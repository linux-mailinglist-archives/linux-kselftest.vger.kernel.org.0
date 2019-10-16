Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C0D85B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 04:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbfJPCAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 22:00:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfJPCAa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 22:00:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46tFqs03bsz9sP7;
        Wed, 16 Oct 2019 13:00:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571191226;
        bh=0KA4g3xowsqOnI9ovIRoXat3q18fqIJdjDOOFzRTZIg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XPgn6dcXOiENhvvPhScdow4uV6XbPWC/BZjzknSx1mU6zuIAhaMjhUAq9EcndoA8U
         FiJoTuLImuL4G+j2ot562gMKoLKb8zxE2O0ShNPLunyJVc/6LAkX+9F4tB1OLvcPYi
         Ty1JdudVrAYDJzRpQ6q3PYyO2XQKnU+yxJSwixPESIK6WCxUX90Fe5IvVEOVGitbuk
         /6AlB1ZsGHmwqARGfbkYZOYrqLL4DvIA7YCzqeaUJLd+7YVW/UMmXXKKF1hVrrzUgE
         sRMFALFgH9UfdEg1BNE9HeutVBQa9qAL1Xw9LgmhAIFgsQQL82AJqNrcASGRqPMrHv
         f+TT+KahHEtqQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: Add kselftest-all and kselftest-install targets
In-Reply-To: <20190926224014.28910-1-skhan@linuxfoundation.org>
References: <20190926224014.28910-1-skhan@linuxfoundation.org>
Date:   Wed, 16 Oct 2019 13:00:21 +1100
Message-ID: <87sgnttpoq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

I know this has been merged already, so this is just FYI and in case it
helps anyone else who's tracking down build failures.

Sorry I didn't reply before you merged it, I was on leave.

Shuah Khan <skhan@linuxfoundation.org> writes:
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
...
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

This change broke all my CI, because the tests no longer install in the
place it's expecting them :/

I can fix it by explicitly specifying the install path in my CI scripts.

> +KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
> +# Avoid changing the rest of the logic here and lib.mk.
> +INSTALL_PATH := $(KSFT_INSTALL_PATH)

But because the over-rideable variable changed from INSTALL_PATH to
KSFT_INSTALL_PATH I will need to export both of them in order for my CI
to work with old and new kernels.

So to emulate the old behaviour for old & new kernels you need to do:

# export KSFT_INSTALL_PATH=install
# export INSTALL_PATH=install
# make -C tools/testing/selftests install


cheers
