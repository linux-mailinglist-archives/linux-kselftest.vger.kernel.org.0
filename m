Return-Path: <linux-kselftest+bounces-23825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824C9FFCBC
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F821881B06
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24489185924;
	Thu,  2 Jan 2025 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gwxgx7Kn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tsGJNe3x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164B181334;
	Thu,  2 Jan 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839077; cv=fail; b=X/+MUHSOKmoRdhgPSgGrvFStGxqgXC/tTrw35MFaQ4kX37ZFK/qrHt1FcnLUnhKapKg4KWPd0Lix5U6F998WwZnZBLQT+GHwIHiVTfRbaFrZDiXl3Ll8YTrddCo5kO+RKFxHFBIsvP+dFN5ePWDKPwozKmeuJ7q6FXICBK+xE6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839077; c=relaxed/simple;
	bh=qn+45tbh8HGh1RLsHkL5qeP80IUTduzj+BH3Y9Rxljw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bczcPWEGA/R/aUycYch/G+EMf9ufMBIOLMB+YAx9A9WoyjDRRWZ4uP/Poa7wUuY43m0QIvGZWPxLr8iEry+NnPM+rLfkJY8WM0LL3VBqwdHYDilBB0A1/yQrnrDbDEiwxL6rsM1NI0KHQO+c6zqvrZYdiPwpoWAA2TOqdCIiQyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gwxgx7Kn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tsGJNe3x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502HUKgZ010127;
	Thu, 2 Jan 2025 17:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VtOF7P++F0Cgdj51m75mr+xexM7I3dL1p1Fs3kNTCZE=; b=
	gwxgx7KnSwJJU4NeQ6xRKLjZynmPqMfqLdhe8hFjmLt1sGG0tonqaptt6UQLlKvT
	sb8/YdOOvB1n36CV4F3UWLG/gLREeyQAel08V1kIipjCYtwim2PydxdRxj3sr2dE
	e8wc7KfBxoxfbUlVgfDboCyH0eDvWUHxkfUrWVC5BI1d+/4wUV3hBCVX3MP0lqF/
	3tEboGpf10lCLq41u/NYG9Is63ZxCcJTPVJDHLxpZ7KVT/CamIib1lrCftp7+9cC
	gQE+CLtGuaWNve8oMiR5VBOyRuaCl7JvarZoXrymiTRdeboT2G9dQiLCnWtasLLk
	fUiknivrT59zHDbcnT8S/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t841x0d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 17:30:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502H1I5j009322;
	Thu, 2 Jan 2025 17:30:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s925xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 17:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz1FkGn5zBJMXRrJdLjGL6aMkuYH34vj7pb86ilj2kBcSx7jDA7Kct7NUGVSrdR2gddupW/QXk1u+FLtZXDyJY1C3flgii37YO6jpu5DWr/yEl2GCFUusXcYl7fCDsqFDbmFlDqd9Xi+vb2Za7ck4oSCSA3tcadB+2MGgej5+FtG1X7rcTsE3u6iqr+0pK9wooFQLOpEwzgboVmAiZwJSCrTFWflotdAO9ggwNEJK5zyMcdjbEaP/7vfexdcn5M6VD3u4RALH4B92DkzvZQtMI3e/UkF40rmvb4hbqTb6Xzpa1mGrzbVPES6lt5T2gOtAOlFmGHiHNXMJj3MdvPoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtOF7P++F0Cgdj51m75mr+xexM7I3dL1p1Fs3kNTCZE=;
 b=m2gUG2+FpngTiatpMkHJg5WuQbWzGL5+FwTQKUZvX1ZqJlsc1exmYtztD3hOkgll8pHuAMbF9LZelqg72ttgEfcNXb3Fs34G/PMwEPVOjO2Rvy1GDMYRMuKH6+2l7wcQSAq9d52Vhyx44NXBzBhdlBUEdwsegxq1TVshP5tok304tV0VnWuYjTRg85hyNInlfx79W8qhudhjJYIHa1stN4qvDWDTQl0TSTRFefrh0L0zy2iygGg/zTBHTIa3UHyK8uMI8hmgU799kucG15Rl9jEEZXuzD0Uu4oMsFKF7gBJU1QwYfbg49noGoAQWkuBh+CYr4CWh7oG9RV6fk9Mqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtOF7P++F0Cgdj51m75mr+xexM7I3dL1p1Fs3kNTCZE=;
 b=tsGJNe3xPnKnt8338Jm3OvCfjN4RdC6NF55yPwF7+Gkx2BzFL40kK+N7jzbuXKEHQ3/dcAlHsKrMiwHhAeB8IsZujdAgF3vDu1jFvdMuuc4hdj+udBBwvbbGVwFaH+Jd4r4P+ilsdgqpKG9EqW3i3LlpWjdHo1qSh94XlqP4vKc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 17:30:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 17:30:44 +0000
Date: Thu, 2 Jan 2025 17:30:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com,
        broonie@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jorgelo@chromium.org, keescook@chromium.org, pedro.falcato@gmail.com,
        rdunlap@infradead.org, jannh@google.com
