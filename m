Return-Path: <linux-kselftest+bounces-34631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75081AD4686
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 01:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34F5189AC92
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777662D5415;
	Tue, 10 Jun 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bpwcvtxf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D82D5412;
	Tue, 10 Jun 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597214; cv=fail; b=SBW8dTnSx75Y8XHkFpki+ScDoDP2JeWpSkmgYVbFhrF/txe7K2Vu1DbkTp3L0bAHPvvBVDX+M3Mgc9jHoZMu4jKXrIcDbGkWbuioAqVEMtew8rvldiWdSdSzQrdM2MnZrFbzJvaMIV+H8Q6FYE8A+p+iOmuynYsLFhA4usXNUcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597214; c=relaxed/simple;
	bh=xemFi/07jAlkOoNrnbCgceiJ8QJ6o7LcgXLeaYW5YrQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkBxHflNnYi+Fg4oPk7pEP24Ak0r58ATO3S5yJbrZj67Zl5tSHa7VVv66Mwj7xL555DiBPQDbU4NUDnqquBoD3RB7ZsbsxFILbVUAcmJXqLhBrP0l4uydYE9vG2DsawfNQRtpNUx6Xir28bMK9DpquXubK3bygjAwaJIeaqaW/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bpwcvtxf reason="signature verification failed"; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rb43b3wMQIK+NEQ/l/Bk7W/5NWobaj+tm1KaMI51w29Nw2+aKrDfP/ks0lpwVED19T7VyFNjkgqq2asQFivajwPEXjHZpO4HkwG1jZNXIdY92mXOLWgGdlnO5NvKbwmC96vkPYRLT2+ipXTbdBZGO09BFI8ofRaCh7UgMIPIF5BIs+mMR0d+ftr1PwnK32E2vj5RfzjWPGxpQuMKT41U4P4y52jnHCQMRZjJoKqAVJXWX8hzgzbj8wS8p2sq9j04i9g7sELtcC7citw7ARJ6zyH+vCVZLoP+jC+rNBZ4h7Gro1/Qg3HCa7WbVbllHRnhAtpaaDEz6+u88pDK8ZdBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPapIboJQ5ldmkjzIwStZ6Wwi0jY9/XaUqgOgVxwL4Q=;
 b=OUpmmS7+5dQ3gCeYjw9EL//SEF5vLqn2/DK6VhNsJPV5gO9BEfp0ojmgTdrABn4ei2Bs/fPAb5V/WkoLemUgg8bFunan2iWoWqpI5qao/D2b03EvJ2W8aylVk60k8LffgD2J06YGqk/XSOCb6ptLkzHwdsTESaNmric12XX/iAPnHSDuztWdfOCvhh97ClODZZdS/ytgOCO/4qac+N//JrnTlcG0txD+5eyMl29OVHM+sclfaQdM0fqxA2rRdaWy71sG+pY+MV3bNaz8eV6hKFBzA+4C/9roNCg3BSkQinMbDMQJ9mMAt8RO6DDQ/L62d77V2lh+FqH7ZTLxzceqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPapIboJQ5ldmkjzIwStZ6Wwi0jY9/XaUqgOgVxwL4Q=;
 b=bpwcvtxfxav1dfKs/NLvpiIYNDglCjhwtCjejLwzckxW8OjexObWrNX5Wl4duf9IRFVLGXWTAwXrOrjCIEbq+xkXDF4zfpDrM5y2GO1rZpq2MRIRHSm39qfVOa2uFNBOOY9crPltcLcOzbSkpW9biOyEa5qte9nybmSKq1Wbumhmx/23xv4UDK/o7rjgjox7Xp0s3GDb0f2XTvLpxG/migDwILqNo7CzfoKO2bwCI84uzvmexaGWU77NHV74G+gSzVd2pyDPNzAAbnR0n53ooneezcrAH6KNOJueXwzQP5YLOHUgbMAJkl+7X41ggPHXmh2+yudSJuvTOIC7e4HXQQ==
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 23:13:30 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::9) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Tue,
 10 Jun 2025 23:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 23:13:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 16:13:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 10 Jun 2025 16:13:22 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 16:13:19 -0700
Date: Tue, 10 Jun 2025 16:13:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown
	<broonie@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: Re: [PATCH v4 12/14] selftests: harness: Stop using
 setjmp()/longjmp()
Message-ID: <aEi8DV+ReF3v3Rlf@nvidia.com>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-12-ee4dd5257135@linutronix.de>
 <aEfTYkVdphiOhqPg@nvidia.com>
 <20250610141252-1ee7ae72-dbad-4a80-931c-5b4b14fb07ce@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610141252-1ee7ae72-dbad-4a80-931c-5b4b14fb07ce@linutronix.de>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1938a6-9e45-4fba-730b-08dda874698b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?yBxUz91G2oTDGuP4dTYN3ZpFfTRSKkIWIm6VADfEikXAau4llkzT+pi827?=
 =?iso-8859-1?Q?LfbhasRUWbogqSCFo3E/Czq2yzQpnLHFqv/7ejW3UFgQQdpklvTWxKG5nz?=
 =?iso-8859-1?Q?6GyK+p8BAqq1nfNbGhslHULLGN98fzXXKBaBJ4Cx5c1s4wn2wuhY79qgp+?=
 =?iso-8859-1?Q?3MU11vXl1YpSJ53XqFhutBnZwcTtskrVtIPI+Gi6z8bOHw7Li2+oS30RyD?=
 =?iso-8859-1?Q?vtWI71lhcHAYasjein4KyKjqNY0Qt5E9JdZVxlo5/iHTkLjnHaksM1eTA0?=
 =?iso-8859-1?Q?6jA2vsmnTFjUtbKSl8aez72h9bctZtYF+ta119wdvFpRJvwVI4Ukxudxdh?=
 =?iso-8859-1?Q?ZakURB1aoN13b5wxLDkmPfF0DlzfEu5TlEdZe3svTIkll764ZE0UlJAbDT?=
 =?iso-8859-1?Q?MxlqxtnMt0RAiE5o1YvyjwI4jP6HFYCr+YGgSlDDNTX2bLjFxdzEt8jiCy?=
 =?iso-8859-1?Q?T1z4F1AYo0CvueRERjwHrOzVpzYQPki9IHMoy94ruiTWM206AMo+Q4sYui?=
 =?iso-8859-1?Q?uFSb2YsNZDYqWoXweUC1n0QmcO2Vkxdr/p464gwTRl44wIxcD7zBDP5cTK?=
 =?iso-8859-1?Q?epOObmPXOuqguDc1fTwAVuAAQgo+vrkcnVMZy1JTGaLfg4l6CMVGehHxWO?=
 =?iso-8859-1?Q?R0EqHpXEwAzDrRJzovgiiQN9m8Z3m6LmVhR8uj6m+jGadJM5P/149HeKjp?=
 =?iso-8859-1?Q?E/soywzjCP4WAUqRkd0IYDa0cs10p1IHdQd+ZKyposM1vsTBcFMCRm6zcs?=
 =?iso-8859-1?Q?rJ9pbFbR2ly/aWCBkOZNIjtPzqn5J43vMLKloetdQn9u4v+zRFEzx5eXOt?=
 =?iso-8859-1?Q?slkVEzMDPEEWpAMDfruN/xYfAwVrmfraOYou1DpjpymkqeHJDSK6L+88wi?=
 =?iso-8859-1?Q?VtjrWvTGQqLbOeTl1UgZo1dQKgzPeyj3bbj5eQpf6ybabD2pLBIy9RUJiE?=
 =?iso-8859-1?Q?ABwbmrwvh0gSaT6AOI9Z5myEJIZuMDbzf7mASuYOWir8525n6bl6OHogAJ?=
 =?iso-8859-1?Q?MX3Q59JG6x5n0JHuMdVzeOXpavC6T9aLrNpVOn0MKys0uB9FWjFaZdWHtL?=
 =?iso-8859-1?Q?oS0c7zXctKazKEGSpYqT5ZVujvbA8nJittHybHhUyo3DvqCq/uUiPkaJ4d?=
 =?iso-8859-1?Q?fJy8p3JIeO0TWVFVmwNDos0qu87j8cTi2aYYVWatmeoO0ofPntHnjZ8F/Q?=
 =?iso-8859-1?Q?/riyOcDwlzN64QPeSDk3KGLCbW+Id7G7u1GUZIlBzDqX9878+tYDuaom9G?=
 =?iso-8859-1?Q?KSLDxRdmwodRNN9OtZkG3NiQftZxeuOK8tHG1JkHUJ75JCu4nFxhGpgzWn?=
 =?iso-8859-1?Q?2VM6NQJPyNq45YiCWzK/AqVO+EMVOIFK2zwEQHC7zxBBknQlOxOloowU6l?=
 =?iso-8859-1?Q?iaVe97Q8U5u0nROaHMn2fTYBHeDz8iJiwW8KRwcjncSE/H/IeoyVONysQG?=
 =?iso-8859-1?Q?ONbqhh2MCvnu66JgXQhIJWyW8ZXuiCVTdQMTrSLuIa13A3QQRViJy8amLM?=
 =?iso-8859-1?Q?Vu56u1Yjfel4DMlJie2tXmmLtER3l7Eh/iRiJTzjlUMC41u7YqSxayHjYf?=
 =?iso-8859-1?Q?t1eGXY+CfY7JltMaOzAChnFolMYW?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 23:13:29.6060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1938a6-9e45-4fba-730b-08dda874698b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494

On Tue, Jun 10, 2025 at 02:21:25PM +0200, Thomas Weißschuh wrote:
> The following diff *alone* also prevents the warning, but that doesn't
> make any sense either:
> 
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -65,7 +65,7 @@ static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
>                 return MAP_FAILED;
>         if (ftruncate(mfd, length))
>                 return MAP_FAILED;
> -       *mfd_p = mfd;
> +       *mfd_p = 0;
>         return mmap(0, length, prot, flags, mfd, 0);
>  }
> 
> 
> Maybe the logic became too complex for GCC?

Maybe. Those warnings are gone using a dummy setjmp() without a
longjmp() :-/

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..2dc288413fc7 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -67,6 +67,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <setjmp.h>

 #include "kselftest.h"

@@ -407,6 +408,7 @@
                FIXTURE_DATA(fixture_name) self_private, *self = NULL; \
                pid_t child = 1; \
                int status = 0; \
+               jmp_buf test = {}; \
                /* Makes sure there is only one teardown, even when child forks again. */ \
                _metadata->no_teardown = mmap(NULL, sizeof(*_metadata->no_teardown), \
                        PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
@@ -422,6 +424,7 @@
                } \
                _metadata->variant = variant->data; \
                _metadata->self = self; \
+               setjmp(test); \
                /* _metadata and potentially self are shared with all forks. */ \
                child = fork(); \
                if (child == 0) { \

