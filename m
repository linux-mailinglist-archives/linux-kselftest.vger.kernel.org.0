Return-Path: <linux-kselftest+bounces-15288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441795112E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 02:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E18284C5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D335259C;
	Wed, 14 Aug 2024 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt6UbDym"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD3631;
	Wed, 14 Aug 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596809; cv=none; b=TirsvQQjdi+7lwWHM3eOmdU4pBgpV2imSoWgL1eXJriu/dBwkfjRG52OTE28oLr6JogAyg3YnT/BO4setWSA7EScg8UAf8ylQes1Kfr4Vj8LltUP9yIBqIsj7iZEPLU2MWb9ysZHWIKqlALPipDSE+dPF085KMUPr3ZeSnxhNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596809; c=relaxed/simple;
	bh=wu6a4y75kESiXxUTS6ksfYqStN0mqW6kZ03x0lVfkeI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BGEsQCrAfONu6JlSbYv3MBqGPlTL0LDN4nWeMouQIiK5p98GWeKwYpaa59rC3sK5iUpY6AvVi3gD/bQbKJ7cZmQrFWhdWJpChYJbav5mwrKycnCol/aaiiApxNFmVF/lSs5T1a95pEuZsmDd2+/Qob2k3vxavmAjNzxwO3brNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt6UbDym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FA6C32782;
	Wed, 14 Aug 2024 00:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723596808;
	bh=wu6a4y75kESiXxUTS6ksfYqStN0mqW6kZ03x0lVfkeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bt6UbDymPWn8POyWEBLw3O4MnAvJrhPd1B4GTUdIkVJRNRFqkSrFqOOz1K2VkhCKC
	 ZO+6XiWRXVngcnEsegaitrY//YKeliiq0S2SflNqjt0IpVRbJ//tRJPdZ+4usD3mVY
	 sCCGatIqzLia3/WbmBNSYSkJyXjlfNhPkn7c3DKYQ15TWHCOdqFgCQlHziMpacaM0k
	 xZAayNDU3ICBKpHeKeSP05GUa0L85f8zdYZZw7RHE8uVM/HN7Emm/TsGm3VkUDo0le
	 GeR1twyCJvVL9Fs17G0l0IqwTr0tkbBXVas6IBoXas2chRY0o/C5bKtS55d/TJGc7M
	 Ti5kM2gzJ8hTw==
Date: Wed, 14 Aug 2024 09:53:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <shuah@kernel.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add required dependency for kprobe
 tests
Message-Id: <20240814095323.c8458e2cb6031c3014a7b7e0@kernel.org>
In-Reply-To: <171823033048.152840.662759412433336839.stgit@devnote2>
References: <171823033048.152840.662759412433336839.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Shuah,

Can you pick this? I confirmed this can be applied on v6.11-rc3.



On Thu, 13 Jun 2024 07:12:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> kprobe_args_{char,string}.tc are using available_filter_functions file
> which is provided by function tracer. Thus if function tracer is disabled,
> these tests are failed on recent kernels because tracefs_create_dir is
> not raised events by adding a dynamic event.
> Add available_filter_functions to requires line.
> 
> Fixes: 7c1130ea5cae ("test: ftrace: Fix kprobe test for eventfs")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_char.tc       |    2 +-
>  .../ftrace/test.d/kprobe/kprobe_args_string.tc     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> index e21c9c27ece4..77f4c07cdcb8 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Kprobe event char type argument
> -# requires: kprobe_events
> +# requires: kprobe_events available_filter_functions
>  
>  case `uname -m` in
>  x86_64)
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> index 93217d459556..39001073f7ed 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Kprobe event string type argument
> -# requires: kprobe_events
> +# requires: kprobe_events available_filter_functions
>  
>  case `uname -m` in
>  x86_64)
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

