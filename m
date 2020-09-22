Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA85727495D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Sep 2020 21:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVToX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgIVToX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 15:44:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90479C0613D0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:44:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so13393986pfg.13
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xz2HRr+8jfMHydCknS290/QHwlWp02k4FcjW+L/Em9I=;
        b=ACQkpKsGyBx/9tLSKJxE1NFnviev8kAWHtBnoSKLT5BmiA8AMEf3biF7Dvxu/xrvkb
         rEG+qpMKSnNwKiVYJ+OPsL6Cja3hCbjsHb8r83MGK7ya4LYrr+UVXnMVQRZcVJ/a9oa8
         Lk6ydusXQZWGWSzcp11iod8TBdF2x1zUCzvFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xz2HRr+8jfMHydCknS290/QHwlWp02k4FcjW+L/Em9I=;
        b=uk7RNqxdWt3QxnOCU/IP6h4dZgJ2BRJdxOJ5iR7PeAUSFvtL/TsrWhPM5nFamTGO/l
         B2QyZ4VKJYEeKcEOM6VHH5BUfipFk01SxSza6K0ZLMrwFaeGBBlQec9oSwAs79DfcgW+
         hMBj9tW2T/rdVZjGhStjdT05hQYLMTGwD5O5rxC/azFRQRT5TUfZtjKOqEjgwhpg3mcs
         tGi6CR1HzBWCBcuyzaDaL0LqsgwTH0TaY4YAZ/L1D+pJJPN5FDf9fd2mkaS3JWSickcm
         6GysOPQEbVJhiP2jFDzDrjf8VFnI8wdpBqb2bYCfMWZATYE3tSyLmm4XSHn/fmUPSlK2
         mUlQ==
X-Gm-Message-State: AOAM531ZGRUSdeLGh6hC6kaChucEfVhR5EN+1M8yu1Xq6hdaFHBpft4G
        AyxDeQmBbadPlYdYZTbuLNBw7w==
X-Google-Smtp-Source: ABdhPJwLjM/xlaOXDWl7V4N8DTEvXRhf788Id/eAhytvJdLPhBf2gP7Vr1izUKxLKTT9rrCbjA1OOw==
X-Received: by 2002:a63:441a:: with SMTP id r26mr197932pga.290.1600803863106;
        Tue, 22 Sep 2020 12:44:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u71sm16397776pfc.43.2020.09.22.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:44:22 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:44:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <202009221243.6BC5635E@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-2-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> Convert TIF_SECCOMP into a generic TI flag for any syscall interception
> work being done by the kernel.  The actual type of work is exposed by a
> new flag field outside of thread_info.  This ensures that the
> syscall_intercept field is only accessed if struct seccomp has to be
> accessed already, such that it doesn't incur in a much higher cost to
> the seccomp path.
> 
> In order to avoid modifying every architecture at once, this patch has a
> transition mechanism, such that architectures that define TIF_SECCOMP
> continue to work by ignoring the syscall_intercept flag, as long as they
> don't support other syscall interception mechanisms like the future
> syscall user dispatch.  When migrating TIF_SECCOMP to
> TIF_SYSCALL_INTERCEPT, they should adopt the semantics of checking the
> syscall_intercept flag, like it is done in the common entry syscall
> code, or even better, migrate to the common syscall entry code.

Can we "eat" all the other flags like ptrace, audit, etc, too? Doing
this only for seccomp seems strange.

-- 
Kees Cook
