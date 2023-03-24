Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832A46C8287
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCXQkR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCXQkQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 12:40:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52001B2DD
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 09:40:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn12so10300046edb.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679676013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkqrrrBli7iwioLLpZaqx7X4Cp1aCl3V92ectHxHlRw=;
        b=P8fF38dqC7mw9gR50t3xfU0Ct4Nh3npY6bKtO0d0nGq8Nl8Rv6ETrQVG9oxcsQiDCP
         CHDU/FOdQ20gQdHBZQNU62irjEaj0204Jf2AYW5kuTzmAVqDaXXNkR0/h9D8HhgrPbrL
         yfrespfSxEuMuSQRx27xgZNMt1QigBMmFwVF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkqrrrBli7iwioLLpZaqx7X4Cp1aCl3V92ectHxHlRw=;
        b=eW1CPtrUVOtyNT41R5recmspEfu5gHeKHKh1/hbhwRmBMPN6m99uuccSLgMGBVVgI2
         gC5SA+O/LFb9s5JKgNS71jzJZ8s2QadNx6EHiePt/L6ceHxgfKEpv7aP4dxDh5H/4bOU
         jPjqpyxrxYQ0P038dgM/yMbOGNENqjzIH9rNDsaUduQ/yE8Q0wy/KKYgVYUWuM/KKjKh
         w7vkGKza2ORBHJysta3WiK2bpcPca89v3ttd7ngmSoJ4fCOUNnvodn26CFC8KlkNRBeX
         DaGh8ChtLk+gmdvVhppHI15bjjD65gAWFT2sYsQ9wmRbAzZUZMU2L9JJ7Jwz8ZbwxeBp
         9lJg==
X-Gm-Message-State: AAQBX9cMT8SSQ0jkHAjCI3xWYKMpwxvZmOeENHxiZMuGHLYywbRjpEpp
        wHR3kGBCsL/SKyw9CgAFjdBHfDz22naf1vZfsL79NQ==
X-Google-Smtp-Source: AKy350aT3cFNecNnCj6n8bFeiX10U9mxJee/inMxyha8U0G+bxzSn9tYNSvkXGy+sAnUaZGsFqpiqA==
X-Received: by 2002:a17:906:2f96:b0:932:8cd:1021 with SMTP id w22-20020a1709062f9600b0093208cd1021mr3136037eji.33.1679676013066;
        Fri, 24 Mar 2023 09:40:13 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b005021d17d896sm1562074edb.21.2023.03.24.09.40.12
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 09:40:12 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id eh3so10163715edb.11
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 09:40:12 -0700 (PDT)
X-Received: by 2002:a17:906:7846:b0:933:1967:a984 with SMTP id
 p6-20020a170906784600b009331967a984mr1673964ejm.15.1679676012002; Fri, 24 Mar
 2023 09:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230324123626.2177476-1-sashal@kernel.org>
In-Reply-To: <20230324123626.2177476-1-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 09:39:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmKqvUrKx6+N6NzKJuQn0OY2xrDApzHAdJj23ztjzcBw@mail.gmail.com>
Message-ID: <CAHk-=wgmKqvUrKx6+N6NzKJuQn0OY2xrDApzHAdJj23ztjzcBw@mail.gmail.com>
Subject: Re: [PATCH] capability: test_deny_namespace breakage due to
 capability conversion to u64
To:     Sasha Levin <sashal@kernel.org>
Cc:     andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023 at 5:36=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Commit f122a08b197d ("capability: just use a 'u64' instead of a 'u32[2]'
> array") attempts to use BIT_LL() but actually wanted to use BIT_ULL(),
> fix it up to make the test compile and run again.

This got fixed differently by e8c8361cfdbf ("selftests/bpf: Fix
progs/test_deny_namespace.c issues").

I wonder what drugs made me think BIT_LL() was ok. Maybe my wife puts
something in the coffee?

                Linus
