Return-Path: <linux-kselftest+bounces-16367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C08960121
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 07:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B35C1F22371
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04D73466;
	Tue, 27 Aug 2024 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yqixVaE9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A138C13;
	Tue, 27 Aug 2024 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737458; cv=fail; b=M01O9Ni91yzhL3yFzumbE59tecGgn3WClH54bZHGR7dbC3hmGgQdd2zY/j0t86OL3ACfUrd2skuaIdJr17j76zW9Mb70UVH9f9O31oU0mGbI+rN/iq5m/5C9rSFxmFHAAuTuFmZbfFEnF9UsUl6ST3P5+lue1k2KidQ7OqDro9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737458; c=relaxed/simple;
	bh=owt0Y/nBPtJJaN+gExZTtkOi+Yc9CWzXMA6ZY9bcq2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWSktoE2tYTYmYU/T8z73jRaPscW6pUdgFqDvjIrqC4gP7k1413JtYOd+FKoIEn0s+nIGtfcxr5oJeUVqHtOWfc8cliIZv2/6nLnRLpnylKJ9Nu+pVD95bvKLREeQ2bG7J2XBHkS303rZsIF6gg4tj9NRRnLGS4gFnLQsvOMJOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yqixVaE9; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNqWeq/kTRCYuDNeawdYdwC3T+WNA/rOoiW8yxpxP1zCDhJg4H3u9jwGQfJgnkt85kMiHITEO9AUfdlnqRzuawt9V9nMjWK7sJtkKpiKsj0p+Dqx45KczVSsqQcAduPjfOhNTkXRfNJyxUc1L3/w8Si8VZUsidbqxJ9W0uXsW5ymcWQPQh5mlpc3RP72Ld2nwg94p4V+LKY4lirZSMpa8MHWYW4TQM0ioz+z8efGjqsVqS6N4xxwf55HQ/o2YJynXA9qUD85BdmFmzh9a7coAlimjqfyfGTd6hKJ+qWiTEeTemA1Q+bz8whRJT6zNudmKg3FR+ugDe9iDzacUzMF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUXryerqd6BUU0Ud3YXuaNeJklTZbKIQKnUIikaTJ4c=;
 b=ZCHMfwiuXvb7lVnrX01ySDOQ3ph6Tn6wkr6iCztk6O9yFCL/xtex/e1rkRLUR9Jtc3vHaZXmrPm23ACdVYacc2WT8PR9BXST9AYjcTjPzFVAy1GWH1+ib+iK1a6okSga6ozEgknz4uFIVwGB5R584hGg0rQKmP+uWbFJtqo3yWbReXY/Cav7UR82djkpQSULhV7tRegcD8Ck7OW9P3pNlChqq7W5xYlbnJQPEzxhQ9hxjiZSbBGBG/OYWYo2PkbPjYYL73Iz6nk+iiWGvBTQV6gNTOY6ccpE11VeLM2w8823WsNBzBQJHlCmV2A1M2GXcd/1Ckk8rrS6t8F4b8UjVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUXryerqd6BUU0Ud3YXuaNeJklTZbKIQKnUIikaTJ4c=;
 b=yqixVaE9SrDN4lfkVkuHEYIza7ESYwD5JDe8KQavSr6OYEouh3Ogl/87nR51MnGg9WF7qXpzWmvGFDOrPKn/LQmdQJHObK0l9EXPyjrChgObmlhSZZCA3vvHbC/EN2QcSIIhJyoItj6yfkM+E/axs3l8LMlxg6jxTI0UQ8R4wb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 05:44:13 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.7897.014; Tue, 27 Aug 2024
 05:44:12 +0000
