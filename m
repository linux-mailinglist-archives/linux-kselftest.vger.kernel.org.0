Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652441C1E7B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgEAUb1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 16:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgEAUbY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 16:31:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F6C08E934
        for <linux-kselftest@vger.kernel.org>; Fri,  1 May 2020 13:31:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so4013513pll.8
        for <linux-kselftest@vger.kernel.org>; Fri, 01 May 2020 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVZsHO3B+82ZVvSvwD+6L84uL6YCwy6wqP9DD2caeKY=;
        b=Zc3KuQRuQy2OoPJPM+d+PnQiWTvDwpVtt8Zs/O3P2xKcWz2OpXBRQHO7c7IRb3Svou
         7tdEiY8sRnRcjQKcq5Zj+0PlJ3VLXU+3aiTRKJ5MlWhFdkPfkoa8RKmQKcnL+YtrFDPP
         AoyAhLCPYp/Bscc03FLzyMRL/p9YsUHnOlTHVDrPdG/xFXwkBqT1eusZGZHPZcMORFnJ
         XUnONPMgBLe3uBUsDaF4ihYyjghwSsIq+4toZYrsvYog8R/WKxPl/CIP6xrmB3iChGu+
         IP/ZvPS61IFkPnLMCnS1V56OJBpUCNYtLWaCzdi/NkjLIM7PXCLaVmPYfH/gNTtPYD9V
         IZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVZsHO3B+82ZVvSvwD+6L84uL6YCwy6wqP9DD2caeKY=;
        b=V2bixNHAn3VWcCNfdss9S21K1irbfMJmkrYGeBasPE/Dznn7LznheNr0gQ0DNoMj9n
         e0eVPluLEuyrMjSZdmVwGvMPc6gOUW0XUW/Ce3Sf97CjPgwPM+sktpdNkWzgUyCUK4np
         9b/AXvno57o+IO16tsmNYFkmqxFDtd7jiHcoOj0AOdqOSpH7XDpWoJzwCniHWx7u5WX5
         9yjFzI/ssFLuwnKDwpr04GWxDgRJshSjxk0Zuci+Ld2+i/IIDgOT2tfU4/5ypHLXZq6K
         60eYFu+GGpfME6KrERtJeocUyqt9vRKydm4vhHou2gkfzD/Bf5Iq8VG/ZSwFXTVvW+Kw
         jBZQ==
X-Gm-Message-State: AGi0PuaPsRK7M9y6qTbZjREXBCfQZEBddZRr28XLiw/w9cxL2h85EnWR
        kSA63QHhI7Y7dVLaf/S1B1APDeXJxQq6fAHq9koShQ==
X-Google-Smtp-Source: APiQypJ9b4QRn/GrVn+RH4LsZdGv7V2jtr2OO/8zkSxd5QcIuJPpD3L0aOdJL8jy19OYg1HSleGSA99rMnX4I9DcZ7s=
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr5817749plq.297.1588365082975;
 Fri, 01 May 2020 13:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200501083510.1413-1-anders.roxell@linaro.org>
In-Reply-To: <20200501083510.1413-1-anders.roxell@linaro.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 1 May 2020 13:31:11 -0700
Message-ID: <CAFd5g45C98_70Utp=QBWg_tKxaUMJ-ArQvjWbG9q6=dixfHBxw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Marco Elver <elver@google.com>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-security-module@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 1, 2020 at 1:35 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Make it easier to enable all KUnit fragments.  This is needed for kernel
> test-systems, so its easy to get all KUnit tests enabled and if new gets
> added they will be enabled as well.  Fragments that has to be builtin
> will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
>
> Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> someone wants that even though KUNIT_RUN_ALL is enabled.

I would LOVE IT, if you could make this work! I have been trying to
figure out the best way to run all KUnit tests for a long time now.

That being said, I am a bit skeptical that this approach will be much
more successful than just using allyesconfig. Either way, there are
tests coming down the pipeline that are incompatible with each other
(the KASAN test and the KCSAN test will be incompatible). Even so,
tests like the apparmor test require a lot of non-default
configuration to compile. In the end, I am not sure how many tests we
will really be able to turn on this way.

Thoughts?
