Return-Path: <linux-kselftest+bounces-44443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF0DC215AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890DC3A2629
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D12FABE0;
	Thu, 30 Oct 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ec6vIh0h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB223909F;
	Thu, 30 Oct 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843466; cv=fail; b=rhbt14y6txYw3b2Ba0Ng/mFgyy6L7PibaMf5LogA6qkQdCtH8PEv5o4B/g11LepXacnBO/PSgmG4UFJIGLgFmAsKFU2ohgRuM3YjwZvyeCBVlZsev0ZJaAv4rw7PV/ikE/D1Qs9OVjZEWDmqlFvAAgSG6gO/5UiIJ/wMPiWs4vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843466; c=relaxed/simple;
	bh=BEK3zr6VIIDsE6xR+qU0VZDjqMM+B0O/IBMEIEzIB3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJvB3AKhzoU9Aj0gU/rcMeoLzQMXjBSO0zP1BC6f49DySBsRWOEn2+T1WbarVkUl6ic5qSeKqloag2Try1nxYfDygmIvp3li8FAyzgqB2JvmfHfRnI9SK9V5Tk6pR/XoQAvftVhm039QkLnCGeDrU+erTV0Nwca5dxrlzBGHdq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ec6vIh0h; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihB73DrmBd3KJWN7WUNCYHRYCKP9K+gEeTVldJUueigY7ChryPgK4IolWkNZ0Zpw7d7OUarkrc4QJdqsHd6cy6zSBGBSSw/UmARQMVHaFZGLzHTerHCzVGifEn1xHxhDRh7poK709fub7re/odjXOz+gZ/T+w91aW3/bzirYKRBMZEVnMoEA1zq/w8yvwGxibBPaHwQkHbA5zcAsNeIvlLVP65d/wGsT8VElPqRjUzqUkeTOyrI+WpkulNyMOHTD4dIG13b9W7gMfBap848JK+KxKpNXOyyVby6XsTu+tvnCS2d+jrdiSMNHjxQwW/fbWfaal9sUYCcs3rRJWbF9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qej8wY9XhapkSE4VRNblc249pNttWRP/GPOW//UiUzs=;
 b=GX+y7LDXs/IkyzVUQRgvvEXfG9cSHDU98R1SLjEjYvEc6sVRCGAzSjIDX1AnFVjvnt11wicpE8bJYchBEyfRZMZGcsFtvANOJBzYQmIJt84/lv8oIJufunZT8i6nvZx/bHnNyKhTNT/4begytzTYkX7gYZx7ORRQ+t3qyL/qkDtcM2zzozeSUgdjW8rPJcLeD2138JrzN+3kXw6UVJgyDCd22sYjW+X+0Rh5JIDZl9jVhRRAzB+y/v2EVWuJKfuJ3ga7wLGldwx4v98AhuMYjSYogR2kxnldwUuoGxRE2nycbnzqdQHZ3tR8wZ6Nzye4Rqjr7XAWN4pnzvcT/M8GGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qej8wY9XhapkSE4VRNblc249pNttWRP/GPOW//UiUzs=;
 b=ec6vIh0hruXgZi0aEXFT/pJcDkH/3DgYX0J5GIcYJdhIufXDSVZqnR1AdPFycZDG52/VbP2fRiLdG4UxkvmBZHog3H/6fz++16s7h0Jp/CHrVYnIVJTJobEzhOY1xtk+cyMacjrF9m/hUeANJ03zrlVKpwxgmCMdc2F4Vdqn/9fx5E3ZYrNwTSMLNQq8NpaWCjPYcbukcEQq4Sn1jUlqShzedAG7IpRAvbLj7rOXGARuFqfIbrHf8ejdKrq5CIGv6gIimjjMRw2VOUo2ZdaLOiyZlTB7anl2Vy76tPmxCm7kH08ykVvDPUpZvG07eqyJONckX+RkL+TWMFNFQYvtOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 16:57:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 16:57:41 +0000
