Return-Path: <linux-kselftest+bounces-42781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073EBBDCA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 06 Oct 2025 12:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C824B3A580F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Oct 2025 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BB274B42;
	Mon,  6 Oct 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jx3dcUQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4526F46C;
	Mon,  6 Oct 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747713; cv=fail; b=PmOPS9dKJyJBNAmJJ6kFZTt5eVtY89m/3kmU7hcGUS2s07vL6eY6SWD6vT77RUtcsPGQ4zhU2smXhnePHL5cdzOk7XptBJ+fRup1Oqb5/iGXle9hlR8qA163WWcuAvEep7C1TwZw3yxdeGrvresbFWkvgPRIddq/sWLlsUpHxu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747713; c=relaxed/simple;
	bh=9DZfrjE620Agx1BPG4V7N/s1ljTQfXSZ1kByRkC9+xI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hC0S8UTd8N3bgO5Q7m6+LCO25I4ZZlVG4Ypq0+YKFL3ak+k1O2QyXfkcvw1tEdkz7s7f9XmvB+acpkw/uCR0k1gSQkKAgeuqiqDv75HrBftm0/CQGYjdBXkx8Zetsq+i7UM71O6q1y6NyWftY/wan+cbdhHIL2HB5+8lmjFxyBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jx3dcUQ6; arc=fail smtp.client-ip=52.101.61.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLgLowpWA0M6GVKM02Z5se/6X+J2EF9ESb9ce1ZGGR6FYqQ029kDsWnuxLvF3FSTZ32ZMivY2IANiSrB64EZj1A8pmXPlI11iH9NnSqR9kVSzV4lBoKLwO/eD1IY/pX5LiT/PTxMdQFgZNSeUs3yyt9LZQG02DQLO01/V80f0LCbPl3G5O80sP6rYyaX0km1IKkx+C+7qW/P5P1AA/lMjHE+9g5VlA0Vz56TlGwGQa5Cls+M7N6bxMv9PQKS88svj3w/ClpQKBuo2kx3VOJeStbZzdJRiV7QQTovkBK3OHsRtlsPBOZ/0DNZeURvF5DPSqrQvie72IsTLOQO8domaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ojB9u4d7uTq9yuVcGIvbZ47VqyEknRCZdeur5sjuWo=;
 b=tAGh7sUf2P/pxBWA1xi+721+UiD2gUEkhx6oGTdvf0cEsFd5rNtCNqACTPTAIygTBPSYXQNJgNQC9yAWstqufg7VTNmzbt1B4HVAmY0t/YLOKKM/YJYxtmwgzFPxg2OD3SbGczMEX7BQvyBxgAXgrERs9WM4OEccTIWXmMVCjei2u3DupV8XP4cmKrKWMgjKMAzLBUdyAWhY9HRDcS/wHmwnQCQpFJ25CqS+dw9PDFtf64EgZay/EILgHfjJqeA+nQMsgaUoiUHHe9nwZqGq9vAxLwS3W3oUhvVZPsu4ICW2PHqh/fSc/Bl+rhBt9A9T6EEN9RHIvlAWiqK1rdw+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=netfilter.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ojB9u4d7uTq9yuVcGIvbZ47VqyEknRCZdeur5sjuWo=;
 b=Jx3dcUQ6JoAN/oIhc1WI6k1nyAfT9wCRiiPp4bFy+uDnI3zAWeJBspoK1jT9Rmpzz132BZTWZ8ND5yeh9M7gvfBndnnKMU+UBDF/Efef9jJKzdQgEd+ytlSA11DZDiqg5ZEOV1pe28ZFTo0enGX6qjVSkPj8X4S8Bq4jBjoxSuYbp2FKAHBGGNzcYH1lnjVn2UJz9TUtOjVjSgMvijzeSYbuRyHxau7xjSACvLlkj7dfMj02I5jCm46pylDZRYDu9x2t7sYgk77huMdy0wwhnyFuVDiK8Oew5nDrOHR2MEFl/aMLD9E3zI+TliFP36wNliA6pmMVvSuGz5qkCR7hjQ==
