Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AB788C6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjHYP0g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjHYP01 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 11:26:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2B2135
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 08:26:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bf75ca4e4fso11531635ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692977184; x=1693581984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uT9B5IhwSieTS/lycgAO9B5cbkxabumJT7OeFCsXGMk=;
        b=vvVTkRT+VuK5043ahLb/u/zj4f8sB0vqgAunodyYuRhNLeufoefzhoe4WNJFWBlqnT
         fOjWSwwVNPHbk3edqUSOVA+XxAEjDCKjxs3HxwUIlookvW4KiCnYLFtt1qTalqSJOVGF
         sScsGhUtVxEoQK15lzMQlLomYBvjcE2Sz4k/e1Oy+HS/9hhEtZcDcaVdaQEeyjXxZh3R
         TzsVUTWd7XZcUj1STnMDvCZ5q8x5tT67ioP2DbuxoS8Xvt4bmsdKfkLeTHrNoo93HISk
         V1NYfBP6/ZvZCCCq3TieE6qyCIY3XWbSHhfJP0iP2R+QQbrK8/8rYTZUS4Q+EnvzC4ai
         inOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977184; x=1693581984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT9B5IhwSieTS/lycgAO9B5cbkxabumJT7OeFCsXGMk=;
        b=RbpLpxREyu7b0wNRA9A9N/WLLylu4omK9MH+CUr+BmsGeds+erp6pO7mwa6C9h869+
         3zX5naz3T8G4RKXbPYP/nRdU3Q4MlvP08UP0nyBWM9OsAlWTbzNZC4N5M8eInopvR2zq
         f0kavKbJfP9XmK9OEO6tlZQMkw5Bvyn56YSt+pQ+7x0lw8SLaEK6JUEi1efhjx289Oiu
         9KHSpQS6i4/tIy3Re61vXgELx+K+RZ5YKhb7LshzPLBjGjSube6pWZB0booFum+/M3X2
         xZqM4ESqA4p/kOjahMdQNmnfc2m9wF9BZyoHUMz9THY0XPF8O1/791OwIbzyo5Rbr1X3
         TnQQ==
X-Gm-Message-State: AOJu0YzhoxMFfgBEmH7n1kw6Ysds7KdkxgdV+zrcEpvIR/pt/xCSDvgu
        ucBxYhmWP858xUuFz/Mv9IyVulerj3U=
X-Google-Smtp-Source: AGHT+IHBe26z5RAiUFUIi9mr/ywY4xvfcSUx9IiaElkVhEpKpN2zZSyFkiUVw2XIEkVi8AWhgt40SvUlcq8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e801:b0:1bc:4452:59c4 with SMTP id
 u1-20020a170902e80100b001bc445259c4mr7073353plg.4.1692977184048; Fri, 25 Aug
 2023 08:26:24 -0700 (PDT)
Date:   Fri, 25 Aug 2023 08:26:22 -0700
In-Reply-To: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
Mime-Version: 1.0
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
Message-ID: <ZOjIHo2A6HZ8K4Qp@google.com>
Subject: Re: [PATCH v2 1/2] selftests: Provide local define of min() and max()
From:   Sean Christopherson <seanjc@google.com>
To:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Cc:     keescook@chromium.org, edumazet@google.com,
        willemdebruijn.kernel@gmail.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 25, 2023, Mahmoud Maatuq wrote:
> to avoid manual calculation of min and max values
> and fix coccinelle warnings such WARNING opportunity for min()/max()
> adding one common definition that could be used in multiple files
> under selftests.
> there are also some defines for min/max scattered locally inside sources
> under selftests.
> this also prepares for cleaning up those redundant defines and include
> kselftest.h instead.
> 
> Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> Suggested-by: David Laight <David.Laight@aculab.com>
> ---
> changes in v2:
> redefine min/max in a more strict way to avoid 
> signedness mismatch and multiple evaluation.
> is_signed_type() moved from selftests/kselftest_harness.h 
> to selftests/kselftest.h.
> ---
>  tools/testing/selftests/kselftest.h         | 24 +++++++++++++++++++++

Heh, reminds me of https://xkcd.com/927.

All of these #defines are available in tools/include/linux/kernel.h, and it's
trivially easy for selftests to add all of tools/include to their include path.
I don't see any reason for the selftests framework to define yet another version,
just fix the individual tests.
