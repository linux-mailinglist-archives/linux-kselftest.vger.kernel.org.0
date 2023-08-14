Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25BD77AF3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 03:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHNBrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 21:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjHNBqk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 21:46:40 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4CE63;
        Sun, 13 Aug 2023 18:46:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RPHLd6kLgz4f3lY2;
        Mon, 14 Aug 2023 09:46:33 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDnwqV5h9lkUqyjAg--.38273S2;
        Mon, 14 Aug 2023 09:46:34 +0800 (CST)
Subject: Re: [PATCH] kunit: replace KUNIT_TRIGGER_STATIC_STUB maro with
 KUNIT_STATIC_STUB_REDIRECT
To:     David Gow <davidgow@google.com>
Cc:     brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20230725172051.2142641-1-shikemeng@huaweicloud.com>
 <CABVgOSn_k=TV4Y7pKTw5LY3su6r0TYi_ci95MKw7-wRHA1+MdA@mail.gmail.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <915f6336-fc33-c87e-01ac-a80550abbf61@huaweicloud.com>
Date:   Mon, 14 Aug 2023 09:44:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSn_k=TV4Y7pKTw5LY3su6r0TYi_ci95MKw7-wRHA1+MdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDnwqV5h9lkUqyjAg--.38273S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw48Aw47AF4DArWrAF18Xwb_yoW5Ww1xpa
        93C3WUur1UJFs2kFyIvFW0qr1akws5Jr4Utr13Ww4Sqa13Wr1xKa1DKr1rK3yUW3ykJa90
        vasIvFy5KayDArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



on 8/12/2023 3:48 PM, David Gow wrote:
> On Tue, 25 Jul 2023 at 17:20, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>> We mix up KUNIT_TRIGGER_STATIC_STUB and KUNIT_STATIC_STUB_REDIRECT in
>> static_stub header. Just correct KUNIT_TRIGGER_STATIC_STUB to
>> KUNIT_STATIC_STUB_REDIRECT which is documented.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
> 
> Thanks for catching this!
> 
> Only minor note is that there's a typo in the subject ("maro","macro").
> 
> Fixes: e047c5eaa763 ("kunit: Expose 'static stub' API to redirect functions")
> Reviewed-by: David Gow <davidgow@google.com>
> Thanks for the feedback, I will fix it in next version.
> Cheers,
> -- David
> 
>>  include/kunit/static_stub.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
>> index 9b80150a5d62..85315c80b303 100644
>> --- a/include/kunit/static_stub.h
>> +++ b/include/kunit/static_stub.h
>> @@ -11,7 +11,7 @@
>>  #if !IS_ENABLED(CONFIG_KUNIT)
>>
>>  /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
>> -#define KUNIT_TRIGGER_STATIC_STUB(real_fn_name, args...) do {} while (0)
>> +#define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>>
>>  #else
>>
>> @@ -30,7 +30,7 @@
>>   * This is a function prologue which is used to allow calls to the current
>>   * function to be redirected by a KUnit test. KUnit tests can call
>>   * kunit_activate_static_stub() to pass a replacement function in. The
>> - * replacement function will be called by KUNIT_TRIGGER_STATIC_STUB(), which
>> + * replacement function will be called by KUNIT_STATIC_STUB_REDIRECT(), which
>>   * will then return from the function. If the caller is not in a KUnit context,
>>   * the function will continue execution as normal.
>>   *
>> @@ -87,7 +87,7 @@ void __kunit_activate_static_stub(struct kunit *test,
>>   * When activated, calls to real_fn_addr from within this test (even if called
>>   * indirectly) will instead call replacement_addr. The function pointed to by
>>   * real_fn_addr must begin with the static stub prologue in
>> - * KUNIT_TRIGGER_STATIC_STUB() for this to work. real_fn_addr and
>> + * KUNIT_STATIC_STUB_REDIRECT() for this to work. real_fn_addr and
>>   * replacement_addr must have the same type.
>>   *
>>   * The redirection can be disabled again with kunit_deactivate_static_stub().
>> --
>> 2.30.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230725172051.2142641-1-shikemeng%40huaweicloud.com.

