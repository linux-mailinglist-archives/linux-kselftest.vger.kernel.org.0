Return-Path: <linux-kselftest+bounces-45018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F8C3C931
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127FC3A577F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411433F38A;
	Thu,  6 Nov 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIHNlcxX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABB346A12;
	Thu,  6 Nov 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447215; cv=fail; b=qUKP1lFD1/SdXofG4HlLYbuR9AFnnke4mSGi2rMWY6c4MCEQ1UBcG0zHpt5Y3DnjteRJqKrOT7JS+bRYlXW1jZ5RiSR+oCJMXd3H4idoRqZdAnqve0WTSUt6L6p4gJ696dAzXVW86zpxrcDFRGeDiRcz0C5un7FZHaJmiVZ7Wxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447215; c=relaxed/simple;
	bh=9EvzigHVXWMvCSERnEPO2tVWyEyxchUy1j9CXFdiqzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cZXIhyGUc4r7LgMUByKB5qvwGEvhiAP4ruxl8170LlEGqJ4YzLCpItjgJZaW8C0J4oJU+JQQlZ71h6Wi/90YSDsmCuNUwgPLhFYJx4m/JQV7isXGTo8PHlynxg5z4otB174TKR5n9YAOsADyN0xCZ0JhcX52ddnbHoq5mRDE2OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIHNlcxX; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6Dj7QNjK2oY0TLuwlERYBOnBNlgo0OqVzgR8oOV2W1xBzwrQSnlLKtLH+kLWWTctqmpaIvRaamgxYqMIk7Hw4pzriTnAAOLoGb4ZKCY3mtABMfEhgMSPKO9kJKzF1PTFq2UtdeuejTF31xQjiRQL11hZQSrKmncCi8be/EXqnUzmMvYqohzzNf7/wcwPGkiF3vn1aEUalMZcFB0wzbINUkEJhWqBl961eFjBsxZEH/kNd6PNPV0f5IJ/Yb/aX7eF3BwxsqENiO4Il5yb4kAUXg69U/fDRnXKwfaFDi7GVJ1tO6ZzpCaIkPuosrfXnkxasY9F98/rjy+f77m7TKFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6eLPXUujupxthz6DzJLzi55ie+towXCjxW0yWlcq+w=;
 b=KVbgA3k++XMhcYSw3Jg6vaQX5YyCgS872/eL32TMKbZ8rgEl2PxRtjwTvpypPWA4ecds71oaN1vhtpkAOUJnR4Du3vhvKy94EysHP4pzxnse7QddHjqXvzhLIVQTy1yFt7VsAa7W57kVWT87RjByTenvAa4TFEvOftoxJg2xHDoULUw5LGkqmmjwJIEZ6T8GZDYx44i7DGZstVzABIHQiKXmhlYvVQiCt0gqNwF7o72jHUwGBha+j1Gvq6ujVIOCHT0NS8/BhEjQE88XH2x7zYxgxDslS+cE+xcddbhdDEyaJ3JsaCNR+u10Xlvl5M97utgWrA2yWqQXPYUpgGY8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6eLPXUujupxthz6DzJLzi55ie+towXCjxW0yWlcq+w=;
 b=JIHNlcxXGdQM/MPNaHf8Pbwbj1a4H1h/je8P7D0eBPqYs0Rg79PrIt8Tk2OUWt6/HP4KsGfbidiZAJnv+QlHUOotdeoGfNxIAbxWpeY94j0tqLyHaiPsX4MXXRZLtFBhNo73yKTUnBttTCLm8Gd7xthmxg9p0OGYYVs848RvQ3kiPhkCJKGl6Io+/h6LlYw4VCQm59JfpSwEHp4KvoRVQC8x1kOmm+m57l0UKtd0+2gspIZZR9pRbzLb4pFFjtuI+NbmrL/Vb9EuqmuzSEw0QvTh6FXZQByKRvgB6Vp7aj/vQZ0Xd7Zu3f39qs4Hx7UaxDVa6dVSgnoY9Rp2YB9/eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:40:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 16:40:09 +0000
