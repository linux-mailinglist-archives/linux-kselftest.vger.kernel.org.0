Return-Path: <linux-kselftest+bounces-14943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCD94B026
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 20:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F0F1C212D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50591419B5;
	Wed,  7 Aug 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BPSzXr8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815785654;
	Wed,  7 Aug 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057106; cv=none; b=s4t/6UjjDbNAvnWuIT25Tf1qar2+//72dgyZl8BWw3EY/HgEjlq24nkYZSvxcWcjHrfNdKGG49fzvap75BW779wnaIpOPXD2BPW/gJY2CH8mkzxKr9agoCS5fvwBb2ywLqu4OA52sfHR2Grlk61DZqbO6f7PTY1fgm6tL8q5vuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057106; c=relaxed/simple;
	bh=eAz2kJmjkg5Ihm2BfZUadha9dC8QFeceZ7oEvyeeCgc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eXCuW7hgYLs7Uc1jSqpnOZAaq/8igQ2IdleU3EbmGIs2hS+rf+xKkj2a181HwzWE0a8ELwmE6y9rF0tNrXbe0NY26FN+zrrI5j9sarE5v8RiR1k80USXJGnqLAVBCrUsdI6GA3QyNm94y3JMkT2ZdUGXdSiHEmgzdrDscYY/leI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BPSzXr8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C169C32781;
	Wed,  7 Aug 2024 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723057106;
	bh=eAz2kJmjkg5Ihm2BfZUadha9dC8QFeceZ7oEvyeeCgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BPSzXr8r3k7v5vgPZM4yz6cINL04KhJrT0cqIc2BS/oHYuz5mJ3hlJkxe2veu77js
	 tsRqUCbSF/25iPY3PXbe8EQrH/1VcBfc6ttE5PLv2sWd4AQAzwvEMrlsk9UZDuuXyW
	 lAsi7z+X5SZKRJnuo/OSNQGUWTsqCzCjh3KMXaSM=
Date: Wed, 7 Aug 2024 11:58:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, Kees Cook
 <kees@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mseal: Fix is_madv_discard()
Message-Id: <20240807115824.f5c29702dda952abd709351d@linux-foundation.org>
In-Reply-To: <20240807173336.2523757-2-pedro.falcato@gmail.com>
References: <20240807173336.2523757-1-pedro.falcato@gmail.com>
	<20240807173336.2523757-2-pedro.falcato@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 18:33:35 +0100 Pedro Falcato <pedro.falcato@gmail.com> wrote:

> is_madv_discard did its check wrong. MADV_ flags are not bitwise,
> they're normal sequential numbers. So, for instance:
> 	behavior & (/* ... */ | MADV_REMOVE)
> 
> tagged both MADV_REMOVE and MADV_RANDOM (bit 0 set) as
> discard operations. This is obviously incorrect, so use
> a switch statement instead.

Please describe the userspace-visible runtime effects of this bug?

