Return-Path: <linux-kselftest+bounces-27142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A77A3EF99
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41BC1890AFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBEA202C23;
	Fri, 21 Feb 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eB2VELwU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GJHysEom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41977F9D9;
	Fri, 21 Feb 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128987; cv=fail; b=G1O4zG+kuMKQpAWYi0haERgGCjjmdPiX0hVgYhbzlgGSW1/TqVWeq69CaPTE7Ui4+mEEL/Wx5lNY72nIWoGPLI8CJkoYI+fy8i59WsxZPLqO0I7ETbrJ2Y9Q/Zge9w1RVTis3iOOLySdFHUKY4qC3k57mCBZSre2t5+PzAzm0+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128987; c=relaxed/simple;
	bh=GJUy/JWYAfVnwWufPUnlcElhrGZGr2GKpKzOAY3HZBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jZtGd+0EhmDmJGqdNAGUKO7grldxBWJUM+Wdaaf2pBXxwxGpbdmCYVDJGAJ+AjyaMziauo+23llCQj0jhDz/D580XKvPTNL+iB02brr2cuFjO0SWp2NiwI8d8nt6Gpny4cqPN8KhXRpequgrHdCfMqfJ5oX3z8wOEIPma4lll+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eB2VELwU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GJHysEom; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8flmN001571;
	Fri, 21 Feb 2025 09:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9WCiUfOuCITn7WcDWuRRGB/5PAb5Iie96DMbPlvQlGs=; b=
	eB2VELwUvEPnMvwm/dXkdnTWTiQNN3ZTlcGZcQbaIGUu9bVzo0W55FnT39zmLC+F
	oXPY5ahyuwjR4JhAlJhygQdZg9V1OfcDHY2esUuBACI4D5mC1loZ0f1p/oiyhY17
	gMdjf6VtJHXwOWvapJnDqO9MfeYB0RoOY2aDTyeQQlme8iCH7wezJ7WbGxoYNuKk
	aGCNIpivkHPBn4YCRwHYg4vCyVsesJrimdYVnSiorssCMr5OYA2BqOb2Xncd9OBu
	XIVQpQ6hbMJbZFlobK4MXTV3rfugeC5S4QnbF0qpAfILhkX2L5bdR6sCZE8hKkJ3
	uZGlR24z8e/mDI4nWn5mNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02ynvyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 09:09:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51L99P5E002077;
	Fri, 21 Feb 2025 09:09:39 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tphkyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 09:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnjTaIm9MOIJFy0NROUlC0qwvBic+i5oOu+I97fT8YskZcRKuc+ZAeK2DRNUfuDCjgIAFuva768lcLovJgkofIdBkYtuxm3tw5kbnWlG4WQJcFoPrsHXtBHJxKSU9SGI6PRG80aNOV0o02u7j5GV3En0ZUGfXi2blNyhHJ94fmQfRBGYznT2qtPr8Z7lk1DEYa23/x9pou+bzKWEU5+G4WFvVM2lfkOJO5SQ+1SimHN8MI2HmogKeePYnsb1GBEkx6Q8WAoy9bGIa9PwTzSFsfBcaPewFB/lS8yjNmzVBGukzPWZghbXbOpyatzzwvB8ROvp8f4RdwVLhqxnDVOHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WCiUfOuCITn7WcDWuRRGB/5PAb5Iie96DMbPlvQlGs=;
 b=qvlx9XnBi/o8ZRopedalAqsQuG2VFxPFALlL2e+qubwvjKtVxcIxAWXnH2EaX5V8tC9rTexvFu2m3vBK2QzRFAC8gYh4wCZ1AIwV0ospYQPXiGCcAkx30MnGQEW/oiKQQi34n57p3UXEmUqErnP1WTQKKph20e4piHDptNTf51VyHxOOEaFFO3iGVHeAGuYo1qP6157XTP1Ywd75W/rHVMEx9l0b5WZvyOIUSbDfmy6EC1HZKCctEWZ2n7jLI2QzkZtr0jscZV7lsV9QEABkal3JzDnHl9U8btyyCK3o2ED6SBEbeF8d3G1odszMF638B+uajio3hOBdamtrbPxWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WCiUfOuCITn7WcDWuRRGB/5PAb5Iie96DMbPlvQlGs=;
 b=GJHysEom3Y3HgfvBhtZ1d9YED4ip3+qQzpziik+Fb6JniejGPiEdgBqOT1wC7ReO8BOZufAFcx0gktK4rxWg/BbN9YSdt3W0yHqsABRvDFRCSel1m862tkqB5z8gHM+TSTATU4SJvtOCNLXRPvgHYFhp3uiOsGkfB812SVs42TU=