Received: from BN9PR03CA0445.namprd03.prod.outlook.com (2603:10b6:408:113::30)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:48:21 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::f4) by BN9PR03CA0445.outlook.office365.com
 (2603:10b6:408:113::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Mon, 6 Oct 2025 10:48:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 6 Oct
 2025 03:48:06 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 03:47:54 -0700
References: <20251003210127.1021918-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>, "Antonio
 Quartulli" <antonio@openvpn.net>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Allison Henderson <allison.henderson@oracle.com>,
	<shuah@kernel.org>, <jv@jvosburgh.net>, <olteanv@gmail.com>,
	<jiri@resnulli.us>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <kuniyu@google.com>,
	<martineau@kernel.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<fw@strlen.de>, <petrm@nvidia.com>, <razor@blackwall.org>,
	<idosch@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<mptcp@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>
Subject: Re: [PATCH net v2] selftests: net: unify the Makefile formats
Date: Mon, 6 Oct 2025 11:40:59 +0200
In-Reply-To: <20251003210127.1021918-1-kuba@kernel.org>
Message-ID: <87o6qkcnol.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4ba46d-b29e-4133-4458-08de04c5ddd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q51C6cjIfeyiixJ9RvcKhlEzMtK4Bl10CBzcI15KFaPjvFWKUAn1HWNb2pyD?=
 =?us-ascii?Q?IJQPu1p6v60XD5HQiPJaNFQ8Tnpt3EbvTDJkSHwHj1etiHWiZpSCLkymyWEA?=
 =?us-ascii?Q?N6WpQVUamSmZ0nzcvxy48NZWs4ysVgiz6DXvmOddSGHyhVD7K1NkI7hi6N68?=
 =?us-ascii?Q?u87NvvNg//9z8Pt0Ld1vIOwEVU1ecIa1NFI6HFDnji5UuRip/IgrzlwLa/yY?=
 =?us-ascii?Q?Jlmr9F+GSPQaZpllRZnlcIzw1IL1Gm8pkp4U59q6tjf5zx9I9mUmWjNTZJ5h?=
 =?us-ascii?Q?mvCzqXVMYVkCpw4mTc31d2dkyYATWVNpW63/zQJLhSQ0CUKzw6JzZ2iKJxnb?=
 =?us-ascii?Q?QM5UtwF4A5U2Je0crSLARaOpp8efVXM3/CwGyj+CY4ByRLPGxpioILWa/owl?=
 =?us-ascii?Q?gtgzxt9szwBdGbMlWXQomEw6zo8Fi3oLntqWrK9RW0AiaTwTPHGFi3MlQx/5?=
 =?us-ascii?Q?KQrnqcJrc0vgwZF1EL0BM3b+tGolY4NKB/2pUxxW4L3mxW0OSjX0Lh1I1wya?=
 =?us-ascii?Q?ZujekhByoy5cjGPj/J9yFhUaQD+eve0zNEMsinlaS9PIudkvUPQexv1UE9O+?=
 =?us-ascii?Q?EHDX6WNDWlMahQ4rvggSKPH3/lrtn4hnSj1oygPcO1SjdhAEq0AV5HSWr6zi?=
 =?us-ascii?Q?p74aPOqF5VBAcZiZutpthbIhkda65S26chYoKMdyclxiib4sw+rrnDOq3aU5?=
 =?us-ascii?Q?1SQMRYDYT6jloFqPlotXFb24e79wPjqip1FnjwNcqeATrbJ5Qfedmd1av+6i?=
 =?us-ascii?Q?sO2okF7XycIaEAyRXf9+NloiL8YrwHf+/erNgYl7SbahQEoqW9I1Meink7UK?=
 =?us-ascii?Q?U3+/ALYb2Kd3ukfgnGkIN+vLo05BU1FBAUfZ8N+4EpOz1tT4OMUjO3E0fT/D?=
 =?us-ascii?Q?NvA7ZcIdGUJMIkHtXQz89zFF0MeQh8VS7DW77/NLjyHOxLU2DI3539iMCUg8?=
 =?us-ascii?Q?QMXBoAmObplcxD4zsluXpI7ouRggI4ILWZLh+2KSLICDfiHvjgb6evpFUXMQ?=
 =?us-ascii?Q?vlXpYtsaj0YqVhq0SE7OCm11xWBO+8w3sqrce2iUUX3X2WoM9YA8ZscUpOYH?=
 =?us-ascii?Q?BBZCD8fxSe92XVYezoUjHw2RESvqvn3x/unhijWQhebkCXfP3gwpIv456C63?=
 =?us-ascii?Q?Rglaq38RkuxxZNiFXaDoXtCuHksI/csWSwC61Ogf9hNdg0zZTy7icNwoumAz?=
 =?us-ascii?Q?VaVegl53kINPpTTL2rHeR2GqT+hRANMWvMBHnz9Yg5AJ1qdJrBsDHGLtk5tz?=
 =?us-ascii?Q?MbuXGMc+ugfWk7HxZxcwcoIe3FeyS/6WKSL5i7clmdcULbsz7T82+ygB8Y//?=
 =?us-ascii?Q?AmQQNM3vdNAWhdEE/SKva5cU6qss3BPIMwOS7aKYsASD2DfHe1lFLHWj8gfK?=
 =?us-ascii?Q?IOxB/865i0hF2kKQiQJXLBdORpULVvTbbjJWTByryuMTgGXH5B6UQMXnxMrW?=
 =?us-ascii?Q?PWb6cyPIg4tCebZ45LZPy0zNM0wm8DhtPa7ZGMepOfAwp+K5bH8GK2Q7JrIn?=
 =?us-ascii?Q?jQs7MEOAK8iHYupNsC+gCEntRWWamRXU0dBdktM5QpaeAGtiBfdZ+KXTvFR1?=
 =?us-ascii?Q?+jF6xzcZc7D6x7/p4r8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:48:20.8877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4ba46d-b29e-4133-4458-08de04c5ddd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203


Jakub Kicinski <kuba@kernel.org> writes:

> We get a significant number of conflicts between net and net-next
> because of selftests Makefile changes. People tend to append new
> test cases at the end of the Makefile when there's no clear sort
> order. Sort all networking selftests Makefiles, use the following
> format:

If we see weird errors in CI, it might be because tests now run in a
different order and previously masked missed cleanups are now exposed.

>
>  VAR_NAME := \
> 	 entry1 \
> 	 entry2 \
> 	 entry3 \
>  # end of VAR_NAME
>
> Some Makefiles are already pretty close to this.
>
> Acked-by: Antonio Quartulli <antonio@openvpn.net>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Acked-by: Allison Henderson <allison.henderson@oracle.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

But there's a missed nit below.

> diff --git a/tools/testing/selftests/drivers/net/dsa/Makefile b/tools/testing/selftests/drivers/net/dsa/Makefile
> index cd6817fe5be6..699e3565d735 100644
> --- a/tools/testing/selftests/drivers/net/dsa/Makefile
> +++ b/tools/testing/selftests/drivers/net/dsa/Makefile
> @@ -9,11 +9,13 @@ TEST_PROGS = bridge_locked_port.sh \

This should have the header converted as well:

TEST_PROGS := \
	bridge_locked_port.sh \

>  	local_termination.sh \
>  	no_forwarding.sh \
>  	tc_actions.sh \
> -	test_bridge_fdb_stress.sh
> +	test_bridge_fdb_stress.sh \
> +# end of TEST_PROGS
>  
>  TEST_FILES := \
> +	forwarding.config \
>  	run_net_forwarding_test.sh \
> -	forwarding.config
> +# end of TEST_FILES
>  
>  TEST_INCLUDES := \
>  	../../../net/forwarding/bridge_locked_port.sh \