Subject: Re: [RFC PATCH v1 1/1] selftest/mm: refactor mseal_test
Message-ID: <e81dba68-ee9b-42ea-911a-4eca907c8f6a@lucifer.local>
References: <20241211053311.245636-1-jeffxu@google.com>
 <20241211053311.245636-2-jeffxu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211053311.245636-2-jeffxu@google.com>
X-ClientProxiedBy: LO4P123CA0243.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 588c6d9e-933f-4058-27fd-08dd2b532f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE12dWJsZFl1OS9wYlZxUXRmd1ZST1JVRjNzb1o2OFR5TkRIalVMSU03cDdt?=
 =?utf-8?B?TklhNFF0emlkN2w3b1BzMDVGNitkK2tob0F3Njl2aE5qdVJ1MVR0ZUV6OFJT?=
 =?utf-8?B?TWM3UWU5NnlEWnUzRCtSS0hhM1FJY0FUSjVRdU1uS0tnc21zYnAwK1pkOHlh?=
 =?utf-8?B?S3JtVExmL2ZjNGg5bnY2RStjU3dFRFhJMkVEZzlqMDBkRUFZQ1Uvck1sOUdy?=
 =?utf-8?B?M2R6anhOVldtcmh6Y3JSdjhCd2ZJK2FvanpNM25KQm1UTWpWNTJGWXVwa0NM?=
 =?utf-8?B?UiswTURUa3FEWmpkRWFSdTJaNzBBU3JPbFVZU0dHR3h6T1FURzE2UG5Qdlpr?=
 =?utf-8?B?VEFuZzNLd3d4N2dULy9iTzFuWWRxSkVHL1drRW9ldk5odEFxWENXV3BaeVdr?=
 =?utf-8?B?enpQUUFUUHVCNkU1d3hzTTM2YWlNMkJvQThXZ3pjS0JESktrNWtPQzRLdC92?=
 =?utf-8?B?VDdtNE11dERWNlVBYk9WYUMwWTVsUGJnK0JHMnpjNGlGSlEvdDNOMGQvTkpa?=
 =?utf-8?B?cEtxZzlqTitiNFh0ZDh1RlloY0lsZmdTNFBhUVl1RXpYeWwxT1I0ejdpODd4?=
 =?utf-8?B?MlQ0WmpkMnRkdkpHU2VaV2ZRWWNXSzE0aDg1Q2ViNXljMGRlRlZ5LzZ4Zmd3?=
 =?utf-8?B?UFhyZGJ6ZzFLdDgrMGlDSDE1WGRYTU5JR2lsQUpXSWhiWlJONXRXbHRiYlVx?=
 =?utf-8?B?M1JVV2dRcWhnYlB6R3YvWTVuUjdiRnhZbFY0cGVVcVR6akxRYys5QUtjQXUx?=
 =?utf-8?B?Q2VGY1BTS0R3c0hGc0J2eDB2bU42cTNDSzF0ajRlTTRtUWVDWG1yRDE0dDRj?=
 =?utf-8?B?RzJBRERSK0dWS1FQSExVOVEzNVhiKytlQ3EyMkMvN2hiT0pBSm54YVdmZ0Er?=
 =?utf-8?B?YnhVcFpNVDQxbXd1WklpbElmZXpycFM1VnYycWtaWkVhUkpWWDJHalkzUnRS?=
 =?utf-8?B?Z0wrK1NYSStockhmNWI5dkkrMWF0U3F1U0dwaE9NSzFXWlBpYW5mMnYyZ3ox?=
 =?utf-8?B?a0Q2cEhvMTBERExYelJjK1FsSXR5NnBmbFdaTEZ5RjlhMURPVWFmb0ljM09u?=
 =?utf-8?B?M1drL0NwZFE5MEpmaktiaTZxK1V0Yi9JNWRFNnF6VUJ4VEtVamVOdkNMOWV1?=
 =?utf-8?B?UjhmYzNSVjhEdlV5VGViSjdHNUhUcmhKR213Znp2SG1sWlc1VmZOeFZYUFp4?=
 =?utf-8?B?bi9xSFJqbUQrSzRWTmQvU2IrbGEzbUQybGdIOVFTUW5HbXd1WVFzbk1BNEpM?=
 =?utf-8?B?UnN4SUFWczBZbkx1TVhybEVxNVplQUFsb3lYdFpOcmJUa1BPRmZNSkpUQTda?=
 =?utf-8?B?ekhpODFSU3NRZ1ovb0JxS3ovaXBpNUVWV3V2VHNmZG1IYVFqN1ZVdThhQTRL?=
 =?utf-8?B?RGt6SFhPaEVPaTIxTVlHd3RncERoTjQ3VEF3eWJLdUpQajZvb2J6TXBISGVH?=
 =?utf-8?B?cWMwb2FZbnVnTEh5cHB0akhKZlpVV1RLaFhpMWtOaFhqZnVHWjhhMDZtc0lB?=
 =?utf-8?B?OU1rRzhhOWwxRHZkK0N6T2lQaE96a1UvNWdOaGhWY3B6N3RnSURIYS9UQnp6?=
 =?utf-8?B?U3BRQmpwK21tQkt6QjRDMjJ0L3VlS0lvNXAvYjlLMitnRjgrdVRMN1c4UVYr?=
 =?utf-8?B?NHdwcEhqc0U4Q2lrUEIyTWd5a3J3d21tWEYyajZ5S3NOSW5QVEZuckY2OTdI?=
 =?utf-8?B?dFd1T3hPVGQ2Nk82Y1plcTRwL3hDV2xHY2N3b0JOMm1BS0pRUWtZZWEvMUdR?=
 =?utf-8?B?Vkt4dmlBUVQ1QndrT1JGYW84SVFEYTZEMDZnZFF1bXBoVkZ0ajRCWTlBQURX?=
 =?utf-8?B?dU1LNWdwS1JNV2gxZmFZUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWhYcEw0SnFzUkh1YmNwTGg3MlBUbjJta01hUnNSd0x5Y0M1VFRHYVdvcFVH?=
 =?utf-8?B?VWtneHBhNFRPQVZNWndlRm9qa3JTaDdoNE5qM2RVRDJBMlptOE1UVVg2WElV?=
 =?utf-8?B?NnEzbmZ3WGVRc2hKdHF5NTA3SzExM2h3Rllac3pEc3d0YnczMHNtcmswUWdq?=
 =?utf-8?B?ZWZESXk5SmJJYVNSTnJUM2M0bmlyOGFyU3lPS0g2RnJvUlk0NVo1bFozeGEz?=
 =?utf-8?B?UEdOV0Vpd21DWXJQVlJ2VWRqcll0WXAyQ0svSjN6bnVXbENrZENkWkJYSk40?=
 =?utf-8?B?ZDJqOVZCVm8zY1JKS3BPSHJ3Ni8yNW4xQjVMc3JJMG9vSXdScDU5c2c5dlJV?=
 =?utf-8?B?L1VHZWZRTXcvajd0cHJGVTZxRTNyNzdPbmdMbDZ4NjNxei8rUDUrSXNwQjdz?=
 =?utf-8?B?Qzh4R25YOHEwZHcwTzZFVmEycEZqVk95WGpjQ2Fqa3lPMHE2RlBDRVIwRGRM?=
 =?utf-8?B?YklEcWlFRVRHd25uZlJNU1RYUEdlSXJBby9uTUwxRmJXdk41UXRsbXJ3N3J3?=
 =?utf-8?B?emdISGdhZ294VUdyOEpLbjJIUy9OZzV4aVVjcEF3dGJMNE1uOHU2bkRWR3pm?=
 =?utf-8?B?eEJvYmgrQmJiUHZqSU1TN1l4c2pjOGE1SW9PZUx0VC85RXg5aTdsT3N1K0Mw?=
 =?utf-8?B?aHlGTEdESW0ySW50ejNwKzlWeHM1UlhMY0xnZ2lrSWQrYkhWejFtSG5SN0M4?=
 =?utf-8?B?NW5BWVBNLy9laFZwMUVkaWR6c25mVzd4VTljQnl3YUZleFY3TkdDdXp3OTdE?=
 =?utf-8?B?T2NKS1lhZGEvMytjUkdTdjE4SGRwN0xvandhMzdmaHF6UDJTVWpaVFJJQXV6?=
 =?utf-8?B?elQ4U09oZEFyRnRPUnNycGRVSFpDTnNNWkhuSlVWQ3hOU2JmWjRzSDlDamMv?=
 =?utf-8?B?dUs5QzQxa3RHUzZlM2tLRmR5NTJkR0hCdmEyTkFldUM0ZUsxTGNPang4Mito?=
 =?utf-8?B?R1U2S1hGZjVOQjlVdVU1WVZ4L1R1amhzVG1xazRBa2NEOVYvdFBIR3lzVmJr?=
 =?utf-8?B?czJNYVRERGV5NW1iWHJOclN4aFFoalFDc1hBOWM2U1dSYmcwd0ltcStrM2s3?=
 =?utf-8?B?cVVRYUpINUpQdnE2KzNVZWtBUGVpS2g5a2RyemVCbHIvMUM3bnpoOVBZSTlX?=
 =?utf-8?B?ZE1EbURyQWgrZHlVL2ZZOEkzcUlBMXU5bkVrWW00RU9MZUsydzVhTitIQUtE?=
 =?utf-8?B?Y2RrUHoyTVpRVjVTLzNoUGorRjdPenVXMHBIYmM0UEsybzd0MmV6cDdvcUtT?=
 =?utf-8?B?TEZYdUt2bHBOdmtDb0NRVHp0YkUrck90MkwzREN1TURrZndvd1RFM3lrMWdP?=
 =?utf-8?B?Sld2Z1Q3d1JnaXQ5V3BXdnhmOUF1bDYxaGhXbWo1TjE1ZExLRE1wNWtzc1Y3?=
 =?utf-8?B?eHplR2h3TXJ5SFRZOFlERHdJU3VWWGJFVnlWT01NbjNXQk1XMUhGdzAzVjJy?=
 =?utf-8?B?empDQ29wZkFMdDY1QUptNExEYUpXM2laZmVGYWFtR3k3b29xVnFSTm9rT2xl?=
 =?utf-8?B?MGpxR0dGWENTUXhpRVFBT3E4VFMwZFpSV3hHSDAwSVVOZ1JtRWpBdzVGMmVq?=
 =?utf-8?B?ZVhrTVU5bUI3R2hyZ2tMVjNNSDAzVGdHVHQ3LzBNV05oOURLVEZBQnh3b1RY?=
 =?utf-8?B?UUZtZ3FnZmFqN0hBVlBoZld4ZVI4TlV2cExad2JVWEVFcnE5VlQ5ejdJY0xw?=
 =?utf-8?B?QVhnNlUrY1QzS0xFaVM2U2NCazdRaDZXMHoxWDE3QjdONUNzWGdjNmtVU25Q?=
 =?utf-8?B?d2hISFJvZENBMmxDUG41QkE1RnJNZURvVmR5S1A0bG1oTlhGeGVPR1gvdU5y?=
 =?utf-8?B?d3JkUjFwamZtR1k4WmcreU90QmFJenJFaTc1QTBoRXNQQlJzajM3bjhId2E4?=
 =?utf-8?B?bGlYaVZJSFRUdERCOVlIWUNBREZRVnRhSndtRGRBMkk4RFhwaEtJZnhTRUJt?=
 =?utf-8?B?UE1VUGJHejdwQXo4d3A2SUFkRmo0ZzI4S0ptZ291eU43dG1IMnhVUFRNVFIv?=
 =?utf-8?B?eEY2SVMwOEtZeE56ZEo1K3JVQlE2MDVEaFdveExGRko0dm4xZlRVb2JFM0hN?=
 =?utf-8?B?eUs4dENDK2hmTzJjaWw0WlFqNiszMm5MRzd4NE80Um1waGQrTUZQMG93UU9F?=
 =?utf-8?B?WDJaUkJodW9SY29qMW9WUVhSUVhuckt3cVZaalpndmVaajBmWG8xZEthMWRv?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c/VLwFUKEJSSj27nY5AR5tF3ehXnLyEcwMsHmH0m7IBa1GPWxcXTQGU2lZcXQhoWYCjNtpJmf/CephM8tOKMu+AW1BMOqr7uCiA2T/5x4eNyWj5tWtGzrY5JeZRl/dAvSQZiP3XmNUNS5wrlpWIOB3Zv51/A5IBYIeRRSr1k/HpHO/rp5GkTlM9gjZ/AhKKgNXZDaILtyZqPtsHAl+YT2aRWwqaLeendbeV8Pf05sE9HHRVhy0w5/U/aGaTi5Y63RHMLI+hvsoUaAVqw2ILSAlTxnJ99DSesM0t79bOh2ok1+ojwFfss6aQxGYBZp7xJSdhLC1Um43HvYIstqWrUTfljPHds8FxKN5h5NbwWWawPYSvdDZQ5lVmCKNy781tqEDDI4UHlogp4PaXsQkfCAq8UMkYsUqh7qpZwD4OeKPM9ONu9Z/mN+NxhhAQ3N547tU09xKIYE10prlQ09EGfvHtSexYcr+CnnmL9lUmAsCD3fs/7rY4OQ9CFjFR/6i3M9jqxHj1qkaIOwjDyIFMuxHjCog8FTkr59XWf/voVphauxAEHq5VwAqO/iheaCakYmuAXQ+E8TYyT++Na953xqNMb0VBK1yPNHuU1jMYpslQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588c6d9e-933f-4058-27fd-08dd2b532f94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 17:30:44.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLgvAgQxylGi1aOp7xPP8g9ymRQLVj7cgNkwBQ9vMcxloH6ef56vecW3FDRRiQZXtCoB3UMo4Y1iUP91WUGT7nyLrWUfjtbPisW8Q5n7GTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020153
