Return-Path: <linux-kselftest+bounces-27424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B87A43B31
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6313A859C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F375264A96;
	Tue, 25 Feb 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUyebjXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEF260A29;
	Tue, 25 Feb 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478673; cv=none; b=dbHY+p5WtLo+5Sp4iwdNZDd2jnDqb5Xz+5lMpGMLjr7Toj4e2nlP8+TwkQ3yXW/GKknjSYlDYYmxrKBe2LNQUDZWorbDNg2VgQoqRHLvOh+6ozDxO7RfPeIM7w5jlejdT0dnO5as1/+CsPJXRiuY2CW5b1yovUvUCZqa9dM3WVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478673; c=relaxed/simple;
	bh=j7ZWzbcY6LF/84Ab6jSz8hN9Q0IKWKnjg82GiTmzuok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPoG6WwiLRN08ibFHAFflAQGNs87BW/A5kS2zu5VfiKEz7/uvBYP+RPfG399jkPNQdI+4Fy+TvX9fR3uHsmNdIq1DigBQ2unVcYStQZI3NUj2h2r9M8Ppat3ZAGy0dXnIEBKLTc5xa3X88xj4WWdrWaI+qnHEohxK202Wf50dPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUyebjXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571C7C4CEE7;
	Tue, 25 Feb 2025 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478672;
	bh=j7ZWzbcY6LF/84Ab6jSz8hN9Q0IKWKnjg82GiTmzuok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUyebjXSwlGrCGbzPfXT0PDlvUffsJwiSbeH3uTC0AKDtgJjCPpMTxKxu3BVOmU7e
	 6PbM3sLGc4gBEBpQP8p2nxDHdwU5XdVRDMJaJ1nCQW+Nsifg7+y/CBhtG6G7ckGYRo
	 hJueuivdKiCTweBj28Cc2z+YwrcltJh9158+1MwYjlGdlT/0fsNpql5LcgXkvyV0bZ
	 nqcBjrHa8isoSpL3qS1X5g1xtal6LMg+biqmHdHRpSM6JjvDay8bgrOayhVuuAUsjj
	 C9jT8A0moIlDdo2T3yeN2Yf9UFBI8F2b/AMGKygk9tiYTfSSVz/LVZisQivAKoR1Lu
	 omTcpJMhabZjQ==
Date: Tue, 25 Feb 2025 10:17:48 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/7] netconsole: refactor CPU number formatting
 into separate function
Message-ID: <20250225101748.GL1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-2-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-netcons_current-v1-2-21c86ae8fc0d@debian.org>

On Fri, Feb 21, 2025 at 05:52:07AM -0800, Breno Leitao wrote:
> Extract CPU number formatting logic from prepare_extradata() into a new
> append_cpu_nr() function.
> 
> This refactoring improves code organization by isolating CPU number
> formatting into its own function while reducing the complexity of
> prepare_extradata().
> 
> The change prepares the codebase for the upcoming taskname feature by
> establishing a consistent pattern for handling sysdata features.
> 
> The CPU number formatting logic itself remains unchanged; only its
> location has moved to improve maintainability.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index c086e2fe51f874812379e6f89c421d7d32980f91..26ff2ed4de16bce58e9eeaf8b5b362dfaafaca0a 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1117,13 +1117,21 @@ static void populate_configfs_item(struct netconsole_target *nt,
>  	init_target_config_group(nt, target_name);
>  }
>  
> +static int append_cpu_nr(struct netconsole_target *nt, int offset)
> +{
> +	/* Append cpu=%d at extradata_complete after userdata str */
> +	return scnprintf(&nt->extradata_complete[offset],
> +			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
> +			 raw_smp_processor_id());
> +}
> +
>  /*
>   * prepare_extradata - append sysdata at extradata_complete in runtime
>   * @nt: target to send message to
>   */
>  static int prepare_extradata(struct netconsole_target *nt)
>  {
> -	int sysdata_len, extradata_len;
> +	int extradata_len;
>  
>  	/* userdata was appended when configfs write helper was called
>  	 * by update_userdata().
> @@ -1133,12 +1141,8 @@ static int prepare_extradata(struct netconsole_target *nt)
>  	if (!(nt->sysdata_fields & SYSDATA_CPU_NR))
>  		goto out;
>  
> -	/* Append cpu=%d at extradata_complete after userdata str */
> -	sysdata_len = scnprintf(&nt->extradata_complete[nt->userdata_length],
> -				MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
> -				raw_smp_processor_id());
> -
> -	extradata_len += sysdata_len;
> +	if (nt->sysdata_fields & SYSDATA_CPU_NR)
> +		extradata_len += append_cpu_nr(nt, nt->userdata_length);

Hi Breno,

As this is the only caller of append_cpu_nr() I'm wondering
if it would be nicer if nt was the only argument to append_cpu_nr().

Not a big deal either way, so the above notwithstanding:

Reviewed-by: Simon Horman <horms@kernel.org>

>  
>  	WARN_ON_ONCE(extradata_len >
>  		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);
> 
> -- 
> 2.43.5
> 
> 

