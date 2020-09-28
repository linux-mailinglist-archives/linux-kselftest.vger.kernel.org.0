Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78927B81A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 01:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgI1X2n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 19:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgI1X2n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 19:28:43 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F2C0613BF
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 15:52:44 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a2so2613099otr.11
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 15:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zjWGaKaB98mjjh0ZLrJCSXNEtOUo09qmy6NjayUDvk=;
        b=SE0OYfnZMo5uyZPc6mgIG21MkoqGNIbmK0jm0vy2aZv5VKA6ku7jwSWs6b1NGUoty/
         wn4UKOoXxTXy903PvYRPnkC+er2m5Wrf3iavraHJxa+QAxqpaiJN2b04VaT2qF2SzrVa
         Hk27i3iLwkmTdLboVB3hrjT8YMf/YNUT+GaDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zjWGaKaB98mjjh0ZLrJCSXNEtOUo09qmy6NjayUDvk=;
        b=p2sWAUi1ux6dEVwCv0nx/CUeUP/dTNbKCZCke33bbB6h7EdGhKvBSDPe45RYw/ZZZm
         6ZDZo4fL+ohfu6zwfPAPKyXv/eqJykay9tmNfJ10QJXx7GdDenA26eyWsUa8nc7uIfpN
         9Lb0wUxaZ6uO0UYxwq4n9ZI0E8P1Fr4a1fvePoE673aTUjJnzq0AH84LSGahtfGKZS8I
         w6T7MXhIwvg0glxcjJcqZPPaM4FhKfp8BBxwl8O2rKrsyyR1nILegGvpf/jA0YhEdUWK
         wr6Qvhcouv49JoLV93NqkCqTcOH8yls3GZ8tFT3LechpJHkHl+ihX1bc61ji98Bs+wQo
         Cy9g==
X-Gm-Message-State: AOAM531IJjnsn3o2dGiyCL/LD35C8Vv02mhvlEnK0bJBbLl5PXLvOjZv
        wZ/IV8r/lx+eWumjzZIE/p94ww==
X-Google-Smtp-Source: ABdhPJxIHmX1phtewwAqu5CcHxH1zl2JXO7LDJyED8CkXQgctT2koxk9D4O4EqsfNA/ONHttUfK08A==
X-Received: by 2002:a05:6830:1e56:: with SMTP id e22mr785307otj.303.1601333563685;
        Mon, 28 Sep 2020 15:52:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g23sm2586552ooh.45.2020.09.28.15.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 15:52:43 -0700 (PDT)
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <202009251650.193E2AD@keescook>
 <7d8f86ab-4333-afa1-6523-e42ae5c7d9b2@linuxfoundation.org>
 <202009260930.9252966D@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <31f28240-a3f1-e730-0b10-024125b1d2ab@linuxfoundation.org>
Date:   Mon, 28 Sep 2020 16:52:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009260930.9252966D@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/20 10:33 AM, Kees Cook wrote:
> On Fri, Sep 25, 2020 at 06:13:37PM -0600, Shuah Khan wrote:
>> On 9/25/20 5:52 PM, Kees Cook wrote:
>>> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>>>> -- Addressed Kees's comments:
>>>>      1. Non-atomic counters renamed to counter_simple32 and counter_simple64
>>>>         to clearly indicate size.
>>>>      2. Added warning for counter_simple* usage and it should be used only
>>>>         when there is no need for atomicity.
>>>>      3. Renamed counter_atomic to counter_atomic32 to clearly indicate size.
>>>>      4. Renamed counter_atomic_long to counter_atomic64 and it now uses
>>>>         atomic64_t ops and indicates size.
>>>>      5. Test updated for the API renames.
>>>>      6. Added helper functions for test results printing
>>>>      7. Verified that the test module compiles in kunit env. and test
>>>>         module can be loaded to run the test.
>>>
>>> Thanks for all of this!
>>>
>>>>      8. Updated Documentation to reflect the intent to make the API
>>>>         restricted so it can never be used to guard object lifetimes
>>>>         and state management. I left _return ops for now, inc_return
>>>>         is necessary for now as per the discussion we had on this topic.
>>>
>>> I still *really* do not want dec_return() to exist. That is asking for
>>> trouble. I'd prefer inc_return() not exist either, but I can live with
>>> it. ;)
>>>
>>

I didn't read this correctly the first time around.

>> Thanks. I am equally concerned about adding anything that can be used to
>> guard object lifetimes. So I will make sure this set won't expand and
>> plan to remove dec_return() if we don't find any usages.
> 
> I would like it much stronger than "if". dec_return() needs to be just
> dec() and read(). It will not be less efficient (since they're both
> inlines), but it _will_ create a case where the atomicity cannot be used
> for ref counting. My point is that anything that _requires_ dec_return()
> (or, frankly, inc_return()) is _not_ "just" a statistical counter. It
> may not be a refcounter, but it relies on the inc/dec atomicity for some
> reason beyond counting in once place and reporting it in another.
> 

I am not thinking about efficiency rather two calls instead of one if
an decrement needs to followed by return. In any case, I agree with you
that there is no need to add dec_return now without any use-cases.

I will update the patch series to remove it.

thanks,
-- Shuah





