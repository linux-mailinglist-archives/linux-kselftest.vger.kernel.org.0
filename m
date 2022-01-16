Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001E348FF7C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jan 2022 23:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiAPWng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jan 2022 17:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiAPWne (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jan 2022 17:43:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92847C061574;
        Sun, 16 Jan 2022 14:43:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l16so9322552pjl.4;
        Sun, 16 Jan 2022 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qxaCOg29rQig+k7TbIaF8rqp/hw2U2TG7m8oYMGqZdw=;
        b=RAQI+lc4nbJE5yhT3oTmlOtbYV9cnzACTticImr2nRnWYxNX974OQ3u1/o8yTlW2cT
         6Q2msj3Ov76NkshPLkQf4mhNO46ERERlFmoImei0XdbTNx5JPiYNU+SgnGsXPkcsNaPr
         XC509Jr4ERc9x45+RAQDcx1NsgURp8KlzbjoEv4Sqt7gU6/T+vSsUaw/kl206ZnAlADq
         eFF7WFkWPXNaYm4FW/gJHp9HjxvYid6mfmaLJANWyRtkKwSG8epnHBLnbCPGikZwov8d
         pUC3WmORyVQi8G8qIPnwJyVzKF9O3tE39N6mB7ftTINMDncvVw5H+30bIHblly6bREOR
         DREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qxaCOg29rQig+k7TbIaF8rqp/hw2U2TG7m8oYMGqZdw=;
        b=cXZljPRaSEAZKp6hoqvr2rZ/B/c7DRuL6ewzW4X+klVHhlpY8OqZ5zzGSUBuqKOF1m
         3EGoQ6/hek9stzjinMH1DqmO/H415+WpHMZYvW78fclOBur9H7QyYj+O5T4Z87dd9MnM
         mW/N3BV966q6SXcfDVjHbwdCTEbST34ygqFhEd/cHZQCt91NpurZXaCaqoKXGs01aGVy
         JAHdg96awqwb/URtCaR0p2p8bY3lAl8YEb9HWT9NjqCmF037cqdrymPttgo44qlVRm0A
         gB+LWhuHXROGhl6aoOXw7enyUoRboyNLHB+j9raPMpEpyDLfxcZzjaohHVEbfl8dQYae
         7Zxg==
X-Gm-Message-State: AOAM531rRLhzzFT8F0VcXFt9Di4Zz/kZeT7BZ6R0GJqIt7iH6nLWqtcz
        PfiN2NKJRgC7ADUh9emJZzI=
X-Google-Smtp-Source: ABdhPJxcaFzRez1zN7/qA99CPz/hmFzLnmhz3HtAHzR7jTPoxAk7qydpzl8yhZpb44yM2a6SDiHchw==
X-Received: by 2002:a17:902:da8a:b0:14a:92fc:1037 with SMTP id j10-20020a170902da8a00b0014a92fc1037mr11498609plx.13.1642373013912;
        Sun, 16 Jan 2022 14:43:33 -0800 (PST)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id k10sm11272242pfi.52.2022.01.16.14.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 14:43:33 -0800 (PST)
Message-ID: <070044a5-5468-1095-334f-67cf98eb30b3@gmail.com>
Date:   Sun, 16 Jan 2022 14:43:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 2/2] selftests: tpm: add async space test with
 noneexisting handle
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220116012627.2031-1-tstruk@gmail.com>
 <20220116012627.2031-2-tstruk@gmail.com> <YeQs7Fy5NaK6m6Ar@iki.fi>
 <YeR6Z9a4Z3Xz79Tp@iki.fi>
From:   Tadeusz Struk <tstruk@gmail.com>
In-Reply-To: <YeR6Z9a4Z3Xz79Tp@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/16/22 12:04, Jarkko Sakkinen wrote:
> $ b4 am20220116012627.2031-2-tstruk@gmail.com
> Looking uphttps://lore.kernel.org/r/20220116012627.2031-2-tstruk%40gmail.com
> Grabbing thread from lore.kernel.org/all/20220116012627.2031-2-tstruk%40gmail.com/t.mbox.gz
> Analyzing 4 messages in the thread
> Will use the latest revision: v4
> You can pick other revisions using the -vN flag
> Checking attestation on all messages, may take a moment...
> ---
>    ✓ [PATCH v4 1/2] tpm: Fix error handling in async work
>      ✓ Signed: DKIM/gmail.com
>      + Reviewed-by: Jarkko Sakkinen<jarkko@kernel.org>  (✓ DKIM/kernel.org)
>    ERROR: missing [2/2]!
> ---
> Total patches: 1
> ---
> WARNING: Thread incomplete!
>   Link:https://lore.kernel.org/r/20220116012627.2031-1-tstruk@gmail.com
>   Base: applies clean to current tree
>         git am ./v4_20220115_tstruk_tpm_fix_error_handling_in_async_work.mbx
> 
> The patch set is broken. It has patches from two different patch sets.
> 
> I saved the 2nd patch from my email client.

I'm not sure why it doesn't like it. They both are generated with the same
git format-patch command. If you look at the source, the first one is:

Message-Id: <20220116012627.2031-1-tstruk@gmail.com>

and the second is:

Message-Id: <20220116012627.2031-2-tstruk@gmail.com>

and contains:

In-Reply-To: <20220116012627.2031-1-tstruk@gmail.com>
References: <20220116012627.2031-1-tstruk@gmail.com>

Maybe it doesn't like the fact that the first in v4 and the second in v3?
Do you need me to do anything else to get that applied?

--
Thanks,
Tadeusz
