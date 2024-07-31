Return-Path: <linux-kselftest+bounces-14549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD0D942F71
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 14:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4891C23B06
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D521B3F32;
	Wed, 31 Jul 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZAru8Je"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62B1AD9C3;
	Wed, 31 Jul 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430431; cv=fail; b=NBdLxnMc8ZYE8hw8DzF3xaRUgnlwXMImUBl2DZZUhTkNihnXoukXnhVhDsu+gFmtZ06BS39BXo6Qbejb0q6+tEKfVKU5rdndQkOFxsgnKLUVWRk8jIbdYKrzGmXFEr5fWL2aMfJPksZlRUxoViiuCQOXPjkwthuPepU0e+uj/uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430431; c=relaxed/simple;
	bh=Z2J7lZTMKD2Cq0ETM21qGGHl+ZB/IIUWFotKvNrohSQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AnxHs59LY6cnBVEXHpQEJi+jW/yhHkvFUBcx7A/BoyN859Wh6dRiasUO4NDk67IIRxCCgsQIUKF5d+lKbykpCNnU+j4rGCoA30AzuWxBZl091e+9m2uhh1r8Cl7OBaJz9Dfxq5v+Lvtn8sQWTrZdTEIF/PIplpMd0JJ3WHnQcfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SZAru8Je; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFQ4hv2+2OYqNhTJ+Nyhq0sgQ/aSzQT8YkuG/KcGcqIBvUlhBh+3TLgdVkRGIm6Gy/3fK5h2Nlx8nFYZ+CAp67rEnRz4VNMMnLZtIQcfG86Tr+dFJ6mnGJ58+vOXB9Sfe4ej5+Y7K1CyzoRASeUH6qfxKQeOEBWPSdX1603/YaniO0vW5HYQ2GJISJKHfIPgkVxeoUOeE+F05VlaFC/17HPUEA0mBIOlf9HgTzYGMoF5KmhzzvuFhx2RRVM/nTWhRrLyX55JlggNVtOQ0hbAFl/SdxR1o4H5A8ebGQq3Lm3CymMcDh3YjKBAQEF1wupZkJOugM49zP5SKnAH+3o3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHM3p60sZqBa6CXkydt20imXxmgcU9z0lgFL0SfmenM=;
 b=JBv8XkdgPPQx3+1dUpHFT9EMafVL37rsMzgcdVTbXcw/bfZHY4wZ+8n3cvqEwXnx+/07/n6rh6RPd/mlxmDR5XVQr7Zc/r40y5rUuUm8rkPA2GDFeY5pW+eAZZzvGqbkI4PEv1PtXnnDb7QPAJyPmSkqlrtD2BYjWQIveG94tsCK2vCNBLS3DibzwSWrdZ1zuppu9dNgszT8dkCwd7GSr5ouIs3iuv3Z2I6+NGXs2cjRXHJeaa3w5hqnv2EvHHzjw4rk6rHpAF/jxNsQwi2QT6HlMco2LcBI2kh1dqaadUSf1nhpu1O1zmNIEnvMhh8lZwkUgEgl+uCTpqPSRyvsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHM3p60sZqBa6CXkydt20imXxmgcU9z0lgFL0SfmenM=;
 b=SZAru8Je1YGILqm4QuctyDNqTjbsmij/jecJ3G2AmvkvbZrQMxzOIw0KJvMR62UqQ6edl5bky8bJ0QpxurzkKJWklGIJVd4nnuIw3e5cHSwCH4Qnwx50XHmpK8ahrYm7myR5Zk6US0mVacngRa9mRgqKHZnVrBVV6vl4pVhDlzhkrySizhG8bwepP9D1cVT3bTdUyAGQyKX2DTrfpjvPfgS8+NW8rjJj9nF1uftT81M8pE6OBBL4QN9yc79Ho9NMkT8876UeVQ6TCDSACt7dvaQo9AAucPHqgeO+1WU1Rj8BsnUdXMq17AQ84JTtBIbE2nUy14TpGTKVdeduu0jb+Q==
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 12:53:46 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::68) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 12:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 12:53:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 05:53:33 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 05:53:28 -0700
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <20240730223932.3432862-2-sdf@fomichev.me>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Stanislav Fomichev <sdf@fomichev.me>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "Joe
 Damato" <jdamato@fastly.com>, Petr Machata <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: ksft: support marking
 tests as disruptive
