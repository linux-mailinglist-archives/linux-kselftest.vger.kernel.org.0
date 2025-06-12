Return-Path: <linux-kselftest+bounces-34824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF2BAD74EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B3C3AE37C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D460269CE0;
	Thu, 12 Jun 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdBMQO8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EB15278E;
	Thu, 12 Jun 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740288; cv=fail; b=mHdfB/o0FbkMLjTFj3IfmrpQGiDQgyBZeOFTHwUGhOUSmgt0qV52gckhGBZe8+8H1mSlsLR4jsBRAeIvox/nzqRs54IqvmrZLfKdpUHGpOMnDf4tlV8VPyLdEcGnum1SnC8uB3u6p7Yb6KiQawuCmfXmSpvr8fTJZaLqtbkwnIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740288; c=relaxed/simple;
	bh=haoZEuVif0U8PzYEUzzDUsgLt/gxsmJLCMZwi3DVA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2dqRLpredlJYc6fPXQCxs6D8/bfZzcCwxHvliQjmVcsJ1mUnkfc19cOds1jNf5Ze40VQkAXGaAD1VooZNAbJ/+LGEgA7n7GhgLJNhO7QWMTCGAjeoV9tHthUoiFC3puDV9zYiEy9GZazr1Rj37Qbb9OI+xfQeXeoyjAoWuupUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdBMQO8L; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLN/2nNvcy4lHyG0Ap2rg44zYjYaqbM0qr7MpuXZ/9EO9s/zqfh5UDNHzN9ZNu9PO0s/mjZtWYNJA0DGOmLi1sXRTwWcyY0wNzUPPO7/yf3OdLG9lSfs3MtE/xjZ2gUHO1kpH2tSV17k8aAXx9eWYwdDeUMgixPR4rWvAMrxgwGR5Vb3xXiXu9HynC4/9PoxkTJ/vHYmwti0ZtgnOMLTgna21BX+dVCdYpIS4jRkXt8FNIElHa6XjZj4+MYqdBlzrlu72eZ6NI+WTF9+pta+JtfwWt6yfEfN5j06BUsvsJ4/rnuYcK/GNUnS0Fr9m/TJsG+BzH6o4JhnVWxkxqSqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyXKRdn+sP5RbJid7nW+/fYoU/Cpt7kw30UBWrGbRfE=;
 b=QT0di8ahFhMmZKgRbTzmxoZCXOJhgkJFJorpyIIRVCf9CyHBYpp/kdgzoaoeauAKew6dmvVrL8K/lHqqevPfaJvnWtjQ3574Uj3fHoto8QqYwlCRph2J0dUJjFzJcsiFW/vF2JS/a/k9SmDAbbUVaaFq7HFDujSAltm5W0RlmA16UKrL70bGvFqH5VKvz7+OQc8Qd737tjpUpbDkWZKn9uL2MicvxnZ6urCet5vrsQZt2i7WrE+85CTd7zsXDApzHJXZSSadpgOp2Tu4c5QZB4nc2YWgg+UF4+KLIwvdNDWIHzF7fXGd5vzIKZ8NWNlfIvAECZ07s59fatfR0hGvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyXKRdn+sP5RbJid7nW+/fYoU/Cpt7kw30UBWrGbRfE=;
 b=cdBMQO8Lvt24GjItYnJMc19usYy3ZQs1CvxkL07ONHhqLH4pLYTiV/O5z6fEs7/Aw6V5flFil/InFLQysNhRn1dCRyXLzHd59b80lJG2BYHhn2sCr1E2R1FQ12zXtQz4oOszi9Z7ZzWKdcHhy1MzTVxEYKn5CG8otzllspNLttFEPytSq6SJ8ejS8oJjNX9rxSmIOTndyiIzh5bWYbY6aF7Wr7ceBaVQDOO0hRXIOB2T5k7BkU6FZYUFxkY1oVJkzj13Elft7jO4YO7vaGEo400xk8tgqId9lI/IgoJ4pQNUzPIt5J9gsM5/o69OtWSMmj96VouVcdH+EpM0aHwlSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Thu, 12 Jun
 2025 14:58:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Thu, 12 Jun 2025
 14:58:02 +0000
