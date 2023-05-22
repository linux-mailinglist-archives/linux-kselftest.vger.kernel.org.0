Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DBD70C1D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 May 2023 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjEVPDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 May 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjEVPDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 May 2023 11:03:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B9E66
        for <linux-kselftest@vger.kernel.org>; Mon, 22 May 2023 08:02:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-518d6f87a47so3338187a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 May 2023 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684767746; x=1687359746;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fziBUujOdJNTcKGtA3v1WWZ5akyg74yfYnasIYCQmVE=;
        b=HcZv/RpK2iBwC+f4vi/2f3lsrUt9sB5Xp0sQoLPhl6BZvI5rq6oJ5seV6rkxUjltDh
         z+XaHfSk8xydvcuKnU141hRJLQM7v5oFtk8rtn90XKl7u4iiMB5pEMRrYLMu+5S0PfpE
         X/PPbfRycd5kFT7jBcxn5y8lXFWLF+CBJiSwo10DwgBkq2Sq5I89XFdAhba9jCeZoVe9
         jWNxCVIYvpVNF/3zT21bNiJX2X5nhqJtxYfXsAubShMQqVRjg3K5PNAGtD+PV5xM8RT/
         kJ5JLjneNERnVI6oYbBxlQb2J2TTW+g0IKEEB0z7YMKJxtYLO+JP7vJFn1t6oQZNLEji
         MWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684767746; x=1687359746;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fziBUujOdJNTcKGtA3v1WWZ5akyg74yfYnasIYCQmVE=;
        b=SkcbJLejyLvEWYirfNEsdmve+XXV867tXb0yp2en+J/M9AkPnUzYjslVWhrRzjHtrt
         V1/tEGOW2iS1XCac1mY8Y6DvTIGBuWpqdVFRh+5oHO07KdhtrBSrgeK9jorM6p1y2v0k
         BmMXotvwIHND4Sgdd4DeT8g6KYIXdPXYdS5gWam5ufcydsdXlVuv3s06AsFI6a6cWs90
         6KROf5iDJtsEJV8kGgbJjNy9MKoTNGviWbwvN7AKru4HshzGfO7EWKvMmbGDpKz/Vfj2
         xqhpXVtt6vbX9O2s7Z0gp7RF/IMmoTSIGVY/dNY4KjawNI8r/1EMMHu0op5q4lcZOnKL
         OYLA==
X-Gm-Message-State: AC+VfDzSW8BXVjqeOowsz4btscjgOnije9qagpCo9kkh6rxbvitz0nje
        ffTdqPrFh5YRDGNeOUIVxoFp+0JVYRo=
X-Google-Smtp-Source: ACHHUZ5ERPoEbvr+APfX86NeehfWSJRtftrHA1EpWYpuPBCCqx86gSOrtlzcu9bkQmisMJ0L0wFjRF9edFg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6854:0:b0:530:8be8:5ab6 with SMTP id
 q20-20020a656854000000b005308be85ab6mr2513207pgt.8.1684767746328; Mon, 22 May
 2023 08:02:26 -0700 (PDT)
Date:   Mon, 22 May 2023 08:02:24 -0700
In-Reply-To: <CAFg_LQVfECWsmcSXJWnnyJK5mZAbjdCTX-RXP3aoDAECTspqkA@mail.gmail.com>
Mime-Version: 1.0
References: <20230420104622.12504-1-ljrcore@126.com> <CAFg_LQVfECWsmcSXJWnnyJK5mZAbjdCTX-RXP3aoDAECTspqkA@mail.gmail.com>
Message-ID: <ZGuD1LRE4MkKg++D@google.com>
Subject: Re: [PATCH v2 0/7] KVM: selftests: Add tests for pmu event filter
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 22, 2023, Jinrong Liang wrote:
> Jinrong Liang <ljr.kernel@gmail.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8820=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:46=E5=86=99=E9=81=93=EF=BC=9A
> > Jinrong Liang (7):
> >   KVM: selftests: Replace int with uint32_t for nevents
> >   KVM: selftests: Apply create_pmu_event_filter() to fixed ctrs
> >   KVM: selftests: Test unavailable event filters are rejected
> >   KVM: x86/pmu: Add documentation for fixed ctr on PMU filter
> >   KVM: selftests: Check if pmu_event_filter meets expectations on fixed
> >     ctrs
> >   KVM: selftests: Check gp event filters without affecting fixed event
> >     filters
> >   KVM: selftests: Test pmu event filter with incompatible
> >     kvm_pmu_event_filter
> >
> >  Documentation/virt/kvm/api.rst                |  21 ++
> >  .../kvm/x86_64/pmu_event_filter_test.c        | 239 ++++++++++++++++--
> >  2 files changed, 243 insertions(+), 17 deletions(-)
> >
> >
> > base-commit: a25497a280bbd7bbcc08c87ddb2b3909affc8402
> > --
> > 2.31.1
> >
>=20
> Polite ping.

Sorry for the delay, I'm finally getting into review mode for the 6.5 cycle=
.

> Should I post version 3 to fix the problem of two "From: Jinrong Liang
> <cloudliang@tencent.com>"?

No need, that's trivial to fixup when applying (if it even requires fixup).
