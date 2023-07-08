Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CAB74BB82
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 05:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGHDC5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 23:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGHDC4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 23:02:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09FB1FEA;
        Fri,  7 Jul 2023 20:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=q+fKJg6HR9afiGS5ZVUkMqH6jNo2B3LjnZTFJ0ksF7M=; b=p0hZbb6jEJgI7kz5GD5aPJTIxg
        K5qlyeCab9L4xSs9SSpGF/0EgO6mRhDnh6fMTuGwZirQheHjG1QlF5eQW1cz44VptHS+NkRdfsEgW
        NJJ88fZhRgWzwCFs6xpd1RoiueA2g1RFFtoWWtVzgz9J+IEcVN9hfuy1Pfz3rZgdGSXpwqEQOX+aE
        kdZhFhKKxeGag+JOx6+HhToNSPjduhdgq0HEnCLJgtESF60hImYhtoRiao63uC1W5Osk/o9CM7Kho
        2Ix3ZXTslu4bFUDZ8N/qkOkkVVWFoTEbv8TZgE1ig0n8rTHDOA+8vNpGi19/0JkBqS0XJotkJiUnJ
        kINsSWZw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHyDl-006Oo9-1m;
        Sat, 08 Jul 2023 03:02:53 +0000
Message-ID: <d1b35a5b-a061-a6c0-5898-aaaad3dd4986@infradead.org>
Date:   Fri, 7 Jul 2023 20:02:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] RISC-V: mm: Document mmap changes
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
References: <20230708011156.2697409-1-charlie@rivosinc.com>
 <20230708011156.2697409-5-charlie@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230708011156.2697409-5-charlie@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi--

On 7/7/23 18:11, Charlie Jenkins wrote:
> The behavior of mmap is modified with this patch series, so explain the
> changes to the mmap hint address behavior.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
> index 5462c84f4723..8141addbf888 100644
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
> +To maintain compatibility with software that relies on the VA space with a
> +maximum of 48 bits the kernel will, by default, return virtual addresses to
> +userspace from a 48-bit range (sv48). This default behavior is achieved by
> +passing 0 into the hint address parameter of mmap. On CPUs with an address space
> +smaller than sv48, the CPU maximum supported address space will be the default.
> +
> +Software can "opt-in" to receiving VAs from other VA space by providing

                                          from another VA space
or
                                          from other VA spaces
I prefer the first one.

> +a hint address to mmap. A call to mmap is guaranteed to return an address
> +that will not override the unset left-aligned bits in the hint address,
> +unless there is no space left in the address space. If there is no space
> +available in the requested address space, an address in the next smallest
> +available address space will be returned.
> +
> +For example, in order to obtain 48-bit VA space, a hint address greater than
> +:code:`1 << 38` must be provided. Note that this is 38 due to sv39 userspace
> +ending at :code:`1 << 38` and the addresses beyond this are reserved for the
> +kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
> +than or equal to :code:`1 << 47` must be provided.

-- 
~Randy
