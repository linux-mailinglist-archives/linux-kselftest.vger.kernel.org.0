Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E392752064
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjGMLvN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjGMLvM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:51:12 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466551734;
        Thu, 13 Jul 2023 04:51:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5DC2FF80D;
        Thu, 13 Jul 2023 11:51:02 +0000 (UTC)
Message-ID: <f903634d-851f-af64-8d9a-6b13d813587c@ghiti.fr>
Date:   Thu, 13 Jul 2023 13:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests/riscv: fix potential build failure during the
 "emit_tests" step
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Evan Green <evan@rivosinc.com>,
        Hugh Dickins <hughd@google.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230712193514.740033-1-jhubbard@nvidia.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230712193514.740033-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi John,


On 12/07/2023 21:35, John Hubbard wrote:
> The riscv selftests (which were modeled after the arm64 selftests) are
> improperly declaring the "emit_tests" target to depend upon the "all"
> target. This approach, when combined with commit 9fc96c7c19df
> ("selftests: error out if kernel header files are not yet built"), has
> caused build failures [1] on arm64, and is likely to cause similar
> failures for riscv.
>
> To fix this, simply remove the unnecessary "all" dependency from the
> emit_tests target. The dependency is still effectively honored, because
> again, invocation is via "install", which also depends upon "all".
>
> An alternative approach would be to harden the emit_tests target so that
> it can depend upon "all", but that's a lot more complicated and hard to
> get right, and doesn't seem worth it, especially given that emit_tests
> should probably not be overridden at all.
>
> [1] https://lore.kernel.org/20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org
>
> Fixes: 9fc96c7c19df ("selftests: error out if kernel header files are not yet built")
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>
> Andrew,
>
> With this, and with my arm64 fix [2] that you've already put into
> mm-unstable, you should be able to safely drop commit 819187ab8741
> ("selftests: fix arm64 test installation").
>
> [2] https://lore.kernel.org/20230711005629.2547838-1-jhubbard@nvidia.com
>
> thanks,
> John Hubbard
>
>
>   tools/testing/selftests/riscv/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 9dd629cc86aa..f4b3d5c9af5b 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -43,7 +43,7 @@ run_tests: all
>   	done
>   
>   # Avoid any output on non riscv on emit_tests
> -emit_tests: all
> +emit_tests:
>   	@for DIR in $(RISCV_SUBTARGETS); do				\
>   		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
>
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> prerequisite-patch-id: 37c92f7425689ff069fb83996a25cd98e78d7242


Perfect timing, I have just encountered this failure this morning:

make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1

that your patch fixed :) So you can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thank you!

Alex

