Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BBD4748DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhLNRGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 12:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbhLNRGp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 12:06:45 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82973C06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 09:06:45 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso21590850otj.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IemfCDmXWx/SPnnub7QAI6IhttPGClVQvWol1/Vo8hE=;
        b=RfVV6DnVFt1imQzcrX+WIWydNs7BF19SXFkIHEtUg1n/CkWAkas8Z4tcWA0qcqEAPn
         igA5N73E1RtEwHAS6CeM+ooIhpZdT0yw826Tf6CocThL1ho6KQHjWocZkVD7HClqKvNr
         cY6G4qwOvCEaLjAmOvtoU0M4H/VJuFm9HRAa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IemfCDmXWx/SPnnub7QAI6IhttPGClVQvWol1/Vo8hE=;
        b=RF4nvOWIIu78a9WhJ1wrd728SzzIl2vIoIoXRYhfu9voa7HvXu27RPbHOOiKPL9IjC
         kkvSWTG7wBIzkCx32/O3v8QmA3LEz05B9bYz0/IJU7EPYH1dQ7aXDTTnLJRfnGq4lP0V
         UM3m7NFZQGLTkc/DQEdsUQLzFc8Jy1aBofjUlGNUmR81XqBOHlCDxTunOVYdOd87dHIB
         GR3MEGIYfW6UGl8eH0ScBqxWpeUazUsIrglT2VBXY2lWE0dI0uScYtQfns/9uz8gB9+d
         gwnH2VV6Y+3MlRuKbXm/sV25fHBszj6exx4I1TX9ifdZInTvfALOiBw8SOJg5tscDJjH
         LKzg==
X-Gm-Message-State: AOAM531/vc7Lwz29kt+F2U2d9fYXidsYU/XRNeMIRF3GJXYTAHoFzRx+
        ywbdzu+RhdNjGV7NXAXQGQ0c5g==
X-Google-Smtp-Source: ABdhPJzPXw827om0Y5Cd811nXaXL7/9e41CMccQTS2B8fiI1FTev8YKMtcA3PITQyHJiKz1ClqAf8Q==
X-Received: by 2002:a05:6830:1d7c:: with SMTP id l28mr5241205oti.372.1639501604855;
        Tue, 14 Dec 2021 09:06:44 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id bl33sm76949oib.47.2021.12.14.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 09:06:44 -0800 (PST)
Subject: Re: linux-next: manual merge of the xarray tree with the kselftest
 tree
To:     Matthew Wilcox <willy@infradead.org>
Cc:     broonie@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211213222443.474487-1-broonie@kernel.org>
 <1dcd2d43-cf39-3b4c-49b5-138d94f34433@linuxfoundation.org>
 <YbjMLHCRXNMwp4nU@casper.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2ee0bba7-879f-40e2-dd7d-d9b264d4d493@linuxfoundation.org>
Date:   Tue, 14 Dec 2021 10:06:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YbjMLHCRXNMwp4nU@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/14/21 9:54 AM, Matthew Wilcox wrote:
> On Tue, Dec 14, 2021 at 09:39:25AM -0700, Shuah Khan wrote:
>> On 12/13/21 3:24 PM, broonie@kernel.org wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the xarray tree got a conflict in:
>>>
>>>     tools/include/linux/kernel.h
>>>
>>> between commits:
>>>
>>>     d6e6a27d960f9 ("tools: Fix math.h breakage")
>>>     066b34aa5461f ("tools: fix ARRAY_SIZE defines in tools and selftests hdrs")
>>>
>>> from the kselftest and origin trees and commit:
>>>
>>>     f2aa11fd51440 ("tools: Fix math.h breakage")
>>>
>>> from the xarray tree.
> 
> I've dropped that commit from the XArray tree since d6e6a27d960f9
> was essentially f2aa11fd51440 applied to Linus' tree.  The only change
> left in the XArray tree today is a documentation update.
> 
>> Thank you. I will keep track of this when I send pull request.
> 
> As long as what you have merges cleanly against Linus' tree (and I see
> the "conflict" -- __round_mask() is defined adjacent to ARRAY_SIZE()),
> then it'll be fine.  You might want to rebase to a more recent Linus
> tree to get rid of the conflict.
> 

When I applied on rc4 base, I didn't see any problems. This is a minor
one - I can mention this when I send my pull request. Shouldn't be a
problem.

thanks,
-- Shuah
