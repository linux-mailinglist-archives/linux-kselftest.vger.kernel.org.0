Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91BD531C02
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 22:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiEWSg6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbiEWSf4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 14:35:56 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5EE9D06B
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 11:15:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w130so18822679oig.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zzofvizuF8zNiK4IN4+SAjhbde0gMJTVr1Nmbjv6AbQ=;
        b=XLOC+ypgI8cKaE9CDgVvdF8PKbjyzLSoTo3x9MsYzQL2PZAqHEzHlGHIxhtbdbp0mH
         +huFu7/Vq3CUekJB3lNHifVzr+zBFnIkd/aQ3BCB9TjQlOeuB9BzvB4CREai2swuV9BV
         Pizs3aRQMv+PwgitC0E2zF3arst/BqNQvGz8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zzofvizuF8zNiK4IN4+SAjhbde0gMJTVr1Nmbjv6AbQ=;
        b=CI6vVIKh+CFHfORbi0E8TlBfzvpsSKQmetwldTlwCA0A4mnElqll4waDmXKgbcH1TF
         6Up1/9mUObHFyqtAWvl+lFt0e6E2H06AzcoUWtTGIJNuMjp1BQa4MphPaNR44CDZ4L+4
         eny5S5KThoRUbpETGSqKT466Nq0Zb89ON4stEs4D+7aUK9RjzGk7/P8FNholL427qS2T
         axAi2jtjv7MthKQ8yJ7x02BaaI92OMiEJ+nkzF9boVWVYpbZoHufUe3ji6qbJ4k1DHZp
         fFQn+V2uFWFNETopsHic0QAEFPYrKSjwRCckhOCvFkvhsY7dkQTSweWNUXZIsIucXjkh
         wCRw==
X-Gm-Message-State: AOAM530qAIkOk1MLEL99AHSWl8Di80qfTycNAP9M7KpBwZUvVRsVBa/2
        gooVEy92aOYJvQyD6hT/EnxQYg==
X-Google-Smtp-Source: ABdhPJxDOIhMiU07IFlHUIqUQmUxxDSxZUqXiGUN1FyXxfn5p8WiK+DycZ7bCA0CEw1YNOoiiJbylw==
X-Received: by 2002:a05:6808:ec7:b0:322:2bcc:42c2 with SMTP id q7-20020a0568080ec700b003222bcc42c2mr176401oiv.168.1653329644614;
        Mon, 23 May 2022 11:14:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g6-20020aca3906000000b00325cda1ffb5sm4294539oia.52.2022.05.23.11.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:14:04 -0700 (PDT)
Subject: Re: [PATCH v7 04/25] kunit: take `kunit_assert` as `const`
To:     Daniel Latypov <dlatypov@google.com>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
 <20220523020209.11810-5-ojeda@kernel.org>
 <CAGS_qxrW+GpDpD7-jxyGaPtQUzBGTdR7N=_7FRR0KdoJCshAAA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <23e4e7b4-bd09-b186-093b-a436ee9cb649@linuxfoundation.org>
Date:   Mon, 23 May 2022 12:14:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAGS_qxrW+GpDpD7-jxyGaPtQUzBGTdR7N=_7FRR0KdoJCshAAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/23/22 11:15 AM, Daniel Latypov wrote:
> On Sun, May 22, 2022 at 7:03 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>>
>> The `kunit_do_failed_assertion` function passes its
>> `struct kunit_assert` argument to `kunit_fail`. This one,
>> in turn, calls its `format` field passing the assert again
>> as a `const` pointer.
>>
>> Therefore, the whole chain may be made `const`.
>>
>> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> ---
>> This is a prerequisite patch, independently submitted at:
>>
>>      https://lore.kernel.org/lkml/20220502093625.GA23225@kernel.org/
> 
> FYI, we'd asked Shuah to pick this patch up in her "kunit" branch.
> It's applied here:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=7466886b400b1904ce30fa311904849e314a2cf4
> 
> It had previously seemed unclear if this series could make it for the
> 5.19 merge window (but it now looks like there's interest in trying it
> out early on).
> 
> Daniel
> 

I am just about send pull request with this patch included.

thanks,
-- Shuah
