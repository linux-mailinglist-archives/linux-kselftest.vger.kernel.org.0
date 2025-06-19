Return-Path: <linux-kselftest+bounces-35337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB7BADFC82
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 06:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C7F17FC6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0CC2405EC;
	Thu, 19 Jun 2025 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ia7hRmnU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62E4C6C;
	Thu, 19 Jun 2025 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750307454; cv=none; b=AtT9NtVDDVuK4ZKILDzrfbJtHYDBiGCUNrlMBE2DJbPp66X+TkVkkgx+KnBoPVKvXdTXr2WncJEv8AWJuScXn1amxSuJismYU5lSVxAJDEqv7MeIVE4TOcqkMYlpI/156VGDaqzGoaP+f8wXcDC3zq2oVjksWQoeJVo2aUHMPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750307454; c=relaxed/simple;
	bh=DZDkzOxOhDTAnvchUQ1CYPpHPNWT2Zv6IR3Yc/Oa0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxOUbyDOHG9rvnt24wga1qVqm7VtwdaHHJh+Ew8exOk8ajrKsJ4TP8gBa+w92NosOOyD+VDC3T5U7tj6j9xtcSk/Mftur2YfldsPMWS7plb6drPBaOyF1rcMJGzqOCvfsqJs4NKIP2tMhbMBwz/4OJIFtU8+Kxr6OmzUSvAFXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ia7hRmnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE639C4CEEF;
	Thu, 19 Jun 2025 04:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750307454;
	bh=DZDkzOxOhDTAnvchUQ1CYPpHPNWT2Zv6IR3Yc/Oa0Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ia7hRmnUBp8eDmtRMilO0fMWSw/rKx0UfeS5sfgeadffaDMejcs8f/lXHS1GPt5pg
	 ZsSXGI30HI4Iae2Kr5LSdFzQQyWlMTy4IkpUyimWu2IwYk7G8HDr982owdsKIK8XdX
	 iwPrbjQyyi2dQXlrQnov2FLYIEX1XnlgykuKD8kg=
Date: Thu, 19 Jun 2025 06:30:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, David Gow <davidgow@google.com>,
	Tejun Heo <tj@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <2025061947-chunk-unissued-04ab@gregkh>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
 <CAJ-ks9=6RSaLmNmDBv-TzJfGF8WzEi9Vd-s=1wyqBcF7_f7qQQ@mail.gmail.com>
 <CANiq72kgnKH2SSp76EdPeysExBWasqhTyf1JyReR65g6FMsidA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kgnKH2SSp76EdPeysExBWasqhTyf1JyReR65g6FMsidA@mail.gmail.com>

On Wed, Jun 18, 2025 at 06:45:56PM +0200, Miguel Ojeda wrote:
> On Wed, Jun 18, 2025 at 3:54 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > @Andreas Hindborg could you please have a look for configfs?
> >
> > @Rafael J. Wysocki @Viresh Kumar could you please have a look for cpufreq?
> 
> Thanks Tamir.
> 
> Christian, Danilo, David, Greg, Tejun: It would also be nice to get
> Acked-by's for your bits. Thanks!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

