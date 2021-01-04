Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C632B2E97FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jan 2021 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbhADPBV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jan 2021 10:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhADPBV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jan 2021 10:01:21 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D58C061795;
        Mon,  4 Jan 2021 07:00:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 30so14504385pgr.6;
        Mon, 04 Jan 2021 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P/UOf32XQtDWqi9saPG9839isG2jm3RedZf8gZrS4lI=;
        b=q5eygYTooqfGlr45SVlSuNSbmbGaN+SGy3mCJx8RhX7ei8NAcDrOVBscXnRiOW7Bxv
         d+Vvt5n/3jVoaCVNkR41B6GE6NBHlJELQYusuCIkqwqWvF4y8TCgevP5CBeQyohWqvB0
         5pAf5NFjfkg3ESqIg7YdV5/FElsiFOpunYXfsnNiJr62Wix4TjgmNe/WXEeSyQfQe7TA
         hQaegxL8KAEcM7Uq6eB7WfxRFDp856Y9BEGU2ASIO6ISq3DdGF+dDuwb2ywf51akQslp
         RhDDF6Q8nLCXyPeEi8U8Q1IRzreKN5Gn7WUSDY+3cJP34cNNBjC4ltXa9OKz7SvHrLLV
         siMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P/UOf32XQtDWqi9saPG9839isG2jm3RedZf8gZrS4lI=;
        b=RMIIoX7ro53qQJOM5QEJZNzs8iAuOudjKBGxP4tAES1eh3YxsnUdE7bvfHKBrr2OJL
         kbMdyCtjYEhU0qfK0q2Wa97Wc8pAE/3bgC6fJuayxiB5psgadYNR/sSUz+1Xyy+/tXEs
         MfEd35fr1gybrjmjgmvwk90FHFru+1lrJlcsoNShNmKMMpCrkdSLBFIJtMnW3tIsbfJT
         bB0ssHe1Or2kBEdQg6sonAaRLPxpRdw5ByRFrIjnt+S2FGuxCfLHmkjeH/lF9bm/yxAF
         FBse9yJNFhM83j9GKP5ZaDMv5Nz7nVJc3Vh949SPb+m4sizPN/PsM5oZxrI+89O6f0oN
         yGDA==
X-Gm-Message-State: AOAM533kgf7wSPE1XhiCJyioenVU+8UUaC3JIqrjMTGQ5bsIq9DeL9I2
        jdtAudvwlUliBeDaReh/65k=
X-Google-Smtp-Source: ABdhPJwxceoqpljoOxORiWe+hoanyQbBB6sJGiOwW8wB1uRizJrPsm/OTyrEvrg3o+AmYGKcarvRlw==
X-Received: by 2002:a63:4d59:: with SMTP id n25mr52244502pgl.122.1609772437982;
        Mon, 04 Jan 2021 07:00:37 -0800 (PST)
Received: from sol (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id q23sm62373625pgm.89.2021.01.04.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 07:00:37 -0800 (PST)
Date:   Mon, 4 Jan 2021 23:00:31 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Subject: Re: [PATCH 1/7] selftests: gpio: rework and simplify test
 implementation
Message-ID: <20210104150031.GA853645@sol>
References: <20210102022949.92304-1-warthog618@gmail.com>
 <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
 <20210103021725.GA6622@sol>
 <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
 <20210104015129.GA4939@sol>
 <CAHp75Vdd6yC=j+m7OOdP=M1j8Eoaayq8HSLF2fjVXcA0wiu9kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdd6yC=j+m7OOdP=M1j8Eoaayq8HSLF2fjVXcA0wiu9kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 04, 2021 at 03:52:49PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 4, 2021 at 3:51 AM Kent Gibson <warthog618@gmail.com> wrote:
> > On Sun, Jan 03, 2021 at 05:10:10PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > In this example it is the 508:
> >
> > # e.g. gpiochip0: GPIOs 508-511, parent: platform/gpio-mockup.0, gpio-mockup-A:
> >
> > So I'll use that - unless it is unreliable for some reason?
> 
> debugfs is not an ABI and tomorrow this can be changed without notice.
> 

I had a bad feeling that might be the case, and all my current solutions
use debugfs one way or another, so back to the drawing board on that one.

Thanks,
Kent.

