Return-Path: <linux-kselftest+bounces-4071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577F8483C8
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 05:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495BC1C21672
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 04:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2A101CE;
	Sat,  3 Feb 2024 04:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D4+og854";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0h65Kl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768B101C1;
	Sat,  3 Feb 2024 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706935579; cv=fail; b=k+i+p4EKjVd03TOg9pTDjD54IE2lZsJXBvtzIr8aQNVkKIegVTicekUVD0ZAk8lkyfsOcbPg0j3/BCV80NaCarD0ol76OkEeXHUSiRLKa/bEbML3bH4OqGyd9O7yNUE/eywgtOzjNZOinU4wSPk0EkE66uc26/y7NYmc/yNK1CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706935579; c=relaxed/simple;
	bh=yIItZCfkTad/j9yl8C7KT2+hKXHGllLghcFoPjdpSs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mALvYJS9qIDngkaVzGSgIqL5QUY9guKklJo+e8g6OIZepYfjmynFw0XjVHkOEfy1SPD6voFhLGMAeCU004ayG3qbl6hlgHCD0lPzgPtbbuQFo7+SXhJkWMjPlJ3+Dc9sciWeADKXKdYbpOGrXild3tykRGqYbCBY9iU2KhJasrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D4+og854; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V0h65Kl5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4133wfkF030533;
	Sat, 3 Feb 2024 04:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7NSfMzI3jgCV0FeB1mU1IFb59JNDBEla8JRg+Iy6u1Q=;
 b=D4+og854AwoQEKxeJld2RAYxEq4vDZ18q4lkl5bJCRd1C/01CnjPBxJTRIxzELow0Nmd
 pjfLkfVhGmelg2++K3S2XRENgDfO/TXYozwI2NHp5P/vU2R7C7nnN3JvQvGxZDLH+oEs
 EoQOxtuMzDvYYd5RY9JPOEDtuvS0IkYUUSH68uQ0ndEAYo3UKUQVKADRWaaBdYeLOfBA
 Vug7diHI5mY0ihgTcIOsmV/+S5ro/ZKxKTbWWmfCaIVnCOFelTyvjtsZRJRU0N5BEOe1
 eBgDuGqZT9Ay/M52LWcjWrYmQ3V/THvjgf0Dd+Bk58d3ZK0vTUc6gchQbyB2rz9/X6K/ lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v015r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 04:45:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4131XSMf039427;
	Sat, 3 Feb 2024 04:45:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx346bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 04:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEqZkqJyYNz7uesNb+lz+E6uppyEJR1oMiqjUl3PP5oJ7g1Hi+bCke9fJkoFgSOjMWqGuBTVk+1qAgeZVrwFEZ94/ZfVIKCQ3NSWKAKHkO9CoF04+OHquHrvXxe9fvdwRRJGvb0JS3Y++pmNhVDRLE43J724E1cKe8oUnJi3iL7Tjrk7n8881kcuv/T0GM5V9dfnPTue3ATJowZIoIZd7ddQn9yEZDYwLYMrxbpXherIO8W28a8+ih/ukVtpRW3I0EDxEjMRoA6fgNsNn9GaUy41FUUc+NZhMNxXlSnbyr0+Now0xZ8SXbvu+cXRCysizBwUjWJXcTEBrgHaextioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NSfMzI3jgCV0FeB1mU1IFb59JNDBEla8JRg+Iy6u1Q=;
 b=cY+n972WDs4p/JgLRKLtSNynlFQj1IDaYyzTuoIzDZAhFvH1aIZWvivVzsupDo0i/2tVBGnhnlO184YohfB7Ip3XwoH09aDb9DRh+G5mHSMKDyCsLo3Habeu86/RSovyv9L2CSVosZnb8DiZ0BDQYZZXGec+gq7w4Em0Q7p5PKMp87dHALvMtNSwChULycxcyBYpvtlpYDJp11FUmwJ4wt3V+SF4mspLzseH+t4QNTLWwiD6mS9MCBi6Z9xFA/liKlTcp61fHKQmt7/lwgxxxCbkr0cR8w/Lz3PA/r4CMbT+z8zZ99WFU88ITXA1JV6WjVM7yYQfLeuU3hJ4bATPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NSfMzI3jgCV0FeB1mU1IFb59JNDBEla8JRg+Iy6u1Q=;
 b=V0h65Kl5T7ocFRtknoKvTzOajvSrXIyii4+bcdvl1WgiAAfpg74rp1pIhI8u92EXA0ug7Q/qhULl3JaJqWtUx0gvmNacM6kypXAlHX7hyRDzhNK4VF+/WaS1V3nFNRYhErFI2hu+TpPZcUGtx5olqzUxdfpebKWcMqTln16E9WI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5353.namprd10.prod.outlook.com (2603:10b6:610:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 04:45:37 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 04:45:36 +0000
Date: Fri, 2 Feb 2024 23:45:34 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>,
        Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        usama.anjum@collabora.com, rdunlap@infradead.org, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 0/4] Introduce mseal
