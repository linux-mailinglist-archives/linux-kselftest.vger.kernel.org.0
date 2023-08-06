Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAE771453
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 12:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHFKJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 06:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHFKJA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 06:09:00 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2517A131;
        Sun,  6 Aug 2023 03:08:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4585960004;
        Sun,  6 Aug 2023 10:08:53 +0000 (UTC)
Message-ID: <a8a282a3-0530-e1c0-ab54-de302236ce8a@ghiti.fr>
Date:   Sun, 6 Aug 2023 12:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 4/4] RISC-V: mm: Document mmap changes
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
References: <20230727212647.4182407-1-charlie@rivosinc.com>
 <20230727212647.4182407-5-charlie@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230727212647.4182407-5-charlie@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 27/07/2023 23:26, Charlie Jenkins wrote:
> The behavior of mmap is modified with this patch series, so explain the
> changes to the mmap hint address behavior.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
> index 5462c84f4723..69ff6da1dbf8 100644
> --- a/Documentation/riscv/vm-layout.rst
> +++ b/Documentation/riscv/vm-layout.rst
> @@ -133,3 +133,25 @@ RISC-V Linux Kernel SV57
>      ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
>      ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
>     __________________|____________|__________________|_________|____________________________________________________________
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
> +Software can "opt-in" to receiving VAs from another VA space by providing
> +a hint address to mmap. A hint address passed to mmap will cause the largest
> +address space that fits entirely into the hint to be used, unless there is no
> +space left in the address space. If there is no space available in the requested
> +address space, an address in the next smallest available address space will be
> +returned.
> +
> +For example, in order to obtain 48-bit VA space, a hint address greater than
> +:code:`1 << 47` must be provided. Note that this is 47 due to sv48 userspace
> +ending at :code:`1 << 47` and the addresses beyond this are reserved for the
> +kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
> +than or equal to :code:`1 << 56` must be provided.


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

