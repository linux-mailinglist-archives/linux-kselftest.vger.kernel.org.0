Return-Path: <linux-kselftest+bounces-10639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CB8CDEFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 02:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CF728323A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978914C99;
	Fri, 24 May 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJVXwHyB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B47EEAA;
	Fri, 24 May 2024 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511681; cv=none; b=HBK+XLeGKuDxlrD5jJonJfr3aoC322mOXE4vO5IlpHf92bz95aiWJnYHD4JQ0N6HpHI+qDq2UJb1iyJMy/Zoxmm/Xd3+D2weO30z9PP7yqt4IUwpMUUPieSy0StQ4Pn6iV5j3p0e2NH0zm1WWbHTkME0jJPKLeDXk8dSA2ZnBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511681; c=relaxed/simple;
	bh=KTLZyqwm/bxcyXU3DPeiOAIMZgJ5GgaNFY5/kM7KbLU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X4G8RJqMIPjYJdT4RiifZMCBPwoVA1VXYiOCl2dhFmaKKA1tvHPJEfV034iF/buNHNviQVK8HAVQZt1sjV6skt9K0CkGOXfvP+UENeRjSX+F6FIyZ9JWy4TOaYvJGia+XSKft7EySAsym6whzAQCYFrAyeQOyJmz23tm8O/6B9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJVXwHyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63488C2BD10;
	Fri, 24 May 2024 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716511680;
	bh=KTLZyqwm/bxcyXU3DPeiOAIMZgJ5GgaNFY5/kM7KbLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HJVXwHyBeyjEK2zCH6OXcGN4I66qDgnXHSDTawSc6CCcqN6Mpn+rjN+4VhWGQtB0z
	 5Wb7Rh3vgJVQa0iYsVSLoaBd+bIB/1UJlioxRr/dSI4ytyDrDjACbERKDSxjEOqN93
	 W3YViq2y0S9HLU0APvM8EFvwUlk+A4o0QBa5NcgJSFnNSMAI723Kd9jimTI+rnr4AE
	 DVUsnZR0ab9VYpgU9ptXpGA41DjQksOSNgQNtvSTvny2zPNZ7/vrvDJY6nUGyvYmVJ
	 kDDsDK6Zqlp1EFfYNTSvS8uAMLdOxUrhlg1/e2YcPPwPSuQjtFeuYQgUcLswnvD1gt
	 AOfa9LwoKpAcA==
Date: Fri, 24 May 2024 09:47:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ali Zahraee <ahzahraee@gmail.com>, Shuah Khan <shuah@kernel.org>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing/selftests: Run the ownership test twice
Message-Id: <20240524094756.1f3dc4f67ea174770f54fdff@kernel.org>
In-Reply-To: <20240523124541.7dd4cca9@gandalf.local.home>
References: <20240523124541.7dd4cca9@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 12:45:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A regression happened where running the ownership test passes on the first
> iteration but fails running it a second time. This was caught and fixed,
> but a later change brought it back. The regression was missed because the
> automated tests only run the tests once per boot.
> 
> Change the ownership test to iterate through the tests twice, as this will
> catch the regression with a single run.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/00basic/test_ownership.tc   | 34 +++++++++++--------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> index c45094d1e1d2..71e43a92352a 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> @@ -83,32 +83,38 @@ run_tests() {
>  	done
>  }
>  
> -mount -o remount,"$new_options" .
> +# Run the tests twice as leftovers can cause issues
> +for loop in 1 2 ; do
>  
> -run_tests
> +	echo "Running iteration $loop"
>  
> -mount -o remount,"$mount_options" .
> +	mount -o remount,"$new_options" .
>  
> -for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> -	test "$d" $original_group
> -done
> +	run_tests
> +
> +	mount -o remount,"$mount_options" .
> +
> +	for d in "." "events" "events/sched" "events/sched/sched_switch" "events/sched/sched_switch/enable" $canary; do
> +		test "$d" $original_group
> +	done
>  
>  # check instances as well
>  
> -chgrp $other_group instances
> +	chgrp $other_group instances
>  
> -instance="$(mktemp -u test-XXXXXX)"
> +	instance="$(mktemp -u test-XXXXXX)"
>  
> -mkdir instances/$instance
> +	mkdir instances/$instance
>  
> -cd instances/$instance
> +	cd instances/$instance
>  
> -run_tests
> +	run_tests
>  
> -cd ../..
> +	cd ../..
>  
> -rmdir instances/$instance
> +	rmdir instances/$instance
>  
> -chgrp $original_group instances
> +	chgrp $original_group instances
> +done
>  
>  exit 0
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

