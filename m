Return-Path: <linux-kselftest+bounces-31077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C3A9239B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EE25A50B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934A255239;
	Thu, 17 Apr 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ+07d1O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995E255227;
	Thu, 17 Apr 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910028; cv=none; b=qcs0RJs+y1mewmXRZiuoCQlXxvKsydmge0ruYHQRQYKdSKo+R3pQmwiNVMa/2rkZ9VPnbg40HyQjfigs4QT2B9EhBdTvwx5RSl0zkqfGPFzoCKaq/Kx8a6AfD+ZGCli581WafPw7dWzPUAsMt43zdEBEMwq/GVmE8dUsgL72UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910028; c=relaxed/simple;
	bh=ClXKge+s0+Ub2mg760Y3fWyvgn0KGdmf2n1ls9/1cQ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCOkx6i9LwU4HmEf4RUdWzaf8m4zg9YoEIYh+IartBwwC+GgoJ4T4/pzUShLUKkKG3UilfFGmCVd8E4I5o8Ir5VXZvarWf+PncX8Z6Fm05RpIo5IiaEBciJtJDYaWH4AJIz0RkwzijYYxEWvPi8/p1Cg1ljCiL7pRh8WWQB1oXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ+07d1O; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so10451066d6.2;
        Thu, 17 Apr 2025 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744910026; x=1745514826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uMiNN63eUUM5t6fmwQT7MGcJeOTU1iqkIGAVW80wSWM=;
        b=cJ+07d1OEuUmDXsNNIezebyDQpYhFn6WZCYc7/xTmYME0f5EKDqF61a81MLJURIT/C
         Muva7nhr6xwbxWlE/NTx+c9A07tGvayU+r/IZGjhGMtxbB0z4/53Du2RNrZA9VXOMuzr
         wpZrb9nTf2TuObiI0EjBLnIZCzzekkqyodMtidy7gy/CD/exOb56TOIThqW4kPppHnaq
         oYecbRLtG2SZlVeT48dwp7t9whSPsnMU5KXk7uiqu+0LO4/szUK57dB+oVYp3UgKK+ln
         WIUVmPuLum9Oy5RKOKyX8vCoKudeKaPxJJE9dzRbS1F1eY55pg81YraQ/qL8CCGfiNuU
         H+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910026; x=1745514826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMiNN63eUUM5t6fmwQT7MGcJeOTU1iqkIGAVW80wSWM=;
        b=JXooNIik3wHzwM3Ux2zPeqFuKUAn63re1ezdBfFsZBK+K+rULnOYgfI0bQuA+YYU0u
         l3gbwd4Yrn15cWAhBn/8lgBglGC84yFQUiESo0sh8PrZhzQ1uthqnq/+9ovjyEdRk7MX
         A6LjBx6fF1+PVGvA1oZYeuKzZg4o+qyzOogzuxNSxfV6qM4MwBz575ixgbsq1GXc6ref
         3UguCXa1kLavfm+0bxYXr6eSJHxQKqkPAFbBitqArSpKl3TbofyP/MrkCw/XzmAix9EL
         Se8IcfeILWDrSAOXYUhzMuVup6ED7XcRQ+th2m6g/bAnb9h+AgrUfm+uKgT4S6z8rRHK
         C5cw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ho2NrnGPiOhOclnxE2Mr2+P41skGwSXWk2B1B5t7vrIWqHi4Q6ziHwkzm5ToLmD5atscLn5vZ9Dd@vger.kernel.org, AJvYcCUeYF8vB1VBe8qlgsOqsm9TUD5H13onbrWFysgCjfSRO1k4W/LV3mGT67Kiak9+KrNQhJeDngzj41up52IT@vger.kernel.org, AJvYcCUpbWxFViwKYunlrE4aK2VgYbdssrVk//JWeQKaBa7EtQ78ZbNOQJKiSMYG/WPVascYsU2ccLQ427Oy@vger.kernel.org, AJvYcCVIByMDtyjdFYbgpnA0t36jy0oPI4BM57+okLiMT8K9EmOrfH5+k2q9JxA8bzG4fCgvLiOfhbWXJrF8/do=@vger.kernel.org, AJvYcCVWHxnyrPsrAG0wrJIgIhlUs11o3ZxMiusMr+lupl5ja2qX5pG7oRoDP824kzJ+XN5ot8IaG685@vger.kernel.org, AJvYcCVnye0uvgqnwAE7OO/KaNxfkEW1jVJdGluaE5Auzcb+QnFQoEUrj7SaISCkV+G5H4H/CZN6kl61K3KVgzbqy34=@vger.kernel.org, AJvYcCVxSU2ZBu58SBGyEUPlyIbikGy58uIJNCion2td/FTguY1yYLmTUsB3xi47nf2g6qUmWtyXcp76TvZOkzgf@vger.kernel.org, AJvYcCXuM3Nh3228ousIRky9KPcpfnpUeGU9Vq9H/Hh0Yx31JluKVJUdKhmErz0+7WkJLhx5rNJiM/8qqU/vrfuA+FV3@vger.kernel.org
X-Gm-Message-State: AOJu0YxS73WHSy5BwkiClAlwyWP5J53DTXp0KfVoXbfYBcfCZDYljf2g
	xtICUZE5l3uxTlB3JDZwdZc0ui+ZtujoFiKz01CFnkCcKIbi3HhJ
