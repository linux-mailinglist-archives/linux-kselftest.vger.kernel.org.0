Return-Path: <linux-kselftest+bounces-45007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49EC3C3B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25AD54ECDA7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EB6346799;
	Thu,  6 Nov 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+GiE/jM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B11D343210;
	Thu,  6 Nov 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444797; cv=fail; b=oTRj7Wsj/6FMIRVoN2MbqRaN9xLe0w48xggFMtDiK5nCmXfxu4TuUd3tcTJ8aa2qXbH8usg3WzEghkWF64dD6iGivNKcNr3/TzIftmmWoRzhbbuTVI+QXVZRUnGS8MsPAoh/PWQjA7WAHAQOHvH9zs01aNRjSRRVzL1OdgM9em4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444797; c=relaxed/simple;
	bh=W160jdRgIqT0b8YxUu7UpjEGhpb6Hr1zexXBoOkvkKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QWpGGRY8Lf1rFnaXdWJugms7geJcfUtqolTAk/HEOmESMj2MVYFYCngyD8PDTpowvyyUQQmA7rlkN2MwwspXvW6hy+PcitZCKTHbZe+sO4YPLJt/ABGM/l8KgqdpcxfFTEb8Rs35axQ6dYOk8poQOfsXJfomIK4jE/KwP3PGKQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+GiE/jM; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdfkAX61atwxYPfqNx1Npkfhl7byCevvf8PE4hR4uZXIpZPkd342wyjlGdjYuVgVspQIQcM8ZeU9/X+1Nl7Q4zq9zPCe0nd4bF0r5BPy4Jee3jfSqlZ3nsQOv7kjPOu303ZNcgJICAgGke0khOrtj3eVuKooXRiLkInY1RrxbBhMZhNPE0W04EQfkHpvuX8reYJ+qksNLt3C1f5PKB234VkxIWh8Eu97psendqIzH+WaBMHnKIggrFiicGTJlqttI073pRtfV5WWBFrzmRUY/rXrYHnZHRZDm0y9Hn6fKJVkJW6B8MfeCANxAsm3PQUAjiafRMBGJqG+x24ncSFgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg69QKx7lRwARxxDSLC8xGQfma654ZBWmuVPBwiPdSI=;
 b=DvP705IqFKotCfRJ8Sy0/NnCb5jNOAcQExLv09i/6rDX05nBfAXxnbjp4YQ+4Vr5LFS4fbubOAxrjBHElMLlU7JkApPI6hQ4LJWoBH1BQbg1vm98Ad2Y0lxO9BEWgPfWrUxS+cJmJw9BR1uWVZmerV1E38hS8Sod5MBoqc2aDT1l7bkJtLdqiDu2AwhCTODON68paX0kYF0yWi3j3zUrYVEuLLixnfgBrtc5HZDJfDAbSrPBh9QPgvtwfQUxQ2Kb0GWsNRnrCNUpcwT8wrIMvCRq145GNKfYlWvVoy3eO2QvU/VKOoQJ5JGuBztTUJu9iiD1pYXqaCR12KEaPWyXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg69QKx7lRwARxxDSLC8xGQfma654ZBWmuVPBwiPdSI=;
 b=r+GiE/jMbd7o2jvylmU1L0pqNZRB5LUSStwWtKSJzEmZFSoZaJ5vm6hVLzzflVqNwJwzSGFSDiMlsnH1TVkpqjz7Uwp1kRbha1ROukhGesmFc8M3MHKLcHXrUgYgJR6J/25/HmPKjAddxl56jJMqTmuyRenV9GNLMOUy9g+TijMEagR9bN6/c/pUoDxqCe0yMfGRL7xJ03a0pk5Lb7ivojLM6loRv1Q9s8SzlJ8YWvtFSTUgLGUdVg237MqnZKE201ZHTH0cekVkzclAjMtm61bb+QLbWQ5zbcn1LO4Tp57NGGoYsXO1xZZVxwg6g4dgzN6RfAnZCMKARLAKiZieWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 15:59:53 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:59:52 +0000
