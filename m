Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7721574DF24
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGJUWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 16:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGJUWw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 16:22:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F47313E;
        Mon, 10 Jul 2023 13:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei0LH6kQFjXkyuhBsWIsRW5lQV2ugxTUq5OFoYsqkgvc+8Ta8MDjhSg4mivtFcee6h/YSM0WnY4hcXh7e55XukyzRqcoqa49M49ejHsJnYmNTNxb0aqp4N8uFORqK8MGxfFGRk0Cj+EijdeNODUBZgtS+xfsOADhUt/FS3MxdTspu54GRdSYuLDOVNsYebQ8avTIeUVenDDoifYyoRjAXLsFJUa2KG41H7BPSP2QEOv8Gr9HV6o3gX9YPJTeN/CAxq51dihkRmdSj/cmdUfbRW7W4f7ao68/OVNAw5WMnAANwmt5dTOQNHhWZFmIDhiUZES8QOvY2N8OCghKIoxhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9iXJ8r9TaIu59H+JVT5lby4XxGj0K8JaF1RrY68KKI=;
 b=g7E7YM50JO+9txfCVkrJURzP9sERliwe4IcISLpB1HL7eS9NGe+SBBZfv+0FCi6RsDP+xaDo6Dyq0nqHw55FVenPVnWVDasinvM+rwBis9ItFdT8jKgeEcjbp5hytlFp7q7AooJQ7mXZAx2VGsD2pkcEGOVWqomsh0fdsxjXNjwy1862JBVbMTU6IkCf91rWf2dadZ1cBC5Y2PMkIKiZqMZkwxJE4ttJx6UKJUlSbhbIgfFoJho3P8/ZjEfAbCxptPbrSi1OQtg28nz+eEkY17lgZzE4vHy+xA1vGF3HfRVAPczOLAbpszq/GoYX+Dveg5mdPUqnn9K/vkZ34xFX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9iXJ8r9TaIu59H+JVT5lby4XxGj0K8JaF1RrY68KKI=;
 b=phzlKAYJnm6tv7Sh1t/qURJ3gjQDXLRi7BnIypJDpj/nkBiRJ2GxXqA1XL40jHWNvFvnSjhfSc46g6HfEDNarQRU9uP44b4RGYbblLbafnSwLbqMvrB15+Xt9TZUnazkvPUA7vhdd0RyTnW0tbO31MN+gsG1mwXvt2DasY/dzD0aKBtbmpqbIN1XdGF2b4hh1jauyDQylILke0HAXiG8bGXDc6+9PfW9slIMNhgOG3pt0NLgneK70qFRLsXFKZEeuz+vQy2XYUBbFJA1IpTFRvCfNpiI7aKGl8WLt+4mGSDErad+dTNkVAgkrJQZ5FB+zqP2nKjrLWL11kdOBD0gLg==
