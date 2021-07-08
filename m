Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E47D3C160B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGHPfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 11:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231845AbhGHPfR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 11:35:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5144261625;
        Thu,  8 Jul 2021 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625758354;
        bh=d6hWipfI0BuFnl9dNbp+8qC1wTQ3teMKHa503AJAlPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyoPKYxVRv1vMNWTVMHiXStGDPwfMWCQUl0LQlzTfhD9fJVXWEe2h6Gh/IyAnqNqK
         6/4A3b9p2HRqQpAFeeHmBrtWA2anQIIdI7Mbl6he9LgjdLXHEqtvjbr8CY/saQYxMD
         xc67nH26ld32JoOgouZj5VRCew1Q0ka+n1C180PA=
Date:   Thu, 8 Jul 2021 17:32:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Bradley M. Kuhn" <bkuhn@ebb.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, tglx@linutronix.de,
        akpm@linux-foundation.org, shuah@kernel.org, rafael@kernel.org,
        rgoldwyn@suse.com, kuno@frob.nl, fontana@sharpeleven.org,
        Ciaran.Farrell@suse.com, Christopher.DeNicolo@suse.com, hch@lst.de,
        corbet@lwn.net, linux@leemhuis.info, ast@kernel.org,
        andriin@fb.com, daniel@iogearbox.net, atenart@kernel.org,
        alobakin@pm.me, weiwan@google.com, ap420073@gmail.com,
        tj@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-spdx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Message-ID: <YOcakETswyEN58j6@kroah.com>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
 <YOaZohB/2Z3x5grc@kroah.com>
 <YOcSwXkpzAFGucXM@ebb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOcSwXkpzAFGucXM@ebb.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 08, 2021 at 07:59:13AM -0700, Bradley M. Kuhn wrote:
> Greg KH wrote:
> > Any chance you wish to just change the license of these files, given that
> > you are the only one that has tried to use it for kernel code?
> 
> There is a lot of dual-licensed (GPLv2-only|{2,3}-Clause-BSD) code already in
> Linux.  Many corporate copyright holders have well documented strong reasons
> for wanting that.  (Those policy goals and the analysis behind them, I find
> problematic and sometimes outright wrong, but nonetheless it's their right to
> license their copyrights that way, and the license *is* GPLv2-only
> compatible, as is Luis'!).
> 
> I assume that you're not asking those companies to relicense to pure
> GPLv2-only.

On the contrary, I have stated in public many times to companies that
try to add dual-licensed new kernel code that they should only do so if
they provide a really good reason, and pushed back on them numerous
times.  See the mailing list archives for details if you care.

So yes, I am asking them, this is not anything new.

Let's keep it simple please, and not add new licenses for no real good
reason if at all possible.

thanks,

greg k-h
