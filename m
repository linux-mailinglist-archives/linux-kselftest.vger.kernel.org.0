Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4184AC7F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 18:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiBGRu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 12:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346229AbiBGRkH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 12:40:07 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B5C0401DC;
        Mon,  7 Feb 2022 09:40:06 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id r14so12546428qtt.5;
        Mon, 07 Feb 2022 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YMdzuK8V3/C9b2T18KUrgwOQMbLjUc6+PWb6CGsonzg=;
        b=eLkaZ3fiUCdYM66eWYd36pZQnGRXi5VxJmrmBBq2Sc6JeEGeA3yl09C15rUT7DT9U2
         QYSROcPmfU5oY7BcsffcBm61BtFT52oKfIW/3rZmk8Qm9l/Wb8Ndj0NYADrrLTjhet8B
         JkL0QDAKnocOL4H4mfNydJUbHT0f56Y/l9YIwHEZ30eR22x4sUu+sfko0q9XZ6PhSJK5
         6P+L31ZNWqWwOu3tavPJPRrPSABDCDAIf37UVfEwhZAb4kEn4VvdWq/1ynVA6TIrXRyG
         CRpxkTwTyPoZGS9Dmhk0btquQCLgtKlBaSnNzBS8ABz38wn9jTI8UYdRTfR/dgIypKIf
         8Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YMdzuK8V3/C9b2T18KUrgwOQMbLjUc6+PWb6CGsonzg=;
        b=xigJAXb8ZwEpaZXFT6D7Rl5kGpl3/NjllNaqU+quNg/Gwrd7bR3eOq/HCjeBWKdhqI
         seXJAj4CovZGld2IAY3KNCwkLMtHv5hBCqvfZkDEmT3RBP9f5Xw3cyJc0Tu1u/6GeSaO
         PExPHPLlJUEK5e7j+fd+uhBQ0h/KtW9Pfqa9HzPvPOr4+GAZPesxyUIQZWQAN+LbJDd1
         RvPg0qqiKZMAB3tOGS60WMsX+AcVsX4rbqNFmvjHJ7fCdgTgh+A4l28+TMMJ2ziyfKQY
         4Qlf7VBgMkcrvzH9zyeKXEmxGcU5O0yHs5HFRwJa1X5JZNvG8yyA+zXvVpJ9/fD0zVPQ
         u8oQ==
X-Gm-Message-State: AOAM5339ukzxnbZPfYpkQfXE7ObRDB4Uc8F5XBOXEg2Y5q+9J9IuDUr7
        l8yMEswhISkNbxlGQqDHr1eh9D2DKLU=
X-Google-Smtp-Source: ABdhPJz11JukF9ojSqaNxIlD7Ai3HiqLAlhee48JNgqksmcCrnG4UN7nSD4YwNqFXjON8j21WgKAUQ==
X-Received: by 2002:a05:622a:254:: with SMTP id c20mr412739qtx.407.1644255605200;
        Mon, 07 Feb 2022 09:40:05 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id q15sm5650173qti.41.2022.02.07.09.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 09:40:04 -0800 (PST)
Subject: Re: [PATCH v2 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
To:     "Bird, Tim" <Tim.Bird@sony.com>, Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "rmr167@gmail.com" <rmr167@gmail.com>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kernelci@groups.io" <kernelci@groups.io>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220207162813.3091899-1-frowand.list@gmail.com>
 <e795ad1a-ddb1-f0af-4a74-7c2c6a0a949a@gmail.com>
 <0de1426c-5b5d-9160-cd5c-00185fa516f5@gmail.com>
 <BYAPR13MB2503C78EE66DBC27ECF3FE8AFD2C9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <48b9b944-732d-d187-af39-756d87eedfa9@gmail.com>
Date:   Mon, 7 Feb 2022 11:40:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BYAPR13MB2503C78EE66DBC27ECF3FE8AFD2C9@BYAPR13MB2503.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 11:06 AM, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From: Frank Rowand <frowand.list@gmail.com>
>>
>> On 2/7/22 10:38 AM, Frank Rowand wrote:
>>> On 2/7/22 10:28 AM, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Add the spec version to the title line.
>>>>
>>>> Explain likely source of "Unknown lines".
>>>>
>>>> "Unknown lines" in nested tests are optionally indented.
>>>>
>>>> Add "Unknown lines" items to differences between TAP & KTAP list
>>>>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>
>>> Please do not apply this version (v2).  I was working off the KTAP specification
>>                                                                 ^^^^ TAP
> 
> What???

I was looking at the proposed TAP v14 from:
  branch 'git14' of https://github.com/isaacs/testanything.github.io.git
while David was looking at
  branch 'tap-14-specification' of https://github.com/TestAnything/Specification/

David did not find the line type of "Anything else" in the TAP v14 he was looking
at, but did find it in TAP v13 (tap-version-13-specification.md) which is in
https://github.com/TestAnything/testanything.github.io
so my reference to TAP "Anything else" in the patch remains valid.  The lack
of "Anything else" in the TAP v14 that David was looking at is why I initially
said to not apply this patch (v2).

> 
>>> from a different github repo than I should have been referencing.
>>
>> OK to proceed with this version of the patch.  I was referencing the proposed
>> TAP version 14, which is in a different github repo than the TAP version 13
>> specification.  Everything in this patch is consistent with TAP version 13,
>> as well as the proposed TAP version 14.
> 
> I'm confused by this message.
> Will there be a v3 of the patch, or are you saying to just apply the original v2 of
> this patch?

Sorry for the confusion.  There is no longer a need for v3 of the patch, so it is
ok to apply v2 if it passes review.

> 
> For the original (v2) of the patch, which I believe is 
> https://lore.kernel.org/all/20220207162813.3091899-1-frowand.list@gmail.com/
> 
> you can add a "Reviewed-by" from me.
>  -- Tim
> 

