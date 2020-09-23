Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BFF276278
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Sep 2020 22:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIWUt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIWUt5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 16:49:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5934EC0613D2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 13:49:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so341943pjb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vR/4IIWUNKe15foWwpTS+9b9UDo/Qa9Bzr4DnMS8/ac=;
        b=cvjPnC0ctMeBB9Bs+hCjmPTbXFlh28AtvRC9s1zm2hw5bXo4ZM3zQP6zMGV/EI6SFo
         ZCLDgL2ZjoUvZ0VvL5o3QAIC/+pFqbd6cKVOng6IcDOjV9fnoffLoUMEnL06XcnSYhD5
         +9ECmXqHcYULlG40Fvwx9JHw4WrGQFnblwk/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vR/4IIWUNKe15foWwpTS+9b9UDo/Qa9Bzr4DnMS8/ac=;
        b=sFdlRdfxAS6LQVb3DF/F4fxEnyQSlszsloOaK2tSvFlTdjvIgTdw4yqJTNWCL08J80
         cz0LD2Jt/xy/Y+4tgL7RLFhgrEeiuoVle2hpv69cTQQdSYFKSKsNr1xJQ7LkwOYWKS8k
         WSQm/y4bbL/UIpGX/6qOUYEDXIA96FaYxwifKCSE3BJOBVQiNv6MBKl4bU96rSsrIPCv
         +lsVDFaROt6hIzgEmhWB0kfTGz1RKqHDaJVm3w7gPRCCf5uMV+iw/SShDZdQAD85OoVt
         faQZkxgp2bn6kGxdynDkZXwCnd8XzeoVLDrxRkMk/lCnhbSv974nC0H5jeku7DULEJSe
         Os5Q==
X-Gm-Message-State: AOAM5336FU4YxdVFF//+cOJmiYGqghnDtE/JcNMr+6GoyjO1HsB1wnkt
        Ac6vxhRaXwzUTsW0EMX/JMI+vw==
X-Google-Smtp-Source: ABdhPJzAZbjKC++0LwmLMQfeQPatEJ5NMT1jot2+hrKf5dZand6yk9QurwfKoHW0Dn2mkHpfk4pEKA==
X-Received: by 2002:a17:90b:3c3:: with SMTP id go3mr1124426pjb.64.1600894196835;
        Wed, 23 Sep 2020 13:49:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m20sm514433pfa.115.2020.09.23.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:49:55 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:49:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, luto@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <202009231349.4A25EAF@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
 <202009221243.6BC5635E@keescook>
 <874kno6yct.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kno6yct.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 23, 2020 at 04:18:26PM -0400, Gabriel Krisman Bertazi wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> >> Convert TIF_SECCOMP into a generic TI flag for any syscall interception
> >> work being done by the kernel.  The actual type of work is exposed by a
> >> new flag field outside of thread_info.  This ensures that the
> >> syscall_intercept field is only accessed if struct seccomp has to be
> >> accessed already, such that it doesn't incur in a much higher cost to
> >> the seccomp path.
> >> 
> >> In order to avoid modifying every architecture at once, this patch has a
> >> transition mechanism, such that architectures that define TIF_SECCOMP
> >> continue to work by ignoring the syscall_intercept flag, as long as they
> >> don't support other syscall interception mechanisms like the future
> >> syscall user dispatch.  When migrating TIF_SECCOMP to
> >> TIF_SYSCALL_INTERCEPT, they should adopt the semantics of checking the
> >> syscall_intercept flag, like it is done in the common entry syscall
> >> code, or even better, migrate to the common syscall entry code.
> >
> > Can we "eat" all the other flags like ptrace, audit, etc, too? Doing
> > this only for seccomp seems strange.
> 
> Hi Kees, Thanks again for the review.
> 
> Yes, we can, and I'm happy to follow up with that as part of my TIF
> clean up work, but can we not block the current patchset to be merged
> waiting for that, as this already grew a lot from the original feature
> submission?

In that case, I'd say just add the new TIF flag. The consolidation can
come later.

-- 
Kees Cook