X-Proofpoint-ORIG-GUID: blIgHh6N91ZrGnhwkyVNicmoOYmzTjsJ
X-Proofpoint-GUID: blIgHh6N91ZrGnhwkyVNicmoOYmzTjsJ

Sorry for delay, was super busy leading up to xmas break, then had ~2.5
weeks off.

And happy new year! :)

On Wed, Dec 11, 2024 at 05:33:11AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
>
> This change creates the initial version of memorysealing.c.
>
> The introduction of memorysealing.c, which replaces mseal_test.c and

I mean I don't want to be a pain but I would kinda prefer to have 'mseal'
everywhere mseal is to avoid confusion vs. memfd seals.

Of course we in the kernel absolutely _love_ to overload the meaning of terms
but some traditions are worth breaking :)

> uses the kselftest_harness, aims to initiate a discussion on using the
> selftest harness for memory sealing tests. Upon approval of this
> approach, the migration of tests from mseal_test.c to memorysealing.c
> can be implemented in a step-by-step manner.

Well, I for one like this approach so (unsurprisingly) :) but perhaps
sensible to do it iteratively so we can also tweak things as we go.

>
> This tests addresses following feedback from previous reviews:
>
> 1> Use kselftest_harness instead of custom macro, such as EXPECT_XX,
> ASSERT_XX, etc.  (Lorenzo Stoakes, Mark Brown) [1]
>
> 2> Use MAP_FAILED to check the return of mmap (Lorenzo Stoakes).

