Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7682099C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 08:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbgFYGQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 02:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389917AbgFYGQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 02:16:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FA0C0613ED
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 23:16:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p11so2544863pff.11
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZ2PvzdtgciFAabeAtdBsGVo/eCilLMROlNDZwOk8SA=;
        b=Ucdhg60q6WdBMxdYtajQVswDIC1yjf+5xSIQSbbvwAlYDNpC4DfdV6MfEkaDMB3ofY
         vu0pHjlRaeDKqH5RSiWvxNN2Nj7jH08nun3M0ycuD6jJco1lOgIj5xeWCDwM+f70+6Gz
         wKDkM5ZoU8Pvb5goWYdeVnh4aUQvgYnozi/yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZ2PvzdtgciFAabeAtdBsGVo/eCilLMROlNDZwOk8SA=;
        b=KY9ai6VpjG0NsIl+zkX2zcO9smE5210EYjHh1L4Dqw0B8/Mq5XO3nlacGFWRVj07xo
         w+rIkEhzGN/zWhErVM2fByPRHZwWA3xXuwinlyAABg4m7Oxv6kbfmc9gr3YWe6ixjSjy
         s3iGtaMjDWKDg31BWaFXRXNSOMz/kY0L35wPgJh3swRD+fMdjGJOgQ9sc7DHcQLRkYqL
         zdgq/0ZZuPToIr7wfme8zLVUn5h2YLaQfcaYGXf0jOt9AFSoEn1It995SQo0yVycL06Y
         CgoDsvdTofbL0wLObAfnqvw5eWpeiiMbFvYySmWl/clyihM2Mc7b61LWmtuQBhcyFwmx
         3Uqw==
X-Gm-Message-State: AOAM531s43cphhA3yZez4QthmvKOr/oAzvNjdE1sdusoOhkA5Tf/PSrP
        nVTBT2+wLpaYzXNmSzLvQz8T7g==
X-Google-Smtp-Source: ABdhPJzOvRfNxHTxxVh/1x6g3vmqLvkHpgMIs7fv/bdMPlaUfZ5S/hQSdnKWRpmQm9oBxjyvFKmpoA==
X-Received: by 2002:a65:4507:: with SMTP id n7mr3683600pgq.180.1593065765208;
        Wed, 24 Jun 2020 23:16:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y69sm22946845pfg.207.2020.06.24.23.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:16:04 -0700 (PDT)
Date:   Wed, 24 Jun 2020 23:16:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
Message-ID: <202006242312.8888AAFE@keescook>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 22, 2020 at 02:21:38PM +0530, Naresh Kamboju wrote:
> On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >  # Record and dump the results
> > -dmesg -c >"$LOG"
> > +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> 
> We are facing problems with the diff `=%>` part of the option.
> This report is from the OpenEmbedded environment.
> We have the same problem from livepatch_testcases.

Does "comm" exists in those environments?

dmesg | comm -13 "$DMESG" - > "$LOG" || true

this is even shorter than the diff command line. :)

-- 
Kees Cook
