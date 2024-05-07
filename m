Return-Path: <linux-kselftest+bounces-9574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606908BD946
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 04:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACDB283A5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 02:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4274946A4;
	Tue,  7 May 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdwQiZlm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0D8139F;
	Tue,  7 May 2024 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715047367; cv=none; b=sXuejVUHvAgxxyvwnvsdau0jGqwU4MDv/+pmwaQhg7g95GlDyp1QiZi6J43uKJxt6bDRgCZTgpB4QYPyiUXOVg7+hIxMSapX2SiLmEacIbNkDJz7TIgkxpwXLGu2EukDoeyIAUXHLIsIbAQfUnMTnHTEROUoRXES68qOtqz3H7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715047367; c=relaxed/simple;
	bh=2PbTFHwii7HUApZIxpvCWJSS986WH4OcmVs2GTxmBKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGogmkuEVolbtJHTbxFni4JJNKtRwGyK3PNheuem6aL4N5Rok5ehNUvwUcS/DluWMKZCTJEeytyaG1lkhRHI9VrIBqtpFxoEF6QnNkmnz5MOx9XMJUiLalr0MGUAxOkuHttbrMa7I/+zuJrGlEGSvQxDwKl4dK93sB8QwnWK+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdwQiZlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8039CC116B1;
	Tue,  7 May 2024 02:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715047366;
	bh=2PbTFHwii7HUApZIxpvCWJSS986WH4OcmVs2GTxmBKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OdwQiZlmSF8Zx97j7kVtMYdl6YAp3ouOKiF7LDjDY5v6PFJ3Hoh9w2ZtYJCWZV41y
	 gs+v+oS0eqA0xV8+piM5qli1VlfoVg0n9TTYvb0c9JHHD6Hg8bfr3uzqARz3EZw+Pk
	 nZZivYpDoAcbFfx+2O8D64LPjlwj6igDXzaVIn/VJgIaTRyiNMRIDouVlQfmECqEUX
	 vIf2A6JZ5RTUuI4wPSUz0C8XXOyYqhtVYtu4lv6tt217vR+rc5DEMJ6zYzrdsc76TY
	 mHkGSiN10pm0wHCO0gDOR8fe2vMdgg8f5N/mcKb1AGH/Ejjtc7JEnpQxyL6YcIfenZ
	 kZhjbIbhOV4EQ==
Date: Mon, 6 May 2024 19:02:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v2] selftest: epoll_busy_poll: epoll busy poll
 tests
Message-ID: <20240506190245.3236424c@kernel.org>
In-Reply-To: <ZjmGcPrxhm3mZnCS@LQ3V64L9R2>
References: <20240506205326.70502-1-jdamato@fastly.com>
	<20240506181254.09f10699@kernel.org>
	<ZjmGcPrxhm3mZnCS@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 18:40:00 -0700 Joe Damato wrote:
> Ah, sorry -- this is because I had assumed the test would run without
> CAP_NET_ADMIN, but since:
> 
>   epoll_busy_poll.c:204:test_set_invalid:Expected -1 (-1) == ret (0)
> 
> succeeds (ret = 0), clearly I am mistaken. Sorry about that.
> 
> I think I'll spin up a v3 and I'll add a test with and without
> CAP_NET_ADMIN to check both cases, which would probably be better anyway.

FWIW the tests run a in separate process from the harness, so it may 
be possible to drop privileges inside the test, without affecting other
test cases. But I've never done it myself, so not sure how easy it is
to do in practice..

