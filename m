Return-Path: <linux-kselftest+bounces-6304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF5687B169
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 20:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69D228D863
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932E51C49;
	Wed, 13 Mar 2024 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E5wlIJPg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OWM/gfJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAA4AEEA;
	Wed, 13 Mar 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355493; cv=fail; b=OxIc5KjVtWnu9HZquKhOJXEGHVDvHIkXa6nFQ+Z9Tf9lFD2ioiyvY9yzGl2HW7A9lJPfz3Y3y4RqCu4voNdXdgQvs7job3Ovtu4fOiI0QiYPRlGwNw5anckjK0Bza2xdwO6j2DVsLRQ+ouXuf1q+JS+e7tIowHANaOwHg9eFkG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355493; c=relaxed/simple;
	bh=BX/TJugfC35bYYwCgYLLGV82QNg01I5mh+BeJU28Um0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MTGNF/YHSngUlyghbX1iVbN1geJZL5QpEDgSDztzO4+lDM0Yn+eFThB7cJoe/7WrImBaHj1Es8Nr2E6Kf+HyO/jHe54Aqa4Pitz9J6yTN9HgoiRyZBSsXUQn1pz750Hff4ZuOCHApwIwgXYGvhaG0zjX3smo6dLtji9YHddVWh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E5wlIJPg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OWM/gfJ7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DHxZH5004102;
	Wed, 13 Mar 2024 18:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=I4y977zb2gvtgJVRQI1fbOD6Bydf3JvPVFenn9uohBU=;
 b=E5wlIJPgTBNX1VfTVBWCn+5GDuddGOaISqWxbeMqJG3zYyedQ1ZTuOoR2uh3ZAMy6KTq
 XFsNh96SfbIFK7uzglMk9OdMXtOnL8PaBQRQA67dCaZ9t8PKxub1erGIyV8SurNVXic7
 I9u4Ojai4rWytLIUiojOKzGUY/EdslRXJ0NTSL8mNJjzuVR8MAdII6xKPzwhCLw7oOPS
 wNr85Z6guZ7cc3IG5/X3D7nhMmOJ62kIeBS1C/elAnUoOTTLvHRpkvpW3fvFbBIVbe8X
 XBtchiYcbVvSET8lu6TgnrrntqtuBKAVBaaaiXVcucxuIfLYjHUgNvab4hAQ3q7PaCRd tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbsgqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 18:44:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DHR9rl019682;
	Wed, 13 Mar 2024 18:44:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre798qdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 18:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkhLSD7UdRS0kd5ZnDqfHev0G/bnJz+4kT7lS8LkQwvlV+NqI2Yiff2s5bpzpGQE+nX9EbSMRj95CdyE0kqZGOaj4QnU4OFVowiaxjYfKplLhclaCd/ZvEB5H1dMpIqYFJdLpImn0u0K34zWP7/eW+COIwWQe8e7QQ7OJMPZ8u5CBO296+syhVw0rhCXjcOEDYIZr00FVHWwT1f3YEOXN4e351C0TBssssxhI8EbTLNDVQBbFHxYbe3WC2Cxf2KZRjSAb8PuqOxv6YRBF28lfLxABjRz9psBRC+8tBBe0NJpSkKO/AfJQsb8UtPDYHly6RLwp6WoMX0zA9h7BIYB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4y977zb2gvtgJVRQI1fbOD6Bydf3JvPVFenn9uohBU=;
 b=AD7p+wShV60M0fBQb7S0vUUAfDFAzH+akBDKEfsHy0SGk6WYiKSKy/NN5U1em+TV/Jgjy5A8XCam/AbaOnPTYMRI0SUEM/JYXCd4hpE9QxmqThs+gmDY30dG7jlE0wfxQV+qhbEJyj1URtRM9JzS7vr6+0hJ9QvjPqs8ly/GXD7Rz+BoRtUBxbej+RtvHY4UdAV2ZHzFDXe/71Xd3QHhiBjikM/QJl+nj7C9x7Ap0y5FMv5h5z61ExVevhEWUoI1m31cvZTFCdNod4lH42aS3pEM8Ngf8J2ZEVfso7KuzeBE5+iecZpy21DIx3h2p22OzjSTj9Y26+E9tmWOIlt3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4y977zb2gvtgJVRQI1fbOD6Bydf3JvPVFenn9uohBU=;
 b=OWM/gfJ7hnC6TkykzdAJgD7MBrLsgNp9xhDH4QLE6PZyTgNDrPQVIcByD9469+2TsG1iK0QAz05M0ztaYJdnm3Ts0M6UszNRBEG2XAbf4SAIJGCTxgTdiivSO2ikC/FZPrT/5T9C3mf8bBwQoVsdRhPguCgs1FrEA9FUXsb16eo=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 18:44:13 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 18:44:13 +0000
