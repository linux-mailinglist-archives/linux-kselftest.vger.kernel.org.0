Return-Path: <linux-kselftest+bounces-27732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC2A47A04
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 11:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D233D1890A2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F421C18F;
	Thu, 27 Feb 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4QEwvXy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E7C16F288;
	Thu, 27 Feb 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651672; cv=none; b=ZXnjwUCQbU79JTJTVJbSFDyVfnnHoV1G/foSYTjpMCSM7X75/BHwTPcxgAhNObTSRsjyvu4RyunoITvL6XJqovl6H+T6xsR09NRzTlXBDruUt8A5o3PgPTBpa3wt8xjHuEVg0RtuGjQAJ5pQWcp5eirL3U3TbNrpaJomZCxQE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651672; c=relaxed/simple;
	bh=zzDvwBXSETxn6mtxn28zBZtjFE3PxW01NrJVoVK6EB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLdvShpMYu0qZwYZA/sw7RzzNZAI4MYJ7ZyHD6MY00vdcsDoG9z0gSTjshHwtyiErRCBe9urr88QiFvoyLTUHMqUjiK0hXk4aBmYM0f4ik78LA0Mdij0Na1bhg1LPTr1pCDk0jbzC2Bl+HTmxvyqF3/3vqe4FiKohThVUq7aTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4QEwvXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB6FC4CEDD;
	Thu, 27 Feb 2025 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740651671;
	bh=zzDvwBXSETxn6mtxn28zBZtjFE3PxW01NrJVoVK6EB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4QEwvXyIGTKI/Cw3d6dhYL+0enHdms9zJXo0DRmpmGdr49LQj6+DEQxZMLv2qUGi
	 E7LUMw1KQIWwiwlvoJX1AOGWjInogALlcpGz43y0cCk7rA+/GtjD62F9pqoo85CcCy
	 KmL2LepzyWEfligZF2OiogFhtH9guSkg5HjBjVYXCc0VxP0JY48tabydNNfj+hEtrj
	 Z3f5WWQjsU4igRMelz9vZcJ526p7WJLFoLMF0SDSq8wcLOxwYPpafMcreut8jjPknJ
	 0IgCjQX/2W3qccBaXjkcnwmKJgrbwzTQNfti5alJfNQ0YttHSvpZaL+RRWj3xZZv7O
	 6vTI5GfBS068g==
Date: Thu, 27 Feb 2025 10:21:07 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v7 1/8] net: pktgen: fix mix of int/long
Message-ID: <20250227102107.GA3016957@kernel.org>
References: <20250224092242.13192-1-ps.report@gmx.net>
 <20250224092242.13192-2-ps.report@gmx.net>
 <20250224103856.31dc0260@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224103856.31dc0260@gmx.net>

On Mon, Feb 24, 2025 at 10:38:56AM +0100, Peter Seiderer wrote:
> Hello *,
> 
> On Mon, 24 Feb 2025 10:22:35 +0100, Peter Seiderer <ps.report@gmx.net> wrote:
> 
> > Fix mix of int/long (and multiple conversion from/to) by using consequently
> > size_t for i and max and ssize_t for len and adjust function signatures
> > of hex32_arg(), count_trail_chars(), num_arg() and strn_len() accordingly.
> >
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> 
> Actual missing the rev-by Simon Horman given for the v5 version of the
> patch set (see [1]) and indicated in the change description v5->v6...

No problem, let's use this:

Reviewed-by: Simon Horman <horms@kernel.org>