Message-ID: <20240203044534.wkyfkxdlnskxctsq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org,
	keescook@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	usama.anjum@collabora.com, rdunlap@infradead.org,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org
References: <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver>
 <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver>
 <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver>
 <85714.1706902336@cvs.openbsd.org>
 <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
 <20240202211807.6sca4ppezma7cyev@revolver>
 <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0365.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c735fd3-17ed-4882-a5d3-08dc2472f6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4yFAf1WTWoB7X1yk/kTqbMeVoBnIr4wwcKTyuxrOCt8Jl7IZM9mR2x+wLhT/oDeOXIohExqL8EDlAe3HTa2Cq1W1aRMURrkhdM4WZEMF+s67G0LsrR1I6Cv8KJoPMI0Pl6Mo+GpmktKVC9ReevMHHB9+vWvMRRVTWqRB/aAYusDgQ7rCu8Fc19GVoloeDfyJLA/OrqnsDvRVz121objCwHmwNI3n/JYN2ar503hQS+yR7yFJaHl5cf3RVE/X7pNXB+saFDyLZf63nqn46QoS9IXXt96P9BcCGcLe4w32JltChRqyh2QrDS0VyBxOvTeys2fneAYAVADr2zc9YjG25oEtGPC5TlV3Rny9z6TORXN8Eu2Tx6DD1slTx36oX2In0Qld9wPWP7iXr6B801JUa2ng0TWDuJDo3HdRHKcIhn1JQd0KtcThyKxCUE+iiSUgFq7vNGnMl1MKzJHCmxFu/WOdhOrnIpFf7nWkOuphJ9UuDbVOfQPn4aec3duDsQ/FrfIYttJ0IEmYLBqZeqQBKvE0set64xGA0LrXxO3M8aMr/e/SFa/OQmKpR11IAnxS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(33716001)(26005)(1076003)(41300700001)(9686003)(3716004)(54906003)(6916009)(316002)(478600001)(6506007)(6486002)(83380400001)(6512007)(38100700002)(66476007)(66556008)(7416002)(2906002)(5660300002)(86362001)(66946007)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a6ItjUFiTYGOadj/xC5US1sB2xHIzW9ajfmNINDBzJe7fdVZ1UUeEdHnWUUK?=
 =?us-ascii?Q?ZHq/j965sSOLW17/0KKlMwG+elkn+YVmnDn3gw4Cz0N6c9I5zB1skQPb9ILc?=
 =?us-ascii?Q?xjyO/JqqK3jDwIesELaYehUg9RULk/QzXYz8/vJTPZe2fn/pVc+TlEcg98yl?=
 =?us-ascii?Q?A+2pbG9IKiXFZE343EaQaN8UBlaFK3YRK2mXwFoECvFUYMuJxkCrgvGStfc2?=
 =?us-ascii?Q?Eyd6wzydHzhubiZ+bYrJxI+0fLjaCter/Kw9nuxJayL8zAnv3sp7gHrYXpWp?=
 =?us-ascii?Q?GIKOg1K2hTAmv4v3PKnN9NirRtpC0rhRd81ovfWRVRWZtvYTDjuauiGAg03B?=
 =?us-ascii?Q?wuT+WE8sPWNBuE0jzaKkFby+K+vTUjht0f1EUH7e1EoZI3EP+gKvXqjnKL+V?=
 =?us-ascii?Q?VAHIS7MsmsTKqTrIacjSNvExAn6v+XdLcL+29iyENxYaiTQehKDlvmQsfEJA?=
 =?us-ascii?Q?k/bIdeswC1RIHRPjSRDzVzC4aihT64duKxc/LGrFODUrKTBHOIamPcmgu5Iy?=
 =?us-ascii?Q?e6g16HqiDcxtLX5nXeM8gzgALTvVV2B3E6J9yiPuWoPtsMHZGwJ6fdzV/KBU?=
 =?us-ascii?Q?O/80BAPPs2cFr36Rs9VkKE6jQSwXygJAvtz34vT2K6uLsH2IzLqcx8ocAhQG?=
 =?us-ascii?Q?mOPAnq4KbuwGqOHxklThYuLDXdtC7DJaR7i9DRoxrg8idvDJ+Tg6dNA5u43G?=
 =?us-ascii?Q?PfcT6+IIvnUc2DzSrikx/VjDVTTC7pLW5MdX0QqVnsdZAY8LZxTlvOFlHsev?=
 =?us-ascii?Q?FpDj2PJ7Jlu+Bgg+2f5YXp8NdEIIr8bX30IwE3VlkuSW+tkHWI2jrGxiEb2k?=
 =?us-ascii?Q?/kStk+tWsrEAMAAwU6UeAJXLz1ZeP3va/kfbRiB711TldKl2xfmrEEbPV8qO?=
 =?us-ascii?Q?JdpRCZnwguE00bdOc7W+qtLHsyVIuBlIa/SIgOhAnPOo+vfSR21sm7tqn+WS?=
 =?us-ascii?Q?KvVYRPtw2leJRtzVq5ymbDYk9W5RhpXjEf0sZpfqoRXUnwOr7Owriq2jDk/F?=
 =?us-ascii?Q?wRzoNehkx0beDjtqWoaObVJZ9dEDPpT9pwSZ+rEesr5aeYMUg/rzIHwKBz8m?=
 =?us-ascii?Q?7aeu/6CaC96xjibhuXaLmVUqV+EVUVx0eIPv/3mpcSdwyJpMog+MQgC5DOLn?=
 =?us-ascii?Q?eylqiO1BAQzPd+ifcLi94LhsmtZE16m2/1j3xjhPkoyIBtz3ycdjlAC0bqvG?=
 =?us-ascii?Q?z7KjtqEDCK/E3B+9rI35nC7PmXWpc70M9oBKkIX2Iji2PPa7ZODdGMLMyNTp?=
 =?us-ascii?Q?3V5yyFmEsjokaOsiRIWmbNymEtrG6Jh1ozXJffVxAr6iBtesZ7NVQyfvknXW?=
 =?us-ascii?Q?8374vB2oHuBen1OGy6cTB1aA6VWggl9FYDk8rWcWN/jZbefRlzjTTIGAJ29y?=
 =?us-ascii?Q?OTOC8JNBj3G/EToSUfqEgDNbttw4ycdq/L9wX5/lkUn+GWnbeXuXb8eTJvyr?=
 =?us-ascii?Q?FKKS/agtPjocMbithhcBtSWb/E1lwuyOIZob3bTLMP7ExbvRbX/EJzWWTBPt?=
 =?us-ascii?Q?pdWeWd+4crCYvn8zC79HBOhslECFncGXH27KAhE6V9S3eUy3OlF2UJQqpasl?=
 =?us-ascii?Q?8fnLxv9McMYa9oJmegX6OZ4/9QPHYmqzLjsxkF6074fsWdrJSJ8tPpm/Xdie?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D6ZQg90c3dHgq4cc4/7DyDyMRtsLKjUP6//aPNB6r8Np55Y3P3jz+zwTBp7AFDihPpdSiWmUIRQl6uRGzGMDQG1400UNOjyxmY+h17fLhQedna3C4JcMlOdD9RLZB3dtQZw9x0xeY18E8qGeZo/F5FIEeRduOhbWegxmx9GAqAvl1mLAFwn+JVdWR7M+DpKYUmHUXxdZDiJGpx4kqpxzKnemnNES2wt8x2PcAGsBRZnB48LbWbnFAHreuVpS28hl4Ya22y98PEnPbommfMk05BbYHbxJ91OI1epJcWiibFvcAHzW15LNyiKmyhz511tlPLp8l1/uAD4O7tLiTt/reMBF7QmPskSyOzxoZLrPGs/ldeXpDjNWP+XNx7Tuc34VWgW+hl2t3SlpZsF1YTv9KDD1CkczuAIJZlylSck7nasxZ+qd3vhKo1x+ibtwztvkXX86H9/bqQ3c2K1j6xGL5ScAW6LYmqCwiG1XgbGQ+OQvV0AfOVfISDx/7OyF0pCjOZEmifa1NJn4Cqs+/2pO+CChuaKkwwWafr4yJmwVuXqPYkZ5wkNkAwWH+CpNPW/BV1CXvoIV5zWNEnLYFc14IJDh2l2Ss5qxfPCLyeWBLKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c735fd3-17ed-4882-a5d3-08dc2472f6ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 04:45:36.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+RFoghRIOfrfxYit8MtDLiX+QtwsHtegVAp1XgIT/wAynur0nfkgiMaHTT+EUTacwUs7UMxgikxZA6MCqrmIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5353
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402030029
X-Proofpoint-GUID: 2hTPGDSUWySPRDaAHVpEpYfFxc-COSij
X-Proofpoint-ORIG-GUID: 2hTPGDSUWySPRDaAHVpEpYfFxc-COSij

