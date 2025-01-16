Return-Path: <linux-kselftest+bounces-24614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB1FA130C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 02:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6AD7A289F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D47082D;
	Thu, 16 Jan 2025 01:26:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA27081E;
	Thu, 16 Jan 2025 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990765; cv=none; b=NQCD6bKCQjjNaRSrrzcwQXYjv8K/xN2cSLGnMXQrIqjt5Mdq8/NYO0vBm7LAMzwlYlDOeVDEoVY+nMwp3t0H2oqwFQWMd8p3MlQ/MGpqkxF5PKQYsDMGMpcosralG8+kaTjBjlZrhGolQpnmVCSugYDcAPIcCbaHKvKIwnUnCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990765; c=relaxed/simple;
	bh=pSvb5rA0KfQChoFQgwIadgXedTvHP2ksEjvitzMOW6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8Wn17YZW/4OyuId7ZYNxVuFkgoLEQMT7ZqZO+bxlC4s+4xTouyRXvMo5pS1ZENdhkeJS7ezLA3mOCqY+jYaNTXkkVQ6PRvBODkSxnn0lEsdw1E2mP6Mri/52TZBR51LxYmlfAM9/sh2VTSDYPrWD7my9Pxit0bawm9dZ1CM/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FCFC4CED1;
	Thu, 16 Jan 2025 01:26:03 +0000 (UTC)
Date: Wed, 15 Jan 2025 20:26:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not
 the instances
Message-ID: <20250115202607.00c6d353@gandalf.local.home>
In-Reply-To: <20250115191758.35b62738@gandalf.local.home>
References: <20250115191758.35b62738@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 19:17:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> For the tests that have both a README attribute as well as the instance
> flag to run the tests as an instance, the instance version will always
> exit with UNSUPPORTED. That's because the instance directory does not
> contain a README file. Currently, the tests check for a README file in the
> directory that the test runs in and if there's a requirement for something
> to be present in the README file, it will not find it, as the instance
> directory doesn't have it.
> 
> Have the tests check if the current directory is an instance directory,
> and if it is, check two directories above the current directory for the
> README file:
> 
>   /sys/kernel/tracing/README
>   /sys/kernel/tracing/instances/foo/../../README

This is the same patch as:

  https://lore.kernel.org/all/20250116012041.326701057@goodmis.org/

But as there are other patches that depended on it, I just added this one
into a patch set with them. But decided not to make that patch set a v2 as
there was no changes with this one.

Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p

-- Steve


> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  tools/testing/selftests/ftrace/test.d/functions | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 779f3e62ec90..9f2a67fbaf4d 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -156,7 +156,13 @@ check_requires() { # Check required files and tracers
>                  exit_unsupported
>              fi
>          elif [ "$r" != "$i" ]; then
> -            if ! grep -Fq "$r" README ; then
> +	    # If this is an instance, check the top directory
> +	    if echo $TRACING_DIR | grep -q "/instances/"; then
> +		test="$TRACING_DIR/../.."
> +	    else
> +		test=$TRACING_DIR
> +	    fi
> +            if ! grep -Fq "$r" $test/README ; then
>                  echo "Required feature pattern \"$r\" is not in README."
>                  exit_unsupported
>              fi


