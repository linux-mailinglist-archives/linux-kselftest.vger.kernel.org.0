Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB439F493
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhFHLFr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhFHLFr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 07:05:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53FBC061574;
        Tue,  8 Jun 2021 04:03:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a1so21687938lfr.12;
        Tue, 08 Jun 2021 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbvnIUDlmrsEz7h8hsEn+CaTGHHdDs7PDJp6JoerDy8=;
        b=YVlYGp7EtT824NClgDG3hbnLiRHH4a8GrUF0qmRSNSqA5P7bo1VluGiSOyfx9lyzZ8
         0qRUBMbXgS/EEDmZK1lvMVrQA4x1OdSvwQPrVv2wDizQwJIxlMDx15vrZSRWK4/H4NhA
         izYjmFl79M4SiuGX4SxWSL0cKgc3OYrAaEy0WdnsicUjtq0ZMGPbNUcPEAW73xedwgog
         EOltv+xwTvV/CBDqhQl5KzfeeRvAlVTr6zTxVPRQTuUclXXgsm/cIo5hTYGBRBzQBJbo
         jcpn2EM2RCzETCjZHjtALTv6wSJtBpJGD3tqipHpeH9LkafEIwFlOlSi0PNshiQ3lLiy
         V6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbvnIUDlmrsEz7h8hsEn+CaTGHHdDs7PDJp6JoerDy8=;
        b=nnn1p8tmhjls7efkY4p0ziTCJWVN4EPIECS7dG88P1mucqXCENoojzHpworZyV/UnP
         q7kIpVSnIUzrDilbXZoKOtrOdLPd8aWMOoMAWcqVpH4+cvx2njqF36G57bzOlR1iLqBi
         LHi0eQ3K2OXu4yW1RE6BRV67ILxpGQOL2AD6iab0JQh+VgpzfYa3YKOn7uAa2vOOZ7yy
         fhPxop4CqRpCSM3Mz56uvcIjlsFIc8+VTx8Ql+/1R883Z0epl9wb6rt22Go3SJe4+Chr
         B2zKq6tF9F9aWmCZFocWZ4ZYVkTuSf6nIWgmlxNt+MSDPT1fR1Zwb4g1JPX+UU2U2/5i
         5iuA==
X-Gm-Message-State: AOAM533Sxyej8C8Fq8I3DKdVNz/6JNJ3PNw6/CgB2NcqSZjyEHrjABPc
        Wq/Y7g5byu5mRX2hszOk1KQ=
X-Google-Smtp-Source: ABdhPJxY4clPUf+kJEyTCGanb9QmdPfQfH9en2/Ins7WQwtCUTKyOZIBj5brYMql77/RoBELy+eFOw==
X-Received: by 2002:ac2:43a3:: with SMTP id t3mr3746636lfl.183.1623150233042;
        Tue, 08 Jun 2021 04:03:53 -0700 (PDT)
Received: from [192.168.1.2] (broadband-5-228-51-184.ip.moscow.rt.ru. [5.228.51.184])
        by smtp.gmail.com with ESMTPSA id x8sm1805778lfn.186.2021.06.08.04.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 04:03:52 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Cc:     acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
From:   Andrey Semashev <andrey.semashev@gmail.com>
Message-ID: <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com>
Date:   Tue, 8 Jun 2021 14:03:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623114630.pc8fq7r5y9.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/21 4:25 AM, Nicholas Piggin wrote:
> 
> Are shared pthread mutexes using existing pthread APIs that are today
> implemented okay with futex1 system call a good reason to constrain
> futex2 I wonder? Or do we have an opportunity to make a bigger change
> to the API so it suffers less from non deterministic latency (for
> example)?

If futex2 is not able to cover futex1 use cases then it cannot be viewed 
as a replacement. In the long term this means futex1 cannot be 
deprecated and has to be maintained. My impression was that futex1 was 
basically unmaintainable(*) and futex2 was an evolution of futex1 so 
that users of futex1 could migrate relatively easily and futex1 
eventually removed. Maybe my impression was wrong, but I would like to 
see futex2 as a replacement and extension of futex1, so the latter can 
be deprecated at some point.

In any case, creating a new API should consider requirements of its 
potential users. If futex2 is intended to eventually replace futex1 then 
all current futex1 users are potential users of futex2. If not, then the 
futex2 submission should list its intended users, at least in general 
terms, and their requirements that led to the proposed API design.

(*) I use "unmaintainable" in a broad sense here. It exists and works in 
newer kernel versions and may receive code changes that are necessary to 
keep it working, but maintainers refuse any extensions or modifications 
of the code, mostly because of its complexity.
