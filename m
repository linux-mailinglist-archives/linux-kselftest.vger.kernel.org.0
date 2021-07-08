Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87E3C18AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhGHRzu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 13:55:50 -0400
Received: from protestant.ebb.org ([50.56.179.12]:37644 "EHLO
        protestant.ebb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHRzu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 13:55:50 -0400
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by protestant.ebb.org (Postfix) with ESMTPSA id 9DD828208F;
        Thu,  8 Jul 2021 10:53:05 -0700 (PDT)
Date:   Thu, 8 Jul 2021 10:52:54 -0700
From:   "Bradley M. Kuhn" <bkuhn@ebb.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <YOc7dgBq/N5vDjhx@ebb.org>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
 <YOaZohB/2Z3x5grc@kroah.com>
 <YOcSwXkpzAFGucXM@ebb.org>
 <YOcakETswyEN58j6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOcakETswyEN58j6@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Greg KH wrote:
> Let's keep it simple please, and not add new licenses for no real good
> reason if at all possible.

I've stated a number of real good reasons to keep copyleft-next as a
dual-licensing option; they seem to have not been refuted here. Indeed, this
point is quite salient:

Joe Perches wrote:
>>> You can ask but it's the submitter's choice to license their code however
>>> they desire.

… to which I'd add, as long as the license is GPLv2-only-compatible, which of
course (GPLv2-only|copyleft-next) is.


Rest is admittedly a bit OT:

Greg also noted:
> I have stated in public many times to companies that try to add
> dual-licensed new kernel code that they should only do so if they provide a
> really good reason

We can agree to disagree on the differences in how company vs. individual
requests and their "good reasons" are handled/prioritized; I think we'd both
agree it's actually moot anyway.  While it's an important topic, I apologize
for raising that as it was off-topic to the issue at hand.

On that off-topic point, Tim Bird added:
>> It's not at all purely symbolic to dual license (GPLv2-only|2-Clause-BSD).
>> That dual-licensing has allowed the interchange of a lot of code between
>> the BSD Unixes and Linux, that otherwise would not have happened.

This is a good point, but the same argument is of course valid for
copyleft-next-licensed projects.  While there are currently fewer than those
than BSD-ish projects, I don't think Linux should stand on ceremony of “your
project must be this tall to ride this ride” and share code with us … and
then there are the aspirational arguments that I made in my prior email.
--
Bradley M. Kuhn - he/him

Pls. support the charity where I work, Software Freedom Conservancy:
https://sfconservancy.org/supporter/
