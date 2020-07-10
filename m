Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9485621BA66
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 18:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgGJQLH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgGJQLG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 12:11:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA592C08C5CE
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 09:11:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls15so2820753pjb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3EszjAuKdLbRnLB9pftKo+oJnCDcBS1AwarADCNsweE=;
        b=PHEEFw8FOundyfqG7JLa9MXMuK6G9bG7jR0cukBcJ09z6qm4KnexC3gg/iT6blS98N
         mkC3YbIW/7Pmzw2t14kgOnIQD+8e0dDhCPfGLjCARjpogHk+qsgU0f2fKSladHEfzbCY
         7+Uy/5bRQPCKIawnMf4jcUp1vQQ9aTTrBhYtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3EszjAuKdLbRnLB9pftKo+oJnCDcBS1AwarADCNsweE=;
        b=BJ3Q/32Or1j4LDkTiAHmbG7RHfyjf/B6Lh4qWJNvG3pPiMmeqr+gneF89nTt3S+gNd
         TjhS6LFlPqfvJ3jVnhClNRtNyYZZpKdbKZXJ2l0tOmapZrzh0nO5vFT21R4BK3MoPuwT
         AhuqsTrACf7tqPyvPoL8WdCWmAhM8V8nzTmnpYXW8e8vBcDQlLmL8jOh6n7H6gNPgNAD
         /caX3VbSaj22GbxQTxX8jLOZjIifGJl6FBP6vI2o7Wb2SR/fc2L625QMlEB167m/Jcie
         4blG92wu+lgYl8JoRu7h3Pjg1eltW6NxElN4xuYicErK954/TRaP/aF28tiWJ96JzaRT
         UYYw==
X-Gm-Message-State: AOAM533Lp8NRXXttI+Zgw8Jwo4LV2U2F7ah2gNvmVtLDZoKrd3zs6a97
        nBljp6Wo3rRioiUXz2ZFLaAy1g==
X-Google-Smtp-Source: ABdhPJwBZWBRUiVm74i+SNKREYZliBSAgKh8do9o20x4bZ5qPhfKMpuRyev1GYSUF/IyzDwxG+x0Dw==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15mr22554817plr.329.1594397465470;
        Fri, 10 Jul 2020 09:11:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q24sm6669112pfg.34.2020.07.10.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:11:04 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:11:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next/seccomp 0/3] Check ENOSYS under tracing
Message-ID: <202007100910.79661A4@keescook>
References: <20200705061232.4151319-1-keescook@chromium.org>
 <20200710124033.GA30458@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710124033.GA30458@willie-the-truck>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 10, 2020 at 01:40:33PM +0100, Will Deacon wrote:
> On Sat, Jul 04, 2020 at 11:12:29PM -0700, Kees Cook wrote:
> > This expands the seccomp selftest to poke a architectural behavior corner
> > that Keno Fischer noticed[1]. In the process, I took the opportunity
> > to do the kselftest harness variant refactoring I'd been meaning to do,
> > which made adding this test much nicer.
> > 
> > I'd prefer this went via the seccomp tree, as it builds on top of the
> > other recent seccomp feature addition tests. Testing and reviews are
> > welcome! :)
> 
> Thanks! I tested these on arm64 (qemu) and they helped me to find a bug
> in some patches I was writing.

Hurray for tests! :)

> Tested-by: Will Deacon <will@kernel.org>

Thanks!

-- 
Kees Cook
