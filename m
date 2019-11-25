Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D63109058
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfKYOtV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 09:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbfKYOtV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 09:49:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDBE207FD;
        Mon, 25 Nov 2019 14:49:20 +0000 (UTC)
Date:   Mon, 25 Nov 2019 09:49:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH v3 4/4] selftests/ftrace: Fix multiple kprobe
 testcase
Message-ID: <20191125094918.738f2c0c@gandalf.local.home>
In-Reply-To: <157466504736.21973.15722652829669648396.stgit@devnote2>
References: <157466501169.21973.31401747181477687.stgit@devnote2>
        <157466504736.21973.15722652829669648396.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 25 Nov 2019 15:57:27 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix multiple kprobe event testcase to work it correctly.
> There are 2 bugfixes.
>  - Since `wc -l FILE` returns not only line number but also
>    FILE filename, following "if" statement always failed.
>    Fix this bug by replacing it with 'cat FILE | wc -l'
>  - Since "while do-done loop" block with pipeline becomes a
>    subshell, $N local variable is not update outside of
>    the loop.
>    Fix this bug by using actual target number (256) instead
>    of $N.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

