Return-Path: <linux-kselftest+bounces-49314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A4D39B12
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 00:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8313E3004C8F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678D311C3D;
	Sun, 18 Jan 2026 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWIEJVCz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1301311C09;
	Sun, 18 Jan 2026 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768777665; cv=none; b=ei2q1Rz8XKc3y9mEiIZxKDSWRu4/W75RQGiQa9HEb47MG7af8w+aAoI7gM2gkd4B8HGYdIpLu+rUYcZRWWlxRoTRB1uR6qKwkVc/y+sqrwLkaXUGuocTAUSc7tjxdxS85yWWMdZuwCGd662G1Zaz19XpqT1csTdjCprz6nVw740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768777665; c=relaxed/simple;
	bh=h8Epw65Z4emZnyiRgunzZI2qtVkcD7Q6LdFv1Pb9c2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UycPf00KxRSyzUvEaOJ2xiqOb08aTE6TasNASaZgcGYtLwHnavay63VDwm/5eoFyWfPJxXfSn5dQqg/0/h1WdyP2O5AWw5q1nTqjfAfxGZYF/bpQ4lekhAIul7yDFU0oTeFdjIZTJW1dmcfhrFmLq6MojYqAOMSPD6SrPQsc+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWIEJVCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A803C116D0;
	Sun, 18 Jan 2026 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768777665;
	bh=h8Epw65Z4emZnyiRgunzZI2qtVkcD7Q6LdFv1Pb9c2g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fWIEJVCznsFRAYGJ5CQnVqrB3MyXoABTOl21a8qunCRHuZ9dL3VLiZA0CZuR4XyK9
	 ZaTNx0lz/K6+xEN1qq61FNp2wcAsjUEdF+GjfjotLiPub9WSGpHcsqxsE/nmuycloS
	 thWLrYYc1pTujvt90aESTCRU91X7yaTCe/dhLoQhai0xV4LfUzpSM8Qdc3p1vAPqAU
	 0COa/A3akKSOFYXfj/XHwu6ChMrgj5zUemcWTlma5TXxjOOZLzGkWB3hNHGjcg1OJT
	 jW4s0bipLq8s8qf2qkJbsSNOZi2jvrJjphPBFzga7cYIwyzVxjpW2Ik/GlqYt5wOvv
	 0RsupwhTlQ5Uw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 00:07:39 +0100
Message-Id: <DFS3CN1KBISV.UEWSY7ATBH94@kernel.org>
Subject: Re: [PATCH] rust: use consistent backtick formatting for NULL in
 docs
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Brendan Higgins" <brendan.higgins@linux.dev>, "David
 Gow" <davidgow@google.com>, "Rae Moar" <raemoar63@gmail.com>, "Peter Novak"
 <seimun018r@gmail.com>, <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-clk@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "KUnit
 Development" <kunit-dev@googlegroups.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251130211233.367946-1-seimun018r@gmail.com>
 <DEMK8K1I3FFY.27ERA2LKI7MYB@nvidia.com>
 <CANiq72=BN3gQfBX-0abv+8hDKDL20JC5G0U0BS=r3nY5VB4a0g@mail.gmail.com>
In-Reply-To: <CANiq72=BN3gQfBX-0abv+8hDKDL20JC5G0U0BS=r3nY5VB4a0g@mail.gmail.com>

On Sun Jan 18, 2026 at 11:14 PM CET, Miguel Ojeda wrote:
> It would be nice to have Acked-by's for them

Acked-by: Danilo Krummrich <dakr@kernel.org>

