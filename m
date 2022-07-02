Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA8564062
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 15:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiGBNf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGBNf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 09:35:28 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9085BE02;
        Sat,  2 Jul 2022 06:35:27 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4LZtNv0vDPz9t92;
        Sat,  2 Jul 2022 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1656768927; bh=b0YYarIvu7AkLafwVnN4NzxB+o08jfKmFCn875cMCV8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rwfYQHcp824s1GbQHuHrS9fQ62fXj+ZW36bEXLbq+Q0XmZIeM8WkSFhIyNrgGd28f
         rZnNDtGL+3ZQFgqCoP7t5P3Z7ulhg1scaHIf3eZSZqGCCoXmNWqoHAmWFRLWiNBbWd
         /GIu5wQ1h/3Tp+d0NhR+GjyfSa+m7HTYHcX2D1AY=
X-Riseup-User-ID: C53355DC3029CEC3D37E10752C8803814EB924C735CAB9C4480786814EBAF71E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LZtNr2Wd5z1yTJ;
        Sat,  2 Jul 2022 13:35:24 +0000 (UTC)
Message-ID: <ba474460-6035-90d8-651a-8b1bc60ecea9@riseup.net>
Date:   Sat, 2 Jul 2022 10:35:20 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: Kunit: Fix example with compilation error
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220701181723.349165-1-mairacanal@riseup.net>
 <CABVgOSn0o=b6vPYsrP+rqGaKskVVL0gw11gbsGn6qecPPKQGqA@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <CABVgOSn0o=b6vPYsrP+rqGaKskVVL0gw11gbsGn6qecPPKQGqA@mail.gmail.com>
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

On 7/2/22 01:32, David Gow wrote:
> On Sat, Jul 2, 2022 at 2:17 AM Maíra Canal <mairacanal@riseup.net> wrote:
>>
>> The Parameterized Testing example contains a compilation error, as the
>> signature for the description helper function should be void(*)(struct
>> sha1_test_case *, char *), so the struct should not be const. This is
>> warned by Clang:
>>
>> error: initialization of ‘void (*)(struct sha1_test_case *, char *)’
>> from incompatible pointer type ‘void (*)(const struct sha1_test_case *,
>> char *)’ [-Werror=incompatible-pointer-types]
>>     33 | KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
>>        |                                ^~~~~~~~~~~~
>> ../include/kunit/test.h:1339:70: note: in definition of macro
>> ‘KUNIT_ARRAY_PARAM’
>> 1339 |                         void (*__get_desc)(typeof(__next), char *) = get_desc; \
>>
>> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
>> ---
> 
> Thanks for catching this. The change to the documentation looks good,
> but it may be better to change the array to be:
> const struct cases[] = { ... }

I missed that! Would you rather that I change it on a v2?

Best Regards,
- Maíra Canal

> 
> That matches most of the existing uses of this, such as the mctp test,
> and encourages the use of const in cases (like the example) where it
> makes sense.
> 
> I'm okay with it either way, though: they're both valid.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
>>  Documentation/dev-tools/kunit/usage.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
>> index d62a04255c2e..8e72fb277058 100644
>> --- a/Documentation/dev-tools/kunit/usage.rst
>> +++ b/Documentation/dev-tools/kunit/usage.rst
>> @@ -517,7 +517,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
>>         };
>>
>>         // Need a helper function to generate a name for each test case.
>> -       static void case_to_desc(const struct sha1_test_case *t, char *desc)
>> +       static void case_to_desc(struct sha1_test_case *t, char *desc)
>>         {
>>                 strcpy(desc, t->str);
>>         }
>> --
>> 2.36.1
>>
>> --