Thanks!

>
> 3>  Adding a check for vma size and prot bits. The discussion for
>     this can be found in [2] [3], here is a brief summary:
>     This is to follow up on Pedro’s in-loop change (from
>     can_modify_mm to can_modify_vma). When mseal_test is initially
>     created, they have a common pattern:  setup memory layout,
>     seal the memory, perform a few mm-api steps, verify return code
>     (not zero).  Because of the nature of out-of-loop,  it is sufficient
>     to just verify the error code in a few cases.
>
>     With Pedro's in-loop change, the sealing check happens later in the
>     stack, thus there are more things and scenarios to verify. And there
>     was feedbacks to me that mseal_test should be extensive enough to
>     discover all regressions. Hence I'm adding check for vma size and prot
>     bits.
>
> In this change: we created two fixtures:
>
> Fixture basic:   This creates a single VMA, the VMA has a
> PROT_NONE page at each end to prevent auto-merging.
>
> Fixture wo_vma: Two VMAs back to end, a PROT_NONE page at each
> end to prevent auto-merging.
>
> In addition, I add one test (mprotec) in each fixture to demo the tests.
>
> [1] https://lore.kernel.org/all/20240830180237.1220027-5-jeffxu@chromium.org/
> [2] https://lore.kernel.org/all/CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com/
> [3] https://lore.kernel.org/all/2qywbjb5ebtgwkh354w3lj3vhaothvubjokxq5fhyri5jeeton@duqngzo3swjz/
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/.gitignore      |   1 +
>  tools/testing/selftests/mm/Makefile        |   1 +
>  tools/testing/selftests/mm/memorysealing.c | 182 +++++++++++++++++++++
>  tools/testing/selftests/mm/memorysealing.h | 116 +++++++++++++
>  tools/testing/selftests/mm/mseal_test.c    |  67 +-------
>  5 files changed, 301 insertions(+), 66 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/memorysealing.c
>  create mode 100644 tools/testing/selftests/mm/memorysealing.h
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index a51a947b2d1d..982234a99f20 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -57,3 +57,4 @@ hugetlb_dio
>  pkey_sighandler_tests_32
>  pkey_sighandler_tests_64
>  guard-pages
> +memorysealing
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 93a46ac633df..08876624f46d 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -67,6 +67,7 @@ TEST_GEN_FILES += map_populate
>  ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
>  TEST_GEN_FILES += memfd_secret
>  endif
> +TEST_GEN_FILES += memorysealing
>  TEST_GEN_FILES += migration
>  TEST_GEN_FILES += mkdirty
>  TEST_GEN_FILES += mlock-random-test
> diff --git a/tools/testing/selftests/mm/memorysealing.c b/tools/testing/selftests/mm/memorysealing.c
> new file mode 100644
> index 000000000000..e10032528b64
> --- /dev/null
> +++ b/tools/testing/selftests/mm/memorysealing.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#define _GNU_SOURCE
> +#include "../kselftest_harness.h"
> +#include <asm-generic/unistd.h>
> +#include <errno.h>
> +#include <syscall.h>
> +#include "memorysealing.h"
> +
> +/*
> + * To avoid auto-merging, create a VMA with PROT_NONE pages at each end.
> + * If unsuccessful, return MAP_FAILED.
> + */
> +static void *setup_single_address(int size, int prot)

