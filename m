Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B043BF574
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 08:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhGHGZL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 02:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhGHGZL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 02:25:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C1C619A2;
        Thu,  8 Jul 2021 06:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625725349;
        bh=W+h53mGiLZxvSfW/R9vFvStJYN2jtiMhpMbQkQuKTNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RX848RGN2A6K5cMjfq7qqzvTetkvK7075GR33IAIWa9IYNaK281/hTyNaG/3WzGxH
         z8w8fz8a5y/j8M3IZMx9PZFDQolcZSzQ31OMRDhCLjWZKZM6sox5aCW3bTywOAPjhh
         pkOBlXEdg9o8eIKwPahTZ6S0u84i8uo47KbrhKa8=
Date:   Thu, 8 Jul 2021 08:22:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org, shuah@kernel.org,
        rafael@kernel.org, rgoldwyn@suse.com, kuno@frob.nl,
        fontana@sharpeleven.org, Ciaran.Farrell@suse.com,
        Christopher.DeNicolo@suse.com, hch@lst.de, corbet@lwn.net,
        linux@leemhuis.info, ast@kernel.org, andriin@fb.com,
        daniel@iogearbox.net, atenart@kernel.org, alobakin@pm.me,
        weiwan@google.com, ap420073@gmail.com, tj@kernel.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-spdx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Message-ID: <YOaZohB/2Z3x5grc@kroah.com>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707184310.3624761-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 07, 2021 at 11:43:08AM -0700, Luis Chamberlain wrote:
> This adds the copyleft-next-0.3.1 SPDX tag and replaces existing
> boilerplate with the tag.
> 
> Luis Chamberlain (2):
>   LICENSES: Add the copyleft-next-0.3.1 license
>   testing: use the copyleft-next-0.3.1 SPDX tag
> 
>  LICENSES/dual/copyleft-next-0.3.1        | 237 +++++++++++++++++++++++
>  lib/test_kmod.c                          |  12 +-
>  lib/test_sysctl.c                        |  12 +-
>  tools/testing/selftests/kmod/kmod.sh     |  13 +-
>  tools/testing/selftests/sysctl/sysctl.sh |  12 +-

As we only have 4 usages of this license in the tree, we have the
opportunity to actually remove it and keep the list of licenses that we
use in the kernel source smaller.

Any chance you wish to just change the license of these files, given
that you are the only one that has tried to use it for kernel code?

As a follow-up to this, I do not want to see your "test_sysfs.c" module
as a dual-licensed file, as that makes no sense whatsoever.  It is
directly testing GPL-v2-only code, so the attempt to dual license it
makes no sense to me.  How could anyone take that code and do anything
with it under the copyleft-next license only?  And where would that
happen?

I understand the appeal of copyleft-next in that it resolves many of the
"grey" areas around gplv2, but given that no one is rushing to advise us
to relicense all of the kernel with this thing, there is no need to
encourage the spread of it given the added complexity and confusion that
adding another license to our mix can only cause.

So please, no, I don't want to see new licenses added to the tree, if
anything we should be trimming them down to be less as it makes things
simpler and more obvious.

thanks,

greg k-h
