Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557EC1B93F9
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Apr 2020 22:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgDZUil (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Apr 2020 16:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgDZUil (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Apr 2020 16:38:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE101C061A0F;
        Sun, 26 Apr 2020 13:38:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so6526058pjh.2;
        Sun, 26 Apr 2020 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kbRv8UzLuFtGFucHws4IrZZDTtkFlPyYccFbWf0LVl0=;
        b=R1goljTcvKUWE/3XNGp8izyowRxLIwVMhVaDsfui2Kt+zNiYBcvGaBeOntb33KuS/c
         7MkOrpzTHefTELc3eZ7rmrMPlzRZX/TXwEJbXC9R+wv+XwCGMm2LKiMGEKf46ODvvacZ
         D6lAVNzYNJzslPWAUYLnpz0mMMJFgCKOqcWy6bMN7f0ieiH9cCeOhpu39FscPm0jB2MN
         U5gj1ullq/BF67Fzuvto+A1A9uT2qU7/ZWFszdRcExvBckBw+1gNx5HtqFYgBFqD855k
         ktd1V6zHUxdYAEiDDhQpm2LPiLEODaxZr+Riyn9DrN4NkQqDLVKoCFeVSd5IMjDiw/nm
         zR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kbRv8UzLuFtGFucHws4IrZZDTtkFlPyYccFbWf0LVl0=;
        b=G5Ub1Q5U8GoBqaDJsO6ssldRiyYYrfwkNhoku3zxk86oTEPldeDrd+EGAtQ4clmSBh
         wugTVKMmfXqRAVXwW2EVldO3yZYySc6QzbF5Mq0ABy5nwbo/HETDoe/fqVfWpAW10/NR
         4J1YmbuypJXg5ooJ8ywGcuwfIFKmpa/W/PdZ5ETu/wu5qcEd07jaLABvIxAd5iyrMIFM
         tpMyMFeOeL27H9EM61PhurYboSW4+pPOFJ5A3lCfZ9BEu4Oe3YBWVtt0XdVkkO013yvZ
         1yBlRVLLTiSghhLygRwE7UWG6tKhjC4U3erw5FwRXkL3NAmM95Scc6wcwKCGKNjgFmiU
         TLPQ==
X-Gm-Message-State: AGi0PuZaqyNlu8+dBIZx8S7yp5FsJc0C+wszIEC0bkDFIUAZj1fP9TSe
        okVe+zaWWcy7WJCT5ISkElT00ovi
X-Google-Smtp-Source: APiQypJz+46iiPUO85VDjW/7lyHhGc/s8pNYXirS/h1Hr4fqDD49YGRwsEhTqrgwF5lfsXv/4w7Wwg==
X-Received: by 2002:a17:90a:3086:: with SMTP id h6mr20338000pjb.49.1587933520184;
        Sun, 26 Apr 2020 13:38:40 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id c15sm10554263pfo.188.2020.04.26.13.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 13:38:39 -0700 (PDT)
Subject: Re: INFO: rcu detected stall in wg_packet_tx_worker
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <29bd64f4-5fe0-605e-59cc-1afa199b1141@gmail.com>
Date:   Sun, 26 Apr 2020 13:38:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f2eb18ea-b32a-4b64-0417-9b5b2df98e33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/26/20 1:26 PM, Eric Dumazet wrote:
> 
> 
> On 4/26/20 12:42 PM, Jason A. Donenfeld wrote:
>> On Sun, Apr 26, 2020 at 1:40 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>
>>>
>>>
>>> On 4/26/20 10:57 AM, syzbot wrote:
>>>> syzbot has bisected this bug to:
>>>>
>>>> commit e7096c131e5161fa3b8e52a650d7719d2857adfd
>>>> Author: Jason A. Donenfeld <Jason@zx2c4.com>
>>>> Date:   Sun Dec 8 23:27:34 2019 +0000
>>>>
>>>>     net: WireGuard secure network tunnel
>>>>
>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15258fcfe00000
>>>> start commit:   b2768df2 Merge branch 'for-linus' of git://git.kernel.org/..
>>>> git tree:       upstream
>>>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=17258fcfe00000
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13258fcfe00000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b7a70e992f2f9b68
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=0251e883fe39e7a0cb0a
>>>> userspace arch: i386
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f5f47fe00000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e8efb4100000
>>>>
>>>> Reported-by: syzbot+0251e883fe39e7a0cb0a@syzkaller.appspotmail.com
>>>> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
>>>>
>>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>>>
>>>
>>> I have not looked at the repro closely, but WireGuard has some workers
>>> that might loop forever, cond_resched() might help a bit.
>>
>> I'm working on this right now. Having a bit difficult of a time
>> getting it to reproduce locally...
>>
>> The reports show the stall happening always at:
>>
>> static struct sk_buff *
>> sfq_dequeue(struct Qdisc *sch)
>> {
>>        struct sfq_sched_data *q = qdisc_priv(sch);
>>        struct sk_buff *skb;
>>        sfq_index a, next_a;
>>        struct sfq_slot *slot;
>>
>>        /* No active slots */
>>        if (q->tail == NULL)
>>                return NULL;
>>
>> next_slot:
>>        a = q->tail->next;
>>        slot = &q->slots[a];
>>
>> Which is kind of interesting, because it's not like that should block
>> or anything, unless there's some kasan faulting happening.
>>
> 
> I am not really sure WireGuard is involved, the repro does not rely on it anyway.
> 

Yes, do not spend too much time on this.

syzbot found its way into crazy qdisc settings these last days.

( I sent a patch yesterday for choke qdisc, it seems similar checks are needed in sfq )

