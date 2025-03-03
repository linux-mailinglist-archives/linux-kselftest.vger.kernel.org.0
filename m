Return-Path: <linux-kselftest+bounces-28107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFC6A4CF56
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155633AC9EF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 23:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF623C385;
	Mon,  3 Mar 2025 23:35:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D023BFA6;
	Mon,  3 Mar 2025 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044934; cv=none; b=BzLlnPV4Vn8sCJnAaPQ5eqKy/Hse0OjiwrMZGhlkvuL9rKBawSSVAC1x+utnZbJ1fhF7iPvRXo4b5CQYXBVkjlsY8DSrKfU1UwntA9SlsIzg3MZvyY4iFKcvfyuaJBROJqj1lK9nO9GKFwON3cqGVe2ruvzxSAqyok3r32bFW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044934; c=relaxed/simple;
	bh=GR6hpDShTHYuM5MN65bxH92P4OE/9lJl7f2NLjNYShg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MD7Y4rIovdyx3CEIVlhK5+45jVTp5Bv8lSlnXOBnmexvrW19HJYRtPh8VIG05P/uEyPkvRNu9rrCRafKLAXuOWA9KLu2vjZXlopRqSNNOVQ7QNDVmB6apNd6sTSj5yflveMRZpvo8QlGU02z3OsLuI0sjxCppqWg+DA/HgrEsqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDC0C4CEEA;
	Mon,  3 Mar 2025 23:35:32 +0000 (UTC)
Date: Mon, 3 Mar 2025 18:36:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 skhan@linuxfoundation.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/ftrace: add 'poll' binary to gitignore
Message-ID: <20250303183625.5acc59ec@gandalf.local.home>
In-Reply-To: <20250210160138.4745-1-bharadwaj.raju777@gmail.com>
References: <20250210160138.4745-1-bharadwaj.raju777@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 21:31:34 +0530
Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:

> When building this test, a binary file 'poll' is
> generated and should be gitignore'd.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah,

Can you take this for your tree?

Possibly with:

Fixes: 80c3e28528ff9 ("selftests/tracing: Add hist poll() support test")

So it should go into this rc release.

Thanks,

-- Steve

> ---
>  tools/testing/selftests/ftrace/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ftrace/.gitignore b/tools/testing/selftests/ftrace/.gitignore
> index 2659417cb2c7..4d7fcb828850 100644
> --- a/tools/testing/selftests/ftrace/.gitignore
> +++ b/tools/testing/selftests/ftrace/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  logs
> +poll