Date: Thu, 6 Nov 2025 17:39:50 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aQzPVuI-dHEfee4W@gpd4>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-3-arighi@nvidia.com>
 <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 311e4e95-6c2f-4558-c929-08de1d53257d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOsf769aZkt/VQvn4UNXEfMfyYPqmZoMMtb1z6GaZeH0FSRK3+4TKMQ52b3G?=
 =?us-ascii?Q?sxEQXJdZq2jN7SkD0n0zIumJ4KU+HQnkTkDKcxn8tBjRMxD6jKkdxWIo514r?=
 =?us-ascii?Q?Y+gODs0D9cpRFnjJOd40/+WpfryNuF3ClfFI4MhwPhJ6QInA4e0tSa8v5YXN?=
 =?us-ascii?Q?Hf835WaNxHNYiXaTLHp1dfZl2nxteJun2eeEgbRtefDcaVnQIhhLsdeIQI20?=
 =?us-ascii?Q?NE6Dd+x2zIUriW6ahVuOv1+p40QjU8k5bjGn5828MKCO35TV10UGBoV309tS?=
 =?us-ascii?Q?/LATAwOzXyk26Zsh/0K6kQueFsrlvYiqFspI24eVVhGQMZH3unb7LwKDO5M2?=
 =?us-ascii?Q?PQRM4/vmZ7uUvR3QxMlpIfXwujcJIXtsRPG4wdQzM4C88H/gg8Bnt8jvmIVG?=
 =?us-ascii?Q?yDO31S2id7M3pHee4tun6X6RZlrJXYLn2eS3aWP/Viz82U7KmDvqUxu8u1e6?=
 =?us-ascii?Q?VR1m486qm5acEBKU2ch26Wgvs+ZFrM9FSNDsQ7aWd5nYsX6AD8VmnZwvDiTQ?=
 =?us-ascii?Q?jUaVQp/hd/Xn5LUWFP634O3twl0lsFbAi3b/MLXT1+SCNUxy2GyX/4D98eeh?=
 =?us-ascii?Q?ZtQ7YeM8DjpcV662K8/tbpuhFndLlru9sgnbD31MCOfs4XXamQLBMQCcG9ZQ?=
 =?us-ascii?Q?jrIdJmFFWXENkaMaEw7rKTQYeixD6ozzGcNkbPsNZWhlKqF96IRt78mvWMV1?=
 =?us-ascii?Q?rGR5kBz6uy3Inxup/x14XFbaogLBK0HNw0qsyzfj2BHHTmQ/gCZGbLeMiweA?=
 =?us-ascii?Q?E0/sokGef8rieLbcdjI3rBU06nI58K0wfaaRZShcp9ZlzIsbqhUrw5E1ew16?=
 =?us-ascii?Q?femcquW8H+HSspHxXhvgRREuUGEoeJxqHTfJcaAGAwiNGmHAyIG93nTi4M17?=
 =?us-ascii?Q?chuHx94qUr3WptT9RsbiMdKCt4TSDW37oTTqPlASCrNUOtoJ+XyodH+46Azb?=
 =?us-ascii?Q?Ov8iTeQm/UJhcKWgTxIVwgDXqEClUc0lFZofhqta4Kq/1NLhgCDE+7wO+vFI?=
 =?us-ascii?Q?oPDINJOZIH1cUv4421j+i2ED8Uivjl5GjMHbrdiD5HV6nmTgf5DXp1g5aae2?=
 =?us-ascii?Q?4xsBRr83En6JthEPROr2GhYMnuhAZ6TBIVjUjc4kRog4JWYSsQ/UGx1BI1Ut?=
 =?us-ascii?Q?H5YVPbLj2gV0T1tqrt6p4uGPBuZBtrrW/6N4qFs+iz8CRixaTkcF7AXD6JGB?=
 =?us-ascii?Q?D51l/iy9BSuGZPpXJqHFp/y0pvZBPrfdlgbjpHS04bPxPbXjLpb4f7nSa1gJ?=
 =?us-ascii?Q?ETxtOZ1URT3EHUN8Xg4sdoZBZTvpjG5AcTTgZQspkPnDSVFy0kW0xh9dJKp0?=
 =?us-ascii?Q?6+6ZyPurxlqh4xqZ4n1EEjrL4pmQi1L0wSm+1ClwJ/uB0Zarqy5vyv9PEsSk?=
 =?us-ascii?Q?aBQMF14UX9i73wZy8iMw41o1ZxS0fhtHW2jw3P4cYb+ieTxYu1ZyyHsWimjI?=
 =?us-ascii?Q?mXE5fue+9jWFevejIFmsV26q7dbdPsG8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dc8a9QNNG/t1Pzdey644wKxWKDZclDyzK8b18+BqdBk4apFDKRS+Ip/JH0eM?=
 =?us-ascii?Q?7N0tcb+cthu012vZNLJgUgx6RjtZG5Pajz2zJfDVDs3NYUe0WGS/jDaz6O5x?=
 =?us-ascii?Q?Ds1rKbvdlQ9JSy+u8prVungpGtNqauDDPBl/oUrmauZVjannyqjKV2T6tqMJ?=
 =?us-ascii?Q?lgItCkz0p52/+7U/oXuVwsGYBN2Aqcf5nf97wmE3ebu1o+tQcau50MwJbnOn?=
 =?us-ascii?Q?XOP1y+uFXByuzDqorn8H2C8rE8nCMdE6EHMDo6sZRvSc3lgXmIZdCHylWYOb?=
 =?us-ascii?Q?x4oWx+h6RhMjPT0hGjDpPVSTeEoRINTL3GnTOidGGB8wdGsLyqlsj7YBW0Ch?=
 =?us-ascii?Q?INYFEoW926j0WZyIn78oymnMCthA4hijefxiKIY0ASevKhtKnrVeRKD0SeVz?=
 =?us-ascii?Q?s3LSXMms+po/EPg8jeEyc7uv2iz9BtuzyCCJWtbMmf8WOyq0+Be4juFzcrOS?=
 =?us-ascii?Q?tJo8hYR36hN4wDF5dYhwoJFptM7EUjmyHLCnNMv8VJaFVdb0TIwpiGo7+tQK?=
 =?us-ascii?Q?hGtUM8aInKMSbEZoKeWZ745v3llLGSL4DvdeebYf96r8Icyn1R92ov0x2oRy?=
 =?us-ascii?Q?P25M2Ch8Ji0UPMW8HIUNMNmD3Kg7QDhoJZvyAgwpkCltff52Sky6ic7vSisq?=
 =?us-ascii?Q?iF6sKkuUggwsgTHWyq8keLcX0SOln3Zp4RKopD0N6wO4vdKz1C3YEkRtqV1s?=
 =?us-ascii?Q?auui1J3Pk3SNqa4ntDhwocPkEItJ0/YBo7LkzWnQ8bmEszOV2nQYLppjCRJX?=
 =?us-ascii?Q?xSDGQcHSxr4tUmLIIkewm3OiVWfZPdS2aOMRmMUDueNX7hcqAA6qHR4DMin9?=
 =?us-ascii?Q?Jh+W0NQeScMlgt10cQWWvgeuMtNYIu2lErZHTU7d+b2+D1kSqHhKw1C5bV0W?=
 =?us-ascii?Q?Ucg+B9cceAqTV3x+ngsB1Zh5AL6i5nZ+dEmbpywUH4Rt2l5pxwxVXnqO5CW+?=
 =?us-ascii?Q?4+y3DLnscorZClailq9sQmdfXxOGamGvTzhnBLIe9wQBPpMRtTz4d4iDVAlk?=
 =?us-ascii?Q?A16J+sBsO+JbHA3ftklyGGTnEnpJgPtU02w6+zImI02LOmVP+dHVRaVQ8mNY?=
 =?us-ascii?Q?kUkvOtOEkS3J69x00zHAax6kN5vMNbPnvAPH07BAENN87nrVyL60uNjZfsuj?=
 =?us-ascii?Q?m7LN3b0H7mW7Fcpnf/E1S2BTDURshVG7DZkeRur6jVwfZto/nqBCJ1BVjkjq?=
 =?us-ascii?Q?fiuCikHGRLr+20hXofi5aZNy9U7QzhCI8Nn+WOyC6P07D7hwegI3wPGHL1N7?=
 =?us-ascii?Q?dgVnYF2XfKWb2GCOpqub9yUnX+jPgzCApyKs3QSt5Gqs0oYVQfdQMg1dgHPU?=
 =?us-ascii?Q?Mrkf+MQmttm/ig8lwqbgBPj6NfIFboTYnqrjQHTBjCSN+LzUl6Wn1oPLv2ZL?=
 =?us-ascii?Q?2ug8G2gOgahHomnlCGvgue0a+hWVas/7Mb91ckgfSi0r6gEWkPXCJwGgjhQh?=
 =?us-ascii?Q?OgHntEOfL14P8Yfzj37+5BphEY5vB6e/QecPpqdrTePNoAzK7Nd8hffDJx5S?=
 =?us-ascii?Q?K5Lp/vJBSnvbpTE4LX36svqLaMzgafGcStxCi/dBIbn54wBUeQBfmvcNykyz?=
 =?us-ascii?Q?6EaGzUMqcRlwpr6j/1nHabgCkzZm5rd5/zi1XiSi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311e4e95-6c2f-4558-c929-08de1d53257d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:40:09.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ef4V8gNlSNLKWlwiyB+GUw01B6+AUkOYbM3XlQhwm1Q1+71kJCMiYvRDniPLMXwgdSW38/AI+tHDQxE8uTTTCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

