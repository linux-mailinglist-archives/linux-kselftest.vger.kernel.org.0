Return-Path: <linux-kselftest+bounces-36786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71233AFDD87
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 04:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1CE5682DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333D1B87F0;
	Wed,  9 Jul 2025 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ayaLvZBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from epicurean-pwyll.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C38BF8;
	Wed,  9 Jul 2025 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.217.159.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028634; cv=none; b=lGuHqFpf0upbE2ttNTdHEqJaGvHCt62UOw7px/y7pcNpxcDOFfBKIKFqR0X7mdL/bVxXLa1TXg2d1PuGJY+XzxX/TYE+7477BeGww54Sd7C2O+1vhXNz8A+8NXhkZOXxG1WzrMw9qA7s6JNPlkGmAT/VWFvAUVrGjZxsowUEUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028634; c=relaxed/simple;
	bh=qkGyhBPpreHdiKwWw2Tr8HKQXsHYRnX4CD2RBL+eBbo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gvT2ucNVjtMAhNw/EKCXbLj6v83DZYnJxjuUq/qrg4QfQteK/Bkm1Nkf9uag0wHAiLnXgH96pnuQMg4soT0ERf0c3O3yrz9aDamBG9g7oZcfkQtI3Di4IPTaAC5H+Kw9ddSd4eCkiHjahVF5xTXa3KgWTP6J/3p+mJbh4tY8/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ayaLvZBa; arc=none smtp.client-ip=18.217.159.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from debonair-kikimora.authn-relay.a.mail.umich.edu (ip-10-0-72-73.us-east-2.compute.internal [10.0.72.73])
	by epicurean-pwyll.relay-egress.a.mail.umich.edu with ESMTPS
	id 686DD516.13FB9855.A9186EB.3869983;
	Tue, 08 Jul 2025 22:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1752028433;
	bh=qGl8TLCl1zcQgMoBT7rj2vBOuyt5muC7xK62hLjiFDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ayaLvZBaoFpQrr4g1+aRWurtZL8NGUUtD5/a8S0tCJh9n6Ana2f2/ErrOpwZMAhTV
	 s9cGTzZRr5RodSb7TD4+fI0vSgvh1NcItfYAN9pn+jtcqf9E2jds3VmIrY9ICIfP8o
	 CJzcrJUmDea/FB9bLLkP80YA6P+Ynz4jdCOYWu/84cBF/aPO3vR0Zwo8axDGn1Yke4
	 FbVKm+a+dGiqOigQbFVGx5xe5bkOqrIWBCLfeQKZD6WiEqtocqt09ooMEfwMQ+zACH
	 5yvxZTgMJr/EzqtlNn//8ZuVk61MYek2Fdky/2aOvX4VQhavpVALdYuUKO5MFsgKS1
	 lZAOUN8R0HX0w==
Authentication-Results: debonair-kikimora.authn-relay.a.mail.umich.edu; 
	iprev=pass policy.iprev=185.104.139.75 (ip-185-104-139-75.ptr.icomera.net);
	auth=pass smtp.auth=tmgross
Received: from localhost (ip-185-104-139-75.ptr.icomera.net [185.104.139.75])
	by debonair-kikimora.authn-relay.a.mail.umich.edu with ESMTPSA
	id 686DD50E.109873CC.5220F189.2839003;
	Tue, 08 Jul 2025 22:33:52 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 21:33:47 -0500
Message-Id: <DB768SCZCRVK.1PVRI6EOMGO6V@umich.edu>
From: "Trevor Gross" <tmgross@umich.edu>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
 <gregkh@linuxfoundation.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <davidgow@google.com>,
 <nm@ti.com>
Subject: Re: [PATCH v4 1/6] rust: switch to `#[expect(...)]` in core modules
X-Mailer: aerc 0.20.1
References: <20250701053557.20859-1-work@onurozkan.dev>
 <20250701053557.20859-2-work@onurozkan.dev>
In-Reply-To: <20250701053557.20859-2-work@onurozkan.dev>

On Tue Jul 1, 2025 at 12:35 AM CDT, Onur =C3=96zkan wrote:
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

> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> index d19c06ef0498..844197d7194e 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -7,7 +7,7 @@
>  //! `Cmalloc` allocator within the `allocator_test` module and type alia=
s all kernel allocators to
>  //! `Cmalloc`. The `Cmalloc` allocator uses libc's `realloc()` function =
as allocator backend.
>
> -#![allow(missing_docs)]
> +#![expect(missing_docs)]
>
>  use super::{flags::*, AllocError, Allocator, Flags};
>  use core::alloc::Layout;

If you spin this again, would you mind adding a comment/`reason` about
why there isn't documentation here?

This is preexisting but something to shift the possible meaning from
"this module shouldn't have documentation" to "it's okay that we don't
document unstable test interfaces" would be helpful.

Thanks,
Trevor


