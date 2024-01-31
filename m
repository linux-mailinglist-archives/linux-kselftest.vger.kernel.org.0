Return-Path: <linux-kselftest+bounces-3853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22480844263
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 16:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D412729670B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2612BE8C;
	Wed, 31 Jan 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+bddtkZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8512BE84;
	Wed, 31 Jan 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712761; cv=none; b=A7KtJU5zexRucxCl0R1b/tdeLq1Oh1mE5ciWhkyIFTt4/s7EDOgVlmqmk3poE/XPcv60l1RpEBzSeqR/3NU9zZLsc2TAynYwBHDSBcc7Jrz1OpfTuHziDgwrcYy9nKZKxLOM7ZDLi4279GF03X89UPIVJcaO+yGqbpySMiAhBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712761; c=relaxed/simple;
	bh=v/kqAugxjJm8wVP0j2KwwdR3hgQFbspT2nVvTeAooBs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ozNAK9WvrGhNqKqcboKQldJFFYzSUCJkYxgTGVJE5uVB02RLn02R9yqfI4b/ZrhRuRfg2DyaTruM7MHt7KDhyrYFh+JUKUf52pApsNlS4quGSerCOr+abP1eQse2TrSDAtk3O9ORURvIKWGuKMeTK4adENBbMC2rTd4a8FGDbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+bddtkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98E8C41679;
	Wed, 31 Jan 2024 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706712760;
	bh=v/kqAugxjJm8wVP0j2KwwdR3hgQFbspT2nVvTeAooBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+bddtkZR3gZkNGTilysjuYhAm1CdHbepWRIoPZrQxC0yPLTXUHXUjQ5YyGLOQUVv
	 4lFjJjn0QxgAxRmw8rbfaVJQmBKJpLKMpA3g/1JR1ojWrY4fh2H6fkEAO5YpE9ze22
	 5oL10bZej+jVwj/SObV1GdMC4uG3qvhFWfKMebCkfk3P0+oTostCWRKNQvrYlQIf5O
	 V1oFeFQAmqKIwkTnWQAxzJHrqbAz3zc6a4g/YBnyhtLPtvABjyh8hO8OS3eCJ/v/AR
	 lshFAUfWl0OXeKRjs/oGhO12atFII6VAwGQIDhs0m3wV/A1bag8orpN3J+VgYcdX4n
	 8MIhSGD3bnC+g==
Date: Wed, 31 Jan 2024 23:52:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftest/ftrace: fix typo in ftracetest script
Message-Id: <20240131235236.749931e31721c892b7591118@kernel.org>
In-Reply-To: <20240129162841.57979-1-five231003@gmail.com>
References: <20240129162841.57979-1-five231003@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 29 Jan 2024 21:58:07 +0530
Kousik Sanagavarapu <five231003@gmail.com> wrote:

> Fix a typo in ftracetest script which is run when running the kselftests
> for ftrace.
> 
> s/faii/fail
> 

Thanks, this looks obvious typo.

> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: dbcf76390eb9 ("selftests/ftrace: Improve integration with kselftest runner")


Shuah, can you pick this to your branch?

Thank you,


> ---
>  tools/testing/selftests/ftrace/ftracetest | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index c778d4dcc17e..25d4e0fca385 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -504,7 +504,7 @@ prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
>  if [ "$KTAP" = "1" ]; then
>    echo -n "# Totals:"
>    echo -n " pass:"`echo $PASSED_CASES | wc -w`
> -  echo -n " faii:"`echo $FAILED_CASES | wc -w`
> +  echo -n " fail:"`echo $FAILED_CASES | wc -w`
>    echo -n " xfail:"`echo $XFAILED_CASES | wc -w`
>    echo -n " xpass:0"
>    echo -n " skip:"`echo $UNTESTED_CASES $UNSUPPORTED_CASES | wc -w`
> -- 
> 2.43.0.443.g6965527da0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

