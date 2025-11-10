Return-Path: <linux-kselftest+bounces-45221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BDC46648
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 12:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29D404E75F2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204230B50B;
	Mon, 10 Nov 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wO2hCQc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC62EB87F
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775600; cv=none; b=nu2OxBMCgJ2EX6YRvVmTs7wRUYwf6IMDPOoMgoj+3tEnWyl8T/0Lo4kcPwdkpRiGl5bFAk+L4PhQteJRn5TWo7rIIBTzVd6cHSA2qXd9xnnQPN+g90oR0ureTDrQGrLHLiW2AyS4rhFHaYTbJtklDYrNk2htzr3xycDpcDBOzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775600; c=relaxed/simple;
	bh=EDZJblRFOBVaS7V9swh66M5uzKZEQn6brygnQ0u2oxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F0Ws+m+gCIYlIS3vrFJ2kRt6jpKpSCWqVQHXFnPmL0nfcoQeJzI5Gd/biBOUtLComX2ze643ixhvmEaZJAQWYRCjUFNhhK7rNPVfGEfghuj9NHfxo7L2yJXrSbvr2019q6q7Kx/Y3ti1f+piQ57cDs9OAVUOHk6A6mUaWoyAhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wO2hCQc1; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b366a76ffso520343f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 03:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775598; x=1763380398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEKi6XUPcJTxR8kCttvI9av/95c/Ll+7Tji2AuMb3UQ=;
        b=wO2hCQc1pDp6U+DbazLKOl9cCy6NhQ3O12tRziaJ2PPRzd2hFYWEMMDIxq0DgUOeCx
         4tYbbsJ5mGg2rY3lYM2hXOV1qPNJ4HFHogKZuBKa1nUrIELAtecSTd0eZOkDB9Ca+FNl
         2/VUne8RYKuI14DLlUfjn9Y9DLcRR5UHPd/cRYixc1293zhyUtjSjiOdloUzCN8aSEEz
         baxeU8hRzmw6333HEj9v4qmQTvjezBjL2us0WIaJa6GHjbpPLJf/or1WkMvU8P4NAc20
         NX/2hw8UFSW08eVk2j0pvkb0kCYqnscbHDirqI/oXPP7rFppDb+yzq+F3w13iIZr07Bo
         rB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775598; x=1763380398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEKi6XUPcJTxR8kCttvI9av/95c/Ll+7Tji2AuMb3UQ=;
        b=V2JroxGunnXlD0X4z8vHFclhb24Qfc1UDVV7NuMHKGnslWp9/kk43z+u+UosGx1Icp
         g+9bf6iQvorAj6n77UDMtbwrNm/cjA08G1jk78NvH6pRtRYNJvPNCoFjuKSRMAgIT/e/
         cV8rh1v9y/W10hopS6OwdcYI/CFVd0DVs8cqLxvDvDw/bebQY4Md+jpZ3PULZIFzD/oA
         xIaVsyMmmlmQeSQ03BRUC98uHDh/zX+mo/4SDBJq3VeMtPclzWscnvENQtitor8SeUZD
         unzeS3KRV1zbCj8/EUBVmxDT3Etpa6fL4v+wOjfXRLeGPECD9ytQ024rwSZaxwbgUw9x
         9W5w==
X-Forwarded-Encrypted: i=1; AJvYcCX/U/Tad1dAwUyzpGskpKAk8W3faulJ4Ch8vzBTJoI/sXieY7oCiDgt/OcopXuJlx09X2n5pSkPuYWInlZ6kjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAHe788FOazk6MNAwvOOdbrZT73m4000qN7ggcRLI7oAq38dU
	9NT8zSU4EQL0FeAOmWmAqBXMDZi/8bEE/cvlxTih12lxKu1fSazjgTy+eKnvOGBYxDulsiwC1yP
	daLQadS5tuyEJ2xZplA==
X-Google-Smtp-Source: AGHT+IGDXVa4jR2Hvr+m+drHIkFWVJ9kU5jgqj0CSyP25A++0dFEDi+XQZITKlDq83CPddiTCOmKe1l7tbj1AWM=
X-Received: from wrnp5.prod.google.com ([2002:adf:ce05:0:b0:42b:33e5:eba1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4710:b0:42b:2dfd:534f with SMTP id ffacd0b85a97d-42b2dfd557dmr4843170f8f.34.1762775597658;
 Mon, 10 Nov 2025 03:53:17 -0800 (PST)
Date: Mon, 10 Nov 2025 11:53:16 +0000
In-Reply-To: <20251110113528.1658238-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org>
Message-ID: <aRHSLChi5HYXW4-9@google.com>
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 12:35:27PM +0100, Miguel Ojeda wrote:
> Examples (i.e. doctests) may want to show public items such as structs,
> thus the `unreachable_pub` warning is not very helpful.
> 
> Thus allow it for all doctests.
> 
> In addition, remove it from the existing `expect`s we have in a couple
> doctests.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aRG9VjsaCjsvAwUn@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/init.rs         | 2 +-
>  rust/kernel/types.rs        | 2 +-
>  scripts/rustdoc_test_gen.rs | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 4949047af8d7..e476d81c1a27 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -67,7 +67,7 @@
>  //! ```
>  //!
>  //! ```rust
> -//! # #![expect(unreachable_pub, clippy::disallowed_names)]
> +//! # #![expect(clippy::disallowed_names)]

Maybe we should also allow disallowed_names in doc tests?

Alice

