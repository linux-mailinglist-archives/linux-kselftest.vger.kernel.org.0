Return-Path: <linux-kselftest+bounces-26598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B160A3516B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 23:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC816B7A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A926E156;
	Thu, 13 Feb 2025 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaDOWZ0k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE422661B9;
	Thu, 13 Feb 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486688; cv=none; b=jukgGh+7FrAvcBfcO3mvnda72ISWR8X/3ektuZcaGnAX6AsnkpDS0DOS8sdei1pzXiH8EIgcQ8YXhfMQlY5W14oDMJFGyAHZ54KVrHq2ht0xQpyCcago6RGL+vkNv8NWuTfzMem2RDDFIh1c9MS1O3j/3z0zNFYTPJZHqc0DyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486688; c=relaxed/simple;
	bh=jK5ZTCGq+m3U/cm67MVV+AZIQJNGQtNxU9otloqcwg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bq/gu6feqqAMNtky0VyzHaoykD+9IuqWzTcAJClWQd8yl6x+uGjCs6frqpf/mybB95/jvBzeGTA+wv1v+1cp2lEXpUv/vGh5Up7O7tk5NGJ27wVDb0hxS3l4g+ezLPPtXbpWkFPt4r7ig8Eif4axAaFGxLQvPqCSHhCLbawLgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaDOWZ0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E982C4CED1;
	Thu, 13 Feb 2025 22:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739486687;
	bh=jK5ZTCGq+m3U/cm67MVV+AZIQJNGQtNxU9otloqcwg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oaDOWZ0k1qtPbvi4siYNey0eHnBY1TXD0HLa27lEpWxER+PeNB41jRTsGKhCWIO+t
	 P3JAYoAOM97BWfY2+DmOp9a/54+f53OudJesfYH5rEnfTGk96D4bYH2jSaq7/I0lE9
	 hN7QqUwPJIEcf3CTz4a01iKtjjuHfgLgz2Zgif2gUa5u0Zt65dHZDg3kluntcHKzhB
	 2flsyDPO+5yBzpr6LCfMEgC4GPsvGjFLuxyeUeu7QJrdAA1ggj+yvbBjQ8Ecwcc69q
	 BdKTkUHyDwQXfKAA0tgpc3/8+VSrhw4w6sjqGGaQq1AAp0jqwHw+pMiaqAlrcoISKV
	 SHkcWtsRNrvxA==
Date: Thu, 13 Feb 2025 16:44:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-kselftest@vger.kernel.org, martineau@kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] Adds colors to kselftest output
Message-ID: <20250213224445.GA137109@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213212858.710884-1-marcelomoreira1905@gmail.com>

I'm confused about why we need this patch, but some overall hints:

Run "git log --oneline tools/testing/selftests/net/mptcp/mptcp_lib.sh"
and make your subject line match the prefixes and overall style:

  $ git log --oneline tools/testing/selftests/net/mptcp/mptcp_lib.sh
  5fbea888f8aa ("selftests: mptcp: add -m with ss in case of errors")
  8c6bb011e188 ("selftests: mptcp: move stats info in case of errors to lib.sh")
  f58817c852e9 ("selftests: mptcp: lib: add time per subtests in TAP output")
  20ccc7c5f7a3 ("selftests: mptcp: join: validate event numbers")
  464b99e77b3d ("selftests: mptcp: lib: fix shellcheck errors")
  1af3bc912eac ("selftests: mptcp: lib: use wait_local_port_listen helper")
  f265d3119a29 ("selftests: mptcp: lib: use setup/cleanup_ns helpers")
  5597613fb3cf ("selftests: mptcp: lib: support flaky subtests")
  ...

So your subject line should probably be:

  selftests: mptcp: lib: add colors to kselftest output

One could argue for "selftests: mptcp:", but generally those touch
multiple files.

On Thu, Feb 13, 2025 at 06:28:16PM -0300, Marcelo Moreira wrote:
> This commit improves the readability of kselftest results by adding
> ANSI color codes to the [ OK ] and FAIL messages.

s/This commit improves/Improve/

See:
  https://chris.beams.io/posts/git-commit/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-tip.rst?id=v6.11#n134

> Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 051e289d7967..7b55855ff788 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -83,7 +83,7 @@ mptcp_lib_print_err() {
>  
>  # shellcheck disable=SC2120 # parameters are optional
>  mptcp_lib_pr_ok() {
> -	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
> +	mptcp_lib_print_ok "\033[32m[ OK ]\033[0m${1:+ ${*}}"

I'm confused.  Did you look at the implementation of
mptcp_lib_print_ok()?  It looks like this:

  mptcp_lib_print_ok() {
	  mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}"
  }

So it looks like this should already be colored.

If there's something broken here, I would take a look at 747ba8783a33
("selftests: mptcp: print test results with colors") and cc the author
when fixing it.

>  }
>  
>  mptcp_lib_pr_skip() {
> @@ -97,7 +97,7 @@ mptcp_lib_pr_fail() {
>  		title="IGNO"
>  		cmt=" (flaky)"
>  	else
> -		title="FAIL"
> +		title="\033[31mFAIL\033[0m"
>  	fi
>  
>  	mptcp_lib_print_err "[${title}]${cmt}${1:+ ${*}}"
> -- 
> 2.48.1
> 

