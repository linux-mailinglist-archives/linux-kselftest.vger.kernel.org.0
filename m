Return-Path: <linux-kselftest+bounces-44380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73819C1E594
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 05:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 514D84E1CF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 04:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4D1F5433;
	Thu, 30 Oct 2025 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzDvOuj7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jffrvq1M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80DC2E0;
	Thu, 30 Oct 2025 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798702; cv=fail; b=dav410PQvNPOnDYcA24/Z/b2hHvPR6ZSmtdIzUr4UK8AHse6wIoMwgaexO5EIcj3rY3yyL6vLcNh6qcMcRh1K0AvFdzi6mLuyqL9u7yN4IT+5itIfeTGXOuniDy90l3SjCDQKB7YtC70rDzjxjrX0mBrYn1Lzu5cGKJ0mF01QzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798702; c=relaxed/simple;
	bh=gECV5kPrPbzw3qoaycePXaYyrnyArwGZUtIzqXj3JIE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ngeLyFaN/SQb1O1oBrNPZzUbnCBE0e61xtf9NblXjp9zQXiNRVRHJ08vneVjEFU9C8bzsJhyJ/ThowCjp8D/U/BkSje7BstCqDhyoWpwTnjCO8wUdPeccPtUNvPBVbCs8tCvCtmnALDA8sQNRlEKcMviRkdIDbTqdvWuogFG5W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FzDvOuj7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jffrvq1M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U2ZNHQ025314;
	Thu, 30 Oct 2025 04:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=R+ew75HTgDh5ULhv9UAtcNkF/ees84u9QbS7G3IYuGQ=; b=
	FzDvOuj7OHC3Zt2ghxZ0G1uh3kJlTqnc0i9RYr6IpwGLueOBihDq1zD+2CmUtBRt
	kYWBhCe6Zjur3kSP8durjgY+kYH54lPc6ty0ibep3Cv6GgFXCpunMYuXCoiRSsBX
	WQucNwlSabau1U4rZod8gTmsZu5zqFxqBA2gSQjyk8uTUANhRfQmaiRQPdU5wKLG
	7OEypYaPQbkhg1Gbbf2ng9pAXyr6OeaHZW3irqrU2sotqVHi7GKjMu1K2rHc94e2
	6ISrzTEoRYq+niM2m1D+5/7mXK19vIHl6kdtgRLwc9uZEEIqAl9i4jl6hWPPzvih
	n/Cc2knhtC+/b4R1+QSSlQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3ybsr4mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 04:31:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U4F6UM031573;
	Thu, 30 Oct 2025 04:31:25 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34ectcyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 04:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEAAe/CM3Zk/aK7K2Ldw8yzHN+eMCZ/7goWdSLGBer5ZFlgpAZASa4pj1nW03Icy77Kh6Aq/nWMcIuPPkoLJnlM+yG+KJgFSGE50gpM/F8TnSE0M+djr5fFon9d9uQU5RLcmMLOy4th1KOrN8W51HmFnvIs6MeLqGaYMNx4JQuM1q35f9xSWyA+ScX1u3nbgOBnXJodUrocceFhtBU51wMvfNtUA3URteOHTmqLWx3hP2WOWWY983Ru63EnZ/aRp+tOZVWyxIgv3r/8cNBAU+pGHeVZv8heC0chONHRAlVjNOpU7M3H/st4zDhUWIgoLh6ddok4NO2R9R0khHWK13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+ew75HTgDh5ULhv9UAtcNkF/ees84u9QbS7G3IYuGQ=;
 b=EDiLrEsUfwSadG3Y35h6IjYG56gWHMtxuz13bWb+7Z7bihWrFTT/eEaCTBJZ7aYBGL7lKZ6MPT93+kq5XbNsh7ww8FJAWLd3OaBCgTWwrVdER6EWw3cWw4cQKHUekQjj9VF0HM8ZGqzepj4JZRvVCcdAAG81E2tQhe2d1opfrvnblz5+sPjehh7J6y9Tn5ytIoCupMIBFE1VkW+UaEk1oX8xUvOOrs9qgjxeLrm/x1SwlIyD7scLk0HWRuJTkI+kyBTkW8Z83Y6HFpphcxxUGQxVtrSHM4cJWrDXLRgmp2ayJ4AR/7RyqsJyDEOGTEesEG6t2M8NFdgVgTLhB8ajbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+ew75HTgDh5ULhv9UAtcNkF/ees84u9QbS7G3IYuGQ=;
 b=jffrvq1MK57hcxKbUg2+NzgDgDy4jINZbv9y0KpmO+Fa6li94PW9HTR09fhZ3SqbPsaqlq2OmQwNBgF4icJX20DMhECE6bazihwWLPzDYtUQiNzoZP/LcyOj5BhSSb8n13ySanI8cM+dlptGZkoUbEKn0hiktkL7TmYPhqvKTms=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 04:31:21 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 04:31:21 +0000
