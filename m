Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBA62B2BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 06:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiKPF14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 00:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKPF1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 00:27:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C32CE26;
        Tue, 15 Nov 2022 21:27:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f7so24976737edc.6;
        Tue, 15 Nov 2022 21:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EL5Ik77VRAEzD9VF8LQx7sfi7nDg2jelPrsKNJCLL+w=;
        b=RqhNsWsyWIbumREbXC1ld3MfXuRCA29JmUASFfBcWaqdmwY4y3nFWIuXfVMDhehp2B
         eJJm41n3HlyLpUUcXR3jVpSNXc6uGx5o4D750nMltZk7c/4FJ9QKvuOndZEiLj+h8HYT
         Wg/XUJPU+TW9jnp8KtxHjq5VcGPnoBytrGVrB4F8KF+Djc+8NNzv1ADlVu5b2BG8yPh9
         CbZymV+cUuPPXiiJUFc6s/UgNiutOumdCZNBeQjyWAuRs1uRprVVTzHOdhoUb46d1sfP
         Gsn4CNBMKVvvNCx+N26Iq9kOx7Cd/u2K3+vwLEhsE/UEBLejWe4bt2guvh7UzYReO8vH
         ZClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EL5Ik77VRAEzD9VF8LQx7sfi7nDg2jelPrsKNJCLL+w=;
        b=Y6T0iffOkPbAQip5BjLc1XIArHnhfREOcMIKxNyFYGPh3J1e4OOh+nSy+XMzh/yXoN
         o9+CyIjCDiHcPdrA28nkzRDspMt+o1XEvw/x7ICE8Mva2pFKB9IdaJWH4K96OUJRXGZ9
         t5wmon+ws4lDnOcnecXZIouOQSKn3KHd6Juq0VaeuR7yFHE4x7p19LFERbZ0ZnPOYWgg
         S+Jg+M4sXkutBJW1xpVgghXBKBKRgQtjVehkTD7O4ofq97sl5muTDBe6Qwqj/Ob02fcQ
         csn68WG92SK9CErs6y+bPVHfLxYzyNsRnScQDTj4rcRsFTLhh1PttzmqOqhspNPAH7en
         n2Mg==
X-Gm-Message-State: ANoB5pl6spW5mdIxofQO7j7VuncXqOFOjr+JIabspAdc/8iOhcwhjQAB
        08E/Cn9wlp7Hq2LWHv7GQKk8Qux9wC14GoxoW0lDLcG1
X-Google-Smtp-Source: AA0mqf4NnbypCcm1Gfuhx0RlRyoJFIOGGWYxd3Xbv/kW3haSdw2e66mNiVvPd+5dDm5QhcrTCR79EYdzLbKsOwG09cQ=
X-Received: by 2002:a05:6402:344f:b0:461:d726:438f with SMTP id
 l15-20020a056402344f00b00461d726438fmr17796199edc.333.1668576469950; Tue, 15
 Nov 2022 21:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20221114134720.1057939-1-xukuohai@huawei.com> <20221114134720.1057939-2-xukuohai@huawei.com>
In-Reply-To: <20221114134720.1057939-2-xukuohai@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Nov 2022 21:27:38 -0800
Message-ID: <CAADnVQLEzrqjuF+qYh2kJz0Q=9G8PySJ6ZwXD2EGoZsBUdwsog@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Do not copy spin lock field from user in bpf_selem_alloc
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 5:31 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> bpf_selem_alloc function is used by inode_storage, sk_storage and
> task_storage maps to set map value, for these map types, there may
> be a spin lock in the map value, so if we use memcpy to copy the whole
> map value from user, the spin lock field may be initialized incorrectly.
>
> Since the spin lock field is zeroed by kzalloc, call copy_map_value
> instead of memcpy to skip copying the spin lock field to fix it.
>
> Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")

The tag is wrong. When local storage was introduced it was not
possible to use spin_locks there.
Pls resubmit.
