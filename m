Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA4C11AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2019 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfI1R5W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Sep 2019 13:57:22 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:37908 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfI1R5W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Sep 2019 13:57:22 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-03.nifty.com with ESMTP id x8SHsFgZ018859
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2019 02:54:15 +0900
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x8SHrwTn000817;
        Sun, 29 Sep 2019 02:53:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x8SHrwTn000817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569693239;
        bh=0Gd7o+697MeBCUqaaUAEfXA11UsBOCRd4GDceG/VWV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xPFANoLRpX3aNeemf3C7gLC4sZ7YE7Q5QlSE0KS3GgrbAgkF7INARMIm+s9FhcTMw
         m+xT3uOIuLPZk5TDTa7CvpChMnLjkiMJInpniRGnxGySUGDS1JKTXHGRxdVqjj55gA
         Jh6NndGojJLx3IoCfS9CwK+nhEhj/fEJQp6mvWKQW36ZVTL/JLFKEvrAd+olzj64u2
         8V2e4eXCwcP90UtSUyTIg5Qzs/cj7UXXiH16ruZFg4yAu10Xo79Fjpz8SXypfOc596
         Ii0lLSuPkx1F5dOocTfQDA74GJLD7aq5kZcQzsAn+/vg5DHTJeCVlpZSf9v3F0DQeL
         QfpfGNpwjkvRw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id p13so4058783vsr.4;
        Sat, 28 Sep 2019 10:53:58 -0700 (PDT)
X-Gm-Message-State: APjAAAV4RAVCoyZ2f6fRY5GfQ8H+tQTzHMZpaVux9I9K/0DkEBPKczHz
        w/wi5oOzgTPN9RkrV1SrXX0p8+hOAVKNFD/unzI=
X-Google-Smtp-Source: APXvYqzswS2+WFLQdAXZWkoQOfsSbayR7ZmaqNEdTu0Bi2gncoF0XyLVOTRaza3guM2TSyOyfuZU/b+7FdMS3e/zRxM=
X-Received: by 2002:a67:1a41:: with SMTP id a62mr6023749vsa.54.1569693237601;
 Sat, 28 Sep 2019 10:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190926224014.28910-1-skhan@linuxfoundation.org>
In-Reply-To: <20190926224014.28910-1-skhan@linuxfoundation.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 29 Sep 2019 02:53:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNOUwnS1=FStKCpPPxDVv=43F_dgvZehJnWQUXj4ER-g@mail.gmail.com>
Message-ID: <CAK7LNASNOUwnS1=FStKCpPPxDVv=43F_dgvZehJnWQUXj4ER-g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: Add kselftest-all and kselftest-install targets
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 27, 2019 at 7:40 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Add kselftest-all target to build tests from the top level
> Makefile. This is to simplify kselftest use-cases for CI and
> distributions where build and test systems are different.
>
> Current kselftest target builds and runs tests on a development
> system which is a developer use-case.
>
> Add kselftest-install target to install tests from the top level
> Makefile. This is to simplify kselftest use-cases for CI and
> distributions where build and test systems are different.
>
> This change addresses requests from developers and testers to add
> support for installing kselftest from the main Makefile.
>
> In addition, make the install directory the same when install is
> run using "make kselftest-install" or by running kselftest_install.sh.
> Also fix the INSTALL_PATH variable conflict between main Makefile and
> selftests Makefile.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

For the top Makefile change:

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> ---
> Changes since v1:
> - Collpased two patches that added separate targets to
>   build and install into one patch using pattern rule to
>   invoke all, install, and clean targets from main Makefile.
>
>  Makefile                                     | 5 ++---
>  tools/testing/selftests/Makefile             | 8 ++++++--
>  tools/testing/selftests/kselftest_install.sh | 4 ++--
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d456746da347..ec296c60c1af 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1237,9 +1237,8 @@ PHONY += kselftest
>  kselftest:
>         $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
>
> -PHONY += kselftest-clean
> -kselftest-clean:
> -       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
> +kselftest-%: FORCE
> +       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
>
>  PHONY += kselftest-merge
>  kselftest-merge:
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index c3feccb99ff5..bad18145ed1a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -171,9 +171,12 @@ run_pstore_crash:
>  # 1. output_dir=kernel_src
>  # 2. a separate output directory is specified using O= KBUILD_OUTPUT
>  # 3. a separate output directory is specified using KBUILD_OUTPUT
> +# Avoid conflict with INSTALL_PATH set by the main Makefile
>  #
> -INSTALL_PATH ?= $(BUILD)/install
> -INSTALL_PATH := $(abspath $(INSTALL_PATH))
> +KSFT_INSTALL_PATH ?= $(BUILD)/kselftest_install
> +KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
> +# Avoid changing the rest of the logic here and lib.mk.
> +INSTALL_PATH := $(KSFT_INSTALL_PATH)
>  ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
>
>  install: all
> @@ -203,6 +206,7 @@ ifdef INSTALL_PATH
>                 echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
>                 echo "cd $$TARGET" >> $(ALL_SCRIPT); \
>                 echo -n "run_many" >> $(ALL_SCRIPT); \
> +               echo -n "Emit Tests for $$TARGET\n"; \
>                 $(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
>                 echo "" >> $(ALL_SCRIPT);           \
>                 echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
> diff --git a/tools/testing/selftests/kselftest_install.sh b/tools/testing/selftests/kselftest_install.sh
> index ec304463883c..e2e1911d62d5 100755
> --- a/tools/testing/selftests/kselftest_install.sh
> +++ b/tools/testing/selftests/kselftest_install.sh
> @@ -24,12 +24,12 @@ main()
>                 echo "$0: Installing in specified location - $install_loc ..."
>         fi
>
> -       install_dir=$install_loc/kselftest
> +       install_dir=$install_loc/kselftest_install
>
>  # Create install directory
>         mkdir -p $install_dir
>  # Build tests
> -       INSTALL_PATH=$install_dir make install
> +       KSFT_INSTALL_PATH=$install_dir make install
>  }
>
>  main "$@"
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
