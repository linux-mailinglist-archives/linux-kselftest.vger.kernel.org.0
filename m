Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFAC77CE33
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjHOOgO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbjHOOf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 10:35:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D3719A6;
        Tue, 15 Aug 2023 07:35:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5234b80e9b6so7461639a12.2;
        Tue, 15 Aug 2023 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692110153; x=1692714953;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ExkU1aXgwbVZAT4/86NsHH+oPTHRo8kokP8esTR6pM=;
        b=T8JfBGRKfRbUqDuTJiwMDTGkrsRIKO5jTVuAqeDt45jhDd+MoPa0r9rX6d+JXB2SLH
         +PdVegksVN7bVdmYt0loLcqvellOQIle4Gh8C4S0uUSTNbGFG/T1RJl2QvLFUj6BVGsi
         fpLg6c77iRfXi/coDfTa7VaY7bVSsXhSeZmxhUS0UEWcVpiUmO2MkQoZFY6YHpkt9Ltv
         XzWstHS/9nWlHwYLdZhEtS2nCeZx3HXivTZv7prynNSMvoL5EfqyMFQJFwL4WjM0xpZm
         N/tnxa2KLrWGXfxKLLIqTwz+bs1lST0+VmoajwsrbVuLtgVk/XpaFyfJZXlHNXb58Qyw
         Cizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110153; x=1692714953;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ExkU1aXgwbVZAT4/86NsHH+oPTHRo8kokP8esTR6pM=;
        b=iLrb6NVavHradzfYV9cbPUdV03q0U14iyiR5YoXPjcZGWczPo7NcDHjg7tE8T3UeHv
         k7kNNzcwt0HzKC2gJCoLbpPaVwX2+Rcu/zRU/gMOwmF/3rVh5K1ZZf60NG0Mwl4ysk8D
         Vveoxik8QYJiGyLv6DgQkF4LhKXxnm4d7rdneeulkxUS2r3Nm0NUBldMR+KRf4KeQmem
         xLJS+Flsc5eRp3qb/5MdRKHBlL6spE1mEZeKiZeSaORiGTmBWMW9yCsXtvwpksAaMJoM
         IpcdDvuzDy1fA+RL/AL90f/s1xHoqiUff4Q/MrYzzMUj1AmqiKVmGvZF06w6XB1cc+EC
         lgGg==
X-Gm-Message-State: AOJu0Yw/Qy1GpeZvuMV+OLBGQB7ouGOF9SraQlfNiJkXhnGe5eyNw+QF
        LdgR6nChaItJ9/Ke9GXNOdvbxIDsIl/csA==
X-Google-Smtp-Source: AGHT+IFsmByXjHI0wnLzrSXkFNHsDb7aGcOCiExsey2xd2N/qfCGkxS21qOBHQU7rf4CmMMPM/mEAg==
X-Received: by 2002:aa7:c612:0:b0:522:20a0:7eb8 with SMTP id h18-20020aa7c612000000b0052220a07eb8mr9909900edq.33.1692110152723;
        Tue, 15 Aug 2023 07:35:52 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c453000000b0052328d4268asm6831254edr.81.2023.08.15.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:35:52 -0700 (PDT)
Message-ID: <841306f0691a7d56be72be0bb3c7472eadcc3367.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop
 bug
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mykolal@fb.com,
        shuah@kernel.org, davem@davemloft.net, dsahern@kernel.org,
        tangyeechou@gmail.com, kernel-patches-bot@fb.com,
        maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Tue, 15 Aug 2023 17:35:50 +0300
In-Reply-To: <43201fd2-dca7-9294-1dea-8460a9e99296@gmail.com>
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
         <20230814134147.70289-2-hffilwlqm@gmail.com>
         <ad3db96c97aea916d555c76069490a176f634ccb.camel@gmail.com>
         <43201fd2-dca7-9294-1dea-8460a9e99296@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2023-08-15 at 11:01 +0800, Leon Hwang wrote:
[...]
> a) Initial value of RAX is in emit_prologue().
> 	if (!ebpf_from_cbpf) {
> 		if (tail_call_reachable && !is_subprog)
> 			/* When it's the entry of the whole
> 			 * tailcall context, zeroing the RAX
> 			 * means init tail_call_cnt.
> 			 */
> 			EMIT2(0x31, 0xC0); /* xor eax, eax */
> 		else
> 			// Keep the same asm layout.
> 			EMIT2(0x66, 0x90); /* nop2 */
> 	}
>    I'd like to add this comment to emit_prologue().

Got it, thank you.


[...]
