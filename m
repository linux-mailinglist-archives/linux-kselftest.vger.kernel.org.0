Return-Path: <linux-kselftest+bounces-22753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF39E2040
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAAE28A0CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B421F755D;
	Tue,  3 Dec 2024 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0Uo6uzK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170C13B5B6;
	Tue,  3 Dec 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237774; cv=fail; b=f7Ve2MwCb9GQL8jPuIXWZ6AZ6CBypGQnj8hAk6BrjEZk/9F0GOVS784xqrkQl9ZubPx4Z8c9HORkEuGiaWA3UnM2SA32gWpbCM8laS02dkHtDXj0apvuw/JYgGIrNbL2bpNevbhYhNvSQ6nqk6zfzff6AGBHv2gS33nEUpoLiVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237774; c=relaxed/simple;
	bh=ZbJF9uJuAtN0ZXeXjD5loeifOlGrKRSWvbbpXdI1ySI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tqm6HzZwSvxl0X2uuaQiWQ/Iiue1Yr7LzEC4ywmZmNUD8u5kphiqm6+gUvvHKZxu1uJRN/md/Ft/DrkKfpS7fONjRlqSOJDZWqUNJiBz3nPL6FBhwwGv+N8z71HZu5mz2RvYvzxE0HkqeJeOfH3ZxKd1EK+yzt5qY+2CSVF7XQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0Uo6uzK; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkV2qAimWlvTTVkJ54Mx5X63mncNB6UsfFlDFignxCxgXUHikYkfpChLREwN45ctoV52xn3SK61ugl0VfW8/lMC7evV13oitgMUpWWjniJi/KyfwmS+UoJ7e9121hTdfw0kLX476WcCIlp9INSIdk3kWsOHVQYH/5cfoTN7l/N2CU88V0SJAtrEneNnfCshWYIW+Ig7RTh8Us+j3b3WCNk8CKeoUAxrMd9uZ6OH01ePtqjv80etAY9Ll1WxuG9Ces7oKtcdZqbb+QiRoi+q8ltumQX5MAHwIz9HDPoJsm7YznleR2uLO4svv/wjRMWJk+WcYTUOXt29xVWZYgNVd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzdDLkp2JcpJLmlCoY5b7KnCSkGGIdZ8V6KrG5nH53U=;
 b=K0OGsbhYoVFd5l6Fp4ZoSlyaCactV6ubTUQwl5qbCaXHPl/2UD8uNJpvEh+I33LYTN32R6gJCH38mr60JoFhtpRS3LdlG6hSg+apoLQoiXzme0jtKVRHBrmXlFLA/DNDqWdPYniU5IXH9nRxm7+0/aN4riz1bfiDnFUDVozmCd1Vkl4yL0rAgoqbck+O3QhY7JFPY4AJHhAFHRhEsHrLxShiylubCmMW1mdIv1H47Am2QFeNWflDlIDibT/7MWJ5IE32Rc2dsRKJuA20JiJG4shoFzyMEBkOgIYnwbt3ZsZtbZgL06DRq9Snbw9RII1bmZsGicSLznzh6V1OIxQj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzdDLkp2JcpJLmlCoY5b7KnCSkGGIdZ8V6KrG5nH53U=;
 b=V0Uo6uzKOWMBlAUIrkEbjJUsbjdNehv4IwMM2Kcg63nwQ4qbB794xeI7ozxizwHHYJqiAytJP9M4QY9tAJEN5w6iiHFwtAkIumTDX+UWuCxpvgOSnmL+9t2lhvdozZhFxSOT/LRnEUv60/xFvDrRa0m3kcf/2DKjuTEs7UkNr4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:56:03 +0000
