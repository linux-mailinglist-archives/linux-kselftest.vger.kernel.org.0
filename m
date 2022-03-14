Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C784D865C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Mar 2022 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiCNOD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Mar 2022 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbiCNODT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Mar 2022 10:03:19 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9A6369DC;
        Mon, 14 Mar 2022 07:02:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V7BHX-8_1647266523;
Received: from 192.168.193.163(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V7BHX-8_1647266523)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 22:02:04 +0800
Message-ID: <4bd3432c-4ee4-3f5f-2c20-6e5da3362726@linux.alibaba.com>
Date:   Mon, 14 Mar 2022 07:02:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 2/2] lkdtm: Add Shadow Call Stack tests
Content-Language: en-US
To:     catalin.marinas@arm.com, will@kernel.org, keescook@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, shuah@kernel.org, mark.rutland@arm.com,
        ojeda@kernel.org, akpm@linux-foundation.org, elver@google.com,
        luc.vanoostenryck@gmail.com, samitolvanen@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <20220303074339.86337-1-ashimida@linux.alibaba.com>
 <20220314135329.80621-1-ashimida@linux.alibaba.com>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <20220314135329.80621-1-ashimida@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/14/22 06:53, Dan Li wrote:
> Add tests for SCS (Shadow Call Stack) based backward CFI.
> 
> +
> +#ifdef CONFIG_ARM64
> +/*
> + * This function is used to modify its return address. The PAC needs to be turned
> + * off here to ensure that the modification of the return address will not be blocked.
> + */
> +static noinline __no_ptrauth
> +void lkdtm_scs_set_lr(unsigned long *expected, unsigned long *addr)
> +{
> +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> +
> +	/* Make sure we've found the right place on the stack before writing it. */
> +	if (*ret_addr == expected)
> +		*ret_addr = addr;
> +}
> +
> +/* Function with __noscs attribute attempts to modify its return address. */
> +static noinline __no_ptrauth __noscs
> +void lkdtm_noscs_set_lr(unsigned long *expected, unsigned long *addr)
> +{
> +	/* Use of volatile is to make sure final write isn't seen as a dead store. */
> +	unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> +
> +	/* Make sure we've found the right place on the stack before writing it. */
> +	if (*ret_addr == expected)
> +		*ret_addr = addr;
> +}
> +#else
> +static inline void lkdtm_noscs_set_lr(unsigned long *expected, unsigned long *addr) { }
> +static inline void lkdtm_scs_set_lr(unsigned long *expected, unsigned long *addr) { }
> +#endif
> +
> +static volatile unsigned int force_label;
> +
> +/*
> + * This first checks whether a function with the __noscs attribute under
> + * the current platform can directly modify its return address, and if so,
> + * checks whether scs takes effect.
> + */
> +void __no_optimize lkdtm_CFI_BACKWARD_SHADOW(void)
> +{
> +	void *array[] = {&&unexpected, &&expected, &&good_scs, &&bad_scs};
> +
> +	if (force_label && (force_label < sizeof(array))) {
> +		/*
> +		 * Call them with "NULL" first to avoid
> +		 * arguments being treated as constants in -02.
> +		 */
> +		lkdtm_noscs_set_lr(NULL, NULL);
> +		lkdtm_scs_set_lr(NULL, NULL);
> +		goto *array[force_label];
> +	}
> +
> +	/* Keep labels in scope to avoid compiler warnings. */
> +	do {
> +		/* Verify the "normal" condition of LR corruption working. */
> +		pr_info("Trying to corrupt lr in a function without scs protection ...\n");
> +		lkdtm_noscs_set_lr(&&unexpected, &&expected);
> +
> +unexpected:
Hi, Kees,

With the default -O2, this code tests fine in gcc 11/clang 12, but
doesn't work in gcc 7.5.0. In 7.5.0, the generated code is as follows:

  bl      ffff8000088335c0 <lkdtm_noscs_set_lr>
  nop     						      ## return address of lkdtm_noscs_set_lr
  adrp    x0, ffff80000962b000 <kallsyms_token_index+0xe5908>  ## address of "&&unexpected"

The address of "&&unexpected" is still not guaranteed to always be the
same as the return address of lkdtm_noscs_set_lr, so I had to add
__no_optimize attribute here.

The code compiled under __no_optimize in above versions works fine, but
I saw the following description in the gcc user manual:

"You may not use this mechanism to jump to code in a different function.
If you do that, totally unpredictable things happen."

So there might be some risk here that we might not be able to run this
test case stably across all compiler versions, probably we still have to
use two test cases to complete this.

link: https://gcc.gnu.org/onlinedocs/gcc-11.2.0/gcc/Labels-as-Values.html#Labels-as-Values

Thanks,
Dan.

> +		/*
> +		 * If lr cannot be modified, the following check is meaningless,
> +		 * returns directly.
> +		 */
> +		pr_err("XPASS: Unexpectedly survived lr corruption without scs?!\n");
> +		break;
> +
> +expected:
> +		pr_info("ok: lr corruption redirected without scs.\n");
> +
> +		/* Verify that SCS is in effect. */
> +		pr_info("Trying to corrupt lr in a function with scs protection ...\n");
> +		lkdtm_scs_set_lr(&&good_scs, &&bad_scs);
> +
> +good_scs:
> +		pr_info("ok: scs takes effect.\n");
> +		break;
> +
> +bad_scs:
> +		pr_err("FAIL: return address rewritten!\n");
> +		pr_expected_config(CONFIG_SHADOW_CALL_STACK);
> +	} while (0);
> +}
