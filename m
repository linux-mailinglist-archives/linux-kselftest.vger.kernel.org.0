Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE610904D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 15:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfKYOp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 09:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfKYOp7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 09:45:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D902068F;
        Mon, 25 Nov 2019 14:45:58 +0000 (UTC)
Date:   Mon, 25 Nov 2019 09:45:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v3 2/4] selftests/ftrace: Fix ftrace test cases
 to check unsupported
Message-ID: <20191125094557.14585d0b@gandalf.local.home>
In-Reply-To: <157466502948.21973.11090994193254792649.stgit@devnote2>
References: <157466501169.21973.31401747181477687.stgit@devnote2>
        <157466502948.21973.11090994193254792649.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Nov 2019 15:57:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since dynamic function tracer can be disabled, set_ftrace_filter
> can be disappeared. Test cases which depends on it, must check
> whether the set_ftrace_filter exists or not before testing
> and if not, return as unsupported.
> 
> Also, if the function tracer itself is disabled, we can not
> set "function" to current_tracer. Test cases must check it
> before testing, and return as unsupported.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