Date: Thu, 30 Oct 2025 17:57:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] selftests/sched_ext: Add test for sched_ext
 dl_server
Message-ID: <aQOZAtXtD023n5sc@gpd4>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-11-arighi@nvidia.com>
 <fcf2fe41-54bb-42af-a4ff-c3f39e62afdf@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf2fe41-54bb-42af-a4ff-c3f39e62afdf@arm.com>
X-ClientProxiedBy: MI0P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: afb1edb3-556f-43b4-58ce-08de17d57047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/R+wplvlQlrNTjgyMDpr1rrL/TGHE0nVhfrAcklrdKJVkY/S/36PTU2HPQK0?=
 =?us-ascii?Q?soT0O0T5qwpWg6jnaXe6I6Wci/WHJTKl1+8mpdfqJJcbbkHWnzizS9TVoCsT?=
 =?us-ascii?Q?7hGRXGSSJGHKWwWO6csL4uUikkDyiuEE+VDmRmkDjEQEwA1nLGZCxdumGrG0?=
 =?us-ascii?Q?bOuTGkrEarvDxZcFjSjaaSc/bBx8VE0LXWdn/WQg0hxEOgH8wkjpVQNN8zwR?=
 =?us-ascii?Q?vHlRrKB+W4RMwk6dbyFFo52rzBaaC0VxEpOCS/5ELqhTmJ9yCLsZsxXgv2s1?=
 =?us-ascii?Q?yqdsfOr8nMpCi8eVHA64iyoHGdG7trldEi4ZjUPm/b4sBAizcthKxUdpwf9D?=
 =?us-ascii?Q?rKcH9b7L4SuAHZqIS6+1/5AUphj48zQovqgXTLKf/f6UgRYn2aQATskaAoJg?=
 =?us-ascii?Q?ZfDx1ZzjKsFqohjriMX+HBFJoMHNmnLz25A9FAYYeFqdL05UJKfQukyRMTFu?=
 =?us-ascii?Q?HqhYKEVK+6zhI4QC3Gdcpgk35tg4OoigIL+hm/2+4QdutSyN38luO3xLjghZ?=
 =?us-ascii?Q?/OKUMseMfJwKRsVbF5HHsa+vFhVRESq4DDgmYHq3D5KpAkpz6k9wJhw7OWxi?=
 =?us-ascii?Q?go1S4ESBCJvUlcZ3rWE9O2y0tpbll0pTSr5v4ZyujXKPR5WXdIR2g4otVr1W?=
 =?us-ascii?Q?qaSmRr9d5L6nzqwoyRh75BKuROynVecIyaAvBVS18uFT2hJkeymqMGWXewlV?=
 =?us-ascii?Q?zUjTme+sYU9fXWTPHaYgOieRdl6kKhw7oEGq1seM7fSjuBU+8C9EorCYghUG?=
 =?us-ascii?Q?9qKOjRUkh+TwjM+KNGXZBRhgyNXFP7ZUuq/G2Ya015Jtk0kTU1USgWgV6Nrd?=
 =?us-ascii?Q?mZAg3oM9BQ6Hz6AupjJLF2Mya71CqP8FCxB8M/oAPEUw5J9wIb33Y3vk7cD5?=
 =?us-ascii?Q?ZxhKkvL4Vk2LRSq8gKSCuoBuOR5l0p5snDN2Kj2T9+ci5RyHP5FcInkNRBL5?=
 =?us-ascii?Q?qrf+y5MtR3Qb8fY/d4N0OktzAU/qgrnkEIywLB3kgJZc/kkwFWs1Ib1P1vWE?=
 =?us-ascii?Q?FLxvsDIstZMq6UAQvij2lfwqcmCGGDgdJBGPXc9Mr3r0S+CGmPdclp8xLVXr?=
 =?us-ascii?Q?/PgXAYU/1pkxmwEGwRqhNALFthsAfigbct/mZCfRraf8KBMmbU+AXohtAEU7?=
 =?us-ascii?Q?s4fPutzLXAmvplOcKWdu9eQsNorwSLCLvJI/OiCSSaMvpQyobI/i8FArC75z?=
 =?us-ascii?Q?otWBgF2M/M9KEddZKg+K1kesZPKG2GjR7fkExDOHiwbKMP0WYZyr7MPOwp7E?=
 =?us-ascii?Q?MCwlkOYNUkU4iFbgwAJ0n/I7SToiibN7APkofVeVG4ltPDGO3pLqp70CbZlI?=
 =?us-ascii?Q?goAZ47wyJzwQqYDRymH3rzxG+l4SzA1FKumstmwBMsYFwroD8lg4hLbxMIWA?=
 =?us-ascii?Q?03gQd2piAHISV7EKBOM9W5dSRcZUHIAP+v6BvibTvxTm5CCJ6VVxB/Pqz07g?=
 =?us-ascii?Q?tzebK9I1YbLr5QKEbZUg++979+LliyFx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AA9RsRlnSFafWJklUV89UuQXHiteimGlbDLxdnYDNAfCainrdKIzrpZjuwDO?=
 =?us-ascii?Q?bJKA1LDR1TmdcIIAtbhZqaig5LPsKdHk0g9a+WJaZFoE3D5ApFS7RMc27vld?=
 =?us-ascii?Q?Trm0JlNvKvqobcdRJuXmrpvSuYF35i5X7g+e0k+toFzXTStW98kheyT1hb03?=
 =?us-ascii?Q?SVPUnW94TywxgCJ3SjIZ6kShgzEDR7n4GK3ztYv0NbaHBlXiQZjgnpGfsY7j?=
 =?us-ascii?Q?d40snnsnICD/G/uUdLPF/tH7HUYBbTVkw19P2y+i1kBR7G69kAI4yAcUQpyB?=
 =?us-ascii?Q?jcgNTqrfEPOtVFyuKc4eZOT5ZsHFSdO10AGKv0t8ed+r747sFAgRTslMgyFg?=
 =?us-ascii?Q?W7lF+Lr7XAIeOtQAjS0l05zOBKagd3eD9vdt9HOiXue4spEFRJRb3GQsl4Wa?=
 =?us-ascii?Q?v0IeYm8HkruvfACeVkiTijMA+/K95nJqkLD8viYQyA+ig49FAEFzG72Un/wJ?=
 =?us-ascii?Q?abBnt8FZyXNWBX7AeXK3slBAtW1AYyRavYW1hqYt+7JFnnBZ0/EhIe66UGxA?=
 =?us-ascii?Q?GWv4yx+E27XTCqJkNrPV5b26iN8UdkkSGHoe3WVPRs/55pITZH/ys5bHXdG5?=
 =?us-ascii?Q?82YsAAGvdHfJLWGD5yLAd5YQtVb7WbY59hO19bk9xPvpbsVHNBATm0CL7oAk?=
 =?us-ascii?Q?v+JNiRftx7lQhmhQBqEC7vldWQ6joH5vrdkyfejEeVuZ0YRu4LXTvjbyzGRe?=
 =?us-ascii?Q?HvI1lW5aOa5TPAE5cA4OX4IbLz24aE227evbtibZCDYfViF0ccCWuyxfeLEi?=
 =?us-ascii?Q?8OHnXTDPxgqiy3eZY/kNNExrFEXjHZdDgSbl7EdeZRF9x0SM+eIMdJ39McSJ?=
 =?us-ascii?Q?VdMeGqnn6bE+WVzi1fcNDvRBO9EqPAf7FgSfjiCC/whckejmMkSST5scg/un?=
 =?us-ascii?Q?mgAx1uwgox/vrXXanDkN7lsgvP9sxUwUHPqx3NWQYgJ8sCq4INZOI0c3ZvlW?=
 =?us-ascii?Q?PcqKt45MUOdQ2LwTIKSAC86qkGIE4gOLOFw9i9KUStEluASnEtEWk0CF9tSm?=
 =?us-ascii?Q?UTGgH5aggcTtb6qZ0CPu698F+bTjX2Bq8Z9gV0JktLLeYXqCznYRzv3WizWd?=
 =?us-ascii?Q?o147oPWe5+Ek1rSq/nLV1f2kO5IGg6YdAUzafhcIf8FBWR55cLA5wc/ts55H?=
 =?us-ascii?Q?dKBNRUBoJv8scFBgvux1vdTDNn6n8JrGCYCtrD81QThp7VzNQY6agghxp1cB?=
 =?us-ascii?Q?BCME0lbmVBymwrOFiMmaZobNCCXN6cLQeoKbvzM/VSqWHy/pJ2/3QRP5Ecf/?=
 =?us-ascii?Q?T/m9X4Je8lf9KXn/KZyHYIf/nyJG7hUSuvywSvPf/cCGrU4VD43H6WP9oEv4?=
 =?us-ascii?Q?cgD9vA6TVeI1fjd7ffRx+emLfIiPEV9hLlDixP9bUG514RC7/J7TGG4g3yzo?=
 =?us-ascii?Q?HMfRK+rf4qIDHZs506bGQcvkObHoNPCX1Aqce+717x5ap2zxQ/uJYSSPZoNC?=
 =?us-ascii?Q?vy0F+xPwUWOamcxQPrXjlnNR0IYQ38csu73c2V5ov2aO4HnsFXEdAMTDwCJ6?=
 =?us-ascii?Q?hTwe1blVH0SNGpSgpCYKkl5MpOO5veTfz/0PbdXRb+usTy5V8CW+nZ6BCQIZ?=
 =?us-ascii?Q?kWxdtyC6vnhv19tsW331J+Uuqjf440H1bmdXY7jo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb1edb3-556f-43b4-58ce-08de17d57047
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:57:41.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43WTVVYUYrFXES58NpQvzeXuTAf1YxeUVCrBsrdW//rSDs/5OGIivHxSt3zVEVGtQ9GQCV1WUeNDKhPDIjAi1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121

