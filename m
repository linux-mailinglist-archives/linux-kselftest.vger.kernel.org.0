Return-Path: <linux-kselftest+bounces-12337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9E910A3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AA31F22C34
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE261B010E;
	Thu, 20 Jun 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pq3OqKKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68981B0109;
	Thu, 20 Jun 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898204; cv=fail; b=J18BF3fjOOVV81Zp82oRDLQV9qL3zpUxWcoHwLxTohuDkuMhAO0EXg03x1dj84bqW5f7LPTP+FZDpWrbRjqaeYt2DQogkHoQpQ8dKmEkP7mX2NL3buty4hx6zFecJ1jZxbG1sRwoAeDYFZEQB0zygwJdtFyiNMuLtlquoJBVlTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898204; c=relaxed/simple;
	bh=Q9jQKMrzEwPw41pvZAzTOPipQQ1gT+oqnyXIjqWFITI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D0TYlg/tP6YU3OiT4iqpp8eBMYoIRV60BZwkJtltLKEVhU9jnztCyJF6SNXadEmzNGQ2M5vVmzkSzqFjHhjZSiJo2KJjtsRQclN0kf8u/sxOFrRjCtzQQ1AtlAEV00zECLDrlMnY8PF0PVTV5kcPdlEtYjutQdSFAY2SkWDrtwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pq3OqKKO; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieqiug4ZNnCEDHhvrpeVaMVYXvsRE9olkYBsI9i+YNiQ03FuD/IicWuU6pY8+Ggs2TEz2Wpz3ZptLdWCP8d1OG1Plh2LWdb5xgOmG2Q3pkczP9RNA0m3NPmAUAkbopHWVmUaof9LMR2YMdepYHdP+Fi71gD6pzAiaZT4f4IyYeIIpScEDBLq0lg3A1N79yf7g59zTJ/JeGPnME2iT++f4ktcJtpmD3dw7sZ83orvP7Ey+g73o3kTOzhFie3JPc+2IhNE1jggFqHDfB8R/cXG9AnhDZz+Od9TUMub4wox5I8LFu492IP+uAAt9NxzBJh8kmVUd4kbvujRMIBPBDEFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kTHj1dD7jz4zuBfRHEF5+Yzszi45O/2mOZH8Do1dEU=;
 b=QKs1XlTCtfkHoVflkhVszS6KRsEJau4UfoEaSRLGbrb7nczZcSgfP+NzN3zpTj8yE94IAqAkdp0fGCAexJldOYTGgd4yrlDo83+uxOtuQTJCXZ/uNJhdVHX13rRHwjAf6ByTm0YbbdOrN7PCA8AqHKelVqwa5lghl8CR9czcwOgGqtae6RqE6uHBmwa83SgD8cZgkcUm5H9CBurEI4Ofgop0FGoDX8fC5huFlufNsjgcyvSOosd/vX/EdEZNjdgARrGKV+EsseyXTH2pja9bVl4VWfPu1AgNpT3P30caIBrZ2tZa1s+eHy0kMd3Lsdlyy8tZTMeFWwxF5Wb0jnzHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kTHj1dD7jz4zuBfRHEF5+Yzszi45O/2mOZH8Do1dEU=;
 b=Pq3OqKKOVSxOjrUHBXt2aaxxeiQLJDWeT6JhHCEl77nq1pUKZmiR6jy/A0afflFwt3p6heVKVIJPxFCPGlnjpseVtIbqdvzp/iGokJ1amLW6zUUmBYAb3ZL3bWXUDQfd0o1bc7E2QzTIVu6+RdhVNtVGFek/YPHrOLORSZpvuRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 15:43:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 15:43:11 +0000
