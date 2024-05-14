Return-Path: <linux-kselftest+bounces-10203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF028C5DEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 00:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106861F21652
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 22:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80EF182C82;
	Tue, 14 May 2024 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="DXKecPN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182B181D1F;
	Tue, 14 May 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727330; cv=none; b=gMYx54o7KCtDtbILXNNL7idZwgLsrnohlHM+gaDsU4zPS1nUNr5Np2y50yk7MgWrM0cVnmikC8m8V3NyVqP69t9beWed9xht3q9KO4Ci87UgyZRJ5ZBCbM4qlnEFGLo5s6hkv/GAoUrR7yd42cM+7Eo1U1ax7RDsC9CbfhxmyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727330; c=relaxed/simple;
	bh=lUUbtboFXAJWCE0W1VokJb8/yl3D0BpWZ8xnDFVZ9qM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=NAapIUaj2VBO1DfdqC4kCdN5cagjrWqIL86g5DvvBagbVSeO2fLz7PaY/JY0W4OnmAn7oYk2dzqtP1CBLqbvs3PzmJSyVKAebQ/bjC6LkFVsA4bDV7DlyuAo+uawdFK3Sw7uzGQAXO3vRSEPzljCR3PH+ZKPm4+6qdp5VTaz0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=DXKecPN0; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=lUUbtboFXA
	JWCE0W1VokJb8/yl3D0BpWZ8xnDFVZ9qM=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=DXKecPN04dCt3ZGgyElWyQpUlSl8jxRlY
	fFmJmAonBF+5KpsNWHrZwtZLRNElrmyFepY+8i/Z1yYp6+xsR2NPvp22BIvChLbSA5tuWS
	L86bhYwLO9mbdcbd5MUKwgx0zrriBeTE5NTzNdm7wU+JAaxFvYez/GuEHF/1kfs9q2CbRt
	WZlubKV/MDKp30IHhP5MgV/YrT+UCm+zetoZ7L58Wrk+Tdie9BX4HIJrPq7TKoqTjbNgK1
	D8wl0W+5bf5Yjcs1fc359iBaktIk3EM/C7cMwOyXGf5J0ybBHf4/BT7VNAcYrBpnwjZiPl
	rAJdmEb0IiNvnAemTgraO883ggLaA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 907e0c43;
	Tue, 14 May 2024 16:48:47 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Matthew Wilcox <willy@infradead.org>
cc: Jonathan Corbet <corbet@lwn.net>,
    Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, Liam.Howlett@oracle.com,
    surenb@google.com, merimus@google.com, rdunlap@infradead.org,
    jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
In-reply-to: <ZkPXcT_JuQeZCAv0@casper.infradead.org>
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org> <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
Comments: In-reply-to Matthew Wilcox <willy@infradead.org>
   message dated "Tue, 14 May 2024 22:28:17 +0100."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57526.1715726927.1@cvs.openbsd.org>
Date: Tue, 14 May 2024 16:48:47 -0600
Message-ID: <56001.1715726927@cvs.openbsd.org>

Matthew Wilcox <willy@infradead.org> wrote:

> > Not taking a position on merging, but I have to ask: are we convinced at
> > this point that mseal() isn't a chrome-only system call?  Did we ever
> > see the glibc patches that were promised?
> 
> I think _this_ version of mseal() is OpenBSD's mimmutable() with a
> basically unused extra 'flags' argument.  As such, we have an existance
> proof that it's useful beyond Chrome.

Yes, it is close enough.

> I think Liam still had concerns around the
> walk-the-vmas-twice-to-error-out-early part of the implementation?
> Although we can always fix the implementation later; changing the API
> is hard.

Yes I am a bit worried about the point Liam brings up -- we've discussed
it privately at length.  Matthew, to keep it short I have a different
viewpoint:

Some of the Linux m* system calls have non-conforming, partial-work-then-return-error
behaviour.  I cannot find anything like this in any system call in any other
operating system, and I believe there is a defacto rule against doing this, and
Linux has an optimization which violating this, and I think it could be fixed
with fairly minor expense, and can't imagine it affecting a single application.

I worry that the non-atomicity will one day be used by an attacker.

