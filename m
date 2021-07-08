Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342D83C1A54
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGHUKs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jul 2021 16:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhGHUKr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jul 2021 16:10:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E60613BA;
        Thu,  8 Jul 2021 20:08:02 +0000 (UTC)
Date:   Thu, 8 Jul 2021 16:08:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Bradley M. Kuhn" <bkuhn@ebb.org>,
        Greg KH <gregkh@linuxfoundation.org>, tglx@linutronix.de,
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
Message-ID: <20210708160800.75b7c86d@gandalf.local.home>
In-Reply-To: <20210708193746.7e2dbpgs33cl73wx@garbanzo>
References: <20210707184310.3624761-1-mcgrof@kernel.org>
        <YOaZohB/2Z3x5grc@kroah.com>
        <YOcSwXkpzAFGucXM@ebb.org>
        <YOcakETswyEN58j6@kroah.com>
        <YOc7dgBq/N5vDjhx@ebb.org>
        <20210708150158.08ba548c@gandalf.local.home>
        <20210708193746.7e2dbpgs33cl73wx@garbanzo>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 8 Jul 2021 12:37:46 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> The Signed-off-by tag implies you are making a contribution under the
> same license as the license file states. The more people are aware of
> this fact, the better, and its then why we made DCO a public thing and
> now other projects embrace it.

Ah, I forgot it was "per-file" and not "per-project". That's the difference.

-- Steve
