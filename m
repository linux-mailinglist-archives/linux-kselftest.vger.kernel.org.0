Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953967494FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 07:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGFFaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 01:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjGFFaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 01:30:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121A1BD6;
        Wed,  5 Jul 2023 22:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tdQdAo2qFTj9DGBuoLP2bbCYlpn9+aYrsvBc/jj9Rf8=; b=u4VkgAOorIJnIks7BeD4quSFTl
        ISGBFW6rKQ/t2PCT2iUGMw5XoZCSTI73o0HG1Ow7DLVUlRSCNP7NCrva+xHeUJJGlR9047v4XLOCt
        M5wzogth/xpQ1WAooFH5OIc7wIK07fz/D6pjjx0Pvqfb7b5envA4VuM+v6535aMJEVQ2AVchMopCN
        ohURXs3HMho+WOF79xj3MTLacTTEzUGzpZsXuCid00fuZRV4PtUYa2MfQJ+dbum+RcHG83Jsrit9M
        Itt8fANfH8AO2G3tI9Fa7XRmsuLj51T+B1qoIMueE1HzKCg6IyVwblWb1ZoSrLLzQk3eK6ekuHJ8e
        5XCzkzjA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHHZ5-000UqT-21;
        Thu, 06 Jul 2023 05:30:03 +0000
Message-ID: <fc9ebfc8-87cd-9488-20cd-85ed2a164bc9@infradead.org>
Date:   Wed, 5 Jul 2023 22:30:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v3 2/2] RISC-V: mm: Update documentation and
 include test
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
References: <20230705190002.384799-1-charlie@rivosinc.com>
 <20230705190002.384799-3-charlie@rivosinc.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230705190002.384799-3-charlie@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi--

On 7/5/23 11:59, Charlie Jenkins wrote:
> Add documentation explaining the behavior of mmap. Include
> a simple test that ensures that mmap returns an address less
> than the hint address while there are still addresses available.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/riscv/vm-layout.rst             | 22 +++++++++
>  arch/riscv/include/asm/pgtable.h              |  8 +--
>  tools/testing/selftests/riscv/Makefile        |  2 +-
>  tools/testing/selftests/riscv/mm/.gitignore   |  1 +
>  tools/testing/selftests/riscv/mm/Makefile     | 21 ++++++++
>  .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
>  6 files changed, 99 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/mm/Makefile
>  create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c
> 
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
> index 5462c84f4723..a610c68c9f3f 100644
> --- a/Documentation/riscv/vm-layout.rst
> +++ b/Documentation/riscv/vm-layout.rst
> @@ -133,3 +133,25 @@ RISC-V Linux Kernel SV57
>     ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
>     ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
>    __________________|____________|__________________|_________|____________________________________________________________
> +
> +
> +Userspace VAs
> +--------------------
> +To maintain compatibility with software that relies on the VA space
> +with a maximum of 39-bits, the kernel will, by default, return virtual

                     39 bits,

> +return virtual addresses to userspace from a 48-bit range (sv48). This

^^ duplicate "return virtual"

> +default behavior is achieved by passing 0 into the hint address parameter
> +of mmap.
> +

> diff --git a/tools/testing/selftests/riscv/mm/.gitignore b/tools/testing/selftests/riscv/mm/.gitignore
> new file mode 100644
> index 000000000000..022ea0a3f7df
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/.gitignore
> @@ -0,0 +1 @@
> +mmap
> \ No newline at end of file

add a newline, please.

> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
> new file mode 100644
> index 000000000000..d41a0b3d2ca2
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Originally tools/testing/selftests/arm64/signal
> +
> +# Additional include paths needed by kselftest.h and local headers
> +CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +
> +SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
> +PROGS := $(patsubst %.c,%,$(SRCS))
> +
> +# Generated binaries to be installed by top KSFT script
> +TEST_GEN_PROGS := $(notdir $(PROGS))
> +
> +# Get Kernel headers installed and use them.
> +
> +# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
> +# to account for any OUTPUT target-dirs optionally provided by
> +# the toplevel makefile
> +include ../../lib.mk
> +
> +$(TEST_GEN_PROGS): $(PROGS)
> +	cp $(PROGS) $(OUTPUT)/
> \ No newline at end of file

add a newline, please.

-- 
~Randy