Date: Wed, 31 Jul 2024 13:55:13 +0200
In-Reply-To: <20240730223932.3432862-2-sdf@fomichev.me>
Message-ID: <878qxh7mf4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d0ba62-f2e0-4554-849e-08dcb15fd0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u8DsfwGsKa5MJV06amu/LJnulI4hmn37rzRISJOn3eSGayWcAqWQEOdnkkit?=
 =?us-ascii?Q?ff1kWm3docDCTDATRUYFNFAgbLJya6LYtzWgnIPsWfx+l1uyChv1O+cfaQOI?=
 =?us-ascii?Q?RFgEMoATDf78DzWUIXIczKjxdLXs6E5lkdO+UMD4lb3Ou+Rhz+xzBfrfPQrT?=
 =?us-ascii?Q?oEFf+pfQSN+euGDNGd2rzSo9y6QqpmxCnpMolY4NuRqFrJeEJagLenynp25Q?=
 =?us-ascii?Q?IM3tZe6D3Osf3cI9eM2eZ9oUjkVvRrc+eHZ2naWyo0cpFAzSbf0uSFItFSTs?=
 =?us-ascii?Q?cj3cQOmuLwwMQEPAxFzFYC1sADkVr28c6GvK+qDocktUIBokBOmJuSSnpBa3?=
 =?us-ascii?Q?r149MH9smj+S7O2/IximzNN8tHnr2uDWk2sW06ahRyhK0MFQBPiqm9T8BpMI?=
 =?us-ascii?Q?zeGPdEv/quwK1t5I4Oq+oEIlozrnzW6R9dl0SH8YAXsAODPDMbmnz6b5eHvL?=
 =?us-ascii?Q?RC0iEYwXHMZHKjK61CnElluCZcZvDQ2YP5t701m3RRURoJXOI1ataWsTEqc5?=
 =?us-ascii?Q?iwRX8rVbIEVnbu6v6/Yf50srJhWgxHCSFoIGhdouu/Cz9ARy29FDJipqXKPW?=
 =?us-ascii?Q?Gvq97c/KhvIRFqvIrHa6HaRQuoBWH2zkJQLJ7wwxjUWlR8sTuWfjb6gPCP1s?=
 =?us-ascii?Q?M0KJ/M66R1LaF76E7l0ytijIZWnWeLowvVwv3D60WSzwKGehQwgTASBW1Wrc?=
 =?us-ascii?Q?hSyAfUZ9rbw0wOuQp8oO1I3P4N3FRKvUCRqo6W+WwUW4s+Y4NIo8MUrJXT/J?=
 =?us-ascii?Q?U9rvovxCRrOXzqlKhj++EBdChPv7kgc+x4nOABVjcsPZVKAtSl3Se3tiZCGc?=
 =?us-ascii?Q?5WiShzGGyIbRNPTc5RrmbD5dZSq7bqYkJk4cTP1kpEzp2tbTBkhOv2pHK6tu?=
 =?us-ascii?Q?2qGL/ZTFUsODKBfdA5MZo1PgABJ6bsePP4iRINjG6h7LOV7+kl2a01VD2cNJ?=
 =?us-ascii?Q?d4fp2xpFifYKXZ/88ag1rl+04eR8WiY1LWV/JMpiDtB3+WQ2vBXfVPOolWHa?=
 =?us-ascii?Q?PvMqAfzbYbWad6I1ak9WxRvpT5SM7bhAuFey5oeW2441ZxldYqA+OON0G4+M?=
 =?us-ascii?Q?nWEwHHATCgFvkzY+FdgN536358Xkdm+m/UucqC3y/31AAslX64fY7qKtHQeU?=
 =?us-ascii?Q?AOkYTr5WuKWDQ3lRhgera23mtizvIq0hlVcKKn25MnmEKL2rYiuKSCZ/Gbo3?=
 =?us-ascii?Q?PHInKy3ww9G4K+J6lG4pCZ1hyhX6sSgPzT6B4mlrpamHUJN4C1kjk/iMtXYY?=
 =?us-ascii?Q?eeMJUxMggZLXW7Ri7rguw/hjYSW3+DRJj+FIO8SCIAYRvm8cOpVII5JPzbXN?=
 =?us-ascii?Q?2DQxG9imSBIgBGTO1qU/cBjlcnwRYw9yR32yoUaAM+AB095zpoYPaQuYKspy?=
 =?us-ascii?Q?m3gm0xcY3uf9OXeQWi6yyTC3phn2AChkop6JcbdyXpHLKEtYcPjHfdetDuBq?=
 =?us-ascii?Q?vvFkE2z4qt7dCqpnJrfut+26gYpXujEJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:53:45.9197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d0ba62-f2e0-4554-849e-08dcb15fd0b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540


