Return-Path: <linux-kselftest+bounces-5447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC718867F69
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 18:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542ECB21102
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049F12CD8E;
	Mon, 26 Feb 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnVScf5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058F12C815;
	Mon, 26 Feb 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970292; cv=none; b=Lzkt90LDxsDZulFS+GHICudMXJGJhwF5vDGrPYC8QJpxkL2wUVuL88qGxZlhK4APRKuR1i4ZqD+/INC/Mee+dqCFTS8ab4ClWIDRPhHM3hxAZLpyMakpqIKpfHHhBp58T8OYFKIbcXeDymTXw7t65jZtdOu5DHMOzvrwqOCx3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970292; c=relaxed/simple;
	bh=mXtVnnZU5KldRH/xAQBuuqOy4rYUXPWyBCIe0Ahw4DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2UJydDXFW7o+mfSOwiytSMs+oelAiTAPuCtRW2qZnTQri8g30rMJL0QpUa/Ru10LFYn5M0XtrGdnpWm7CCk+Yct0DSviGiFIvRIpnCeceD/OGT4GjAG3SpeF5Ahzz0HCPLv5fUu643gwkfKYI+WP76X8EBom1pZJ5rEff1Wttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnVScf5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6668C433C7;
	Mon, 26 Feb 2024 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708970291;
	bh=mXtVnnZU5KldRH/xAQBuuqOy4rYUXPWyBCIe0Ahw4DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnVScf5Ql39ByDTDraRO5HJefp1ts2WNx7YSyg0S473pWGzF+mUaYmexthRZAvHRG
	 MXnsLGH1IZSftf29Pq1zDBIGpMW16NEjMuTDdbdnocr0Z4jLwo++AH5420p4XkbLck
	 muptFsm3DmCIUHMjeaVNJB1ou69kCgFcvxQWZLCp0sN39JESkafDLiKs/J6OB1xhRD
	 yLqoAgb1h7bYehmhJg34m64npHE9AW7yAI/C3Xo8mVbEs+kaE4Uy2EPK5Tc0Y8bBQ8
	 p3vc6PjkQNWScqRv47Kl+eo+2G0KvqZEdOKnn/zbQ3Jf1RQXFXv0fWdINNF8uePaXt
	 13AXreIPxRUEQ==
Date: Mon, 26 Feb 2024 17:58:06 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Christoph Paasch <cpaasch@apple.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 10/10] selftests: mptcp: explicitly trigger the
 listener diag code-path
Message-ID: <20240226175806.GI13129@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
 <20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org>

On Fri, Feb 23, 2024 at 05:14:20PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> The mptcp diag interface already experienced a few locking bugs
> that lockdep and appropriate coverage have detected in advance.
> 
> Let's add a test-case triggering the relevant code path, to prevent
> similar issues in the future.
> 
> Be careful to cope with very slow environments.
> 
> Note that we don't need an explicit timeout on the mptcp_connect
> subprocess to cope with eventual bug/hang-up as the final cleanup
> terminating the child processes will take care of that.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


