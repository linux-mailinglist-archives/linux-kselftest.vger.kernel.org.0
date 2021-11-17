Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FB4542EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 09:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhKQIu4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 03:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhKQIu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 03:50:56 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2293DC061766
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 00:47:58 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y26so5272748lfa.11
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yJIKBkP/hglrN2GamqzYCPrI09C09Ls8U6CmGp4m+U=;
        b=moB0PXTl70rf/MyP3I0QeYk8t7ub0FlTGV1HzUVW4qwLq9Xj14xVXFtjVrLyw6BZHV
         PTmyfSC619Hw0rOzwl0Gk8aRJOCpTa0zxRrY6sqOBykhpNz3XTKB0B6Z+9CNxkXOfpnG
         TmJYkMRwdSN83eXS1M0KI1XKU441hSMu5dKP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yJIKBkP/hglrN2GamqzYCPrI09C09Ls8U6CmGp4m+U=;
        b=7SMM5cEOiL44hPtmEaT7+eMK5btwwUkGfrktmAGLKC+wHXozfFaDLFM7ujHRnblOun
         Ef4rjDplVvOfnhZMBUPQvSymYzGj26zkG/jrJof03bf0dIdxC8IE9JqWkC86XsYaQ6UP
         AAMTuB5yMNxJHmLfDZ69c0b/A9/CFxvTsW67OUgEp8UmR4f86DiJJfsp1uBryUhkolTr
         9EX0N4NVX5LULo28BArqFlO9D6CRQhDdKgfGIh5CO5hW1rjNh7SSnOnAwf61456dtrsN
         c/ief5pGeURAyLSyK4FN4x+d6kqSUrugVH8tr5Xtpwprj9rsOCYQbxQRLF9mrN/U9Oia
         fy4Q==
X-Gm-Message-State: AOAM531qhSfoUEV6TJZR2ly7FNBh525sCIPGbmA+rcXGirsM13lbE04C
        1n+UZzu8IkKZQE00y2l/WrbePyaHZ5hJEgIrnipGngbREbQ=
X-Google-Smtp-Source: ABdhPJyup6wdQP7lq2iQ9eWNfwCJm2OJVL9q/glWYOp3IJ6/yAujHKV3SscAIeCa4bAYjVrQ+AV3riR5SoORtlHBpM4=
X-Received: by 2002:a05:6512:31d:: with SMTP id t29mr13381740lfp.331.1637138876438;
 Wed, 17 Nov 2021 00:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20211111161452.86864-1-lmb@cloudflare.com> <CAADnVQKWk5VNT9Z_Cy6COO9NMjkUg1p9gYTsPPzH-fi1qCrDiw@mail.gmail.com>
In-Reply-To: <CAADnVQKWk5VNT9Z_Cy6COO9NMjkUg1p9gYTsPPzH-fi1qCrDiw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 17 Nov 2021 08:47:45 +0000
Message-ID: <CACAyw99EhJ8k4f3zeQMf3pRC+L=hQhK=Rb3UwSz19wt9gnMPrA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests: bpf: check map in map pruning
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 13 Nov 2021 at 01:27, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Not sure how you've tested it, but it doesn't work in unpriv:
> $ test_verifier 789
> #789/u map in map state pruning FAIL
> processed 26 insns (limit 1000000) max_states_per_insn 0 total_states
> 2 peak_states 2 mark_read 1
> #789/p map in map state pruning OK

Strange, I have a script that I use for bisecting which uses a minimal
.config + virtue to run a vm, plus I was debugging in gdb at the same
time. I might have missed this, apologies.

I guess vmtest.sh is the canonical way to run tests now?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
