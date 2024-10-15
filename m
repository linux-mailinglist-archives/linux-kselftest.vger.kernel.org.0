Return-Path: <linux-kselftest+bounces-19783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8597C99F913
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B1BB220AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D532E1FBF57;
	Tue, 15 Oct 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XjTV1Kt7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HTXYr8v5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09111F80BC;
	Tue, 15 Oct 2024 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027726; cv=fail; b=lgvERDDq+83Bs8kHm0SM8LiBr09cLjgwqFPwtWNuZJjW4//zmkccmN7Qa0z/Wck0Ur59DCb2XrMZrgVQSKYBZ+M3co8dyxWmXFJjQab1AvfXTMRnRR44JrrBvUTimIt6hV6SjIrpqtSKakaBHrknA/n99hsVtx0LZvdUEhoHYTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027726; c=relaxed/simple;
	bh=tP+r901bcnQzRhn5rNmA19cIgxdJed7xfSwPD26Ts2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ls0NmyXcH9d6ZXhVh3hbeukkUDCxVhADHpJXo7s9X0bXTMJEjInc03UblVBajyDl2NYj9DnURGU6k3gPnE3BedLAILlE+MDE7r0DxLhLzayvPSUMTsYUW1Q9ounkV0/4O8rN3vL6NYVyhacRHiX6CkB8fWrMZ+FvHfONr3yV1kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XjTV1Kt7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HTXYr8v5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHtg0V008322;
	Tue, 15 Oct 2024 21:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tP+r901bcnQzRhn5rNmA19cIgxdJed7xfSwPD26Ts2Y=; b=
	XjTV1Kt78qJsknQq2qayQ5el2olowqdNkNKICPXn/7WE4GmZAPVVLxtr1QSzAiyN
	LFDHoJNvJNPIwsNxnstueGz4oRGHoEa2+PMYdkOfFQ3wYtELmQphdDM3T4rra5kV
	pTpfgs6ld0PM/qCEXFtzeIaxsEQ3pgvvAxbfxL+PzklgvqU/+LCXi1KKQaT8rq9P
	4uJl9jbQSeLnGHLjRdI+Wnf4BsUa2Ur8x13+4mLNNwv2sjCPbYX80WVxlEJaxTWt
	ugr1636n39Ncx+VXOVzdKLJfkPcbC7W2w7Yuz7DGdUIxSEOOArS92VzXbsNVEkGk
	BO3/iApgs5CA/o1iREma5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntab5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 21:28:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKbnRU010367;
	Tue, 15 Oct 2024 21:28:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjeb1hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 21:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyJsuM0LhzyWx9IxUErQ0a2tJnVdHioPbviQhqN4sJsw7EiGB4W81AEKxCe3Gt/CRXlyJXUpKSOdgMQKV5O/paRFTD6xViFDV5661LWlgNqFZW0N7zutIZf3HLOKHtj6uyzds4UkBSkOPnT8zIto5rw89D9PSAnYhNbEcjpE3eQ2OOXnWtn15i9gletrvzBkPsFbkIOZPfPzaDiTtLGSQ0mXTm6GptbucVP6DjLTkNvrkLBTveBnjYwsiFln/WIWvgBU7mu1G6SmFzlt2OjzYoKmbNdIqLKLKmQsmcrQayvhUjcFIfsC6o3dcqtWaTyYK2cS3198wMFpA006wcoojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP+r901bcnQzRhn5rNmA19cIgxdJed7xfSwPD26Ts2Y=;
 b=fcjqF6DlvQSkxZTFKAEdsYj9gOacFiSlDkSjT657x7lUB+G8D+tQozkYFFEBUK75QgeIgAdbEnh58m6+pXBbzE/4XaNzHDOko6KGRVwf9Ux6imz1Byd6RSoYh4YU7UWLkQGezKau5rtP/hySSGlrygv7neONiYqVZ6fGX+PsUvU/UlULBcitCWICaNgFEsLNEtbyd7jF3lzSxLMZCHxqfujCjw2Rqr91jIxc7hCPJ2fVEJwJiCBh2d4J7uR8kU4o1DsTTeqrZIZXln7o57RUJj3nIOe8CX9H6WKYLpFndMSWTvmA5W3NbeMzqBx4WjSF3jsmxoTxpdmUvgXo+oegJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP+r901bcnQzRhn5rNmA19cIgxdJed7xfSwPD26Ts2Y=;
 b=HTXYr8v50+6WX9j2mxoSZU85lMeLqCatTj9hPmiKxs9+OgGDNuRAdWlILKEsM4Ot958TKOWHoYcILXqITRuXEV/CJKCuib3qMwA3DFzt8eG5XxG3IswRCx3dBNvCGsi0RzG/U30levg66aHWUuEU2NKGVXBxD476KMXmhxF7l44=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ0PR10MB4639.namprd10.prod.outlook.com (2603:10b6:a03:2db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Tue, 15 Oct
 2024 21:28:18 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 21:28:18 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Liam Howlett <liam.howlett@oracle.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Pei Li
	<peili.io@oracle.com>
Subject: Re: [PATCH net-next v2 3/3] connector/cn_proc: Selftest for threads
Thread-Topic: [PATCH net-next v2 3/3] connector/cn_proc: Selftest for threads
Thread-Index: AQHbHyfyb3isQmfQUE+MZ3/MYmXKmrKIMjKAgAAhvQA=
Date: Tue, 15 Oct 2024 21:28:17 +0000
Message-ID: <B4DCFCF8-BD05-4379-BCAE-DD507D894032@oracle.com>
References: <20241015173014.1083069-1-anjali.k.kulkarni@oracle.com>
 <20241015173014.1083069-4-anjali.k.kulkarni@oracle.com>
 <36kdqgl425qzoqqbct4jusrzgpcn4cff62jaswcsrc4licalvp@f3okz2ygoww6>
In-Reply-To: <36kdqgl425qzoqqbct4jusrzgpcn4cff62jaswcsrc4licalvp@f3okz2ygoww6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ0PR10MB4639:EE_
x-ms-office365-filtering-correlation-id: c3dafb72-9ecb-492a-bb6b-08dced604926
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aE5vVi9UYlcwWnZxTHRmNjFwQW9HVUtiRmhMelVOTW5HVjB6TVhTbkZJR29G?=
 =?utf-8?B?NXV2UEwwd1NGVkdyWlJLVkN1Vi9QZXlsUUtGVklRL3dnb2x2dE15Q0xTaERD?=
 =?utf-8?B?ZmxuVzRpQ0dsdjkvVHVrY3lpT09sUldRY1VyelBiWlVSRVo0alBrSkRtV2V4?=
 =?utf-8?B?Ni9Qc1ZIZEF5VGFna2h5VFpBOXlpbmxucHh0bkhBMW5IQUlvOEFuL1FJRnlZ?=
 =?utf-8?B?VkpLcFdGeWhpU0N6TlJITTlnQjIzV2o3WGtFcDc3d0Vlb2IyanFkR3ZlMlF1?=
 =?utf-8?B?cmpxY3NYMk1rZEkxcmVzSWVoM0FEb2lvL3FLOWlFNkJNa2t6ZDMyR0ZFNWJw?=
 =?utf-8?B?Q3ROeUpqRG9SamNZWW9IUzhzU0p6Vi9aL3BORlppem8yYTRqZFlZRFVBZjMr?=
 =?utf-8?B?bDZqSWlHS3lBR3dSRkZxZjFEY3duVFZ2OU44TTJwN0xoR0FJR2ozRHJ3OW5x?=
 =?utf-8?B?b0RNMXNLemR2eURTQ2dxRmZOMmhtQW1VVG1sM1dpMlpzVkdEZFlQMk1kL0FE?=
 =?utf-8?B?b0ZtTXpMcUxQT1k4VWRnd0JzeWhkREFycDIvcXZoM0xUNFZ2NG55T2V3ZzBI?=
 =?utf-8?B?eW11M2lFNkVheGt4MzVjSG9jN3dzR0ZlYm9wL2RwUXZGbWppQURwU0p1L1RI?=
 =?utf-8?B?WEE2SlFkM2lBenlZRXRvRFlYU2NReUMyK1RtbE4raWxFaVpnRXZnempLNGs3?=
 =?utf-8?B?aGd5SCtNQnBPNUVuWjB2RVNzVUdSVjE1bDhYM2hudysxRXdEN1Q5QzBQRTZr?=
 =?utf-8?B?YjVWYlhVbnZHOW5EeTAwRWhoQ1V5TlVmWExCRW8wOEExeEh1Z05KY2oxUGth?=
 =?utf-8?B?b1ZjdFZvYjZMR2dUWGNTVnl6S3BHUDlOc0dQUUE4TTlNU3Z6UTNTbHRKWW1l?=
 =?utf-8?B?cFlrblJHSlg5VTNoYWZRYXU5RXJadmkwYk5Fb1ZxbGY2MjFUdzUrbXBpZFVV?=
 =?utf-8?B?a1JqUmJrTmNEemNML3dVRDZLbWhuL2t4dEJSa0NtOE1iQ3Zyc1p4V3M0QUNU?=
 =?utf-8?B?cDVYcEVyTEtZTnZsSUtyaE1IY2JDSERXOUE0VndDdlNwUFBUQWExWmd3STBh?=
 =?utf-8?B?N3U4T2NZU1pVak9IYmI4SWY5d3pJaEdoWHp2alVuRFRlYmVsTzNMT0xDTFhw?=
 =?utf-8?B?OVlJWUZDdXl1ZklFZVlkeFlSbE5EQWxOVEZrWi9URFkwNlRzZmRoUCttaENE?=
 =?utf-8?B?TWxmMUV5dUR3Z2VlaEVEemVoaDJ2cFNBLzc1aG9RL01xSlU5WS9WWHByYnBu?=
 =?utf-8?B?N1NTOHdoR2tVUldDM2JYaElaS0NQWTN4dkV0TUs0OGlNdkZxZjJpaGVYbjlk?=
 =?utf-8?B?d05pK2laak15UGhJdVYyWVB2RWRqQVJvN3Rxb1AxY3JZcDJQMmxYZXVzNXZa?=
 =?utf-8?B?cGk3aHdSVHUxTTUvQkdvNll0Z21LZmNVcnB4RmFjZmZyNUpGQ25qVmdkSmp2?=
 =?utf-8?B?Ly9WVW1ZQ1l2bVl6cGFJQThrUGZHeUUvN3c2UXRwNzFKQlB6MmVWbDczaDd0?=
 =?utf-8?B?NkxpRWJ3SjNsYmY4N2FBSnNhLzN2d1VodjJiK2liWnRCbHNYNSs1eVRaVVAr?=
 =?utf-8?B?NVFKWjBGS1NmTFNROWdhTG9mTHlCNWNCUmFFMGl5REtjejdqS2RmdEJrbjZh?=
 =?utf-8?B?QmJWSUduUlp6KzV0aTdPVGNjc0NXWGEzWGNWdS9ScHhhaHU2NURmdk1nYndS?=
 =?utf-8?B?VHNRNWpadDNkSW1QOHBHS0paMTdYQWpNbEtpKytOb00rMTRwK0g1SlpXTEQr?=
 =?utf-8?B?WHNNY3lTZmZaemxJM1F2dUVQUXp3a0pCNm93Z0QyWFc2R3BtQzdGaVNreklp?=
 =?utf-8?B?R0szUC9Ga0RtOTZTbS82Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVB4cnlnRmRxMFNMQUczT2VXRHkzdXBlTUJSdmxSMlh4elZOM0RLbGw4MmFi?=
 =?utf-8?B?OUNZUXBGc1oydTViY2FuL2hOSVF2TE8vUXVvTlZjemYyQStUVlU2Vk1VbG5S?=
 =?utf-8?B?M2x1b2pTRkh4eWNkaDB4K0VYUmtoOUltdGdnWGh2RzQ1TDFtYVVUcGpydHJ3?=
 =?utf-8?B?U0FvakJJa09HQWVQYVgxRUc3UUxVVzVWUTVsQzNFNHZkQmNPdFBNbGd2RDd4?=
 =?utf-8?B?ZnZFcnZ2a3FVSFZmRldjeTlYNThjRStkbmJWZnVyN3RLUUJzbDdWTDJDaFdV?=
 =?utf-8?B?NVh5N1hBcVR1aDZvbGpqdjUzYWNwS0xBWjBEQ1JKQy9xU0NtR2NJUmhPMDFi?=
 =?utf-8?B?elFDNVl2V3E1S1N4cWxyR3ZzeW5IMjJtN2pndktEY1g2Rm9JVWduTXdjQUUz?=
 =?utf-8?B?emhKR2dqK3UrWTlCa0pYcVJsaHQvc21oN2tQM0hFY1p5VWVYUndiQy9jQ0pV?=
 =?utf-8?B?cE4rUC8wNTBISlBnTDRTUXUvR0VJNEVTL1VOWWpHQlJYR2NiZ0x5UDV0WEdr?=
 =?utf-8?B?ZisvR3hsd1lac2IzZEsxNHBUWVBGLzVYQ1VWeS9PTzZnODdDb2E3bEVSYnFw?=
 =?utf-8?B?Z0pqckZWUWcxMWtkaFk5b3RsVTNmeTFKcUF6ZFg1UWVyMllJSkhBOEdWN1hU?=
 =?utf-8?B?eTM0bERDS0RJc1A1YVdJc3FaMnZ6M1BTT01Xek01UkZoVlpMU20rM2toc2Rm?=
 =?utf-8?B?RWZQOWtZS3lXUTFrZXJpZ0t2RnlnWU0vOWFKREhFQVMrODI0b0tWMjhIM1ZH?=
 =?utf-8?B?NExQUUp5cUFMd3dicjJqclMycDlZQkNkU3V3Nk5FOGlkUGF0WjVjZGNkM0V6?=
 =?utf-8?B?STNhM1BQOU1NbDJBTk1ZQjZOZUg0Y1FwYWlRM0ZERmZnZ0lqOVZJaDIwUTB3?=
 =?utf-8?B?QmV4dDZ0YTFBaG1nN29HaFBhUEZYU2ZHc2hnbnJnVUJhSnlUbDFBSldDellh?=
 =?utf-8?B?ai9pV1VtNjczMGpCOThxaDBobjU2KzJEVFZIcVNNcXdrQk50Wml0b3Uva29y?=
 =?utf-8?B?d3pib0dZbjlaRVBxcHk4VU5CTi9Xc29VR2V2eDArWXQ4N2xEOGtQYVpRMnFQ?=
 =?utf-8?B?WHFDeUgwaTg4ck5HMFBlQXNuek8yOUt6THZoWlRYRzh1MlBUSm8ySDVoNnhv?=
 =?utf-8?B?dFZTemdpemNFOStqR1JqMlR0MlRnZTd6ai8rQ2pXSHZnamlGQmg5WnQxVFM4?=
 =?utf-8?B?TDN4QTU3anpuSDVja0grWi9BWjg2YWdha3RTWXc5T1JKOHNDcXVkeStLWWJm?=
 =?utf-8?B?YTBwNzg3K3BEUDlpSDZxc0dqVE1ZZGdDQjQ3Ui9qS2JmQW5YeWRKYmVnczEv?=
 =?utf-8?B?L2preVU1Z2xUS1VXNlBVcU0rUm92ekRtRVk0ZEpidlJOYnFKNXJub3Q3VUdX?=
 =?utf-8?B?L1ZXZnU3S2VlRGIwWWptN3N4RkdiL0pqZzlkTlZYVzZnRXdXRnljZEcwTEs1?=
 =?utf-8?B?Vkd2T1pwUTdha01NdHo4ZmZoa3NxMi9mQTQ1RDZRTnh3aHZ5YUlkRm5GcjBQ?=
 =?utf-8?B?ZkQzdVVTc3NUWldTTTJzZ0RIMGZiZDZWUjNmTlRYT0JOWnVvcjlCNGM0NHFN?=
 =?utf-8?B?SFpyZW1TMklnWkxjUWphMzVqV1p4dGZ4M21WZHVKdzR2ZXcwRS9RVTByQzBv?=
 =?utf-8?B?NHNrUHlGeTVMN0JpYUV3bmRKUWhmWXg5UjlseGU0N2NOK2VwZTJJOUgrTkxQ?=
 =?utf-8?B?bDZMamNCU0IyNU9ORlM0OFQzb1FDNktDTFhRckJ5UVZ6QzlQV2ZaSTJmM29J?=
 =?utf-8?B?NDV1ODdOV1dmRjV3Y0dtYUZDcmQyNEpCNUs1cytXZlhMSDBKUG1NRVNFNjdW?=
 =?utf-8?B?bWJaTlBDamgxVlY5QWx1Y1VIbFNtY29HQ1BYSzZTdWRzc3Nnbkd5VEdkdWw2?=
 =?utf-8?B?bThUUXVFODdBd3JuK2pIL1Z0b3VBZVdNS3YzTncxUlBVblMzNitiRGhxKzhQ?=
 =?utf-8?B?UG5YWUlSNFc1T29pVHJZSnV3TDZRcUNpZms2ekZFYmFSQ0wyUUN1SmRZdFlD?=
 =?utf-8?B?Um40TWxxMExJcTJ4aFlHblpMUXRNVVFQNXpndmNOK3FUR0w0VTlzemt4SERP?=
 =?utf-8?B?UFhnQm1TTzhyazVwYU1sVFFmeGlzZjlzcWtDN1V4YWxtUjdoSXRJenNEME9Q?=
 =?utf-8?B?V2YrcVg1eVFPUFFxMldtSjdlS3d4MG5XL3VHa1NEWURRRUpWc0lSQS8vYWpr?=
 =?utf-8?Q?wzXPuaHQ21jEt96cK2sY1CF4gAtlGF2b4OoSkOwoBfLu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57F8E4271F126C469D2944C76AC2A395@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vPv8hjjdw2rpSvPjcCCxy+seSszp6prpWNyFI6blHSm86auK4x051Eadu62oFZcJd6cNdAU94FzHF+c9qE6uFGpWSHt+RnnYsV/SyHX+0aS9f5YLQKPONPBR1PUQxmSUDMyG91zdfTEnoFynv7VPoU4tATeJZMJ6WgzQjvqrrEOfDOSzc+nem3aSKwzXGo4qvrZ5iGm/vTBaE5OV/cZgfJBp2IlfY38lRjXwqPpvcDr5IIzyGASTo73rHBj6+m7hmPTlOGZDLFoSIHvpsjze8WV9AGWIKd3Wf9HjVsBBcKO8QbB79xBcPIA0pa3jh9Srj/tZXku/nm/+I1Wthmjels6gGZlmbwvCeW/pqUqA1o2V/uDEq8DCzVnXpLvRfzEGCECvQCzV5Hb91wYF0hKQyxgj1fH+dvqt1E7EB+Zabz/fwMI1XbbQk7d/Z3t5CSyPkUE/aJhB/mdPa4WhDsQLfk1pDXj6eAhzT6UL9U7f1cOifHO92o7yN6JHMzTPR4I9f12OAaviapqE+/iF+EiX0pzTVcjeke0zOe60wQ6W/E9l4hv1dLKWHdrNOgc0pwFXr1Jh6lsx8USL7W8SY6U7VF3eEgo2IxZy61f22ZKWpH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dafb72-9ecb-492a-bb6b-08dced604926
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 21:28:17.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXstl24B6GSSI+cQJROoNXt1isqgnFZ/hdXnc226ItYHJtTXsCOE49cjSuP8hcEoE3DJZ76uxQAJ3Rp1Q6toqzYP60zKGHHm+YSAQyhssEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_16,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150142
X-Proofpoint-ORIG-GUID: UuD3vUioKfLt3Z9udCBadEKQ_-ux0WqX
X-Proofpoint-GUID: UuD3vUioKfLt3Z9udCBadEKQ_-ux0WqX

DQoNCj4gT24gT2N0IDE1LCAyMDI0LCBhdCAxMjoyN+KAr1BNLCBMaWFtIEhvd2xldHQgPGxpYW0u
aG93bGV0dEBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+ICogQW5qYWxpIEt1bGthcm5pIDxhbmph
bGkuay5rdWxrYXJuaUBvcmFjbGUuY29tPiBbMjQxMDE1IDEzOjMwXToNCj4+IFRlc3QgdG8gY2hl
Y2sgaWYgc2V0dGluZyBQUk9DX0NOX01DQVNUX05PVElGWSBpbiBwcm9jIGNvbm5lY3RvciBBUEks
IGFsbG93cw0KPj4gYSB0aHJlYWQncyBub24temVybyBleGl0IHN0YXR1cyB0byBiZSByZXR1cm5l
ZCB0byBwcm9jX2ZpbHRlci4NCj4+IA0KPj4gVGhlIHRocmVhZHMuYyBwcm9ncmFtIGNyZWF0ZXMg
MiBjaGlsZCB0aHJlYWRzLiAxc3QgdGhyZWFkIGhhbmRsZXMgc2lnbmFsDQo+PiBTSUdTRUdWLCBh
bmQgMm5kIHRocmVhZCBuZWVkcyB0byBpbmRpY2F0ZSBzb21lIGVycm9yIGNvbmRpdGlvbiAodmFs
dWUgMSkNCj4+IHRvIHRoZSBrZXJuZWwsIGluc3RlYWQgb2YgdXNpbmcgcHRocmVhZF9leGl0KCkg
d2l0aCAxLg0KPj4gDQo+PiBJbiBib3RoIGNhc2VzLCBjaGlsZCBzZW5kcyBub3RpZnlfbmV0bGlu
a190aHJlYWRfZXhpdChleGl0X2NvZGUpIHRvIGtlcm5lbCwNCj4+IHRvIGxldCBrZXJuZWwga25v
dyBpdCBoYXMgZXhpdGVkIGFibm9ybWFsbHkgd2l0aCBleGl0X2NvZGUuDQo+PiANCj4+IENvbXBp
bGU6DQo+PiAgICBtYWtlIHRocmVhZA0KPj4gICAgbWFrZSBwcm9jX2ZpbHRlcg0KPj4gVG8gc2Vl
IG5vbi16ZXJvIGV4aXQgbm90aWZpY2F0aW9ucywgcnVuOg0KPj4gICAgLi9wcm9jX2ZpbHRlciAt
Zg0KPj4gUnVuIHRocmVhZHMgY29kZSBpbiBhbm90aGVyIHdpbmRvdzoNCj4+ICAgIC4vdGhyZWFk
cw0KPj4gTm90ZSB0aGUgMiBjaGlsZCB0aHJlYWQgSURzIHJlcG9ydGVkIGFib3ZlDQo+PiBTZW5k
IFNJR1NFR1Ygc2lnbmFsIHRvIHRoZSBjaGlsZCBoYW5kbGluZyBTSUdTRUdWOg0KPj4gICAga2ls
bCAtMTEgPGNoaWxkMS10aWQ+DQo+PiBXYXRjaCB0aGUgY2hpbGQgMSB0aWQgYmVpbmcgbm90aWZp
ZWQgd2l0aCBleGl0IGNvZGUgMTEgdG8gcHJvY19maWx0ZXINCj4+IFdhdGNoIGNoaWxkIDIgdGlk
IGJlaW5nIG5vdGlmaWVkIHdpdGggZXhpdCBjb2RlIDEgKHZhbHVlIGRlZmluZWQgaW4gY29kZSkN
Cj4+IHRvIHByb2NfZmlsdGVyDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEFuamFsaSBLdWxrYXJu
aSA8YW5qYWxpLmsua3Vsa2FybmlAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvY29ubmVjdG9yL01ha2VmaWxlICAgIHwgIDIzICsrKy0NCj4+IC4uLi90ZXN0
aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYyB8ICAgNSArDQo+PiB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvdGhyZWFkLmMgICAgfCAxMTYgKysrKysrKysrKysr
KysrKysrDQo+PiAuLi4vc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWRfZmlsdGVyLmMgICAgICAg
fCAgOTYgKysrKysrKysrKysrKysrDQo+PiA0IGZpbGVzIGNoYW5nZWQsIDIzOSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvY29ubmVjdG9yL3RocmVhZC5jDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL3RocmVhZF9maWx0ZXIuYw0KPj4gDQo+PiBkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL01ha2VmaWxlIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL01ha2VmaWxlDQo+PiBpbmRleCA5MjE4OGI5
YmFjNWMuLmJmMzM1ODI2YmMzYiAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2Nvbm5lY3Rvci9NYWtlZmlsZQ0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
Y29ubmVjdG9yL01ha2VmaWxlDQo+PiBAQCAtMSw1ICsxLDI2IEBADQo+PiAjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiAtQ0ZMQUdTICs9IC1XYWxsICQoS0hEUl9JTkNMVURF
UykNCj4+ICtLRVJORUw9Ii4uLy4uLy4uLy4uIg0KPj4gKw0KPj4gK0NGTEFHUyArPSAtV2FsbCAk
KEtIRFJfSU5DTFVERVMpIC1JICQoS0VSTkVMKS9pbmNsdWRlL3VhcGkgLUkgJChLRVJORUwpL2lu
Y2x1ZGUNCj4+ICsNCj4+ICtwcm9jX2ZpbHRlcjogcHJvY19maWx0ZXIubw0KPj4gKyBjYyBwcm9j
X2ZpbHRlci5vIC1vIHByb2NfZmlsdGVyDQo+PiArDQo+PiArcHJvY19maWx0ZXIubzogcHJvY19m
aWx0ZXIuYw0KPj4gKyBjYyAtYyBwcm9jX2ZpbHRlci5jIC1vIHByb2NfZmlsdGVyLm8gJChDRkxB
R1MpDQo+PiArDQo+PiArdGhyZWFkOiB0aHJlYWQubyB0aHJlYWRfZmlsdGVyLm8NCj4+ICsgY2Mg
dGhyZWFkLm8gdGhyZWFkX2ZpbHRlci5vIC1vIHRocmVhZA0KPj4gKw0KPj4gK3RocmVhZC5vOiB0
aHJlYWQuYyAkKERFUFMpDQo+PiArIGNjIC1jIHRocmVhZC5jIC1vIHRocmVhZC5vICQoQ0ZMQUdT
KQ0KPj4gKw0KPj4gK3RocmVhZF9maWx0ZXIubzogdGhyZWFkX2ZpbHRlci5jDQo+PiArIGNjIC1j
IHRocmVhZF9maWx0ZXIuYyAtbyB0aHJlYWRfZmlsdGVyLm8gJChDRkxBR1MpDQo+PiArDQo+PiAr
ZGVmaW5lIEVYVFJBX0NMRUFODQo+PiArIHJtICoubyB0aHJlYWQNCj4+ICtlbmRlZg0KPj4gDQo+
PiBURVNUX0dFTl9QUk9HUyA9IHByb2NfZmlsdGVyDQo+PiANCj4+IGRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jDQo+PiBpbmRleCA0YTgyNWI5OTc2
NjYuLjZmYjQ4NDI4OTRmOCAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9jb25uZWN0b3IvcHJvY19maWx0ZXIuYw0KPj4gQEAgLTEsNCArMSw5IEBADQo+PiAvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+PiArLyoNCj4+ICsgKiBBdXRob3I6
IEFuamFsaSBLdWxrYXJuaSA8YW5qYWxpLmsua3Vsa2FybmlAb3JhY2xlLmNvbT4NCj4+ICsgKg0K
Pj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBPcmFjbGUgYW5kL29yIGl0cyBhZmZpbGlhdGVzLg0K
Pj4gKyAqLw0KPj4gDQo+PiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+DQo+PiAjaW5jbHVkZSA8c3lz
L2Vwb2xsLmg+DQo+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVj
dG9yL3RocmVhZC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL3RocmVhZC5j
DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi44YzlhYmY2
MTE1ZDYNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvci90aHJlYWQuYw0KPj4gQEAgLTAsMCArMSwxMTYgQEANCj4+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+PiArLyoNCj4+ICsgKiBBdXRob3I6IEFu
amFsaSBLdWxrYXJuaSA8YW5qYWxpLmsua3Vsa2FybmlAb3JhY2xlLmNvbT4NCj4+ICsgKg0KPj4g
KyAqIENvcHlyaWdodCAoYykgMjAyNCBPcmFjbGUgYW5kL29yIGl0cyBhZmZpbGlhdGVzLg0KPj4g
KyAqLw0KPj4gKw0KPj4gKyNpbmNsdWRlIDxwdGhyZWFkLmg+DQo+PiArI2luY2x1ZGUgPHN0ZGlv
Lmg+DQo+PiArI2luY2x1ZGUgPHVuaXN0ZC5oPg0KPj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4NCj4+
ICsjaW5jbHVkZSA8c2lnbmFsLmg+DQo+PiArDQo+PiArLyoNCj4+ICsgKiBUaGlzIGNvZGUgdGVz
dHMgYSB0aHJlYWQgZXhpdCBub3RpZmljYXRpb24gd2hlbiB0aHJlYWQgZXhpdHMgYWJub3JtYWxs
eS4NCj4+ICsgKiBOb3JtYWxseSwgd2hlbiBhIHRocmVhZCBleGl0cyBhYm5vcm1hbGx5LCB0aGUg
a2VybmVsIGlzIG5vdCBhd2FyZSBvZiB0aGUNCj4+ICsgKiBleGl0IGNvZGUuIFRoaXMgaXMgdXN1
YWxseSBvbmx5IGNvbnZleWVkIGZyb20gY2hpbGQgdG8gcGFyZW50IHZpYSB0aGUNCj4+ICsgKiBw
dGhyZWFkX2V4aXQoKSBhbmQgcHRocmVhZF9qb2luKCkgY2FsbHMuIFNvbWV0aW1lcywgaG93ZXZl
ciwgYSBwYXJlbnQNCj4+ICsgKiBwcm9jZXNzIGNhbm5vdCBtb25pdG9yIGFsbCBjaGlsZCBwcm9j
ZXNzZXMgdmlhIHB0aHJlYWRfam9pbigpLCBwYXJ0aWN1bGFybHkNCj4+ICsgKiB3aGVuIHRoZXJl
IGlzIGEgaHVnZSBhbW91bnQgb2YgY2hpbGQgcHJvY2Vzc2VzLiBJbiB0aGlzIGNhc2UsIHRoZSBw
YXJlbnQNCj4+ICsgKiBoYXMgY3JlYXRlZCB0aGUgY2hpbGQgd2l0aCBQVEhSRUFEX0NSRUFURV9E
RVRBQ0hFRCBhdHRyaWJ1dGUuDQo+PiArICogVG8gZml4IHRoaXMgcHJvYmxlbSwgZWl0aGVyIHdo
ZW4gY2hpbGQgd2FudHMgdG8gY29udmV5IG5vbi16ZXJvIGV4aXQgdmlhDQo+PiArICogcHRocmVh
ZF9leGl0KCkgb3IgaW4gYSBzaWduYWwgaGFuZGxlciwgdGhlIGNoaWxkIGNhbiBub3RpZnkgdGhl
IGtlcm5lbCdzDQo+PiArICogY29ubmVjdG9yIG1vZHVsZSBpdCdzIGV4aXQgc3RhdHVzIHZpYSBh
IG5ldGxpbmsgY2FsbCB3aXRoIG5ldyB0eXBlDQo+PiArICogUFJPQ19DTl9NQ0FTVF9OT1RJRlku
IChJbXBsZW1lbnRlZCBpbiB0aGUgdGhyZWFkX2ZpbHRlci5jIGZpbGUpLg0KPj4gKyAqIFRoaXMg
d2lsbCBzZW5kIHRoZSBleGl0IGNvZGUgZnJvbSB0aGUgY2hpbGQgdG8gdGhlIGtlcm5lbCwgd2hp
Y2ggdGhlIGtlcm5lbA0KPj4gKyAqIGNhbiBsYXRlciByZXR1cm4gdG8gcHJvY19maWx0ZXIgcHJv
Z3JhbSB3aGVuIHRoZSBjaGlsZCBhY3R1YWxseSBleGl0cy4NCj4+ICsgKiBUbyB0ZXN0IHRoaXMg
dXNlY2FzZToNCj4+ICsgKiBDb21waWxlOg0KPj4gKyAqIG1ha2UgdGhyZWFkDQo+PiArICogbWFr
ZSBwcm9jX2ZpbHRlcg0KPj4gKyAqIFRvIHNlZSBub24temVybyBleGl0IG5vdGlmaWNhdGlvbnMs
IHJ1bjoNCj4+ICsgKiAuL3Byb2NfZmlsdGVyIC1mDQo+PiArICogU3RhcnQgdGhlIHRocmVhZHMg
Y29kZSwgY3JlYXRpbmcgMiB0aHJlYWRzLCBpbiBhbm90aGVyIHdpbmRvdzoNCj4+ICsgKiAuL3Ro
cmVhZHMNCj4+ICsgKiBOb3RlIHRoZSAyIGNoaWxkIHRocmVhZCBJRHMgcmVwb3J0ZWQgYWJvdmUN
Cj4+ICsgKiBTZW5kIFNJR1NFR1Ygc2lnbmFsIHRvIHRoZSBjaGlsZCBoYW5kbGluZyBTSUdTRUdW
Og0KPj4gKyAqIGtpbGwgLTExIDxjaGlsZDEtdGlkPg0KPj4gKyAqIFdhdGNoIHRoZSBldmVudCBi
ZWluZyBub3RpZmllZCB3aXRoIGV4aXQgY29kZSAxMSB0byBwcm9jX2ZpbHRlcg0KPj4gKyAqIFdh
dGNoIGNoaWxkIDIgdGlkIGJlaW5nIG5vdGlmaWVkIHdpdGggZXhpdCBjb2RlIDEgKHZhbHVlIGRl
ZmluZWQgaW4gY29kZSkNCj4+ICsgKiB0byBwcm9jX2ZpbHRlcg0KPj4gKyAqLw0KPj4gKw0KPj4g
K2V4dGVybiBpbnQgbm90aWZ5X25ldGxpbmtfdGhyZWFkX2V4aXQodW5zaWduZWQgaW50IGV4aXRf
Y29kZSk7DQo+PiArDQo+PiArc3RhdGljIHZvaWQgc2lnc2VndmgoaW50IHNpZykNCj4+ICt7DQo+
PiArIHVuc2lnbmVkIGludCBleGl0X2NvZGUgPSAodW5zaWduZWQgaW50KSBzaWc7DQo+PiArIC8q
DQo+PiArICAqIFNlbmQgYW55IG5vbi16ZXJvIHZhbHVlIHRvIGdldCBhIG5vdGlmaWNhdGlvbi4g
SGVyZSB3ZSBhcmUNCj4+ICsgICogc2VuZGluZyB0aGUgc2lnbmFsIG51bWJlciBmb3IgU0lHU0VH
ViB3aGljaCBpcyAxMQ0KPj4gKyAgKi8NCj4+ICsgbm90aWZ5X25ldGxpbmtfdGhyZWFkX2V4aXQo
ZXhpdF9jb2RlKTsNCj4+ICt9DQo+PiArDQo+PiArdm9pZCAqdGhyZWFkYzEodm9pZCAqcHRyKQ0K
Pj4gK3sNCj4+ICsgc2lnbmFsKFNJR1NFR1YsIHNpZ3NlZ3ZoKTsNCj4+ICsgcHJpbnRmKCJDaGls
ZCAxIHRocmVhZCBpZCAlZCwgaGFuZGxpbmcgU0lHU0VHVlxuIiwgZ2V0dGlkKCkpOw0KPj4gKyBz
bGVlcCgyMCk7DQo+PiArIHB0aHJlYWRfZXhpdChOVUxMKTsNCj4+ICt9DQo+PiArDQo+PiArdm9p
ZCAqdGhyZWFkYzIodm9pZCAqcHRyKQ0KPj4gK3sNCj4+ICsgaW50IGV4aXRfdmFsID0gMTsNCj4+
ICsNCj4+ICsgcHJpbnRmKCJDaGlsZCAyIHRocmVhZCBpZCAlZCwgd2FudHMgdG8gZXhpdCB3aXRo
IHZhbHVlICVkXG4iLA0KPj4gKyBnZXR0aWQoKSwgZXhpdF92YWwpOw0KPj4gKyBzbGVlcCgyKTsN
Cj4+ICsgbm90aWZ5X25ldGxpbmtfdGhyZWFkX2V4aXQoZXhpdF92YWwpOw0KPj4gKyBwdGhyZWFk
X2V4aXQoTlVMTCk7DQo+PiArfQ0KPj4gKw0KPj4gK2ludCBtYWluKGludCBhcmdjLCBjaGFyICoq
YXJndikNCj4+ICt7DQo+PiArIHB0aHJlYWRfdCB0aHJlYWQxLCB0aHJlYWQyOw0KPj4gKyBwdGhy
ZWFkX2F0dHJfdCBhdHRyMSwgYXR0cjI7DQo+PiArIGludCByZXQ7DQo+PiArDQo+PiArIHJldCA9
IHB0aHJlYWRfYXR0cl9pbml0KCZhdHRyMSk7DQo+PiArIGlmIChyZXQgIT0gMCkgew0KPj4gKyBw
ZXJyb3IoInB0aHJlYWRfYXR0cl9pbml0IGZhaWxlZCIpOw0KPj4gKyBleGl0KHJldCk7DQo+PiAr
IH0NCj4+ICsgcmV0ID0gcHRocmVhZF9hdHRyX3NldGRldGFjaHN0YXRlKCZhdHRyMSwgUFRIUkVB
RF9DUkVBVEVfREVUQUNIRUQpOw0KPj4gKyBpZiAocmV0ICE9IDApIHsNCj4+ICsgcGVycm9yKCJw
dGhyZWFkX2F0dHJfc2V0ZGV0YWNoc3RhdGUgZmFpbGVkIik7DQo+PiArIGV4aXQocmV0KTsNCj4+
ICsgfQ0KPj4gKyByZXQgPSBwdGhyZWFkX2NyZWF0ZSgmdGhyZWFkMSwgJmF0dHIxLCAqdGhyZWFk
YzEsIE5VTEwpOw0KPj4gKyBpZiAocmV0ICE9IDApIHsNCj4+ICsgcGVycm9yKCJwdGhyZWFkX2Ny
ZWF0ZSBmYWlsZWQiKTsNCj4+ICsgZXhpdChyZXQpOw0KPj4gKyB9DQo+PiArDQo+PiArIHJldCA9
IHB0aHJlYWRfYXR0cl9pbml0KCZhdHRyMik7DQo+PiArIGlmIChyZXQgIT0gMCkgew0KPj4gKyBw
ZXJyb3IoInB0aHJlYWRfYXR0cl9pbml0IGZhaWxlZCIpOw0KPj4gKyBleGl0KHJldCk7DQo+PiAr
IH0NCj4+ICsgcmV0ID0gcHRocmVhZF9hdHRyX3NldGRldGFjaHN0YXRlKCZhdHRyMiwgUFRIUkVB
RF9DUkVBVEVfREVUQUNIRUQpOw0KPj4gKyBpZiAocmV0ICE9IDApIHsNCj4+ICsgcGVycm9yKCJw
dGhyZWFkX2F0dHJfc2V0ZGV0YWNoc3RhdGUgZmFpbGVkIik7DQo+PiArIGV4aXQocmV0KTsNCj4+
ICsgfQ0KPj4gKyByZXQgPSBwdGhyZWFkX2NyZWF0ZSgmdGhyZWFkMiwgJmF0dHIyLCAqdGhyZWFk
YzIsIE5VTEwpOw0KPj4gKyBpZiAocmV0ICE9IDApIHsNCj4+ICsgcGVycm9yKCJwdGhyZWFkX2Ny
ZWF0ZSBmYWlsZWQiKTsNCj4+ICsgZXhpdChyZXQpOw0KPj4gKyB9DQo+IA0KPiBJIGV4cGVjdGVk
IHRoZSB0ZXN0IHRvIGNoZWNrIGZvciB0aGUgY29ycmVjdCB2YWx1ZSB0byBiZSByZXR1cm5lZD8N
Cj4gQ291bGQgeW91IHVzZSBwdGhyZWFkX2pvaW4oKSBhbmQgdmVyaWZ5IHRoZSBzYW1lIHZhbHVl
IGlzIHJldHVybmVkDQo+IHRocm91Z2ggdGhlIG5ldyBtZWNoYW5pc20sIG9yIHdpbGwgdGhleSBu
b3QgbWF0Y2g/DQoNClRoaXMgaXMgYSBtYW51YWwgdGVzdCwgeW91IG5lZWQgdG8gY2hlY2sgdmlz
dWFsbHkgdGhhdCB0aGUgcHJvY19maWx0ZXINCklzIHJldHVybmluZyBjb3JyZWN0IHZhbHVlcyBm
b3IgdGhlIDIgY2FzZXMuIEkgY2FuIG1ha2UgdGhpcyBhbg0KYXV0b21hdGVkIHRlc3QsIHJlYWRp
bmcgdGhlIG91dHB1dCBvZiBwcm9jX2ZpbHRlciBkaXJlY3RseSBmcm9tIGEgZmlsZQ0KYW5kIGNo
ZWNraW5nIHRoZSB2YWx1ZXMgYXJlIGFzIGV4cGVjdGVkLg0KVGhlcmUgaXMgYWxzbyBhbm90aGVy
IHRlc3QgcHJvZ3JhbSB3aGljaCBkb2VzIGFuIGF1dG9tYXRlZCB0ZXN0DQpvZiB0aGUgdmFsdWVz
IHJldHVybmVkIGJ5IHByb2NfZmlsdGVyIGZvciBzY2FsZSAoMTAwayBvciBzbyksIHdoaWNoIEkN
CndpbGwgc2VuZCBvdXQgbGF0ZXIuIChUaGUgY28tYXV0aG9yIG9mIHRoYXQgcGF0Y2gsIHdobyB3
cm90ZSB0aGUNCm9yaWdpbmFsIGNvZGUgZm9yIHByb2Nlc3NlcywgaXMgYXdheSAtIEBwZWlsaS5p
b0BvcmFjbGUuY29tKQ0KcHRocmVhZF9qb2luKCkgY2Fubm90IHJldHVybiBhIHZhbHVlIHRvIHRo
ZSBrZXJuZWwsIHNvIHdlIGNhbm5vdA0KdXNlIGl0IHRvIHZlcmlmeSB0aGUgbmV3IG1lY2hhbmlz
bS4gDQoNCj4gDQo+PiArDQo+PiArIC8qIFdhaXQgZm9yIGNoaWxkcmVuIHRvIGV4aXQgb3IgYmUg
a2lsbGVkICovDQo+PiArIHNsZWVwKDMwKTsNCj4+ICsgZXhpdCgwKTsNCj4+ICt9DQo+PiBkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29ubmVjdG9yL3RocmVhZF9maWx0ZXIu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWRfZmlsdGVyLmMNCj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjNkYTc0MGFhNzUz
Nw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29u
bmVjdG9yL3RocmVhZF9maWx0ZXIuYw0KPj4gQEAgLTAsMCArMSw5NiBAQA0KPj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4+ICsvKg0KPj4gKyAqIEF1dGhvcjog
QW5qYWxpIEt1bGthcm5pIDxhbmphbGkuay5rdWxrYXJuaUBvcmFjbGUuY29tPg0KPj4gKyAqDQo+
PiArICogQ29weXJpZ2h0IChjKSAyMDI0IE9yYWNsZSBhbmQvb3IgaXRzIGFmZmlsaWF0ZXMuDQo+
PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KPj4gKyNpbmNsdWRlIDxz
eXMvZXBvbGwuaD4NCj4+ICsjaW5jbHVkZSA8c3lzL3NvY2tldC5oPg0KPj4gKyNpbmNsdWRlIDxs
aW51eC9uZXRsaW5rLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2Nvbm5lY3Rvci5oPg0KPj4gKyNp
bmNsdWRlIDxsaW51eC9jbl9wcm9jLmg+DQo+PiArDQo+PiArI2luY2x1ZGUgPHN0ZGRlZi5oPg0K
Pj4gKyNpbmNsdWRlIDxzdGRpby5oPg0KPj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4NCj4+ICsjaW5j
bHVkZSA8dW5pc3RkLmg+DQo+PiArI2luY2x1ZGUgPHN0cmluZ3MuaD4NCj4+ICsjaW5jbHVkZSA8
ZXJybm8uaD4NCj4+ICsjaW5jbHVkZSA8c2lnbmFsLmg+DQo+PiArI2luY2x1ZGUgPHN0cmluZy5o
Pg0KPj4gKw0KPj4gKyNkZWZpbmUgTkxfTUVTU0FHRV9TSVpFIChzaXplb2Yoc3RydWN0IG5sbXNn
aGRyKSArIHNpemVvZihzdHJ1Y3QgY25fbXNnKSArIFwNCj4+ICsgc2l6ZW9mKHN0cnVjdCBwcm9j
X2lucHV0KSkNCj4+ICsNCj4+ICsvKg0KPj4gKyAqIFNlbmQgUFJPQ19DTl9NQ0FTVF9OT1RJRlkg
dHlwZSBub3RpZmljYXRpb24gdG8gdGhlIGNvbm5lY3RvciBjb2RlIGluIGtlcm5lbC4NCj4+ICsg
KiBUaGlzIHdpbGwgc2VuZCB0aGUgZXhpdF9jb2RlIHNwZWNpZmllZCBieSB1c2VyIHRvIHRoZSBj
b25uZWN0b3IgbGF5ZXIsIHNvDQo+PiArICogaXQgY2FuIHNlbmQgYSBub3RpZmljYXRpb24gZm9y
IHRoYXQgZXZlbnQgdG8gYW55IGxpc3RlbmluZyBwcm9jZXNzDQo+PiArICovDQo+PiAraW50IHNl
bmRfbWVzc2FnZShpbnQgbmxfc29jaywgdW5zaWduZWQgaW50IGV4aXRfY29kZSkNCj4+ICt7DQo+
PiArIGNoYXIgYnVmZltOTF9NRVNTQUdFX1NJWkVdOw0KPj4gKyBzdHJ1Y3Qgbmxtc2doZHIgKmhk
cjsNCj4+ICsgc3RydWN0IGNuX21zZyAqbXNnOw0KPj4gKw0KPj4gKyBoZHIgPSAoc3RydWN0IG5s
bXNnaGRyICopYnVmZjsNCj4+ICsgaGRyLT5ubG1zZ19sZW4gPSBOTF9NRVNTQUdFX1NJWkU7DQo+
PiArIGhkci0+bmxtc2dfdHlwZSA9IE5MTVNHX0RPTkU7DQo+PiArIGhkci0+bmxtc2dfZmxhZ3Mg
PSAwOw0KPj4gKyBoZHItPm5sbXNnX3NlcSA9IDA7DQo+PiArIGhkci0+bmxtc2dfcGlkID0gZ2V0
cGlkKCk7DQo+PiArDQo+PiArIG1zZyA9IChzdHJ1Y3QgY25fbXNnICopTkxNU0dfREFUQShoZHIp
Ow0KPj4gKyBtc2ctPmlkLmlkeCA9IENOX0lEWF9QUk9DOw0KPj4gKyBtc2ctPmlkLnZhbCA9IENO
X1ZBTF9QUk9DOw0KPj4gKyBtc2ctPnNlcSA9IDA7DQo+PiArIG1zZy0+YWNrID0gMDsNCj4+ICsg
bXNnLT5mbGFncyA9IDA7DQo+PiArDQo+PiArIG1zZy0+bGVuID0gc2l6ZW9mKHN0cnVjdCBwcm9j
X2lucHV0KTsNCj4+ICsgKChzdHJ1Y3QgcHJvY19pbnB1dCAqKW1zZy0+ZGF0YSktPm1jYXN0X29w
ID0NCj4+ICsgUFJPQ19DTl9NQ0FTVF9OT1RJRlk7DQo+PiArICgoc3RydWN0IHByb2NfaW5wdXQg
Kiltc2ctPmRhdGEpLT51ZXhpdF9jb2RlID0gZXhpdF9jb2RlOw0KPj4gKw0KPj4gKyBpZiAoc2Vu
ZChubF9zb2NrLCBoZHIsIGhkci0+bmxtc2dfbGVuLCAwKSA9PSAtMSkgew0KPj4gKyBwZXJyb3Io
InNlbmQgZmFpbGVkIik7DQo+PiArIHJldHVybiAtZXJybm87DQo+PiArIH0NCj4+ICsgcmV0dXJu
IDA7DQo+PiArfQ0KPj4gKw0KPj4gK2ludCBub3RpZnlfbmV0bGlua190aHJlYWRfZXhpdCh1bnNp
Z25lZCBpbnQgZXhpdF9jb2RlKQ0KPj4gK3sNCj4+ICsgc3RydWN0IHNvY2thZGRyX25sIHNhX25s
Ow0KPj4gKyBpbnQgZXJyID0gMDsNCj4+ICsgaW50IG5sX3NvY2s7DQo+PiArDQo+PiArIG5sX3Nv
Y2sgPSBzb2NrZXQoUEZfTkVUTElOSywgU09DS19ER1JBTSwgTkVUTElOS19DT05ORUNUT1IpOw0K
Pj4gKw0KPj4gKyBpZiAobmxfc29jayA9PSAtMSkgew0KPj4gKyBwZXJyb3IoInNvY2tldCBmYWls
ZWQiKTsNCj4+ICsgcmV0dXJuIC1lcnJubzsNCj4+ICsgfQ0KPj4gKw0KPj4gKyBiemVybygmc2Ff
bmwsIHNpemVvZihzYV9ubCkpOw0KPj4gKyBzYV9ubC5ubF9mYW1pbHkgPSBBRl9ORVRMSU5LOw0K
Pj4gKyBzYV9ubC5ubF9ncm91cHMgPSBDTl9JRFhfUFJPQzsNCj4+ICsgc2FfbmwubmxfcGlkICAg
ID0gZ2V0dGlkKCk7DQo+PiArDQo+PiArIGlmIChiaW5kKG5sX3NvY2ssIChzdHJ1Y3Qgc29ja2Fk
ZHIgKikmc2FfbmwsIHNpemVvZihzYV9ubCkpID09IC0xKSB7DQo+PiArIHBlcnJvcigiYmluZCBm
YWlsZWQiKTsNCj4+ICsgY2xvc2Uobmxfc29jayk7DQo+PiArIHJldHVybiAtZXJybm87DQo+PiAr
IH0NCj4+ICsNCj4+ICsgZXJyID0gc2VuZF9tZXNzYWdlKG5sX3NvY2ssIGV4aXRfY29kZSk7DQo+
PiArDQo+PiArIGNsb3NlKG5sX3NvY2spOw0KPj4gKw0KPj4gKyBpZiAoZXJyIDwgMCkNCj4+ICsg
cmV0dXJuIGVycjsNCj4+ICsNCj4+ICsgcmV0dXJuIDA7DQo+PiArfQ0KPj4gLS0gDQo+PiAyLjQ2
LjANCg0KDQo=

