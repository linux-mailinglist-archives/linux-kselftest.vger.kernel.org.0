Return-Path: <linux-kselftest+bounces-7172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B31898533
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461941F25D16
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC067F7C8;
	Thu,  4 Apr 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GzevARI7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874F78B63;
	Thu,  4 Apr 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227182; cv=fail; b=vFSqmyxSejv63Ykxava/DYpUhMkkWU2fTSMr5ydnoQt5SqMror81Tu2C7NhVlw0eS+7FHtCOSM4BfbdLbvunvaY2XWohx8BQv273Oj6Rz6eUrXS+eVVIeaej9WqN8eLDqvLU3/DZ2RYl5RoiKxSk2Wa34pgu6qDZBfaDhOARK44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227182; c=relaxed/simple;
	bh=+XcOcfzbvbVB19EMZcCf+IOCkKm7J/8qOOnDQvkvaHk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qK3afw4xrYWDy7TRMSwedYwFst8Ndyv0CvBDkSowMptHYsnHO7Pu92nIoTgvOzHP9MrR4tibrKW/oTiTIw5f0oMUACTkGEK07W8T4XbLzSf3ZTGR5wh393vphptmc0n85xKvCsKd3o3Rhi0i6+BRAMWy/1s9f1OyHDx8hk8flwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GzevARI7; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuPI2iv3+4gjTHBi4UrajG4xKOtXyyFTLnXe0R+nvG2emqi5jtiSNKYWo1qDYNEZW56q0MfKyA/8Y9fu+b1tGHZG4wLxiin4gnIs8K+gkXwx4pHCmoTIKqrwekmHRR3Sww9jykBSRMkFAHCIz3LQyo2vhcSlf4bJRLlqOocbs8F6Df8fspQsntuNVkeVYq4d2oPc8lljtU/Y1RvTi5AewP00u1IPTUDe8jQzKFhNgpvgXesBHI/lwT8dtoasKMtfDKKzYPdqvIs+bR1wQUiC5UAbDgk40RgqZqTDLvXHlCYTC0whxSHy+M0nk+ONGHxmIne3S4VfoprM6dAyQxIOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B6h9uKox5YyWetyXGdRDaDpj0sKdzIjQ/TsWQFuo7s=;
 b=HUuJam6ciG/IWyd4CdJcf7phDbW+YxkVoBLlsVpT9tIdgtQKp08SvUNawOVvlxb7voJd4p2eTJwvNcVtz4csQIHEw/YXqDC34BbMuN9GqtRHg1No4+iQ/+tY7p0dEqh0Kg6+9ENZVZlwLvDPFHSHBAeApF2CXJSvXhOg0xjJt470hDlP0fzA0ctIdll0/5xvUigtH8Q/6dU1CvsnFBSiZPXxZ/Y62lrho1WqSe6wTbXB76FWaH39PHEiYys1gXgc9+MUxCSNK73Yxlhz6HD2m5IFBO8vrPBz/OiuX6HqOtv7rA6lI27zvKjSqe2evnsMUrJvAQdQXk3/GANOQFvcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B6h9uKox5YyWetyXGdRDaDpj0sKdzIjQ/TsWQFuo7s=;
 b=GzevARI7PytvwUWBLX5SMIAu8bEWJE+PXtwMXG2qFBNEIEehlIqOCW7HUZ7chspherZP7R2g/cWqTb/CtI1Gw5YSh9TA1I0a5XRAuGAfjJyWTWH3pPzqoHl5XT+FAXEiv/sDbOvPQeGDI5+k/dLSPMVxbj43lXxfTjLMXAOvRjtKlOB7+Keq6WJZMpIWzSc2g+6a22tqA1Yqm7d3WikPXsN2pcUZtyOPOovVB6Z6DGeVZO3kI7JCI5VF/esad6ZSr3oLT82nZaHoPTNQTcRwnoIEdUMwjVdJyNHrTzxercGkXj5EXu9sl95n9SCTvgKXk9Wa9Ux0y+zsDruKD4Vreg==
Received: from MN2PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:c0::27)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:39:35 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::ea) by MN2PR05CA0014.outlook.office365.com
 (2603:10b6:208:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 10:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 10:39:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 03:39:29 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 03:39:24 -0700
References: <20240403023426.1762996-1-kuba@kernel.org>
 <20240403023426.1762996-4-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 3/7] selftests: net: add scaffolding for
 Netlink tests in Python
