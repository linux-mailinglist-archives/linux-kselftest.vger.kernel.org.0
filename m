Return-Path: <linux-kselftest+bounces-45019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3CC3CC14
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 18:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B458504B8B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD934DCC0;
	Thu,  6 Nov 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UP1ZNO+h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361234D4E4;
	Thu,  6 Nov 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448957; cv=fail; b=rIJtSU/rwzjlILWewK21DjuLZ92p/JjoyOFhNgXsnAeT5Btv/Oq2XUSrJkrKvzSjxZgTxAWamrdvNSK+JD7JqGavm3TVoMe+Z6oKORN6dXSL5QbqI7OKhSUwoXMcEhm3UIU9a1NkuNV1MSgWoKShRx7v7+g9XclD1Gemj9Yoce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448957; c=relaxed/simple;
	bh=ewwxdxoqatdUeU8YONMFq30EHqy6JNqQBsTMGAvZXZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dlRbhg1rj8PGRHRe51rOHAxsCOJqhGnJ/bZly5UZkdlcPNGTdTvsqCqTsHkLgF6jxCgfw7YhXTQdpP6gC7B6UDwz0/y5H9JcXof33d0JNQ2xfPdQe56jWjU7/PuYjX3wRWcpI04UEvdIcxMMROjjTT8yfKn8f9AKCc3bzjbJTFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UP1ZNO+h; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shvQL0eYE5XSuQM/3ob7+QcZqRR8J31sCgygZiS8iW4fCcDG9x+G/PGsdYYSnMzcYcv2cNACSIgFTuUuzrQIHvQ7d60o7qnU/O3U+xJvoCPM7rjiYa7N3IdXOz50sRsDpcUF8Ss80+Ob/NIIMx9aFXAEgbAdGGsUkSFvel3bKJI49z3G1R2S+6KtpaPqt0YrOAVKTP5b9pUyNBlCeVTG41kNsse1CycqEogAv3tm2Z5kI9BYUYO/MOuuSnUpmqjaberxKu3PhShW+FOGmnCKPMGAlE+MzCz2yv8xhS6BYZ9DCMq+7LBreraJZt2vpNY6LM71AfYskdQmQS2IKQbYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OZhTWwO4xAWVeD7O7pmtB3ZqU8N2brPeSGhzhjS9TU=;
 b=wSjKqXONIzf5ow7aH1KIoF2vq7ca0+Cp3IIYiPQC0kYA1CvNKSdntILJFPzysT/HKRg1PsMwBTaDJcJltWAawnwSZu7Q/zZB755soGxkm5OEJEmdNnGFxdGLSqqaW6oiR5HXr3fBSSZafeJyYuEMfKrnU+6AnOzMM8U95iIOCT3+R7Qdk9xpAmCZBuoiGQRznWR9TRrx1Z1ZD//NzfOoFxlfIexdXld9QcIj2Fk6+AO64Ae2TAqFPk5q3Bsk4M0E3zYLGgvGFJCPs0B4yLMsDqT2ZPTQFwzS0IglGSrqIQ6aOKf8Mq/Z4Y9jtEBLjjGHTLU84larpX5ZiFtAN4FTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OZhTWwO4xAWVeD7O7pmtB3ZqU8N2brPeSGhzhjS9TU=;
 b=UP1ZNO+h5DpoSlaRmGjyR1ifdvODlYRP+IABxMiapRgj4qpcy5FUpn7/JcjUOhToMl14CAjXSHw1hb36tQwllfb43tY7Bwrvdd+nHp4NWBXZxeBITjm9IDWQpUH55F/5FzAEu5vqCaNbZPwAUbEXCgNlkQfLNuXZI4//r/caGBQbYan9T/XDHsM3G2rmFN0pTCM1znhLsyr9crvPKGD7TY4tD5V6DUPYfoKWdZZ0b4ox3kFcVPX1IzAWsh9vpm3CO6K4bjOZVLIb/iQDHwlbqm5OjHe+eDozEcuQK53IXCv+l+ak5dmyeiSoK0PsTCglB0k1uWQGMpQLFB2+rV1GVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:09:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 17:09:10 +0000
Date: Thu, 6 Nov 2025 18:09:07 +0100
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
Subject: Re: [PATCH 04/11] sched/deadline: Add support to initialize and
 remove dl_server bandwidth