Received: from CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22)
 by DM6PR10MB4316.namprd10.prod.outlook.com (2603:10b6:5:21d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 09:09:38 +0000
Received: from CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e]) by CH3PR10MB7211.namprd10.prod.outlook.com
 ([fe80::4c63:cc47:6a4:e38e%5]) with mapi id 15.20.8445.019; Fri, 21 Feb 2025
 09:09:38 +0000
Message-ID: <058cd52f-aa5d-477b-83d0-3745fc9f70c5@oracle.com>
Date: Fri, 21 Feb 2025 14:39:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
To: Chris Hyser <chris.hyser@oracle.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
References: <20250219064658.449069-1-sinadin.shan@oracle.com>
 <74dddd26-4a0e-4bb6-958a-229cca3c24d1@linux.ibm.com>
 <a3b5bbc0-f875-451f-8528-38a7eafc4949@oracle.com>
 <CO1PR10MB4705883FED10DAE126DEC9D59BC42@CO1PR10MB4705.namprd10.prod.outlook.com>
 <0d22f89a-d896-44ed-b4a9-c860c63450fa@oracle.com>
 <CO1PR10MB47051B268FCBD44E24B281439BC72@CO1PR10MB4705.namprd10.prod.outlook.com>
 <CO1PR10MB470557AF5FC26790CB8FB2FE9BC72@CO1PR10MB4705.namprd10.prod.outlook.com>
