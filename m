Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095EC39F800
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhFHNnO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 09:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhFHNnL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 09:43:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066AC061574;
        Tue,  8 Jun 2021 06:41:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r198so28819593lff.11;
        Tue, 08 Jun 2021 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8CP8awcg95oWuVc3U+udiIOQfXQwkD1ELykPoeSDRf0=;
        b=iJPUF2zRKrL8aPbnq6ruVV7uDa2MAPDQ71g9cFK6NodFwJHSxT0o3hecmaPpudVxod
         r8galZFH0J98fnH+ymQDnhT3nnESaD7oxf6oLPHGC1N42ffQeogmS4PKE5oKcvZ77Not
         OmBNYipVRrD2IZcWzBoEgHL+cATFntc0NFLtV5I7Boag5rW+tc0fnvAK5iuTu9miHIff
         ieOVD/5njM7BzHWHQHXNFYwNoVFAOO5joQfIUFXOHvoVMxFwD2tFujpalxMwhd/42O2B
         sFYKNfz1dniBt59rXk9hFauVvFLqlUg8kdoX9Q1hBYgBeHOQclht6iyXAPFgYtBVgD9p
         3yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8CP8awcg95oWuVc3U+udiIOQfXQwkD1ELykPoeSDRf0=;
        b=Fz5Nh3C+X/wjOSca+eZgAtSiNvxEMChl0uBfgNieDK9KX+ztAHc24P/zGVLBFPBuVo
         UdFqYLcNE0TLvj0Y4equj219XY8V/Eub6BCxQgXa77MtXP82SKxt8oNQnkJwUZKz913A
         ZQV2EKtA8qYrNdvYDlRVf/45Le0+KAVz/AGURFcQw1tnI7hXo4lZquK5fb2AIcMVmef+
         OPD8kTeB4kKkdpufeLmkgqMAIRGWG5E/XhE+ums6J4eJKqqorRB2ZPO5+DmFqbgU1lEp
         HpcLvU6Pwh9zcoa3FGlGCvTe8gqf3We8YP8JtqpNlhpr/tCBm2xrDC+vnJsa0whsq7dM
         n8fA==
X-Gm-Message-State: AOAM533/FnvpalD4Yfqyf81d4AV5DUw5cgZ5i0PC0SA0mIZspfg6+Mgl
        dB5xhiNcTQ4bvBdcLHzankM=
X-Google-Smtp-Source: ABdhPJxyRgGCXscqZPEqdY3tizyXXZkHxIfRc0pL2h7PfHdsBirtbLZ3f0h4iLxhxFKq/sAN9wN8SQ==
X-Received: by 2002:ac2:5084:: with SMTP id f4mr15801044lfm.466.1623159669392;
        Tue, 08 Jun 2021 06:41:09 -0700 (PDT)
Received: from [192.168.1.2] (broadband-5-228-51-184.ip.moscow.rt.ru. [5.228.51.184])
        by smtp.gmail.com with ESMTPSA id h4sm494809ljk.4.2021.06.08.06.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:41:08 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
References: <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com> <YL9Q2tKLZP6GKbHW@kroah.com>
 <8fa8b7fd-58ae-9467-138d-4ff4f32f68f7@gmail.com> <YL9kApyE6FbG/hru@kroah.com>
 <3fca0afa-d9db-a176-aad1-ff7db21ba4a2@gmail.com> <YL9wROdz4y/pETA1@kroah.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <edc30790-e29c-723c-50c8-61e258c6508b@gmail.com>
Date:   Tue, 8 Jun 2021 16:41:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL9wROdz4y/pETA1@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/21 4:27 PM, Greg KH wrote:
> On Tue, Jun 08, 2021 at 04:18:42PM +0300, Andrey Semashev wrote:
>> On 6/8/21 3:35 PM, Greg KH wrote:
>>> On Tue, Jun 08, 2021 at 03:06:48PM +0300, Andrey Semashev wrote:
>>>> On 6/8/21 2:13 PM, Greg KH wrote:
>>>
>>>>> So what's keeping the futex2 code from doing all that futex1 does so
>>>>> that the futex1 code can be deleted internally?
>>>>
>>>> I think, André will answer this, but my guess is, as stated above, this is a
>>>> lot of work and time while the intermediate version is already useful.
>>>
>>> useful to who?  I still do not understand what users will be needing
>>> this.  All I can tell is a single userspace program wants to use it, and
>>> that is a fork from the real project it was based on and that the
>>> maintainers have no plan to merge it back.
>>>
>>> So who does need/want this?
>>
>> I mentioned C++ std::atomic and Boost.Atomic before. Those need variable
>> sized futexes.
> 
> And has anyone converted them to use this new api to see if it works
> well or not?
> 
> As was pointed out to me numerous times when I tried to propose
> readfile(), you need a real user that can show and prove it is needed
> before we can take new syscalls, especially complex beasts like this
> one.

André has mentioned that he tested the patch set with patched Wine and 
glibc.

I didn't patch Boost.Atomic or std::atomic, but it doesn't look to be 
problematic. The only difference it would make there is to enable 
futex2-based implementation for multiple atomic sizes and set up flags 
to indicate the futex size, instead of only enabling futex-based 
implementation for 32-bit atomics.
