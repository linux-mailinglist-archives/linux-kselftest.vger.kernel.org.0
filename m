Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B822668F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgIKTi4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgIKTis (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 15:38:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6FAC0613ED
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Sep 2020 12:38:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so7331673pgm.11
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Sep 2020 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qaZP6m6PliEDeF0nF0A/r4O+cyZTLN4HiaGdVnnobZs=;
        b=RZw4+7KZntnY0JsM9KLXdwU8V/b2ZDu1qTtZ0ikbRHS0KmNTbb0KNEowrsD+eaZXBM
         LlW+XMPPC0WixHNWKCfsb4v1YOEKGixe3rSBCKfniGjHZgEffR6guUU3mZMzlUwNLJpv
         6MecHVMi/SUQlTlsasQr+fSv9Ib+vkyMsU/k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qaZP6m6PliEDeF0nF0A/r4O+cyZTLN4HiaGdVnnobZs=;
        b=Ud7BV3wZNSAH9IGuyjfBPFJhMgyeWIVHqUQZ81Z302fnlB14mFEKvkzbQW8765gVj1
         zuG4UxLC9BwYZI8m47xzfYHFhbIlaw+z4CqTZvlUdz8Vun57Lk96tr7iq871JW5l02xS
         cJHYQOFJbkVuNCEd8DS3YaSrAzteXfdfOg7M5nTIuwilDrpfvHkNppBD3IH56snGB7I5
         wjqyZREI1nx1Xf+15ROt9HKkqt+KeUWPIUVr81snkdg3QgeH7F98TixIjkQgNBfCGvry
         Ef0G2nW/Rffk0rvTDc+Y6FPPjE+LrEYl2SlHraGoK2hjOgAS6+nBaGeJ2e+pxJRGdY/D
         Gf+Q==
X-Gm-Message-State: AOAM531UYqlPcZTBsFwO+C0hYIDWSLDmRN0dqXNP5a/6mxku4FOCVkdU
        dVkx3yGye8296kjv4IxdXwG3sg==
X-Google-Smtp-Source: ABdhPJyXHMyFqXUriaTsd1oDPtK6lGHGDe6EoXYTZLs/6cPi5Z3ZgVaaKgJ5t0S3yWtzEgXdRqy1kQ==
X-Received: by 2002:a63:444d:: with SMTP id t13mr2686979pgk.404.1599853126903;
        Fri, 11 Sep 2020 12:38:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15sm2695755pgi.69.2020.09.11.12.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 12:38:45 -0700 (PDT)
Date:   Fri, 11 Sep 2020 12:38:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] xtensa: add seccomp support
Message-ID: <202009111229.4A853F0@keescook>
References: <20200719021654.25922-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719021654.25922-1-jcmvbkbc@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 18, 2020 at 07:16:51PM -0700, Max Filippov wrote:
> Hello,
> 
> this series adds support for seccomp filter on xtensa and updates
> selftests/seccomp.

Hi!

Firstly, thanks for adding seccomp support! :) I would, however, ask
that you CC maintainers on these kinds of changes for feedback. I was
surprised to find the changes in the seccomp selftests today in Linus's
tree. I didn't seem to get CCed on this series, even though
get_maintainers shows this:

$ ./scripts/get_maintainer.pl 0001-selftests-seccomp-add-xtensa-support.mbox
Kees Cook <keescook@chromium.org> (supporter:SECURE COMPUTING)
Andy Lutomirski <luto@amacapital.net> (reviewer:SECURE COMPUTING)
Will Drewry <wad@chromium.org> (reviewer:SECURE COMPUTING)
Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
...

Regardless, I'm still glad to have more arch support! :) I'll send a
follow-up patch to refactor a bit of the selftest.

Thanks,

-- 
Kees Cook
