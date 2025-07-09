Return-Path: <linux-kselftest+bounces-36789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D3AFDD9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 04:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC111C24593
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13EE1D61A3;
	Wed,  9 Jul 2025 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="YeGZXVxu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lovable-gwydion.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.216.144.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951511D54F7;
	Wed,  9 Jul 2025 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.216.144.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029095; cv=none; b=eU6/avF1LEI4D3Czi2wU9hNAg4MI7usd8KnGCUZ4Ok3mG4QKBb6Xmf8LjGR+thJL1/ee0NdY4FqCcGoBGAw3gELORjd4rrrwxzZf+A8uPrAL3OHAEhr7Cj2qF0ET8UOV/WliXOnQ55zTxwuyU86daqjHvv2DD9HiEfKBuUJIx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029095; c=relaxed/simple;
	bh=AUjRfsmtfEtzEUulCJjdYlIztPE4v3RWoPJHKXE92Ng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OLusSkPk4z85dCjGKTmbJxnkWkCHse11wBGQrf9g3DXxE2bJ0bqyJx0LDWXNPVuIDKzUJYKHayURDHdQXUTCr0sDhMUgzcTl/4qGi3sIL6WV5qvRpdUnwVewJUsZ5vM2mW4KGaKBm25/Wt7N0ILHf61WKswdsebcc47q1pXX/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=YeGZXVxu; arc=none smtp.client-ip=18.216.144.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from inspiring-wechuge.authn-relay.a.mail.umich.edu (ip-10-0-74-32.us-east-2.compute.internal [10.0.74.32])
	by lovable-gwydion.relay-egress.a.mail.umich.edu with ESMTPS
	id 686DD72E.389596A4.14DF24C4.1013114;
	Tue, 08 Jul 2025 22:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1752028969;
	bh=FgUb7F7hDUYl370c9CJvKvlQkXQ8nsxDnF74XDbF674=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=YeGZXVxuyGbgnA5hJR3YYD5GgOmJAEkFshCKTJkA6QLLJGoV6urMLLfeljiubUtbS
	 Ps+8nfF5ctnEW18BAh67ei9JQ3gpZbz7UFfhIokAicR4nVTpRcanI7CT0rAfOitNWs
	 ZZUcq7cmcasPl3wzf4gEc8JE4/Q1oGHbgVqrvt2Sm4aJrGHQjiAgg74wlhTyJjUCXk
	 v8IuP3j2nERJXv+29iU31Ac4CoaUpuAYgrdpHofQptIqzps8yB077puK8mXJ5aTCi/
	 ZPBZa6XI5JpxmBOGMq/yuB0ai6JN/rGYpyS7FcNLKI7g5tRPCB0Yyanp/hzXK9jB7y
	 /VwIdg2BZ817g==
Authentication-Results: inspiring-wechuge.authn-relay.a.mail.umich.edu; 
	iprev=pass policy.iprev=185.104.139.75 (ip-185-104-139-75.ptr.icomera.net);
	auth=pass smtp.auth=tmgross
Received: from localhost (ip-185-104-139-75.ptr.icomera.net [185.104.139.75])
	by inspiring-wechuge.authn-relay.a.mail.umich.edu with ESMTPSA
	id 686DD726.2E0AACB5.716CEEF3.1030639;
	Tue, 08 Jul 2025 22:42:49 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 22:42:45 -0400
Message-Id: <DB76FN8WH6HK.1LST75877I45J@umich.edu>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
 <gregkh@linuxfoundation.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <davidgow@google.com>,
 <nm@ti.com>
Subject: Re: [PATCH v4 3/6] drivers: gpu: switch to `#[expect(...)]` in
 nova-core/regs.rs
From: "Trevor Gross" <tmgross@umich.edu>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
X-Mailer: aerc 0.20.1
References: <20250701053557.20859-1-work@onurozkan.dev>
 <20250701053557.20859-4-work@onurozkan.dev>
In-Reply-To: <20250701053557.20859-4-work@onurozkan.dev>

On Tue Jul 1, 2025 at 1:35 AM EDT, Onur =C3=96zkan wrote:
> This makes it clear that the warning is expected not just
> ignored, so we don't end up having various unnecessary
> linting rules in the codebase.
>
> Some parts of the codebase already use this approach, this
> patch just applies it more broadly.
>
> No functional changes.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  drivers/gpu/nova-core/regs.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.r=
s
> index 5a1273230306..87e5963f1ebb 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -2,7 +2,7 @@
>
>  // Required to retain the original register names used by OpenRM, which =
are all capital snake case
>  // but are mapped to types.
> -#![allow(non_camel_case_types)]
> +#![expect(non_camel_case_types)]
>
>  #[macro_use]
>  mod macros;
> --
> 2.50.0

Reviewed-by: Trevor Gross <tmgross@umich.edu>

