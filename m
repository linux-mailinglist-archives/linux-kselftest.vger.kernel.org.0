Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3927B78B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 01:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgI1XNK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 19:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgI1XNJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD47C05BD24
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 16:13:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o25so2271800pgm.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NftyTi1bwuaE14e4XfgcQF93EOxKUsMOEEQqaDTCXJ4=;
        b=gb3PRHELtfh8s0n7btbKHS7gdHecLDH27/WSx/dTaEZqzwAyfLHcApZT5c+IqoShdm
         0LEtidHDj3nYkCuzJeB2PL+jPZX/ntrn70g8bHDhQFR+CUPr0IDYs3hxi4tZpkrlg6d9
         hrDzPZTP54zHmpmIZZBNppWuJmHgMncA/mXvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NftyTi1bwuaE14e4XfgcQF93EOxKUsMOEEQqaDTCXJ4=;
        b=C2M0b5fboSRO1ZYX7tOXT5VFspGIkOe03R6z+P/+0+2ZjL74YKv65ka6waQ/Od/1Jt
         p2AvMlocd8U1fe2e7JDQ77ED8BaBVn5ICxubLYzkyGHTYfbftgGCZrJDt0PQPqn8lgzU
         G/pnSLrkJ9N2qjmy7nioy3tfYn1PjuBwlx41Pa7+NkxeXZ2IA0BOnHE/25wBPeNqE1Fd
         2jV1/PqV8/x71hmolnxMbKJE/F9kEB3V2oSoVkyBOqxRnYzbTcx9s16gM5ZT7ccNLCkt
         l/e2Qq1R4zOW0Uhx0RQ6/WKYdmwpmIARikhylmWsJz2iksAR10ZW8mVHIPBUoA788AXS
         NQKQ==
X-Gm-Message-State: AOAM532NTWfj6+477FecfS6UA0/fLcVoI5tBMQPDhJ5TwmYMzLIppH2x
        QsNHU+tthU0eUkB3t+ILhs//9A==
X-Google-Smtp-Source: ABdhPJwQDKOxa8hqpizwqXPcIZmf1ybA5/FNT7GiN+5miNLUE3lYvrdUP8suk6yqrm6piIZGkrVe3g==
X-Received: by 2002:a65:494e:: with SMTP id q14mr1006851pgs.281.1601334788954;
        Mon, 28 Sep 2020 16:13:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z23sm2835217pfj.177.2020.09.28.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 16:13:08 -0700 (PDT)
Date:   Mon, 28 Sep 2020 16:13:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
Message-ID: <202009281612.EDC1C0078@keescook>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <202009260923.9A2606CFF6@keescook>
 <3929a023-eb7a-509c-50e1-ee72dca05191@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3929a023-eb7a-509c-50e1-ee72dca05191@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 28, 2020 at 04:41:47PM -0600, Shuah Khan wrote:
> On 9/26/20 10:29 AM, Kees Cook wrote:
> > On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
> > >     7. Verified that the test module compiles in kunit env. and test
> > >        module can be loaded to run the test.
> > 
> > I meant write it using KUnit interfaces (e.g. KUNIT_EXPECT*(),
> > kunit_test_suite(), etc):
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/
> > 
> > Though I see the docs are still not updated[1] to reflect the Kconfig
> > (CONFIG_foo_KUNIT_TEST) and file naming conventions (foo_kunit.c).
> > 
> 
> I would like to be able to run this test outside Kunit env., hence the
> choice to go with a module and kselftest script. It makes it easier to
> test as part of my workflow as opposed to doing a kunit and build and
> running it that way.

It does -- you just load it normally like before and it prints out
everything just fine. This is how I use the lib/test_user_copy.c and
lib/test_overflow.c before/after their conversions.

-- 
Kees Cook
