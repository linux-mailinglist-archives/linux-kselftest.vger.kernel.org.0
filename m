Return-Path: <linux-kselftest+bounces-548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF927F75F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 15:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C7D280F41
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF002C84C;
	Fri, 24 Nov 2023 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BsXwDs6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453C11988;
	Fri, 24 Nov 2023 06:08:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU2gptxI66/X2ZdvW2ZHpSmPZmNLecvMLdMfmMKBOxTfs84HZD/9HG4SugmCXJCUDumiPtCuETWVoB9g2L6klX6JqDeJ1idyKb94sTNE2WhmReKWkUIcSTG1kUcDlFx098EeVrO2EHxXnYmROU5Lg1Oc3S6ohRjX26T/ioppohv99BVrza0TZmNecS19NGZ/NaP3xONqLPiz9Lvsw9oSchyRV0OMJB3aQkGCL83aqCXh9yrd+PwSzpZMvgbtxl3uM7FOnZjmh7OJ+Mc12i14RaSHRCp1fkp/E7dWVU1u9UtrG2R0A+DLP4ePT4oLRJFwTEvGegJsWCTh1cH9Iq8HXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hio7W9fLSPGnQqSBgMF+qAmZqFXJqIoCNzwFaIFAr+s=;
 b=mtKF+ctH4Z2iVwH1DjyNRHLvFlQiH04NPPwLQh12PcwgIM5A/HeujDt0jr8MNlVwvZZpNpGdH5mEbZ3Sm9xEsFEhY5d0cXB+XDNkPzzYRBhXmXAopuA/jI95HWGe9CC7zMnJ5XTjLITfKYF+7DJEbybpMDFNl/zAQMuy3hq90pEAHnPlx/h0aHXeBE4JcX/lfQkdPjav0/No8M/veN8ssS9q2fcOhIh5pXmDPMQcvojADoOG68n0+EfYHQq/JP7COJz7mXAVc7+l21RMR7yERKIoEIO1OD+N4jWOqjHCtFhIA1RdeT1wB/4bgAH1xTvEvSZNY1k6F3fxctOdRAdO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hio7W9fLSPGnQqSBgMF+qAmZqFXJqIoCNzwFaIFAr+s=;
 b=BsXwDs6+yZryBhcC55nPE41YGCYCKOGBhTr7gAd4a25TKFYITSAfb06EWA//oO2KgoHN+A6BOP7jRxduq8Pk8c8YCOX6LTChD1P+liYntj/aZ4C3WV7CXnA8S9F1sgwkosjT2vDyRQzKGxbEQCyPgpxWM8qnvWoBsR5q5jFo6I+bQkxKkdJxKAiiLeAypJvGVwurhLm2f9alq+a5C5z5KqTOkl83yLyPGFrZIysGjvqqe/Rok0uZcc5zqhSD9Ukxy7Wz0qWhsNpUfhkH//zPLxLnCEJixNbfhPvqhU1HZ7d64MFrNNvtyzT9EFJz6SZGL4l4DvWoptr9Rx6ln7BaqQ==
