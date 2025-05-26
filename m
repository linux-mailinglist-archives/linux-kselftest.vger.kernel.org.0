Return-Path: <linux-kselftest+bounces-33766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F12DAC39B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F6F3A4D33
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 06:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7EC1A8412;
	Mon, 26 May 2025 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ttrD6hLL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74D5383;
	Mon, 26 May 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240148; cv=fail; b=K82x8qGqLTA0IoWhJVuYGNyHaMJ1Qs0Trs41UDMSZMAndQX9s4S307LGnZYOBIZ8gSh0d97crk1FfbAxDVRY9CTRfERgC9hta8Y5BIhsWtJwuIIUGZohPIKjdgCLzhKgCh3tWySfJzo8lFBns7V2sPOT5mJwMjXDV/rLkBDw+b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240148; c=relaxed/simple;
	bh=L+cFMZYrxnW81Yg8tkXE90SU4u4qivREBB90A2HZa3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pXzdl55qu95ZdzctpiZJDwPzLbiFBVBEJ4Uo148j6U+oX6JyOTCcs6zzdB1ncFp2fIO3O5OeX/Y3Tmpq2OIdcPCDq8npblf/rWfUTR9QuPu0bBV2xLfa0PEUwfBprK27NxjQ29MnJj8K4y9cIIVxzniJopc23EeADbox6e+dz04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ttrD6hLL; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxCvrzgXjOfhK2nVyiEUE0Vg//ozYvgHk9Ia1ratnEb9MOwjkQngzOW0meR8sEvfSz9K6s0dr1qYTCdtXJ+Vm/E0rOtvMRUEl8pYifvq1WF2pnvIKjScf8KApa4cIgGc4fccRJ9R238yuN+RZ9UFBt82KW6GbLYPI3ttn3EJA4UvNv7zLktHmKb0EUd1a/r2lnEARNsPd7IWwl6G1W9I1PL1lhUVwBaIBgB5dEzjPtTGX5eszMwzzB3J8HUmsMRFC3GtS47yTnzsl4CWQrKjrY9073yPluaA4Qz/ykKkTHa5GPlbmcB58y2ALRXdST9Jktk0UugSwT5jAUnEW/C01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29Oa+x7Nx4DtsQxq5AM9YgroY6ey57+hpklbnYmzQrg=;
 b=lTJ+J0y23rCIbmHMWhm/l0qN0Ss/pPSoKoamK04Y0K3g01NbxvWNXTuOiBV91RhadAN4EJT0S685PVLQgMmPauBOpnNnoqnFDB13Nbx3uLqriFvraBWXXAJYdimw5BoxTu47GEcdz1uPz8++22iuWRhaomNh5jyrrItNmYq8lkA+oUCs+OrjSxlEfsJcWH5lpzGtzfthppYxiu4l8gSt6sZf6tONbmu60H193XKNUX1Cxx49C7BY4MVdaI8ynt3xg3QLucE4Ojbh6c5wTOH8Cw+D6Ia8wZiDbJVTzSH48lYS9zsX+9YOUnQx+CSNavdEPP18y3bdPIMaUEgnnID1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29Oa+x7Nx4DtsQxq5AM9YgroY6ey57+hpklbnYmzQrg=;
 b=ttrD6hLLFHxBhQ4MwBxPAxtyy/ihk8g6YoNC8rjLGpFPm2jF/kPh3BI+3FleThiHWp0OulvrIygBvlm19WLgDMERfrWChflq4dGlx0WM/pS+C58dj2KMy1kABxg+MA9hmdOl2yJcZCr0fuiujRwnAEikxA58HZlnE0pzkR7zijU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Mon, 26 May
 2025 06:15:40 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::bbe0:a58f:b02c:1427]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::bbe0:a58f:b02c:1427%5]) with mapi id 15.20.8769.021; Mon, 26 May 2025
 06:15:37 +0000
