Return-Path: <linux-kselftest+bounces-12177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458690DEC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 23:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D80E1C23072
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 21:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253D179211;
	Tue, 18 Jun 2024 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fRMcKjsg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616641741E5;
	Tue, 18 Jun 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747723; cv=fail; b=NWsaONznYYtHyuD689HWsos82FIRfWVyQ0TSI7ztid9sMyh7V7ZpL9nyhM60M8W4Os1EbY/sFUgwbOFszuxDkMC7U4kSQhH4XAt/i+3WyyNGMjyiTgrRPEpPBh/oU0mRN8hmSW4TqTASLEZ2VWR+BCzWSjIvKlu+1pUDoza9J+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747723; c=relaxed/simple;
	bh=KYEuLRMYijezD2UiHq50yo0wkk57ciTvKXoMRQxtNaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DsPaS24TWGQ19VI6jeamcjtMiJfxrm5FISCbutdqZ9NMOHjrEgBcIoMduKJdMLeVGlQUBThnSCSM6zODeviMhIn8FHHli0TWxU7lPnFINzqVoWGjug2PFidJOSjsLATOvekhvpcu01JIRcLdD6knge0lCEg9a4v65nORI3+wge4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fRMcKjsg; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw/nKIRexWJggo70W7cnS0XXGvwsjmlNyXC1R/FCYNZQLvJov6c29b6YPCvVAVvNaZQMzXTjgQTshks6m+baeaX2UqY1uG11bKeeIk3FDj8/GspHSJ3aUqQRGL8PtQy9v5I0Vr0cya+GUvd7O1DULe8ibMOaTHdP5Jl3ar2GWYur+X0y8WZ8LzzlIbUeKbybuHDhjkRge1TAqCyKpTyq20b6hXK9Q6ByDXIF0K/vQkEXMRg11JEmfu+Qm/5GEVX8q0V8OyMK/sXibZH11lBFlDmvMMPXxl+s5oR5snhyjrUuoOOabcg4SfM5JUgTbvwEiqQSkBT0p8GLvLgCCyzwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj2kgZUo4iSns2TqrKpfBAS9wtFpm0Ppdmv48eRfwMc=;
 b=lpBL2K/z+wf/uH+XzR57g7d7L7RMwaVVE3g5F3eOa1cTc6G04nfXCwzBJFbZ0pDUoiiLH3lCVU9oq+zVhXrhsFnThUgM3Dwi4eQp1DuUGllwAYt1Sx1uC1K1YZt2DG+/wwBiHb+McQVL59SzB2IBR0ksKH8OVMiy3+f1R5ArRSqWOOxGhXc2mcB/zSIk0PoWM+OaXWPXA8FPQ4c/ZjSV34JHbLTVT2stWFKsb2jtKVa5Dbrv2ER7kctl06c9Z06cUzOO44bYS3iguZa/fLxwXBQRaZAsF0Z1+o6FuluMOrKZ9Gf4i/OXnYDOy6tql78A7uym9F5nQX/4dhINCiFdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj2kgZUo4iSns2TqrKpfBAS9wtFpm0Ppdmv48eRfwMc=;
 b=fRMcKjsgkJXfs1W6ZuGCj3jTJembfjCufLLcBLISdkJ0FzmkG3eFWbXX35LbcTQllViEcIDvzwtfW+BiEmYA9PSEH2EJwtG+peXQzhXnj47wY1KDyEHX31TXHv67tz1XbPa+X0mmWQPNVZpDYYe2tMg3ijK3SnIwWtiiMBok9i/WTXHn6vZ546fVKdg+dxCLwH+tj2JSruf7r61mnlKSTyK9kp3Ga+I5vh1CGF2uxwCN/XwWAFohqoaNebCsKNAWySMoTsHZLhcq/Wggvd+fz5KworBjh81t+O0r9F1tSiKTBzmL2zZq1GS0knfHcjGSaIJP5RIlFvNFfTd/bcXZYA==