Date: Thu, 4 Apr 2024 11:11:57 +0200
In-Reply-To: <20240403023426.1762996-4-kuba@kernel.org>
Message-ID: <87cyr5h0o6.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eccc805-8509-43e0-6216-08dc5493850e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pjnp7KcUuatKugb8kbd5fFTkXVSg+FKsrTT8CTKlCemEQkspuwXVgD+7Wusq8hWNn1EyU7cajUqvDeB8JhMvbUyvf5gw6iplmcfkH2T+jwBauO0bprOnHA63XgDdEt9cNq+otbpBK2nOb/6C9rYwN9ERl0HDFkMVJpV8qR+hJONLyPNzMtUyzQQ9Xrl5RixfTkhTES2RYH5Mhrc9Z7lxqIAHPOxOcLl2mCEO5haPXr1PHCw23/VDpIynOen1NznuqzIZLfl7ck7hk0ZetO71w3zRY7YFjkAIAb9ye/FuAoE0rRw36I1nNMt1nvrWKRpUO5Nq3ztQ3Om6wNrNueoARZQGFPiFih46aLt+dWN1M7LhaLTnt1r4MEh8MJjd+zwVJT7KuefLNVddmz8stXpiC2eVIy3vDM5IAHbzfDo8gdPngznv2IcfNyxOP63c8/e5QSVcf6htrGrrT1MDI5ail+2iLnRSKV/5I1RkhiJp6aDZuTcH5C2QFCgOjgmuo8f1OG4DyOB24h5ti/V4hH++ubyVR4iSH+MUCsRnLmQdd2OI63a1F9zNYgpL9nHCPDVXaw3aiUl7TFBpj4HiFg9b19F1/oD1H9ebwW3z2RLqtGI64KiSXdXR2pFwbWh09rSFskKxnzx13tzz5qHx6ciU4Xhw0Otx9Gnp07K/zXWP2FIzq38OxdzRy0V5dk2rAoYM7L+j3Y6D/oJtvTXyMZC1a3W8+gqpDWDv4Cpa0W1xZC42xn3Ko0HZfqmQOZ1+oXvP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:39:34.6818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eccc805-8509-43e0-6216-08dc5493850e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109


Jakub Kicinski <kuba@kernel.org> writes:

> Add glue code for accessing the YNL library which lives under
> tools/net and YAML spec files from under Documentation/.
> Automatically figure out if tests are run in tree or not.
> Since we'll want to use this library both from net and
> drivers/net test targets make the library a target as well,
> and automatically include it when net or drivers/net are
> included. Making net/lib a target ensures that we end up
> with only one copy of it, and saves us some path guessing.
>
> Add a tiny bit of formatting support to be able to output KTAP
> from the start.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - include the net/lib only in install
>  - support passing state to tests
>  - don't apply Path() on what's already a Path()
>  - fix spacing in Makefile's filter()
>  - sort imports
>
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/Makefile              |  9 +-
>  tools/testing/selftests/net/lib/Makefile      |  8 ++
>  .../testing/selftests/net/lib/py/__init__.py  |  6 ++
>  tools/testing/selftests/net/lib/py/consts.py  |  9 ++
>  tools/testing/selftests/net/lib/py/ksft.py    | 96 +++++++++++++++++++
>  tools/testing/selftests/net/lib/py/utils.py   | 47 +++++++++
>  tools/testing/selftests/net/lib/py/ynl.py     | 49 ++++++++++
>  7 files changed, 223 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/lib/Makefile
>  create mode 100644 tools/testing/selftests/net/lib/py/__init__.py
>  create mode 100644 tools/testing/selftests/net/lib/py/consts.py
>  create mode 100644 tools/testing/selftests/net/lib/py/ksft.py
>  create mode 100644 tools/testing/selftests/net/lib/py/utils.py
>  create mode 100644 tools/testing/selftests/net/lib/py/ynl.py
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index e1504833654d..f533eb7054fe 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -116,6 +116,13 @@ TARGETS += zram
>  TARGETS_HOTPLUG = cpu-hotplug
>  TARGETS_HOTPLUG += memory-hotplug
>  
> +# Networking tests want the net/lib target, include it automatically
> +ifneq ($(filter net,$(TARGETS)),)
> +ifeq ($(filter net/lib,$(TARGETS)),)
> +	INSTALL_DEP_TARGETS := net/lib
> +endif
> +endif
> +
>  # User can optionally provide a TARGETS skiplist.  By default we skip
>  # BPF since it has cutting edge build time dependencies which require
>  # more effort to install.
> @@ -245,7 +252,7 @@ ifdef INSTALL_PATH
>  	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
>  	rm -f $(TEST_LIST)
>  	@ret=1;	\
> -	for TARGET in $(TARGETS); do \
> +	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
>  		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
>  				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> new file mode 100644
> index 000000000000..5730682aeffb
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_FILES := ../../../../../Documentation/netlink/s*

Not sure I understand the motivation for the wildcard. Currently this
matches Documentation/netlink/specs. Do you expect everything that
starts with s to be a testfile?

> +TEST_FILES += ../../../../net/*

Likewise this -- it's just tools/net/ynl? Will everything that's there
be a testfile?

> +TEST_INCLUDES := $(wildcard py/*.py)
> +
> +include ../../lib.mk

Other than that it looks OK.

Reviewed-by: Petr Machata <petrm@nvidia.com>