Content-Language: en-US
From: Shan <sinadin.shan@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CO1PR10MB470557AF5FC26790CB8FB2FE9BC72@CO1PR10MB4705.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7211:EE_|DM6PR10MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be1dbdc-94e3-4a9c-b9f0-08dd5257777d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG5hOGpHY291V2dRVEV0WFJ5ZkNmRG9JT3orSHlJVElVUmJhd05IL29HNndP?=
 =?utf-8?B?cXBsNWtTWlFQL0lwVUllVHVqYklNS0tDVUx5amxqWTdaV0xHbXptQ0tMK3FI?=
 =?utf-8?B?czdzYTlFVks3M1RwSnUwdExsK0pnMGhxV3E1MytMTUxuRmZDRmZobmlhdkhO?=
 =?utf-8?B?UTZSeUthUGFhNEN6SDUzL1J0ekp6S2hkaWJ5SnhNTU9Fb2kwRTJIRkdWMVAr?=
 =?utf-8?B?TjRwcS9KL1lmNTlKTldrTkxaUGpUV3puY3Y2WUhxSDBUMXlnZm56U29hb3g1?=
 =?utf-8?B?amlrYjVtT3hFalRHek5uRzNWZC94Si9LUENjbGhSZ1FYL3hXaUk4cEwzOXcz?=
 =?utf-8?B?dXhZZjEzNFk2UnBSRlRDTUV6NzV3Uno0WkYzUFZRbUNLU3VtMGVBMUIzVVVQ?=
 =?utf-8?B?MVhITUFQdERLcGRmcmRhdks5NVFlb3pRN3RSQzV2amZMVFBTenVxenNpY1U4?=
 =?utf-8?B?bU1na0ZLUXFxV3ltNk5nT1F5QnNnaFlPblgvenArM2wrVUdBSEd2SEJQVFFH?=
 =?utf-8?B?OFNLZjAwdXc0Z3VvZGUxTHNpdFRnNm9EbmVMOFpQQVFHZVVpdWZSbTNIWkN4?=
 =?utf-8?B?b1NQUHNNczhINXNweDl5RWt1L1p0cDhqc1NlQVhaSlU5V1lXY3ZmQmZVb2I5?=
 =?utf-8?B?ZEd3NmNaQklNS0FtZXVqMngwK0psTGQ4WjFPQmI1ZkE3SCtLZzdVbCtXczdY?=
 =?utf-8?B?WFhBUFJjODdMbG1sZ3UzSTJGdjRDeFROVUl1S3RXSm9zb3hPVGNWR2RQQmxr?=
 =?utf-8?B?a1lERUtsS3p6NVZGVEU3eTZDclRoZ0pTMS9Ec1QvRzdoemg0S0xJU2RrNmNK?=
 =?utf-8?B?QXRTWHFOSG9sMS9TVkUvYk9KbkNTQ0FqMFBQdW40WmhCTmY4YldjdHQrMlFY?=
 =?utf-8?B?VUNIeTJRemx6U1ZHa3dBMWNueHQ1SVZVTDZ4cnIyRTA3anlKVlZZRkxjT3dE?=
 =?utf-8?B?bXFMMWlqSmQ2SjV6QlFNYklId0ZLMUg4WnoyZDdQR29mM3lvQ1JhOVhJK0pj?=
 =?utf-8?B?N2lPclBSMHE0bW83RTFhdXlJVFRpUHlVSE5VV052NFI4cUQ5dGdPMHlWOHJ3?=
 =?utf-8?B?WnFGMkViK2JZQml4VVE5UVN1S2gvL1grUkpaeEVtQzRwS0QrL0luVkU4VWVa?=
 =?utf-8?B?ZVNPSlVObnV3Q3lodEhQMU1sQjdVOWx5SURXV2s0QkxTOTVJeEN5Y0tqRFJi?=
 =?utf-8?B?U3lPb0kzRms5eFcwWnl3WnV3RnBoZmFsa2ZUb1FseVdxeU45NmpXYk9tbW5x?=
 =?utf-8?B?NkdFTmtwcVZjdUtYTkIzRW1Fc0VFOEdEK2tIaWd5Rzl2ci90VUJHdHpWZGxW?=
 =?utf-8?B?MWZ1T3JZcFEvVVNzOGcxWjVCcEM5czhRUUZLUzVwamZxVlhYVWh2SEg1RHlG?=
 =?utf-8?B?cllIQk1hS2RGVjdSWW8rc2Q3a05oMWJnWVJuR2FyTmtlZXowaW5yNE1JKzFr?=
 =?utf-8?B?SktpclQzZE11ZUFvc2kyZUNyZ0d0aU9WMDN3R2UxTjlhOU0wVWxEYnF5elBr?=
 =?utf-8?B?b2MrUExKQmR0RXRUZkhIV0lnWEthbmE5Y1hnOEJxWE1TV3R3bU4yMWtXK0V1?=
 =?utf-8?B?VmxVeVFLSml1Q0k4dS9qZjM3cDVoU1k0Qk1tekEyaHd3TjR4ckNrRVZGdkdS?=
 =?utf-8?B?bTgxUXhOK0tycTFIYzlXM3JvZmMxdG1rcDRHZCt2dHlKVndqNWNwQ2Vlek84?=
 =?utf-8?B?YUZtZHBsM2dVaitncVJMUFNSNG5BcHpOYWR2UUI1U1J0L2RqRkxjcTNhbjlt?=
 =?utf-8?B?N0pkNEZwZ1l0anFjRWlEbW5RS1djVTdRdTZEVmxPOU1xb1FLWUgvdEJjSVJr?=
 =?utf-8?B?cHpyaEtIZnRhNXc2Ym9zMk1tbktuZXIzVFZDaTJHL3lwbkhBWkY0Mld1dklP?=
 =?utf-8?Q?VSXd6DhFLOWHB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7211.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9WemFock9KemN5YWx5ZmpTeHV6Um1MU3V2dFA4OG95cytlVXlzdlZMVk1u?=
 =?utf-8?B?S0hKaUI2ZlgyYVAvOE12V1ZEK0cybmpRSmxhb3pDa2oyMC93RlFpd2llRUda?=
 =?utf-8?B?N1RPUUF5WVN0ZjE2SGh0UytTMFI5S0tockgxTURYUXNjbnhQUWV3b1ZuT3V6?=
 =?utf-8?B?bmp2d0wvY0NZVC92UzlMK3pKTFVSNWxKckRhZlA2RlA4RVJYZGZQVGRGK21W?=
 =?utf-8?B?VXpLRUorQnlTRG5pajZpdDNHWkxtbXd1Mk9wdXdQM2h0Y2dMNmMzSXNIbTkw?=
 =?utf-8?B?YzNhVzVkS2lTUEU0OFFqdmpCbGUwQS81Y1N5UjlvY0h1R3MxZndPNENVNXhz?=
 =?utf-8?B?NnphbkRxWXRTMVpXamRDaDVoQktkSEo3RG4zVlBLUlg0NDN3WjdMWVVhb2Vp?=
 =?utf-8?B?dW5sZlBsRk5TOGNKazcrZ0Q0b3c2R0U4UGp0aFdYY1VUZHRHM0R4Y1BQZFBa?=
 =?utf-8?B?U2p5NC9WcDdyUkIwc3FOUXltSFpodXdiYWhmSzd5ZGZ1aFdYazk1ZndrRUtV?=
 =?utf-8?B?amF4aWZjMG9sQ1c1Zk5XbTMxUnVlWmlaMUpVOGMxT3BIQmZMV1FYL0VUaUxT?=
 =?utf-8?B?RTJIVTkwaC90QWxEUWxXMUUxNDcyVmpkUVJrZVBPR1FmT1BGVHpETFo3Y295?=
 =?utf-8?B?U0drS1Y1S2xWNGFpdENkUnFmSDZiZDBOZlpDMm1XdkpRWTV2NzZwZzhKQ05z?=
 =?utf-8?B?WDBtbjlDd3VobC9JUm5SakVnczBuZWRLSTVzNEdXdTl2b0lTOFVENmFISlJ0?=
 =?utf-8?B?VjhrRnM3ZndkUDJEMkl4K0dxdkVVWTNvYVg3UW40dTNURnJqSEF2NWYwbnE0?=
 =?utf-8?B?K203WmNLdzhjdyt4R0FRRFByNE5nZkYrMzZRL1FIYndnNlNrZUdyYkM1Z0Qx?=
 =?utf-8?B?Y2JuK0x6TklMK1J0SzlLVHNwakR0NkZJbjZGSlVlRHdOSndiQTFTVHMwZGxO?=
 =?utf-8?B?RWRRLytnRjhFMXVWMDNDODlUNE56clFIQTVXY2lWWVNLMFc5TnFjNW1mbFZB?=
 =?utf-8?B?dDlqaml0UzE1RDNOWFlONUxhMmplaHdZRkJ6RndKVzNlUUl0NnFqKzNjaDFR?=
 =?utf-8?B?VmczazI1b1NQcUx5dDJSSkhFN1FiRkVMUXR0SFlkWURpejJkZFl1UjVrWWZR?=
 =?utf-8?B?QThTSHN3dFdCelBzU3I2eHF3K0dSQnFyOGFFMzdsYWk0aXdkK2ZvTXlCRmc0?=
 =?utf-8?B?bURyd0VvZFd1MmZtZ2kwRm9Rek02N3REUlhuT0RmSk90c3Jjdy9CUmhsVzB2?=
 =?utf-8?B?ZkJ4UzVvV3N1WUp0MmdMeFJxaGxpWThzNXRUd3NlMytRQ0hSbTIxL0Z4ZU4v?=
 =?utf-8?B?ejNPdlI1TmZDTEtDdkNLT09TejlHUUhFbnpTSkh4eHFJeG9rdEZyb0dSTUI3?=
 =?utf-8?B?WmxPZXdLS0tJSmZUSHVhbVFvbnpZRzYvNTZ5L2poSThmMGZGa3VsQzR2aG92?=
 =?utf-8?B?SWhiZmc3dzBtQW1yblJiZWtVM3pQSlRFYWhCKzJZVmQzdmtmQnZ5Yi9Dd0dk?=
 =?utf-8?B?dndjNzhCeTdGOEhtcTRxa3o0d2kyNEo2R3UzUFhlS0dSSWxNd1FrZG9TV3RB?=
 =?utf-8?B?aERIYkFDQ0Roc3JldDNzZWhwTTJCNDhza0ZDQzgxK1RDK3RYTzRhbEtmTjFh?=
 =?utf-8?B?MWQvWjI3c1BxWitFYmR3T1JiSEt6TW1RR3ZBTlNrUEVMRUY5SW5KeFh5Q3NW?=
 =?utf-8?B?NDZIdEs5V1BmVExmRmFDR1prL0xITjV1ZkhCMzBYWUxKVUNhbDhFakIwRklJ?=
 =?utf-8?B?THRSZHVac2NSYUg3aXZvRG9JeDNtUE1aODFLQzcyNGhjdW12Q0xUQmFKT1kr?=
 =?utf-8?B?Yk1HcHBXdFRRYW53MEhiRFRYRUlSZ0R3eFFqa2RFL3ByZGt2VnB4YlRCSHUx?=
 =?utf-8?B?SDNZSmlJd0UvNWxvN1FGMFZqOGNNTDdaU1pydFlKTEVvMEtURnUra1luUVAy?=
 =?utf-8?B?by9aSUdPU3R5a0xIN0FzaFhFdkk1eXVWU0QyMkNpL0NnUTVobWx5MmQ4TmFa?=
 =?utf-8?B?VGVaaFk1a0xhYjBYeXNVOUxZbzJTM2QvZkJ6dmZ3cWpReFdjQTVkTzgrbGRJ?=
 =?utf-8?B?aVladnNPSHhML1JpZ1lLRTJybDdSck9yWWxpSHNPTWNiNURjV1B6QS9XYXhx?=
 =?utf-8?B?REo5bUNsQ0ZEL1dWQStGZXFjSDlKejJjcHp3WFVzQkRFRzExcWtQRTNYUHN1?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y/naW1mQN4SVPTvv2N5r5C9Qj1cVTkR8RJvL2oi79xx7JePnWuvvHmRttG1UzIiM4ZAwRFh1a7x1ZnsL4oQfO67hswHrnHFKjX20V6R31N0L/mAJ/O8fWHRR2wQFZKDJ0kn2x8i5CJkd9Do13d455gSZpJ3i4Z6t0Wn/yLG34Bpe3nQFOjmbwzhzW1JKVFZYsbICJat67ZRQc1/cWoGaeIhAzaDRyh2/thZyt7ZL+vqs8+IfWH7PvBMnmOQJ2nLJ8h0XoNScjDD+ySyKQuf/oRLRdKNARXrguJ1ARo2TIiuDRxEv4nLcToHxutg/hcarbSxhJSCXubONQYuRTu0HtkimARgiHs7pytc7py1nh3huCkkn78OvK5hb1CR9eXAyHO+gRA+3ppOgi0w4yr/mlTIr0UaveARwj7JQLGyVpf+Cbe5hYrjXdeUsORQt/02SIk9V0Gdhq/SMdhJPkDHXYRNYpaX8irm7bnHio0339AZZdxNbBbpPRmXq/1Bi+e3iBBNMg1cOsTlWZ8wnzLYlU4C6u3meX7XZTq/oUqDL/PLS1Whr0wgmkdR++OckeFrDv+2v8Iu6aCBbOZ0Yo1QcIxSQ71I/rw6gi6ldvKEUKYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be1dbdc-94e3-4a9c-b9f0-08dd5257777d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7211.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:09:38.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwi2x+hartvIUrjYStmqjNGhEw7uQmoyu+COp3FYub6PRU0sJC6HeXQadHizTLTq55naojPQeHmeQnEULVhFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210069
