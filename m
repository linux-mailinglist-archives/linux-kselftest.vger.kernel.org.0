Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A505839F7A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhFHNVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 09:21:42 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40600 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhFHNVi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 09:21:38 -0400
Received: by mail-lf1-f44.google.com with SMTP id w33so32070137lfu.7;
        Tue, 08 Jun 2021 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tZorGvclpOPbhfWPZaOjzmooZyvoUCWVkBUywkX8hVE=;
        b=cLdowKF6nDP8aESrogQtYZIP99vozu+I/mrGv+bjQWoL4XeTfzPCyPxxfYcHFoLheU
         ClGPeL2b1yOrtqC38+ICGLUYst1T2ZSjR62PHgjdWVVb6FP9WcJhRu5oZLRdpkrMzi5o
         KzA94JoXvAc+PIk0j6f8R8lmkYZ0CcuRM5JxB4qZzCpgJOpYap39A/LKTnzG3basoQVC
         5joO48T897mkCFrGx6SRJPgdVivp44ADgbApejeAJkKOz3edbc/J4Z52eAjbVgr/UUDq
         TeCsrwSuperGlYQlGd2bxSaJ07NfbyNTOe0Ld/iigTDOLYVde09+NSrAYpJv7W9qAgen
         ZQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tZorGvclpOPbhfWPZaOjzmooZyvoUCWVkBUywkX8hVE=;
        b=KkAURT8QxJ9e4pV2Z0OAqOoa2e22FppsS3EkA0XrCsKAeZkdYi1bIIZBT87ZUoA03F
         6mk8B+7XimTqzCOBce2544D7Qwn73NjoCXX5Ej7RDwCm66w/EbhQHuAB/guyKgl1n0qT
         kvLs8yiPLYIa5BfpzPoSgMscLtlazza5oTWl5iblunhlfWd0AQL6Svn6JWGnIqDfEp5s
         Z5DYazDjsS4Va0V62jmYy5edcAh031wPn+aaS7Krq60o01TeqgjAVAJ+C41J0lAOKyRF
         59kSi8vn31aIhGDwB2Oj0z8zZ0N2VNc1l0H78IGnhufyQvcj8Th3B9UC3MSzTjS16jTd
         j8iA==
X-Gm-Message-State: AOAM532l9pRREK1XukrAa9PGUmuKGPu+bMBDX3TbkdEAREL4CCJ2mmt2
        X5ny6KrcGpbfxOZ5eIWaz8Y=
X-Google-Smtp-Source: ABdhPJwrZLqSS8selXX297l/UST/YtonGUnayP2LjZk04lHR17IUaOnVAsD5CaOitjDBhBs2FLhF9Q==
X-Received: by 2002:ac2:47f7:: with SMTP id b23mr15844488lfp.522.1623158324713;
        Tue, 08 Jun 2021 06:18:44 -0700 (PDT)
Received: from [192.168.1.2] (broadband-5-228-51-184.ip.moscow.rt.ru. [5.228.51.184])
        by smtp.gmail.com with ESMTPSA id t12sm1160270ljk.116.2021.06.08.06.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:18:43 -0700 (PDT)
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
References: <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com> <YL9Q2tKLZP6GKbHW@kroah.com>
 <8fa8b7fd-58ae-9467-138d-4ff4f32f68f7@gmail.com> <YL9kApyE6FbG/hru@kroah.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <3fca0afa-d9db-a176-aad1-ff7db21ba4a2@gmail.com>
Date:   Tue, 8 Jun 2021 16:18:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL9kApyE6FbG/hru@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/21 3:35 PM, Greg KH wrote:
> On Tue, Jun 08, 2021 at 03:06:48PM +0300, Andrey Semashev wrote:
>> On 6/8/21 2:13 PM, Greg KH wrote:
> 
>>> So what's keeping the futex2 code from doing all that futex1 does so
>>> that the futex1 code can be deleted internally?
>>
>> I think, André will answer this, but my guess is, as stated above, this is a
>> lot of work and time while the intermediate version is already useful.
> 
> useful to who?  I still do not understand what users will be needing
> this.  All I can tell is a single userspace program wants to use it, and
> that is a fork from the real project it was based on and that the
> maintainers have no plan to merge it back.
> 
> So who does need/want this?

I mentioned C++ std::atomic and Boost.Atomic before. Those need variable 
sized futexes.

The project you mention is probably Wine and its derivatives. Those need 
variable sized futexes and "wait for multiple" operation. I'm not sure 
about the "no plan to merge it back" part, I probably missed it in an 
earlier discussion. There are multiple different patches and versions 
out there, and I don't know which one it refers to. But WaitOnAddress 
and WaitForMultipleObjects APIs are very important and I would assume 
Wine wants to emulate those with best efficiency.

I have a media processing engine application that needs 64-bit futexes 
would benefit from a "wait for multiple" function. Its source code is 
not open currently, so I'm not sure if you can count it as a valid user.

There is a generic std::lock algorithm in C++ and an equivalent in 
Boost.Thread that is supposed to lock multiple lockables (a mutex-like 
object). Those could benefit from the "wait for multiple" function in 
some cases, e.g. when the objects are actually futex-based mutexes, and 
the function can access the internal futex. I'm not saying this will 
definitely be implemented, it just looks like a possible optimization to me.

I think someone mentioned databases earlier in the discussion, but I 
don't know the details. I hope someone will be able to expand.