Received: from BYAPR06CA0019.namprd06.prod.outlook.com (2603:10b6:a03:d4::32)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 14:07:57 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::7c) by BYAPR06CA0019.outlook.office365.com
 (2603:10b6:a03:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.30 via Frontend
 Transport; Fri, 24 Nov 2023 14:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 14:07:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Nov
 2023 06:07:36 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Nov
 2023 06:07:33 -0800
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
 <20231124092736.3673263-2-liuhangbin@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, David Ahern
	<dsahern@kernel.org>, <linux-kselftest@vger.kernel.org>, Po-Hsu Lin
	<po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Brown" <broonie@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH net-next 01/38] selftests/net: add lib.sh
Date: Fri, 24 Nov 2023 15:05:18 +0100
In-Reply-To: <20231124092736.3673263-2-liuhangbin@gmail.com>
Message-ID: <87h6lbfdnh.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: d53494b5-ca7d-47e2-d56b-08dbecf6c234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bKS24oI0rcpOm7B0c3GJBIPhZJwKAQNyVcTcNe7h0tc1FcKOC5Tg8ooH5A22djOPI4v+MJi94mQNA5b1LWDofib74XualLeyLcnceMt+Ima00INGZJpdOrkTmYbnyem+bmYMqcNzoPkbxK4vEtHR3FO5lT8ZjaHWvECfv/FnPWqEdjtqBWCC++xsljoGd0mpdTxqFm7mhaB55JlzcAM2QDz37QSEEHBJpijWP5r+3W4tyVbuXsfLtUZD8LCHWU81eVWtKJMfHJCK2WAGArVHAh1HCMZc7hYJ6nQI3kCQqilvlyCgOe+KogG/97ZW+3xFpNa5PvObv8v2NkWBe6VvTrU+eSGP9B8vHBJM35NEfsbgcqGg2tiQSfDFVIOPyqZS2pciw4X1wKsv/lKIXRztTSEZfXqRPuv5QGQlfuc7HSTy1ViHXtcc0+Ju9vyxyVFBsBqgvUI1v83T0L8Mb9QGyxiUM9OXYSLRcqqqCDzpED8ucSVIw/HYgYzeN+lOV9deccnexP8fxINWfvKC0OzlLXeoozvuD/x0OsIgVEV8Ibf126H4i9WSPmhdBhkYfXq9EnASKT8dVB39hi1eKoOhEteuq2zBck7EhTCAGTUuAFfXWGxfdwzw35i6VvdhWpdkv/qt2gowHHhKKKKEHS2ya66HxPdp5vC8vPnuOCAFMHnvPLq171kZUVj3F0lEx91PvAamoYhBmt1vUcebDZypHiAyRxB6PcBHde7r1x1ugZuJurA08WSkYF5/zUKeyn7G
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(6916009)(40460700003)(70586007)(316002)(70206006)(54906003)(36756003)(26005)(16526019)(336012)(426003)(2616005)(6666004)(83380400001)(478600001)(82740400003)(356005)(7636003)(36860700001)(86362001)(47076005)(2906002)(7416002)(5660300002)(40480700001)(8676002)(8936002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 14:07:56.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53494b5-ca7d-47e2-d56b-08dbecf6c234
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386


Hangbin Liu <liuhangbin@gmail.com> writes:

> Add a lib.sh for net selftests. This file can be used to define commonly
> used variables and functions.
>
> Add function setup_ns() for user to create unique namespaces with given
> prefix name.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile |  2 +-
>  tools/testing/selftests/net/lib.sh   | 98 ++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/lib.sh
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 9274edfb76ff..14bd68da7466 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -54,7 +54,7 @@ TEST_PROGS += ip_local_port_range.sh
>  TEST_PROGS += rps_default_mask.sh
>  TEST_PROGS += big_tcp.sh
>  TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
> -TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh
> +TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh lib.sh
>  TEST_GEN_FILES =  socket nettest
>  TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
>  TEST_GEN_FILES += tcp_mmap tcp_inq psock_snd txring_overwrite
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> new file mode 100644
> index 000000000000..239ab2beb438
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -0,0 +1,98 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +##############################################################################
> +# Defines
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +# namespace list created by setup_ns
> +NS_LIST=""
> +
> +##############################################################################
> +# Helpers
> +busywait()
> +{
> +	local timeout=$1; shift
> +
> +	local start_time="$(date -u +%s%3N)"
> +	while true
> +	do
> +		local out
> +		out=$($@)
> +		local ret=$?
> +		if ((!ret)); then
> +			echo -n "$out"
> +			return 0
> +		fi
> +
> +		local current_time="$(date -u +%s%3N)"
> +		if ((current_time - start_time > timeout)); then
> +			echo -n "$out"
> +			return 1
> +		fi
> +	done
> +}

This is lifted from forwarding/lib.sh, right? Would it make sense to
just source this new file from forwarding/lib.sh instead of copying
stuff around? I imagine there will eventually be more commonality, and
when that pops up, we can just shuffle the forwarding code to
net/lib.sh.

