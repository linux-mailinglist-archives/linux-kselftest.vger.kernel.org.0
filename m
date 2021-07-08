Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E488B3C15AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 17:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGHPJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 11:09:45 -0400
Received: from protestant.ebb.org ([50.56.179.12]:37442 "EHLO
        protestant.ebb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPJp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 11:09:45 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 11:09:44 EDT
Received: from localhost (unknown [216.161.86.19])
        (Authenticated sender: bkuhn)
        by protestant.ebb.org (Postfix) with ESMTPSA id C8C59820B2;
        Thu,  8 Jul 2021 07:59:46 -0700 (PDT)
Date:   Thu, 8 Jul 2021 07:59:13 -0700
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
Message-ID: <YOcSwXkpzAFGucXM@ebb.org>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
 <YOaZohB/2Z3x5grc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOaZohB/2Z3x5grc@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


[ Full Disclosure: I've written parts of copyleft-next, have been involved
  with the initiative basically since its inception, and obviously I like the
  license a lot.  Take my comments with the recommend dose NaCl granules
  those facts require. ]

Greg KH wrote:
> Any chance you wish to just change the license of these files, given that
> you are the only one that has tried to use it for kernel code?

There is a lot of dual-licensed (GPLv2-only|{2,3}-Clause-BSD) code already in
Linux.  Many corporate copyright holders have well documented strong reasons
for wanting that.  (Those policy goals and the analysis behind them, I find
problematic and sometimes outright wrong, but nonetheless it's their right to
license their copyrights that way, and the license *is* GPLv2-only
compatible, as is Luis'!).

I assume that you're not asking those companies to relicense to pure
GPLv2-only.  While those companies perhaps faced early resistance when they
began their dual-licensing-in-upstream endeavor, it was ultimately accepted
and that opens the door, IMO, to accepting any form of GPL-compatible
dual-licensing upstream.  There is no cogent argument that I can see that
says “(GPLv2-only|{2,3}-Clause-BSD) is so special that it should be
grandfathered in over other forms of dual licensing”.

(Ironically, IIRC, (then acting on behalf of Qualcomm/Atheros, Luis — the
person proposing the (GPLv2-only|copyleft-next) dual-licensing *now* was a
champion of upstreaming (GPLv2-only|{2,3}-Clause-BSD) code years ago before
it was a wide and common practice.)

> As a follow-up to this, I do not want to see your "test_sysfs.c" module as
> a dual-licensed file, as that makes no sense whatsoever.  It is directly
> testing GPL-v2-only code, so the attempt to dual license it makes no sense
> to me.  How could anyone take that code and do anything with it under the
> copyleft-next license only?  And where would that happen?

But, it's a valid compatible license, so there is no harm.  And, see below,
regarding policy reasons …

> I understand the appeal of copyleft-next in that it resolves many of the
> "grey" areas around gplv2, but given that no one is rushing to advise us to
> relicense all of the kernel with this thing,

Consider me to be the first to advise that!  I realize it's a tough thing to
do, but every great adventure to solve a big problem starts with a first
step!  I further realize it's a non-starter, but please don't say again no
one has advised you such!

BTW, the only reason I didn't advise it because I know a top-level license
change away from straight, no-exceptions/no-additional-permissions GPLv2-only
is a non-starter for the Linux community.  (Great, BTW, that you've stuck so
firmly to your steadfast plan on this!)

Greg continued:
> there is no need to encourage the spread of it given the added complexity
> and confusion that adding another license to our mix can only cause.
Relatedly, Christoph asked (footnote mine):
>> Why do we need a random weirdo [0] license in the kernel tree?  Is there
>> any benefit?

To be frank, we in the copyleft-next community were very excited to learn
that such dual-licensed code had been added to upstream Linux, back when it
was many years ago.  It's a vote of confidence from a well-known developer
who really is excited about our policy goals.  FOSS licensing isn't just
about simplicity and cleanliness.  Like budgets, which seem dry topics on
surface, they are actual moral documents that make a statement about the
philosophy and aspirations for software freedom by the licensor.  Of course,
we all know it's completely symbolic to dual license
(GPLv2-only|copyleft-next), just like it's purely symbolic to dual license
(GPLv2-only|2-Clause-BSD) upstream [1].  But it makes a statement that I
think is a good one.

Finally, while GPLv2-only compatibility has been a mainstay so far in
copyleft-next drafting, it's not clear to me that we can keep that
compatibility forever and reach copyleft-next's policy goals.  There's been
no discussion of this yet, but it's certainly in the realm of possibility.
If GPLv2-incompatibility ultimately happens in future copyleft-next versions,
having dual-licensed code out there will be a huge help as it will assure
that code can forever be used both on GPLv2-only and copyleft-next sides of
future single-license-project equations.

Thanks for listening; of course it's the sole prerogative for the copyright
holder to decide whether to change the license of their code or not, and I
hope that they don't bow to pressure, just as Qualcomm wouldn't bow to
pressure if you started asking them to stop dual licensing all their upstream
Linux code under BSD licenses.

[0] BTW, Christoph, I remember when I started in FOSS in the early 1990s,
    everyone called the GPL a “random weirdo license”.  The incumbent always
    seems not as random and weirdo as the challenger.

[1] There is the argument that 2-Clause-BSD has fewer requirements than
    GPLv2-only; however, that's not an argument to release the code
    *upstream* that way, it's an argument to release a separate version under
    2-Clause-BSD.

--
Bradley M. Kuhn - he/him

Pls. support the charity where I work, Software Freedom Conservancy:
https://sfconservancy.org/supporter/