Message-ID: <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com>
Date: Mon, 26 May 2025 11:45:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
To: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
 Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>,
 Xiong Zhang <xiong.y.zhang@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>,
 Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Nikunj Dadhania <nikunj.dadhania@amd.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-21-mizhang@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20250324173121.1275209-21-mizhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::15) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f17b3a-772d-4ee8-f264-08dd9c1cbad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eCtEcml2eTBkRWpqWnJEbWtuNGZla3k4dnozeDdYS2JYekFDc1hYWVZmMCtL?=
 =?utf-8?B?aTVMUG9KaHE1ODVYVkFCLzhXeXlFMXU1aWpsVGVzZEs2UlRRbEMwVnlNUC9j?=
 =?utf-8?B?Yk9vS0JYaGpTZy9laUlNUXhVUnNoZllWSitRS0FqbndWZVhHUEZNTVpFODNx?=
 =?utf-8?B?VXM1T0UvRHJWb0RGNys5RVphZDB3b0w1ang5b2RwSDNwbDg4Zi9LMHpGRXpv?=
 =?utf-8?B?WnlMcHNiWU53YVU1VTU5Y3ZhTWJYc1AxT3lRSFRPYWRjRWdaSUNMV3RuV0FT?=
 =?utf-8?B?WjNaK1hUMlFKbVk1UTZyUU84ZTJQOElrb0UvTmIzK0RrMGtHOUsvNVJBaGRZ?=
 =?utf-8?B?YW5QTGtFMW5UZTZ5LzhsMnduM0VKVEgwWUx6WnZZKzVXbUIzdG1JdGtremRQ?=
 =?utf-8?B?bDNjSUU3RnpXa2JpQ3BGRnVWNXlUcVpnU2VBZWZDeTZkMlIwSHY4VU1XeUg0?=
 =?utf-8?B?amZUaFN2RHBVa2dpM0JrT2RQZmJRdENPREFuNDFJUHBaVUNuQm5JTHc1NnJa?=
 =?utf-8?B?Q2pVbnIyRDd0RXNDUDhJcG9HanUzMVdCTUE0WVpwWllWSUpuRXNnck1yeFEy?=
 =?utf-8?B?TzlkUlVxRnlzbnBheDNrQUdyRk4raGVIQjNkUWtUMmF6a0Z2cURKUnI4TlNZ?=
 =?utf-8?B?dEpiUmwrWldkalVDZm56K1BxNlNNQUVKb0dOVS9lMlpLWFFpUE1UYTVkb3M0?=
 =?utf-8?B?bWtGelVaeWtIOVBsYWphOXBwZ2dQSW9WN0pCcFQvUTlTdXRvMk1RZER0T1JZ?=
 =?utf-8?B?VXpSZFRpcG5OU3JxYm1KU2g0REZrYTZqWlIydnNKRlBZUC9UeFhCaVJlbThI?=
 =?utf-8?B?bHZEQUVZQ1RGeWwwcVdGcEZ3R21BOWhCVFpyWEUvaTRYVFVOL2d5UVdVZjVm?=
 =?utf-8?B?Y2M0Y3RKK0tFSVA4Sm5sWWErS2hzNEVaWWt6blRmRXBIM1U1STNDOHU4TVhB?=
 =?utf-8?B?dFBPNEQ5SVRPUHFSZUZaRzBJVU5FZS9JMDB4a1J0dzRBL2dZR25oWmduMDhV?=
 =?utf-8?B?ZU9VTGozbDY2QURZZjl5Z0wwSVVOL0pGYW5mRUlHd0ZSczdUVkRKN2lCUTlh?=
 =?utf-8?B?cVJyTWVwZk9MN01UTXBxOTFXV3hZdnhoaDlBanp6YWlhYXVPMDhhdE1VUkJj?=
 =?utf-8?B?MVFnSU9Ea1B6THBxdWdMakpISU1ISXU2TWZwSVdSRHNQN2ZWQWEwZGtUcmsv?=
 =?utf-8?B?RXFrNUFJR2F3TVlNSk4vREhadE8rVUxOL1dyeDBmejZtclpZSjZ0VEs5QmFU?=
 =?utf-8?B?ak9xNzhEOC9sQm1aSnppOElRRVlyWUZOckhSNFJxNDN3dHZsOG9CMjQrb3F6?=
 =?utf-8?B?NDAxNFBJOFpSQjRTa3lQZ2w0SU1uWjhGS1hBTnNpdzVjMTNxRlk0Qml0VUxm?=
 =?utf-8?B?T3U2dDRDa2lBajdWLzl5cVo1RmVHV3JUcEU3RFl0cFdJVUhCcDdibW5UZ2JW?=
 =?utf-8?B?L1l4VEIrR25yb3cwcFYrSHpjNDlkdFVudHN0aDQ3enFqa2ZNS3NkMHd0Z3hl?=
 =?utf-8?B?cDB5bk1XT1RuOERHWENJS1BqWHkyUjZTaXdSNXM4a0krdDNKRUFZRnhaTkZy?=
 =?utf-8?B?NzBlRzNDUVdTSUZQUHRucWpaZG9XRWxSVXBSdGlzYzJBbXdVTGkyeWJ2QzJv?=
 =?utf-8?B?RWlSTWQ5bDhKYWgxK0IvTkpSM0tjT0x6MmRMamt6eUdyc1I5T29tU2prK0tW?=
 =?utf-8?B?aWsvYnZ1VjlibGZQQ1dTdGU3MHpRWkxlTHBaM21LRjVFQUVSVi9PaitMMFBp?=
 =?utf-8?B?THFuQStKYXJqLzhaWFkydkdjeGhDb1RJYk01SWVhT1RJYk9WWmNLS3VsTkFR?=
 =?utf-8?B?M203dFYzczFRM1lCcXNoaXorODgzVlJWMVU3dmhLVkNnTHpPUFdQNjIybDRD?=
 =?utf-8?B?SVlqZFc2YXlNV2NiZ0k2Y1hxbmUvL3B2M1NJTitwZGpCdVRkcERMQlYxWnZp?=
 =?utf-8?Q?zjjgHb7sxKM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZ5aFcwbmRxdFpxSWZZTkxvMWl1RFJnNzR0V00zTWM4d1pYYkdKL0RWaXZn?=
 =?utf-8?B?L0lKN2hXMVFyUDhhdFJDdndXcmFZZFJHWEZ2SEFTWm1BandqUCs3TURSZ3JL?=
 =?utf-8?B?VUhFMkhicll1cWpYRDJwdS9YWGZSU1NOOHhWOVcyRVA3YmxpeHc5alBwR1Vn?=
 =?utf-8?B?WVBTSDJJaXZXSjYrWTYvMTM1RUxjeW5FSVVEaWVxL1dSNlkrUE9JUmR0ZDZR?=
 =?utf-8?B?OGdvaFRKMkNrUGFYc0ViTndnS1huanhuTlpHWnI2NGhhWm9iR2FjR051Nlo2?=
 =?utf-8?B?bXJxUnd6bmVvWlBuZTNsUk8zV2M4VTJMRVhhTVdKU2d6TllYZUYzRmpFcUIv?=
 =?utf-8?B?MS9PTVYzK0pMKzhIUlJpakZaU3kvNzJYMGRmeXdJd08wLys5SFgxZ3NvYW9t?=
 =?utf-8?B?OGFnUk1NbmhlWVZpSlRHSVJQQVFJQmRqLzROMW82Y2lnQkFZRURpYXJTejNJ?=
 =?utf-8?B?UWsvU0dPNk4yZm9jZjNOaVFrZExNa0ZiWi8wTUtvd1VOZUZwY3g1VGhvR2tv?=
 =?utf-8?B?T05WWFFCNDhIVUFHSFlYV09VdUxCZk1pWjYxdlFyL1FNUjBTOEE0Tzc5ZXZ6?=
 =?utf-8?B?SC9xQStVUmJrSWZtZE9zYlZxNnl3QWljYlh6c0xGQ01jMmwvNTBkWkZabTBZ?=
 =?utf-8?B?TVFiaDE2czR5Z3RnNE95dkhhdlg1czZ2L2xTeldxNGJER2x0T2tDMnUyTWJL?=
 =?utf-8?B?dHg4TTdvMFdkclg4endYaldVZnVOdHYrL1NhNnNFdWh1akJ3dE9NRGl2YmRT?=
 =?utf-8?B?cy9NS0grV3VhQTVhVXBwenBOVFowZkJqclcvUFBxVGplWE81a3BzT3JJYmta?=
 =?utf-8?B?bGlnbkw1KzBqWmpna2lnYnFXR3h5TDI4UTlVUnZQYlBiV0M5RGxITWVGRDNT?=
 =?utf-8?B?dzVpczczUHhYZXVMQzRrSlJwWXRYTzFRRWpTR3VMdlVIbGlsaGNzSk1lVmlL?=
 =?utf-8?B?aC9CcHFRS3JISmtxTFdFSVZ6M0tZZHpWNkkvWG5CV2QraWRPcnhmQTg5aHNj?=
 =?utf-8?B?bDIyZjJwNUx4cWU1OTNIYzZkRXRkQzg0L2J6VU40N3BXMXVDMmVqMXRyVUVq?=
 =?utf-8?B?aHNFY3V5ZUtNNmg3M1FDYjhxS0FKZUFYaUMxVzdFQkt3TzhnOGhhSjVETzN6?=
 =?utf-8?B?V1VmY1VBOG1IZmpTaXphMzg5VTg0N0NyeVJkVUt0by8wSnZJR1BIcVdZZzUx?=
 =?utf-8?B?UHoyb3d2QnQzcXdhQlZKQzZ1REF6K05jcDhlNWZ4V3loZG1rRVBqeUcvQ0dG?=
 =?utf-8?B?YlgzdFVrSEtVYithcGxrdW05OWE2T1VwcUNkQjhUdjdCZFJtRzhMQks0L0pa?=
 =?utf-8?B?K3Y1UW11c0dOa3poa3BWNm16VitOREhxTjVZMlJrdnc0MkJTTzk1V0ovWGJD?=
 =?utf-8?B?dk5aTjF3UzVGY1ZVcGpCd3U4Q0hGV016ZmxyS21rQlBFbUxUOXhmZlo0N0ZV?=
 =?utf-8?B?L28zMm9aSzNxY2dCRTJYL2IydWg4eHJNNVNqRjduSWp3ZUtEMzJlVzFmRTkz?=
 =?utf-8?B?bmVSZHpSR2tZWTBZK3dLRm5NekNxMkMyZnd5Y0MzWXRzTmNmWWNxck5XUjZX?=
 =?utf-8?B?TnV6M1RFSGZxZDFUdkMzNU9HS01IZ2VPZEUzbDQybXcxQXM1eUhiNE0wLzVG?=
 =?utf-8?B?WUpHb0g2b01SMWtqL0c4OW16VFVKQmdmRS9kU1ZHUTk0Qk9PUVFrVER0amRr?=
 =?utf-8?B?SDQwQTVGU3N6RmRDWGVHZ3kvLzJ5bk5NY2VyQnBqN3p6Z0Nrc3U4QzY0S2VE?=
 =?utf-8?B?NlI2M0l1M2FqSUo5TFgyTTlxdU80QVR1bGdmbGlBRFBDTnRLTmVvbjNvb2Fo?=
 =?utf-8?B?QStKZWVDSEozN3V4UHFXVWlCYWpyUDVKVFZXZTJEdU1uZGFWZ1pNaUsvUlB4?=
 =?utf-8?B?NFN1VWRKSmZWWTBiZnFVNFFUb2pZL3lVRzFZUkZzWGdKUkkwR2Y2SU5jb21W?=
 =?utf-8?B?c3NSMDhLcVN4TG9iTHlSc1EzNHNOWG41UHZMWnJNN1RBUUIwOHdwU1FUL2lL?=
 =?utf-8?B?ZHdIdHBOWWl1SjJUVm8yR1h5TW1IYTdoYWpXb3FXcTB1SVNmcTIrK1lWc0hH?=
 =?utf-8?B?YWpYMFErbjgzd1BodnllL2RwemhQeVdWaXkwY0haSjdDVFMrcTBnT09JMjlP?=
 =?utf-8?Q?m8mPdj0FkqGUKzPACS/eXaTZW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f17b3a-772d-4ee8-f264-08dd9c1cbad3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 06:15:37.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKMfimcxWEm2ss4rGvgD0ElRU+eqG1YXFDb51pfuTTZ6Y3+RvtBETqjbdnCYRW6Cf64QJ0UGWpxiu1af0Xpx9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