On Thu, Nov 06, 2025 at 08:13:39AM +0100, Juri Lelli wrote:
> Hi,
> 
> On 29/10/25 20:08, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Currently the DL server interface for applying parameters checks
> > CFS-internals to identify if the server is active. This is error-prone
> > and makes it difficult when adding new servers in the future.
> > 
> > Fix it, by using dl_server_active() which is also used by the DL server
> > code to determine if the DL server was started.
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/debug.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index 6cf9be6eea49a..e71f6618c1a6a 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  		return err;
> >  
> >  	scoped_guard (rq_lock_irqsave, rq) {
> > +		bool is_active;
> > +
> >  		runtime  = rq->fair_server.dl_runtime;
> >  		period = rq->fair_server.dl_period;
> >  
> > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			return  -EINVAL;
> >  		}
> >  
> > -		update_rq_clock(rq);
> > -		dl_server_stop(&rq->fair_server);
> > +		is_active = dl_server_active(&rq->fair_server);
> > +		if (is_active) {
> > +			update_rq_clock(rq);
> > +			dl_server_stop(&rq->fair_server);
> > +		}
> >  
> >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> >  
> > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> >  					cpu_of(rq));
> >  
> > -		if (rq->cfs.h_nr_queued)
> > +		if (is_active)
> >  			dl_server_start(&rq->fair_server);
> 
> Something that I noticed while reviewing this series is that we still
> start back a server even if the user put its runtime to zero (disabling
> it) and I don't think we want to do that. It's not of course related to
> this change or this series per-se, but something we probably want to fix
> independently.

Should we just call dl_server_remove_params() when runtime is zero?

Thanks,
-Andrea