X-Gm-Gg: ASbGncvURpN4aQe0oHv9za4x1exOccqzWk9IeudYPOv82uesxrDH7upqNBLccgP0I6G
	OBYa74WnOheNX5CLuiYJBuPgiJbpcPtdQU+FvQ8D0Rr7NWeVO4NaBXE2TmVZ3iFgWhdHGf8rdYR
	+L/1kKH/3b32zP2RoE7fBABZHPDGiL+tf9a9RPbfttZmjUKrAsosL5Rrz3885pXEjlGjNVAzPnz
	ZL/kTD8sBVY7ySCsNgVzv5CH81TuW63fW5VSRZNekvBLgQeAqpgc7ALdX00yEuoVi25ArLNFubf
	4SATTvwbDp/u0lG3v4a/MPIl0ScaiBg30VnBVzTk9+uhmurm7Pab3LNvhHO3hLzmqdeUt89k0G4
	lasuE02OLiv/gL5Cp2IMGlejxtxF+56k=
X-Google-Smtp-Source: AGHT+IFjAMymz+o8QFD3zeYcOgfTsX1rJmYVCrC8UuklVGxVBRToXezBFVxai8deeydLj3G4kuqUbg==
X-Received: by 2002:a05:6214:29ca:b0:6f2:aefb:948d with SMTP id 6a1803df08f44-6f2b2f47dafmr111323006d6.15.1744910025787;
        Thu, 17 Apr 2025 10:13:45 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c21d85sm1193506d6.107.2025.04.17.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:13:45 -0700 (PDT)
Message-ID: <680136c9.d40a0220.3a40bc.0bd0@mx.google.com>
X-Google-Original-Message-ID: <aAE2xsLJq-QnGamy@winterfell.>
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4A7821200043;
	Thu, 17 Apr 2025 13:13:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 17 Apr 2025 13:13:44 -0400
X-ME-Sender: <xms:yDYBaKP-8D2Cc1Qasl15QzYIKWEXmuEJNyu7NeylH87LFVV_OyaoUg>
    <xme:yDYBaI_5nESWhc4x7XO7Kw4SC8rxSyDiRyMg0FcQNLUttVtEKp05ZjLA7qGXWUc-L
    bswlrf6bKx-KuONyA>
X-ME-Received: <xmr:yDYBaBQUQUgJSQ_cEe2LZpJkNWc6_9yJwwld8UVgtygkbo3-_CO0cFVCfm8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhnuc
    fhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthht
    vghrnhepfedvkeettdeluedtjeevleeugfehiedvuefhgfdvleduheegvdekudegvefhue
    ffnecuffhomhgrihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhope
    egjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgrshgrhhhirhhohieskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    ohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    gvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhhhinhgu
    sghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yDYBaKvwEls1Zv6MdJG_fBGROyvSZPi_smjaTZit-e5mcuMjphUgRw>
    <xmx:yDYBaCffMS8uRoKqZ7odUAvP81el5qkqHjyOniSsrdgkC12UYxz4FA>
    <xmx:yDYBaO2pk_HMexV47hY4tJuwpSETKzXzexChsPkbiSfrQ6HAuB9-hA>
    <xmx:yDYBaG_ZoyUhjasgiehzWnKMBRUdZTU7eKXpRc5jx2qcFp0R-6dfRQ>
    <xmx:yDYBaB8bIvlKrY0p0lTwqimjLRsBSCtP3OJvaLaUDpHBMf4dz94q4W3O>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 13:13:43 -0400 (EDT)
Date: Thu, 17 Apr 2025 10:13:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-3-18ec29b1b1f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416-ptr-as-ptr-v9-3-18ec29b1b1f3@gmail.com>

On Wed, Apr 16, 2025 at 01:36:07PM -0400, Tamir Duberstein wrote:
> In Rust 1.66.0, Clippy introduced the `as_ptr_cast_mut` lint [1]:
> 
> > Since `as_ptr` takes a `&self`, the pointer won’t have write
> > permissions unless interior mutability is used, making it unlikely
> > that having it as a mutable pointer is correct.
> 
> There is only one affected callsite, and the change amounts to replacing
> `as _` with `.cast_mut().cast()`. This doesn't change the semantics, but
> is more descriptive of what's going on.
> 
> Apply this change and enable the lint -- no functional change intended.
> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_ptr_cast_mut [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Makefile              | 1 +
>  rust/kernel/devres.rs | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 7b85b2a8d371..04a5246171f9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -474,6 +474,7 @@ export rust_common_flags := --edition=2021 \
>  			    -Wrust_2018_idioms \
>  			    -Wunreachable_pub \
>  			    -Wclippy::all \
> +			    -Wclippy::as_ptr_cast_mut \
>  			    -Wclippy::ignored_unit_patterns \
>  			    -Wclippy::mut_mut \
>  			    -Wclippy::needless_bitwise_bool \
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 9e649d70716a..f7e8f5f53622 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -143,7 +143,7 @@ fn remove_action(this: &Arc<Self>) {
>              bindings::devm_remove_action_nowarn(
>                  this.dev.as_raw(),
>                  Some(this.callback),
> -                this.as_ptr() as _,
> +                this.as_ptr().cast_mut().cast(),
>              )
>          };
>  
> 
> -- 
> 2.49.0
> 