Message-ID: <5e79d13a-fdc3-6c37-a4f4-54ad633f1d6e@oracle.com>
Date: Wed, 13 Mar 2024 14:44:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] selftests/sched: Migrate cs_prctl_test to
 kselfttest
Content-Language: en-US
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: Suleiman Souhlal <suleiman@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        David Vernet <void@manifault.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        joseph.salisbury@canonical.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
        linux-kselftest@vger.kernel.org
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-9-joel@joelfernandes.org>
From: Chris Hyser <chris.hyser@oracle.com>
In-Reply-To: <20240313012451.1693807-9-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0296.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::31) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a83428-8abd-44a9-fd75-08dc438d943b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SKpG6kUuSZvgUCIOPN17LrYHCTyKoDjlYsJemHbM8a+xz2wQKzMuG48KV6tUqmcwHtipTkB0Fi6eAHPcfrq+BPtL4sX4LumXBpSKvPfS6JqEvsHebHLZQDhPscxPhlgNOQcTYwdUxWTKHcB0nu4C82HvI2thWA8rx2GTBoMf0oghYHcbQf7By78UUgt+Ij4SqPNDcNyiBii+lfLeXnKU/+p+cX+H1ekF7CLQT8A2ZEL1TT0rYWoP8Bb35demeCX9oSvGr5TjmNTWJXUBQZoyCxTLgZ/ekQAsV9OWsNAu7R9kYE+3eFJjG8ndlo7OL1bOvJPaoQ8BXUwOU/kysUgHXiAhrsavRXVjZRwwGUHM4DCPwAKKQaClH6yDtCf8cSJEMygIlWYmUsYwE9uJgtxXS4PkeZUy7XvWVE0lVG/7d2GwF55b0re/WFoWXJbkYXn7cPZRY2yfm0sipFLD6R3qWnBb9I4kCY9QNFBjwjdVS0RnBvrRkMZkQCcHoEiV0uvFDi2I//l9OcdcN6uzPrkdahN3DpWoCpqhnGXko5BISLknU+fiQNmcEwMqQIGgXurW8AhoS3SL/Sx3BZvEseLX9RL0oq8Q1+VtSnMuZ6msz8/ttFm/vOBDE4RxaYBLi+2inSTjdife6nZciuOTZIgq9/qVUF3hso5gNlPR7YKKc6E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VU8rQ2s0clRWb29OWXVxZGExWWlCK2RjcXlET3dENnZCU2F3OTZIaEg1Zmdq?=
 =?utf-8?B?c1BvcWcxb2FrdWtPdFZ3NE9Ldjg5ZEpsZk1kbTcxSC9YQU92WFJHTnYyTDZ1?=
 =?utf-8?B?TXI5cWFhcG5YMTM3Q0R2S0IwUG15bWFzZXJVdldteVNmYVE0RWx0YytDN2xE?=
 =?utf-8?B?YzhwdTE0bDBWc2VDVGI3RWhOMTVwbEUxRjExb0Q3bjBPYndLckxxSGVLcncr?=
 =?utf-8?B?K3d1MVl0YSsxcVlSc2FoQWxlMnUveEw5anAvd0FicW9LTCtSeFBJYTBUNkRT?=
 =?utf-8?B?QVE0STF0ZXdnOUVCOU5JaGdObkk4QTN3Q29qQkNmSCtjQkhNbG5lY3RBR2Fs?=
 =?utf-8?B?bkFjb3NMbTBZTS9jYVplQnNGWFFHMVhGVmNKTXV1N3lVNk5sYUpMT2JQZ1Fw?=
 =?utf-8?B?Zkw3QmkwS04zTlFiOCs4aTBObm1ZSlEzSkNVNUs2ek5lU0N1Mm12NkdCUDd0?=
 =?utf-8?B?cXdsNk5EZGtkLzdFTmxYTU1nNXV3Tk1lclVJdkhHNUcrVzdMRzd4VlhtWVd4?=
 =?utf-8?B?R3QvekFkQjNxaS8yQk1ZYzk4eHFYZWFwMjNsOUlIOTU3NytlOUNuNVFNdGl4?=
 =?utf-8?B?MHRuV1BKbDA5Wk1CSlpHaTBqYzh2WWEyTzFleWdIRjhEclMwZkliZHNmczBS?=
 =?utf-8?B?dGcwOCsvRjVRTzMvT05xQTNZYkNrNFJPSGxveXZZYUZock5hMkp5RCtLSTZk?=
 =?utf-8?B?TGw3NERNZUppd3BDUGtWT09XUG9mYWlQUTdiUEFsbDZhQWM4cVFBV1RYNGM2?=
 =?utf-8?B?amwrU3ZnWDFUVDVUb0t2cno1M01OY2s4eE5JdWtCMm5OQXJNMy9wSlA3MDNz?=
 =?utf-8?B?cWFBMW82V2FXd3BQMUU3QmtPVU1NR1FSSGptQnlrRDRGbGVtOHBuQWlKYmZ3?=
 =?utf-8?B?MkJwOFVjRWRTOE5xd0VLRGRZK1hUUVhXUFFlNVdEZHVtZzJOdmI4blFkT1VI?=
 =?utf-8?B?cGR4L1cxVXY2aU4rek16TVV4VUFOQ1cwNnRkZkVjZjhhcDZOTEZ4cFU4bUVG?=
 =?utf-8?B?QWh5U04vU1dwaDY3ajlQU2pmeDhKMnNaelpRaHRlUm5GNVZKQjhoS0N4Yzly?=
 =?utf-8?B?U3RHMElJdFEvbGxUQ0ZQOHY1NmY4M0MvaDA0Vzd6cEp0RjQwRUp0SGZISDJw?=
 =?utf-8?B?Q3g1emdtOHN3SGhMbEc1M2JMd0tGMnlRMmQzV3RoY2dqL3Y2QTNNcUZOUUFu?=
 =?utf-8?B?bGwzb25nYjV1S3IzMjBjYXBZb1FSRVRpUy8yRlNsSVhFZHNiNExrb01WZThx?=
 =?utf-8?B?V0pLT1dLWFkyM25vR0d2bDZPQmtabmdNbGdUeVZjREpGSi9pZ2FvVmFCbE5k?=
 =?utf-8?B?WVJNajM1ZzFnQ0phQ0xlVHh1YnJkUGwwalJkcUlYdFR4RXpLdU90TE5GQnhP?=
 =?utf-8?B?N1hzQlY5ZnJlamxJWmNLWHU2RWtqQkYwNXp0TVZabHdNdFlQTS9pTGlVNkdw?=
 =?utf-8?B?UlNTTzV2OS9hcW1VdGc4b0ZudU1WQ1VqZFZjd3FVejZWRVFyTE4rbHRIVlg1?=
 =?utf-8?B?bDlxa0V0aG5vaFMzZk5hMFkvSzdJYnozaCt5clVnZXhlMUNMNTR5S2Z1ZE16?=
 =?utf-8?B?bWFyN0VxdHFlaFJHT2wzTWxaNlR5SXdBajI1WVRnOXMrbXRaMEV3Tkt1TjBz?=
 =?utf-8?B?YVlUclVhcE1LUHdTUlJlMmZoSUUvT01FTU00VlgzdzE5cGU3M2pIUTRVbC80?=
 =?utf-8?B?RXAxSHhoVmx0R3NFK1VWcStMQ3JoaEl1UmNmZlRSL0x4bG9OakhuNmxRc0Fy?=
 =?utf-8?B?b3pEeVdMd2ZxSHdLV1l6R205Y0c3bmpubVVmYjd5VnZlTHdoblp3L3E3bW40?=
 =?utf-8?B?ODRoUytSd0NFNXhUa2FuMTJWUjFMNGE0TDVEZHFuU1NLSXBTb2dQbFJCaVJI?=
 =?utf-8?B?ZGswWW8rd0Y5MDFYTXFyQXpoaEdBNWJvYndnUGwzbTBsZ2pPYXZ1TTdhUlh2?=
 =?utf-8?B?M0srNlppZlhZbldvWThhdDVmMlhJbkhxbE5Mb3B6TVJGWG1mZ1RPSjVEQ3lC?=
 =?utf-8?B?YVE4QnIxd2pmVTB4UVdwOThka010N1BrWXFzNVl2RXZRbUprSE1BVXg0NTBq?=
 =?utf-8?B?ckpiZnEzMDYrUHBCMlVhVC9CcmRoYkg0bndNblRTZnZsS1dzaVdQVll1VzVm?=
 =?utf-8?B?b1I2aG1ENXIyWDVlcWlxVzRWUjk3WVNiTXVaRm9uNFpVdWpNTFYwNURCS1FT?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7oZLMAGGkfC1dF8nzP72fOq3uQmaIcMiu0vv2/6pVgagrW34GIbLWW2GwQx4t4q2Pf0IQCvbX5C7K3putz9Rtsmtsa3mbdmgI/qC/SIw/emqAXXi9+Blqx4fAMH9n7fb+ftDxMWrJgm9+klAgwRcNsscF067Ccf1CQDmCYgQ8b5nKqXIealiKvIQFoQ7yRXUV6HdNOdT2EuryQ95Y0DL7vC7LzCQXEk6Dz7dlrv6U3fQPwUiCGaXNH4Ajz7dAP0EwkviiZK2YzgcgFpP1CfpVwFe8m0v1f421kgTbxhhfho0L9TRpIUqtBSkd594VZdqedKrKGf4HLr7y8iqeqku309ack9P1B0BtUhoY8bUZwbwCQgkmpC7p5Ntk5bmB3CKcih2s+j73Ak/iTnRpi/TNJZmNDy4SSSGr2ZvrikIJI/4aUuXRPXNgP7snaYN2qkfYd55o1o6qufjdBideB98P32dzRpJeE0eInIH05XonRU9WFlyw6YZURQK2T0jZ9eNTWuZHbzIreA3HbfIqR+iLeid5yoz9/L04LceX0MfPnuQXRHJf4zWfIUF/2S5ATlAB2kz1C8kL/AxNsOpLVsoxCf/aooGMYeHCkGpzSxUIfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a83428-8abd-44a9-fd75-08dc438d943b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 18:44:13.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQVzkVExbUimF0DmCdpBjPji2xVRZJu8RkZKwwYK+KcU59TWYISw5Od/ykrJl+6lOgOEwq+gw19vQO3TlfzQSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130143
