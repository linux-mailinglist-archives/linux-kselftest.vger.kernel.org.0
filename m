Return-Path: <linux-kselftest+bounces-35335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD993ADFC6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 06:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645BA17DEDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 04:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C7A188580;
	Thu, 19 Jun 2025 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzCxRxVB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454314C6C;
	Thu, 19 Jun 2025 04:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750307436; cv=none; b=H5rp31L02Ghi9F/U9XEKFlI9mA2nmYXcndHQD7C5r8bxbz4vxnXX+6zQrupkTtFqNmHwZSJtJ51+hHicYfHw/MCN1lMqY9YGtxaCA/zhk1utXWZNtZmneNXL9ClcIFhUvmvqyZY02QQnh/2Onu6dGNja3sm8yvlyp/8iEdtRK/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750307436; c=relaxed/simple;
	bh=hO0TBASwoc3FULZXFzHhHmKijD+SjFrHsXI7r55AdbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRu7iWF1mKtRroZyZtl363XNQ1z5UAmY+DXfuzJF0NDXwyraYVu+qDDKDRzuiFjCyxMzhdHUKB++IcIUXsgSo3qFAx5qncMlrGgamne/0oZJwbe4XQJaqs4fUwH7ezKVt9VEuTnrzZ21Cpa8Dq8dh3vevjK4ROQTTZhykGJ9vQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzCxRxVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B6BC4CEEA;
	Thu, 19 Jun 2025 04:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750307435;
	bh=hO0TBASwoc3FULZXFzHhHmKijD+SjFrHsXI7r55AdbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzCxRxVBtx0jtsOzTuX5lDiIuXCgfmTkoIsSs4pvrxvGPGJnnznlBOCC+SumafN9C
	 hGscwnr1vSXreuaYFr8wOn+XZRaxWe3djIwnySC08WCgOa8OnehiLnwvAwJmScrV9B
	 73U8zk4S21SJ6Ck6LJeAECPS5KdQgVrJYCdl/Ys0=
Date: Thu, 19 Jun 2025 06:30:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
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
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Breno Leitao <leitao@debian.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
Message-ID: <2025061919-stooge-fascism-d734@gregkh>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-3-f43b024581e8@gmail.com>
 <CANiq72mn6fFL86-7XjsovdjQ2ySiNNviP4dvE170FmK_4E19OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mn6fFL86-7XjsovdjQ2ySiNNviP4dvE170FmK_4E19OQ@mail.gmail.com>

On Wed, Jun 18, 2025 at 07:29:25PM +0200, Miguel Ojeda wrote:
> On Sun, Jun 15, 2025 at 10:55 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> >  rust/kernel/devres.rs | 2 +-
> 
> Danilo, Greg: for completeness: if you don't want this, please shout. Thanks!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

