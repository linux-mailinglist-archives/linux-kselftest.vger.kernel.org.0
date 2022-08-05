Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC958AAA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Aug 2022 14:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiHEMS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 08:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiHEMSZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 08:18:25 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8059928709;
        Fri,  5 Aug 2022 05:18:24 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Lzl4D619vz9rwt;
        Fri,  5 Aug 2022 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659701903; bh=x4KMxTVE17HVu5TEjEC0MsTy0o85wBRihPIa06Wqnpk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=diQYDxzk0nNAXQ207Ib5FkeMqAOz/YYT2h3pv6GQrDZU0bgwcDDodCQANfqIjGPta
         hcvSY7nBo5fZK3gqlip4XMqw6KFDXYojUoDZpnSE7meWScnUBW4eeY60h4lPay0rDB
         GmgZFJIZ6JsPgTOZPkXOLJXr+zi9qnlZug6vAdKk=
X-Riseup-User-ID: 8F1703E09777E2DBB8AB9A0A3D112253BDA56237E670C033CB6579E5EBADACAE
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Lzl474xqXz1yWd;
        Fri,  5 Aug 2022 12:18:15 +0000 (UTC)
Message-ID: <ad483719-24b2-3207-cdcc-f5055d7a8895@riseup.net>
Date:   Fri, 5 Aug 2022 09:18:12 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220803215855.258704-1-mairacanal@riseup.net>
 <CABVgOS=Yq2+uDw_iVK11eqBjEB-BErEr6naYpTswtTvyehAzYw@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <CABVgOS=Yq2+uDw_iVK11eqBjEB-BErEr6naYpTswtTvyehAzYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/5/22 01:44, David Gow wrote:
> On Thu, Aug 4, 2022 at 5:59 AM Maíra Canal <mairacanal@riseup.net> wrote:
>>
>> Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_EQ or
>> KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp function,
>> such as:
>>   KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
>>
>> Although this usage produces correct results for the test cases, if the
>> expectation fails the error message is not very helpful, indicating only the
>> return of the memcmp function.
>>
>> Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
>> KUNIT_EXPECT_MEMNEQ that compare memory blocks until a determined size. In
>> case of expectation failure, those macros print the hex dump of the memory
>> blocks, making it easier to debug test failures for memory blocks.
>>
>> Other than the style changes, this v3 brings alignment to the bytes, making
>> it easier to identify the faulty bytes. So, on the previous version, the
>> output from a failure would be:
>> [14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_format_helper_test.c:248
>> [14:27:42] Expected dst == result->expected, but
>> [14:27:42] dst ==
>> [14:27:42] 33 0a <60> 12 00 a8 00 00 <00> 00 8e 6b <33> 0a 60 12
>> [14:27:42] 00 00 <00> 00 00 a8 <8e> 6b 33 0a 00 00 <00> 00
>> [14:27:42] result->expected ==
>> [14:27:42] 33 0a <61> 12 00 a8 00 00 <01> 00 8e 6b <31> 0a 60 12
>> [14:27:42] 00 00 <01> 00 00 a8 <81> 6b 33 0a 00 00 <01> 00
>>
>> Now, with the alignment, the output is:
>> [14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_format_helper_test.c:248
>> [14:27:42] Expected dst == result->expected, but
>> [14:27:42] dst ==
>> [14:27:42] 33  0a <60> 12  00  a8  00  00 <00> 00  8e  6b <33> 0a  60  12
>> [14:27:42] 00  00 <00> 00  00  a8 <8e> 6b  33  0a  00  00 <00> 00
>> [14:27:42] result->expected ==
>> [14:27:42] 33  0a <61> 12  00  a8  00  00 <01> 00  8e  6b <31> 0a  60  12
>> [14:27:42] 00  00 <01> 00  00  a8 <81> 6b  33  0a  00  00 <01> 00
>>
>> Moreover, on the raw output, there were some indentation problems. Those
>> problems were solved with the use of KUNIT_SUBSUBTEST_INDENT.
>>
>> The first patch of the series introduces the KUNIT_EXPECT_MEMEQ and
>> KUNIT_EXPECT_MEMNEQ. The second patch adds an example of memory block
>> expectations on the kunit-example-test.c. And the last patch replaces the
>> KUNIT_EXPECT_EQ for KUNIT_EXPECT_MEMEQ on the existing occurrences.
>>
>> Best Regards,
>> - Maíra Canal
>>
>> v1 -> v2: https://lore.kernel.org/linux-kselftest/2a0dcd75-5461-5266-2749-808f638f4c50@riseup.net/T/#m402cc72eb01fb3b88d6706cf7d1705fdd51e5da2
>>
>> - Change "determinated" to "specified" (Daniel Latypov).
>> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to make
>> it easier for users to infer the right size unit (Daniel Latypov).
>> - Mark the different bytes on the failure message with a <> (Daniel Latypov).
>> - Replace a constant number of array elements for ARRAY_SIZE() (André Almeida).
>> - Rename "array" and "expected" variables to "array1" and "array2" (Daniel Latypov).
>>
>> v2 -> v3: https://lore.kernel.org/linux-kselftest/20220802212621.420840-1-mairacanal@riseup.net/T/#t
>>
>> - Make the bytes aligned at output.
>> - Add KUNIT_SUBSUBTEST_INDENT to the output for the indentation (Daniel Latypov).
>> - Line up the trailing \ at macros using tabs (Daniel Latypov).
>> - Line up the params to the functions (Daniel Latypov).
>> - Change "Increament" to "Augment" (Daniel Latypov).
>> - Use sizeof() for array sizes (Daniel Latypov).
>>
>> Maíra Canal (3):
>>   kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
>>   kunit: Add KUnit memory block assertions to the example_all_expect_macros_test
>>   kunit: Use KUNIT_EXPECT_MEMEQ macro
>>
>>  .../gpu/drm/tests/drm_format_helper_test.c    |  6 +-
>>  include/kunit/assert.h                        | 34 +++++++++
>>  include/kunit/test.h                          | 76 +++++++++++++++++++
>>  lib/kunit/assert.c                            | 56 ++++++++++++++
>>  lib/kunit/kunit-example-test.c                |  7 ++
>>  net/core/dev_addr_lists_test.c                |  4 +-
>>  6 files changed, 178 insertions(+), 5 deletions(-)
>>
>> --
>> 2.37.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220803215855.258704-1-mairacanal%40riseup.net.
> 
> These patches look pretty good to me overall, but I was unable to
> apply v3 to test -- it looks like the mail client has wrapped some
> lines or something...
> 
> davidgow@slicestar:~/linux-kselftest$ git am
> ./v3_20220803_mairacanal_introduce_kunit_expect_memeq_and_kunit_expect_memneq_macros.mbx
> Applying: kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
> error: corrupt patch at line 24
> Patch failed at 0001 kunit: Introduce KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ macros
> 
> Checkpatch also picks up an issue:
> ERROR: patch seems to be corrupt (line wrapped?)
> #62: FILE: include/kunit/assert.h:255:
>                                    const struct va_format *message,
> 
> v2 applied clearnly, so it seems to be specific to v3.

I'll check this issue and submit a v4. Thank you!

> 
> In general, I like the patches, though. While I think there are a few
> places it'd be slightly suboptimale if it's being used to compare more
> structured data, such as the prospect of comparing padding between
> elements, as well as the output formatting not being ideal. It's
> perfect for the cases where memcmp() otherwise would be used, though.

Do you any take on how to make the output formatting more ideal?

Best Regards,
- Maíra Canal

> 
> Cheers,
> -- David