Date: Thu, 12 Jun 2025 11:58:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250612145801.GV543171@nvidia.com>
References: <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
X-ClientProxiedBy: YT4P288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fea7d0e-5a0c-418e-b9eb-08dda9c1876e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWVwMGJOTVdIbnUzL0FrQmFuWUY5UmI4cVJyQVY5M2svSHR6STdjZ0ZFcHE1?=
 =?utf-8?B?ak5iSFE2MlNZWDJzanlHQnZlVk5kWFRQcFJhY2xSU3RsL1FralpJUTF0WW52?=
 =?utf-8?B?TkFFQlFRUThndG11eVVvem5Ndk55RmpjWkRDK0pXNS96QnI3UERBY3VpY1Fj?=
 =?utf-8?B?MWRmU3YxckdzMm5WZXNKS1kvTVNmSDVZK1hxa2lvQU1qU1RIRWxkMmhPQ0NK?=
 =?utf-8?B?U3MzaFpuVkN0MVhMVzZmQkRJZDFiU2V6VFVaNU93S1BQWnN2cGxieWR6aHBv?=
 =?utf-8?B?aGRMN1VOdXZiYWdwRDU1TFhDckNRdFE1ZGxCdlVsOXNEWDVKREwrZC9IVTdC?=
 =?utf-8?B?cDhqWTkvT2dmNWs2TmZidUdvc3o0aHBQYk9yOE5DZno4MzJqLzRrVFZraUhh?=
 =?utf-8?B?cEJOZFVEdkZ6dTgrVXVxcWVxVmlERWxLZEJCV2xKdWxxenhTRVliT0cvdW9Z?=
 =?utf-8?B?Q3cyODJSRjBrL3NiWWlGcnpLTzZONFJXd1kydjVhNG5sWWxCeUtVTWZuTzN6?=
 =?utf-8?B?SUxLZUhjMTR6S05SY2pVZTkrSlhnTklsaGlyemF3eXhzUndmRkYwSzdtclN2?=
 =?utf-8?B?c0g1S0JHdUxpUVVkNmh1cjhHbmlscmhZNzVNdlJKaE1jQ0pDalUzSHNXdWJo?=
 =?utf-8?B?NURmT0FoOHBqVVhXaUt1cnpLY1J5K1piTm8wY1M2YVY2S2JsK2xzQUJ4Y1Rs?=
 =?utf-8?B?RnB0TCtRaG16bjVYS2RqaDgvVDdNOGZjTmlDeVR3djVsL0JXRldOL1hnc0Q5?=
 =?utf-8?B?cDdFU25wTW82OElOdHluU05zZkM5aTFrZlFseU4vYy9ibUlEbFdIKzFqbmlY?=
 =?utf-8?B?YW5yYkJ6K090Y3RmbmpiK0cra0xIUURVOHRsdVUwUnFZd1hsbUgvdEJKanlw?=
 =?utf-8?B?bU5qcGkvUzM3UlFvOUV3a1B0QndPVGljTU1JQ25pQUZ5MUFyMnU1bDRMcit6?=
 =?utf-8?B?Z3g5R1Fkb0FaN28wMkJJV3VoTjlGdEpkL2pMMk5JMDR6S3I4dG8rOXpObkJ3?=
 =?utf-8?B?WlZsL1ZRWGtiUkIrOVF3UGk0NWE3c3Y0N0ZSMGlzNXZYbmd3bmMraUtUM09h?=
 =?utf-8?B?ekR3M1BabjArblBKNU56dXo3OWNVSEloQy93VjRFVktUb2F0b0UzcjlBYWEv?=
 =?utf-8?B?MWt1TFlrUUVYV0k0dXUyTTRSWnJFOVhkeGVQTmo3YjRQTU5BZTk1L0xTcDZP?=
 =?utf-8?B?RmMvZCtlYmNYN1RkV0tTaFdDb09vb0ppMCttd1JKNDRkWEN0YWVYc3dhcmI5?=
 =?utf-8?B?TWVPRnlXRElEU1RBNW9WZVl5WW1MWXEwMHBOeENBTW5pQ0M3Y213QnZVSjBt?=
 =?utf-8?B?UXVuTHYxY01EblYwYlJZK1NvOXVBekN2YThleWtUYUtqTEJQQVRpcHBpbDJq?=
 =?utf-8?B?dS83bVVORFVnSWVZN3dEZHNocCt5cng0TlpxRUcyZU9DbEJJRjBwSEZXbEl0?=
 =?utf-8?B?UTNFaS93ZG5tYXZEVCt6cnFiVlRMenlLTkovNWo1czJYVytKcU8wRDVVODBP?=
 =?utf-8?B?YUVzQmFqcDJwUEF5SXdkL2FZcEVtNEFlanZUQlI3RllDWUNrMEhUR040UmdC?=
 =?utf-8?B?N0ZHcGw5V3VsZFFKb1FGM3FGQzB2bUhHQnp3SkFmdWxVUjkyY3llTGd3VlQr?=
 =?utf-8?B?MmxoUy9LTUsyK2RLRWViOWtyNFNqNzNLNk81NGliczBuckd2VC93OThMcGdE?=
 =?utf-8?B?dXdYTXZaNzVMZW5hY0M2VTN0bE4rVmgrTjlqcHVtYTMrakg2Y1E0aXFYVVNK?=
 =?utf-8?B?OTYzZzZmS2V2MUhDU1Z3RUMrUEJoUXcyV0R4aU1IbHNURjVwQnAvUVhGRG9L?=
 =?utf-8?B?VzRPdlh6RkdjVWd0SndhUXhYMnN4bzNPdFI0Njg0RUxpbjArbml3WDA4VmQ5?=
 =?utf-8?B?bUJqbVhnZVcxbFR6QlZqWmtaT0VyaTJvSUJuNmNIQjVxSWhPUExzODV2b1JU?=
 =?utf-8?Q?4g2ojnGGJRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUFZcjdMK0tRZ3EwWU52cXBLL2NGK2hpU09hUXc1b1pKZjA5OHc1MHR1Yk5S?=
 =?utf-8?B?WW1uNXNyYlJPSGF0SHJxTU52djRuOW5NZFJnMXV2WmNYMmdLWFVDZGtFQkR4?=
 =?utf-8?B?MnRtMXVoK0Fvdmg1d2tyOGtPN1owcVVDaFNkNmI4d3lmakdpcy9HUlNtbWNU?=
 =?utf-8?B?VVNWZGdHWm8vLzdwS2R5TjlRTzA4Mml0QVZVZUM4bmp1S3dPMzZpQnFaR3BD?=
 =?utf-8?B?Ri9pY0E1QmV0Z2lmVE04R0FLNmhDK2V1OWhLTmNTYmF5enBPQjFOR1ZHR1Fm?=
 =?utf-8?B?NWJPUFBtRUZiWEhjaWpsUDlqU09sWUdMV3lvQ1Y3U3hPeUM1M00xMkVjcU9x?=
 =?utf-8?B?RC9rVnRFTjlXeVlzRGJRVDkxR3RMQTFhemhrSStCWG5ESS8wQlo3RVAxS1R4?=
 =?utf-8?B?MXhacmdNaVRpNTcyQ2Z6WkF4R0hOQWY1b1p0NEJ1RTk2TGF6dHkrSE5jRCtv?=
 =?utf-8?B?a21QMXBSL01hWThaU2cyQ29vTHJYME5UcUxPSk5wcE1ISnZYYzZ4UVA4NlhC?=
 =?utf-8?B?a0Z4VWlzV29pY041N3hjV0ZMK0sxck5sMHRIcjVhZ3JyQytNRDNVcWNlbngx?=
 =?utf-8?B?QVg4ZGxWaEk0L0dWWjcxWmpOTEZQWStuLzg4VXIya3hkMVFsNndtSUJ6YXBX?=
 =?utf-8?B?REtwbFBjK2g3WlZZU2xGUi8zYXZqcHZSSk53SXpMY1VOdjhwaXdRcWNYUWp6?=
 =?utf-8?B?UnN2SEFZRXRjVTdXMlNyTnJyWlpua0VxZnFKeDRPdmFLYjU0a0ttUjczL1Fm?=
 =?utf-8?B?Y0xpQ1hlVWVrSElLa0FJWHk5QWFtV2M3aTVJOTlQYVNIcng0WkN5VWlUSjRZ?=
 =?utf-8?B?TUVBOG9oZjNaR2pYVWx2bGEzaE1IUHdvUEFZbzJKZnNaZmhuVmdyVVppZmNE?=
 =?utf-8?B?UGlubmNEVEpzMmhNY2ZSSm5XV1praWZrT1JoWVFyMVJsbVFhZ29RL1FVdldL?=
 =?utf-8?B?NlR1RlJZd2dHei80RVhOSUR0a2xPSTg3bThiU2psVEhkQWZZenRNcDY1NHhl?=
 =?utf-8?B?bXRiZzBXMzJFZXJPMHdocnBMYkFnZnBIUXhpSmdPa1d6ek54b29jamdCNi85?=
 =?utf-8?B?S2cwaWRqaDl1SzlGUCtLZ0JxbkpIUnZDNHBBTzJiSVBHbEgxQzRLamZSNGJo?=
 =?utf-8?B?eUQrUEpKVGl5bW5jT3FKZVVqZ0NSZjdyRVJwSXlMNTZoa1JPYjladGpjKzFT?=
 =?utf-8?B?eWVCdEw4MHNoaEtJTmNVUTkzQ0piMWpuQ2dZOGVrdnNRTGRsRmd5ZU1IVDdy?=
 =?utf-8?B?a3VTUVpJWmxoSkpLcTc2TE9aL296S3E3NWlhd045Nk9YYXdoUTEzM0FPZkZx?=
 =?utf-8?B?YkI1VVlMNlNnWnNxYzJxcDdENFZCekxQczZjNmFZRVJubkd0Tkg2UnF5L04z?=
 =?utf-8?B?L2JhZENRMVNkZFRlRUhEcSsxZkV1eVRjdDArLzVJM3NtYXlJeXE1MWFjYUdN?=
 =?utf-8?B?Z2MwQzN0ck4yNk01cVY5eEZRY3hmN05QeGptZ0JlUGRWUm9UM3NCSUxWRDgw?=
 =?utf-8?B?M0ZWNFdUMm9XdjM5UjlnL3RGTjVQMmx4Y3VjRUtNejg2eUVjNjRvY21xd3RX?=
 =?utf-8?B?bm5GS2RQLzFkQzd4NmZyM0JoVVA4TkppMW84MlJHVkczU0JTYm9qY1FhS0Zv?=
 =?utf-8?B?RUU3V0R2K3Q2MUV1TTA1Y1o2MHZmbktmdm1TVG1ieFpmSDRzeHNYVVhvb1NM?=
 =?utf-8?B?dS9IYmZDY0lIaWFtNzdoSTltZWdNQ3M0ZkJha3J6Rms4MUFubnZxS2I5K0lr?=
 =?utf-8?B?THpzMEZubk5EUFVJSHlvNHN5ZWZVc016RS9zZ1RTQVFTR0g5c3ZrSHR4ZWUx?=
 =?utf-8?B?cXFOOHZXNG1HWmxpZjVqYzEvZXIwdHlVOTZselZrQkJKS29wczA3YTB4QlhL?=
 =?utf-8?B?UnJXdC80Wk5DNHk0dVhld0tRcGZ5cGhUclp6VGU2cUxUT3FmSU5yM0xWcGNM?=
 =?utf-8?B?S0xLR2gvcTZpelh3M0t5UGZ4WW1hSUNEL2lWUHM0czJTUFI1SDc4RjFOeXBW?=
 =?utf-8?B?QUpOdm9tU0JVRGl3UUhWbTNkOE1JYXZCWUovTm9abTM0T3JTNFJsdUdYL1NC?=
 =?utf-8?B?Ung1R29LaE0rYXpPVUdkcXdoaEFtRnZyT0lNQWxxWFcrREJlR3drV1BhMjc2?=
 =?utf-8?Q?jH49+dhPbkuknLLT3iMFnUjlN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fea7d0e-5a0c-418e-b9eb-08dda9c1876e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 14:58:02.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH9drIbN6wRxPWtg6YueorqmDrbiEgeo8WSAuA4E5EQKnhmPyClEjUrtiwqim0bv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778

On Thu, Jun 12, 2025 at 04:27:41PM +0200, Thomas Weißschuh wrote:

> If the assumption is that this is most likely a kernel bug,
> shouldn't it be fixed properly rather than worked around?
> After all the job of a selftest is to detect bugs to be fixed.

I investigated the history for a bit and it seems likely we cannot
change the kernel here. Call it an undocumented "feature".

MAP_HUGETLBFS rounds up the length to some value, userspace has to
figure that out and not pass incorrect lengths.  The selftest is doing
that wrong.

> If the test is broken on ARM64 64k in general then I am also wondering how
> it didn't fail before my change to the selftest harness.

It got lucky and didn't overmap something important.

Jason