Message-ID: <e85e6190-eea7-4010-8eb1-3f04fcce5609@amd.com>
Date: Thu, 20 Jun 2024 10:43:08 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 1/4] selftests/resctrl: Rename variables and functions
 to generic names
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1717626661.git.babu.moger@amd.com>
 <c1b9905b5fd6b80933fddd6c576e5d34a78b2b90.1717626661.git.babu.moger@amd.com>
 <7cff31f8-f94f-4b76-beb9-073c369e5080@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <7cff31f8-f94f-4b76-beb9-073c369e5080@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:806:6f::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: d05a8363-f12d-4df5-a78c-08dc913fb06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODh2VmxVZXI3Q0VOaFZTZE1KdFFZaDkzVzFXYmo4QUJoOHAva3VyZEdDazVp?=
 =?utf-8?B?b3FpeEtyY0dhODl6NGEwUE1CMFNaMVZ2Y0RXQ0dCN1ZWbFNUOVl2eG9wTzJa?=
 =?utf-8?B?MytTSFFHbXJYNmZTNUZ3ejZFd0JPbVBUdFNiN3puZmlaRllMNmhtclluOSt3?=
 =?utf-8?B?dmxzNnpubHNYMGNKenlZQTZKL0dhVmt1S09ySjBpck5xUkZlVGlwaW8xN0E2?=
 =?utf-8?B?SHY4ZmlIeUczVThZYlVPYU12NnNjK05pQTRacFU2cE54YWMxVG9iUGZvQktZ?=
 =?utf-8?B?SE5jTmh3YkpjT1BlY2VHb29JSjhjV0NLYWZCdzMzdG5qeUdNdzNZYjI0OGNJ?=
 =?utf-8?B?NHhCNXRWODBUOFI3eFdZSVVTZVIrMW54L252Q2JRYnBlTE80SnJOQVZkcG8x?=
 =?utf-8?B?V3VoOGpzR2tmVktleDcyMnRzSG1CYldOQ004VC9RSkt4UkdwdWlDRDZpLzNB?=
 =?utf-8?B?emhYRGdUZzVMYXVoVUZIQXVFVFdHU2ZIY0c2dzEyYUw3M2VVS0RDTVd6TzVW?=
 =?utf-8?B?aVg2bUhEdVp3L2JXVGhwbXFVZjBOdS9kck5BVU1GSUFrSUY5QnA2MWFjUUxP?=
 =?utf-8?B?M2RDUWwvbVZPcVZleUMvazNuMFdkQVFyV0o2NkJhOERaaXM5S1V6QTkwRmpY?=
 =?utf-8?B?SG5pZE5oeGFqdzJqZW9oME1mRHJaMkN1RHh1N3dlSjdGRlNWKy9JcEdwUUpj?=
 =?utf-8?B?RjB4MkxsQUtzUXFUK013UElic2tibGEzWU5LWEtlMXhia0xhQnlGWU5vSHVH?=
 =?utf-8?B?Rjc1OW9pRkJvNUJwbStmalZqOEhJWDV5KzFuNWxoZlBlaDRhYm9MaFlRSmxz?=
 =?utf-8?B?bEZ4TzJKYXg0bG9FMGJDbkV4ZXZZRG9TVld1MzN0YmFlKzVFNXVwNU5PektK?=
 =?utf-8?B?R0ZoL1NaamdQOTNsREh6L3hNWDNnRFY3NEJXUDJ4T0RRZWErRDI0ajMyOEpT?=
 =?utf-8?B?YjgrRkluelY4M1owWG10ZURWYkpMQU1IYk5CdHNFVHcxWC9tcnhQV3ZCbFR6?=
 =?utf-8?B?dTZqOTZSR3NnNkF1L3NaRWNXTkFIOEVZRHl1QVFiN0RNZUsxUkJrd0RsWFpW?=
 =?utf-8?B?Z216bUZDWXhKZlZ4dTBwTkYxcmdSeFpWcVZpVEpFRG80cVExMGhzTTAvamQ1?=
 =?utf-8?B?cUtkeVB4UjRFSTNpTXBEbnc2UDFBbkVkTUJKY2dvWW82eExQa0hGK1Q4T2Uv?=
 =?utf-8?B?T3dNRm1BVjNwMW9nK3d5SGdsUll4b1dyOVppMzMwdFBrc0ZDd3N1bkhGN0dF?=
 =?utf-8?B?ZTM2SVpLa0ZMcXBIUFg2c214Rzcrd0kzVkJZdHVDZzUybko1LzU4V0hoOWdJ?=
 =?utf-8?B?VTI2Zmx5TWcxTmRObGs4NkFtOGFmc00zS0hhSTJWZHl2Y2hEbGRiVzd6U3BJ?=
 =?utf-8?B?ZHYxRWJDMXAxVzRDbWVDZjVlMkFBdFNMNGxaaUQ5elBXMTlSMWJJRWk4NDVh?=
 =?utf-8?B?NDNjeTRCYTNYVWhSYkJSbGExejVFQXpJVkpBZjJ0c2ZrUkgvU0h2NnJjZVlH?=
 =?utf-8?B?ZTh2TnJ3TEVVZnUrd2JPbXRSdml4alo1QTFkekRiMU1kYmNkaktOQURSZG9V?=
 =?utf-8?B?U3ZJamttdkZaaDh0SzFtdmVaT2dmYUQ0SE5yMmRBcHZ6ZlB0QVUxY2pGWE44?=
 =?utf-8?B?bm0zTjFaNTVXZzNBLzZMM055dDdUTFlIVm9sdlVMaWlQeHY0cEFKMGhYMUR2?=
 =?utf-8?B?aXNWOUF1V0RIQUdQei9JbHBqWEJZemMvd2ZJSGlhZm9DL1dva3Q1SkltZ04v?=
 =?utf-8?Q?sAqHdLa7EZRLYZQ9dmCqyf2Qnus5A3q6UQFfEob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWhZaXEweVFQRmNzRldpYWw4T3VIclpQRVB5ampDQU4xNy9xM3dqN1Y5YW44?=
 =?utf-8?B?Tm16WmpxMUhwNUIvYS81V1pyYXgxdGFHYThDNnlLMzZ0K0M2OFozNlcrUkUw?=
 =?utf-8?B?VThyZnNMNTByOG1GS3ozdFIvRFNyL3FRMENhamdZbEtzZHZRUGk4dDczZlF3?=
 =?utf-8?B?bFJ2NVRHU3ZFOHhUbGxGeldEWkMzQ2Z4Lzc2SnhaYmdSeTBxMEI0SHdDSGlP?=
 =?utf-8?B?NndzTDJPNUJsOHdwZ2V3dXNFSk5qQ2trdTdoazFOdDBFUG5KcmNjK0xqVG1G?=
 =?utf-8?B?cVRhNHBwbXZYYkhWTnlzWHZtSWU5aUtLK2lpVUE5WXMzdXpaNkc4M052SkZB?=
 =?utf-8?B?bXgyZzdWejNJZ2RWNXRYQm1FeWdCMTRNMXZTVjhuR0p2cHF5TEhLWmtxU1dU?=
 =?utf-8?B?Qng4djBoSiszZmpTM1cxNWhMR2RicnRmalpwYnRSTU1mcEZoamNORkFrTHZI?=
 =?utf-8?B?RWIyRXN4ZkU1NXZYVEM3bWhpdERlMVdOZ1BrbTlNcWJsV3c4ZmFwMTd3VVc2?=
 =?utf-8?B?QVdHS0g2RkpjM21EMkgvL2E1ME02VmQvRGtIcnpROEJvSkVCNkY0Z3NkVjBu?=
 =?utf-8?B?ak1pWkFzZ3JsZlMzK0FPSkJVWkExbExrQWI1aWQxZHJzbGxFVHlOZkxLYkE1?=
 =?utf-8?B?M2JWbjM3THBzb01EWktjZG5yZlhBV3V3QU1Ya0V5QlJ4Tm5CR05TK1Ayc3dI?=
 =?utf-8?B?Z1B5YmFzQUpubmtUclZ0akF4c04xS2dwbElxaitNdHg4NkxpTFVsQlpNZmRy?=
 =?utf-8?B?K0NkakdmbnRveFhCT1VLZjhyazdmNzVUZ041amJOQkdCbXRmWTQxalNCekZy?=
 =?utf-8?B?cnFyRTJXRVYwWFJFbVRiQnJqMm5RNm5OcFVHTHIvbDNGbkRTaDE3TndHY2ZV?=
 =?utf-8?B?Rllac3RmUnIxUDFCVEUzaGZWZUJ5ZEU1VHpyU2ZqL3BWdnZBR2NDMDZiek8y?=
 =?utf-8?B?djE4RlNMTkE3alNUSGxMV2h5SWNCbHBtQjNFd2plTFl6QUFZTXVUWjc1Y1NK?=
 =?utf-8?B?dFMwV1ZTUFVxNjJMYmJ5MnY5cVR5bjU1OGE2L0tGNmxGOFdJRnIwd3hVRDJY?=
 =?utf-8?B?d2JsejJQZHQ5dG8wNjV5YlRYV3ZCUHdEdGhXSUg0TXh0bVMyL0JhSzhqanp2?=
 =?utf-8?B?S2hNUTJmeXZYVGk3RWdpNVNDZVNpQnNzclBocXNRcUV1MUphSHZpWTRQNXBG?=
 =?utf-8?B?ODZWSHBseU1lcU53YzczT2lXaXhVMkN5VFNNQTlBQWZqV1ZraHh3eVVBV2xp?=
 =?utf-8?B?NWV2ZG8rMnl4MW5HTk94Mm9qSEV6Y1dEQ3RsbFlQemJBMzBKTEd0UTdjeFdB?=
 =?utf-8?B?Q2MwSjcxSVc0cm9udWpjVExYb0lQUVRRUEQ5elkvbEYzanBLejVEYkRrTCtv?=
 =?utf-8?B?NVI3V0wxUFdhbnA4UUVIeU85c3g0SGZaZ2ZQOFJpbEVDUVdwWkw0L1hFeEFy?=
 =?utf-8?B?VlUyV2xPREZGWlI5bXA3cXA1NU5TS21mMXFQcVpnS0VmQVc4RkRtWXB4ZmJ6?=
 =?utf-8?B?REFWWDI0a01CWHkzTW1lME1QSHg4K0pmKzNMSGUwUGNQZFBjR2Evb0ZFTmVX?=
 =?utf-8?B?YTJTSHl4NlZTSDJvUkpIQk5uM2VlQlNKYTBVQ0twb0REWlo0eVZnbTF3UnEw?=
 =?utf-8?B?OVd3UERJeUZ0VStwMFVxbXp3cG9MVzkyTXF0RGZMUkZkb3pCZTZwWWhHRUY1?=
 =?utf-8?B?WE5vTStSd0NldWRZYzA4ZnJoMjVLU2FDcWRFd0FZaXpDVW5kSm1IMVNFMnVG?=
 =?utf-8?B?VEMrSlJ3OVorejRscXpWZDNpQXhkQmVjUWdzM0RDWnF2V2ZDNDdZOWdVTldt?=
 =?utf-8?B?enhsaG84WEtyeW9rSmFKVnVsbnR0WVkvWC9uajNMY1hZZkJINzJSME96RkxW?=
 =?utf-8?B?ZGIrK0lScnNES3JlVm9ROUhjc3lNOWtMZGxKS292RUFtR3JsLzVHdnpxZTlJ?=
 =?utf-8?B?Vkd6MVQreXBjM0ZkZ1d4VWFIanhSaW96aE5MQmgvM1ErbHJjT2tzR0s1V1ZV?=
 =?utf-8?B?dVZQMUF2c1N3Q0ZrTWF1WUFBTTJhZW1qRlUzbUMxS1FsN3VoZWpvb2hxV1Ur?=
 =?utf-8?B?VVFGeTFRTXNOMGVTTlFzd2dYaXNZcTNMc3cxRC9sSkdXUThBMjVkaW0rbWds?=
 =?utf-8?Q?cv7U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05a8363-f12d-4df5-a78c-08dc913fb06d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:43:11.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrWvjbEd8m4Lw3Wx/g3Q46sUMTkNKpixRln6kN2GXmTVK2BqxDkW4hRBrRhT9RLN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101

