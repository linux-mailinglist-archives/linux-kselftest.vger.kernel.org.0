Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755CD1B9459
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Apr 2020 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgDZVxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Apr 2020 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZVxq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Apr 2020 17:53:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402E5C061A0F;
        Sun, 26 Apr 2020 14:53:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so6214716plr.1;
        Sun, 26 Apr 2020 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H5D1PG6e/lMszq0Rf949EFEkle4oIskhG7vE9vM9dC4=;
        b=gz4u1B/Skr8dsJGByTK2XWhiRHHeIiJZhyUTcQxEMw5oTN+clJwfvrhHWwRaMgDPks
         SMs+QJlwZcv4XoMltJQ/o7qXuTkMuSfpQdq4HxDJBXB1/Brawn81miRiltA44CJozitD
         4/CP/nB3W0TUJfCo2rr6dGLiBAvgxJgcgpsFtrfASPAlOec4eLvqfib9DRtnJAFMUmDU
         JIsUDSHkLXGpVaSiKplTehHcZ+1gNn/HtN1XqWTqzQ53K/4TPUCPgx3OR0moFSueWT16
         epWZKE9C2Q3NooFtA+t+7twpfMYGy3NXlHU/op6j2ucEvcAcjn00qPEOyYTlMZ0JwEwZ
         +oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5D1PG6e/lMszq0Rf949EFEkle4oIskhG7vE9vM9dC4=;
        b=I3lNpitHO6vpe0BYxvrQqKNvXjQQbDEkNtFH8sNLq1mxcJ+AIUDJkBI4KFkQxLWIAo
         iklrekpb6q26WBlkiGh3T+HFfepa85nv7SOgjeW6qQuALVC75CKEr6vi4GJcrD7vgvg3
         K2oTsWCiHAfO+pRBqKseRgy286SVeJWGwIs7pGKp5wWkLfu8hwjGamk8v8u6Ir3O9B7e
         zGcMMggptAC7Y+46YVKqQvAvQNIVx98trWae9pyN/nhK1kvkA5RMgI5BvR7zdQHiC05Y
         6PYbHyp4p6s/psvXaL5ljRWpyuFeks5gzWoqXewIFXdmtmVCcXMQg3u3JhaBHUdwDovd
         63RA==
X-Gm-Message-State: AGi0PuakV54nrAg1mNaUHuo3MsQKu5kHRhT0o6j9tDgTZja0geni1mnY
        iJsXq7CxrgFQaLkoDbD3RA4=
X-Google-Smtp-Source: APiQypLlLPgA6Ou9oUq3eMaI0CVQsG9UrGKGpXBdsliinmBgCNXAyiE4zSfQmRisUhR9LgkPSFMytg==
X-Received: by 2002:a17:90a:6d03:: with SMTP id z3mr20045920pjj.32.1587938024753;
        Sun, 26 Apr 2020 14:53:44 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id 67sm954454pfx.108.2020.04.26.14.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 14:53:44 -0700 (PDT)
Subject: Re: INFO: rcu detected stall in wg_packet_tx_worker
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot <syzbot+0251e883fe39e7a0cb0a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jhs@mojatatu.com,
        =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
        Krzysztof Kozlowski <krzk@kernel.org>, kuba@kernel.org,
        kvalo@codeaurora.org, leon@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, vivien.didelot@gmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>
References: <0000000000005fd19505a4355311@google.com>
 <e40c443e-74aa-bad4-7be8-4cdddfdf3eaf@gmail.com>
 <CAHmME9ov2ae08UTzwKL7enquChzDNxpg4c=ppnJqS2QF6ZAn_Q@mail.gmail.com>
 <f2eb18ea-b32a-4b64-0417-9b5b2df98e33@gmail.com>
 <29bd64f4-5fe0-605e-59cc-1afa199b1141@gmail.com>
 <CAHmME9rR-_KvENZyBrRhYNWD+hVD-FraxPJiofsmuXBh651QXw@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <85e76f66-f807-ad12-df9d-0805b68133fa@gmail.com>
Date:   Sun, 26 Apr 2020 14:53:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHmME9rR-_KvENZyBrRhYNWD+hVD-FraxPJiofsmuXBh651QXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/26/20 1:46 PM, Jason A. Donenfeld wrote:

> 
> Ah, whew, okay. I had just begun instrumenting sfq (the highly
> technical term for "adding printks everywhere") to figure out what's
> going on. Looks like you've got a handle on it, so I'll let you have
> at it.

Yes, syzbot manages to put a zero in q->scaled_quantum

I will send a fix.

> 
> On the brighter side, it seems like Dmitry's and my effort to get full
> coverage of WireGuard has paid off in the sense that tons of packets
> wind up being shoveled through it in one way or another, which is
> good.
> 

Sure !
