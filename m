Return-Path: <linux-kselftest+bounces-29366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C2A67ABC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C8C3BE382
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10E820E708;
	Tue, 18 Mar 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrxJrSQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF551A8F89;
	Tue, 18 Mar 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318464; cv=none; b=VlhUuCqI2Np9Oo3PbZgIrlmaS2jouShyKe/gOofomgmrnPJRS65UGKHikbLmV0n5sJJ/rTqyQcserer7vWHhrSav/eqD+AplPg1bN4NVbRHXTUhzo1YMZTWsVr8cY5mV6lFk4nZTY41015zQTuZoDqpvB7yBiII1rl7BRtcNVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318464; c=relaxed/simple;
	bh=86feaT24MiY33wMZOb5aKO2/GBTDif7HKriJHjPlljU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsXEuRgRMgGxzw/Fx0LBfYHM7BTpPYNWbFtA/RbTH6D5vDYEOEzlBGj4fZaUn/wONL6NxZWepeOIftGk0C3Ts+u8vibyDXIxPoyd/Jg7wAFEdPKvfcbL7pjzW8QXBPBZDpSLhqJGC+jS4dt9EusIJjD8P8gN5wOr9ryOjjjeoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrxJrSQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEB9C4CEDD;
	Tue, 18 Mar 2025 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318463;
	bh=86feaT24MiY33wMZOb5aKO2/GBTDif7HKriJHjPlljU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrxJrSQ4CjihIOi1nem74TlmbSDlDE9/NYBf3Pu7P/HA8TTB8mprCBJGZnSUoVO5U
	 wP+jcOB8ijQrFeW3j+09mNB9Ra/IemvNStFdwkYwYvJ2nocTFPFj8d6BLVocX8J2Qo
	 9Vh17mnC7ljbdchhumWdRqRr4qhmVLpRjnTecmEUhTLkaKhgBLlESzvZreES3RwFQ7
	 ZROl7SV8bH0D52WNCkJOg3RiI+Ie6bYP8aQ3hIJ73CGa9nD7QCqkKtIWjXfa9/UKph
	 1DNLcJlXpWYkSqj1Bplo6s5L8sk9vFjVYZyGYafX2s3A/57Fhd6nA5HqR8TjoGHYq/
	 ZZmwM4HsYXGCg==
Date: Tue, 18 Mar 2025 17:20:59 +0000
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
Subject: Re: [PATCH net-next 03/12] mptcp: pm: use pm variable instead of
 msk->pm
Message-ID: <20250318172059.GH688833@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
 <20250313-net-next-mptcp-pm-ops-intro-v1-3-f4e4a88efc50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-3-f4e4a88efc50@kernel.org>

On Thu, Mar 13, 2025 at 11:20:52AM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The variable "pm" has been defined in mptcp_pm_fully_established()
> and mptcp_pm_data_reset() as "msk->pm", so use "pm" directly instead
> of using "msk->pm".
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


