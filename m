Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2322AE37D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgKJWmQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 17:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbgKJWmP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 17:42:15 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71EC0617A7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 14:42:14 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id g7so104467ilr.12
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7jSf/XzZ4jyQ+1vMaLtMgIwZ1Hd3aE57H+YNIg7Vd6s=;
        b=HmAOZ27e8pHLOZtNt33kCndwJB139JyHCZFOiD/C94/+pWb2KGdTlQCvLFR1HyR9mk
         lFx1ytT/rJSJ7/tpMYshlVQIWUN/TZct4TCzlg9wYsDyPKswhZWrEi9oFiHeYSi0CMuE
         tmbYZnr4Jy0AgOqG0pqnPBmt6xrLd9kKaYRBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7jSf/XzZ4jyQ+1vMaLtMgIwZ1Hd3aE57H+YNIg7Vd6s=;
        b=YUTZ4hBLCzIfIXoxCb9gybEhpo2MJML26xj8wrgAIa1CuFMra00O1lu5SyI6bsgqgg
         O6u12HwNaQoMvVd/erMTFBXCftcfxu1MuqWpquPQ0D5RDOkgvlMx6gkIPUJQnW7R02qv
         WO0mCzxNerTeMj/zUQ3XeV76P6k28SdLLGKk3iK7f74Q4JNyKkxlTS2wyG66rNt0yWSp
         5zSzFzUQjlPmtLsUFvI/txrjrWGs/T5csDt9MXZccWN3GtT04PTjIcH1WR/ry3LxoRoh
         zW2QAFzYgJAoo+Q3hiaMlbGBYUx95ha1wELJAzEvkwVYtlXs2FPtpkmqV48ZtoXdQ99N
         pJGg==
X-Gm-Message-State: AOAM533QUTmXdZf+zzyd9s2X5y+fxJwRjJX6wibBLc08/Zm2Bya+7r4c
        ZKaRGONf183cjBRzmJl15LiXYQ==
X-Google-Smtp-Source: ABdhPJy+/m7HgoPinpwrhFYoHGR3jeRThmYkrgj1Js7jS1hKjj3aF+EFXbp2kYFpSB7gnDlz1TZdJg==
X-Received: by 2002:a92:99ce:: with SMTP id t75mr16441201ilk.257.1605048133972;
        Tue, 10 Nov 2020 14:42:13 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e12sm38652ilq.65.2020.11.10.14.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 14:42:13 -0800 (PST)
Subject: Re: [PATCH 00/13] Introduce seqnum_ops
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <20201110204414.GA204624@rowland.harvard.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c58fde16-4bd1-0e1e-94ce-a15c359f9f91@linuxfoundation.org>
Date:   Tue, 10 Nov 2020 15:42:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201110204414.GA204624@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/10/20 1:44 PM, Alan Stern wrote:
> On Tue, Nov 10, 2020 at 12:53:26PM -0700, Shuah Khan wrote:
>> There are a number of atomic_t usages in the kernel where atomic_t api
>> is used strictly for counting sequence numbers and other statistical
>> counters and not for managing object lifetime.
>>
>> The purpose of these Sequence Number Ops is to clearly differentiate
>> atomic_t counter usages from atomic_t usages that guard object lifetimes,
>> hence prone to overflow and underflow errors.
>>
>> The atomic_t api provides a wide range of atomic operations as a base
>> api to implement atomic counters, bitops, spinlock interfaces. The usages
>> also evolved into being used for resource lifetimes and state management.
>> The refcount_t api was introduced to address resource lifetime problems
>> related to atomic_t wrapping. There is a large overlap between the
>> atomic_t api used for resource lifetimes and just counters, stats, and
>> sequence numbers. It has become difficult to differentiate between the
>> atomic_t usages that should be converted to refcount_t and the ones that
>> can be left alone. Introducing seqnum_ops to wrap the usages that are
>> stats, counters, sequence numbers makes it easier for tools that scan
>> for underflow and overflow on atomic_t usages to detect overflow and
>> underflows to scan just the cases that are prone to errors.
>>
>> Sequence Number api provides interfaces for simple atomic_t counter usages
>> that just count, and don't guard resource lifetimes. The seqnum_ops are
>> built on top of atomic_t api, providing a smaller subset of atomic_t
>> interfaces necessary to support atomic_t usages as simple counters.
>> This api has init/set/inc/dec/read and doesn't support any other atomic_t
>> ops with the intent to restrict the use of these interfaces as simple
>> counting usages.
>>
>> Sequence Numbers wrap around to INT_MIN when it overflows and should not
>> be used to guard resource lifetimes, device usage and open counts that
>> control state changes, and pm states. Overflowing to INT_MIN is consistent
>> with the atomic_t api, which it is built on top of.
> 
> If Sequence Numbers are subject to wraparound then they aren't reliable.
> Given that they aren't reliable, why use atomic instructions at all?
> Why not just use plain regular integers with READ_ONCE and WRITE_ONCE?
> 

You still need atomic update for these numbers. The intent is to provide
atomic api for cases where the variable doesn't guard lifetimes and yet
needs atomic instructions.

Several such usages where atomic_t is used for up counting, also use
upper bounds. It is also an option to switch to seqnum64 to avoid
wrap around in case there is a concern.

thanks,
-- Shuah


