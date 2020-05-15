Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7121D5027
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 May 2020 16:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgEOOPG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 May 2020 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbgEOOPG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 May 2020 10:15:06 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FEC061A0C
        for <linux-kselftest@vger.kernel.org>; Fri, 15 May 2020 07:15:06 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so2811855iog.13
        for <linux-kselftest@vger.kernel.org>; Fri, 15 May 2020 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Vc6zetwP6+V6hm8FQe6RbS/l4eRIu3Ah4JCuV/PbuI=;
        b=hKBf3EEFOcPEiSyCVBNCGrUN55mtqZDnXEMs91YKh3J/kddvuN4mGwrT/B/7tryAP7
         lfv2MTggP7Kk/Df4GxkdIkoWXNJZu9PCbBhCd1phg4+1bNFPg+2ZaOPmtMGGmSH20hAD
         3t3icSe2FiR1CKCYpR5WfB3C2PN2/iaZynzlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Vc6zetwP6+V6hm8FQe6RbS/l4eRIu3Ah4JCuV/PbuI=;
        b=liTy9sLdCDAuNfVaP7uZKlPVPJ1FxGapOUUsG1aunyU2Y2cEgR3w3WCXZYFy9CPytw
         5+S0wiJg9jVhIyT7Uu5X7D56yCHhT4DU8l1aqXH3zKxtvJExCqYCzy949PH3WXSRUGco
         EPDEPnHb9jDfynXrw6oqnUQ5IF2gQ31wdOOLjM+joZj+qfgwwGnM03mIdeMqlqbYk4I5
         b3/AqTXRpLzI75HJx+mIJ4PgKFxotDV7aTBzETXZYAVfGAIwr91ISqJpz1yxM1rXz+SN
         o5XIaglH2uhT7ioFHXbCyhTf4KRLMzqjJOYfAwvnA3y84EAel/bloHlGcaHgAKNMduzI
         qlaA==
X-Gm-Message-State: AOAM532NN1Yz8DqgNJ2SGVo7Tb22P++FaMrAS+fmUBrv2UdtrbTkbgrW
        MT09as7lsx1S9Ubz+GtWqGnmgQ==
X-Google-Smtp-Source: ABdhPJxUWoLgEw9pDcP5zoizEWrT9AfP7Dr+SeOivEeaMsHN4oDP8N2KSFbXjeQjNoWaCo0YjWqqLw==
X-Received: by 2002:a05:6638:3af:: with SMTP id z15mr1842637jap.4.1589552105324;
        Fri, 15 May 2020 07:15:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r80sm960355ilk.65.2020.05.15.07.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 07:15:04 -0700 (PDT)
Subject: Re: [PATCH 1/4] selftests: Fix kselftest O=objdir build from
 cluttering top level objdir
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>, shuah@kernel.org
Cc:     mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
 <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
 <7hwo7qijn0.fsf@baylibre.com>
 <ceb910b1-2ab7-b27f-7e53-c445d96cdeb1@linuxfoundation.org>
 <11765b79-f19c-4aea-5c4a-d9ad24e550de@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d9a50dff-f634-f8d0-a25b-7f33ccf46d9f@linuxfoundation.org>
Date:   Fri, 15 May 2020 08:15:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <11765b79-f19c-4aea-5c4a-d9ad24e550de@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/14/20 8:27 PM, Randy Dunlap wrote:
> On 3/11/20 4:31 PM, Shuah Khan wrote:
>> On 3/11/20 4:58 PM, Kevin Hilman wrote:
>>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>>
>>>> make kselftest-all O=objdir builds create generated objects in objdir.
>>>> This clutters the top level directory with kselftest objects. Fix it
>>>> to create sub-directory under objdir for kselftest objects.
>>>>
>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> Only somewhat related to this patch, another problem that wasn't in your
>>> doci is that the current O= support doesn't support relative paths.
>>>
>>
>> Yes I am aware of it and it is in the document as something that will
>> be addressed later.
>>
>> "Note: Relative paths don’t work - supporting relative paths breaks work-flows e.g:
>> powerpc. Explore fix. Compile work-flows. Not planning to support at the moment."
> 

I attempted to fix it once and had to revert the patch. This relative
problem needs to be fixed and being tracked as a bug.

>>
>> I am looking to address build and install issues first.
>>

As I said above, there were higher priority test build and install
failures in cross-build and native build use-cases when I made this
call to prioritize fixing them first. I fixed all the known issues.

As of Linux 5.7-rc5 all of the know issues related test build and
install failures have been fixed.

With tha done, it is time to work on the relative path fix. I have
my reverted patch to start with and get it to work with the
workflows so it doesn't break them.

I also have the following patch you gave me as reference for fixing
the relative path problem:

https://lore.kernel.org/lkml/158351957799.3363.15269768530697526765.stgit@devnote2/

In any case, based on my previous experience fixing this problem,
I plan to take the fix in rc1 to allow enough time to fix any
problems that show up. It will be fixed for sure.

Hope this helps addresses any concerns you may have on whether or
not this problem will be fixed.

thanks,
-- Shuah

