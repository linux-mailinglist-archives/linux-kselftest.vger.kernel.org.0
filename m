Return-Path: <linux-kselftest+bounces-44108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B40C0EF1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CA03A7A90
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF54309F13;
	Mon, 27 Oct 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9eLsuyu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B592F690B;
	Mon, 27 Oct 2025 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578379; cv=none; b=gdHAWzzlFLWOWnxWhlVxQmqy/WbKGqEXUUH9kX4xcd8369nVsHX2Scs6CksMgYiy1n2z45pskW7SdzK4q+hYf4D6YXp0dX4S03EIZklxizCcl4drBgogE4TNjNaFV95qZgNjcXEItJVb37k+D2Gssf8X+bNGY4bTDg9dIqpTVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578379; c=relaxed/simple;
	bh=BMapSBYAO53AJvc4WTEhyEXvhYKAuV0mXHwxj9h9aHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzOa/nLpEtKazahoRGbrRi50bQiuV99CJmSJeq2mAXJQLrj9LkQzYmo7n1zshsPbJfhgDTJuCKKl9ArER80P3xTyiNtWXHJp70+GRLNW05no1frM5D5bK57jGclD4iAXEgMkSi76Gqy4YvgdX7Ea3tJRRZ00LUPM6T8ztG0CDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9eLsuyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FCFC4CEFF;
	Mon, 27 Oct 2025 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761578378;
	bh=BMapSBYAO53AJvc4WTEhyEXvhYKAuV0mXHwxj9h9aHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M9eLsuyuaL3gq3sqSRLpyKhN+KHGut4HbGKh2FsxoVNRdkC36ADnJFMrp+jklVmlL
	 QnprKg0YFBYVKT43cr4GubNJ65fzPer6vZGREjfmOga3yvDNQBONztC+p4AWaJBVum
	 ujYBxCjH00QACKSxjpxl3PQudAPusWPSLY1m1q2daB/bpmUvVQAcWiSoQoB/e7q8Dt
	 SkEx+j0UuhhkmUEplj+6sQY/FCZihmmcJxbS1kATjMdVBmRLZ4FQWR7ITflaBwLwxn
	 boMQ7QlcT8/y1aDDzJM63/S+e9qSMx/i/XUbbY/zndARO364l2VSpryIJWIPhrvZiq
	 r18qCM4CcaxrQ==
Date: Mon, 27 Oct 2025 08:19:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Xing <kernelxing@tencent.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftest: net: fix variable sized type issue not at
 the end of a struct
Message-ID: <20251027081937.3b89d06f@kernel.org>
In-Reply-To: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
References: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 11:01:56 +0530 Ankit Khushwaha wrote:
> -		struct cmsghdr cm;
>  		char control[512];
> +		struct cmsghdr cm;

This is no longer in the order in which it will appear in the msg.
If the struct placement is not important just use a raw char buffer
for the whole thing.

Before you repost please read at least the TLDR section of:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr

