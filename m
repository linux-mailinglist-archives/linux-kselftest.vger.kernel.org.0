Return-Path: <linux-kselftest+bounces-6994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF750895A66
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26579282B29
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E91715A492;
	Tue,  2 Apr 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnhUMrkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E702AD1E;
	Tue,  2 Apr 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077685; cv=fail; b=et5OLz7l32DMgItsK0QYvDiKj8iKnZesj8wuurzbr9Kjj2U0auYeXMcftuCm99CS7klKcS32FxViWjypYcrhMmLdOtX9dKQEVueSzeCsfchVHcMmWD1CYmMdoA5lxRF7D6YHOW0Al59YMESEweM+d7Wse1MQq/NEuqmWH64TnNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077685; c=relaxed/simple;
	bh=NuGMrS3gUhnJ+xyLwU8RmHWLqL/82HVFGRZCLbPejIA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VPTzerzAFDKb1lNFFUl8j7jGx2Bxhv/IV2A+SUXhb1FmD22FQ3nkD4POFq2/B/5rZmTqzA5LJ3LLxi1h5CvfqEd86bveJF95y24tAPfe8Xj8/CLCpzcqolILQgyLuHowKH47B2K/jJKlnRmsRRgnHFRf8j6T8RyC78//mcuigVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UnhUMrkI; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhW7DqOvi9EDSLS827geGuqxLHEDixtm07YmT7pkE3pKXIvPccyWV8XDdxbW7NX93ae1jHrfl9pq91GT4wvtvESUA9iMLnLS3hVBCU7n/IS5UwXRzQ6O7mWdpTGqBitLKSItcOSLv9b32YouluiYMz8hjD1TaD21T/zx7JJV3+PfOWCB+TZqE4PUdfhb6c2C1zaQbOKfF6cy2QmAfB8H1tc0m2oWgDGTAc4g7V4wbGH5KmVjoEovyC7kvuIS5/Wd+3dgvAYLIBMrOyqWY8AFDv7ESZxpf8pOnguZoXUw+rG1BlGC65kQxOSOgFsf2dvtHak/0W/GG/8Lm0ayDUUSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z76/nkmHV25cJae+gT2hFJPcS+zyzSeyJueTU4KARzQ=;
 b=CHHIVxj7qp078crF92eeMS1JZTvqcHLtN9Qbjhwbi+HgQZkNAT7t+C0C29iCkb459fDouyhj/P8+9lE8LYwaBBq1uCMhRD2++dHahdPrCe7bDIcZIXZFDE5ZxUK53Jw4vVpws0vn5oK5CrfWB6gUE4PkKPdg9rxdGhHVqMjRm3l69XjQPtEPUx/TCu6XR0g1VQGvbIcoJy1RFPG4oDnmVQHlK92IAbx4ezttKEmtTra4mcmghta4tI7rAu8iaLWL5HKo+zxzyT6YnleF0EzJ4hcIFQjannfXQwOJ2c3amF53JmB9EVzqYi6HCUZMauGB910hKbI2/qa0Xxb2v3xLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z76/nkmHV25cJae+gT2hFJPcS+zyzSeyJueTU4KARzQ=;
 b=UnhUMrkIvZowqgYdJmct5Ek6zpAjeHhpR8xXVPH0Wr+iWwUu5gboxyC4OJa3HkiHbIqfATIMZRivRjQ+32xCzW0QVXnUXXwdvxk76VkXx8AR+raxe0XATGtXUexOraAbYPnnrkdoF3ZcJStZKQh3pIg6jqNy4Gc+/dZY4+wnUKqNzSHRXdVGMkOrhu3SztjdQFtKwetV8c9Vd5fo5BkIqxuaKu/NEueoLaXgtFnp2dS+yjEH+mbY+ljntJoiv8v5mKIIBIg8PyFGmYmhjSUxPjivPqKKLKe5HK2eSc5E67Z/xPLELMXhaU+FGjjG8nCQZaINJ/KM5vOARmyArcAzYA==
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:07:59 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::8a) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Tue, 2 Apr 2024 17:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 17:07:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 10:07:25 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 10:07:21 -0700
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-4-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next 3/7] selftests: net: add scaffolding for
 Netlink tests in Python
