Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A43C198A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGHTEp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 15:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhGHTEp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 15:04:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAAB161864;
        Thu,  8 Jul 2021 19:01:59 +0000 (UTC)
Date:   Thu, 8 Jul 2021 15:01:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Bradley M. Kuhn" <bkuhn@ebb.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, tglx@linutronix.de,
        akpm@linux-foundation.org, shuah@kernel.org, rafael@kernel.org,
        rgoldwyn@suse.com, kuno@frob.nl, fontana@sharpeleven.org,
        Ciaran.Farrell@suse.com, Christopher.DeNicolo@suse.com, hch@lst.de,
        corbet@lwn.net, linux@leemhuis.info, ast@kernel.org,
        andriin@fb.com, daniel@iogearbox.net, atenart@kernel.org,
        alobakin@pm.me, weiwan@google.com, ap420073@gmail.com,
        tj@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        keescook@chromium.org, jikos@kernel.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-spdx@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH 0/2] LICENSES: add and use copyleft-next-0.3.1
Message-ID: <20210708150158.08ba548c@gandalf.local.home>
In-Reply-To: <YOc7dgBq/N5vDjhx@ebb.org>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
        <YOaZohB/2Z3x5grc@kroah.com>
        <YOcSwXkpzAFGucXM@ebb.org>
        <YOcakETswyEN58j6@kroah.com>
        <YOc7dgBq/N5vDjhx@ebb.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 8 Jul 2021 10:52:54 -0700
"Bradley M. Kuhn" <bkuhn@ebb.org> wrote:

> Joe Perches wrote:
> >>> You can ask but it's the submitter's choice to license their code however
> >>> they desire.  
> 
> … to which I'd add, as long as the license is GPLv2-only-compatible, which of
> course (GPLv2-only|copyleft-next) is.

I agree with Joe on this, but I have to ask; What happens when someone
makes a change to this file? The default kernel license is GPL-v2. Does this
change automatically become the same as the file itself, or is the new
change under the dual license?

I've made changes to code that had a dual license that wasn't GPL
compatible, and the company involved asked me to sign off on the other
license (which I did).

-- Steve
