Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A52E9865
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jan 2021 16:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbhADPYH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jan 2021 10:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADPYG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jan 2021 10:24:06 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A23C061574;
        Mon,  4 Jan 2021 07:23:26 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 11so16627248pfu.4;
        Mon, 04 Jan 2021 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G8nosa3HmeTxWutD9E8tm0s7tb/P8NNzuyVaCnbWuyk=;
        b=A4llXl+3wIiV+Oq9Y20Dc8axEyRRzmFLSeJhzN47+3nN6q0W6gkR9gTxnEUADLXQ6J
         T3JVaAIwUA/hwzgq/pRKAF0NjCij9XBXa2NhZyURpjIFHjK8+H1WWB/65is3BhK5T+sQ
         AdDKzDyN9jT7LYIarmmuLAhrMXc2Co31MhHRgK/hUDUjUWonFsjSbxHDn3cTaT4i3gUR
         Y9QrqOTQlv73GFm0pvGN5PeITUlAcRFwbHD4SUPjHLd8UAIrXOVaOe55812NKvwV4DOG
         +g8+OEJ14tjL8UtEUx7+oiwJ6xxl5FU4q6kU3uCfFiXgwH0gjiq2SdOQ7pd3hf1WiueY
         Kezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8nosa3HmeTxWutD9E8tm0s7tb/P8NNzuyVaCnbWuyk=;
        b=Lcpl0p1rleoaHIwQZ7/IsXa4BF2C4p01tx+jaWDKHRfsucp6RI/M6pHm8ZaJ46Snto
         sHdGSAl4IyKDSH+0dsqrCQs+dZ9B2OFB72fngO0MnUQ+B+cWIQrqzPBrvzxkVZwY3qZw
         ITbObmgluF5HJuKgYZoFTuQq7DUgQfuHU50P5T9V6/LQXld1gZfEgqLj4mHsGD4cJ0Jh
         5dgJByX8ZXcRbHYOKU+Mex6a8WVR0zWiqe8XqMSDw/E+e8Sa1fQeClrmd4Ca/IGEbSUX
         VM8J7qOkxQaSlQDH51i/hFx1pHgz4pw+ebDZ66S5JLQBq02Md67BUVjW7ALXp9xfiicH
         nR9w==
X-Gm-Message-State: AOAM531ReaneOlz0YhEmAvQK2UnQACPjfZCox33V4FnOKs2ns8eG3Dl4
        LLhB8zSEBe9Tm/1Yc9Ic3jI=
X-Google-Smtp-Source: ABdhPJyGA7VAmzl1o1sn62Q4T/s1NvRB4sS4yQ8j28DKQqXDwKtCJrpVQkBCdaS+xIVvojGuwaRKVA==
X-Received: by 2002:a63:4644:: with SMTP id v4mr53315268pgk.440.1609773805947;
        Mon, 04 Jan 2021 07:23:25 -0800 (PST)
Received: from sol (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id z10sm57240689pfr.204.2021.01.04.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 07:23:25 -0800 (PST)
Date:   Mon, 4 Jan 2021 23:23:19 +0800
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
Message-ID: <20210104152319.GA854268@sol>
References: <20210102022949.92304-1-warthog618@gmail.com>
 <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdMs1mP7pK46qKqJbjfyrcKhSGvtyzQpTRsehMz6o=Jpg@mail.gmail.com>
 <20210103021725.GA6622@sol>
 <CAHp75VfONKY7VS0q=GkSX14i--g0=jfBg4RFBoMk4DxJPMHJFg@mail.gmail.com>
 <20210104015129.GA4939@sol>
 <CAHp75Vdd6yC=j+m7OOdP=M1j8Eoaayq8HSLF2fjVXcA0wiu9kQ@mail.gmail.com>
 <20210104150031.GA853645@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104150031.GA853645@sol>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 04, 2021 at 11:00:31PM +0800, Kent Gibson wrote:
> On Mon, Jan 04, 2021 at 03:52:49PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 4, 2021 at 3:51 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > On Sun, Jan 03, 2021 at 05:10:10PM +0200, Andy Shevchenko wrote:
> > 
> > ...
> > 
> > > In this example it is the 508:
> > >
> > > # e.g. gpiochip0: GPIOs 508-511, parent: platform/gpio-mockup.0, gpio-mockup-A:
> > >
> > > So I'll use that - unless it is unreliable for some reason?
> > 
> > debugfs is not an ABI and tomorrow this can be changed without notice.
> > 
> 
> I had a bad feeling that might be the case, and all my current solutions
> use debugfs one way or another, so back to the drawing board on that one.
> 

Hang on - the find approach that I was looking at previously only uses
/sys/devices/platform, so I'll revert to that one - and add handling for
multi-match.

Cheers,
Kent.
