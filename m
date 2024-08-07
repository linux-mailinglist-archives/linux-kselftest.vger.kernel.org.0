Return-Path: <linux-kselftest+bounces-14951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8994B077
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AF31F226F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5878C7E;
	Wed,  7 Aug 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qPrex5OH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6163CB;
	Wed,  7 Aug 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059114; cv=none; b=lSZKl1rVWR57y8ZERRhNzr/UztvsPHe1P2jaJmX4y6S3GXpRegC6bUsEOf4S/Ob1u5l70xF4B+VaVrhAiFC/SAoCxvQnucaLZZUNoHMrGgrOexUnGhlHIFfWiaxusi8Bjoj6orcub/bhp8Dudd08KUn5/ilJgxuQsg/RhJgAZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059114; c=relaxed/simple;
	bh=bOrep78qwpQ+ZvCf1wppZmAp3VaReel1+oiiqrsO3as=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iiM3189j3GCJTo0aQkh4VLEQCGAU8W9IK/DW8Q2oZqH4LA0MaZDO3bM2QoCIMmmrd21TlU5TW7v++2oBiwu3OfMH05FhhblNBB2HHgvqFxvZz0bWnmqDtGiMmqCT5mVp/+R+ebAHShwLArhZuFeqgjm0lNZz5IjvVqc9ZvKohKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qPrex5OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CA6C32781;
	Wed,  7 Aug 2024 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723059114;
	bh=bOrep78qwpQ+ZvCf1wppZmAp3VaReel1+oiiqrsO3as=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qPrex5OHq6DgLB1AlO3lxni+t8gZLu0zfMQdVPA9KDHBQbDTxrTHLCbqlub4N1mYw
	 8vrCxOplGGmhcr5ApHNyYI3Zx6JRsbTTIMbr08aMkQVkdmaBEUDSgrvQtcSQi5FmsN
	 dmYBQZsxW8D+g8fA/MyGlNnx0U1mEoLGgGsrBJT0=
Date: Wed, 7 Aug 2024 12:31:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, Kees Cook
 <kees@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mseal: Fix is_madv_discard()
Message-Id: <20240807123153.227390ebb7c6dff911b5fddf@linux-foundation.org>
In-Reply-To: <CAKbZUD3kNTKfV5yMQW7YYbRx2XJiMNM4owGiYue1Y-A=yVbWog@mail.gmail.com>
References: <20240807173336.2523757-1-pedro.falcato@gmail.com>
	<20240807173336.2523757-2-pedro.falcato@gmail.com>
	<20240807115824.f5c29702dda952abd709351d@linux-foundation.org>
	<CAKbZUD3kNTKfV5yMQW7YYbRx2XJiMNM4owGiYue1Y-A=yVbWog@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 7 Aug 2024 20:25:45 +0100 Pedro Falcato <pedro.falcato@gmail.com> wrote:

> On Wed, Aug 7, 2024 at 7:58 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed,  7 Aug 2024 18:33:35 +0100 Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > > is_madv_discard did its check wrong. MADV_ flags are not bitwise,
> > > they're normal sequential numbers. So, for instance:
> > >       behavior & (/* ... */ | MADV_REMOVE)
> > >
> > > tagged both MADV_REMOVE and MADV_RANDOM (bit 0 set) as
> > > discard operations. This is obviously incorrect, so use
> > > a switch statement instead.
> >
> > Please describe the userspace-visible runtime effects of this bug?
> 
> The kernel could erroneously block certain madvises (e.g MADV_RANDOM
> or MADV_HUGEPAGE) on sealed VMAs due to them sharing bits with blocked
> MADV operations (e.g REMOVE or WIPEONFORK).

Thanks, I updated the changelog.