X-Proofpoint-GUID: LljdYxOxXcZVo_gQPXE4OuCFy1woaxyF
X-Proofpoint-ORIG-GUID: LljdYxOxXcZVo_gQPXE4OuCFy1woaxyF


On 3/12/24 21:24, Joel Fernandes (Google) wrote:
> This test begs to be a kselftest, is in the kselftest hierarchy and does
> not even use a single kselftest API. Convert it.
>
> It simplifies some of the code and the output also looks much nicer now:
>
>   Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Chris Hyser <chris.hyser@oracle.com>


> ---
>   tools/testing/selftests/sched/Makefile        |  6 +-
>   tools/testing/selftests/sched/cs_prctl_test.c | 74 ++++++++++---------
>   2 files changed, 43 insertions(+), 37 deletions(-)
>
> diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
> index f491d741cb45..90c53bc1337e 100644
> --- a/tools/testing/selftests/sched/Makefile
> +++ b/tools/testing/selftests/sched/Makefile
> @@ -1,9 +1,11 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   TEST_GEN_PROGS := cs_dlserver_test
> -
> -cs_dlserver_test: cs_dlserver_test.c common.c
> +TEST_GEN_PROGS += cs_prctl_test
>   
>   CFLAGS += $(KHDR_INCLUDES)
>   CFLAGS += -Wall
>   
>   include ../lib.mk
> +
> +$(OUTPUT)/cs_dlserver_test: cs_dlserver_test.c common.c
> +$(OUTPUT)/cs_prctl_test: cs_prctl_test.c common.c
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 7ba057154343..bb7aee703cdf 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -28,10 +28,11 @@
>   #include <unistd.h>
>   #include <time.h>
>   #include <errno.h>
> -#include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
>   
> +#include "common.h"
> +
>   #if __GLIBC_PREREQ(2, 30) == 0
>   #include <sys/syscall.h>
>   static pid_t gettid(void)
> @@ -80,7 +81,7 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
>   	int res;
>   
>   	res = prctl(option, arg2, arg3, arg4, arg5);
> -	printf("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
> +	ksft_print_msg("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
>   	       (long)arg4, arg5);
>   	return res;
>   }
> @@ -91,21 +92,20 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
>   static void __handle_error(char *fn, int ln, char *msg)
>   {
>   	int pidx;
> -	printf("(%s:%d) - ", fn, ln);
> +	ksft_print_msg("(%s:%d) - ", fn, ln);
>   	perror(msg);
>   	if (need_cleanup) {
>   		for (pidx = 0; pidx < num_processes; ++pidx)
>   			kill(procs[pidx].cpid, 15);
>   		need_cleanup = 0;
>   	}
> -	exit(EXIT_FAILURE);
> +	ksft_exit_fail();
>   }
>   
>   static void handle_usage(int rc, char *msg)
>   {
> -	puts(USAGE);
> -	puts(msg);
> -	putchar('\n');
> +	ksft_print_msg("%s\n", USAGE);
> +	ksft_print_msg("%s\n\n", msg);
>   	exit(rc);
>   }
>   
> @@ -117,7 +117,7 @@ static unsigned long get_cs_cookie(int pid)
>   	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
>   		    (unsigned long)&cookie);
>   	if (ret) {
> -		printf("Not a core sched system\n");
> +		ksft_print_msg("Not a core sched system\n");
>   		return -1UL;
>   	}
>   
> @@ -160,7 +160,7 @@ static int child_func_process(void *arg)
>   
>   	ret = write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
>   	if (ret == -1)
> -		printf("write failed on pfd[%d] - error (%s)\n",
> +		ksft_print_msg("write failed on pfd[%d] - error (%s)\n",
>   			ca->pfd[1], strerror(errno));
>   
>   	close(ca->pfd[1]);
> @@ -192,7 +192,7 @@ void create_processes(int num_processes, int num_threads, struct child_args proc
>   	for (i = 0; i < num_processes; ++i) {
>   		ret = read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
>   		if (ret == -1)
> -			printf("read failed on proc[%d].pfd[0] error (%s)\n",
> +			ksft_print_msg("read failed on proc[%d].pfd[0] error (%s)\n",
>   				i, strerror(errno));
>   		close(proc[i].pfd[0]);
>   	}
> @@ -202,30 +202,29 @@ void disp_processes(int num_processes, struct child_args proc[])
>   {
>   	int i, j;
>   
> -	printf("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
> +	ksft_print_msg("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
>   	       get_cs_cookie(getpid()));
>   
>   	for (i = 0; i < num_processes; ++i) {
> -		printf("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
> +		ksft_print_msg("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
>   		       getpgid(proc[i].cpid), get_cs_cookie(proc[i].cpid));
>   		for (j = 0; j < proc[i].num_threads; ++j) {
> -			printf("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
> +			ksft_print_msg("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
>   			       proc[i].cpid, getpgid(0), get_cs_cookie(proc[i].thr_tids[j]));
>   		}
>   	}
>   	puts("\n");
>   }
>   
> -static int errors;
> -
>   #define validate(v) _validate(__LINE__, v, #v)
>   void _validate(int line, int val, char *msg)
>   {
>   	if (!val) {
> -		++errors;
> -		printf("(%d) FAILED: %s\n", line, msg);
> +		ksft_print_msg("(%d) FAILED: %s\n", line, msg);
> +		ksft_inc_fail_cnt();
>   	} else {
> -		printf("(%d) PASSED: %s\n", line, msg);
> +		ksft_print_msg("(%d) PASSED: %s\n", line, msg);
> +		ksft_inc_pass_cnt();
>   	}
>   }
>   
> @@ -254,13 +253,17 @@ int main(int argc, char *argv[])
>   			keypress = 1;
>   			break;
>   		case 'h':
> -			printf(USAGE);
> +			ksft_print_msg(USAGE);
>   			exit(EXIT_SUCCESS);
>   		default:
>   			handle_usage(20, "unknown option");
>   		}
>   	}
>   
> +	if (!hyperthreading_enabled()) {
> +		ksft_exit_skip("This test requires hyperthreading to be enabled\n");
> +	}
> +
>   	if (num_processes < 1 || num_processes > MAX_PROCESSES)
>   		handle_usage(1, "Bad processes value");
>   
> @@ -272,17 +275,22 @@ int main(int argc, char *argv[])
>   
>   	srand(time(NULL));
>   
> -	/* put into separate process group */
> +	/* Put into separate process group */
>   	if (setpgid(0, 0) != 0)
>   		handle_error("process group");
>   
> -	printf("\n## Create a thread/process/process group hiearchy\n");
> +	ksft_print_header();
> +
> +	/* Increase the count if adding more validate() statements. */
> +	ksft_set_plan(17);
> +
> +	ksft_print_msg("\n## Create a thread/process/process group hiearchy\n");
>   	create_processes(num_processes, num_threads, procs);
>   	need_cleanup = 1;
>   	disp_processes(num_processes, procs);
>   	validate(get_cs_cookie(0) == 0);
>   
> -	printf("\n## Set a cookie on entire process group\n");
> +	ksft_print_msg("\n## Set a cookie on entire process group\n");
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 0, PIDTYPE_PGID, 0) < 0)
>   		handle_error("core_sched create failed -- PGID");
>   	disp_processes(num_processes, procs);
> @@ -296,7 +304,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(0) == get_cs_cookie(pid));
>   	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
> +	ksft_print_msg("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, PIDTYPE_TGID, 0) < 0)
>   		handle_error("core_sched create failed -- TGID");
>   	disp_processes(num_processes, procs);
> @@ -305,7 +313,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(pid) != 0);
>   	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
> +	ksft_print_msg("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
>   	       getpid(), pid);
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, pid, PIDTYPE_PID, 0) < 0)
>   		handle_error("core_sched share to itself failed -- PID");
> @@ -315,7 +323,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(pid) != 0);
>   	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
> +	ksft_print_msg("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
>   	       procs[pidx].thr_tids[0], getpid());
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, procs[pidx].thr_tids[0],
>   		   PIDTYPE_PID, 0) < 0)
> @@ -325,7 +333,7 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
>   	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> -	printf("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
> +	ksft_print_msg("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
>   	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 0) < 0)
>   		handle_error("core_sched share to self failed -- PGID");
>   	disp_processes(num_processes, procs);
> @@ -340,20 +348,16 @@ int main(int argc, char *argv[])
>   	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 1) < 0
>   		&& errno == EINVAL);
>   
> -	if (errors) {
> -		printf("TESTS FAILED. errors: %d\n", errors);
> -		res = 10;
> -	} else {
> -		printf("SUCCESS !!!\n");
> -	}
> -
> -	if (keypress)
> +	if (keypress) {
> +		ksft_print_msg("Waiting for keypress to exit\n");
>   		getchar();
> -	else
> +	} else {
>   		sleep(delay);
> +	}
>   
>   	for (pidx = 0; pidx < num_processes; ++pidx)
>   		kill(procs[pidx].cpid, 15);
>   
> +	ksft_finished();
>   	return res;
>   }