* Linus Torvalds <torvalds@linux-foundation.org> [240202 18:36]:
> On Fri, 2 Feb 2024 at 13:18, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > There will be a larger performance cost to checking up front without
> > allowing the partial completion.
> 
> I suspect that for mseal(), the only half-way common case will be
> sealing an area that is entirely contained within one vma.

Agreed.

> 
> So the cost will be the vma splitting (if it's not the whole vma), and
> very unlikely to be any kind of "walk the vma's to check that they can
> all be sealed" loop up-front.

That's the cost of calling mseal(), and I think that will be totally
reasonable.

I'm more concerned with the other calls that do affect more than one vma
that will now have to ensure there is not an mseal'ed vma among the
affected area.

As you pointed out, we don't do atomic updates and so we have to add a
loop at the beginning to check this new special case, which is what this
patch set does today.  That means we're going to be looping through
twice for any call that could fail if one is mseal'ed. This includes
munmap() and mprotect().

The impact will vary based on how many vma's are handled. I'd like some
numbers on this so we can see if it is a concern, which Jeff has agreed
to provide in the future - Thank you, Jeff.

It also means we're modifying the behaviour of those calls so they could
fail before anything changes (regardless of where the failure would
occur), and we could still fail later when another aspect of a vma would
cause a failure as we do today.  We are paying the price for a more
atomic update, but we aren't trying very hard to be atomic with our
updates - we don't have many (virtually no) vma checks before
modifications start.

For instance, we could move the mprotect check for map_deny_write_exec()
to the pre-update loop to make it more atomic in nature.  This one seems
somewhat related to mseal, so it would be better if they were both
checked atomic(ish) together.  Although, I wonder if the user visible
changes would be acceptable and worth the risk.

We will have two classes of updates to vma's: the more atomic view and
the legacy view.  The question of what happens when the two mix, or
where a specific check should go will get (more) confusing.

Thanks,
Liam

