Return-Path: <linux-kselftest+bounces-45222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFECC46660
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 12:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433133A322C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CD30B525;
	Mon, 10 Nov 2025 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yxe5My0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8232EB87F
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775696; cv=none; b=bj4YkP8ChoqRp0JKqf1GnhCNYmhRkDDrRgSzvJThGcn43skScbKZGbq0iC0RyDhg6ifx+dXiGK+s1Zz0wj33bnLb6dnXhN6bZDJE6OG8+NX2te98Hd2uUIGWkUB1b3qJfaIeCHD+VnABqgO9QnW8wOJzbrTXBTIGvRVmsqCtcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775696; c=relaxed/simple;
	bh=Wld7jp9tEQXuIh09SWUvMZLGcORmYH4LRprox5mayS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Aj/KvZxrMC4r1qO7r3HmIIT0aClk37HP3dnFlPo04+ZrFwlW0TbX+Ohs2qcYefLrG3nOET3jSY67FQEhRs+6MeQazTvA20hw3Nz95UmUiSqODGW02jZVavQV5LIFPZ7l875tjJ/gnaiR6/8dSRPQKgWfRBq8WcpzkN//TcIW5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yxe5My0q; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64097bef0e2so4156495a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 03:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775693; x=1763380493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQQBm4PwQuyI6yZ9AdqTjALBwiLdrNslKJZVi9Mtf9A=;
        b=Yxe5My0qzeQJg0PhWL6EKJGdRWXdvyWwA6GKEJBtTzxfccEC879ZHcA6PZIRHCwRG1
         JQARHzpFvIWNeLAlK7WJR70EHZOhaBETWBmwU3lsGS+jYgrkp47cMSr71HVvxORvg6ry
         LEfQobC1E+pH58SKkK8cpdb+xofnjIyD8dpRbHKREEWMZ2Nj9ytEr6mAd99Bt648rWWs
         6uH1w4mmjPOI7Ip3hP3V1G7UVTOXcU0BDEY3G9e/mSIRSdHz57ccrczAsrz6j/2yaeYr
         3hE/T0rTw0LfuPbbnQC7TR54RFvl8k/rAbXiaNnXVbdA2ofwAsC9HySBeg2nyYQboonh
         LIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775693; x=1763380493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQQBm4PwQuyI6yZ9AdqTjALBwiLdrNslKJZVi9Mtf9A=;
        b=kExsJDkJg4LGoLcq4nzDladeiOdQW7jPGyVPbbKoqTFEVocyrdfZwFFgwLwcpajWYA
         PWKjwLqEXfcEKxbRR+uBys9+S8XW5dRvDftaP5HSeVvw4BVNMAAkAu1t06I7mN5LHnmf
         gGbGbuPFqtxU+yNabNFN9fWXQNsHerki4JBBHI5cRpY94CpF8Ur7C8f18HdzHOuCrhT6
         LGac9b6bH03UmToP55MoL6AUnVLsMZeIz4boNUCiLJalnwpoLTnxnBxzzPsCNx4Lujf8
         IOtaWKrOaM2LiCHrTx8LrHHTVyJW8IAZyp9/mipSUYYFcAHT1cm1Ukq2kWf7qegtWdEJ
         OA8g==
X-Forwarded-Encrypted: i=1; AJvYcCXbKjE8rzcIreadHERn85FSgJBzSWXnX/TdzbuHqIveJfcYEEr4Pq2BCGpEBS0HaeRJ/CLcZCGUXi5S8osnpVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzq2eyjFf0nfwk7vJO4kx1MUuU0jhfYPrBNTqeA9h3KsWK6l3
	T0aNzK1eh25E3INJSirYQ9kY7bfLpCLbgE8TsbwTOgJ+TMqoGatKIjs8RhPPBC5hV+PgA4fOQo6
	Ak+lnIqZpUlOaX1czQg==
X-Google-Smtp-Source: AGHT+IF3M40dNIzNZkxr/1+aJ+nfeEg2fTctw3V8OcAEVxMO8ut0+MdQ2WzFfOK9xMLQ2EWoslAnSoMKLCyCugk=
X-Received: from edaa20.prod.google.com ([2002:a05:6402:24d4:b0:640:949d:9bf8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:27d4:b0:640:fb00:9b0b with SMTP id 4fb4d7f45d1cf-6415e8565d6mr6321846a12.32.1762775693084;
 Mon, 10 Nov 2025 03:54:53 -0800 (PST)
Date: Mon, 10 Nov 2025 11:54:52 +0000
In-Reply-To: <20251110113528.1658238-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org> <20251110113528.1658238-2-ojeda@kernel.org>
Message-ID: <aRHSjKsZVz3NfUrW@google.com>
Subject: Re: [PATCH 2/2] rust: device: make example buildable
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

On Mon, Nov 10, 2025 at 12:35:28PM +0100, Miguel Ojeda wrote:
> This example can easily be made buildable, thus do so.
> 
> It would have triggered an `unreachable_pub` warning without the previous
> commit.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/device.rs | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index a849b7dde2fd..d00f4af507db 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -67,7 +67,16 @@
>  ///
>  /// A bus specific device should be defined as follows.
>  ///
> -/// ```ignore
> +/// ```
> +/// # use core::marker::PhantomData;
> +/// # use kernel::{
> +/// #     device,
> +/// #     types::Opaque, //
> +/// # };
> +/// # mod bindings {
> +/// #     #[expect(non_camel_case_types)]
> +/// #     pub struct bus_device_type;
> +/// # }
>  /// #[repr(transparent)]
>  /// pub struct Device<Ctx: device::DeviceContext = device::Normal>(
>  ///     Opaque<bindings::bus_device_type>,
> -- 
> 2.51.2
> 

