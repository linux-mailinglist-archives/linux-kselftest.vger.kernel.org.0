Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9827F23AF88
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Aug 2020 23:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgHCVO4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Aug 2020 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgHCVOy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Aug 2020 17:14:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E44C061756
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Aug 2020 14:14:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 189so3305758pfd.9
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Aug 2020 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFs5N7Aj94X2p4Itvu8tYvN2B3/GsCmBFKnespcHSO0=;
        b=BIJROpGSryxlCfoh5rldvY+j0NKCC0TMSDj/SFN4RZMbQXx5jWPcy71uC+SEtNDxX7
         BqHAgLfMCOWFh5CNKROZfxPZ7EGqxWAg93Z6IjH7NzGlBMXrZcz89dtyCQzcWdK51/rc
         4fcRl1C9vlx4ysv8yE4M/BFzdQHtnm+whqM3MeFrq5DQOznOUiZWtnNMCG0/nmJ4d/7y
         rB4POQCJpPpNHFNFza1crYxYA9RRemn99Fll6ery5GoKvTgmgHezyhpPaFZuHLcvyRsN
         GEAKftb1k0JcKY4VpjWXVi9+noA+0KYRnOD0pfyJCTCONpF6xVqUst0vVvw9lVpCHj9e
         mamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFs5N7Aj94X2p4Itvu8tYvN2B3/GsCmBFKnespcHSO0=;
        b=dRdPTKGMx/PywKnD3hJVJQ9SDh1itpg/AqhHhuhP2HB2PYgmJ6rGwgvpvWrXRASZXX
         Hb/u+qOwlKJzUYHaRr36Rjb5YPUA/P8zbYPGNZQP1B7JF9VhEG5r3UCk3GzqR7NdYV4a
         yPmu6xnC0jSF/8Nk7P9ysflJo+R4jfDeDFaDs+Fdm4MxYx8bz/iGPDQ1sjYp2nqnIIX9
         NYcLqhBhw3YtA9vYe2++2aX+xkjC+Pqielu6gfPJKkCT3foo5B0kPmGzy/C+XWjj09Hs
         7ak7V5EA9mSMdPF4u6MrRSoZOwsS2Pdx7UMn7pqgb7J+dH2/F+JPC2bs3hb49O8eOv4K
         VQ3w==
X-Gm-Message-State: AOAM532JsQ5fwSfnNAWjPbMZaeXrXSmaDAJxigYHCyatKI+VwfAEviWH
        8H33ApuGvC+iLhezSgt6qjoWEbmr4x4ygyuciqX3aQ==
X-Google-Smtp-Source: ABdhPJxN74uGPSyFq/sMHzSrAyVNydvv3a1KRtp+ugVWRWUR4XzuGsQSZAk1SzJ3Mge5oZFXZ7/TRU4deckwnTL4Mdg=
X-Received: by 2002:a62:7b89:: with SMTP id w131mr16526946pfc.284.1596489293882;
 Mon, 03 Aug 2020 14:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200803025939.21106-1-98.arpi@gmail.com>
In-Reply-To: <20200803025939.21106-1-98.arpi@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Aug 2020 14:14:42 -0700
Message-ID: <CAFd5g47u5u=cVAM_5rBj0mA4YcKjanebb35Po1EN13mNrEH7KA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: Convert test_uuid.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 2, 2020 at 8:00 PM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Converts test lib/test_uuid.c to KUnit.
> More information about KUnit can be found at
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> This change is beneficial as KUnit provides a common framework for
> unit tests in the kernel. KUnit is fast as well.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