Message-ID: <92cb16f0-20e8-4ef5-8b4e-3ec5de3e5fd3@oracle.com>
Date: Thu, 30 Oct 2025 10:01:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v3] selftests: drv-net: replace the
 nsim ring test with a drv-net one
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20251029164930.2923448-1-kuba@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251029164930.2923448-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 681d7776-aef7-44b4-8568-08de176d2d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NLUXVSdmk0ZDg5RDNUNkIzMFpDVXB3Mjh5Y1ZQK3hkcHlHUXdta0xtaFRq?=
 =?utf-8?B?eDFXUWowcGhSTnV6NXN2SEdyYWJnekpOMGl2MUVENmI5eml3TWRMeXlYbnBs?=
 =?utf-8?B?Qll6c2JDcDRqem1DMTJSM3ZCSHgyK2o2b1JKTVk1SjZVWDNSR09IWlUwTHBz?=
 =?utf-8?B?dmh2dnZhMi9SVk5jMUJsL21aY2tlekxHMEVsL01FeVh1QVhIME9jZmhUa0tB?=
 =?utf-8?B?Z1YyOCs4Z0dmaU5pVTNkVHN0MDFnNzhCWnVTaGNhYnBITm93ckpWT3NmUEtG?=
 =?utf-8?B?aGVseFhJQ0ZXUDVaRFBPNlNUTzNNRU1udUc5VEs1cEg4dytzOTZXd3dzaVc2?=
 =?utf-8?B?S2R6cndwSnRQR0JEdlptVjZ0S0Q2YzRqbkl1MFR4VG5ERmhpd0ErNWJTWVQx?=
 =?utf-8?B?dFU5bGRUb2xsbndsY21IODdPMHZyYlpFWjJqTXhOc1ExZnA4R0ZJMktBT1Yv?=
 =?utf-8?B?WEFXKzBlZFF0RWMycE9OSHhFZGNqRDgwM3JxZ0lYZG5rcDZzZmZMZElnejYr?=
 =?utf-8?B?cTEvVWYzNjd3RWRCMDdRWmdLOFh0eVpkcFdHOVNlMEFsMjlyY1RVWTdmMWw3?=
 =?utf-8?B?b3lWVDRnY2FlUzFkVDNyclpYUzc4VS91RWNRakFPY2l0SVlKemhwVUpBbUNH?=
 =?utf-8?B?WmJyWk1NdmNYeHh5R2h1R3dZelNkL0xsUVlGM0QxUWNMYWhqcTl0dWExTE1n?=
 =?utf-8?B?bTlLck01cnk1VzJEQkcvUjZYSmdaamNJS1ZEUkZPcVFpb25UVlFacFhjcHo0?=
 =?utf-8?B?QlZKZ2FFekQ5elJMdlYxL3pVcVhWTlExY3lJcExUTUl5VytLOUJJaWR3T0Nu?=
 =?utf-8?B?SEJNdHV3Z0hzdFF5c3JxSFNlMi84eklOb0YvSHRmUVhGZ0RXSG9IbENjdjBl?=
 =?utf-8?B?RFpibTBxalVEeHpOMUw2ODFuTmxKNXpsaFhXY3VCZ1QvanpwaC9BWGdJRHZ1?=
 =?utf-8?B?cThtYXdjbW1kM0dTZUFyMkljcHV0T0lCTVpYWWtYNEZxSmZTZXFxYzlKMG5x?=
 =?utf-8?B?T09RYS92b0ZqL2pOb1IxTjJyUlZqVDhwNjRZbVcyTW1KZ1BwQUxNZU5FUUkw?=
 =?utf-8?B?VFU1bktUVHJEc2VhMitXQjk5eVlUR0R3UjQyVFBYSFFuNm9wNE9ndmNYYWhE?=
 =?utf-8?B?b0pkam1EZTlsUnBvRDB6ZUFwdnBRbElTdlNSQ3ZmK3JZOUtDb0FicVQxcC9R?=
 =?utf-8?B?TnR4QzIySkltd25ETmtrY25tME1hRXdBbGk1Ty9CVGxuU1FRenZPYzhhWCtF?=
 =?utf-8?B?NjFyYXBWdms1ZU53N1lMeDJwbCtSNGF6Q2FEVExLN1RKREE3cWpsUGIyME9T?=
 =?utf-8?B?S3QyYUljK3VwNS9IVGU0WkxWZm81NzVySURmNkh1cWJtVS8wdTc0WDJvQTQ1?=
 =?utf-8?B?R1ZzWGZNdDQzM3lERjgvSmU3UHpBNUJZWEJoUUpLbXpaWEtpN0M2L0lWelRM?=
 =?utf-8?B?MTRwYTM2cmxlQVIrbHh6V20zQldvTWcrU2ZFeU1MYzlwRFNZV1ppK1dpTlBK?=
 =?utf-8?B?ZTJvRFg2MTgwYWFWNFlxRkJHUTYzdjlSV2t5M2VORHRWZmZlUmpCRVJxekZQ?=
 =?utf-8?B?RHVDSFBwbWd5SWtHZmZtVGpQVWUwTFFqeG1iNUxzQVFFeG8vSUxYVmx5aTBR?=
 =?utf-8?B?RFpod01SUlRYZFAvZzhQaEY3eGt1N251bWhIcHZ4SVIvb3EwRldhSVJVZ05m?=
 =?utf-8?B?QXZZVS8xOVlITG1hc3lQRVorYTlOY2taNmZkUnVaSVpUZkUrWWhsZ1gyWjZt?=
 =?utf-8?B?UkhwM0l0YXRDQ2djWUVwdDA3YmdxQUQyWElobHdmWUdZQXRkcFNob0c1WWhE?=
 =?utf-8?B?Y1Zza3VZUzFsSER0bVF3TWtuMHRpYTY0ZVQ0c1lTTjhBdEcvaTFlWUhFNEY1?=
 =?utf-8?B?SUZHL05pekNhZVdSbUpRSU1wanNjN0VlL2lNeC9KTVVzcGxkR0pzS0pDbGU1?=
 =?utf-8?Q?CEe3dmxXpHNLZWU1DGLHTXWRgfBGBt0g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?USs3cmc5Z2trdXNxTlJDRWlxaDZML3QzZ2FYR01zSGx6aGUwZ2JkamNYYUJq?=
 =?utf-8?B?M1ZNS1N2TG12Z0xLZVVTUTVHOTlBSGkzcWtxUmhYdzdxeXB6SUtZM2cvZG1B?=
 =?utf-8?B?UityYmVPL3I5eHZ4S1hlM0paTTRBUG43MFlOemZUVlhEb0hGR0JZSjhmUDJK?=
 =?utf-8?B?NHFzK3hGVGxiRTJZZEVId1pVbG52VjFZYUxoOXRRVjJaQ3FUZ3RhTkxJS0Yx?=
 =?utf-8?B?eVdhLzN5SmF3bENhdys0aW1UZXNteFFFQlNXekFRUlkrdGw5Mk1nSzFSYUNv?=
 =?utf-8?B?M2pJUC9YOXRhODNkU1ZIVGcvMyszeWY2YmFPZ2srclVKOVJyZjdITkZwSm9z?=
 =?utf-8?B?SDRuTmNCN3J2NnZYZ3hTdFc5WW90c2lPNnRGbFIzWEkramVFdUk2L05SVXBW?=
 =?utf-8?B?NzNjNW53Ti80REhjRCtlVG5vbVpxaFFmQ2Q5MEVwTUh2UG9JTlB4OG5Va0xY?=
 =?utf-8?B?VjdLZEdGYU5TbFJENG1raHpiSUdlRkVBNzlLdG9HSTRXRUh2NVBCQlF6SlZE?=
 =?utf-8?B?OTB4ckt1OTF0WUt2Tm9CMUprZWxlcE81QmxldWpMdGdyRkgvTlJyeW9NcUZT?=
 =?utf-8?B?QzVxQWdxUUZkTEhRTXRlbEtXeGNheERIbFZseGp2ZmMxTEdqL3pxM0RhdS9H?=
 =?utf-8?B?WGdHc0IyTzBiRkhDd1A2clVZUXNudnRyWkoxS3YyRVNkYzJFeVd1Z1R2UzFx?=
 =?utf-8?B?QUpkZ3JyZk5TS2xqMjI1N29CRTFLblVFd3R1ME1RTERCci9kS2llQTc4Zk82?=
 =?utf-8?B?ZVpJYzdGNHFQM1hOanYybTdLYmlGeEw5Qk1aMVBST2hkWUx1QVNDRGJTTk5s?=
 =?utf-8?B?a1ZBWldmMzVUSFd0Z3pJYVFCeWUxSVhCdlBJZW5VR1Z1RjJ6NytUcXM3MEVQ?=
 =?utf-8?B?Z0EwUlFSd2g2QlVWcXNPY3Q4OFJ4Z3RBQWJoSlZ1OFNHVlRMSlpPSGphNzBL?=
 =?utf-8?B?ZHk0L2RIM0JKZHRwVUZkY3pMNUpkVmRmWW5GdTJ6RXU2ZEl0Uy9ZNmNrWXlO?=
 =?utf-8?B?U28wY0xYamx5L0t4WjVtcHFjTXdsUWhZMHhFVmhWYVRoMUlzK2hsNmxLK1hY?=
 =?utf-8?B?UzFLV2hxR0RhVHJmSVFvUGJ0bUlQcHhWdHpNbHZ5OVJWQWRxODl1VTFGVDNs?=
 =?utf-8?B?MkVCTytpN2JOSmd5alBPNUExc1BkbFdaVmJtOW90N0FTNGlNTXFxc2dCd1JJ?=
 =?utf-8?B?bTVUMkh2QWZRWUhyWnA0Yld3Y3NsT1hVcDNxd3I0NGk5bFJtbk04Umh3dzVr?=
 =?utf-8?B?KzZxakVyaEUyRmlzZjJYcXVISGpBZHN3L0Npa01tVEpuSkVLK3NFRDFZT1NW?=
 =?utf-8?B?cnNvN3pkdHdYNENmSjlWU2pBN3hEeXVmaFRnTmt6Z3pFMFludTRXdGJpaSsr?=
 =?utf-8?B?VnBCYUZPV1RiZDZFdUw1cCtJb1Nzcnl0NDBRYUM2aUcrZmpnaDhJUXlMZnBh?=
 =?utf-8?B?RXduU2NaVU8wQkRZclhlQzVnWWhRdTc5VzZxYktLWnJvU3Y2Rmc2Yi80TTQz?=
 =?utf-8?B?V3JMVjAvSEFBZVMrbHl2dXhYQks4ZzBIK0ZaZFd0Uk0wMUFobDBuRXlQRkFp?=
 =?utf-8?B?MkpHRzMzbHBCNXV1RHlBZUpUeWVyaHZ0bWNZUThIUkNseFNGM1NJcTZDakRC?=
 =?utf-8?B?ZHFlWDc5eWkya0NnUDk1WXdVcWkwRHFRZjZGNUZNWG1zcWNIdlB5Tzlub3VF?=
 =?utf-8?B?UVZwa1dMTS9BeTVDNHN2YWd1Y3daVVJ6Vk9WVFF2aFNEMWJycndXN2FkM1BJ?=
 =?utf-8?B?ckpPNkR1RzhadnB1UWx3QUtDbzJWemtrci9pWDh1VTZGR243aXBOY2JmUjQ2?=
 =?utf-8?B?SzFveWJsNGI2ME9KNEhST0d1UkRWSTJJTUFqblE2NTMwL2dZR0JxVDZGUHNz?=
 =?utf-8?B?N3VMRm5UU1NSTVBrTzFKcTZSNkhpcjZ4RkJtOEhGY082eEJEQUxnNGwxYTVj?=
 =?utf-8?B?T3h2MWJiNjg5ekhHVGtIYUZ0cFpjc1ZKckxQRExycEZIa25iVHI0dU96Z1hl?=
 =?utf-8?B?bWM3RGluTFdqSGN6NExPNW8wN080UjRKUWloMFlkOGZaa2pnSXB2TkRtcmZu?=
 =?utf-8?B?Z2JXY211alljRWI1Zk1KRlJ1SnhjcXM0cW5RVThkRGZpRXpqMHdjejlmWkR6?=
 =?utf-8?B?S04xZ0RBQ1J1RHpwUFFhbU8vSm5sM1QyUCsrV2NIbEF6VmpPaTRYNmxiYlVR?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QClZVKUdT2NdHVxHF+UYD/Zyg1oHUFJuCkWph1sTLDmyIydACgz9+uuJeUtWD+IV1yJNNWEqz1rCQffwCDQa+d184S1dpPmEFPJOuIMrzZNUguyJ1WHYFXMv/XwsH2uzjfu6bLNvIvazdXvpNItXUE73TikYo+5F6aAOnU1m7oWClvCQyf7Gzyx9z0sHa6bMpJoUJDW76sY4CzgPuOny7Q9PoZ4V94GnHX9Frzcgvp2a+AhOOHEqK16njSmud7sSPv56uYDG/vb5lgNqM7MsE4YdNagiekoN9KuEG2F8RlUzd0BPuwaEXCJOLTQ/7ONsKOZGpekeBMShI77ec+vqJvaCAbvnuo+lh8xG18r8gkfhA9Rcw3qfCfpmTYYvff1HkrVxhW6w1iBCMLm2CgW2P+lHBB50SWb7ZXv8DNKcvZakalihfuWib8gBVEoF5+/q67OWrajt5yKKuyPQIxVR4MSKLuQUJVsdGMiFvElf2N8cbRSeRt+IX5HxRVekGyOfYpweYeH6SSOw/PCExuvs8/IyYQOX+OGTrh82UoFR/1Ln1u35AZBVlDQ/ecty98DwSavfbUsOiHIQfRPbV2IaYPgMKo48uBuEckTc7J+1uYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d7776-aef7-44b4-8568-08de176d2d70
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 04:31:21.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH2MCxLZNGIJbmnEANNXnlVovJPP60ymi1ZmNXGWlqVnp4G+FFN1C26+oj4H1WVh50N7DCTVi/EEzHNfMFbseBpbZsn+0/8hWF3BRGcHFZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300034
X-Proofpoint-ORIG-GUID: SW2zGBzFVxiK47WkD2nLxbZ8u53BszdQ
X-Proofpoint-GUID: SW2zGBzFVxiK47WkD2nLxbZ8u53BszdQ
X-Authority-Analysis: v=2.4 cv=afxsXBot c=1 sm=1 tr=0 ts=6902ea1e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=1eEGUOzBzYLDoI95:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Us-1UMrJcrhWnadwEOMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 cc=ntf awl=host:13657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAxOSBTYWx0ZWRfXzBl4/8l4Opz9
 EP9+hfmOikpQDGc+kqkj/uV8rpJJEmnExsnJuQhUZgcLlLa+G8xlZt1aIVZZ34CRQtXO/hUk9b/
 /vY1wbF8Qi0f2wAYh1/BzUdAqmGk9bysG4kJ8G0sJzNmzF5i18UOQLNCdr9XdXw9hW7M61fL7pr
 9u0OL1mIJHhVWZdQFLh1OZhlo4yk95x4WK6hHVi1GhTuLOr9GzoIfXhUBpu1e7rfQtoI0iC/3sY
 kOgp3T9AsqtcF5b7qUePRNlgHREZQabMUl170FrZFlvFzT8F8D38vsV+tGx4wH5hQZ02qMhgw8i
 BuboXK47BM/v9t3MBLYLBtPmbNLsJgpSdqZ5sg0YiOsETeyI4t+Y4FBhPEqyh7QGNRGx0i0CBj5
 i4jjIdlSSKOCnwORSlkUiA3j/Pj142npUsTUjrVHWChJq6YvaEA=



On 10/29/2025 10:19 PM, Jakub Kicinski wrote:
> +def channels(cfg) -> None:
> +    """
> +    Twiddle channel counts in various combinations of parameters.
> +    We're only looking for driver adhering to the requested config
> +    if the config is accepted and crashes.

crashes.?

> +    """
> +    ehdr = {'header':{'dev-index': cfg.ifindex}}
> +    chans = cfg.eth.channels_get(ehdr)


Thanks,
Alok

