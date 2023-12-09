Return-Path: <linux-kselftest+bounces-1470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D230480B1A9
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 03:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9941F21347
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 02:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706B7F8;
	Sat,  9 Dec 2023 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/NPVYMN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A57F1;
	Fri,  8 Dec 2023 18:05:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ4JXAnew+t4xSTl4QQw6E1Zv/psyqI8jOEWr9nHsYHrPkBGcYUeXF06sAvPL/ZeEOwMwTAiRhqwnNu+HzpH+RmA9ZTkg6h8/eZfzPI1wI0ZLJJOy2YEbmdKsAw1rbfe3kirFq9tigeIZJJKMW5nBNaFMPHrlHITr8Jf7qYTYNudDFcswiF7AuNLPTLwdsN4nvlESX1B1ncH5xxj2LT4gdHunF25NKsvLr3ayCt9knA8ZTzzMEHbHmcw/Jp3YjZP2m0x9FYof1dvEu1b9KOY1Sb21iAqY7DsBxdCpCHyeuBo4Lma5a1a46jPF60/j8zE8/QX1DZovIPxW4H7v13CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujjjlGD0cy/Ht4ZbY31fgTy0harHUzCzeS7qoYwqjTQ=;
 b=F2JUyYYpJvGvcCwI5mv0gdWW1vNWJCkIgqeV3GYOoDznyKQAIqnpEwkYoYhB03WUO9cDxq1YTr0wVzPV7Bus7s3Ca6zoTOyrmUJGVfGFhW4IP50x0M/DOc9yvezu7HPVClfgDEB0/yA4A3Ss2Zqx7lrxhLGSB417Im8XEtCv86iU5/aU07hIDa0KQwrslXqki3NHeXFJf4ruDSI7+bGOfoQC1RIJDUrKrfZ9ufeU+Iv/gcqtnfcUk39Ov5+Sq5ARZuT/MBL5vwAKVMsWuPsOQDRsrn8e/a1ciK9qYkbrfznzcobtAEKZyh7S6kedDTgR/pSLnlOHC1QMIct53PD0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujjjlGD0cy/Ht4ZbY31fgTy0harHUzCzeS7qoYwqjTQ=;
 b=B/NPVYMNt1jJx1TAd0iaB27TsFnlG/NqpyvTcB+8gHpc61xAFsJPC9OGvgF90vEWWgNvGTbCMVwzpb9tNOwlLHksCB3ONflRA6IYC/orJkfKlKwJr6ttAeQNtoMehSP3sSH05MreMs7f3CxM2ssL4rvLqvgpT6beVOyGF1IdWOhGYpwayd3aiWSFvUkemEVHb4BG0IyhSVlRgdCxHz3iY4mTfcfhbVGnXuNVDQXJzy5obwL0N4DVdyCFhUiZVoHUUO6UiREO+hRLzM9fsHKNt8feyALhp4FMQ1pUZhsF2lJVhfmVcyRzLMkowhAMb+3p/3T4zr/1geSxlDuwaJ4UsQ==