X-Proofpoint-ORIG-GUID: 07S_AAU8a_HBP5hiG3WhMR7AKCR9xhFS
X-Proofpoint-GUID: 07S_AAU8a_HBP5hiG3WhMR7AKCR9xhFS



On 21-02-2025 11:30 am, Chris Hyser wrote:
> From: Chris Hyser <chris.hyser@oracle.com>
> Sent: Thursday, February 20, 2025 11:21 PM
> To: Sinadin Shan; Shrikanth Hegde
> Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; shuah@kernel.org
> Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
>>
>> From: Sinadin Shan <sinadin.shan@oracle.com>
>> Sent: Thursday, February 20, 2025 11:23 AM
>> To: Chris Hyser; Shrikanth Hegde
>> Cc: linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; shuah@kernel.org
>> Subject: Re: [PATCH] selftests: sched: add sched as a default selftest target
>>
>>>> I guess my question is what if SCHED_CORE was supposed to be configed into
>>>> the test kernel?  Silently burying the error might be bad. I'm not strongly tied to
>>>> that, just looking for opinions. At the same time, if you put the orig change in,
>>>> people w/o SCHED_CORE on will start seeing "failures" they didn't see before,
>>>> yes? and that seems bad.
>>>
>>> Yes, that seems bad as rightly pointed out by Shrikant. I have a patch
>>> that does the above mentioned skip, and if skipping is a right option to
>>> take here I can send it in the next version.
>>
>> If that is the plan, I prefer to fix it myself.
> 
> Ok. Here is a better plan. I suspected there must be some convention for all
> these tests (that you are obviously familiar with), I just feel bad for how this test
> originally got jammed in here. If you already have a patch, we should just go with
> that and yes adding that code seems like the exact right thing to do.
> 

Thanks Chris, I shall send the new patch.

-Shan

> -chrish
> 


