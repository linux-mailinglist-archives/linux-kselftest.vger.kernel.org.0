Return-Path: <linux-kselftest+bounces-32366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8466AA9702
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00061883EEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361C25CC4D;
	Mon,  5 May 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VWu8nO+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491FF42AA5;
	Mon,  5 May 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457864; cv=fail; b=gKDta7RgbLZsAy1bnrNjUH193JV8pLcK4M1KMT7Cztv3W4sTG/uI6zeQhS50OPszNIz29ZSJyZdJELeQbqkqEEwHjQU6PYQGqo4Ws6cQWvMWoOVYVfx/J3mnC7bIsY/N425fYzHFCceyWclrPDnd+iUCGcznHJNilGjYOE1498I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457864; c=relaxed/simple;
	bh=EqYa5hgGpdOdXRdoTWDAhcIAQJVpbaouZxizB5Obrfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c4WNH8BWZ0rVmHGtm0NRSB7jTZtiQretRPHmMiEuVF7uliaav/VvW16TUORrv5jCGy/QifbhP++rICjarbQi9I05bRtlObGMVsZcWGJTAsy1XQGgEWmXkrS7seYnbzq3opyPTvf+YJ21NnaBxszyCt+8UvuYU9nxOCa3fiv8sFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VWu8nO+E; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf5XoXlusq8taRKTwU0xr87eeMgaD6NgH55gPQb2nhQDu8I/hgO9cAWYLF4Wqpn/RATPQT9+XqXstzOB9rySnj40Ghizesh1/uiPzk+xI0aeZqX8jNPXumyo8Q6w9rKsFx0uk/Z2AFPO63HQQMMrV3JrDA+O0YxGbdMbZrc8W2mEe8xtnVcFFHQgQcmTEFRMyXoR0708GI+fIQtVqLHzy7kWFsBSWUsFoOFJiEfRO3EG+R2PyN4e0jNqIVf1BtGgPwdoHoyhlxj2Ts4vA0t6QnTnXaeDzZFR7D/C7QGTP44NvqjPxXmBp10KR/VVfC6wXrzMD6Wi2YlR1SIA3oX5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNFFE9sIZagEZtpPzr9VAIEZ/9ruuEZoNoR3wiONmGw=;
 b=iTKUq8xhw1I9EWGh5XnEY5hEdUdrmYbPyi7zcjaQbmRecAveI1RUaE54mNDTs28g/l3LDEMbrJLnlAyFo7360Inl/SKwcSLgbayUrCyR4Tq67T7u4wyfkynsLb3UlCkfo/C7BQ5a6i66OS/oWwplgUJiDZgxyr7Weagth6fwM0DibZdFun4+3+RGEGNKzkvN0akc7u22kHuNK2pzbCmQe4BfbDoKhav782bS/IO3y0krtFgyuK0eoOzrpsRBY2Byv3qjHXFyofRpiV+dF3EgwjPe6FtBLXUPYcJyOZ/2CrBsW9DrIN5QW24kTt5Fo5W4AvS3pzJEj4d6W5zLta5o6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNFFE9sIZagEZtpPzr9VAIEZ/9ruuEZoNoR3wiONmGw=;
 b=VWu8nO+Ep2DIzeHMeck+NC18OqOROZ8c+fR5V5fH3/WKiqrprIErNDr/4IWDyswQtjgATJxHGahracMd5PR/BBQROJZdLiS2H2rvzzQtj2pJAzWHJOi4EWcpi6hKMbBCxVywctPtM1ZICczBm2cqW5IUXM1zcH2tbbFccUOef58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 15:10:56 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%5]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 15:10:56 +0000