Received: from CY5PR15CA0199.namprd15.prod.outlook.com (2603:10b6:930:82::16)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 02:05:18 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::89) by CY5PR15CA0199.outlook.office365.com
 (2603:10b6:930:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Sat, 9 Dec 2023 02:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Sat, 9 Dec 2023 02:05:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 18:05:08 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 18:05:07 -0800
Message-ID: <330553d0-4888-4b55-9e9f-a168e65e1ffa@nvidia.com>
Date: Fri, 8 Dec 2023 18:05:02 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "selftests: error out if kernel header files are
 not yet built"
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, "Shuah
 Khan" <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Jonathan Corbet
	<corbet@lwn.net>
References: <20231209020144.244759-1-jhubbard@nvidia.com>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231209020144.244759-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: b28f65ef-4984-465a-0614-08dbf85b4a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ucnv7XI6CyH9eBVYdbiG2j7D/S145tbHq/ff/acNGWVAbzDQuSZCJyLuWfYwa6y0vmol6yEO3tXED0PUqX633jFp8Wi2k29gyZGqfadzGh6w1eflaP52n6cDnsYM8ngQRhVaK1Sj75UArVMap9PE1ZFfVhE4PiGAc44bja7bIH9A0D8aiqv+Lgf00wg/VoshBfl8WNweondSBo4kFhPJZsbnKzzVBSpXayVsR4H4iQR3rq6yO761PsYCpevDeYqLR7YPjMRFOmwpG4Qx69djN74zBAFQiddkI7QxF2t+9C0w4UQB3vqESZp0qrwWkkVHRXIRwN95DTDxB+i55bn1W4WyA1hRZ+Te/3aHwBL4x/I0BEdvHfe5mgcIAXuFP1VT33T1h4RA7gV+Mh1Nwaz5F4U1XHUhN6apat7ryI2VMEO3mrIaQmPTGDxoDBoQJS5EnCkK7m/eUQx0nB3BTFMr+vb/dELxVwGVmjYbMKuUW6KIEeHNBuuesxDEX3g7CGG88d9xEh2u+ReSlSWDaiJd1L8k72Smkajx9NDgwCuXJrrxZq5JY15J4EJKH2cUQX50hz++BZivwXiaOkRhKfueo4QVukHnp+L6PRXHQA7e4Y1UNKJvI/U1sIyBTTApF1kLThGhKwR94zv2D5nzFvECLHzYAvcDzJx5hAKneB5QxE+oCG+U82wJtikOCKLCUZG5I/s05ECWuouhQNSZJgL8ijtb7if1qwWj6yU0hdo8jHmtj0babxD0Wt8Eierm2Q8B5xcku9ajUGAOckIWDgSX00kPtgePTguOt5RYw6gJHp+htgklUAGnCkXPGRR8JRiT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(110136005)(70586007)(70206006)(54906003)(53546011)(41300700001)(6666004)(16526019)(2616005)(36756003)(426003)(336012)(26005)(86362001)(31696002)(82740400003)(356005)(7636003)(47076005)(83380400001)(36860700001)(966005)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(40480700001)(16576012)(40460700003)(316002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 02:05:17.9636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28f65ef-4984-465a-0614-08dbf85b4a9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

...and, somehow I failed to Cc Peter Z. Doing that now.


thanks,
John Hubbard
NVIDIA

On 12/8/23 18:01, John Hubbard wrote:
> This reverts commit 9fc96c7c19df ("selftests: error out if kernel header
> files are not yet built").
> 
> It turns out that requiring the kernel headers to be built as a
> prerequisite to building selftests, does not work in many cases. For
> example, Peter Zijlstra writes:
> 
> "My biggest beef with the whole thing is that I simply do not want to use
> 'make headers', it doesn't work for me.
> 
> I have a ton of output directories and I don't care to build tools into
> the output dirs, in fact some of them flat out refuse to work that way
> (bpf comes to mind)." [1]
> 
> Therefore, stop erroring out on the selftests build. Additional patches
> will be required in order to change over to not requiring the kernel
> headers.
> 
> [1] https://lore.kernel.org/20231208221007.GO28727@noisy.programming.kicks-ass.net
> 
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/Makefile | 21 +----------------
>   tools/testing/selftests/lib.mk   | 40 +++-----------------------------
>   2 files changed, 4 insertions(+), 57 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 3b2061d1c1a5..8247a7c69c36 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -155,12 +155,10 @@ ifneq ($(KBUILD_OUTPUT),)
>     abs_objtree := $(realpath $(abs_objtree))
>     BUILD := $(abs_objtree)/kselftest
>     KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
> -  KHDR_DIR := ${abs_objtree}/usr/include
>   else
>     BUILD := $(CURDIR)
>     abs_srctree := $(shell cd $(top_srcdir) && pwd)
>     KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
> -  KHDR_DIR := ${abs_srctree}/usr/include
>     DEFAULT_INSTALL_HDR_PATH := 1
>   endif
>   
> @@ -174,7 +172,7 @@ export KHDR_INCLUDES
>   # all isn't the first target in the file.
>   .DEFAULT_GOAL := all
>   
> -all: kernel_header_files
> +all:
>   	@ret=1;							\
>   	for TARGET in $(TARGETS); do				\
>   		BUILD_TARGET=$$BUILD/$$TARGET;			\
> @@ -185,23 +183,6 @@ all: kernel_header_files
>   		ret=$$((ret * $$?));				\
>   	done; exit $$ret;
>   
> -kernel_header_files:
> -	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                          \
> -	if [ $$? -ne 0 ]; then                                                     \
> -            RED='\033[1;31m';                                                  \
> -            NOCOLOR='\033[0m';                                                 \
> -            echo;                                                              \
> -            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
> -            echo "Please run this and try again:";                             \
> -            echo;                                                              \
> -            echo "    cd $(top_srcdir)";                                       \
> -            echo "    make headers";                                           \
> -            echo;                                                              \
> -	    exit 1;                                                                \
> -	fi
> -
> -.PHONY: kernel_header_files
> -
>   run_tests: all
>   	@for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 118e0964bda9..aa646e0661f3 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -44,26 +44,10 @@ endif
>   selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>   top_srcdir = $(selfdir)/../../..
>   
> -ifeq ("$(origin O)", "command line")
> -  KBUILD_OUTPUT := $(O)
> +ifeq ($(KHDR_INCLUDES),)
> +KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
>   endif
>   
> -ifneq ($(KBUILD_OUTPUT),)
> -  # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
> -  # expand a shell special character '~'. We use a somewhat tedious way here.
> -  abs_objtree := $(shell cd $(top_srcdir) && mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
> -  $(if $(abs_objtree),, \
> -    $(error failed to create output directory "$(KBUILD_OUTPUT)"))
> -  # $(realpath ...) resolves symlinks
> -  abs_objtree := $(realpath $(abs_objtree))
> -  KHDR_DIR := ${abs_objtree}/usr/include
> -else
> -  abs_srctree := $(shell cd $(top_srcdir) && pwd)
> -  KHDR_DIR := ${abs_srctree}/usr/include
> -endif
> -
> -KHDR_INCLUDES := -isystem $(KHDR_DIR)
> -
>   # The following are built by lib.mk common compile rules.
>   # TEST_CUSTOM_PROGS should be used by tests that require
>   # custom build rule and prevent common build rule use.
> @@ -74,25 +58,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>   TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>   TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>   
> -all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
> -     $(TEST_GEN_FILES)
> -
> -kernel_header_files:
> -	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
> -	if [ $$? -ne 0 ]; then                                                 \
> -            RED='\033[1;31m';                                                  \
> -            NOCOLOR='\033[0m';                                                 \
> -            echo;                                                              \
> -            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
> -            echo "Please run this and try again:";                             \
> -            echo;                                                              \
> -            echo "    cd $(top_srcdir)";                                       \
> -            echo "    make headers";                                           \
> -            echo;                                                              \
> -	    exit 1; \
> -	fi
> -
> -.PHONY: kernel_header_files
> +all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
>   
>   define RUN_TESTS
>   	BASE_DIR="$(selfdir)";			\