Date: Tue, 2 Apr 2024 17:53:41 +0200
In-Reply-To: <20240402010520.1209517-4-kuba@kernel.org>
Message-ID: <87il0zith6.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: b48bfc01-2824-4205-0ac5-08dc5337727d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gPnEtdGr1RNs/qExYk4ANwAVldzC0L+PEVpxjGQpqMNgLckEaRB51eE1RvOtBHdqavLz1QntngpmkSsrfnIKwG/0h8tzhKPdO5hF6ClSJZbscWFX3xBjUp/Et2yz4L/OjfAzZN7hLRonn1TWJNlMNDfr1hmI7gsW2CCPLcuD25jXt+NNmN098b0Fwt5gnr5+cEqXyCyiYIGHPNhvTf5XAIy8D5nuydB6bvXZvbSrDdHHcxoQCc9MzaU3I/4fj51ZiAoSITogDB4FXXihiCBIZdCZQTB3UAV/HGonovYp/fZGd5RAkAqexs+ilmsrNgLP4ioFUFlO8kPV+kpKg/TD7/xTk9sW7PuDg4DC3O3xGjbmvT9akzDz/Xgo6B1uQaWZaJ3Tgo+OUzNt3QhJrNxdM8b5YCJ2kfGVFHGnx0sNYwOeYOJOh6+x27FwQ8JpYtFB1VSqXefEuuk2EJTO6hfHMDyc5wqGTrzHpQuOVPe0u6HkruQMBwZGdJxCLdGBJTo48ZWoaEP5tZ4JIRcQ7pmUToWzvi8pVIb1FVr0XwoWhRrN3Qgg2Z3fN8PSzzltL2H6wYFQr7B2xoem1eK2tVUXxSgnyqMTIAT6vhvVImRPYm4OWf2kjgs7MWxmQnx7QaYJebcEvFT6n2cfwpZxuS9Z15cUF2v2IqI7C2ax0UASkBOKOW14b02kqk1SJ3rRISx9tnzXlKaDwmolQGiFKYkCQDkHCZrIiRxFx4tky7B68y1JlvEjLq9+ZFqBINQcHbBa
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:07:58.8715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48bfc01-2824-4205-0ac5-08dc5337727d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410


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
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/Makefile              |  7 ++
>  tools/testing/selftests/net/lib/Makefile      |  8 ++
>  .../testing/selftests/net/lib/py/__init__.py  |  6 ++
>  tools/testing/selftests/net/lib/py/consts.py  |  9 ++
>  tools/testing/selftests/net/lib/py/ksft.py    | 96 +++++++++++++++++++
>  tools/testing/selftests/net/lib/py/utils.py   | 47 +++++++++
>  tools/testing/selftests/net/lib/py/ynl.py     | 49 ++++++++++
>  7 files changed, 222 insertions(+)
>  create mode 100644 tools/testing/selftests/net/lib/Makefile
>  create mode 100644 tools/testing/selftests/net/lib/py/__init__.py
>  create mode 100644 tools/testing/selftests/net/lib/py/consts.py
>  create mode 100644 tools/testing/selftests/net/lib/py/ksft.py
>  create mode 100644 tools/testing/selftests/net/lib/py/utils.py
>  create mode 100644 tools/testing/selftests/net/lib/py/ynl.py
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index e1504833654d..0cffdfb4b116 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -116,6 +116,13 @@ TARGETS += zram
>  TARGETS_HOTPLUG = cpu-hotplug
>  TARGETS_HOTPLUG += memory-hotplug
>  
> +# Networking tests want the net/lib target, include it automatically
> +ifneq ($(filter net ,$(TARGETS)),)
> +ifeq ($(filter net/lib,$(TARGETS)),)
> +	override TARGETS := $(TARGETS) net/lib
> +endif
> +endif
> +
>  # User can optionally provide a TARGETS skiplist.  By default we skip
>  # BPF since it has cutting edge build time dependencies which require
>  # more effort to install.
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> new file mode 100644
> index 000000000000..5730682aeffb
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_FILES := ../../../../../Documentation/netlink/s*
> +TEST_FILES += ../../../../net/*
> +
> +TEST_INCLUDES := $(wildcard py/*.py)
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
> new file mode 100644
> index 000000000000..81a8d14b68f0
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from .ksft import *
> +from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
> +from .consts import KSRC
> +from .utils import *
> diff --git a/tools/testing/selftests/net/lib/py/consts.py b/tools/testing/selftests/net/lib/py/consts.py
> new file mode 100644
> index 000000000000..f518ce79d82c
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/consts.py
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import sys
> +from pathlib import Path
> +
> +KSFT_DIR = (Path(__file__).parent / "../../..").resolve()
> +KSRC = (Path(__file__).parent / "../../../../../..").resolve()
> +
> +KSFT_MAIN_NAME = Path(sys.argv[0]).with_suffix("").name
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> new file mode 100644
> index 000000000000..7c296fe5e438
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import builtins
> +from .consts import KSFT_MAIN_NAME
> +
> +KSFT_RESULT = None
> +
> +
> +class KsftSkipEx(Exception):
> +    pass
> +
> +
> +class KsftXfailEx(Exception):
> +    pass
> +
> +
> +def ksft_pr(*objs, **kwargs):
> +    print("#", *objs, **kwargs)
> +
> +
> +def ksft_eq(a, b, comment=""):
> +    global KSFT_RESULT
> +    if a != b:
> +        KSFT_RESULT = False
> +        ksft_pr("Check failed", a, "!=", b, comment)
> +
> +
> +def ksft_true(a, comment=""):
> +    global KSFT_RESULT
> +    if not a:
> +        KSFT_RESULT = False
> +        ksft_pr("Check failed", a, "does not eval to True", comment)
> +
> +
> +def ksft_in(a, b, comment=""):
> +    global KSFT_RESULT
> +    if a not in b:
> +        KSFT_RESULT = False
> +        ksft_pr("Check failed", a, "not in", b, comment)
> +
> +
> +def ksft_ge(a, b, comment=""):
> +    global KSFT_RESULT
> +    if a < b:
> +        KSFT_RESULT = False

Hmm, instead of this global KSFT_RESULT business, have you considered
adding and raising an XsftFailEx, like for the other outcomes? We need
to use KSFT_RESULT-like approach in bash tests, because, well, bash.

Doing it all through exceptions likely requires consistent use of
context managers for resource clean-up. But if we do, we'll get
guaranteed cleanups as well. I see that you use __del__ and explicit
"finally: del cfg" later on, which is exactly the sort of lifetime
management boilerplate that context managers encapsulate.

This stuff is going to get cut'n'pasted around, and I worry we'll end up
with a mess of mutable globals and forgotten cleanups if the right
patterns are not introduced early on.

> +        ksft_pr("Check failed", a, "<", b, comment)
> +
> +
> +def ktap_result(ok, cnt=1, case="", comment=""):
> +    res = ""
> +    if not ok:
> +        res += "not "
> +    res += "ok "
> +    res += str(cnt) + " "
> +    res += KSFT_MAIN_NAME
> +    if case:
> +        res += "." + str(case.__name__)
> +    if comment:
> +        res += " # " + comment
> +    print(res)
> +
> +
> +def ksft_run(cases):
> +    totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
> +
> +    print("KTAP version 1")
> +    print("1.." + str(len(cases)))
> +
> +    global KSFT_RESULT
> +    cnt = 0
> +    for case in cases:
> +        KSFT_RESULT = True
> +        cnt += 1
> +        try:
> +            case()
> +        except KsftSkipEx as e:
> +            ktap_result(True, cnt, case, comment="SKIP " + str(e))
> +            totals['skip'] += 1
> +            continue
> +        except KsftXfailEx as e:
> +            ktap_result(True, cnt, case, comment="XFAIL " + str(e))
> +            totals['xfail'] += 1
> +            continue
> +        except Exception as e:
> +            for line in str(e).split('\n'):
> +                ksft_pr("Exception|", line)
> +            ktap_result(False, cnt, case)
> +            totals['fail'] += 1
> +            continue
> +
> +        ktap_result(KSFT_RESULT, cnt, case)
> +        totals['pass'] += 1
> +
> +    print(
> +        f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
> +    )
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> new file mode 100644
> index 000000000000..f0d425731fd4
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import json as _json
> +import subprocess
> +
> +class cmd:
> +    def __init__(self, comm, shell=True, fail=True, ns=None, background=False):
> +        if ns:
> +            if isinstance(ns, NetNS):
> +                ns = ns.name
> +            comm = f'ip netns exec {ns} ' + comm
> +
> +        self.stdout = None
> +        self.stderr = None
> +        self.ret = None
> +
> +        self.comm = comm
> +        self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
> +                                     stderr=subprocess.PIPE)
> +        if not background:
> +            self.process(terminate=False, fail=fail)
> +
> +    def process(self, terminate=True, fail=None):
> +        if terminate:
> +            self.proc.terminate()
> +        stdout, stderr = self.proc.communicate()
> +        self.stdout = stdout.decode("utf-8")
> +        self.stderr = stderr.decode("utf-8")
> +        self.proc.stdout.close()
> +        self.proc.stderr.close()
> +        self.ret = self.proc.returncode
> +
> +        if self.proc.returncode != 0 and fail:
> +            if len(stderr) > 0 and stderr[-1] == "\n":
> +                stderr = stderr[:-1]
> +            raise Exception("Command failed: %s\n%s" % (self.proc.args, stderr))
> +
> +
> +def ip(args, json=None, ns=None):
> +    cmd_str = "ip "
> +    if json:
> +        cmd_str += '-j '
> +    cmd_str += args
> +    cmd_obj = cmd(cmd_str, ns=ns)
> +    if json:
> +        return _json.loads(cmd_obj.stdout)
> +    return cmd_obj
> diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
> new file mode 100644
> index 000000000000..298bbc6b93c5
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/ynl.py
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import sys
> +from pathlib import Path
> +from .consts import KSRC, KSFT_DIR
> +from .ksft import ksft_pr, ktap_result
> +
> +# Resolve paths
> +try:
> +    if (KSFT_DIR / "kselftest-list.txt").exists():
> +        # Running in "installed" selftests
> +        tools_full_path = KSFT_DIR
> +        SPEC_PATH = KSFT_DIR / "net/lib/specs"
> +
> +        sys.path.append(tools_full_path.as_posix())
> +        from net.lib.ynl.lib import YnlFamily, NlError
> +    else:
> +        # Running in tree
> +        tools_full_path = Path(KSRC) / "tools"
> +        SPEC_PATH = Path(KSRC) / "Documentation/netlink/specs"

I think KSRC is already Path? So it should be enough to just say KSRC /
"tools", like above with KSFT_DIR?

> +        sys.path.append(tools_full_path.as_posix())
> +        from net.ynl.lib import YnlFamily, NlError
> +except ModuleNotFoundError as e:
> +    ksft_pr("Failed importing `ynl` library from kernel sources")
> +    ksft_pr(str(e))
> +    ktap_result(True, comment="SKIP")
> +    sys.exit(4)
> +
> +#
> +# Wrapper classes, loading the right specs
> +# Set schema='' to avoid jsonschema validation, it's slow
> +#
> +class EthtoolFamily(YnlFamily):
> +    def __init__(self):
> +        super().__init__((SPEC_PATH / Path('ethtool.yaml')).as_posix(),
> +                         schema='')
> +
> +
> +class RtnlFamily(YnlFamily):
> +    def __init__(self):
> +        super().__init__((SPEC_PATH / Path('rt_link.yaml')).as_posix(),
> +                         schema='')
> +
> +
> +class NetdevFamily(YnlFamily):
> +    def __init__(self):
> +        super().__init__((SPEC_PATH / Path('netdev.yaml')).as_posix(),
> +                         schema='')