Received: from BLAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:32d::8)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:55:15 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::77) by BLAPR03CA0033.outlook.office365.com
 (2603:10b6:208:32d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 21:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 21:55:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:55:01 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 14:55:00 -0700
Message-ID: <9e1ab5f0-68ef-4eec-aa07-04a202037d5d@nvidia.com>
Date: Tue, 18 Jun 2024 14:54:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@redhat.com>, Jeff Xu <jeffxu@chromium.org>,
	"Shuah Khan" <shuah@kernel.org>, Andrei Vagin <avagin@google.com>, Axel
 Rasmussen <axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, Rich Felker
	<dalias@libc.org>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
 <20240618022422.804305-2-jhubbard@nvidia.com>
 <0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com>
 <9d08f768-b9da-4a44-9d75-a16d6cde6b66@nvidia.com>
 <916f5ba4-02c4-4a33-97e1-5343bde5ae54@redhat.com>
 <ee207aed-d116-49b4-a5cc-91385c52e258@nvidia.com>
 <20240618145348.d49c130694dcde29ec7a6c8e@linux-foundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240618145348.d49c130694dcde29ec7a6c8e@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b5ae8f-c431-4124-79c4-08dc8fe15658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|7416011|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW9FTHQ2emVBQWVrODZpWStWNVhnVEpwd05xaGVacEtuUmdnY3NOWFpDOTJ0?=
 =?utf-8?B?Wkg0MEpvVXkvMFdtYVZJMmM2cDN2b1Fqa2tKeEVmS3dPV01waml2bWJkaXlL?=
 =?utf-8?B?TWpUbW5DeXNjTDlSTjBTZWthM2YvRTV3RHlFdGNKWnB2SlRrYkJZcks4MmxW?=
 =?utf-8?B?SkcxK3pnNVV2YWZGei9yZUc0djl0RWJ5MkRUeVF5MEo5ZlFrRzY4K3N3Unh2?=
 =?utf-8?B?QjI2dHBiOHpQYUQ1Qjd0K01YVS81ZDNVRW1qS0dqY01sek56cEF4ZGxwYlox?=
 =?utf-8?B?LzFQaklQWVRseG5nZWtJcEVLM1BURUU4YmdlblUzRWI2Y3hWM1J4SldmQ2pU?=
 =?utf-8?B?MVFxcmxOdjBBeFQ1QlpOMXZVRmVVbFprbkdySm94amJ6NUhoVjlabjVzbjUz?=
 =?utf-8?B?R0hJT2VVOHlEZkNyVGVqYjR6dzg0Tm9HU2FHWWI4NEJLKzd0ODV4OHM3bDFN?=
 =?utf-8?B?elhsZDVkQXJIeGM2dVpuRWZnZjlvNmlJZnNkcEdML0dXeHcwQVBldFF3dnlX?=
 =?utf-8?B?cXNKN21BdXQ2TWVhR0d3UE5aRE92Zkozblp6ZXlsTHFTaXN6dEN2MTNNbm5o?=
 =?utf-8?B?RFEzTzJrK1lwakMxdjlBWGNDVGFvRVNWcEJBa2pTZzZtSmh2WHV3VGY3TmRn?=
 =?utf-8?B?dXJmQy9Gd0lmcjU1VE9VQ3FJZlRwQStsd2d6UmxjSW9yc3JaK0YrOTIvTjNJ?=
 =?utf-8?B?Z2Z2Y3dBaVBsdUxoWnp6bUFucVZDVlBBbzlMbldiNGVsUnVuSjFhdWM1S2Vn?=
 =?utf-8?B?MHdkdElHOWZ6ZHFIeFo1dFBuRldBUTlPNlRYWUVxUkQ2VWRWa3NJSU1yVk1J?=
 =?utf-8?B?NVhPTFlFS2VFOE1YbzJjdmdDdWZRYk55cW9qcDVGRERUNTNJMjJkRGdtU0dH?=
 =?utf-8?B?NFpWeGtEYXBnaW9Cb2tOaEp1cG1PM0EvSjMrQnk2dWZVQ0JFb1FZbmlWMGdQ?=
 =?utf-8?B?RWtIMGM5UFJreGRCZmljOVNWeXIzNzJDdVVPOUJZZDNFWS9MQnFpR1Fab2tV?=
 =?utf-8?B?MUR4TFU0dmtuUm45K3NESExrbHFFSUpxQjRqMTZTWkhhV2VSeVM1Z2sxRm9I?=
 =?utf-8?B?eGtlc0tJQ1R3eU94YUU2MloweURwdnA4N0NwK2FzU2wvNlF5a3RocE4vQ2NF?=
 =?utf-8?B?b1A2Sk5TS2xOVWhBUkxHUyt5M1hQUFNJUmlnZWdHWnRGZjFLZENCRE5sUEpO?=
 =?utf-8?B?cGVVZm9SNEh5OGJwaW9uS1NwQ0lFZXN4Z1M0eWVSMFJwVW9zdWIrZE0vMEdZ?=
 =?utf-8?B?M3ZjcVFiTnl0dzk0SVV4SlFhLzZCSDNTcThqb1A5NUM0dm5qS2R5SEh6NVAv?=
 =?utf-8?B?VmRlZ2kzRWtHSTVhYWNpV3Y3TU9hZkRPTjI5aE9yK29BcGVVeFpYbGFCNnJN?=
 =?utf-8?B?a0NTKzJnUVphYlpBRDZvaDJpUEtCc2hTVFNoQW4rOU1nVThucWVmam0rOXkz?=
 =?utf-8?B?bXk5d3pvVVF1WWx4QUh3M05LaThLWFpEYktFSHczTU1hNEMxb1FpUEZLbTdh?=
 =?utf-8?B?Y1NFb1EreWRzZzFYYUZENDlNblg3M3Y4aWZpZFNod1N2WG1pbHU2azRqN1BG?=
 =?utf-8?B?SElhazVsZUgwRFk2L2dwejFtKzZVbEhWUmVwaUFKdXF1OGZXbUp4ajdhVDVt?=
 =?utf-8?B?OG9rQlh3QnR1TkUzTXdtVjBJbWJnSnlFNzQydjVpTVlyWWUydTZ4YVlDaStp?=
 =?utf-8?B?MnlxRnJHTm9heVJtNU1ZTHovV0gxREtWOGFZdHRoYnByUUZ3bFJYWDBiTC9x?=
 =?utf-8?B?RUp0N2hBYnhySXBBWWxEVHBpN2tOQ0lvRVFKTVFQSXJMdFJSZnVmVjcrU1kx?=
 =?utf-8?B?WEJFaER5VEllVE9vZDdzRmxoSkZCODBBMEdYaEJvQ1BERlR5RUh0V1J0eHNy?=
 =?utf-8?B?eW1qSkN2RXVBUHkvQkJVeElSbDFHNHFma1RENkNqNUdzclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(7416011)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:55:15.6789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b5ae8f-c431-4124-79c4-08dc8fe15658
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969

On 6/18/24 2:53 PM, Andrew Morton wrote:
> On Tue, 18 Jun 2024 14:29:32 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> OK, I've drafted an updated commit description (below)
> 
> <copy><paste>

Awesome! :)


thanks,
-- 
John Hubbard
NVIDIA