Message-ID: <c72cb617-2c0d-4d38-abef-cda1dcf03c06@amd.com>
Date: Tue, 27 Aug 2024 11:14:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] SEV Kernel Selftests
Content-Language: en-US
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::31) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 7385bc6b-10bc-4ddc-1ce1-08dcc65b4737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHdQekdZM3pkNjhjYXh5TElSalhBTkhVWmxKcHU0LzJxZDJ4bTNwYU1vL0J6?=
 =?utf-8?B?R09jQ2toZTdMUm1BSmRTQjdScWtLVEVxbi90T2t2Smp1c3FYZWRUWEU3a3Jv?=
 =?utf-8?B?amluRTY1SnZzbDIyWEpuZ2tRdjNSbDVlVXlRbjFaVmszTUtvTFVhTUY5NG9j?=
 =?utf-8?B?Q2ZoSno1RHdmVVlLbTVDTm8zc0R3eUkveXdWNDdUZVlxcXIwNE1SM1p2ZGpL?=
 =?utf-8?B?V2R5QXNYR3Q4QVRmMDFyeVdTemNqYnc5azZ6NEw5YzlxZ1orRGJLUzQxRHlz?=
 =?utf-8?B?L2FDb1hCVWYrK2hYQzByMkt5MjdXU0lWZlBFbHdLSUdSS3JoWkEvRnlZYTh4?=
 =?utf-8?B?c2tYaFpLMGJqWWtaUTdnQmNqWVNyS2V3MVlrRlpETHRKVHVGTlIzMDR4MDQy?=
 =?utf-8?B?djQ4RnN1bU1GcElZSTk3Nlc4SlJBTUtmR3ROK1Y0d2d5bkh4UlNibFBnSnh4?=
 =?utf-8?B?T1pVcWRNRVpiMmV2c3MybHhNZnFLYjRWaWRHQkNjUENnZERWQjJoQU1RVVJN?=
 =?utf-8?B?TVFzSzVtT2w4UFBrdHJtYkNBUE5OVWFic0tsYWI4NHk0SWpTTDVYd3dVR2pG?=
 =?utf-8?B?djRMbTJ6TVVQZnQvcHVpSEZmWXg1Y3gxWkdyYzFiOVFIN2NkL2VmWnZSS3Zx?=
 =?utf-8?B?T1ZWcllGUk1rUC9rZ2RjY25JbElqSXBjdmRuYTduTFNuTWpNR0V1eDhCRUhE?=
 =?utf-8?B?WW1tZHVodWd0eHQxUG56cUpYc2lkVW53d1N4MEQ4NFlUZ0VkcU5oL3Y0VThr?=
 =?utf-8?B?c1RlN1FzSDIvZVloNnBBQ2xOcnlPUWRaOVFjM0ZJVXlrbzU0QzFwQXcrV3pz?=
 =?utf-8?B?S0RKWXVGWTFCNjFhcFEwQWppS2FjYnovckhTU3Y2MHRSS3ZSV1Y3bCsxNmJr?=
 =?utf-8?B?Qm01ZGRlNzl2QWUyOW53dGlLeW9hZ3E2Q08vVVhZeGltSzRpcmgrQ0ZMKzhR?=
 =?utf-8?B?YjlrSkI1RnZCcXRVcCswN1hqUUJaSWljRXhtejVGQ0kvZ3N5WWgrUERESE4w?=
 =?utf-8?B?bC9QUXlpZWZmK3paRVJOZ29IU2hFRmN0VUlBYXZBVVBxb2YxV01xNloreXRv?=
 =?utf-8?B?bHNBUmt2amFaMVBNNC9PYlZBZC9rRW5YWWZuM0pUVW1Fc0I5dTFkL2ZOVVJM?=
 =?utf-8?B?UC96N0U0ZXl5eVlobnV5SmJzZG1kNVRRNVg2cklVNHJlbVlnQW1OR1RjTU5U?=
 =?utf-8?B?Vjg3dTNNV1lrZ2tBNmg1aTB4RGRjN1drS1FDZC9CMERvY0NVR3JZRG9CbWh4?=
 =?utf-8?B?RE1UaTVnK2YxR0pkUnlId0VUWENNYXFDdEtXdEpnVGdESEMwQmJkRC9NVUpj?=
 =?utf-8?B?djd3aVh3VjFhdFRUU3hEK2dvVVZhRXdiSFhUYVFjVDVhZWRCMnlOUVZYR3px?=
 =?utf-8?B?aTlFVi9XYVErTFE4MTJEbkNqamZIWE1TMHh6SU9NVWpHTUtlZkE2UUVYaTVX?=
 =?utf-8?B?bWR5M1hwWEE5emxucTE5VEJ4Kzlsc2dnU2xhcnM2OEVDTytuMkxZYzh0UHRZ?=
 =?utf-8?B?SVJHbURXVE5WdVdoMTBVcmNHNUtFUmJxRVRmemlzMFVNQ0NqOVZGSEhLMUhw?=
 =?utf-8?B?cnI5U1pzd0krVTVhZ0hTeFBUQmpXNlI3L0NnMjlqTXBNNnFWSzlneEJJdVRp?=
 =?utf-8?B?dU12TjkwMjJFZmV2QkpuL1JrUUg2SEdzZWw1QWEwRUZmWGg2Yi9BS1pZTDIv?=
 =?utf-8?B?YnZXa0RwQ0pRZzNTM3NrRUQvUjZRUXBpUGlMbURXMnA4bHJ5UEpjZERKS09X?=
 =?utf-8?B?TTlQQmFzZWtWYzQ4K2phelY3enFVWTROajgvMkhBQ3RhTlptbVR0L1IxMXha?=
 =?utf-8?Q?HhLgR00SbH8DmK6gSXppOLdGYY6/s32CFYcZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGZLeGtkSHBCTXNjUHNoaHhDZ2o0Mms4bFFiTGVRVWFsMkx0NkNIdTR4dXMy?=
 =?utf-8?B?UDJhb3BydEk1N0NUdkYvcWRiU29sTmRGTXBJOEUzOGRwS0FkYUJ4aFo2bUgy?=
 =?utf-8?B?VmtZQVR4OXhhM0luWFd1SmkvZzJXSWh4eElZcnRxYlE1eitWa1VFNlFXdXJY?=
 =?utf-8?B?aDRLUklQanc1VVp3YlJhcG05NmhUNlVPRnh5N2wvaUtyVWpCUGxES01Ud1NM?=
 =?utf-8?B?VjZNcGhsSUtIMVJGa1d6bUZwVWxLMG41SUtMTVoxSUhvMk9TVnV6bWIzcXFQ?=
 =?utf-8?B?aEtJZkdDQS83MXJvMktGWlZrUXRwLzZhZWtiQlVBTnR4ZkI3Ry9WQndqaThE?=
 =?utf-8?B?dGMzTlJrQ0lxZ1Z1VzdVUW4zQzhyWFBjaDN3TGNTbXFRRHNXWXRBOVZHdG04?=
 =?utf-8?B?Y3loY2Q1QjNicExKQkVZdi94eGxFRzBnb3JUNzMwUUVFdUtiUUJWaDlLVWps?=
 =?utf-8?B?KzRGQmU0bmc2L3FUbjJmeFdPTVhuMks2Z2dYZ2p2QnlnbW5Vd0cwQ2J1L2tr?=
 =?utf-8?B?dCswODI2U2pKWkgybHhvL0I5NlVNdk81ZXd0aEp1UGtKRE1ZTkduaUZ2ckJn?=
 =?utf-8?B?NzVtZGdNeFRNeFpLenA4REgvdWF6T3B1cGpCK2VubmlCUzhtQ3hGekk3QUpC?=
 =?utf-8?B?SXQvY0plUFB4YURMbmQxemd5UVZ5WnF0cTZBU3VEWmFtbUhBemZhaFdQSmZa?=
 =?utf-8?B?cGxucTF5U3BydXlMV3E3RFJveUhKY2RsQk0zQ2NEZHI5cGxTa0NkbFVyNVZl?=
 =?utf-8?B?azg4WTRmQVlNd0tNWm5HWUZ4U21TbHJ2Ty9mak96Nmw4L3ROaDNSNFNBN0J0?=
 =?utf-8?B?eEROWktNWHdKY1IrTzdpNG1TOW5FVHlWMmpmU0RUWDRHRlZlbEplejNRaDJX?=
 =?utf-8?B?SlI1bFVkM052ZzBFUCtrcStaZXh0Z3NZUExYYU5vSVV5Ymd0S3FKQjcxcUwx?=
 =?utf-8?B?UXJyeFJpMTRQVVNVSzB1SkhlL3VPNW85SzFpU1NxS29sd2tmbTNkaDZjdXlm?=
 =?utf-8?B?TTlIRFUraUM3bXJ1aSsxUnJVVTJRV0RGWFRBRnZNeHQrTnRoTThKOEd6TTF2?=
 =?utf-8?B?NWlVWWU2UHBrRlVaaE9JVlBqYllwWEFRWVZhc3UwWmpETWdOMjNxSGptR21t?=
 =?utf-8?B?SlEzZ3FRNm50Z09pSmtoWXVaSmpqZzdTU0hWS0NGUm1XenJXRHFkN1ZMaFVM?=
 =?utf-8?B?ako5eTA5YzhEZ0lLNE83aFo1ZFd6OHovOXU0RGpmbEdXSTd3bml3SkozV2Vw?=
 =?utf-8?B?UGVXZkVPeFAyM3k0bnpidTRib2EvdDNhdERwMmgzbEZjcG5SQ2RkUW93UHZV?=
 =?utf-8?B?YnZEemdQcXZwQ09uZHZPdmNmNWlVZjVuVUJ2V2VkUXNTL0dSRm1GdTA1MmRn?=
 =?utf-8?B?WFpyaFhWRk5IQlAzNG01bTVxUStmbks4dFZIcHdGenZwUm5pYVh4MUdMcStC?=
 =?utf-8?B?OVBSQ2tDdVd5RU15ZFE5aS8vdWVGVXd1L01qSEM5UmxlZlZSalBvR2kxeU9Q?=
 =?utf-8?B?TGFoWXUyMjdlVEEyZi9CU2RROExXelFMS1ArdnJjbUI1eHBRaUF6SG15SmlO?=
 =?utf-8?B?Vk9WVlRvblhHZldYU0UvSnJEYisvOU8vN20wenZUWGhqSTVZQkhGVWp2REwv?=
 =?utf-8?B?RHFLMUJ4Y2tDWEpxQTE1QklISTZVNURMc1NGZzdDUzZnSmNEc3pGUVE3VXhI?=
 =?utf-8?B?WUl2VGFybEVGQkpWcXNhR0l2a0NoTUg2R3JJRkNhOFN5L0Rtem8vcTFCTSta?=
 =?utf-8?B?WjBnUEM3TG5ZMGxoWExqMHE4WHl2UGFtQXRMaFBNZG84Q2Y3N2h4ZFF5ZXdt?=
 =?utf-8?B?TzZGTjZKSnNDUUFGTnMvc2xYcmtuM2hjOVZCVWMzY0JtY0V1b05tUmlDSTlC?=
 =?utf-8?B?amJuY3lLeDhPaFBEcE54NDdPR2VHK1Jmd1RCdERmSHI4eWs0OE9jdmJha1J4?=
 =?utf-8?B?Y2ZvMG52VGt5WGJKQ0tFVUNUZ3R2K1Fqa0FOMG5uT1BHYzdhcmRXcDhCN25B?=
 =?utf-8?B?OWY1dDlYZXFrS2N1WGgxa2hYVkh3bC9XNUJadkR5NGZTMU9tb0pncExFdHFR?=
 =?utf-8?B?SVQ4dGtDSUdRQjF6Tmp5T0QxSE1raFpOcFB0UEhuclpLSzZRVXZIUXV4eWlC?=
 =?utf-8?Q?uErRQ0HwTfE/AyXpPYTuqDfui?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7385bc6b-10bc-4ddc-1ce1-08dcc65b4737
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 05:44:12.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysmkOa0Prtuw+iAD8+xtkvYukGNSAsCDDg6RK12TBnO/nPf7tRKysXSxosHzN2uW+OkReZnjn8GILgNJdKOzwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