Hi Reinette,


On 6/14/24 13:37, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/5/24 3:45 PM, Babu Moger wrote:
>> In an effort to support MBM and MBA tests for AMD, renaming for variable
>> and functions to generic names. For Intel, the memory controller is called
> 
> Changelog usually starts with some context and then problem to be solved.
> What
> the patch does follows that. Maybe just something like:
> 
>     For Intel, the memory controller is called Integrated Memory
>     Controller (IMC). For AMD, it is called Unified Memory Controller (UMC).
>                                                                                     Change the names of variables and functions from imc to mc in preparation
>     for support of MBM and MBA tests for AMD.
>                                                                                     No functional change.

Sure.

> 
>> Integrated Memory Controllers (IMC). For AMD, it is called Unified
>> Memory Controller (UMC).
>>
>> Change the names of variables and functions from imc (Integrated memory
>> controller) to mc(Memory Controller). No functional change.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> @@ -349,10 +350,10 @@ static void do_imc_mem_bw_test(void)
>>    *
>>    * Return: = 0 on success. < 0 on failure.
>>    */
>> -static int get_mem_bw_imc(const char *bw_report, float *bw_imc)
>> +static int get_mem_bw_mc(const char *bw_report, float *bw_mc)
> 
> The name of the function is expected to be changed in the function comments
> also.

