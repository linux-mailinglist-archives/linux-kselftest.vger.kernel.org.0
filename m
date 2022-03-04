Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5D4CD6D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiCDOzT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 09:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbiCDOzS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 09:55:18 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C521B0C4E;
        Fri,  4 Mar 2022 06:54:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0V6CkHJB_1646405664;
Received: from 192.168.193.155(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V6CkHJB_1646405664)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Mar 2022 22:54:25 +0800
Message-ID: <c26c8946-f979-de83-38ff-ab6533b55885@linux.alibaba.com>
Date:   Fri, 4 Mar 2022 06:54:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/2] lkdtm: Add Shadow Call Stack tests
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, linux@roeck-us.net,
        luc.vanoostenryck@gmail.com, elver@google.com,
        mark.rutland@arm.com, masahiroy@kernel.org, ojeda@kernel.org,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        samitolvanen@google.com, shuah@kernel.org, tglx@linutronix.de,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20220303073340.86008-1-ashimida@linux.alibaba.com>
 <20220303074339.86337-1-ashimida@linux.alibaba.com>
 <202203031010.0A492D114@keescook> <202203031105.A1B4CAE6@keescook>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <202203031105.A1B4CAE6@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/3/22 11:09, Kees Cook wrote:
> On Thu, Mar 03, 2022 at 10:42:45AM -0800, Kees Cook wrote:
>> Though, having the IS_ENABLED in there makes me wonder if this test
>> should instead be made _survivable_ on failure. Something like this,
>> completely untested:
>>
>>
>> And we should, actually, be able to make the "set_lr" functions be
>> arch-specific, leaving the test itself arch-agnostic....
> 
> Yeah, as a tested example, this works for x86_64, and based on what you
> had, I'd expect it to work on arm64 too:
> 
> #include <stdio.h>
> 
> static __attribute__((noinline))
> void set_return_addr(unsigned long *expected, unsigned long *addr)
> {
>      /* Use of volatile is to make sure final write isn't seen as a dead store. */
>      unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;
> 
>      /* Make sure we've found the right place on the stack before writing it. */
>      if (*ret_addr == expected)
>          *ret_addr = addr;
> }
> 
> volatile int force_label;
> int main(void)
> {
>      do {
>          /* Keep labels in scope. */
>          if (force_label)
>              goto normal;
>          if (force_label)
>              goto redirected;
> 
>          set_return_addr(&&normal, &&redirected);
> normal:
>          printf("I should be skipped\n");
>          break;

 From the assembly code, it seems that "&&normal" does't always equal
to the address of label "normal" when we use clang with -O2.

> redirected:
>          printf("Redirected\n");
>      } while (0);
>

The address of "&&redirected" may appear in the middle of the assembly
instructions of the printf. If we unconditionally jump to "&&normal",
it may crash directly because x0 is not set correctly.

>      return 0;
> }
> 
> 
> It does _not_ work under Clang, though, which I'm still looking at.
> 

AFAICT, maybe we could specify -O0 optimization to bypass this.


BTW:
Occasionally found, the following code works correctly, but i think
it doesn't solve the issue :)

#include <stdio.h>

static __attribute__((noinline))
void set_return_addr(unsigned long *expected, unsigned long *addr)
{
     /* Use of volatile is to make sure final write isn't seen as a dead store. */
     unsigned long * volatile *ret_addr = (unsigned long **)__builtin_frame_address(0) + 1;

     /* Make sure we've found the right place on the stack before writing it. */
//    if (*ret_addr == expected)
         *ret_addr = addr;
}
volatile int force_label;
int main(void)
{
     do {
         /* Keep labels in scope. */
         if (force_label)
             goto normal;
         if (force_label)
             goto redirected;

         set_return_addr(&&normal, &&redirected);
normal:
         printf("I should be skipped\n");
         break;

redirected:
         printf("Redirected\n");
         printf("\n");				//add a new printf
     } while (0);

     return 0;
}
