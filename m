Return-Path: <linux-kselftest+bounces-23922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894DA019B4
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA15A1882E15
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D424143C40;
	Sun,  5 Jan 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUy5pprJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7A42A93;
	Sun,  5 Jan 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736086953; cv=none; b=WjQvF16derT+TuVP1uvoie4uyOrO/mWJd9GrF3v5fNky6Gmuoig6i/JC4enbfkSeA7w+tzpmYbStdnauTlKT6dbgkSihsN0YwG4KUS58fQTkHRSbv1bhFyC/F/bxO5DdTxGi/HcuART3d9w710FGO1CaYXrGqJoFrug8QwZ4tFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736086953; c=relaxed/simple;
	bh=o0vjkhKP3lbGLakXGR25MuS5hNOiRQSUwIloZwYrbRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSRB/oP+Ycb8OjAs45Xg6U1q8qj9KmfpLMOHNRATJLmZ1ZgldCb8QOiw+tBvE41LlkJXaB9QUlS/odj/ybaBKBPAtSqnPYYUvTXCvH6mB0lvZrITPW9dYOiffP6E7Pl2wVvuw9pP2itN1SCfdDFd8eK4guWO6Lze9TJmvtIjqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUy5pprJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D832C4CED0;
	Sun,  5 Jan 2025 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736086952;
	bh=o0vjkhKP3lbGLakXGR25MuS5hNOiRQSUwIloZwYrbRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUy5pprJ31qbPGclJoZtCgn4ILdc+/Vh6t+HBIdeHEJLzTfdeVcyRQ6xb3p9W4YEI
	 9P7v1mmqd8GQuzbZGCU2IqM2tfO4/p0RBKT3uiv5Il3TExhsdNyVC/UbPrpMeql1YM
	 tl4XkIvPC8b+eUblR3n0YjGRMuXAwEgNmgOAqa1YDAU7k3SSwy0rfQs6QnoRGOJbgK
	 EA9zQyisuvgVGyX9tTAaHDoAMK7+MaBwFhH3g2DgdTmGCUaV/9ttmNKF2ay+kqVGLj
	 KZ5bjSaejazgnGiVlwJ1bKbwXrOOwuhS4pS4YNVNYWTMrspfzlHof5BgoSbWfiEYuD
	 yOTF0IAzcZD/Q==
Date: Sun, 5 Jan 2025 09:22:31 -0500
From: Sasha Levin <sashal@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	rust-for-linux@vger.kernel.org,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: rust/kernel/lib.rs:17:12 : warning: the feature `new_uninit` has
 been stable since 1.82.0 and no longer requires an attribute to enable
Message-ID: <Z3qVp1m8zKiMrtnd@lappy>
References: <CA+G9fYvM96LS63Wa1+5Md9w0V0JZgBW+f50kzx9RjRCYj3aDkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYvM96LS63Wa1+5Md9w0V0JZgBW+f50kzx9RjRCYj3aDkA@mail.gmail.com>

I'm sorry, this is my bad: I haven't realized anyone else will be
looking at these results...

Naresh, I'm cheating and using this tree to bisect the issue you've
originally reported in
https://lore.kernel.org/all/CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com/
.

It seems we can't get traction to get it fixes, so I'm trying to make
forward progress.

Please ignore linus-next for the next day or two :)

-- 
Thanks,
Sasha