Message-ID: <aQzWM4vv30etfhok@gpd4>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-5-arighi@nvidia.com>
 <aQxvIBIwOCDDu60b@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQxvIBIwOCDDu60b@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f2acbd-24c5-43a9-19af-08de1d573404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BjBQX8EDTLRUgt06ZepC8d3dKczOw6AMZT2efz09G9dqdled3Wj/B6GzqCWd?=
 =?us-ascii?Q?NYweJYfHSrqMXtozB6HrnPaCzieSJqRNZNf3842ALAqiY+xc7mqtWVmVWK6q?=
 =?us-ascii?Q?zaf5fQAX6nLaTBsLb/PqMcR++AB45zMWmxdyP0iQWMKDbPBQrjrrPAU35u1f?=
 =?us-ascii?Q?Y9Bnr+yv7f91NrILuUdomQan/1I69gyYKchAFvWh8LA+XifV+gkhckodiLEw?=
 =?us-ascii?Q?YCn4qnJ8SnZpoTz3l8VFKA6tmpEdK900agypUSi4/7f6oQzy70tqn8WGug0D?=
 =?us-ascii?Q?UIgO6ag5jSkklmUT1BzwdsoB6gue25ln6SCXGj39yDW0g535zqXzuKswd7z/?=
 =?us-ascii?Q?/DSVQxjuWzKJoNreF+PgtyAJtL+WP1KY+PlRW0nBCHbfkytVbDZKNtAJvcP1?=
 =?us-ascii?Q?k4b1o3vn3rSG8+EHzKQikPyBDz6IG3+qR7W5hFHPelXPMyh9qQYEXzgRS/sc?=
 =?us-ascii?Q?R64bFhbw18nam+Y4DtL+mdXQhn4/RA1u+SPsK896/nMnvsRH4RpsGBRW5/Nl?=
 =?us-ascii?Q?r0+keH529s0HQ+4iSpnRR26Is9tThN9HJMcj31yHqvMfWs+QopKe9n1KfRXY?=
 =?us-ascii?Q?dDBy4TESfsvyqltkbK1qOiSkGYQPKvgY8HZhJ5/WRXgiaWF9VUoIPwfteRo0?=
 =?us-ascii?Q?t8DHqoc9CXsHNVBMteD8P8h6Zjhx8Aae8sMhFmv8ggYxK93O63AMCpyZObmS?=
 =?us-ascii?Q?PjPvn9aq5PGzrH9vDFehCF4z+/cFrm1oR0oYriD6lSvwuPsgvbIRakreQc+9?=
 =?us-ascii?Q?T6sz5XkTpa3vpcX9jPqFa78A1/YyW/tx083cMlkD37+qGMYDjsl4oZzpJe9j?=
 =?us-ascii?Q?KC/KHnxNzlDWqaT6+JwXcrVeCGu4+F/k41Gvn5p6XvN3yRNfSKUjA0ra+l7k?=
 =?us-ascii?Q?nDCbOo+qirH9OQ5fTbSMCx2QRO0WQWT+uP3ZyM4e23NTKTtqFGy0Km2Bv5AI?=
 =?us-ascii?Q?nSET8sMggfJGtBuefhi7F0PGLguRJSJVF+YW99xYM0NdZ0CSHMWe7LPbiJwZ?=
 =?us-ascii?Q?7DhQPYyVdldKH0es3YQx8haizmZQM2rOxqPlGI8zs3u6QqZEw3IBAx7Qg2YE?=
 =?us-ascii?Q?cILfegy2mSEEpe+6sZD7oWNj0+LNFB5JoShg1pD3Tq7cCp2pMSoNKDmnBBlR?=
 =?us-ascii?Q?ZWy9XSf2FikZ/nqZzogzsoTASNJL3YyXnbscSlF+LNsTZKDZxMwuuCOo5JBH?=
 =?us-ascii?Q?OuWo8PwzAo/uOZNhm1es0/DM09/+WJOC6c0Higqywyw6hQYu4PW6nhKmE6xo?=
 =?us-ascii?Q?ZeazkvRifMCChsjbv6wnPUoC8xz5Lht0ZuwTERNGgPGTP2z5b/AmecGPYB4U?=
 =?us-ascii?Q?LNw7BX9oiNFn4/5dZIP+Zb/YsV3vh/GLwV3Mfc/xiWasF7KgRKlpVi7JPWcI?=
 =?us-ascii?Q?SFtm8dPe/c8iCLcg8kWQsemFHtj0vepW4fX8vnc8z7d3CCNn9uixztNxNvUw?=
 =?us-ascii?Q?sqBGUuXHXwNljEhAc8mz95E+g2uUO5VB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/wpb/P98Oawh5rJ007yrhtiAsCtycgFwZF/nTiatTaOsCWzstEPHJS9CgFM?=
 =?us-ascii?Q?kzLBMyR26pHcvJxxSraTyYLzfQi67Qjk0sOoYriAEF1LL6lpFqIPm4rYoSRB?=
 =?us-ascii?Q?isczMTtJARkp30IzXhTWsRz+TTyheLkfRlRcJKQlWOUgJ9zyqasXjftA1P0b?=
 =?us-ascii?Q?jtjw5JLexZ6cHxw8wRyrLsL0n37jKxUcsijTD8wC94+XO3wM8dbKd3pBCo2b?=
 =?us-ascii?Q?h+yC4PwcVWnKOfoD0hdn7qtn0C9ReMd5MBasqf1IuGL6ZhCvB69Cc3HsH+zo?=
 =?us-ascii?Q?GEBlBLtAwZZmizIMgsI857+3rQ2jvqcXZ0zLaz+Ap6X17e4yDMSoxR78kpGZ?=
 =?us-ascii?Q?SLbKcXn0Bx7/u0OUQpD4+CPmZ+R5k95afIG1c7aDlhnxiXaXlmVcLQeMh03A?=
 =?us-ascii?Q?GI/tdypTB8dpLaBzYj0E1MuVT+1cOcMMHVNzUhHv/QhBQf2lhyYpmyKX4yxR?=
 =?us-ascii?Q?0gOWf6N1R24cgQ2z3S/Cbn2tRevssDtea5jhP9hqPiuLE/z1v/DvaaApVI04?=
 =?us-ascii?Q?5MnQeyr973jdON5OVanVjYqmI7oA+HWs98RhkdmMWEwXXj8WBdgrtSl/OgOa?=
 =?us-ascii?Q?4blmawyKS/5Xh0HwgEm5Gc5QoAb7AqWcbje9BOtvYD1Dlu5a32LrGkXUCQiH?=
 =?us-ascii?Q?Pe765ObETdaadNacCjYjFf7yn3p+YDdPWds/D8mwJjrZLbjrooYEgzg7baOT?=
 =?us-ascii?Q?4PUdWl2UHp4QR4pXsvyOgK9lf3chFls9eWzGej8lMcAgt+En/cNnEXOhHh7R?=
 =?us-ascii?Q?atJIsbUUzM9dYVtPslFRpmcprL4s6xXdwy5UNbLteODxt+FgW/RaZnnXG0ty?=
 =?us-ascii?Q?ruQ7lnkjXno2zdxaRd+2WlC/64tauPiP9vgDEMPd2zEHtj6YTz0lGTKahfrv?=
 =?us-ascii?Q?ke/KUr4aDStNBKx39YgET4IbUtBHn0GZF/xh/bB7IQOA+X4VRUidqpl4EtZG?=
 =?us-ascii?Q?i39PVCWs42do55ukzMuPgoPI/yxefJJdUepFhRhpoCGU5Cw2oewM4Nabi5By?=
 =?us-ascii?Q?H/IKojad0xAgLAG6LixA03wlBHAdPw2af+7koQztf14KVH6zEU5s9CKjA73L?=
 =?us-ascii?Q?bmBgXuX8RkiVbksjiP5sUBE+bXOBUws/fTmmKUfRRXL24XK5FwAsgNPy7HAP?=
 =?us-ascii?Q?ypoJ3KJP9zTSO2zolSrCeaJgSj8cVfAimJ/UEosli7obev+SOznGdNS4pH2Y?=
 =?us-ascii?Q?piUVBxjPKwC4oEDlmwOpGKYLGpsK20JuNVh6Ck9tF3UfxQWKXIqexS9atM6l?=
 =?us-ascii?Q?s44Tvc2Cxw3FfYUVEIpLvTSQTyS8RrTtjHEQCUMvpUtihXYpjt3K3S5NXumu?=
 =?us-ascii?Q?xb4e9p8CsnUCqj1gFF+MXC158mm1nuhGc2UDMqj5FdK6drU0oDn00c98vgSk?=
 =?us-ascii?Q?p0IamwEA9LkCiZqtoUS6wSX+vwBZ55B+D5dbfIZQaTMYLdluWb5ZYo9IjqII?=
 =?us-ascii?Q?UUryDxHba+ovQL3ZNgx0SvqjJmn0YnUtzdPzQSmvtDOXc455W67wJBnp4OYd?=
 =?us-ascii?Q?3dx0pSlo1t8MaM+YrsI5tLkFS3PGBdajhWshS5BoRpxY5T9pD41RZ4QVi+0I?=
 =?us-ascii?Q?r81+eqIiMx3Bpg5FSwqvt38wGZC0K7NiEG3zzmOW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f2acbd-24c5-43a9-19af-08de1d573404
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:09:10.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqkpWRs+fsHcxbUteoG5rO5iXKoH4x/II7Wm4m+VBmnLtu8XxNXcDG5j5hO/0K7QwnWDnx4kuhbVDUWpEr6NpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