Message-ID: <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com>
Date: Mon, 5 May 2025 10:10:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 shuah@kernel.org, pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com,
 pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250305230000.231025-1-prsampat@amd.com>
 <174622216534.881262.8086472919667553138.b4-ty@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <174622216534.881262.8086472919667553138.b4-ty@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::19) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: d5925399-ed01-4a8d-48ac-08dd8be708e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWQ1ODVMMGo5V0lxVE14djZUWWZabytLWUVZTUtxMGlRVGFNWjNOOWI0aHpO?=
 =?utf-8?B?SDNsN3V4azJMMktwM2tHNWN6V2lIdGloWHl1Y3Zkc1NzUkxFR292dVFQQ1c0?=
 =?utf-8?B?YjVDblhYTTFoUXhuSVB0WE5CRFR2WXhlZmtGTDVOOTFUZzhlRmV0ZkZONFcz?=
 =?utf-8?B?ZC9HUlc4RVhVdDFyWDhRUm91NUdlUDF4ZXllSVl5azE3VUR0SE85L2xLVkha?=
 =?utf-8?B?bC85VGZmWmg2aWJ5MEpoYm1NOStBYXRxbnhMUXc1Q0NNMXZVR3dGSnV2NWYv?=
 =?utf-8?B?Y051NzQ1dHJCSFMrMW0yWHR2enVNcDBwTlpMRjlidDJnRnZFQVljUFBKM2ll?=
 =?utf-8?B?VDhxUGJuWjFwdWZLMGV0Z1Nac2h5OFhMb2c0Y0tvZi9YSXhDYXo2elZQYzZn?=
 =?utf-8?B?QnN3c1M4dXRLNGQ0Znpnb3FXME90anVpMXRzSmlOYlhick1LRXI3QTlMQUNL?=
 =?utf-8?B?MS85Nis1K0x1T1Jzb3N0V0ZMWG5aNEZmeVBPMGtKdmZ5bGc3TFovdEpqNFZs?=
 =?utf-8?B?WFNHZU92UGFUSDErRFEybGpEcnUvMXBpR2E0VExieFZMSmdBa1FWVXNRQmc5?=
 =?utf-8?B?KzhteEkwc3N1ditrRXR5bWtNa0hLeGx0VUhTdjV4aHk1MXpNWkoxbkdJYUdF?=
 =?utf-8?B?RVAyd1BMcDRSWitZSVFycTA1RzB4Y1U1K1IxN2RwQW16ZERUU1JCbVhjV25G?=
 =?utf-8?B?Y1lOeUlZQTc2R3hBTDc5SVkwbVppQnJEU3NmQ0dEMDNIeCttd3NYU3luYzNU?=
 =?utf-8?B?MndKR3pYQ2ZIemVnMHZtM3FpUVNCZk1mVkR1UFNBY2FqSjlIaXRhVFJzUHlw?=
 =?utf-8?B?K0QzM1NCbnNRcEVTcUNBTmtxdktBbVh3MmRZNTBydjBxUUh1eHpXZWMxZm0v?=
 =?utf-8?B?Y1dQcDExa1lxL2kxc3dCNmFPYmNvdmRaNzh3NmpIemN3b0ozS3lZWFVQUVRh?=
 =?utf-8?B?NkxrazlLdHQrTWl6eGlyeGVqZFZISGNQSlJHdnRVSGZ4aUxqaGFyMVBPMk4x?=
 =?utf-8?B?NGhJS2NQQmVqWTN1MDVwWlQ1Tmg3UTRQVUd2dDduUy85S1g0VnQ2bkc0VXYv?=
 =?utf-8?B?aUVud2lkQTFBN21WNEdyUy9JVTh2TWNhemhqSnkwQzVwb1BtUEovaG15clNS?=
 =?utf-8?B?VVFoekRkMHZBQ291ZXczNk1VZHpjK2E1U29ySXA1dDVRcUJjSmh3dDVybEx3?=
 =?utf-8?B?YzNHOHdTa0RVV1hFS0llN0cvZmdqM0NWRGxqelNJNDkrN3V1MS9jb2tmU1BH?=
 =?utf-8?B?NU04cmZMRzNKNnZjaVhPb1lTZkM1amp2Z2VlVFBya09aUWo1RGozV0Z6N3Fh?=
 =?utf-8?B?c2wxMnd5RHNLelh4cFIrUXErNnZiMkRaMHV2N05CY05UYTUraGgvcUdSY0Iw?=
 =?utf-8?B?aGNNcUcwZmNhTjFBeFo0U2JtV3NiYjlOQ2ZiQ3lzWlNvb1g2NmdKRUxNZ1Z6?=
 =?utf-8?B?WFlyMkk1Um9Tb0c0cnZtTkNJWXVNNkJodGY0WFFsRUFxc1FYNWVLaStUaHJw?=
 =?utf-8?B?VVEvNnpENVJwSGJhZHFHckZEaGNDR21kL0lVS3NDUWw1RzZ0TjIrek1XVm5D?=
 =?utf-8?B?YytPSlM3bElTbDZDdG9XWVV1QzE5UjlVeUhCa2dHd2M4Q3BNYmJnaFdKMHlv?=
 =?utf-8?B?Zi9oSExVYXBXZ1BZTlFwSW80NzNjWFZ4S1dsa05YNGpzaU9oMzA5bHluQy9Y?=
 =?utf-8?B?SFRseHVqM3QxampuSnB0bzdDQ0FWcGtyV1RWOFJyUTg0THlrTVpvQUZSRzNU?=
 =?utf-8?B?T1I2c2ZNajZBN1JkbGxTb0NwR1hRV2hsVXorNm5TQ0VpaEZWSFpvUk4zVElQ?=
 =?utf-8?B?UzdyNGZIODdsSWNrMkxHempYNGY5NENnVVJDWXVzVUVwM0Z6VzdVL2xWQjdR?=
 =?utf-8?B?NEplNDNIYkNLbi9HaHdwaDFVeURVSkR1Y1gvY1AvZzVxL1lsbXFac1NWamhL?=
 =?utf-8?Q?mBRznBAfJps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djFXUHl1dFBxZmozZDdkNElXTGp5b3VBR3BlcjRhUENtOFQwSXlFbUhRTzl2?=
 =?utf-8?B?SHg0UjJXdDgxWS9ydG9uWWdJaTZsZFYzV2hubWhZN09PVXBOTzgzVjh4NDhH?=
 =?utf-8?B?Vmd6YmxQWUVQcXBRNGZSSFB1R0p3c2ovdXN5ZW4rV3BNWGdlKzJXVVdwWUZZ?=
 =?utf-8?B?VlZPMjkwTmpiTGNBTzR1TWVEZkZ5UlNZQ1R4R04wM2o0NHFvNE0rQ3l1NEVu?=
 =?utf-8?B?OEJwZm0xaWRmN1dHcHRuY0ROajNJcnVpL0w4ajVRTDZ4c0Vkb2o1VTArQU9T?=
 =?utf-8?B?d1R6NGJpdWxucXE1QzkzL1ZLaEFhSEM1SlZwKzA5M2psY1haMTNCZWtCdThX?=
 =?utf-8?B?bHNWRU1RUUx4SFlUQ3JUTXJ2ZHdKSXlCWnBoT0cybHFQcGJZUDMxbEk4Y3dP?=
 =?utf-8?B?NlpxNUIxaENxTlQzaUtrRkl1VVJEODQ3TnQwL1g3N3FmSjExMjhsZXZhVWRt?=
 =?utf-8?B?RFdRaUF2SmZOU29XRDlJN28vKzB2ZExHU0FsQlBkczZLc0NzWUZIK2FGMDNJ?=
 =?utf-8?B?TGZRa3VZM2Z2Y3ZYc2Ntc3g0RE83ZDVLMmh1WVFoT0c3SlBQdHdOc3RNWjV5?=
 =?utf-8?B?eXRCZlJySEwwY1BSMWVpM21ERVBxNFREdzk4THpoV2tCeTVCRk5YZFl3MDcx?=
 =?utf-8?B?c3JqelI0VmNHcVBCOGlzR1E5aUFnNnZPY3N5bGV0a2NYWUhDR2d5cDdqZUEr?=
 =?utf-8?B?MUhndmZtR2w3WHFPWlFVUTVDeFgwMUI3bTgzS3dKNHJlZWk2M2ttb25QSGN3?=
 =?utf-8?B?b1ZVUjVZUDVOM2syOFBHWmcxdXpCOVRZN1lDcFRaWE5uZXVkWWlOQlg3STJT?=
 =?utf-8?B?UjNuQnRSK2VOckwrNThmcFFRcE1JcjI4bXUzV3RBUHAvVzBKUzJTdHZ6NzND?=
 =?utf-8?B?aVdBaU80OU1XYW8ycFYvYTJRZGgyRkFJcDdPTWJndmRmSFFMMUxBQ2dlSk10?=
 =?utf-8?B?NkxSb3l4ZjNxeHBpaGZZdFRFK2J1bDd4cUJNclhTY0RHemRKMDNDQlQzNkdp?=
 =?utf-8?B?U1d2dWhNaGliYzV5OFlQUEoxOS9JTXFidUdROFhUaGNTbS9Bbm1TczdHTkNT?=
 =?utf-8?B?THEvNlA0KzJtYi9Ja3c0YWk4UjlKandUQkNSelhSbk9tSUNOaUxlK1lUVVpE?=
 =?utf-8?B?Wkp1UU84VXFueEtDVTRuajFITmZlYk9weWJwUHlJNG5manRhbUFFaEFYOElE?=
 =?utf-8?B?RmdheFdoZlJYUnRId1JROUFmUm02UG5ZdHhoNThia1RvY0tVNC8vblA0Zkx0?=
 =?utf-8?B?aXFpb2JKbmZjTkFZMVNKRnpSOGdraWpLMTA2c2pFdy8ybWYwNm0vUnliS2tZ?=
 =?utf-8?B?NHBwWkcrM3NXMzhyRFE0SHgzTXpVa01WQ3BudU9Ka2hoZndYV3FLR2JhaGl2?=
 =?utf-8?B?Rm1MSnhrRWFpOFowQ2dIZ0J6QVVhbXYrTmhwTXRhRXRZYlZrMTlLcFhXTGVu?=
 =?utf-8?B?NEgzQWZYbWZhbCs4cTR6Rk9JZURGU3YwaGdVbG9KR0huTlFEMWpFeER1eHJo?=
 =?utf-8?B?U0ZSM2xrOUlhMitwcUVSeHU2LzZ2VTFJNXVQWC8xNFJBWjVpZld2a0RTN2pU?=
 =?utf-8?B?aFYzL0twa0tWcnZjaHpraUpKWm5sN0UyQm1Nb3gyWjNLQ2hEcmtKbEEweWtE?=
 =?utf-8?B?Y0pkRmo2dGhKeERyYXZXbU5xV1h3dlYydkg5dEkvdWduMW9UR2VkRmxOM3Y2?=
 =?utf-8?B?dW9JdnZCMGJMUGkyZDdnSHA3YStuWnc2ZHlqYUZuVHUxWEpOYVRlY2V0YVhz?=
 =?utf-8?B?R3pNSldzZHNBQ0U0akJPNzgzUXlja0h4RVE3WDM3UWRkOUFFaXA2NmY4bVB3?=
 =?utf-8?B?cFJyMFZhYmdmdlNNU0I5MUJuRzQyL3lNZ2w3cmtwbGFCYXVrcmpzck1xUEJD?=
 =?utf-8?B?M2NmY25NZ3VZeWt1d3AyKzVWR3RPNlM2WjZZT0U3cEJYbDhMWWdobHlPSXpi?=
 =?utf-8?B?bnBCaUhTQUtiUXdJRnJGbEVvRlVwTVRLYmtsbnphMFZrQndFVWZFaUF6VnhS?=
 =?utf-8?B?Y0ZxcWFIR3hSNUVMd2cvZW04bDVqT2E0OGRDUUVXZFNXVEg5NWZlbDQwemdm?=
 =?utf-8?B?SENSVzEwSnV6eU10dDAxdCtCUWcyVFo2RTFjM3o5VmgrVmVmWHI0dUswc2Vh?=
 =?utf-8?Q?3m+oiciDZr76Evi/MkJG7/4ix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5925399-ed01-4a8d-48ac-08dd8be708e8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:10:56.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNxiMk3OB3eBOK9UMretERMgM8nZXiCnbJ8bpnsj9rzt/sgDt7wiOXGwYiXvGMkGpYwTE2tWbkoceqJZwhoW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

