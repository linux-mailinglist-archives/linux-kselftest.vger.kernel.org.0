Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE94D6EFD09
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 00:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbjDZWH0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZWHZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 18:07:25 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A02708
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 15:07:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2472a3bfd23so5318299a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Apr 2023 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682546834; x=1685138834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6o3HhDAjNO89E3A0MRfU/b89KbqoEVo8Ba34QDXA+YA=;
        b=vOoliF7YSsdLjONkRkZIomxWjUfYe8LKdJb6rEHeLX6RhV38s/FBR4eoLfKYHW7zE3
         IavK6ET/Qqw5poSNg/YQZq3rl6vIwPoyAUWlMwIL/UgLwhldJ2/Nd9O47mnyXXXL9cvc
         sbFEtL3hc7qQh5FF+QVgJ+bj4+U9dfQxRkPyP9jul2D1FVAiTPMHklz+MO3UfFTHw1Xm
         oXIIx8QlKD6IFFHxrWK2XZK4XxjXuoHPzTZ/2hRqfXcOlir58wsKvMi0q4JRPoYFFWOv
         e4yhq3ur0yW91dT8QCcgI0Rp96j+86/T/j+x9r6LdVItESTZ1/6fDdvYKWk3gPn4jiib
         l8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682546834; x=1685138834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o3HhDAjNO89E3A0MRfU/b89KbqoEVo8Ba34QDXA+YA=;
        b=NG3U5hNtPyWk7TkkwrT/hUs/lbi9OvsniQ60D8xFasRzn7CJY11dYLbMbBwcV4qxiW
         aQ7ju/PrH7mpzA2Iju0gBGonjc1N+7fO1tM3RD9b55SZ2PGZKi8/+069suYEAodNhZsO
         82N2ejOGyCHboyuJj8rRL1cxyhU1DM5N+viEMZ3tz7NPnBgbsU8aFNhiXdM/vWYjvaFu
         txAEcubLV6bQlpOsLRwK3NBbYWb56+cFqlApFt1LIPfoUhWQrO1zDeZaThzQtw5TYJQU
         PYupn+DHWYyVJMoe1YWlRioGZR4QFCROrtYwiYFts2CJxPOHbZ1BvrY0yDg63aY7D+sX
         0+rw==
X-Gm-Message-State: AAQBX9eRXoQdneU+geYKw3SwpH1CaQJpx3J1c91W23dHkgj2YzOwxmoo
        33YJUIw5FNAMkma90PJnT+Vzr1m6thX/MSURe5TFqw==
X-Google-Smtp-Source: AKy350bX4vKLe+c9/tywLjSWFK8JD/QrNCXcfXaXMeIppYVuasWMVt/WvZF7gUIFFE4mxooBAPv/W+J2eK4njGwo/b8=
X-Received: by 2002:a17:90a:8589:b0:249:7224:41cb with SMTP id
 m9-20020a17090a858900b00249722441cbmr22904088pjn.31.1682546834469; Wed, 26
 Apr 2023 15:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 26 Apr 2023 15:07:03 -0700
Message-ID: <CA+PiJmTHO3SPM_LvwFYWP+uf_KU4QytBshGzk78CZi8oGJ+rnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>
> It is expected that you build the freshest vmlinux image before
> building selftests, because we generate vmlinux.h from it. In your
> case we generated vmlinux.h from your system-wide
> /sys/kernel/btf/vmlinux BTF information, which doesn't yet have latest
> UAPI enums.
>
I'm still unable to build the selftests. I've got it pointed to a
locally built kernel built using the config/config.x86_64, and have
tried running the vmtest.sh script, and building just the tests via
make. I'm using O= to direct it to the out directory for the kernel
build. I've been hitting various errors when trying this. Confusingly
the error message isn't always the same. Currently from a clean build,
it complains about "linux/atomic.h" not found via #include
"../../../include/linux/filter.h"'s in various files. Other times it's
complained about the various helper functions from bpf_helper_defs.h
being unused.

I'm not sure if I'm invoking the command wrong, or missing
dependencies or something. I got past some earlier issues by updating
clang. Any idea what I'm doing wrong?
