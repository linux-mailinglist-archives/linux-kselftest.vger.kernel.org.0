Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC126215AD1
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgGFPeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgGFPeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 11:34:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDB8C08C5E0
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 08:34:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so2123195plk.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2k2hbPhkWweF7cLfaAlco18/gAjmQL1VA8QeUZk2IDs=;
        b=OagKnMIgpgCJnhru2Z6F1OwWIFBf3SN+y2OfCovePGZIuLrTF/nRI+GDYcy2KjYAs1
         ++qSitiDJGXLArCMnPS20ukW55tzKpQzB8Cu4U3LFvOD7zfF125j85Do1bBecl2JSrgp
         UNTlg8r21yWCoyaf24FivPXQwGx2006gzAFhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2k2hbPhkWweF7cLfaAlco18/gAjmQL1VA8QeUZk2IDs=;
        b=Wy0nCRhiWtuZ1gr5c7QFdAqgB81inUEOfA7aPyAPl5aNXzbNDzToCSLjdfarid7txK
         iy8lOf6aK+7QoMFtlGipFKZdT9HmJqF5LmuPblpURyW3f1BFT7xXMrP/0yBw/5Z4vQ9n
         ZnM3kc8w65NGUuLN1zL8vz7nm5j1VTg4mNRmKP/KUCvWS9OYMa3lNmm6f/0xsmxsxAZO
         RU4/EcPoXjwWoAd4SPAkn9WyaRM3jNLXGtKjV2QczpPc82GKLagPUX23qWOo21uKAloK
         MvhOr/RAo/SH4z2NT47mtKVI+x3YNk8HigQgKMEQDdF4DKwVRcNIfsgjtIZoL4+2DOOl
         358w==
X-Gm-Message-State: AOAM531vuRqlho02F3/hr55kYbKIc5smUN9KOI1pDr1gWZIkZP5qTcou
        87Sqs+1NN/8x12YaJgyD2xRaLA==
X-Google-Smtp-Source: ABdhPJyG5yXSH5wzz03o2yh+N8HdVwwIQHNogdAtABoG1rJq2H1Q1au4F8P3NBp4eYhUsmAXwBu/Pg==
X-Received: by 2002:a17:902:a3c7:: with SMTP id q7mr7536954plb.20.1594049648909;
        Mon, 06 Jul 2020 08:34:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm20497150pfk.8.2020.07.06.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 08:34:07 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:34:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH v5 4/7] pidfd: Replace open-coded partial
 fd_install_received()
Message-ID: <202007060830.0FE753B@keescook>
References: <20200617220327.3731559-1-keescook@chromium.org>
 <20200617220327.3731559-5-keescook@chromium.org>
 <20200706130713.n6r3vhn4hn2lodex@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706130713.n6r3vhn4hn2lodex@wittgenstein>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 03:07:13PM +0200, Christian Brauner wrote:
> On Wed, Jun 17, 2020 at 03:03:24PM -0700, Kees Cook wrote:
> > The sock counting (sock_update_netprioidx() and sock_update_classid()) was
> > missing from pidfd's implementation of received fd installation. Replace
> > the open-coded version with a call to the new fd_install_received()
> > helper.
> > 
> > Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/pid.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index f1496b757162..24924ec5df0e 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -635,18 +635,9 @@ static int pidfd_getfd(struct pid *pid, int fd)
> >  	if (IS_ERR(file))
> >  		return PTR_ERR(file);
> >  
> > -	ret = security_file_receive(file);
> > -	if (ret) {
> > -		fput(file);
> > -		return ret;
> > -	}
> > -
> > -	ret = get_unused_fd_flags(O_CLOEXEC);
> > +	ret = fd_install_received(file, O_CLOEXEC);
> >  	if (ret < 0)
> >  		fput(file);
> > -	else
> > -		fd_install(ret, file);
> 
> So someone just sent a fix for pidfd_getfd() that was based on the
> changes done here.

Hi! Ah yes, that didn't get CCed to me. I'll go reply.

> I've been on vacation so didn't have a change to review this series and
> I see it's already in linux-next. This introduces a memory leak and
> actually proves a point I tried to stress when adding this helper:
> fd_install_received() in contrast to fd_install() does _not_ consume a
> reference because it takes one before it calls into fd_install(). That
> means, you need an unconditional fput() here both in the failure and
> error path.

Yup, this was a mistake in my refactoring of the pidfs changes.

> I strongly suggest though that we simply align the behavior between
> fd_install() and fd_install_received() and have the latter simply
> consume a reference when it succeeds! Imho, this bug proves that I was
> right to insist on this before. ;)

I still don't agree: it radically complicates the SCM_RIGHTS and seccomp
cases. The primary difference is that fd_install() cannot fail, and it
was optimized for this situation. The other file-related helpers that
can fail do not consume the reference, so this is in keeping with those
as well.

-- 
Kees Cook
