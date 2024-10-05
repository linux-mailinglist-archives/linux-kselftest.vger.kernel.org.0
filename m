Return-Path: <linux-kselftest+bounces-19084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6879913A5
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 03:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A93B1C225FA
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1604C7C;
	Sat,  5 Oct 2024 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="sHZb4/K1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C54C7E;
	Sat,  5 Oct 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728090274; cv=none; b=fZ0kaNVJcaaKNxK1P52jKXY3hl0uYS7FVkbOs5hZ0x2m5vLbNqU141yFUAM8VsTGYFQa5OldhTFdCLCaoNhkBpVaJDgnxKgI7QGlFalT/70s035njvdKmPCFwO7AzyxwzZzcR7oO3VoXEpAlMGshJ794JlO0tmQTalJUnN3+hqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728090274; c=relaxed/simple;
	bh=ceoFgBtwxSZTjATveYnv5yYpnEyiSYI8ibzvGyRpUcM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=nOEzMAly1tLMuTYl452I5Puyjks8A4zduELGT1C1DgNK7rG/U9OhtNLUGQCyI2c1yg7OGV1XGtJYvi2Bod1QCiIdRwXkSsJqrmcoZI6xaatfo3w8EyBDj0qwBVpjn+Ms8WRO93egchMOx5oHWy+yTq8KXggAyDyvJGZdWAwLHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=sHZb4/K1; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=ceoFgBtwxS
	ZTjATveYnv5yYpnEyiSYI8ibzvGyRpUcM=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=sHZb4/K17HQLUj6Xf/aoweZ8SPSWlEkj+
	iV16cjKudM8yAAyPqYXrNHvHu0kOTJ/nvVS2Wk3cb3IrycxbZu8vCPoru0j0Mly5TudqT2
	OI26Yo+0YGCoxM2LQfAqDTKn3RqzEYhI4D3yRT/F3pgdRXHlaZDjFLQajYZX3+ho2cpsTa
	HA5iZ+5T78uBxzIJepR5g1JZdE563fvq0OccznuEDbI2jykoruB+5CachkoWmmW5k4MH8B
	96kd1Ack+hrPxlZSJtMihZOVRFJNyBBpSjsNsQfTr1xu4gIGhLikyhac2t9Td47ucORQon
	7xrqkLBQAE2Fep/ijnW261s9gXt2Q==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id a9f35afe;
	Fri, 4 Oct 2024 19:04:31 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Randy Dunlap <rdunlap@infradead.org>
cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
    keescook@chromium.org, corbet@lwn.net, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    jannh@google.com, sroettger@google.com, pedro.falcato@gmail.com,
    linux-hardening@vger.kernel.org, willy@infradead.org,
    gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, surenb@google.com, merimus@google.com,
    lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, enh@google.com
Subject: Re: [PATCH v2 1/1] mseal: update mseal.rst
In-reply-to: <78f05735-cca3-491e-b2d6-c673427efa07@infradead.org>
References: <20241001002628.2239032-1-jeffxu@chromium.org> <20241001002628.2239032-2-jeffxu@chromium.org> <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org> <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com> <78f05735-cca3-491e-b2d6-c673427efa07@infradead.org>
Comments: In-reply-to Randy Dunlap <rdunlap@infradead.org>
   message dated "Fri, 04 Oct 2024 16:52:06 -0700."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25904.1728090271.1@cvs.openbsd.org>
Date: Fri, 04 Oct 2024 19:04:31 -0600
Message-ID: <15868.1728090271@cvs.openbsd.org>

Randy Dunlap <rdunlap@infradead.org> wrote:

> On 10/4/24 9:52 AM, Jeff Xu wrote:
> >> above is not a sentence but I don't know how to fix it.
> >>
> > Would below work ?
> > 
> > Certain destructive madvise behaviors, specifically MADV_DONTNEED,
> > MADV_FREE, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK,
> > MADV_WIPEONFORK, can pose risks when applied to anonymous memory by
> > threads without write permissions. These behaviors have the potential
> > to modify region contents by discarding pages, effectively performing
> > a memset(0) operation on the anonymous memory.
> 
> Yes, that works.
> Or at least it explains the problem, like Theo said.

In OpenBSD, mimmutable() solves this problem (in later code iterations).

In Linux, does mseal() solve the problem or not?  The statement doesn't
answer this question.  It only explains the problem.

If it doesn't solve the problem, that's pretty surprising (weaker than
mimmutable).

During development I wrote a fake little program which placed an 'int =
1' resided into a zone of readonly memory (.data), and then imagined "an
attacker gets enough control to perform an madvise(), but only had
enough control, and has to return to normal control flow immediately".
The madvise() operations was able to trash the int, altering the
program's later behaviour.  So I researched the matter more, and adapted
mimmutable() to block ALL system-call variations similar to 'write to a
not-permitted region'.

So the question remains:  Does mseal() block such a (rare) pattern or not.
The sentence doesn't indicate that mseal() has a response to the stated
problem.