Nitty, but size should really be an unsigned long.

> +{
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();

Trivial, but we store page size in self->page_size so why not pass it as a
parameter instead of looking up?

> +
> +	ptr = mmap(NULL, size + 2 * page_size, prot,
> +		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +
> +	if (ptr == MAP_FAILED)
> +		return MAP_FAILED;
> +
> +	/* To avoid auto-merging, change to PROT_NONE at each end. */
> +	ret = sys_mprotect(ptr, page_size, PROT_NONE);
> +	if (ret != 0)
> +		return MAP_FAILED;
> +
> +	ret = sys_mprotect(ptr + size + page_size, page_size, PROT_NONE);
> +	if (ret != 0)
> +		return MAP_FAILED;
> +
> +	return ptr + page_size;
> +}

This could be done more easily with a single PROT_NONE, like:

	static void *setup_single_address(unsigned long size, int prot,
			unsigned long page_size)
	{
		void *ptr;

		/* Ensure we only merge what we intend to. */
		ptr = mmap(NULL, size + 2 * page_size, PROT_NONE,
			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
		if (ptr == MAP_FAILED)
			return MAP_FAILED;

		return mmap(&ptr[page_size], size, prot,
			    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
	}

It's probably worth having an equivalent freeing function to avoid leaks:

	static int free_single_address(void *ptr, unsigned long size,
			unsigned long page_size)
	{
		/* Also free the PROT_NONE sentinels. */
		return munmap(ptr - page_size, size + 2 * page_size);
	}

> +
> +FIXTURE(basic)
> +{
> +	unsigned long page_size;
> +	unsigned long size;
> +	void *ptr;
> +};
> +
> +/*
> + * Setup for basic:
> + * Single VMA with 4 pages, prot = (PROT_READ | PROT_WRITE).
> + */
> +FIXTURE_SETUP(basic)
> +{
> +	int prot;
> +
> +	self->page_size = getpagesize();
> +
> +	if (!mseal_supported())
> +		SKIP(return, "mseal is not supported");
> +
> +	/* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRITE. */
> +	self->size = self->page_size * 4;
> +	self->ptr = setup_single_address(self->size, PROT_READ | PROT_WRITE);
> +	EXPECT_NE(self->ptr, MAP_FAILED);
> +
> +	EXPECT_EQ(self->size, get_vma_size(self->ptr, &prot));

I mean fine but this check seems a bit overkill here, we don't need to
check to ensure that PROT_NONE works.

> +	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);

Nitty, but this seems a bit 'Yoda style', that is placing the expectation
prior to the value whose expectation we are assessing, that is perhaps it'd
be clearer as:

	EXPECT_EQ(prot, PROT_READ | PROT_WRITE);

And again, I think this is really overkill here, if the kernel is unable to
do an ordinary mapping correctly we have bigger problems than an mseal bug!

> +};
> +
> +FIXTURE_TEARDOWN(basic)
> +{

Probably worth adding munmap() teardown here.

> +}
> +
> +FIXTURE(two_vma)
> +{
> +	unsigned long page_size;
> +	unsigned long size;
> +	void *ptr;
> +};
> +
> +/*
> + * Setup for two_vma:
> + * Two consecutive VMAs, each with 2 pages.
> + * The first VMA:  prot = PROT_READ.
> + * The second VMA: prot = (PROT_READ | PROT_WRITE).
> + */
> +FIXTURE_SETUP(two_vma)
> +{
> +	int prot;
> +	int ret;
> +
> +	self->page_size = getpagesize();
> +
> +	if (!mseal_supported())
> +		SKIP(return, "mseal is not supported");
> +
> +	/* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRITE. */
> +	self->size = getpagesize() * 4;
> +	self->ptr = setup_single_address(self->size, PROT_READ | PROT_WRITE);
> +	EXPECT_NE(self->ptr, MAP_FAILED);
> +
> +	/* Use mprotect to split as two VMA. */
> +	ret = sys_mprotect(self->ptr, self->page_size * 2, PROT_READ);
> +	ASSERT_EQ(ret, 0);
> +

> +	/* Verify the first VMA is 2 pages and prot bits */
> +	EXPECT_EQ(self->page_size * 2, get_vma_size(self->ptr, &prot));
> +	EXPECT_EQ(PROT_READ, prot);
> +
> +	/* Verify the second VMA is 2 pages and prot bits */
> +	EXPECT_EQ(self->page_size * 2,
> +		get_vma_size(self->ptr + self->page_size * 2, &prot));
> +	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);

Again, as with the prior fixture, it seems a bit overkill, as this is
essentially testing 'does mmap() and mprotect()' work. We should hope so :)

> +};
> +
> +FIXTURE_TEARDOWN(two_vma)
> +{

Same comment as for the basic fixture - let's clean up after ourselves.

> +}
> +
> +/*
> + * Verify mprotect is blocked.
> + */
> +TEST_F(basic, mprotect_basic)
> +{
> +	int ret;
> +	unsigned long size;
> +	int prot;
> +
> +	/* Seal the mapping. */
> +	ret = sys_mseal(self->ptr, self->size, 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	/* Verify mprotect is blocked. */
> +	ret = sys_mprotect(self->ptr, self->size, PROT_READ);
> +	EXPECT_GT(0, ret);

Yeah this one is kinda egregious, this is genuinely hard to read. Wouldn't
this be better as:

	EXPECT_NE(ret, 0);

As it explicitly says 'not equal to a success case'. Rather than 'wait 0 is
_greater than_ the result which means the result is _less than_ 0 which
means an error but let me check the man page can it be positive, oh ok it's
-1 on error, 0 on success', which was the Lorenzo thought process... :)

> +	EXPECT_EQ(EPERM, errno);

Let's invert these, Yoda style isn't really useful here and is a little
harder to read, e.g. we should do:

	EXPECT_EQ(errno, EPERM);

> +
> +	/* Verify the VMA (sealed) isn't changed */
> +	size = get_vma_size(self->ptr, &prot);
> +	EXPECT_EQ(self->size, size);
> +	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);

Again, no to Yoda :)

