Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695C02991C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784733AbgJZQEW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 12:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784723AbgJZQD0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 12:03:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2AFF22400;
        Mon, 26 Oct 2020 16:03:25 +0000 (UTC)
Date:   Mon, 26 Oct 2020 12:03:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Message-ID: <20201026120323.14058f56@gandalf.local.home>
In-Reply-To: <20201024103112.64372203e6729279e9ef92f5@kernel.org>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
        <20201023093523.65c495f8@gandalf.local.home>
        <20201024103112.64372203e6729279e9ef92f5@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 24 Oct 2020 10:31:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Perhaps we should have:
> > 
> > 	# older kernels have do_fork, but newer kernels have kernel_clone
> > 	echo kernel_clone >> set_ftrace_filter || echo *do_fork >> set_ftrace_filter  
> 
> Good catch. BTW, can we check the filter-bility by grep the pattern from set_ftrace_filter?

I think we need to use /proc/kallsyms, as the kprobe code should still work
if function tracing is disabled, and the function filter files will not
exist.

-- Steve
