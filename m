Return-Path: <linux-kselftest+bounces-30443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114EBA82CD8
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 18:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4873AA8A4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E508726FD9C;
	Wed,  9 Apr 2025 16:47:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C389326FD99;
	Wed,  9 Apr 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217257; cv=none; b=RXRl+/BwY3bGm0BKGE5yzUfim6nh1LtHmMVlMlqMLm1m6vxTo5uRlvBnYeGGqF/DeIBDu6rIPsuTPanRdBKRqh53FXts/dRuRh28/2OsBlGzWv8peS6zHTCz1zNyJAsmUMOWrDjXM7sxMLQv2h9paQ/747eMUyf6pmxm8zdYgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217257; c=relaxed/simple;
	bh=Hjw4v5OLo085UBRbutbpnMjWuHi68TiVyARn066UPRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtwkTyAdhIl7ep3hGpffnVhBWQfVTr1e9zW9lOpsHU33SHon2He7EJWs5auu9j6wQ4i/X9NSqvv+Cg8JyXk0Yytps3GOWG6Ix5TAn4CTFpC8nNXSqJaUBlfo49Z5zUUjE/zAr5SUY1KfMEYKTVhdTq3BkAstAiikhLm9sL4QOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C303C4CEE2;
	Wed,  9 Apr 2025 16:47:36 +0000 (UTC)
Date: Wed, 9 Apr 2025 12:48:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ayush Jain <Ayush.jain3@amd.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <Naveen.Rao@amd.com>,
 <Kalpana.Shetty@amd.com>, <Narasimhan.V@amd.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/ftrace: Convert poll to a gen_file
Message-ID: <20250409124855.4dc8fd58@gandalf.local.home>
In-Reply-To: <20250409044632.363285-1-Ayush.jain3@amd.com>
References: <20250409044632.363285-1-Ayush.jain3@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 04:46:32 +0000
Ayush Jain <Ayush.jain3@amd.com> wrote:

> Poll program is a helper to ftracetest, thus make it a
> generic file and remove it from being run as a test.
> 
> Currently when executing tests using
>     $ make run_tests
>       CC       poll
>     TAP version 13
>     1..2
>     # timeout set to 0
>     # selftests: ftrace: poll
>     # Error: Polling file is not specified
>     not ok 1 selftests: ftrace: poll # exit=255
> 
> Fix this by using TEST_GEN_FILES to build the 'poll' binary as a helper
> rather than as a test.
> 
> Fixes: 80c3e28528ff ("selftests/tracing: Add hist poll() support test")
> 
> Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  tools/testing/selftests/ftrace/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> index 49d96bb16355..7c12263f8260 100644
> --- a/tools/testing/selftests/ftrace/Makefile
> +++ b/tools/testing/selftests/ftrace/Makefile
> @@ -6,6 +6,6 @@ TEST_PROGS := ftracetest-ktap
>  TEST_FILES := test.d settings
>  EXTRA_CLEAN := $(OUTPUT)/logs/*
>  
> -TEST_GEN_PROGS = poll
> +TEST_GEN_FILES := poll
>  
>  include ../lib.mk


