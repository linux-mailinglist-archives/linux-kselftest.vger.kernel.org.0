Return-Path: <linux-kselftest+bounces-13692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C21930071
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 20:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16757284AE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5223F199C2;
	Fri, 12 Jul 2024 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDxfWKkw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298F18E1A;
	Fri, 12 Jul 2024 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808678; cv=none; b=gCCpSRBHG25CIWCPvvgleqbSBJ0Jv9P1klTM3cOTpU72ur7YAum44++Q7vt34uSXoeaa30tIy6SwNKDpfD6xYCvq3d7z1qnxWQRA7dOAkyHG8MZ49Yi2m0wP+B0re+Bwkeut01plI3wueBqvJJrYLpqEOIhO0ZfiQLld6vTsp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808678; c=relaxed/simple;
	bh=lh4FxyZr5ujAZWVWAD2op6TEZtgNAuCuxfWyGyTGIb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT/VES1Pc8kIWrgWe4URNJjCRM4t7WOZEUE4Uf6hLYi1j1iMs48fBbV3eA5LfcypwupyOLdOlJLMwewjwv1KA3Qpfx3dYdhHFcUkGsJ9+HcZHXgZ/pZDYMlDnC0REW87TxWW9NvCZeL3RExc8ZXE1oCM5FT7jAP6HSjr/PMLwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDxfWKkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955BCC32782;
	Fri, 12 Jul 2024 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720808678;
	bh=lh4FxyZr5ujAZWVWAD2op6TEZtgNAuCuxfWyGyTGIb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDxfWKkw5ZwNZoHJydKqrWHos58LXY4zRxLlfmdRZHOgZZqFB4IV7eGGLNfVbhDkS
	 Q/otgm2TnNu5strPx0MJpKqT61Q9SyJjswnCV4MImmsNcOtZHOfbSaEtNrtgyfq61n
	 XytYyQaAL0qov6cay0IXUJ2s8JOSiqMxdwXTI0nc3ChXK+WReaMpsI9n0Pc+Ql9dFf
	 d4ep9VprsfOcZ2zQRpsJgAQTV6jWu53Hhapvp1rvPTgHn6jI6jxtvW8kNyaRtbvZER
	 mxbvUpUtCWObbhW8KSTTkt3MfejiPZs/Q7alIBugvGS60grB2+55UBtJ90xbSjkGT+
	 dnmHchKJcgZ5A==
Date: Fri, 12 Jul 2024 19:24:33 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: mptcp: lib: fix shellcheck errors
Message-ID: <20240712182433.GD120802@kernel.org>
References: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>

On Fri, Jul 12, 2024 at 12:00:15PM +0200, Matthieu Baerts (NGI0) wrote:
> It looks like we missed these two errors recently:
> 
>   - SC2068: Double quote array expansions to avoid re-splitting elements.
>   - SC2145: Argument mixes string and array. Use * or separate argument.
> 
> Two simple fixes, it is not supposed to change the behaviour as the
> variable names should not have any spaces in their names. Still, better
> to fix them to easily spot new issues.
> 
> Fixes: f265d3119a29 ("selftests: mptcp: lib: use setup/cleanup_ns helpers")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - The mentioned commit is currently only in 'net-next', not in 'net'.

Reviewed-by: Simon Horman <horms@kernel.org>