Hi Sean,

On 5/2/25 4:50 PM, Sean Christopherson wrote:
> On Wed, 05 Mar 2025 16:59:50 -0600, Pratik R. Sampat wrote:
>> This patch series extends the sev_init2 and the sev_smoke test to
>> exercise the SEV-SNP VM launch workflow.
>>
>> Primarily, it introduces the architectural defines, its support in the
>> SEV library and extends the tests to interact with the SEV-SNP ioctl()
>> wrappers.
>>
>> [...]
> 
> Applied 2-9 to kvm-x86 selftests.  AIUI, the KVM side of things should already
> be fixed.  If KVM isn't fixed, I want to take that discussion/patch to a
> separate thread.
> 

Thanks for pulling these patches in.

For 1 - Ashish's commit now returns failure for this case [1].
Although, it appears that the return code isn't checked within
sev_platform_init()[2], so it shouldn't change existing behavior. In the
kselftest case, if platform init fails, the selftest will also fail — just as
it does currently too.

Regardless of what we decide on what the right behavior is, fail vs skip (I
don't mind the former) we can certainly do that over new patches rebased over
the new series.

[1]: https://lore.kernel.org/kvm/ab9a028cf232663f9fc839f48cfcf97694846c13.1742850400.git.ashish.kalra@amd.com/
[2]: https://lore.kernel.org/kvm/d8de6de80c36721ea3eb92ecac81b211f401c3b2.1742850400.git.ashish.kalra@amd.com/

> I made minor changes along the way (some details in the commits' []), please
> holler if you disagree with the end result.

Thank you for cleaning these up!

Pratik

> 
> [01/10] KVM: SEV: Disable SEV-SNP support on initialization failure
>         (no commit info)
> [02/10] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
>         https://github.com/kvm-x86/linux/commit/68ed692e3954
> [03/10] KVM: selftests: Add vmgexit helper
>         https://github.com/kvm-x86/linux/commit/c4e1a848d721
> [04/10] KVM: selftests: Add SMT control state helper
>         https://github.com/kvm-x86/linux/commit/acf064345018
> [05/10] KVM: selftests: Replace assert() with TEST_ASSERT_EQ()
>         https://github.com/kvm-x86/linux/commit/f694f30e81c4
> [06/10] KVM: selftests: Introduce SEV VM type check
>         https://github.com/kvm-x86/linux/commit/4a4e1e8e92eb
> [07/10] KVM: selftests: Add library support for interacting with SNP
>         https://github.com/kvm-x86/linux/commit/3bf3e0a52123
> [08/10] KVM: selftests: Force GUEST_MEMFD flag for SNP VM type
>         https://github.com/kvm-x86/linux/commit/b73a30cd9caa
> [09/10] KVM: selftests: Abstractions for SEV to decouple policy from type
>         https://github.com/kvm-x86/linux/commit/a5d55f783fb7
> [10/10] KVM: selftests: Add a basic SEV-SNP smoke test
>         https://github.com/kvm-x86/linux/commit/ada014f5fc67
> 
> --
> https://github.com/kvm-x86/linux/tree/next


