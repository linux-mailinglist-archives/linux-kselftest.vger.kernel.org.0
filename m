Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F493C17AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGHRES (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 13:04:18 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:41150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229469AbhGHRES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 13:04:18 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 13:04:18 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 968388122D47;
        Thu,  8 Jul 2021 16:56:21 +0000 (UTC)
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 14E3F1846F773;
        Thu,  8 Jul 2021 16:56:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 332772EBFC6;
        Thu,  8 Jul 2021 16:56:08 +0000 (UTC)
Message-ID: <d538c07ccb0176fe7c715bf4cb3b48d84b378c52.camel@perches.com>
Subject: Re: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Bradley M. Kuhn" <bkuhn@ebb.org>
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
Date:   Thu, 08 Jul 2021 09:56:05 -0700
In-Reply-To: <YOcakETswyEN58j6@kroah.com>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
         <YOaZohB/2Z3x5grc@kroah.com> <YOcSwXkpzAFGucXM@ebb.org>
         <YOcakETswyEN58j6@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.40
X-Stat-Signature: 475dg3wxf8bgjys8z5wo7iib4gfsknho
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 332772EBFC6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19kIzUQ5SAeC/3sY9lA0yTN+vDwkbWjZK8=
X-HE-Tag: 1625763368-322840
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-07-08 at 17:32 +0200, Greg KH wrote:
> On Thu, Jul 08, 2021 at 07:59:13AM -0700, Bradley M. Kuhn wrote:
> > Greg KH wrote:
> > > Any chance you wish to just change the license of these files, given that
> > > you are the only one that has tried to use it for kernel code?
> > 
> > There is a lot of dual-licensed (GPLv2-only|{2,3}-Clause-BSD) code already in
> > Linux.  Many corporate copyright holders have well documented strong reasons
> > for wanting that.  (Those policy goals and the analysis behind them, I find
> > problematic and sometimes outright wrong, but nonetheless it's their right to
> > license their copyrights that way, and the license *is* GPLv2-only
> > compatible, as is Luis'!).
> > 
> > I assume that you're not asking those companies to relicense to pure
> > GPLv2-only.
> 
> On the contrary, I have stated in public many times to companies that
> try to add dual-licensed new kernel code that they should only do so if
> they provide a really good reason, and pushed back on them numerous
> times.  See the mailing list archives for details if you care.
> 
> So yes, I am asking them, this is not anything new.
> 
> Let's keep it simple please, and not add new licenses for no real good
> reason if at all possible.

You can ask but it's the submitter's choice to license their code
however they desire.


