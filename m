Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9BA50E32C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiDYOdH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiDYOdE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 10:33:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF535247
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 07:29:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id be20so10295211edb.12
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=7rrYelrP4QZ6HvzFwdjgT6NJJeIklZpujcadGzr6vYk=;
        b=NUJt+ffd3r42NPZ2AiHobip2CJqto98McXPa+xDzJkMRXlIpAu3qmSPkG2MjjEdyns
         ulTE1HOQDDGnMo3fCI97Zfhclwqu+6Z0PWYSHOyYr9ohoGYcHE3EqaQ/az4inQ7SXUyW
         IhAfUuicHbE0seDUkvDZ02qxNo2ggP1WKzmlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=7rrYelrP4QZ6HvzFwdjgT6NJJeIklZpujcadGzr6vYk=;
        b=FQELry8YKnn4fbk5LTxPJDK1pR73p5nFzBPcAEJT7p10KNBPJO7hNBe0ZMZddcgURW
         BAVdxjMWQ2BpJFbQqlBi0cd+gkjPdKGoYNmSpLDwmu1qxZxS7220MekGZTspafmoBu6r
         5u3uMQtaKwVAKYPpF7zyTG5Z8Gwhu8FNQ3ISYoedodqM9Gu2wAXn38RocoNBHvtCDvYH
         9P8njmkoce3ITGz4bmSQVpb9k+RPKCzKqml1ds32WQmYcogn55ZUxIFWWcqKX6tHhkfo
         Swfn4Z6ZvBHWdzEvTNLROrTBge8nwVuiGvjQlu8pXUBWv4rL6EQIiyxJeFA0NmbNrUYj
         BqvA==
X-Gm-Message-State: AOAM531vHAjyJphI6+agOoCr7KuN/Psl7ljJtMFw6QDhtv+RnCwGHXwF
        fIhX2dOb/eiCIWWj4+3DMyN8HA==
X-Google-Smtp-Source: ABdhPJxzq7pjTESlNW3kdPfJp4OL7kjqilTpw9u6ruuZ+iqj3IQMKrsL+yYyrwlst07BHIJlXJ9b/A==
X-Received: by 2002:a05:6402:2794:b0:424:a76:2b14 with SMTP id b20-20020a056402279400b004240a762b14mr19442698ede.226.1650896997565;
        Mon, 25 Apr 2022 07:29:57 -0700 (PDT)
Received: from cloudflare.com (79.184.126.143.ipv4.supernova.orange.pl. [79.184.126.143])
        by smtp.gmail.com with ESMTPSA id y14-20020a056402440e00b00416046b623csm4972686eda.2.2022.04.25.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:29:57 -0700 (PDT)
References: <20220414162220.1985095-1-xukuohai@huawei.com>
 <20220414162220.1985095-5-xukuohai@huawei.com>
 <87levxfj32.fsf@cloudflare.com>
 <13cd161b-43a2-ce66-6a27-6662fc36e063@huawei.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Shuah Khan <shuah@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Collingbourne <pcc@google.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steven Price <steven.price@arm.com>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Delyan Kratunov <delyank@fb.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2 4/6] bpf, arm64: Impelment
 bpf_arch_text_poke() for arm64
Date:   Mon, 25 Apr 2022 16:26:39 +0200
In-reply-to: <13cd161b-43a2-ce66-6a27-6662fc36e063@huawei.com>
Message-ID: <87pml56xsr.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 24, 2022 at 01:05 PM +08, Xu Kuohai wrote:
> Thanks for your testing and suggestion! I added bpf2bpf poking to this
> series and rebased it to [2] a few days ago, so there are some conflicts
> with the bpf-next branch. I'll rebase it to bpf-next and send v3.
>
> [2] https://lore.kernel.org/bpf/20220416042940.656344-1-kuifeng@fb.com/

Looking forward to it.

I think it would be okay to post v3 saying that it depends on the
"Attach a cookie to a tracing program" series and won't apply cleanly to
bpf-next with out.

It would give us more time to review.
