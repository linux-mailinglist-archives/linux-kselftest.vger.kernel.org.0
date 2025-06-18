Return-Path: <linux-kselftest+bounces-35312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4E9ADF408
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592554A1F64
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3B2F3C3C;
	Wed, 18 Jun 2025 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMjYJJMN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32CC2F2C62;
	Wed, 18 Jun 2025 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268287; cv=none; b=Otz5XlWJbIxMS4vx2WHAdaNpcDpeSX7qRl503nh+bpLVAXB29AtUjkHcjuU/RGWFglnABk2AwhOYZQpVBT6hgcQvtIVsbRyIoSADj9p0sG0XB5owXuUpfWWWndTm8u3vRrE0EY5GIMsZZ8eQaYX9uVD97q/GWDDS/XVS0HCcQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268287; c=relaxed/simple;
	bh=iW9LufXJIvbvUBrzExqn4UB+Dl7RTb6MInZzRTsd/gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/6NPn+So6Ak7wFfyPiRJ2fsgh2/7ybAlv1UaJINCjxvqZ7OE/eU++NqaBQDyKjxUjnnsew/qzHdSnFAbFplaWz+7jpDq7ZylRI/eZRifwfKOeh8y3Li7roUQN7PxRu6sDrXHaxhZ/+JyDJyIMlyxMyHzLAou6vggIWoJufWl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMjYJJMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2905C4CEF0;
	Wed, 18 Jun 2025 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750268286;
	bh=iW9LufXJIvbvUBrzExqn4UB+Dl7RTb6MInZzRTsd/gE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMjYJJMNrwSXJJKi8YsQ2JJzCWZzP3aUZRw8z5zFfnRs1PXkskRU1Uy/yMHhyjNDZ
	 aYyZvuF39WCJ0xfMW8VeWBs9XfgsxQPF+pfQhST331PYbTu5SMofDob0J6zFVIuQiD
	 xSNdKxYMYh7U71x0eBK5yeKhMdcB9wxpVvFZ3qE1TB+ZhJbwwiFeANK7gl5OpRQQfV
	 HSlnFlW678e57cd/6TC7LCfpEXAcYmojJXL5MBRF9yft0mAOs/z5mLjzxKGeOOJg26
	 w8zV/ffBD4jrvfjL7VmhG/U0wMlv2WpMERp1XRhsOUdVpC+tBSoJP0eHtbj0yJFIBz
	 Dl2uipre8dPhQ==
Message-ID: <de30bc80-3dc9-4fac-afe8-bf6b0df42ea9@kernel.org>
Date: Wed, 18 Jun 2025 19:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/6] rust: enable `clippy::as_underscore` lint
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Breno Leitao
 <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
 linux-block@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-4-f43b024581e8@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250615-ptr-as-ptr-v12-4-f43b024581e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/15/25 10:55 PM, Tamir Duberstein wrote:
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index afcb00cb6a75..fd7a8b759437 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -153,7 +153,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
>       /// Returns the error encoded as a pointer.
>       pub fn to_ptr<T>(self) -> *mut T {
>           // SAFETY: `self.0` is a valid error due to its invariant.
> -        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
> +        unsafe { bindings::ERR_PTR(self.0.get() as isize).cast() }

Shouldn't this be `c_long`?

