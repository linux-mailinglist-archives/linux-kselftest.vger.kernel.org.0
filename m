Return-Path: <linux-kselftest+bounces-26924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59303A3AF61
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 03:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC331893222
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 02:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073F7157A55;
	Wed, 19 Feb 2025 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iQyyarN1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SZIzHuiy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A90157487;
	Wed, 19 Feb 2025 02:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931223; cv=fail; b=V//osEJhgePDoXRNan32Jn4awDDBiU5byIsiYVFIjJ62avmcoXShhOUykHHWEO54v5OjYSBlXtr1CtRBxERB6Xkgypqxl21zgmRHONbq7eBRVjlzypYtWuWkX8cTXksHmm97VWEZsoM3PyUcTGpRhFdIFbwYsAVf0kGawnBX+MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931223; c=relaxed/simple;
	bh=d9OFWCmBFoJY5E5WTQWZxSsYs18wLdNq1qzuLymJVx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ifjKLSTE1/xufbYIAcpHSGoT26/SDfTp+upUeD6IdaK95+sV2ICbohoJleh9gnRcNUKIRdDHnZ0awpLHCVXH0n0aVUpH/vu6HA0ItOesIu26PCyKJYy2/RT8C3hPgQxMRw8BF1HdinJGqsfMMgerHvY1xOM/Qt67koY3S7Ry5FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iQyyarN1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SZIzHuiy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J1vJPF012334;
	Wed, 19 Feb 2025 02:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d9OFWCmBFoJY5E5WTQWZxSsYs18wLdNq1qzuLymJVx0=; b=
	iQyyarN1CJAwhXtsWt2lN0bZqGNnL8j11xkG1bW28ynJXwNQTvXbUJRdfBRqJzg0
	0PyvZz3ovZKdvZNHakd8/aMVgoXbaSTmy9K3nGKihzn+H1fYh6LJKA6xxfkJq8m7
	HaEHdHtv/04D/vioEPqZQSUmd6biamsrNaUgXhT46QeZ1fQFgyQFxLSNSNtFr9DF
	fjQNfdisFeg4NFIpfdEkzcPjNK0K1XGOl0Fp2lJeiCG8cn0kI6FO215dplZGpXes
	urlrLnjMKmFsK8IMlYTUcNacvkFq/S0isYx9zvKoo8UsYBCF2ITdtuvwe73hcsO7
	HztwB/GXpo74fKatbUukHA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00ngngc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 02:13:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51J0Ildm002257;
	Wed, 19 Feb 2025 02:13:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tk38av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 02:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJKQ76X1tmkNoMod2fW1toh8K79/Ez/S0zEfB70KEplefPFF5XdE7y3hySa49gW1mN/WABYK3n5zzRC+w7sO/EvqPjwBZvOHQdRTNt0G0C1dk6w1xYvGorLwmfrgNi+46mi1Ozy9PiWN1glq5/6rt8sDF82S17bB7E+7rvQ9EO7Zvv+Uk2KhtYZNmla+LQyXsWOzyNiaEqMy58kS05qLW1nc3niOHW2TAwuzbxTLw/xv1+yz4IVGE9YkTdeOPN75qgSoI9Ba0x2K3Snx+6Ho9AB4/W3dyIU9AoEW+eFP7dMCIKjKiAMsSTH5dBC2j3pXNasXsipaNYCeI3Qqh8oJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9OFWCmBFoJY5E5WTQWZxSsYs18wLdNq1qzuLymJVx0=;
 b=kgBYgpdNrRSta0pwimHVJ7D1namDSGq/mzE/6ibXmw1LM0ejfaPcGVoZpBnZS7WCoHaB/EeEpQ6F/P4EJakvbOYquXjlWr0oMScIfZDtCLkycqNcbu4qgIIE+Djr6cedgfTsymaWfDtRIM8ZRnKSmxkq4kNG4GYz9gFgx8hxyeUGY3Jin2vt4fHs83jgumzkcFY7vL6p4qXPXeNB0ltO4wE3Mdily3H8otDgVJs3OxzDuWDQVAcqNucJrG1i/RNCMdEqJ+9Nw61XHx65irwXGe1dz7wOhplVCZB0+mdncB3mF9plhIHYPx/vW3DPV7lfRbKl2UcaLQywiZwFoxwMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9OFWCmBFoJY5E5WTQWZxSsYs18wLdNq1qzuLymJVx0=;
 b=SZIzHuiy72d5BNuZ2nlDLaz54QldinZEcBJwUoHWdofrP7vf9DkhHDbDkuGl4zBZewCI8eCuxnuKBfJ9sGg8hX6C54CG8uyukH5grT0y3oWVcE8nS2bnFdjmVGV5fcrllFu4ZYRA/iVhIPtA6Y4l2VUBZtokuSDt3KeGdr05nO4=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 02:13:29 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 02:13:29 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "kevin.brodsky@arm.com"
	<kevin.brodsky@arm.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Thread-Topic: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Thread-Index: AQHbd1CzXVXDkvdxj0SWfa9FkUurILM4oICAgAhIQoCAAMP0AIABMAYAgAscUAA=
