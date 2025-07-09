Return-Path: <linux-kselftest+bounces-36788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20EAAFDD90
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 04:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C28E584C8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F561C860E;
	Wed,  9 Jul 2025 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="HrJGh2CP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from epicurean-pwyll.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C391624E9;
	Wed,  9 Jul 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.217.159.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028786; cv=none; b=eLZY4USV5gDIP4Ml/IJjdaxHm2S14l0TRLhI2NKKU0cdLy1ylR17264t8DfkRZsLb+XNYMNNfvViLQbF5BDu93bG7kmM2e1MObP5+jxh3u4ex/KBetVHphqluL0PEXIapLXm1qj5nBk0UQZdXh+VLvdG+hTkK6T9QKxeaOgJlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028786; c=relaxed/simple;
	bh=ZYR4K95V9ALZLMcep15JqtiEmMDyYDtbCeQA2No6fss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WDOI2bSM09p8qbfmVROPwg/M+5kS7YEMsulcyVuVXRPQY6bYLaNjjkY7h7I9qDe136QJXNyazkSt/u3ozAByZsEc02wfOaV/3h48KxwMp5w2LJS2cKhEkd+HQfToYrDHRzyQRHRl4QtIM+KzYMI2vPZU9BLl6MdD0liReavm4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=HrJGh2CP; arc=none smtp.client-ip=18.217.159.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from inspiring-wechuge.authn-relay.a.mail.umich.edu (ip-10-0-74-32.us-east-2.compute.internal [10.0.74.32])
	by epicurean-pwyll.relay-egress.a.mail.umich.edu with ESMTPS
	id 686DD655.2A651943.69D839AA.3911671;
	Tue, 08 Jul 2025 22:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1752028752;
	bh=uM3GFOudNcSynMjCw9J4qh1wKrYmol4BLtprb7u3Ic4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=HrJGh2CPQ8sVs8mxXbdQ95OvEhzKjE8ZLe2qu0Q3pT4vs56Gq1U8bgKYjZmMOg0ZO
	 vexwK75KewFnGZvdH8/+PCTAdnSNoYFa4q0Akjvo9/fittn/xeCxs2d7slo14uX8Zn
	 iSBOFNdhyt2rAe016nmDqNhYqerf5BysxlkyFUiA6rNV95z+6InKKIB4Tsc5tIvY5m
	 VJfHfKNvo53/qrc/d3E7EQQ8KZAlBkSgyo84ufKq/Xz4U5bS/ulc6P9ZkbmP+I8YxE
	 bNW8RAf8pqVXhnuA1BzbOmLSFdTSQlNh2sy9cjUspzer22GJc4Egx46Vky6VJXdMNS
	 t1+jdmVWIy4Dw==
Authentication-Results: inspiring-wechuge.authn-relay.a.mail.umich.edu; 
	iprev=pass policy.iprev=185.104.139.75 (ip-185-104-139-75.ptr.icomera.net);
	auth=pass smtp.auth=tmgross
Received: from localhost (ip-185-104-139-75.ptr.icomera.net [185.104.139.75])
	by inspiring-wechuge.authn-relay.a.mail.umich.edu with ESMTPSA
	id 686DD64D.2C2761F7.61A0FC7E.1028970;
	Tue, 08 Jul 2025 22:39:12 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 21:39:08 -0500
Message-Id: <DB76CVMK4V80.NWOL1Z2SKS8Q@umich.edu>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
 <gregkh@linuxfoundation.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <davidgow@google.com>,
 <nm@ti.com>
Subject: Re: [PATCH v4 2/6] rust: switch to `#[expect(...)]` in init and
 kunit
From: "Trevor Gross" <tmgross@umich.edu>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
X-Mailer: aerc 0.20.1
References: <20250701053557.20859-1-work@onurozkan.dev>
 <20250701053557.20859-3-work@onurozkan.dev>
In-Reply-To: <20250701053557.20859-3-work@onurozkan.dev>

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
>  rust/kernel/init.rs  | 6 +++---
>  rust/kernel/kunit.rs | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 8d228c237954..288b1c2a290d 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -30,7 +30,7 @@
>  //! ## General Examples
>  //!
>  //! ```rust,ignore
> -//! # #![allow(clippy::disallowed_names)]
> +//! # #![expect(clippy::disallowed_names)]
>  //! use kernel::types::Opaque;
>  //! use pin_init::pin_init_from_closure;
>  //!
> @@ -67,11 +67,11 @@
>  //! ```
>  //!
>  //! ```rust,ignore
> -//! # #![allow(unreachable_pub, clippy::disallowed_names)]
> +//! # #![expect(unreachable_pub, clippy::disallowed_names)]
>  //! use kernel::{prelude::*, types::Opaque};
>  //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
>  //! # mod bindings {
> -//! #     #![allow(non_camel_case_types)]
> +//! #     #![expect(non_camel_case_types)]
>  //! #     pub struct foo;
>  //! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
>  //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 4b8cdcb21e77..91710a1d7b87 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -280,7 +280,7 @@ macro_rules! kunit_unsafe_test_suite {
>              static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit_suite=
 =3D
>                  ::kernel::bindings::kunit_suite {
>                      name: KUNIT_TEST_SUITE_NAME,
> -                    #[allow(unused_unsafe)]
> +                    #[expect(unused_unsafe)]
>                      // SAFETY: `$test_cases` is passed in by the user, a=
nd
>                      // (as documented) must be valid for the lifetime of
>                      // the suite (i.e., static).
> --
> 2.50.0

Understood that the files may wind up split here, but the changes look
good to me.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

