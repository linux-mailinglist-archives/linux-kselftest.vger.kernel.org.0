Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348E227EEC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Sep 2020 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgI3QSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgI3QSB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 12:18:01 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B3C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 09:18:01 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z1so645538ooj.3
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY2l/Yt+N6Qm5zwEsafOSNC/Vn5PVtgIOgVEBv2bpzc=;
        b=enqjfInlrBuTD//8bd1nIYeKHK/pBJcmYVk1pRtxQAJfynhwLhsAbwJu/a8NGRTBng
         EPXUmFjbMGVH3UDVYZRS2LyQi7OmXp+RLZbpPOzDU6pdcLQRnsiOtS+sh9A93BUBwh3N
         zkVrB6Q0VSXEBP2FcH4Spiaq8QDmQpIMgkK/VoyLy6G7J4xw3Z8my9GrNyUo6OtP0ouE
         GnIXWKIDIW8mY4gIJqZOW4d7ko3aarGG32xxla4i7ivAhHS3jmDA18ZzjMzvT4K3K4rg
         Eq/XE+0/52E4tDpTOxwoVFRMD0P3+qaSZHWxqD5ivAXZa9gZ9u/syditveIyoiT/pg8j
         J4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY2l/Yt+N6Qm5zwEsafOSNC/Vn5PVtgIOgVEBv2bpzc=;
        b=amInfFoOV3i0c4bfWSi0tEXUfr0+SyM4NywlLYTMSVcTddjYfyexCnssJD9jUI5TbA
         X5xws87X8cJoWkyXNqOOJuuTXGaB2pyrSOOydQCHdxuek0Trt1uxDX26eHGVofFpkjoJ
         eOVN+xExLdum8kPiSV5gCTdLNnPxyJxt5YdFDE3g4kevTqtu0WeBQNgVKbVxchwWj6x7
         QVBf9g+l116O5jPTDuadUpSwwLCoZivM4qd1jsPROlxwE4gdlXyNirkWUaxuHL47LV75
         PAXRYDI0n78NP8Nq/RtiN4QWmmuhw8LbcARHKftKSYPCji58HrtrZhpvnH981feNq4nr
         b5ig==
X-Gm-Message-State: AOAM531HC3jsd+vZl27oxfaRg757ccAEhMjQrSEGoWGPpEvrmVPpa/SI
        h+pCPNfkhgjaUYj/gVJfzDRdtwJJj6UAh4/dqiQfJA==
X-Google-Smtp-Source: ABdhPJwwfh1/zkpRwXrKHRDJQHq/uW5ADaFJO6+Jcorf/fVowmls8HVvF/f/Gsmv2V+j+VYAEwZTs/wmqYcI/M6B+BM=
X-Received: by 2002:a4a:95f1:: with SMTP id p46mr2358703ooi.93.1601482680767;
 Wed, 30 Sep 2020 09:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200928202650.2530280-1-keescook@chromium.org>
In-Reply-To: <20200928202650.2530280-1-keescook@chromium.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Sep 2020 21:47:49 +0530
Message-ID: <CA+G9fYtAWPuL=SEd3=K0WF3xVu6wwx4ETLadASxKKs0dMYbdWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Extract run_kselftest.sh and generate stand-alone
 test list
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 29 Sep 2020 at 01:56, Kees Cook <keescook@chromium.org> wrote:
>
> v2:
> - update documentation
> - include SPDX line in extracted script
> v1: https://lore.kernel.org/linux-kselftest/20200925234527.1885234-1-keescook@chromium.org/
>
>
> Hi!
>
> I really like Hangbin Liu's intent[1] but I think we need to be a little
> more clean about the implementation. This extracts run_kselftest.sh from
> the Makefile so it can actually be changed without embeds, etc. Instead,
> generate the test list into a text file. Everything gets much simpler.
> :)
>
> And in patch 2, I add back Hangbin Liu's new options (with some extra
> added) with knowledge of "collections" (i.e. Makefile TARGETS) and
> subtests. This should work really well with LAVA too, which needs to
> manipulate the lists of tests being run.
>
> Thoughts?

I have tested this patch set on LAVA with full run and it went well.

>
> -Kees
>
> [1] https://lore.kernel.org/lkml/20200914022227.437143-1-liuhangbin@gmail.com/
>
> Kees Cook (3):
>   selftests: Extract run_kselftest.sh and generate stand-alone test list
>   selftests/run_kselftest.sh: Make each test individually selectable
>   doc: dev-tools: kselftest.rst: Update examples and paths
>
>  Documentation/dev-tools/kselftest.rst    | 35 +++++----
>  tools/testing/selftests/Makefile         | 26 ++-----
>  tools/testing/selftests/lib.mk           |  5 +-
>  tools/testing/selftests/run_kselftest.sh | 93 ++++++++++++++++++++++++
>  4 files changed, 124 insertions(+), 35 deletions(-)
>  create mode 100755 tools/testing/selftests/run_kselftest.sh
>
> --
> 2.25.1
>

- Naresh
