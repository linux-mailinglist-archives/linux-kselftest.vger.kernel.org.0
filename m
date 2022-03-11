Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B714D5855
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 03:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbiCKCri (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 21:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiCKCrh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 21:47:37 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2981A41E9;
        Thu, 10 Mar 2022 18:46:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0V6rDYwB_1646966789;
Received: from 192.168.193.160(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V6rDYwB_1646966789)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 10:46:30 +0800
Message-ID: <fc2fa0a9-eae8-edc4-f86f-b9056d93ee12@linux.alibaba.com>
Date:   Thu, 10 Mar 2022 18:46:29 -0800
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
 <92a767c4-09e1-8783-2581-9848bb72890d@linux.alibaba.com>
 <202203091211.4F00F560@keescook>
From:   Dan Li <ashimida@linux.alibaba.com>
In-Reply-To: <202203091211.4F00F560@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/9/22 12:16, Kees Cook wrote:
> On Mon, Mar 07, 2022 at 07:16:36AM -0800, Dan Li wrote:
>> But currently it still crashes when I try to enable
>> "-mbranch-protection=pac-ret+leaf+bti".
>>
>> Because the address of "&&redirected" is not encrypted under pac,
>> the autiasp check will fail when set_return_addr returns, and
>> eventually cause the function to crash when it returns to "&&redirected"
>> ("&&redirected" as a reserved label always seems to start with a bti j
>> insn).
> 
> Strictly speaking, this is entirely correct. :)
> 
>> For lkdtm, if we're going to handle both cases in one function, maybe
>> it would be better to turn off the -mbranch-protection=pac-ret+leaf+bti
>> and maybe also turn off -O2 options for the function :)
> 
> If we can apply a function attribute to turn off pac for the "does this
> work without protections", that should be sufficient.
> 

Got it, will do in the next version :)

Thanks,
Dan.
