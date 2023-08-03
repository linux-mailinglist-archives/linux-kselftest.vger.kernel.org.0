Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828576E216
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHCHuW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjHCHtj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:49:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843957D88
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 00:41:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bed101b70so86881066b.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691048428; x=1691653228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhuM9CzT4ZlJPwZeDMHcBHTztrtNOrwoYZyKAu87MfI=;
        b=Gt1VLqufUFWf2WQcUsB4KBU9RnxDcT/soWdf6VOAc47BXdjAlC9AlcRmwowlIbpM3p
         037jIM17/kqAIs1JoEOf/YkKdTel71aaObfnQDbZrE3PCUEvwVRSKV287VlezAmAy+/Z
         Yn5kMW++Mh07/pygTlv6R1Nu0zsO8gLKX7vbBg0e5P0dEKXZma2g7S4+1Df+20b+6eoJ
         iix4B+rK/KxsAnjbmrw+XOXVXoxWqWAGg1n1GkggCS9tn32edH/o2DeHhgipMkliWURI
         NiP9H1rOUBybJ68omHCsLqpIYCaIdHW5Xeay+BcN1Q9HzV50EI7fIs2KUjH4sfzmYziV
         iz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048428; x=1691653228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhuM9CzT4ZlJPwZeDMHcBHTztrtNOrwoYZyKAu87MfI=;
        b=KyJrQG0+Ww/JoyzYEujXaFMfsavfDufqytW/SIvTCFaYqs8FiloU1/HrdoqqOVwDHT
         kuJO3NlEcCz1TdfdqfUcbOanCAgUjl4NFNg9skrVOK5ygeVNFY7GelG73iICncW9X4HY
         I/BWJy++H/h6F8sjwyxFm5fT1CM1QMfbdBl8w2vxg0cmcgdIIfrjJaeDfcG3xTnC4WoP
         p4DVw07Lk9TpEphqnjdCquzTrG8YXxGGfx1QjGSbJPv4QoobJJHdRkGHxDAMlikGuqHU
         z8CHP1EPxppvZMU3oO7HhcgLGM7KzFkzEpInTD5f6qIeAjzeYIJMOh1yjTgdGUYPPhhq
         V39g==
X-Gm-Message-State: ABy/qLbxYNmVJDwImsP6npbJShgdvAi0/+H/wJ9qqEWk739birEHsmcf
        wQqe7Gl4MBRz5zT5fl+BIz0n3g==
X-Google-Smtp-Source: APBJJlFea5mmJfT7Y+q6H05ClFZP3wGJMPemJQNCbFeWGngzqx6vQ8kD0S3ZQXgODLvNRJGdbLty9g==
X-Received: by 2002:a17:906:73d3:b0:997:ea67:cb2f with SMTP id n19-20020a17090673d300b00997ea67cb2fmr6287103ejl.48.1691048428402;
        Thu, 03 Aug 2023 00:40:28 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ace8:eb44:12a0:888? ([2a02:578:8593:1200:ace8:eb44:12a0:888])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b0099bc08862b6sm10256386ejb.171.2023.08.03.00.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 00:40:27 -0700 (PDT)
Message-ID: <3b1eb406-ff56-414d-b143-79b7a3144420@tessares.net>
Date:   Thu, 3 Aug 2023 09:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
Content-Language: en-GB
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>,
        apparmor@lists.ubuntu.com,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <cover.1690624340.git.geliang.tang@suse.com>
 <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
 <20230802021903.GA3070@bogon>
 <CAADnVQJRmXy_iFBsWLTTKBnmwPjSJP+7RLfJwB9GUb=GEFoMwg@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <CAADnVQJRmXy_iFBsWLTTKBnmwPjSJP+7RLfJwB9GUb=GEFoMwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alexei,

On 02/08/2023 04:23, Alexei Starovoitov wrote:
> On Tue, Aug 1, 2023 at 7:19 PM Geliang Tang <geliang.tang@suse.com> wrote:
>>
>> On Mon, Jul 31, 2023 at 05:43:23PM -0700, Alexei Starovoitov wrote:
>>> On Sat, Jul 29, 2023 at 05:57:21PM +0800, Geliang Tang wrote:
>>>>
>>>> The main idea is to add a hook in sys_socket() to change the protocol id
>>>> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
>>>
>>> I still think it's a hack, but its blast radius is nicely contained.
>>> And since I cannot propose any better I'm ok with it.
>>>
>>> Patches 1-2 can be squashed into one.
>>> Just like patches 3-6 as a single patch for selftests.
>>
>> Thanks Alexei. I'll squash patch 1 and patch 2 into one, and squash patch 3
>> and patch 6 into one for selftests. But I prefer to keep patch 4 and patch 5
>> as is, since they were implemented in different times for different purposes.
>> They were merged into MPTCP repo on May 17 for "run MPTCP sched tests in a
>> dedicated ns" [1].
> 
> since they were sent to a different tree than don't send them here.
> git will not like that during the merge window.

Thank you for the suggestion but that's OK to have these patches applied
in BPF tree because on MPTCP side, they have been applied in a "devel"
branch which is rebased on top of -net and net-next everyday. In other
words, we don't use it in pull requests and it is fine to apply these
patches in bpf-next or elsewhere.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