I also wonder how useful this is - I guess belts + braces, and linux _can_
do partial failures, but is that something we would care about in practice?

> +}
> +
> +/*
> + * Seal both VMAs in one mseal call.
> + * Verify mprotect is blocked on both VMAs in various cases.
> + */
> +TEST_F(two_vma, mprotect)

I'm guessing you aren't necessarily covering _all_ mprotect cases here
(though perhaps you intend to later, iteratively?)

> +{
> +	int ret;
> +	int prot;
> +	unsigned long size;

I think 'size' is a bit confusing as it refers to the size ascertained from
the get_vma_size() later on. Perhaps call it actual_size?

Maybe worth adding:

	void *ptr = self->ptr;
	unsigned long size = self->size;
	unsigned long page_size = self->page_size;

For convenience?

This is totally optional though, maybe more effort than it's worth.

> +
> +	/* Seal both VMAs in one mseal call. */
> +	ret = sys_mseal(self->ptr, self->size, 0);
> +	ASSERT_EQ(ret, 0);
> +
> +	/* Verify mprotect is rejected on the first VMA. */
> +	ret = sys_mprotect(self->ptr, self->page_size * 2,
> +		PROT_READ | PROT_EXEC);

Why PROT_READ | PROT_EXEC? Is this arbitrary? To be thorough shouldn't you
loop through all of the prot flags that you think should fail? And perhaps
check what happens if you mprotect() the VMA to set it to what it already
is?

> +	EXPECT_GT(0, ret);

Please convert to EXPECT_NE(ret, 0)

> +	EXPECT_EQ(EPERM, errno);

Please invert to EXPECT_EQ(errno, EPERM)

> +
> +	/* Verify mprotect is rejected on the second VMA. */
> +	ret = sys_mprotect(self->ptr, self->page_size * 2,
> +		PROT_READ | PROT_EXEC);

Hang on, isn't this just a repeat of the first test? Shouldn't this be:

	ret = sys_mprotect(&self->ptr[self->page_size * 2],
		self->page_size * 2, PROT_READ | PROT_EXEC);

> +	EXPECT_GT(0, ret);
> +	EXPECT_EQ(EPERM, errno);

Same comment as above re: ordering.

> +
> +	/* Attempt of mprotect two VMAs at the same call is blocked */
> +	ret = sys_mprotect(self->ptr, self->size,
> +		PROT_READ | PROT_EXEC);

Same comment about iterating through prot flags that should fail as above.

> +	EXPECT_GT(0, ret);
> +	EXPECT_EQ(EPERM, errno);

Same comment as above re: ordering.

> +
> +	/* Verify both VMAs aren't changed. */
> +	size = get_vma_size(self->ptr, &prot);
> +	EXPECT_EQ(self->page_size * 2, size);
> +	EXPECT_EQ(PROT_READ, prot);

Same comment as above re: ordering.

> +
> +	size = get_vma_size(self->ptr + self->page_size * 2, &prot);
> +	EXPECT_EQ(self->page_size * 2, size);
> +	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);

