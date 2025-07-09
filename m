Return-Path: <linux-kselftest+bounces-36787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C6AFDD8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 04:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AFE481C3B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 02:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749C1C32FF;
	Wed,  9 Jul 2025 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="HTWySZpt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from epicurean-pwyll.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2B1A9B53;
	Wed,  9 Jul 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.217.159.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028654; cv=none; b=rNzVtOtiuQmLYD3sTN1YFJIcPjXFfDmQm1M1KVgnVmInJjQAk4nEQ9d5pBhmzMOJJ0yV6D2P94v0ycCE/th2r8pXK0dCFdAsGGZEPhbVFXNfq5sDoxqJEIm6rSdMI4CtFqJJab4ofyDF1/tVuQ21zJ1dG2dJ9HanL3y4s9kweAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028654; c=relaxed/simple;
	bh=VTakTpbD+/ck8WoyE/AJFOUOdGMd9ulSB3DN9NmElJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rE8xqDaBVCLgxRrBH1FcING2sF2IwT5sMV9pc5j2VdWBOvgrflx7S0ljMgebOtSPiAajoPqOkdJx+xxOPejWYGNQNzCF2RvlWh2HWFIeK+3tEv3avi56r9dnVWu2pOXAjsgNDzWJbwbLCD/9YXIjHuHTbTt50z6QlfqmU+X5uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=HTWySZpt; arc=none smtp.client-ip=18.217.159.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: from inspiring-wechuge.authn-relay.a.mail.umich.edu (ip-10-0-74-32.us-east-2.compute.internal [10.0.74.32])
	by epicurean-pwyll.relay-egress.a.mail.umich.edu with ESMTPS
	id 686DD5D2.13EDAD5C.57D01473.3894664;
	Tue, 08 Jul 2025 22:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
	s=relay-1; t=1752028626;
	bh=T7eoNy6cEsEjh+BNoMcOqnD0AF+jHSHZHYV7ZlywU6M=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=HTWySZptBk1BzDPVADcoGedBuWDkfthsHx0rJwSb82h3kP9/gPQ6ZUkVnaEnFRWWV
	 uSdw47Iv3BT740DQ1dG2pM3C1vflyazI5JVfzPeYZm1W/Tq71aKad1lMoZ2/jTSQXU
	 vfidSoOjsyvYWIXlrHGyjGr6J4uVwqR7H0jn9MkRoQ3+k3UEkAu26FdZZF3JLgu4p1
	 bibUVuxfJM49eWnW2emvbDwB63BdH42lAiwKoC684hTMTVezhSBY/LV49CZsPpKLIB
	 DRuqqnAqgo3GvmawYVw2CmtGHw6rex0e/OZDRDyXABwWBFGgdjOveoWhYMDH3Nv7el
	 pes9sYt08dY0w==
Authentication-Results: inspiring-wechuge.authn-relay.a.mail.umich.edu; 
	iprev=pass policy.iprev=185.104.139.75 (ip-185-104-139-75.ptr.icomera.net);
	auth=pass smtp.auth=tmgross
Received: from localhost (ip-185-104-139-75.ptr.icomera.net [185.104.139.75])
	by inspiring-wechuge.authn-relay.a.mail.umich.edu with ESMTPSA
	id 686DD5CF.15A3D811.3754A1D1.1028157;
	Tue, 08 Jul 2025 22:37:05 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 21:37:01 -0500
Message-Id: <DB76B96DHB88.1ASN4O1SLKNAS@umich.edu>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
 <gregkh@linuxfoundation.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <davidgow@google.com>,
 <nm@ti.com>
Subject: Re: [PATCH v4 5/6] rust: remove
 `#[allow(clippy::unnecessary_cast)]`
From: "Trevor Gross" <tmgross@umich.edu>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
X-Mailer: aerc 0.20.1
References: <20250701053557.20859-1-work@onurozkan.dev>
 <20250701053557.20859-6-work@onurozkan.dev>
In-Reply-To: <20250701053557.20859-6-work@onurozkan.dev>

On Tue Jul 1, 2025 at 12:35 AM CDT, Onur =C3=96zkan wrote:
> This isn't needed anymore since `kernel::ffi::c_int` type
> is always `i32` which differs from `err` (isize).
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/error.rs | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index a59613918d4c..05c6e71c0afb 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -413,7 +413,6 @@ pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T>=
 {
>          // SAFETY: The FFI function does not deref the pointer.
>          let err =3D unsafe { bindings::PTR_ERR(const_ptr) };
>
> -        #[allow(clippy::unnecessary_cast)]
>          // CAST: If `IS_ERR()` returns `true`,
>          // then `PTR_ERR()` is guaranteed to return a
>          // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
> --
> 2.50.0

Reviewed-by: Trevor Gross <tmgross@umich.edu>