Stanislav Fomichev <sdf@fomichev.me> writes:

> Add new @ksft_disruptive decorator to mark the tests that might
> be disruptive to the system. Depending on how well the previous
> test works in the CI we might want to disable disruptive tests
> by default and only let the developers run them manually.
>
> KSFT framework runs disruptive tests by default. DISRUPTIVE=False
> environment (or config file) can be used to disable these tests.
> ksft_setup should be called by the test cases that want to use
> new decorator (ksft_setup is only called via NetDrvEnv/NetDrvEpEnv for now).

Is that something that tests would want to genuinely do, manage this
stuff by hand? I don't really mind having the helper globally
accessible, but default I'd keep it inside env.py and expect others to
inherit appropriately.

> @@ -127,6 +129,36 @@ KSFT_RESULT_ALL = True
>              KSFT_RESULT = False
>  
>  
> +def ksft_disruptive(func):
> +    """
> +    Decorator that marks the test as disruptive (e.g. the test
> +    that can down the interface). Disruptive tests can be skipped
> +    by passing DISRUPTIVE=False environment variable.
> +    """
> +
> +    @functools.wraps(func)
> +    def wrapper(*args, **kwargs):
> +        if not KSFT_DISRUPTIVE:
> +            raise KsftSkipEx(f"marked as disruptive")

Since this is a skip, it will fail the overall run. But that happened
because the user themselves set DISRUPTIVE=0 to avoid, um, disruption to
the system. I think it should either be xfail, or something else
dedicated that conveys the idea that we didn't run the test, but that's
fine.

Using xfail for this somehow doesn't seem correct, nothing failed. Maybe
we need KsftOmitEx, which would basically be an xfail with a more
appropriate name?

> +def ksft_setup(env):
> +    """
> +    Setup test framework global state from the environment.
> +    """
> +
> +    def get_bool(env, name):
> +        return env.get(name, "").lower() in ["true", "1"]

"yes" should alse be considered, for compatibility with the bash
selftests.

It's also odd that 0 is false, 1 is true, but 2 is false again. How
about something like this?

    def get_bool(env, name):
        value = env.get(name, "").lower()
        if value in ["yes", "true"]:
            return True
        if value in ["no", "false"]:
            return False

        try:
            return bool(int(value))
        except:
            raise something something invalid value

So that people at least know if they set it to nonsense that it's
nonsense?

Dunno. The bash selftests just take "yes" and don't care about being
very user friendly in that regard at all. _load_env_file() likewise
looks like it just takes strings and doesn't care about the semantics.
So I don't feel too strongly about this at all. Besides the "yes" bit,
that should be recognized.

