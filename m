Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF73E39B1AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 06:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFDEyj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 00:54:39 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:45693 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDEyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 00:54:39 -0400
Received: by mail-il1-f178.google.com with SMTP id b5so7679603ilc.12;
        Thu, 03 Jun 2021 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1PgbPrY10zYsjifCFzWyh2BDHPVeu66kYt4xk+1XagA=;
        b=BRFT0PFacapa79dgWyqVB1rrB4rCX8Hl4Jvwfuiik4wOdTQbuswOyQd3lyhUtIHA95
         Jx7VbXc53nQfSF789Dj3KP3ekfgafPiF3LXWSR3RHbcAFkouBQ90k57rqEjvpjHNTAml
         exhRmhEabKFIeAi/c0uebCRS9mqbDZgM1m1TG7dSOWQiJKgvTm23JzveZzHLvl8a6Iyy
         GvJ/MtGTO+hTUTlDnvrLkzA9litdS5Nftaz25U1GIB8UCvepDI5ufPYCZcHoKkJjFCSw
         g6t1zdEheCO/Xm7sICGnaUKQhil+VUxwPJpytk3FdvoN+Skb6Vxtu0Q9GN3SBsbh33+G
         QVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1PgbPrY10zYsjifCFzWyh2BDHPVeu66kYt4xk+1XagA=;
        b=WPKG39T1KtPCX8tSiYQ/BupkbvQ1mGkgLr5DPxESgWiCCI41eqKOvo8FNs8HLmuDsp
         lUS+1VK91MaY3afWYqg/m0V1Fv54fqjb9xNPtFgOdbMjkOfSMA/qxVr1H7pTuOeBikxp
         W/R8ELd46e2KPReC/Q/NS1lzeVWmby9FT/KV2g3GGfTVyJw+4giYQgNgu1gcUALZkivg
         +A82fMgWPbjv12w5gVz6a+/e43R5rv74LlsKxwLImnUk/85jDERx6ZEphLs0DZC1Jv1E
         5fu9Jux7aEWPSy5BKQmzga/dqIvqkmI3TF75C7yxWDLvRanRqtT7NNLCp3aUXd0V4KHK
         k6/Q==
X-Gm-Message-State: AOAM533ULToNXVvXw4wqqkopw19caf+RdUebEV+8cLQ2qiWuaS9Kn+v8
        FvmDPknWCrDrp5SWGVxg5vQ=
X-Google-Smtp-Source: ABdhPJy3sgFV/xsccZqhNRUor2dII2d6E1DIQNG12H/xDoszibp8FHPgZBX0ThCCy6cLblI5uHY9AA==
X-Received: by 2002:a05:6e02:10d4:: with SMTP id s20mr2397773ilj.37.1622782303991;
        Thu, 03 Jun 2021 21:51:43 -0700 (PDT)
Received: from ?IPv6:2606:3280:8:e29:2093:3298:f887:8ed6? ([2606:3280:8:e29:2093:3298:f887:8ed6])
        by smtp.googlemail.com with ESMTPSA id s23sm2762345iol.49.2021.06.03.21.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 21:51:43 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, joel@joelfernandes.org,
        malteskarupke@fastmail.fm, linux-api@vger.kernel.org,
        fweimer@redhat.com, libc-alpha@sourceware.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, acme@kernel.org,
        corbet@lwn.net, Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
From:   Zebediah Figura <z.figura12@gmail.com>
Message-ID: <dab34fd2-b494-8686-bcd7-68beeba4f386@gmail.com>
Date:   Thu, 3 Jun 2021 23:51:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210603195924.361327-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/3/21 2:59 PM, André Almeida wrote:
>   ** The wait on multiple problem
> 
>   The use case lies in the Wine implementation of the Windows NT interface
>   WaitMultipleObjects. This Windows API function allows a thread to sleep
>   waiting on the first of a set of event sources (mutexes, timers, signal,
>   console input, etc) to signal.  Considering this is a primitive
>   synchronization operation for Windows applications, being able to quickly
>   signal events on the producer side, and quickly go to sleep on the
>   consumer side is essential for good performance of those running over Wine.
> 

I know this is part of the cover letter, but I really do want to clarify 
that this isn't really accurate. The use case that this is referring to 
is not "the Wine implementation of WaitForMultipleObjects", it is an 
out-of-tree implementation of WaitForMultipleObjects that provides 
improved performance compared to the in-tree implementation.

This is especially salient because:

(1) this out-of-tree implementation is only in a small handful of cases 
any more performant than a different out-of-tree implementation which 
uses eventfd and poll() instead;

(2) these implementations will remain out-of-tree due to compatibility 
and robustness problems;

(3) I believe there is potential for an upstreamable implementation 
which does not rely on futex or futex2.