Date: Wed, 19 Feb 2025 02:13:29 +0000
Message-ID: <4FF4FFA8-1385-452D-9B44-D791B664D4E8@oracle.com>
References: <20250204214723.1991309-1-yifei.l.liu@oracle.com>
 <2025020544-preview-worshiper-8539@gregkh>
 <C8A5840D-B312-40DC-A75D-3BA14614F8C4@oracle.com>
 <2025021143-limes-babble-e137@gregkh>
 <1D84255C-D49A-4056-9299-B1E6099154DE@oracle.com>
In-Reply-To: <1D84255C-D49A-4056-9299-B1E6099154DE@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|DS7PR10MB5215:EE_
x-ms-office365-filtering-correlation-id: bef09ae0-7b47-4e06-1571-08dd508b006f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wlo0eThoc2xjbnFnZEh6a1hCdWJTVWRyOHVENllZR1VoaVJrWlJzbTcrUzc0?=
 =?utf-8?B?UE5pSHN5WnVnc2x6ekNNQXk1YUgzM2s3RFhaQThSeWZ1cWhXY085TzdjenVE?=
 =?utf-8?B?djJFUjF4ZGs2NnJBRS9tck1nL3k1NE1EQm1NbThwMXhjVjZsL1NOQXR1U2U0?=
 =?utf-8?B?bWVZMWlrNjZwbXR4K3RtS3F6a1dZVm45SHdpVVlNT25hN2tsa0M1YXF5VXNw?=
 =?utf-8?B?MkFFMjB2ZTdGNGxGVDhpeVN3bkxBdC9uL0V0anFGdWZSRmszQVp0Nk54Q0t2?=
 =?utf-8?B?OE43YUl3NUtsS29tYVNXNnhwUGR5N3JvditQTXhVN3k3T1o5aDkzdGVjVE5X?=
 =?utf-8?B?RXlYTWc4RFFDRWp2Z1Nyd1prdnJHNC94YzJXQkFmU1I0bVE2V05YdHlRZkFW?=
 =?utf-8?B?azRNNElKbDltNXBFcXNjOFhkVlZWNzN2VEVUVTN3WG11clRERmZCSzJQY2l3?=
 =?utf-8?B?N01hQjA2TnBCeVlkUnV3SDlOQlFYaFFDSkZucDl1ZFRVZ0tVV3BJS2RDTUU2?=
 =?utf-8?B?UzM1WVZmZGhVWDA2MWxYZ0U0TmtnOHcwWnA1YlhQVU5KOWRyNGwzeE1QTDd1?=
 =?utf-8?B?aktXRmNld25kZS9DdG1Pb0dNRmwxWWF3NGhTZW8vV1BtYmJIeUpXaW9qNUdl?=
 =?utf-8?B?Vm8xeWtXejFPcjdtcFhZQTV1TkpvMVozcFhJN08vaG9JUXpsckNoNnY1Z2sw?=
 =?utf-8?B?NU5PZXp5M0RVT0ZJZFJTdlR2aTEwZzJsTTV1LzhvaC9Kdjdkb3Y4R2RTWW9O?=
 =?utf-8?B?Y0FjRmlkTlJRajgvelFKbTQycDVaQXg0VmhSdHhaTTM2dTR6RjJnMERSK1U3?=
 =?utf-8?B?MVVCRWlGcndVTTR2VlZPbzkrZG9RdUxCV3JLMzFESWRtdFdWRGhVNzVsa2ox?=
 =?utf-8?B?ZnpCdXRsZzljTlpISnhKS0VKSEdqSno1d2FkWXB6Mk1HT2pCNW5BaFFEckZv?=
 =?utf-8?B?WHQ1amhnVlowK1JUTW1kdndXUXhNZTk2OW9OMkp0ZkRMVzlIbVZUNzdsK2hk?=
 =?utf-8?B?WGRnWExpVVVKc3psSS9oSEp4M2JpUnFESFVkbHRQZHNEKzQ5cDg2WHVJZmNt?=
 =?utf-8?B?em8rMVZoa0tRQ2trSGZsWTlKL1NidWhXWkNnM2dxcU1EeFpaTmZSZmVWZ1Rj?=
 =?utf-8?B?VHZBUVdGYUhQTUMrcjBpNmRWRXY0cEFYNzUwR2QyOHYxaHhhSExwYjFIeFF4?=
 =?utf-8?B?bFROaE9MWkxpVW9XT2daV2J3S1JqTTlZKzFrM2tuRmN4b25LQkhtV2wrcTM3?=
 =?utf-8?B?ZzNTOGZsYUtWZDBENlo0ZHY2NHBXbGJqV1U2R01EVlZ3U1VHNW9wS0QzOHhr?=
 =?utf-8?B?MW5ZMnBWTS95VzhyQWpQZWhIeHpWMHdINWY3NUNKMUJBVklhNHBvM2g4VGxG?=
 =?utf-8?B?UUFTK1pERnhYeFNmaU1SSWNMaFRhZXE4NDF2MmFtL1BMaGQzWUNVVVE0Nlda?=
 =?utf-8?B?bDkzUGxFVlh1R0lOQ014TEVxbEhNZENVclU1Yk11Kys5T0hUMlBVV0pYanNB?=
 =?utf-8?B?aHZvUlI3MjZUaUZJbDdBdVJNeEZZRllkVGQ4VEdHMXZSYlpOQ1hFTFYyRTV4?=
 =?utf-8?B?Y0ZWSVFXRHYrckJaSmFlSFh1VWhTUnBYSG1vckxFRWJuRHJ6WVl0M2JzUnZ1?=
 =?utf-8?B?TGM5ZDY0VXBZL1BKeGNvd005QkRBcVl5U3JidEQxeGdTVjIyeGJuT2RjNXY4?=
 =?utf-8?B?dm5TQWFvSnBpMFVYOFZiVjZjZXRQQ24rcjFGSHVWNkpkK1RGV3pKUThNVVZJ?=
 =?utf-8?B?a1JPQ0JxQ0tHc21hQStmeExsZEh0UUdjN3Y5Z20zSG15N2RwQ2trSnh5SXBZ?=
 =?utf-8?B?OE1KZExReitLaFAyWHBvNFZYS1BWbFBkTUpwaUVNQ2ZYU3paN2F1a09iMmMz?=
 =?utf-8?Q?A5QuPBBq94e44?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0M4YWM5dFQzZkE0NHozMENrcmRhb1RpYllaOVNTR3VsVkFyU3lnQjZZQjgw?=
 =?utf-8?B?OVZ0Q0hDWW9XMmR6TWZpbjlMTkVoeEVyVExaMnRMbzk0NHpmRE94VHFEenQ4?=
 =?utf-8?B?MDQ5ZFJPcUUrMEI4R3Irend1a3FzZm9BcUVJZndhdFlOcXJnSXphVWVUNGZj?=
 =?utf-8?B?T2ZVcVRVWlpxVWpmOGsxOC9jc1lWV2J2ejh6S0Z6Z2xyUFNtaFZ1UVNWV1hu?=
 =?utf-8?B?Zm1yTW1qSHVDK1BsazFMeCtDejNZQ1lPUmxOSjVvck8rNFRBRVcxWnltRklU?=
 =?utf-8?B?cG91dHFJaU9UbDBXdzVwZDNPc2dkS1h1RVRiOEJJcFZQNk9XNjllUGlGQ1hv?=
 =?utf-8?B?MzZjNGZDNG53b0F6OU4zV1oydzluKzJzVTVPVHhTbERUTjNQbDFtekxhK1lh?=
 =?utf-8?B?WjVGeHM0eXpkUGtWbGxRemZtY0MvcHZ0UHgxT3pBdVdsK0RieXBYdC90cWdV?=
 =?utf-8?B?V0REZ0piZ3gzUzIwbzZ1bm1OdUNjZWR2NEwwU09UZmlXbERTVk53bWp3Q2lk?=
 =?utf-8?B?ZG1Dc2hoSmdlUWxBSmZzTHY1b1FJQ1NOelFwRkM3T2l5UUN0MEpJWVJRb0tM?=
 =?utf-8?B?TTJtRUpNVUVxRjhVUFFKYlMzMitlSzJiN3VFOEdpbWpSWmU0YlhYZEg0VjFQ?=
 =?utf-8?B?a2tWaXdHODFwd0t0SkkxRTlpdEZ5WVR3cThBcDlRZDVHcmxZZFVRc0tRK2xo?=
 =?utf-8?B?ZWwyWSs3VDdYc2ExeFd2bTh2a0puTWdEM0xmVW1iOHBQL1ZCUGNkZzFOSXRU?=
 =?utf-8?B?cSt0NGgrSFovQlRnbWxpRnRJZ29iRjFJRnlJUmZUQnhzaEpySHJrdlE3N0ZN?=
 =?utf-8?B?aWhuVHZGd3pXaEdScnNXS2RwcGEzN3hxbjF4MS9OWkpOWDVSNCtFVXp3RU96?=
 =?utf-8?B?ZUhuM3pqdmV5WXUwMFowc2FHazJoYk83RmZ0TFp6NTFDZzFZQUFPRHBLNlpT?=
 =?utf-8?B?N2RkVmo1b1dmMnJPNG9SVTRtUWg3d29rRWtvdE1ZNjd1RDZmSmhxSmlMaHBa?=
 =?utf-8?B?SXBUK1JRcG9rKy9oa2FiWUlRem45cTZ0SzAvWmthdU0wZmU0eG94KzZadGRx?=
 =?utf-8?B?L1dkR3hhdzJjRWJPM0kwanB0aDB1MTZpam41Yit0Znl0WHlyRU01NmhPSnJj?=
 =?utf-8?B?a213WjQ3OGhjbVlXOVlzWTh4dXg2b1NvTm4zUnJJOUFtMUo1aThNYWNoUTJp?=
 =?utf-8?B?LzVJRzZRVkphVklVanAwTHRCZUltOUh0d0pPS1NyYk5XY3lCbEt4RnQ0MUVt?=
 =?utf-8?B?MlI4dXozMC9kdkZxbEt6Y0NzaW9YbURCZmo5RUdJVHZEYmNFY0x5TlRoWEox?=
 =?utf-8?B?QU1KUFdFWVFLSjdxVW5aeUx6eUhaTEpQRk5CZzY2aWlyMzVVeWZMN2h5VkM3?=
 =?utf-8?B?U2liYW83L0tMRWhwb3BYWTFnRDh2YlU3VlJlY041M3M0cWQ3L0trTnRnU2lz?=
 =?utf-8?B?YWhQT1cwWnArbzRVVE96dkpzbDF2T0kzanNhd000T05zZElLUTBBYmV0VXlj?=
 =?utf-8?B?eVZIQVMwR1lmSWY0Wkd6aGNMSHptRzl5WnZiT3ZIUHFrSS81SFo4VE85T1pn?=
 =?utf-8?B?UEswc3BtdkE3dlFXUlhVUzI4akF0U05Jb1FLOUM3SVJYaHc4M2ErS2duUWdq?=
 =?utf-8?B?TFg3N3hJMlhIMmZsN29MSy9qRHFkZ3FIREVwNkp4Yy80NW1GS21YcXdxYXE0?=
 =?utf-8?B?Q2VtZkNkVzlDcjU2OVhOcXk4VnREWXlKR0xkaFFJZ3FSdmtrSmE4Zm1SaHF5?=
 =?utf-8?B?emhQMWprNHQrZkM5L0Nsb2lsaXRtbGRCN1V6ZEI3QUhPamU2RlZFaU5oM3U2?=
 =?utf-8?B?RHJjM2ZqQm0ydHNyQlgwVDkwZnRuOEpkYjdFZjJtRzBlbSs1QzVEWWlPVnBZ?=
 =?utf-8?B?Tk1iR3JMRDBiQlRYSXQ2REIwbmpxQnFTZllzYXp2SmNSY0QyZHZodmJwd3lk?=
 =?utf-8?B?b0lMOGVzTTMxZDgyR2o4M0RvTmxGL0JoWGFhMzFVeWlVYlFmMy8rYW4vQU1U?=
 =?utf-8?B?MjNQdlZyVE9rYXlDRlBXUk5WMEFKeWxYQzU4YkxsYjFSa2pQVXExRXgxSnVq?=
 =?utf-8?B?K1hXWFFFdnphQVRUREpUZ1cxQzhXRUJhYnNIaVBHQVVYZno3Skg3cVZUTDhZ?=
 =?utf-8?B?eXY2djU2YWZ0REhYQXVERFYxUjdNSVBGK0tNWG5xeDRnME9HM1lvanRLaDZL?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D1521AC0187E847BB15B31776DAD93D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OVaaIPhpI4/QD1pMtGAV+by0RPacdm/1LFk7RGR9zUH9/CsH1syHu9b2uRwfaTQDmr1LEDHiEJCLcx/rc/0SMG0PDNnUgw16g0K25pzis93UYcIamLPIdGKHwQocJzbuUnt5wSc4uQHLpyI0lV9Xzb9ZUw2k1bwnuKmoiclBtM4WNldMWxiut71D7Bke3JjHOo8DATKsC1BlQj7Ol54NyB0eWR3BWfRQkPVM+qjtH+66A0piAdQ5gGo5H+302ZS1LpYM0uWK41xxRpspQKpzKGxZ0YUqur/cxsm7qaOTS+v4I7xAiAcqd5i0raIuAL5nAVp/bPeAASHpMP33phFCoIDYvtewCccVgooi4sC3WwXsHVZKdH5OdqsPb0qBUi4bfdhqeRRfMlY4p/jOwKS+SmjoH0JJ04RbEd9Zer/CxSaa+i72cCvx+FtdsJ2ksV1h76Qs8LQ2wxciG3bGEdqtgUBjG+12BhYp+OYs3ZQf7oOmwkyTGLw7/jQ7g2Bha54oKEg7GUhOaLqO3PDcvYpuEg656XLRQSzPRlYgVXko4IS8cs7O2D1CAHMu2DQu1jVXSJ2SLVFhrAAdnK106EDyZlh0xMIzvq6Wpi00nGx7FZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef09ae0-7b47-4e06-1571-08dd508b006f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 02:13:29.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbBdR+oKxQlFWrOZtqP+sFo7Z2nWiCZslgpC941zTxfUiC7zV256aKBaqMohZXocZwoL+Wu+R/fbop77Ajajsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_01,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190016
