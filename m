Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E16EBC72
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Apr 2023 04:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDWCdo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Apr 2023 22:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDWCdn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Apr 2023 22:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B59270E;
        Sat, 22 Apr 2023 19:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6198161464;
        Sun, 23 Apr 2023 02:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084ECC4339B;
        Sun, 23 Apr 2023 02:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682217218;
        bh=OcZ0bU8LJU9yMW4pHaGP7+q1DhjiYwp1X4zH0KA+xZs=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=bT6OPPwWwCtxwTbeNBIWlBGd2U3HLbqnCjDKQOQuUBHj2V4QiG4ybtBc0HJ0mWOzp
         4p7ETEglnRsU7+VzUEaiVKMiG/9Olxul88McayFrym3TT5oE8EuTFNd7mUSTlX4Kkr
         +8bOzzn7FIvc70U6FeB5rUDct1kUGfHoGqEQI13zZ+RMXSDDOztVlbTo8/DT9vHbGu
         bHCMd1V8Gv+07I+Z51R57Je+AbCxKx+TLbYsKcFwhYH5ARASEZtzrlTm78rGyxnx/X
         WoEdIMeGoaDS9flASsxTjQZj7tpxxqlXw8YrHjLksZooGcGK12meXDeGzkDT0my1kV
         0iqNkXniVpAvg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 23 Apr 2023 05:33:34 +0300
Message-Id: <CS3S8FWAXBUF.JP6W4J54MZN@suppilovahvero>
Cc:     <linux-sgx@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <heng.su@intel.com>, <pengfei.xu@intel.com>
Subject: Re: [RESEND PATCH] selftests/sgx: Add "test_encl.elf" to TEST_FILES
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Yi Lai" <yi1.lai@intel.com>, <dave.hansen@linux.intel.com>,
        <shuah@kernel.org>, <jethro@fortanix.com>, <bp@suse.de>
X-Mailer: aerc 0.14.0
References: <20230421033123.445883-1-yi1.lai@intel.com>
In-Reply-To: <20230421033123.445883-1-yi1.lai@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri Apr 21, 2023 at 6:31 AM EEST, Yi Lai wrote:
> The "test_encl.elf" file used by test_sgx is not installed in
> INSTALL_PATH. Attempting to execute test_sgx causes false negative:
>
> "
> enclave executable open(): No such file or directory
> main.c:188:unclobbered_vdso:Failed to load the test enclave.
> "
>
> Add "test_encl.elf" to TEST_FILES so that it will be installed.
>
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Signed-off-by: Yi Lai <yi1.lai@intel.com>
> ---
>  tools/testing/selftests/sgx/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> index 75af864e07b6..50aab6b57da3 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -17,6 +17,7 @@ ENCL_CFLAGS :=3D -Wall -Werror -static -nostdlib -nosta=
rtfiles -fPIC \
>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
> =20
>  TEST_CUSTOM_PROGS :=3D $(OUTPUT)/test_sgx
> +TEST_FILES :=3D $(OUTPUT)/test_encl.elf
> =20
>  ifeq ($(CAN_BUILD_X86_64), 1)
>  all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
