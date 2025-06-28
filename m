Return-Path: <linux-kselftest+bounces-36043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A56AEC743
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADF63A98A1
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586EC24889B;
	Sat, 28 Jun 2025 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Rv9Y53q4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970C1E32D6;
	Sat, 28 Jun 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751115352; cv=none; b=RPF15Z87HsviIqOkjPXhDDTH6VKM9m9f/ZMz2fjk0rYuOLYHIrwbdraJd1+xml3m+3YlUpv0GJeBePJ1MlIKLUrFjHbaSu3lwgnDnRxpChke4dsPQ+qnjg5UPX3CVHxn42OhKoUsGg6iicFY3sqCiOoCOaGGOlWAK9Dexn4Z7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751115352; c=relaxed/simple;
	bh=S7++PTAr4xAkYMbCgcR89+yGuk3BpPCWsV/+d4CP3oM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc4IZIHFYmemK581LmI265LGQzOjU05eIdigeVZXtkYyNulAkHoQK4g07CzsJ83YguTC66tFnQgLCNwOmS44VH15+tiB1Y98IsR1uFj+Xr1sy58/zKf8/rMm4rvPk5Qz0cN4zExwuOWtFS7m39Tjgsi29j3bMmTA9lqpzMLMAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Rv9Y53q4; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bca0:0:640:380a:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 58A7B6186F;
	Sat, 28 Jun 2025 15:48:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bmWfNHHLlSw0-XeRbLXHj;
	Sat, 28 Jun 2025 15:48:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751114922;
	bh=ET/LhC8QU7n+a3hSVOWcQEFar31KwcGnUYMpx7mD4JY=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Rv9Y53q41/X4ucraT7PqIEN6T52TlIy8XH/+OGQzaNmNRU786Bf+1FVa/020sI15D
	 14EbGI63y5peJj2y0CaM/gokUSC1Ouhz1H0fejxfK/09EL75jgHCH5xGbVgXNi1dWw
	 4blxx8kcKKplcizUveC+JUbOMrpvNWRPI36Qb4YA=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 28 Jun 2025 15:48:35 +0300
From: Onur <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: viresh.kumar@linaro.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, rafael@kernel.org,
 gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, davidgow@google.com, nm@ti.com
Subject: Re: [PATCH v3 3/3] rust: remove
 `#[allow(clippy::non_send_fields_in_send_ty)]`
Message-ID: <20250628154835.4e2e4a92@nimda.home>
In-Reply-To: <CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
References: <20250628040956.2181-1-work@onurozkan.dev>
	<20250628040956.2181-4-work@onurozkan.dev>
	<CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
	<20250628133013.703461c8@nimda.home>
	<CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 14:18:53 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:


> > IMO, we should require people to add a comment explaining the reason
> > for adding these lint rules to the codebase. It would make both
> > reading and modifying the code much simpler and clearer.
> 
> Do you mean using the lint reasons feature? IIRC we discussed at some
> point doing that when the feature was added (we enabled it for the
> `expect` side of things).

Yeah, I meant that it't taking more effort than it should, like digging
through historical changes in the relevant parts of the source code,
trying to figuring out whether it was just a false positive or if there
was a specific reason behind it, etc.