On 3/24/2025 11:01 PM, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Check if rdpmc can be intercepted for mediated vPMU. Simply speaking,
> if guest own all PMU counters in mediated vPMU, then rdpmc interception
> should be disabled to mitigate the performance impact, otherwise rdpmc
> has to be intercepted to avoid guest obtain host counter's data via
> rdpmc instruction.
> 
> Co-developed-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/include/asm/msr-index.h |  1 +
>  arch/x86/kvm/pmu.c               | 34 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/pmu.h               | 19 ++++++++++++++++++
>  arch/x86/kvm/svm/pmu.c           | 14 ++++++++++++-
>  arch/x86/kvm/vmx/pmu_intel.c     | 18 ++++++++---------
>  5 files changed, 76 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index ca70846ffd55..337f4b0a2998 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -312,6 +312,7 @@
>  #define PERF_CAP_PEBS_FORMAT		0xf00
>  #define PERF_CAP_FW_WRITES		BIT_ULL(13)
>  #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
> +#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
>  #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
>  					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
>  
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 92c742ead663..6ad71752be4b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -604,6 +604,40 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  	return 0;
>  }
>  
> +inline bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	if (!kvm_mediated_pmu_enabled(vcpu))
> +		return false;
> +
> +	/*
> +	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
> +	 * in Ring3 when CR4.PCE=0.
> +	 */
> +	if (enable_vmware_backdoor)
> +		return false;
> +
> +	/*
> +	 * FIXME: In theory, perf metrics is always combined with fixed
> +	 *	  counter 3. it's fair enough to compare the guest and host
> +	 *	  fixed counter number and don't need to check perf metrics
> +	 *	  explicitly. However kvm_pmu_cap.num_counters_fixed is limited
> +	 *	  KVM_MAX_NR_FIXED_COUNTERS (3) as fixed counter 3 is not
> +	 *	  supported now. perf metrics is still needed to be checked
> +	 *	  explicitly here. Once fixed counter 3 is supported, the perf
> +	 *	  metrics checking can be removed.
> +	 */
> +	return pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
> +	       pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
> +	       vcpu_has_perf_metrics(vcpu) == kvm_host_has_perf_metrics() &&
> +	       pmu->counter_bitmask[KVM_PMC_GP] ==
> +				(BIT_ULL(kvm_pmu_cap.bit_width_gp) - 1) &&
> +	       pmu->counter_bitmask[KVM_PMC_FIXED] ==
> +				(BIT_ULL(kvm_pmu_cap.bit_width_fixed) - 1);
> +}
> +EXPORT_SYMBOL_GPL(kvm_rdpmc_in_guest);
> +
>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
>  {
>  	if (lapic_in_kernel(vcpu)) {
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index e1d0096f249b..509c995b7871 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -271,6 +271,24 @@ static inline bool pmc_is_globally_enabled(struct kvm_pmc *pmc)
>  	return test_bit(pmc->idx, (unsigned long *)&pmu->global_ctrl);
>  }
>  
> +static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
> +{
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> +		return 0;
> +
> +	return vcpu->arch.perf_capabilities;
> +}
> +
> +static inline bool vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
> +{
> +	return !!(vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PERF_METRICS);
> +}
> +
> +static inline bool kvm_host_has_perf_metrics(void)
> +{
> +	return !!(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS);
> +}
> +
>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
>  void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
> @@ -287,6 +305,7 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel);
>  bool vcpu_pmu_can_enable(struct kvm_vcpu *vcpu);
>  
>  bool is_vmware_backdoor_pmc(u32 pmc_idx);
> +bool kvm_rdpmc_in_guest(struct kvm_vcpu *vcpu);
>  
>  extern struct kvm_pmu_ops intel_pmu_ops;
>  extern struct kvm_pmu_ops amd_pmu_ops;
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index c8b9fd9b5350..153972e944eb 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -173,7 +173,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	return 1;
>  }
>  
> -static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
> +static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	union cpuid_0x80000022_ebx ebx;
> @@ -212,6 +212,18 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
>  }
>  
> +static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +
> +	__amd_pmu_refresh(vcpu);
> +
> +	if (kvm_rdpmc_in_guest(vcpu))
> +		svm_clr_intercept(svm, INTERCEPT_RDPMC);
> +	else
> +		svm_set_intercept(svm, INTERCEPT_RDPMC);
> +}
> +