X-Proofpoint-ORIG-GUID: JBOe_G7o0yQYrciGVM_y3vz40otkWu0p
X-Proofpoint-GUID: JBOe_G7o0yQYrciGVM_y3vz40otkWu0p

DQoNCj4gT24gRmViIDExLCAyMDI1LCBhdCA0OjMz4oCvUE0sIFlpZmVpIExpdSA8eWlmZWkubC5s
aXVAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBGZWIgMTAsIDIwMjUsIGF0
IDEwOjI04oCvUE0sIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToN
Cj4+IA0KPj4gQTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9lbi53aWtpcGVk
aWEub3JnL3dpa2kvVG9wX3Bvc3RfXzshIUFDV1Y1TjlNMlJWOTloUSFJNk8wRWNCWU11bjV6eTdw
SzM5Wkc5YUpZcmJ2M1V5N0lhSllsLWZLT1hKZm1JbUJiemZYREZmT1dlWVkybzFKdXRIUEJvQW9J
X2I3eEpReWpRNW5uZmd2JCANCj4+IFE6IFdlcmUgZG8gSSBmaW5kIGluZm8gYWJvdXQgdGhpcyB0
aGluZyBjYWxsZWQgdG9wLXBvc3Rpbmc/DQo+PiBBOiBCZWNhdXNlIGl0IG1lc3NlcyB1cCB0aGUg
b3JkZXIgaW4gd2hpY2ggcGVvcGxlIG5vcm1hbGx5IHJlYWQgdGV4dC4NCj4+IFE6IFdoeSBpcyB0
b3AtcG9zdGluZyBzdWNoIGEgYmFkIHRoaW5nPw0KPj4gQTogVG9wLXBvc3RpbmcuDQo+PiBROiBX
aGF0IGlzIHRoZSBtb3N0IGFubm95aW5nIHRoaW5nIGluIGUtbWFpbD8NCj4+IA0KPj4gQTogTm8u
DQo+PiBROiBTaG91bGQgSSBpbmNsdWRlIHF1b3RhdGlvbnMgYWZ0ZXIgbXkgcmVwbHk/DQo+PiAN
Cj4gSGkgR3JlZywNCj4gU29ycnkgZm9yIHRoZSB0b3AtcG9zdGluZy4gSSB3aWxsIG5vdCBkbyB0
aGF0IGFueSBtb3JlLiANCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGFy
aW5nZmlyZWJhbGwubmV0LzIwMDcvMDcvb25fdG9wX187ISFBQ1dWNU45TTJSVjk5aFEhSTZPMEVj
QllNdW41enk3cEszOVpHOWFKWXJidjNVeTdJYUpZbC1mS09YSmZtSW1CYnpmWERGZk9XZVlZMm8x
SnV0SFBCb0FvSV9iN3hKUXlqYW5TTk9oeiQNCj4+IA0KPj4gT24gTW9uLCBGZWIgMTAsIDIwMjUg
YXQgMDY6NDM6NDlQTSArMDAwMCwgWWlmZWkgTGl1IHdyb3RlOg0KPj4+IEhpIEdyZWcsIA0KPj4+
IFllcywgbG9va3Mgd2Ugb25seSBuZWVkIHRoaXMgZm9yIGxpbnV4LTYuMTIueS4gTWF5YmUgd2Ug
Y291bGQgdXNlIHRoZSB2MSB2ZXJzaW9uIHdoaWNoIGRvZXMgbm90IGluY2x1ZGUgdGhlIGxpbnV4
LTYuMTMueSB0YWcuIE9yIEkgY2FuIHNlbmQgYSB2MyB3aXRoIHRoZSBsaW51eC02LjEyLnkgb25s
eS4NCj4+IA0KPj4gQXMgeW91IGtub3csIHdlIGNhbid0IHRha2UgcGF0Y2hlcyBmb3Igb25seSBv
bGRlciBrZXJuZWxzIGFuZCBub3QgbmV3ZXINCj4+IG9uZXMuICBQbGVhc2Ugc3VibWl0IHRoZW0g
Zm9yIGFsbCByZWxldmFudCBicmFuY2hlcywgQU5EIHRlc3QgeW91cg0KPj4gcGF0Y2hlcyBiZWZv
cmUgeW91IHN1Ym1pdCB0aGVtIHNvIHRoYXQgdGhleSBkb24ndCBmYWlsIG9uIG91ciBzaWRlLCBh
cw0KPj4gdGhhdCBqdXN0IHdhc3RlcyBvdXIgZW5lcmd5IDooDQo+IEZvciB0aGlzIHBhdGNoLCBJ
IGJlbGlldmUgaXQgZmFpbGVkIHRvIGFwcGx5IHRvIGxpbnV4LTYuMTMgZHVlIHRvIGFub3RoZXIg
c2FtZSBwYXRjaCBhcHBsaWVkIGJlZm9yZSBpdC4gQ29tbWl0IGQ5ZWI1YTFlNzZmNSAoInNlbGZ0
ZXN0cy9tbTogYnVpbGQgd2l0aCAtTzLigJ0pIGdvZXMgaW50byBsaW51eC02LjEzIHdpdGggdGFn
IHY2LjEzLjIsIGxhc3Qgd2Vla+KAmXMgdGFnLiBJIGNoZWNrZWQgdGhlIHF1ZXVlLTYuMTIgYW5k
IGRvIG5vdCBzZWUgdGhpcyBwYXRjaCB5ZXQgZm9yIHY2LjEyLiBJIHRoaW5rIHdlIHN0aWxsIG5l
ZWQgdGhpcyBmb3IgdjYuMTIuIEFib3V0IHRoZSBwYXRjaCwgaXQgZml4ZXMgYSBidWlsZCBpc3N1
ZSBmb3Igc2VsZnRlc3QvbW0sIHdoaWNoIGlzIGJhY3BvcnRlZCB0byB2Ni4xMi4gVGh1cyB0aGlz
IHBhdGNoIHNob3VsZCBvbmx5IGJlIGJhY2twb3J0ZWQgdG8gdjYuMTIuDQo+IA0KPiBJIHRlc3Rl
ZCBpdCBvbiBteSBkZXZpY2UgYW5kIGl0IHdvcmtzIGZpbmUgYW5kIHNvbHZlZCB0aGUgZmFpbHVy
ZSBvZiBzZWxmdGVzdC4NCj4gDQpIaSBHcmVnLCANCg0KSSBjaGVja2VkIHRoZSB2Ni4xMi4xNiB0
YWcgcmVsZWFzZWQgbGFzdCBGcmlkYXkuIEl0IGRvZXMgbm90IGNvbnRhaW4gdGhpcyBwYXRjaC4g
SXQgbG9va3Mgd2Ugd2lsbCBub3Qgc2VlIHRoZSBzYW1lIHNpdHVhdGlvbiB3ZSBoYXZlIGZvciB2
Ni4xMyBsaWtlIEkgbWVudGlvbmVkIGFib3ZlIGFuZCBpdOKAmXMgc2FmZSB0byBpbmNsdWRlIHRo
aXMgaW4gdjYuMTIuIA0KDQpJIGNvdWxkIHJlc2VuZCBhIHYzIHdpdGggYWxsIHRoZSBsaW51eC02
LjEzLnkgdGFncyByZW1vdmVkIGlmIHlvdSB3YW50LiANClRoYW5rIHlvdQ0KWWlmZWkNCj4gVGhh
bmsgeW91DQo+IFlpZmVpDQo+PiANCj4+IHRoYW5rcywNCj4+IA0KPj4gZ3JlZyBrLWgNCg0KDQo=