On 8/17/2024 12:53 AM, Pratik R. Sampat wrote:
> This series primarily introduces SEV-SNP test for the kernel selftest
> framework. It tests boot, ioctl, pre fault, and fallocate in various
> combinations to exercise both positive and negative launch flow paths.
> 
> Patch 1 - Adds a wrapper for the ioctl calls that decouple ioctl and
> asserts which enables the use of negative test cases. No functional
> change intended.
> Patch 2 - Extend the sev smoke tests to use the SNP specific ioctl
> calls and sets up memory to boot a SNP guest VM
> Patch 3 - Adds SNP to shutdown testing
> Patch 4, 5 - Tests the ioctl path for SEV, SEV-ES and SNP
> Patch 6 - Adds support for SNP in KVM_SEV_INIT2 tests
> Patch 7,8,9 - Enable Prefault tests for SEV, SEV-ES and SNP
> 
> The patchset is rebased on top of kvm/queue and and over the
> "KVM: selftests: Add SEV-ES shutdown test" patch.
> https://lore.kernel.org/kvm/20240709182936.146487-1-pgonda@google.com/
> 
> v2:
> 1. Add SMT parsing check to populate SNP policy flags
> 2. Extend Peter Gonda's shutdown test to include SNP
> 3. Introduce new tests for prefault which include exercising prefault,
>     fallocate, hole-punch in various combinations.
> 4. Decouple ioctl patch reworked to introduce private variants of the
>     the functions that call into the ioctl. Also reordered the patch for
>     it to arrive first so that new APIs are not written right after
>     their introduction.
> 5. General cleanups - adding comments, avoiding local booleans, better
>     error message. Suggestions incorporated from Peter, Tom, and Sean.
> 

Tested-by: Srikanth Aithal <sraithal@amd.com>