Hi Christian,

On Thu, Oct 30, 2025 at 04:49:48PM +0000, Christian Loehle wrote:
> On 10/29/25 19:08, Andrea Righi wrote:
> > Add a selftest to validate the correct behavior of the deadline server
> > for the ext_sched_class.
> > 
> > v3: - add a comment to explain the 4% threshold (Emil Tsalapatis)
> > v2: - replaced occurences of CFS in the test with EXT (Joel Fernandes)
> > 
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
...
> I'd still prefer something like the below to also test if the
> fair_server stop -> ext_server start -> fair_server start -> ext_server stop
> flow works correctly, but FWIW
> Tested-by: Christian Loehle <christian.loehle@arm.com>

Ack, I'll also run some tests on my side with this applied.

And yes, this definitely improves the selftest. I think we can also apply
it as a follow-up patch later.

Thanks,
-Andrea

> 
> 
> ------8<------
> @@ -188,19 +188,24 @@ static bool sched_stress_test(void)
>  static enum scx_test_status run(void *ctx)
>  {
>         struct rt_stall *skel = ctx;
> -       struct bpf_link *link;
> +       struct bpf_link *link = NULL;
>         bool res;
>  
> -       link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
> -       SCX_FAIL_IF(!link, "Failed to attach scheduler");
> -
> -       res = sched_stress_test();
> -
> -       SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
> -       bpf_link__destroy(link);
> -
> -       if (!res)
> -               ksft_exit_fail();
> +       for (int i = 0; i < 4; i++) {
> +               if (i % 2) {
> +                       memset(&skel->data->uei, 0, sizeof(skel->data->uei));
> +                       link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
> +                       SCX_FAIL_IF(!link, "Failed to attach scheduler");
> +               }
> +               res = sched_stress_test();
> +               if (i % 2) {
> +                       SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
> +                       bpf_link__destroy(link);
> +               }
> +
> +               if (!res)
> +                       ksft_exit_fail();
> +       }
>  
>         return SCX_TEST_PASS;
>  }
> 

