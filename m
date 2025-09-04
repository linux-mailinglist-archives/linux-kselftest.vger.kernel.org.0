Return-Path: <linux-kselftest+bounces-40807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4703B448E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 23:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD825A65D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6992D3ECC;
	Thu,  4 Sep 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzBe+Cu8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6B2D29D7;
	Thu,  4 Sep 2025 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023168; cv=none; b=LKV6N3mSPym3t2pdaXmq/7mnwSsbtsACaQVLK+99OfMorhMtK8VR7GpUXpxymH4VOT/vlcubbOTTJcMCcg7c/PTzg52VresoY+vls/8h/BcYvQj3jk2cozNOgnpO8pwWdDxpgpO3Vpxz0lIri1cIXwbwNkvc9DlY/E6E3gDQ6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023168; c=relaxed/simple;
	bh=v3lystvLeot+6/SWLgp9xylE+fag16+7WPr29APprdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBrxSTVhCoVeAeVlkbfQsVi7Zu5KczHGF8Dg7dCfN3uXeBukXGXXJxpTRP0m6ypJo+DaAd+qE/SMhCi20jMqdEPr004i54RlirLNqYZIgf/HDxLq1+8y5qDPD2XHtLQAgDPOeNZa1Us8mqboxtAfwBo6ZFoolhDqyyhU4MZ4Y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzBe+Cu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA96BC4CEF0;
	Thu,  4 Sep 2025 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757023167;
	bh=v3lystvLeot+6/SWLgp9xylE+fag16+7WPr29APprdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qzBe+Cu8e9bl8ZEG2xM7fVHDnagWJ1a4hJq0t4SZOfGwelcUfNezBuLwZub777MLw
	 gOyXZ5LrXI/iq+pRrxtlCVd8UaXsq9Za0yAuu0wg73cXQWauYEXvYYPvEenm4OkOjU
	 pWbE9WTJsELw1Jd9QVh6ZehXjhXpUItdtk/hwyGnlap4vLKaOEVla6sR0y1Y2wsOUK
	 ROXc3cHkiXnJvKe8LklltNkF20LlqO/Y6QZXW6a5R/A4shmX5Ur3nLmZi4yvJqc0bj
	 duGr4gD3tq1riqbA+Y1aQ5cycbm27rkUktUSfkpp+gw91znNxUnxCSmIagxfncD+Yj
	 uECRjAjKx5x+w==
Date: Thu, 4 Sep 2025 14:59:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/2] net: selftest: Introduce netconsole
 torture test
Message-ID: <20250904145925.101e2091@kernel.org>
In-Reply-To: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
References: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Sep 2025 11:00:39 -0700 Breno Leitao wrote:
> Create a netconsole test that puts a lot of pressure on the netconsole
> list manipulation. Do it by creating dynamic targets and deleting
> targets while messages are being sent. Also put interface down while the
> 
> In order to do it, refactor create_dynamic_target(), so it can be used to
> create random targets in the torture test.

You either have to post it in the same series as the fix, or wait for
the fix to be present in net-next. Without your pending fix this will
obviously not pass thru the CI :/

