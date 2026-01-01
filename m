Return-Path: <linux-kselftest+bounces-48057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B0CED867
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 23:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73F7130012D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 22:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F7226D4F9;
	Thu,  1 Jan 2026 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpRHWOmq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCB1EE7B9;
	Thu,  1 Jan 2026 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307687; cv=none; b=LLCVPXHcfrVw4OVnVTpfdTu9Mwj+ey42fXLcE/QQfm5lFBAB/7svspdXOIusACpR1f1KaU5LpC8jGq2zXnJQ/Xr1RmUPq1vegpwI0ivosDSIDZJlDJXovO+eBhjerrrvj2s2TQJwU22stKfx0I1NKa/MtyDfMdwGCm9qUPjnOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307687; c=relaxed/simple;
	bh=tptO1M75uAITg/xEG4wkC/11aCQhVh6vPc1jHQqyomI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAZTNJgoQ5zxNXIEv2o5oTEg9KbfoDKPRopokPfJ/Jx4RpnUxgNB9zeHtRuylmyNpURyWVz4CBH7syHyvabjh6oEGta2u5/BBtNBv7ghwqemZBzECdGJqkZjZDUjT3xE74BmEr2GeR34p3xhQOvN1+RnbGr1IiHfhBj0WPcoj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpRHWOmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D92C4CEF7;
	Thu,  1 Jan 2026 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767307687;
	bh=tptO1M75uAITg/xEG4wkC/11aCQhVh6vPc1jHQqyomI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IpRHWOmqGaMhubw2iqYMNYbuIa18uupX7jEWCtYGno8s05s7tzTlLNi7oDIkMrNX/
	 Nyb+ye23fYbZ2ulfJ9TQyIP8jq9ithq45csF0cvnzh5jQXOXftHn3UzfOo/+j1HMsM
	 V102japFRpOKW6whZ7CokKAysRPctmywmTYyyfBkN1Wi/fYYnxe2Y9t/b340M40Cl+
	 GK+iuG0RPH27szUMbAjmKgVCDnnGZ9+WUlxeHTepW57v0b+XCscWb5hV/5uohjI8lM
	 W/N36/4FQcBC+IlT6c3UdMhUYAgjE53ZVNV8V4YTfxglgT51rGQ9Jw0qQo1sdsZBLH
	 Ppq0C+Y2Eou0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8175ECE11A4; Thu,  1 Jan 2026 14:48:06 -0800 (PST)
Date: Thu, 1 Jan 2026 14:48:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 8/8] rcutorture: Add --kill-previous option to
 terminate previous kvm.sh runs
Message-ID: <0fb9fa43-9e64-4ada-9bb2-c15102dab482@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-9-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101163417.1065705-9-joelagnelf@nvidia.com>

On Thu, Jan 01, 2026 at 11:34:17AM -0500, Joel Fernandes wrote:
> When kvm.sh is killed, its child processes (make, gcc, qemu, etc.) may
> continue running. This prevents new kvm.sh instances from starting even
> though the parent is gone.
> 
> Add a --kill-previous option that uses fuser(1) to terminate all
> processes holding the flock file before attempting to acquire it. This
> provides a clean way to recover from stale/zombie kvm.sh runs which
> sometimes may have lots of qemu and compiler processes still disturbing.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

For #7 and #8:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

One way to kill the current/previous run without starting a new one is
to use the --dryrun argument.

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/kvm.sh | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index d1fbd092e22a..65b04b832733 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -80,6 +80,7 @@ usage () {
>  	echo "       --kasan"
>  	echo "       --kconfig Kconfig-options"
>  	echo "       --kcsan"
> +	echo "       --kill-previous"
>  	echo "       --kmake-arg kernel-make-arguments"
>  	echo "       --mac nn:nn:nn:nn:nn:nn"
>  	echo "       --memory megabytes|nnnG"
> @@ -206,6 +207,9 @@ do
>  	--kcsan)
>  		TORTURE_KCONFIG_KCSAN_ARG="$debuginfo CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
>  		;;
> +	--kill-previous)
> +		TORTURE_KILL_PREVIOUS=1
> +		;;
>  	--kmake-arg|--kmake-args)
>  		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
>  		TORTURE_KMAKE_ARG="`echo "$TORTURE_KMAKE_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
> @@ -278,6 +282,25 @@ done
>  # Prevent concurrent kvm.sh runs on the same source tree.  The flock
>  # is automatically released when the script exits, even if killed.
>  TORTURE_LOCK="$RCUTORTURE/.kvm.sh.lock"
> +
> +# Terminate any processes holding the lock file, if requested.
> +if test -n "$TORTURE_KILL_PREVIOUS"
> +then
> +	if test -e "$TORTURE_LOCK"
> +	then
> +		echo "Killing processes holding $TORTURE_LOCK..."
> +		if fuser -k "$TORTURE_LOCK" >/dev/null 2>&1
> +		then
> +			sleep 2
> +			echo "Previous kvm.sh processes killed."
> +		else
> +			echo "No processes were holding the lock."
> +		fi
> +	else
> +		echo "No lock file exists, nothing to kill."
> +	fi
> +fi
> +
>  if test -z "$dryrun"
>  then
>  	# Create a file descriptor and flock it, so that when kvm.sh (and its
> @@ -287,7 +310,7 @@ then
>  	then
>  		echo "ERROR: Another kvm.sh instance is already running on this tree."
>  		echo "       Lock file: $TORTURE_LOCK"
> -		echo "       To run kvm.sh, kill all existing kvm.sh runs first."
> +		echo "       To run kvm.sh, kill all existing kvm.sh runs first (--kill-previous)."
>  		exit 1
>  	fi
>  fi
> -- 
> 2.34.1
> 

