Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE64F29B0FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 15:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901667AbgJ0OZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 10:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2901662AbgJ0OZv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 10:25:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC6E22258;
        Tue, 27 Oct 2020 14:25:50 +0000 (UTC)
Date:   Tue, 27 Oct 2020 10:25:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] selftests/ftrace: Use $FUNCTION_FORK to reference
 kernel fork function
Message-ID: <20201027102548.713c4604@gandalf.local.home>
In-Reply-To: <20201027223831.dba931ab868584fc999b0617@kernel.org>
References: <20201026162032.124c728d@gandalf.local.home>
        <20201027223831.dba931ab868584fc999b0617@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 27 Oct 2020 22:38:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > 
> > Fixes: eea11285dab3 ("tracing: switch to kernel_clone()")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Shuah,

Can you take this through your tree?

Thanks!

-- Steve
