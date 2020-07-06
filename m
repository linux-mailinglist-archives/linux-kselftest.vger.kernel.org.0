Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF22A215FBA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 21:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGFT5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGFT5X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 15:57:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EECC061794
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 12:57:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h1so10409144otq.12
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 12:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NNkS68aIGFVWNR7YnFBQ30+uEJYalVEOdCqtNuMpEVI=;
        b=gBD/5cT2i401HN6B8Xf0dgioJhJUoFa2hqp/mBLMCOxZZdfmjI7U+27ntRFx9CsWnS
         3QfkIj0dwEbb37umw1r1PJaBabSFfSI4YVaq64bFKm8pj5jSYBixY6uXJ1sC9zq9Z/8p
         62I52tTPNAgyWSN8b8yLyfx3cq/RAexHBfr5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNkS68aIGFVWNR7YnFBQ30+uEJYalVEOdCqtNuMpEVI=;
        b=Za7x4KELMIYAfANT/oBRdL+JT95zCaUYFfZznRII1crc1o0bV6FHc9EnikNibGmU1c
         uLY5oKsmPLJebDMzkOvhtlpqyDF5/Ok5U5vnAxa6jZTn+5Mvm9KQmFl5Tq5tduyUDBG2
         hf21g/mLF+3kXIWw56Tv0lmwjKzv0aXF53h8HzfYlpwox7oQwRPSPFQ2BWiJHkzLdE8l
         MXtCHSzE4cDcH3QhZCFxSVKW84d1gpfGjGmzcGKiayqS2i5+a9MAHOySsPyM3yY1nJkV
         vs2PtylPl+xxFDi1XNF6RYfTUrwxiakgGuFEFW2GhAOVxtOjAF+t72hXxgfwf2uY9HdD
         SUnA==
X-Gm-Message-State: AOAM530HzhiHSXtmvHaK4k5BZKBIJvid8B8DeYGjVPgqWF0KvaJmxyMc
        bv1lO7mwmRNx379naKFwY27CSg==
X-Google-Smtp-Source: ABdhPJz1hUqPFyeMR4FGnhixYt0cFJ82a6OJplHRat/2wN471E/UNGGbhp2991+h6Bp+8Q62qmoj/A==
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr43441517otn.75.1594065441858;
        Mon, 06 Jul 2020 12:57:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v137sm5293827oia.23.2020.07.06.12.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 12:57:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] selftests/harness: Switch to TAP output
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20200622181651.2795217-1-keescook@chromium.org>
 <202007042245.BCC693126@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <026732c2-5713-eeba-0706-b533ea488db1@linuxfoundation.org>
Date:   Mon, 6 Jul 2020 13:57:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007042245.BCC693126@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/4/20 11:46 PM, Kees Cook wrote:
> On Mon, Jun 22, 2020 at 11:16:43AM -0700, Kees Cook wrote:
>> Hi,
>>
>> v2:
>> - switch harness from XFAIL to SKIP
>> - pass skip reason from test into TAP output
>> - add acks/reviews
>> v1: https://lore.kernel.org/lkml/20200611224028.3275174-1-keescook@chromium.org/
>>
>>
>> I finally got around to converting the kselftest_harness.h API to actually
>> use the kselftest.h API so all the tools using it can actually report
>> TAP correctly. As part of this, there are a bunch of related cleanups,
>> API updates, and additions.
> 
> Friendly ping -- I'd love to get this landed for -next, it makes doing
> seccomp testing much nicer. :)
> 
> Thanks!
> 

I will pull them in today. OSS+ELC set me back with getting ready for
the talks and presenting. July 4th holiday didn't help.

thanks,
-- Shuah