After putting kprobes on kvm_pmu_rdpmc(), I noticed that RDPMC instructions were
getting intercepted for the secondary vCPUs. This happens because when secondary
vCPUs come up, kvm_vcpu_reset() gets called after guest CPUID has been updated.
While RDPMC interception is initially disabled in the kvm_pmu_refresh() path, it
gets re-enabled in the kvm_vcpu_reset() path as svm_vcpu_reset() calls init_vmcb().
We should consider adding the following change to avoid that.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6f9142063cc4..1c9c183092f3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1354,7 +1354,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
                svm_set_intercept(svm, INTERCEPT_SMI);

        svm_set_intercept(svm, INTERCEPT_SELECTIVE_CR0);
-       svm_set_intercept(svm, INTERCEPT_RDPMC);
        svm_set_intercept(svm, INTERCEPT_CPUID);
        svm_set_intercept(svm, INTERCEPT_INVD);
        svm_set_intercept(svm, INTERCEPT_INVLPG);

>  static void amd_pmu_init(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index fc017e9a6a0c..2a5f79206b02 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -108,14 +108,6 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	return &counters[array_index_nospec(idx, num_counters)];
>  }
>  
> -static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
> -{
> -	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> -		return 0;
> -
> -	return vcpu->arch.perf_capabilities;
> -}
> -
>  static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
>  {
>  	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
> @@ -456,7 +448,7 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
>  		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
>  }
>  
> -static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
> +static void __intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
> @@ -564,6 +556,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
> +{
> +	__intel_pmu_refresh(vcpu);
> +
> +	exec_controls_changebit(to_vmx(vcpu), CPU_BASED_RDPMC_EXITING,
> +				!kvm_rdpmc_in_guest(vcpu));
> +}
> +
>  static void intel_pmu_init(struct kvm_vcpu *vcpu)
>  {
>  	int i;


