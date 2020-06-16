Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E31FB976
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbgFPQD5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733084AbgFPQDy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 12:03:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FECC0613EE
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 09:03:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so5340589plk.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zKc/JpLrFA5C9B00OW//vjJ8ZMv5QimUc3F5i8rvet4=;
        b=OllvnLopOjSAVN/rCkHGWJ500Le3/6Ku5c3o8ZlC+gP2RzGDWdyhUX0XwzoK6KZlXi
         oVUvlUOsEvATG+ldK1KcrhLOS061oY8IpfnuZkqmEEiYnuh+gmbZps73C0AZ9cOBaHq1
         exTGM1g9ghl69TYphlzSAJ8R2IcP6MK/Wv63w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKc/JpLrFA5C9B00OW//vjJ8ZMv5QimUc3F5i8rvet4=;
        b=jTVEHvwu+Z5HXOh7VXhc1OHFwn22JG7jk53yHbaUJ7k2uzy7ItJ78Xw5P0IfWiFTp2
         c8iCHQdU6cBXq2zFBA3irHjZK8uNRGB7Vfnj5VjIXIg/fiVzkVT6cD3yBb8uvHLdyBNC
         i0rvQVXFlw0OUhzjpJQnV581OK21GpMe1razPNE+2f+dhAYHVsJb+/bVId4+DD8qamiW
         IZwrBBm96T2XGYGZOdMZbjG4vcxzSS1GLNiLlgzpuJBrMlUYIy0aCYGlRhey3CREOhuv
         OQDzdACCqNIdpoMhoA39s+O0c5SVmRwBm+IILIHZXubX7Hu7ShSF24qOJd1pEUF1+CKI
         1LFA==
X-Gm-Message-State: AOAM533BuiVHNcEu08JlMlJS3rEn6VTfxtIh76PpBZPnYzwIsbykst8o
        DXXiawXVkrjsOG0qM4Y6vcy0tg==
X-Google-Smtp-Source: ABdhPJwVjALfzLCAM/XOMQlngQM0/cTr6VlDaTe0C2TtJc/aiEyzOtzkrH1NE78arH20bNJ9zx2lfA==
X-Received: by 2002:a17:902:e901:: with SMTP id k1mr2665677pld.92.1592323433244;
        Tue, 16 Jun 2020 09:03:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14sm17059842pfc.133.2020.06.16.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:03:52 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:03:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 08/11] selftests/seccomp: Make kcmp() less required
Message-ID: <202006160902.E331FF1917@keescook>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-9-keescook@chromium.org>
 <20200616145725.GJ2893648@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616145725.GJ2893648@cisco>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 08:57:25AM -0600, Tycho Andersen wrote:
> On Mon, Jun 15, 2020 at 08:25:21PM -0700, Kees Cook wrote:
> > The seccomp tests are a bit noisy without CONFIG_CHECKPOINT_RESTORE (due
> > to missing the kcmp() syscall). The seccomp tests are more accurate with
> > kcmp(), but it's not strictly required. Refactor the tests to use
> > alternatives (comparing fd numbers), and provide a central test for
> > kcmp() so there is a single XFAIL instead of many. Continue to produce
> > warnings for the other tests, though.
> > 
> > Additionally adds some more bad flag EINVAL tests to the addfd selftest.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> This looks fine, but I wonder if this is enough motivation for taking
> kcmp() out of CONFIG_CHECKPOINT_RESTORE guards?

Do you mean in the kernel? I'd rather not -- it's a relatively powerful
primitive. Maybe if there were other users needing it, but there doesn't
seem to have been much demand.

-- 
Kees Cook
