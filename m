Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DBF10A34A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfKZRYG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 12:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfKZRYG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 12:24:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426E8206BF;
        Tue, 26 Nov 2019 17:24:05 +0000 (UTC)
Date:   Tue, 26 Nov 2019 12:24:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v4 1/4] selftests/ftrace: Fix to check the
 existence of set_ftrace_filter
Message-ID: <20191126122403.79705b9e@gandalf.local.home>
In-Reply-To: <157475725551.3389.16908546371847626653.stgit@devnote2>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
        <157475725551.3389.16908546371847626653.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Nov 2019 17:34:16 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> If we run ftracetest on the kernel with CONFIG_DYNAMIC_FTRACE=n,
> there is no set_ftrace_filter and all test cases are failed, because
> reset_ftrace_filter() returns an error.
> Let's check whether set_ftrace_filter exists in reset_ftrace_filter()
> and clean up only set_ftrace_notrace in initialize_ftrace().
> 
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

