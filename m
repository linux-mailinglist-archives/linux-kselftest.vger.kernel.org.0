Return-Path: <linux-kselftest+bounces-34489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFACAD22F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7491886DC2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897220CCCA;
	Mon,  9 Jun 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C/FFabkU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F953D544;
	Mon,  9 Jun 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484284; cv=none; b=ZvSSAYPWo6Mk20TtRJ/olG+9a+JK3rACDJF6HgTZzCY3AMnqJwooIMK1dpw1i4GSVW6X6YA7ft59nzmsG2V7bBN3XZLBVM4iefT4+83RWeeloVNlJZR/wPyJHFWzcjL/mppmkNVY0gDbVztK1TSYBkCW1jGA5v6vAzHwLvHHtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484284; c=relaxed/simple;
	bh=b2Wgtom4VQPmWb8cZ96Sldnc/IbgbcGy9qLVL/LndP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKE5a86lktVwRMWU9jfqnk/OjM97VjN+JHCmO3pvKWZ4E16j0dUfJN3nc0fwUpqEfYn2JZleC0oJJBTa23DD7da4eWE7Yd8Qdi0I5agyDW2ZXjjj0QAphXYkUE6DoX2+5J2dNqkGd+Ie4Wr6dODzwBe4nOaAvx3/ZZF5b+WcUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C/FFabkU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749484280;
	bh=b2Wgtom4VQPmWb8cZ96Sldnc/IbgbcGy9qLVL/LndP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/FFabkU8OWROYnczjEpCIlLs4zvR4hKgjFas/26QrtqXGDDMX1ty0XcQUaTtWyvI
	 IcwhfyrwFNzIWey27gft97jEjjwgmTjELbOYbfwg+KPx5pz+uadyrCP06b8Vazt6r/
	 yAZHd07b7SYaOZeG3tewAkSiPn+1OcgorSlxLjcI=
Date: Mon, 9 Jun 2025 17:51:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Christian Brauner <brauner@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/nolibc: Provide vfork()
Message-ID: <d4fb291c-e329-4fb6-839f-01cb17afc933@t-8ch.de>
References: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
 <20250609-arm64-gcs-vfork-exit-v1-1-baad0f085747@kernel.org>
 <df6f5620-5986-4080-bb00-c7bee856bf66@t-8ch.de>
 <4a4ef323-25e9-4bb5-bde4-9ad740693246@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a4ef323-25e9-4bb5-bde4-9ad740693246@sirena.org.uk>

On 2025-06-09 16:43:55+0100, Mark Brown wrote:
> On Mon, Jun 09, 2025 at 05:34:33PM +0200, Thomas Weißschuh wrote:
> > On 2025-06-09 16:08:56+0100, Mark Brown wrote:

<snip>

> > > +static __attribute__((unused))
> > > +pid_t sys_vfork(void)
> > > +{
> > > +#ifdef __NR_vfork
> 
> > For consistency:
> > #if defined(__NR_vfork)
> 
> Are you sure?  I'm seeing an awful lot of #ifdef __NR_foo instances in
> sys.h - it looks like the idiom is to use that unless it either needs an
> additional condition (with || or &&) or is an elif.

In sys.h, indeed. These have mostly grown historically, newer ones use
#if defined() together with #elif defined().

