Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660741F7D06
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLSlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 14:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFLSlx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 14:41:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A410C08C5C1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 11:41:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so3997978pjb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Jun 2020 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkjrCiKtn27Q86bEY5Zk8H6jpaZDgzX0V2ezg2m+c28=;
        b=HMApzVGKyREgvBZcJ3L+ZHYzdU8A7u2LcP73qWYOlMUrqKOtbTinPJcTIWLT1XmDgj
         dzNKNYDYm9DR+3r5Ls0MmPvx/weBNrWJ/pyA7WhHjfrPz4TKhqRDabII+ejN6s54hsGV
         oNy43643FzpCg0BlZMemItXDkJqE9w3K3wM/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkjrCiKtn27Q86bEY5Zk8H6jpaZDgzX0V2ezg2m+c28=;
        b=jwYEGWeMuKjE+AX3RhPEPXE/n/JB/VaAh5tNfuSeds4lnNVkyOvctcsn8O8Sd/4o7w
         NzzDi3pwGKtKCgWVbxvTojgKzUzix8PSloIUnK/mmaCW+TKHl7dUvJBeDeLGvpNDOW1F
         S9U7HL3T1mzQ5UbAz2flS21rFfAtP/89ViP4ncPV0sLIx1AHd9IpnhlepMhJUUQzxHAc
         tpNAB+wcqI8ldUiwZHR0aVDCr2KJjp66sw8RYrMEDHyhXbxGpO9Z1yLOZN/jChvDjq3t
         XEXcfVW0wlDQBO1O6Ut280SdlSb0PfAjEztP4Dxs54pmD4igrE28/LAXAVWikLdCgVxy
         ynRg==
X-Gm-Message-State: AOAM530JVRkjjcAYSu4hCpbRMU8UKOuU44YQTGT/z9Gfb4L9Lbph4vnP
        DdGLdvG27w4k+lPUdeTiW/awnQ==
X-Google-Smtp-Source: ABdhPJw7+X28Su6pr5AQrgMOS6ASerURV1Q7yRXEHjjBew+WOoj/phuKUp8p7+5Gb/6yrzHFLe0jTg==
X-Received: by 2002:a17:90a:2ec6:: with SMTP id h6mr292496pjs.82.1591987312542;
        Fri, 12 Jun 2020 11:41:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b6sm6733713pfp.24.2020.06.12.11.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:41:51 -0700 (PDT)
Date:   Fri, 12 Jun 2020 11:41:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] selftests/binderfs: Fix harness API usage
Message-ID: <202006121141.1A0623336C@keescook>
References: <20200611224028.3275174-1-keescook@chromium.org>
 <20200611224028.3275174-4-keescook@chromium.org>
 <20200612181900.6kyhxevm6ebhu43d@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612181900.6kyhxevm6ebhu43d@wittgenstein>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 12, 2020 at 08:19:00PM +0200, Christian Brauner wrote:
> On Thu, Jun 11, 2020 at 03:40:24PM -0700, Kees Cook wrote:
> > The binderfs test mixed the full harness API and the selftest API.
> > Adjust to use only the harness API so that the harness API can switch
> > to using the selftest API internally in future patches.
> > 
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> I had this on my TODO but never actually got around to it, so thanks!
> 
> In all honesty, I've done a "Does this overall look sane?" review.
> Simply because I lack the time to do this in more detail right now but
> I'm happy this work is done and so overall:
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

I did actually do runtime tests of this (and found a couple bugs in my
port that I fixed before sending the final version). So, fwiw, it passes
for me.

Thanks for the review!

-Kees

-- 
Kees Cook