Same comment as above re: ordering.

> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/mm/memorysealing.h b/tools/testing/selftests/mm/memorysealing.h
> new file mode 100644
> index 000000000000..aee6e6700028
> --- /dev/null
> +++ b/tools/testing/selftests/mm/memorysealing.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <syscall.h>
> +
> +/*
> + * Define sys_xyx to call syscall directly.
> + * This is needed because we want to avoid calling glibc and
> + * test syscall directly.

I do wonder if this is worth it, but I mean, I guess it's not too egregious
if it's wrapped like this. Same comment for other wrappers.

> + * The only exception is mmap, which _NR_mmap2 is not defined for
> + * some ARM architecture.
> + */
> +static inline int sys_mseal(void *start, size_t len, unsigned long flags)
> +{
> +	int sret;
> +
> +	errno = 0;

Why are we setting this to 0? Same comment for all sys_XXX() wrappers.

> +	sret = syscall(__NR_mseal, start, len, flags);
> +	return sret;

Nit, but this seems a bit redundant, why not just drop the sret assignment,
and simply:

	return syscall(__NR_mseal, start, len, flags);

Same comment for all sys_XXX() wrappers.

> +}
> +
> +static inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_mprotect, ptr, size, prot);
> +	return sret;
> +}
> +

The wrappers below don't seem to be used yet, could we delay putting them
in until they are actually used?

> +static inline int sys_mprotect_pkey(void *ptr, size_t size,
> +	unsigned long orig_prot, unsigned long pkey)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
> +	return sret;
> +}
> +
> +static inline int sys_munmap(void *ptr, size_t size)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_munmap, ptr, size);
> +	return sret;
> +}
> +
> +static inline int sys_madvise(void *start, size_t len, int types)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_madvise, start, len, types);
> +	return sret;
> +}
> +
> +static inline void *sys_mremap(void *addr, size_t old_len, size_t new_len,
> +	unsigned long flags, void *new_addr)
> +{
> +	void *sret;
> +
> +	errno = 0;
> +	sret = (void *) syscall(__NR_mremap, addr, old_len, new_len, flags, new_addr);
> +	return sret;
> +}
> +
> +/*
> + * Parsing /proc/self/maps to get VMA's size and prot bit.
> + */
> +static unsigned long get_vma_size(void *addr, int *prot)
> +{
> +	FILE *maps;
> +	char line[256];
> +	int size = 0;
> +	uintptr_t  addr_start, addr_end;

Why not add a:

	uintptr_t addr_val = (uintptr_t)addr;

To avoid having to constantly cast below?

> +	char protstr[5];
> +	*prot = 0;

Nit but not sure there's much point in setting this to 0 even in failure
cases?

With an error code return you can avoid having to do this.

> +
> +	maps = fopen("/proc/self/maps", "r");
> +	if (!maps)
> +		return 0;

Might it be better to return an error code or something so we can identify
this case? I guess any sensible call will fail on a 0 but you're sort of
just implicitly hoping for this.

> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, protstr) == 3) {
> +			if (addr_start == (uintptr_t) addr) {

This is a Yoda comparison again, let's put what we're comparing first, and
the thing we're comparing to afterwards, e.g.

	if ((uintptr_t)addr == addr_start) ...

Also I don't think a space after the (type) cast is necesary.

> +				size = addr_end - addr_start;
> +				if (protstr[0] == 'r')
> +					*prot |= PROT_READ;
> +				if (protstr[1] == 'w')
> +					*prot |= PROT_WRITE;
> +				if (protstr[2] == 'x')
> +					*prot |= PROT_EXEC;
> +				break;
> +			}
> +		}
> +	}

