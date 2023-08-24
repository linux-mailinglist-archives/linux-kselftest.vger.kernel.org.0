Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D9787BCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 01:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjHXXHh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 19:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjHXXHe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 19:07:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD311BD8
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 16:07:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so483431e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692918450; x=1693523250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0gAwhqOWZT0diMDK7kLkhF5OyNhIxTRw4Qs38qP1Eo=;
        b=Soeu+ivRN6Fyjs15dnt25q9GyyVqV/LhqdPPPbJ/bLzb5EKpEuNPHHO+Zlya3NWdaU
         6IR9vCEkM2qXT+4JkknTa5kyBQJh6xbdQNtzcBzItAtLwWLUNMTTLEdcnPyH9ANv1Gi3
         DJ+GM4xunJ1O4N56AP0Fz8TFy1ZGxJhSxursc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918450; x=1693523250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0gAwhqOWZT0diMDK7kLkhF5OyNhIxTRw4Qs38qP1Eo=;
        b=kYv57q9d+WH7RS/WuAC6bqqr2YPf+KtLPF19kM9GPdicYf2y5QDgiL9J9GcRlljews
         srPZnmpp+XgnUoOU36GQ7+9K2Ea4yrdO9G6de9wma9VXUF/pQE4IvmIi+7M6DDsHYR9F
         JC+ltuZKuoW5dpfQjlU5DptbBpd6V9oXGHmPLr/Fl+wCnCvzz9HTz/gOtFDjKAujUH4s
         Ge3BGsLOepssnrnNEac6wNDzhIMjf/MUn+iGFLbIWA2pgPJkejSTPEDMkZ/vBllxaav0
         kdTGsvPppP7NP3gfOTgCj5w/nrqLoaQWp1b54s1nn1j+50fqH05CoqGw7cpxemlfxjyx
         p8rQ==
X-Gm-Message-State: AOJu0Yz5DLDiToc5cU5TXW/57q80Bl9HIyvohlmm/rp0Zg/WSzf48e1B
        hs/SLYEjB9nnFGqEzg7o8euRXqLxDRRZLsfVM3OTgoIQ
X-Google-Smtp-Source: AGHT+IFaUuY+cOjFKr+KFJ0VQgU5LHsdbHbjbjbAB/FFvPY2abZBUYrav7Di/H3j6UUEj3XFCuOMKg==
X-Received: by 2002:a05:6512:304d:b0:4fb:be3c:d8b7 with SMTP id b13-20020a056512304d00b004fbbe3cd8b7mr14714190lfb.51.1692918450290;
        Thu, 24 Aug 2023 16:07:30 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f17-20020ac25331000000b00500a14a6659sm47266lfh.51.2023.08.24.16.07.29
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 16:07:29 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b962c226ceso4461101fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Aug 2023 16:07:29 -0700 (PDT)
X-Received: by 2002:a2e:9bcc:0:b0:2bc:bc70:263f with SMTP id
 w12-20020a2e9bcc000000b002bcbc70263fmr9572475ljj.0.1692918449041; Thu, 24 Aug
 2023 16:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
In-Reply-To: <79cb1ec7-08ec-40d2-bbb4-ce40b684f1a4@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Aug 2023 16:07:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
Message-ID: <CAHk-=whn=hcK3E+je=QjJ-b0CYbp2aY6sQBJGjFsX34L7wO+xA@mail.gmail.com>
Subject: Re: [GIT PULL] scftorture changes for v6.4
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 24 Aug 2023 at 15:06, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Once the merge window opens, please pull these scftorture changes:

Heh, hedging your bets a bit?

This email had "for v6.4" in the subject, the CSD-lock one had "for
v6.5", and the RCU one had "for v6.6".

But I'll do them all in the next merge window, never fear.

              Linus