Ok.

> 
>>   {
>>       float reads, writes, of_mul_read, of_mul_write;
>> -    int imc;
>> +    int mc;
>>         /* Start all iMC counters to log values (both read and write) */
> 
> Was this intended to be MC?

Yes.

> 
>>       reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>> @@ -361,21 +362,21 @@ static int get_mem_bw_imc(const char *bw_report,
>> float *bw_imc)
>>        * Get results which are stored in struct type imc_counter_config
>>        * Take overflow into consideration before calculating total
>> bandwidth.
>>        */
> 
> In below snippet imc_counter_config is renamed to mc_counter_config yet the
> comment above was not changed to match.

Will correct it.

> 
>> -    for (imc = 0; imc < imcs; imc++) {
>> -        struct imc_counter_config *r =
>> -            &imc_counters_config[imc][READ];
>> -        struct imc_counter_config *w =
>> -            &imc_counters_config[imc][WRITE];
>> +    for (mc = 0; mc < mcs; mc++) {
>> +        struct mc_counter_config *r =
>> +            &mc_counters_config[mc][READ];
>> +        struct mc_counter_config *w =
>> +            &mc_counters_config[mc][WRITE];
>>   
> 
> I noticed a couple of misses by just looking at this patch. You can
> use grep to ensure that this patch does what you intend.

Sure.--
Thanks
Babu Moger