On the impl: This would be neater if you used guard clauses:

	while (fgets(line, sizeof(line), maps)) {
		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, protstr) != 3)
			continue;

		if (addr_val != addr_start)
			continue;

		size = addr_end - addr_start;
		if (protstr[0] == 'r')
			*prot |= PROT_READ;
		if (protstr[1] == 'w')
			*prot |= PROT_WRITE;
		if (protstr[2] == 'x')
			*prot |= PROT_EXEC;
		break;
	}

This is a lot more readable?

On doing this at all - it feels a bit crazy to check this, but I guess it
might be the only way to assert things about merge/split.

I'm not sure it's _really useful_ to do that though - merges/splits are
internal implementation details in effect (modulo mremap single VMA
requirements), and mseal is an external interface, really the check should
be around 'can forbidden operations be performed on sealed mappings'.

However, if you do really want to do this, I think it would be much better
to use the new ioctl interface for this [0] which should avoid having to do
unpleasant text wrangling :)

[0]:https://lore.kernel.org/all/20240627170900.1672542-1-andrii@kernel.org/


> +	fclose(maps);
> +	return size;

If we don't find the line we don't seem to be indicating this, again worth
being able to pass back an error?

> +}
> +
> +static inline bool mseal_supported(void)
> +{
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +
> +	ptr = mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (ptr == MAP_FAILED)
> +		return false;
> +
> +	ret = sys_mseal(ptr, page_size, 0);
> +	if (ret < 0)
> +		return false;

This is kind of cute, I mean it speaks to the need I think for us to be
able to expose 'is X available?' programmatically. But I digress.

I guess this is ok, as this is something that should never fail.

But we should definitely clean up after ourselves here whether this
succeeds or fails.

> +
> +	return true;
> +}
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index ad17005521a8..8dd20341de3d 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -517,30 +517,6 @@ static void test_seal_twice(void)
>  	REPORT_TEST_PASS();
>  }
>
> -static void test_seal_mprotect(bool seal)
> -{
> -	void *ptr;
> -	unsigned long page_size = getpagesize();
> -	unsigned long size = 4 * page_size;
> -	int ret;
> -
> -	setup_single_address(size, &ptr);
> -	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> -
> -	if (seal) {
> -		ret = seal_single_address(ptr, size);
> -		FAIL_TEST_IF_FALSE(!ret);
> -	}
> -
> -	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> -	if (seal)
> -		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> -		FAIL_TEST_IF_FALSE(!ret);
> -
> -	REPORT_TEST_PASS();
> -}
> -
>  static void test_seal_start_mprotect(bool seal)
>  {
>  	void *ptr;
> @@ -658,41 +634,6 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
>  	REPORT_TEST_PASS();
>  }
>
> -static void test_seal_mprotect_two_vma(bool seal)
> -{
> -	void *ptr;
> -	unsigned long page_size = getpagesize();
> -	unsigned long size = 4 * page_size;
> -	int ret;
> -
> -	setup_single_address(size, &ptr);
> -	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
> -
> -	/* use mprotect to split */
> -	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> -	FAIL_TEST_IF_FALSE(!ret);
> -
> -	if (seal) {
> -		ret = seal_single_address(ptr, page_size * 4);
> -		FAIL_TEST_IF_FALSE(!ret);
> -	}
> -
> -	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> -	if (seal)
> -		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> -		FAIL_TEST_IF_FALSE(!ret);
> -
> -	ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
> -			PROT_READ | PROT_WRITE);
> -	if (seal)
> -		FAIL_TEST_IF_FALSE(ret < 0);
> -	else
> -		FAIL_TEST_IF_FALSE(!ret);
> -
> -	REPORT_TEST_PASS();
> -}
> -
>  static void test_seal_mprotect_two_vma_with_split(bool seal)
>  {
>  	void *ptr;
> @@ -1876,7 +1817,7 @@ int main(void)
>  	if (!pkey_supported())
>  		ksft_print_msg("PKEY not supported\n");
>
> -	ksft_set_plan(88);
> +	ksft_set_plan(84);
>
>  	test_seal_addseal();
>  	test_seal_unmapped_start();
> @@ -1889,9 +1830,6 @@ int main(void)
>  	test_seal_zero_length();
>  	test_seal_twice();
>
> -	test_seal_mprotect(false);
> -	test_seal_mprotect(true);
> -
>  	test_seal_start_mprotect(false);
>  	test_seal_start_mprotect(true);
>
> @@ -1904,9 +1842,6 @@ int main(void)
>  	test_seal_mprotect_unalign_len_variant_2(false);
>  	test_seal_mprotect_unalign_len_variant_2(true);
>
> -	test_seal_mprotect_two_vma(false);
> -	test_seal_mprotect_two_vma(true);
> -
>  	test_seal_mprotect_two_vma_with_split(false);
>  	test_seal_mprotect_two_vma_with_split(true);
>
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