Received: from DM5PR07CA0112.namprd07.prod.outlook.com (2603:10b6:4:ae::41) by
 CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 20:22:49 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::9a) by DM5PR07CA0112.outlook.office365.com
 (2603:10b6:4:ae::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 20:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 20:22:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 13:22:42 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 13:22:42 -0700
Message-ID: <04a35122-5020-5ad9-7bdc-c17f9a27bf50@nvidia.com>
Date:   Mon, 10 Jul 2023 13:22:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5416f8fb-48fa-4a42-76ed-08db81836e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atWzbfR8efJCHgqzuyB1b4zz0X3seYJ258OMOJpG4ImLkshMFv11FcOnw9Z2ASi1d1O04HJcnfL6RmSwEwrOAcjnv8lmgTL6jGaDDqVF2ppL8o1mQObYXZdeMf2Q2tJns0e+QAoyNZzxSt++fPHvazYT9TCJC653RGih0mDn5/vZxtSBnvx/LoOYvdCK+40v8uAIV/BjqgpEv656i9HEAciKS6saDPzNA29avWw62CWgBEQRs11cfLxUtK3zm8F3Gr7AsI/qOu+kiRwBt7BeAIuKBNzDo88ZcaHTgRZufdi8YA00PKdT5jnkKCptZtO+rwffFS4wjJNaX3vBCm2n16Q7SmmaoBsgFx6SfxIHABjEK3V16BxisLr1+iMPnhkDxsu39iduG45l92s1OSUsFBun2hr2DAPqXojNhLjGWMrZvjKiKSoryJ17DTyTBTXIsUBW0AcVAyC3xTOUAl986IYFQlaPtcET8H2WTDn6AFqWt9izuIrNsDHnPLfImNnnxZX91pv9hPuZzs+MztUadiTtyuN3/kLK4pKSLvl/EXI/dbSugcMG0CZBuwSiFnbc2Z+3uQ6jHmbBCf4nTxEkDQMo5WROQH7WkFvHZXhKgc+fFPtsZN5aiKXNWgQHarXyAfedziOLZVKSYXtMwjzj8/H8AKTizQ6PYUn0wwMPfBhZrgSrx3jeAkLCEtKlevJtEJ5psPLOj19qKckGbuY9pa/EwVWIxw3T9lIK2haBDnKNLSwofac3FXxh1S9XRnw5TPKoFVBysPjbazFHAsIzmWdGYlMXJCX7085m3xzW0eKP6oHjDplvVd5kzIeJcuDf
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(86362001)(31696002)(31686004)(66899021)(82740400003)(40460700003)(40480700001)(36756003)(110136005)(54906003)(16576012)(70586007)(70206006)(356005)(7636003)(36860700001)(16526019)(26005)(186003)(966005)(53546011)(2616005)(5660300002)(316002)(478600001)(8936002)(8676002)(2906002)(47076005)(426003)(336012)(83380400001)(4326008)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 20:22:48.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5416f8fb-48fa-4a42-76ed-08db81836e1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 07:04, Mark Brown wrote:
> The recent change fc96c7c19df ("selftests: error out if kernel header
> files are not yet built") to generate an error message when building
> kselftests without having installed the headers is generating spurious
> failures during the install step which breaks the arm64 selftests (and
> only the arm64 selftests):
> 
> Emit Tests for arm64
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
> make[4]: *** [Makefile:26: all] Error 2
> 
> Presumably the arm64 tests are doing something unusual in their build
> setup which could be adjusted but I didn't immediately see it and since
> this is having a serious impact on test coverage in automation let's
> just revert for now.
> 
> This is causing failures in KernelCI with the command:
> 
>     make KBUILD_BUILD_USER=KernelCI FORMAT=.xz ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- CC="ccache aarch64-linux-gnu-gcc" O=/tmp/kci/linux/build -C/tmp/kci/linux -j10 kselftest-gen_tar
> 
> and also when building using tuxmake.
> 
> Full log: https://storage.kernelci.org/mainline/master/v6.5-rc1/arm64/defconfig/gcc-10/logs/kselftest.log

OK, I borrowed an arm64 system and was able to reproduce the problem.

There are 30 or 50 other pre-existing arm64 selftest build failures which were
quite misleading at first, until I got into the "right" selftests mindset of,
"massive swaths of selftests are broken, deal with it". :)

Anyway, I can now see new hard failure that you reported:

Emit Tests for arm64
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1

Let me see if there is a quick fix for this, especially given that
every other subsystem is somehow avoiding this--it's probably easy, just
a sec...


thanks,
-- 
John Hubbard
NVIDIA

> 
> Fixes: 9fc96c7c19df ("selftests: error out if kernel header files are not yet built")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/Makefile | 21 +--------------------
>   tools/testing/selftests/lib.mk   | 40 +++-------------------------------------
>   2 files changed, 4 insertions(+), 57 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 666b56f22a41..405683b8cb39 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -146,12 +146,10 @@ ifneq ($(KBUILD_OUTPUT),)
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
> @@ -165,7 +163,7 @@ export KHDR_INCLUDES
>   # all isn't the first target in the file.
>   .DEFAULT_GOAL := all
>   
> -all: kernel_header_files
> +all:
>   	@ret=1;							\
>   	for TARGET in $(TARGETS); do				\
>   		BUILD_TARGET=$$BUILD/$$TARGET;			\
> @@ -176,23 +174,6 @@ all: kernel_header_files
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
> index d17854285f2b..05400462c779 100644
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
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230710-kselftest-fix-arm64-c023160018d7
> 
> Best regards,