Received: from SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca]) by SA1PR12MB5672.namprd12.prod.outlook.com
 ([fe80::60f:5e8d:f0da:4eca%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:56:01 +0000
Message-ID: <03530f39-8abe-4c24-b5a8-3b6f91eb1c74@amd.com>
Date: Tue, 3 Dec 2024 08:55:59 -0600
User-Agent: Mozilla Thunderbird
Reply-To: michael.day@amd.com
Subject: Re: [RFC PATCH v2 1/2] KVM: guest_memfd: add generic population via
 write
To: Nikita Kalyazin <kalyazin@amazon.com>, pbonzini@redhat.com,
 shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, david@redhat.com, quic_eberman@quicinc.com,
 jthoughton@google.com, brijesh.singh@amd.com, michael.roth@amd.com,
 graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
 nsaenz@amazon.es, xmarcalx@amazon.com
References: <20241129123929.64790-1-kalyazin@amazon.com>
 <20241129123929.64790-2-kalyazin@amazon.com>
From: Mike Day <michael.day@amd.com>
Content-Language: en-US
In-Reply-To: <20241129123929.64790-2-kalyazin@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0101.namprd12.prod.outlook.com
 (2603:10b6:802:21::36) To SA1PR12MB5672.namprd12.prod.outlook.com
 (2603:10b6:806:23c::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5672:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6b7e40-2f5b-4de7-c7f9-08dd13aa9a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1dIQ3dnTVVnZDNIbVFxNUtiSXRFU2grSHhSVEtSek9KL0FQV0hrNHc2K2p0?=
 =?utf-8?B?MGtvWGtCVWQvWVZLRkphMWVXcDBVaW5FSUlYSk5LZlZWUi9nZ0ZiZFJmUXdM?=
 =?utf-8?B?ckIyUW5xR0d0REVIV1N3TWI1YmlOUGJZOVBYNVI5bEtlYlozdWlJa2x4eEFo?=
 =?utf-8?B?a1JleVpIdGFuWVRVK2NOdWFrS3VqdHBISllpa1RtMHRYTU1kbTVaY3hRTVZC?=
 =?utf-8?B?ZUVFdjFZK241MFlNUW1LSG9XdFVJMDljMlR1NnhDTitpa2dOa2w0M3JvRlpM?=
 =?utf-8?B?NGhYd0Y0dFhnV0dLTWdLcUxpODV1TmdYQzN3eHE1RGhZbzBNV1k0djh4eVhh?=
 =?utf-8?B?NWo1bXhVWC9qd0tueXptRDR4OE0xQTRhS2dyQkNPSjQ5V1MxUmxEK01aRWZH?=
 =?utf-8?B?Q2t4YVU3TUxVLy90Qi9zb2xqSkcyR2xKZ3hnWFhFQVlQNHJUWGF2eDE1akhh?=
 =?utf-8?B?WG1NbmxScUdCRG9ISjBLUERXN0FpRElza2Jrb2Q0YWZ1Q2lDUjNxalNEUm44?=
 =?utf-8?B?bXFORHVMRFNGUE1ESk04VlRpdjNQUWp1VkZFNkV4UC9CSWR4Q0hKTzEvS3Jw?=
 =?utf-8?B?L1RWNSswcU1mQ1lpZ3VaWDNIalhlMUU0V3d2V3pZSlVpcFFaazhIWnFRSk5t?=
 =?utf-8?B?TkUxYmVoeVZ0elNYS0FFN0hJTkdtV1VmdEtodnNaYjBuYnJzSVVTNCtjNGVJ?=
 =?utf-8?B?VEdUdWFjSzlQOFNtMzlmTVNRRm5PNTlHTXpDVkJKV1daZHZLRG56V1VZY054?=
 =?utf-8?B?dHlSbWk3MmdWYm1Wdysxa251M2pzT0Y5NmRJNVMvdzNrMG1aMGg1VHFub0dt?=
 =?utf-8?B?SHpyamZBaVdJdE02UWFVYWh0dnkyUjFteVNwQ3g4WEM5SU04cnIzWTJ3bDNV?=
 =?utf-8?B?Vmk5VGs4Y3k4L293VTZqYmsyYzBTd21jNldVTUtHQzJvMVl2bnhXNU4zWm04?=
 =?utf-8?B?dDZSUTUxZXRDSnpWNTl3QXpuVmF1WExzZ3FPdThvb0hkUFNYTmNGYitkSnRD?=
 =?utf-8?B?NkU3UmpzOVNPVStnQkt4T01Fekp6YW9KWVcza1Avb1pMZjVjQ0wvTkhvYXAr?=
 =?utf-8?B?bVgzdnQ3TkJMQ3hhVzhuWDdhTDZHQ29ieFFpeFlqMHJhVkZHSElOdUVyU3hI?=
 =?utf-8?B?NmFXQVBMbkMvMGNidysxamNWMXBhVk10TFRiQkNPOFI0cEZhOWp4ajBBZUY0?=
 =?utf-8?B?c09RQUtQTTllV1pVU1VLazByc2J0b1VqZmE1UytWTnQ1akgxVHE0OUcxL0FN?=
 =?utf-8?B?MjVBeTR5VGNpOG9HcTdMamxaS0ozcUgxTE4xR2FmT29vWFJNQmFiSXltbmFP?=
 =?utf-8?B?TTZEZy9oS3AvMWJMRjRwOXN6YTBBdTFLeUpIcHVpZDEwY2pQU0IxNCtIcWZ0?=
 =?utf-8?B?bkZrMDFwVFlrajNVMkU0SmVXeVliNHkxZitEVjZCK3hhL3h3N0xSU2ZCR3Jx?=
 =?utf-8?B?WjZGY3lLTEw5K2p0T3FUTlBZTFFkSkY2aEg1amNmT3RDRDMyOWlxTVp4b0Ju?=
 =?utf-8?B?VnE3WVM1ajNyRHlZb3BWRDBnNkt0RXdiaXJkdVZrQzdlWVF5Ulp4TzhndmVJ?=
 =?utf-8?B?YWNiaVVSMVRkNUFzL0Q2cjV0Z0t0a1ZIREhBRXVmdUQ1eHlUQVdRVjJIQlI2?=
 =?utf-8?B?Nk1ma3VJUFAzZmhaWnlpTnJkUm45clBMN2I0dTBlQVNVZ0RCOE9yZktYYU4z?=
 =?utf-8?B?KzB5NEpoMXlCVjRRd1ZJeE1UUXhmZUtxbHl4cDEzV1JPOVNLck42bzFyenJs?=
 =?utf-8?B?MW1lT2lRR1p2d1JSN2ZndE1VOGEzUWlpZU1oblNHaXFjUmZPSm4zL3JTbitG?=
 =?utf-8?B?RlVTKzNEa2ZsUGVodktVQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5672.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cERGNzFmc0ZablpjWlNWWE5aUFBOUUVEclcxTmMxMHNHdDNwblA5RGtaQXF3?=
 =?utf-8?B?UmphNE1Pdit2NUttZXphZnlQdDY1M3AvelFnV2xJaWVzcDB0UnhQSlgvT25V?=
 =?utf-8?B?L2NjYnZWVEt0eEZkYWZOM01FNEJ4bUJOSDc1aWZMUjZnUzhLSm0wUitmWElx?=
 =?utf-8?B?RjhHNGU5OEljVGFQUTFUYXBUQTkrQ290Zy95c1Jzb3dMZS9LWWpmbFBiVkRj?=
 =?utf-8?B?SmQ2V21NNXJxdTlHVWNUTXBqNTRsOVZvbFlMWGoybHAvU1VraHo1aWNaMVV6?=
 =?utf-8?B?ZGVoQXJWT1BUZmY0WCtUQXZEcnpsMnhvMmRXMnJ2NStYME44YU95T0wrNVRF?=
 =?utf-8?B?TVF2REZiVUE5MFEwdGpUazlySlRtaTNMMm1zZ0Y0dlRKYzYxQ0lRTm1PMW90?=
 =?utf-8?B?YXlvOXNlV2x5R2dtdXp5OXUyMUlqL0dsYnlGcUppeUZoKytEVmxaUGRSMEho?=
 =?utf-8?B?VEcyY0FLOTJNb3l2cHNJRTR6S0Fpc0JhWW5FV1lqUWt3TnprcGFQVWdRaU1V?=
 =?utf-8?B?Lzl2c1BsN1Vlb2Y0NEFhQWJ2WUx0OHlWY0NGZDBBcEh5SmN6NkdOejlEdk5t?=
 =?utf-8?B?bndvc1JwS096YThZcDVqM3lOL3drb01SQVpzZ1ZuY0pOSWkrVVlYcjBXSFNY?=
 =?utf-8?B?RlUvWE9YTzlxMTVBb1JLZUgrekxYT3RtMVB4Rk5pTHFjbkRNMi9jV2xzaGV6?=
 =?utf-8?B?YUlmVDYwR2RiNElHbVZKdmhzSWF6L21wa2lJNGVIN2RaYXNFbm5iTXZkMzBE?=
 =?utf-8?B?OEdlNEtsRlk5dXVTZml0aitDclhQTU1ySWdmQVFEYm9HdTFNdE1LK0NibVJr?=
 =?utf-8?B?ME5VaFVRMCtBUm5FcEVEamtQNlFWaXNjaldCV3UvbGtPM3kxTnRzQmZWNzBo?=
 =?utf-8?B?SmtPRkhONC9Ea24xN2N6TXFIODQwWSs3R3o5aE9zc2RMYTZIdXRGZjJ6QzFP?=
 =?utf-8?B?dTVqbkNvZlp5cDAwSkVuWE1VeDBxcVA2NEF4Z0VkRTZHMisyS0dveFViVW1v?=
 =?utf-8?B?Z1JTVWpHaGRXMjZ6aWFpTmQrdWJjczBxVno3dU9vQW10dWJiV0dGOUw2S09U?=
 =?utf-8?B?bi96amh4RUJMeVEzSXgxdU5aeU1Xc1VoV0JIQ2p0MEtocDlLaGNDYkZsV1do?=
 =?utf-8?B?MkgvN3hMT0k3Rm1XN1FOdVh0QXYzRXo5NmcwejVxRUtvdWhqQjkrMGh4Rkln?=
 =?utf-8?B?VlVXRC84aGhwQ0tidFZJaUNva3dDMTFPbTRvb1dFOHp1MVp4UGtkNEtHdm1w?=
 =?utf-8?B?N2hBbmFyaDAyazdkZ0U2U3g5M3BhZGhGWmliK3NZbHh2VnV5V2hQN0VKdTZq?=
 =?utf-8?B?TmtKQU9tTTBjaUtUSHlHQUFYVzJoMlZFWlFlb2J1c0ZrN2ZPZE90LzJYMnZP?=
 =?utf-8?B?Wjh5N0UyN3Nzd2t6Q2hoaVdNdk5GSjkyOGxic09LRFQ3N0hXNmN2Yng2akdI?=
 =?utf-8?B?WlU1VTdleFh4Qk1mR3ZkZ0RmSFVDeFdpTkdXNWUyRmhNL0FhK1Fxb0JXeGJJ?=
 =?utf-8?B?djJ3b1R5WEIxMXh2Zk9uWGFKVkVOekc5MG44STBXd0hUMEE2UzlCeC9ia0dR?=
 =?utf-8?B?azdDQnRjeUNrcytsYTJCRmZESGtZTVozNlZLNXJmSjJ6NDFyNkZNUmt1NTdS?=
 =?utf-8?B?am02VXZUWVYrbTlFazR0ZDhHTWZaYkpoektzYVpwSHJxd0JvTS9kaWJlMFFG?=
 =?utf-8?B?ZXFkT1c5T1lXditMa0xNbTdrMkZkdEl5dXA5S1M4WEFqUG5nQlpwemZxR2ND?=
 =?utf-8?B?bmt0cVM5YW4yaXVJZ29xSDhkS2ZDTk5CNHNUS3o2YncwSmFQUWgyYVFMYnVt?=
 =?utf-8?B?UXlUdWJvT0VRTURTWEZmNFVPc3pOOFdPbkpCbTBFN1hTWnNoSWdISHozRGtU?=
 =?utf-8?B?TUQvWmlLZHBwY0F3VHQ0Uk9lQ0VBS0NnTVFDaTZZbkV3cnhWVzRqQUlZSlgx?=
 =?utf-8?B?ZjVOQ3c1L2wxSFpqSHJSRFBMUTlxVGJhK09kbm9aeE4vdDkyUGFXVnkvOXQw?=
 =?utf-8?B?VTZYSEk4cmFjWmVnSjcxUE00U1psTE1VbDdVMnNPMmlZVEttVUpCOTBMMGFs?=
 =?utf-8?B?VDMvOFEweFVSNGE2M3BzeUx0cms5NG5BL2NYOVcrQXQ4emF3SzVheWxFTSsz?=
 =?utf-8?Q?8jqWqm/OA/aVUlXB+LAzkVQ1c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6b7e40-2f5b-4de7-c7f9-08dd13aa9a83
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:56:01.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOjBRzNTZQbxbvXo3qBfEoMO8oj0EeMZ+OoKbd5UbKUeTEf6E+bTcR3iAn8v1rAdhmqfQkpIleFuACrNJQunIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

On 11/29/24 06:39, Nikita Kalyazin wrote:
>   
> +#if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && !defined(CONFIG_KVM_AMD_SEV)

Another option is to use the confidential computing (coco) attributes to keep
the write operation limited to clear-text guests (diff against patch 1/2):
There are a couple of benefits and shortcomings that I've listed below the diff.

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 9aba0ba25276..b7a0c7f2f82d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,5 +1,6 @@
  // SPDX-License-Identifier: GPL-2.0
  #include <linux/backing-dev.h>
+#include <linux/cc_platform.h>
  #include <linux/falloc.h>
  #include <linux/kvm_host.h>
  #include <linux/pagemap.h>
@@ -274,7 +275,14 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
         return filemap_grab_folio(inode->i_mapping, index);
  }

-#if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && !defined(CONFIG_KVM_AMD_SEV)
+static bool kvm_has_cc(void)
+{
+       if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+               return true;
+       return false;
+}
+
+#if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM)
  static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
                                    size_t count, loff_t *offset)
  {
@@ -290,6 +298,9 @@ static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
         if (!buf)
                 return -EINVAL;

+       if (kvm_has_cc())
+               return -EIO;
+
         start = *offset >> PAGE_SHIFT;
          end = (*offset + count) >> PAGE_SHIFT;

@@ -564,7 +575,7 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
  }

  static struct file_operations kvm_gmem_fops = {
-#if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && !defined(CONFIG_KVM_AMD_SEV)
+#if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM)
         .llseek         = default_llseek,
         .write          = kvm_kmem_gmem_write,
  #endif

Advantages:
  * works with multiple architectures (powerpc and x86 so far)
  * enumerates specific types of coco attributes

Disadvantages:
  * The platform can have an encryption attribute but still be running a guest in clear text
  * Some guests could be encrypted while others are clear text

To remedy the disadvantage, the write function would need to check if guest encryption is
currently active for a specific guest.

Mike

> +static ssize_t kvm_kmem_gmem_write(struct file *file, const char __user *buf,
> +				   size_t count, loff_t *offset)
> +{
> +	pgoff_t start, end, index;
> +	ssize_t ret = 0;