Date: Thu, 6 Nov 2025 11:59:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 2/2] platform/chrome: cros_ec_chardev: Consume
 cros_ec_device via revocable
Message-ID: <20251106155951.GC1732817@nvidia.com>
References: <20251106152602.11814-1-tzungbi@kernel.org>
 <20251106152602.11814-3-tzungbi@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106152602.11814-3-tzungbi@kernel.org>
X-ClientProxiedBy: BN9PR03CA0891.namprd03.prod.outlook.com
 (2603:10b6:408:13c::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 359e2239-caa0-40df-c24c-08de1d4d8551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+aOzndZrhIth1Ky00kjOzPSVEHrHKsDCEIhBayA/pzJauwRP8VmMtofl0S9G?=
 =?us-ascii?Q?7rwVmGpBZe3hsZVEa5yoDhKZo4HDDNNJOg/nSRO6Mi5O2awdeu8q+CmYv7N+?=
 =?us-ascii?Q?oI7UuAQo9rI2du3ohr5Jbq4EkpgBt4JeFipW52TuEoCrAmHesvF7mae/Wg8O?=
 =?us-ascii?Q?+YLdp0pHz5DF+17mSK3qxFXnRqe1q2AWEbaY5spE4f49/XHrapp1U51AcU+7?=
 =?us-ascii?Q?w/Blw4Bw/ec0nUs3dgch8D0Q4PSnAV75x21pruBXvTfeoZXVdFZgqYt+FunH?=
 =?us-ascii?Q?KnYAwq7wbA06kEqyb9OYbMN7GYJSFvUlQPyN+DytYMJJqje8RV5TpPT6Uc/7?=
 =?us-ascii?Q?G5pCHd5Duqx9/WdeUmFH+yXj2t39GTtwipXiVOQyV1bU/C41PDvNheeNkjqd?=
 =?us-ascii?Q?P7oLN3M5pVBab7JFDSDc2sosWDf/p1dTmQ4E1pq7JAk5zzcAnn9xVFebKMjF?=
 =?us-ascii?Q?uTVUj/E5DREXKsxQI81SPNxiyV3Xb1fYlWeVLzNKnVZYkYw6CBAJMLaLeUql?=
 =?us-ascii?Q?VFz8f6qOUOwI5LbBPH4GzhZv4XRgk5fL/vA9TT6N3UyNEAKsdlldrmxgCBoS?=
 =?us-ascii?Q?+1kQWmvlun5gf3ikJjTYAC2+HMpmigXw6MuLFohxufCm2TDGSnOiWJUALxyy?=
 =?us-ascii?Q?cQwpESGXxXN3uFhFZCe2f4e5EQszXdJoYPcb6ASgyAk7rTawihgq6t4Ln8xt?=
 =?us-ascii?Q?62624K5jzXJvGGVio5hUcjSpNhvhbR9+gcbPr7pCGY6Oz85aUftQnuCI9LLp?=
 =?us-ascii?Q?S2zYM+lrebfpsqraZYdyVtXzP7Rf01XWEVzRgsEx/K7M2tMmfQp8tRQlHEkB?=
 =?us-ascii?Q?hXDNTE99DJguQvWUwprPK4FOwi4GONqHc/qRJ3C34FFh+8DuZ6j3qoxUFHxe?=
 =?us-ascii?Q?p+XDWdzkJgH1pRed5KmEdQUxireFFl0M85/93Trr+0Yo5Ka+HaIK/5Yw2V77?=
 =?us-ascii?Q?mQZ7OL3CWaiV3vrqd4k7qSmbsiLwa1DhdHaDieW8L51tWNyuxmk8npMQiChj?=
 =?us-ascii?Q?aE4LPBVAQPQ7Q9NBwSNNT0xt17c4OAC1kUOPe71X6dt0PO6COoBA7pdMuGm0?=
 =?us-ascii?Q?UXWRPBL0FZHfwVfhZp8vqz5ulKGXTm1n6nurlPodrZpa7CLPF3bM1VNvi6qZ?=
 =?us-ascii?Q?9Fr30CIftx27iKDiTls0xDKZWIglMCzxOHet0tYEI2HSjjXLn7jxfXhyJUkp?=
 =?us-ascii?Q?ae+N4uOrAa/40/IwOfDad4mJy1TOcEQDI2snVRk0m3mzlMWuKq87X2by6wri?=
 =?us-ascii?Q?8Ww61pePLculbRJsuIRfeD5V8K8uheo0qC9pPJjxQu0l1QkL9i2ZijhymEKP?=
 =?us-ascii?Q?QeHSk1JqzzzS1PbIfQLha/k+qi3GMzHYxcyO3CszmOMbYl/FJayCx6ORAwga?=
 =?us-ascii?Q?bksVe4J+Go1PfN2BNG20O/nCs2sB6+YNE3GoKkZxxE0tkMnx0efNmXQsC45R?=
 =?us-ascii?Q?y2hSnc9CTZyHmTltw0EAs9QF2jNtz0Tm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JAcaSMhGs4rNCntVOTjpyVh/BJf5PCaR9a9G2XjD78Xw6GG+H8Yh5wIZfJ3i?=
 =?us-ascii?Q?zoJPD5z5gGwBT+vMjkTokYcK0QqhV9p7hT4bKMTnFVThjGBeYCnZuH8ouLQS?=
 =?us-ascii?Q?flHUHtURxcZKlwZifQVd7HD9l2VoPBb2Jze7duk00cveCK2bLZraQ1ffm9FK?=
 =?us-ascii?Q?1H5kYBFd8+WD6hLmKF3wgV2yUse9WEtm6XtveDA4bOhbguYTqxPOYRhN4W+w?=
 =?us-ascii?Q?BCha1mmLQfiWX1lR0RhYy/EOILF+e7F/PAziftI/ytHvpHovYK7auqo1rzHf?=
 =?us-ascii?Q?9vQNXmGDWAqCwNRe/gx+HDebYBm2wbvFP2kn2cDIDBR/JLI81JrnHw2pu40o?=
 =?us-ascii?Q?arN8RbuO+zc/6xITa5kJF2ndqr7QQp4VKhrAYgxNWVeDPKLtMjx1+buZDP0k?=
 =?us-ascii?Q?8tuXuUY4o3hk+KliZgajG/fGlscZkW0x4FrzDUJR12dLv80t7By8IaoHSoI6?=
 =?us-ascii?Q?iwdJz7rsSCJY8MwU0GDEqHWZMii9qApIDMCIehDsXnWlD1usQRuMpn/YfbOi?=
 =?us-ascii?Q?Mx6Scl+NAuGR3INu8VYd66L4zZAxdLoDaYftX2/ULONTvA9+l3151hfA0Cck?=
 =?us-ascii?Q?qB5GIrWsiqC8ObeEIe+skAeQiWmvB5shz10Z5XzQFoW5GuvB+K2XGAkvgjMv?=
 =?us-ascii?Q?+EgodzlL0OZuDpncDrbWdUil3S8X8tOv4Vn/yRcNfC9G9Ca5GsznlXYosO8P?=
 =?us-ascii?Q?mITOPhrKu9rkrgma7/SfY66x4kHUxXTgoNsbFg+Xow4C4f6G1vCcQoQjcj7L?=
 =?us-ascii?Q?isVXMd+bHcx1iANX43qKEcmsgp35jyH8a/jjFD88fVGFkJPdGwNmFQzrgr7P?=
 =?us-ascii?Q?waC/o0ApXWKKdlHx44l0sZ43wXhAv5Uw45/Gc8hq9LJwZBqO3ule8eXaBVPU?=
 =?us-ascii?Q?rKyXFAkYFdjNQtg0YjNQRAkLoji2KtBq7JnjJXv7NKUO6+E8AtLxXY2aAzOQ?=
 =?us-ascii?Q?by++ori3Rt3mKIxGJESR55Jp7i+iPu3nEz3G+7whoW3uYoHlm8xE3WnQjvu6?=
 =?us-ascii?Q?pkcOHvnD3gUFed6KyBhXRvmY9T34YzZvAoxwApS/Bur5Z3iFt1XQpQdersiY?=
 =?us-ascii?Q?Sm9tOmFrEHA6o95QuVHBVmTHUGN3xFEAHyjW6OnRBJnU5Uner8zU7rcBwTTY?=
 =?us-ascii?Q?AzCYd8+uc3XPfOOwLS9Bm5D6RDcPvyjW/TO/SqKg1dd6tc7y32GcHUixPBOS?=
 =?us-ascii?Q?wzY9MvdB69fM3lZleN9VF53oIuxZGo8oNaX33zS+MpuqNqwtuvYcRYCUoY9E?=
 =?us-ascii?Q?+zJv54PzwjQdf7amE7LY1VRO6/70QPWLvryt6MGVD2DH8cxoVNPOtriy9DeU?=
 =?us-ascii?Q?kO8PuucCLXTB4R/w0nuSyZRmXEnVGgUaNX46PAWEKWLfd1yQE3Q2d5Jkp96l?=
 =?us-ascii?Q?tUCG1jx9r8z3R+iWYxAKDXAHzg6vSrhCJuGHnNUSehK7OVxYsOqYN4XqkE9h?=
 =?us-ascii?Q?o7TEJifHRQqx3nQmxsel3DbWF3eRcVXaSItssdymG5EhyJOJA7LpshL/ws8c?=
 =?us-ascii?Q?4xdcZ2Z6Xm8TIWxDkWfqnQJ9gGfx7Wj1eoC2pF5+Mw/MuBvfV7MEgyDy9L3s?=
 =?us-ascii?Q?6Yg7mhM+IdtEGB6gdN8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359e2239-caa0-40df-c24c-08de1d4d8551
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:59:52.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JmYybxQtaK0WfkL+ZV+mMGpxzfD3ZDyuXcVRJmNJkNtTYzY9uOIY9K6E2K8WWe2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

On Thu, Nov 06, 2025 at 11:26:02PM +0800, Tzung-Bi Shih wrote:
> @@ -166,7 +181,12 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->ec_dev = ec_dev;
> +	priv->ec_dev_rev = revocable_alloc(ec_dev->revocable_provider);
> +	if (!priv->ec_dev_rev) {
> +		ret = -ENOMEM;
> +		goto free_priv;
> +	}

The lifecyle of ec_dev->ec_dev->revocable_provider memory is
controlled by dev:

+       ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);

Under the lifecycle of some other driver.

The above only works because misc calls open under the misc_mtx so it
open has "sync" behavior during misc_unregister, and other rules
ensure that ec_dev is valid during the full lifecycle of this driver.

So, I think this cross-driver design an abusive use of the revocable
idea.

It should not be allocated by the parent driver, it should be fully
contained to this driver alone and used only to synchronize the
fops. This would make it clear that the ec_dev pointer must be valid
during the *entire* lifecycle of this driver.

What you have here by putting the providing in another driver is too
magic and obfuscates what the actual lifetime rules are while
providing a giant foot gun for someone to think that just because it
is marked revocable it is fully safe to touch revocable_provider at
any time.

Broadly I think embedding a revocable in the memory that it is trying
to protect is probably an anti-pattern as you must somehow already
have a valid pointer to thing to get the revocable in the first place.
This severely muddies the whole notion of when it can actually be
revoked nor not.

Jason

