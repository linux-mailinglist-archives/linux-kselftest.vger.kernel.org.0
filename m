Return-Path: <linux-kselftest+bounces-29365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF3A67AAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AAA7AD307
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB4211A11;
	Tue, 18 Mar 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0Tj55FY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385619ABAB;
	Tue, 18 Mar 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318432; cv=none; b=rlV+J1HoAiiX4uYc8qj4USTjG1GNZ8R3iC310jiSyofMOC8vW1iuD+6pY+6nj6rOQt7TOCqmeTVNNQUUWm57qlHKKgCetIQ4uawLx+/fQQgI8AmRLU7/Lmzki2kO39hOmo3Qc2gzAg8goE5maW6GfURKrg7IeBPT1dubTNgs8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318432; c=relaxed/simple;
	bh=vNeLf5ICm5WMxAWbfNRIaGRxIZX4ZMchxZkDu4V47Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l//3fA+fhfo2r0WDXt9R3teEnMh248IxO3YX4Jv/wRcFXLR2TugfNrnCXQUcPfE/ckt5yCRIF5H/txHzRZ8UFR+9zEWjwXs98iqGruopsWl4zTfqEUnEMHAIQEIGOGYez1bbX4s+5CyD7/oi4WUkvhc1O/nff5naPKlMbVbWOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0Tj55FY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675C4C4CEF0;
	Tue, 18 Mar 2025 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318432;
	bh=vNeLf5ICm5WMxAWbfNRIaGRxIZX4ZMchxZkDu4V47Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0Tj55FYw4qqHJGeeDPbUjy3WOINYLMGd+sc2sh+XfFaN8zBmq0LyHhw5oJLcRKy/
	 q2GGShCxvVmtR/HikuYWZU2DXqIVYFf1q0HC6NxJZE28J0CcHWR9RDhmYSwyenH/4L
	 3dGw24LebdNgdVmQFVdIndEVjlS5ZM3AzPVKsvaghl3nuRt81JjQuMT1MaVdeEI7vX
	 TBsmJtapkz49/k4qHlvbLsxZnLfFgnjUP/diZpTc4ZlDLKbJbuyLB4gLdLmJlEB5VU
	 OjJB0cMjhWOFUAYBYJ20W/2ytUUEWnsWdO7x8mQmrkNR0OZF212UgofgCIWqUm+tb5
	 VILMq9keqOsIA==
Date: Tue, 18 Mar 2025 17:20:27 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] mptcp: pm: in-kernel: use kmemdup helper
Message-ID: <20250318172027.GG688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-2-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-2-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:51AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Instead of using kmalloc() or kzalloc() to allocate an entry and
> then immediately duplicate another entry to the newly allocated
> one, kmemdup() helper can be used to simplify the code.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