On Thu, Nov 06, 2025 at 10:49:20AM +0100, Juri Lelli wrote:
> Hi,
> 
> On 29/10/25 20:08, Andrea Righi wrote:
> > During switching from sched_ext to fair tasks and vice-versa, we need
> > support for intializing and removing the bandwidth contribution of
> > either DL server.
> 
> My first and more general/design question is do we strictly need this
> automagic bandwidth management. We seem to agree [1] that we want to
> move towards explicit dl-server(s) and tasks bandwidth handling, so we
> might want to consider leaving the burden completely to whomever might
> be configuring the system.

I think we decided to take this approach because, once a sched_ext
scheduler is loaded and all tasks are moved to the ext class, the fair
class becomes "empty", but the fair dl-server would still keep its
bandwidth reserved, so somehow we need to release that reservation,
right?

> 
> > Add support for handling these transitions.
> 
> Anyway, if we still want to do this :) ...
> 
> > Moreover, remove references specific to the fair server, in preparation
> > for adding the ext server.
> > 
> > v2: - wait for inactive_task_timer to fire before removing the bandwidth
> >       reservation (Juri Lelli)
> >     - add WARN_ON_ONCE(!cpus) sanity check in dl_server_apply_params()
> >       (Andrea Righi)
> > 
> > Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> ...
> 
> > +/**
> > + * dl_server_remove_params - Remove bandwidth reservation for a DL server
> > + * @dl_se: The DL server entity to remove bandwidth for
> > + *
> > + * This function removes the bandwidth reservation for a DL server entity,
> > + * cleaning up all bandwidth accounting and server state.
> > + *
> > + * Returns: 0 on success, negative error code on failure
> > + */
> > +int dl_server_remove_params(struct sched_dl_entity *dl_se,
> > +			    struct rq *rq, struct rq_flags *rf)
> > +{
> > +	if (!dl_se->dl_server)
> > +		return 0; /* Already disabled */
> > +
> > +	/*
> > +	 * First dequeue if still queued. It should not be queued since
> > +	 * we call this only after the last dl_server_stop().
> > +	 */
> > +	if (WARN_ON_ONCE(on_dl_rq(dl_se)))
> > +		dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
> > +
> > +	if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == -1) {
> > +		rq_unlock_irqrestore(rq, rf);
> 
> This seems racy. I fear the moment we release the rq lock something can
> slip in and the server(s) state might change?

Yeah, however, sched_ext is the only user of dl_server_remove_params() (at
least for now), this is called when an scx scheduler is started/stopped and
concurrent starts/stops can't happen, so maybe we're safe...? And in that
case it'd be helpful to document this scenario clearly, unless we want to
rethink this part and avoid cancelling the timer.

> 
> > +
> > +		hrtimer_cancel(&dl_se->inactive_timer);
> 
> I am not sure we actually need to force cancel the timer (but still
> contradicting myself every time I go back at staring at code :). The way
> I believe this should work 'in theory' is
> 
>  - we remove a server (either automagic or user sets runtime to 0 -
>    which is probably to fix/look at in current implementation as well
>    btw)
>  - current bandwidth is retained and only freed (and server reset) at
>    0-lag (when inactive_timer fires)
>  - if server is activated back before 0-lag it will use it's current
>    parameters
>  - after 0-lag it's a new instance with new parameters

Hm... that means just setting the runtime to 0 IIUC. I think I tried that
approach in the past, but I was seeing some inconsistencies with the
total_bw kselftest, starting/stopping an scx scheduler multiple times
seemed to gradually consume all the available bandwidth.

But I can give it another try, maybe that behavior was caused by other
issues, since we've fixed quite a few things since then.

> 
> In inactive_timer() we have this behavior for simple tasks, but we skip
> __dl_sub() etc for servers (since we clear it up immediately).
> 
> In all this I essentially fear that if we clear parameters immediately
> one could be able to trick the system by quickly disabling/enabling a
> dl-server to let fair/scx tasks execute more than what requested (as
> each new enable will be seen as a new instance). But, again, I wasn't
> yet able to demonstrate this and I am still uncomfortably uncertain.
> Please Peter and others keep me honest.
> 
> Also, server parameters changes are root only, so maybe not a big deal?
> For scx automagic as well?

Only root can start/stop scx schedulers, or better whoever has the CAP_BPF
or CAP_SYS_ADMIN capabilities. There's also some natural throttling in the
rate of scx restarts you can do, due to the overhead of switching to scx
bypass mode, re-enqueue all the tasks, and so on.

Maybe we could even explicitly throttle the rate of scx restarts if it
raises concerns from a security or stability standpoint.

Thanks,
-Andrea

