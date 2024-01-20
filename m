Return-Path: <linux-kselftest+bounces-3270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 315BC833546
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E476B226D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBB101D5;
	Sat, 20 Jan 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="YicnAI/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B592117;
	Sat, 20 Jan 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764627; cv=none; b=Nc0H27UbOBtNRD6xa7Ttq8WHFr0oeQ1u+5CMjjNhyO1OnGzX/E5iGts7z8RY/032Zs2lrhWgt+A2as+3UktGLEJg8SQ5bLU1FUmt3nXtx8tHR7KkOvJ2AiDq6BCfF0eAlxUk4ye3Swct3Gpbi4Q6W5Mv7CororZidT1ezQTugEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764627; c=relaxed/simple;
	bh=4OWicOUgr4L9XOpIC8Mj/UCoeLP2NtOXMnYVddveOY0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=LKuxatsSRw1oKV8UdKOhqyUYqQ1U6ycKBxz6ujg5nEz2EHoBiX6DrFHapaxeG5xAgo2N2xsrJy0XnOifEtEn/Sr4d8gZ4OsfxHy5SdvhYdvApf+KI1XKW4NuQATHHcm+96G/NqFokyOnJzCfQOZh/8es5JVGWPa/JWsbAsD0kkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=YicnAI/Z; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=4OWicOUgr4
	L9XOpIC8Mj/UCoeLP2NtOXMnYVddveOY0=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=YicnAI/ZhxukTjaldVdclRZFxTLi4itmr
	tNLKXPemFgAzsDYBZqrDlhF8hKj9fc6mUckUM/iyBV589tt7LViHcOyf2nf6j2zTEslzh4
	vG/l8dNmRi+jECNxd2ZsgriACFzDRwUff3t4dg1Cw9QlDOyECEPJenw35PZGGBPCBdB7BZ
	RGFWT8c7WkpMUT/foI2hTNF+F9uQu4ruA0PAFajE6OYwpa+NShTfzbhxK/ff0YFRxH5Hek
	AMyJ71GI47E6Gm24f6LQryBH1ut63FSj3cg1mVvHLyfzq81KQL3IaM9V/vGpnw9rKT1fjE
	otMZ+r4bE51rZdAr2FONDv+DyVVGw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 77142d56;
	Sat, 20 Jan 2024 08:23:44 -0700 (MST)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Jeff Xu <jeffxu@chromium.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
    =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
    Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org,
    keescook@chromium.org, jannh@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
In-reply-to: <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com>
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org> <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com> <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com> <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com> <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com> <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com> <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@chromium.org>
   message dated "Thu, 14 Dec 2023 14:52:58 -0800."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45028.1705764224.1@cvs.openbsd.org>
Date: Sat, 20 Jan 2024 08:23:44 -0700
Message-ID: <78111.1705764224@cvs.openbsd.org>

Some notes about compatibility between mimmutable(2) and mseal().

This morning, the "RW -> R demotion" code in mimmutable(2) was removed.
As described previously, that was a development crutch to solved a problem
but we found a better way with a new ELF section which is available at
compile time with __attribute__((section(".openbsd.mutable"))).   Which
works great.

I am syncronizing the madvise / msync behaviour further, we will be compatible.
I have worried about madvise / msync for a long time, and audited vast amounts
of the software ecosystem to come to a conclusion we can be more strict, but
I never acted upon it.

BTW, on OpenBSD and probably other related BSD operating systems,
MADV_DONTNEED is non-destructive.  However we have a destructive
operation called MADV_FREE.  msync() MS_INVALIDATE is also destructive.
But all of these operations will now be prohibited, to syncronize the
error return value situation.

There is an one large difference remainig between mimmutable() and mseal(),
which is how other system calls behave.

We return EPERM for failures in all the system calls that fail upon
immutable memory (since Oct 2022).

You are returning EACESS.

Before it is too late, do you want to reconsider that return value, or
do you have a justification for the choice?

I think this remains the blocker which would prevent software from doing

#define mimmutable(addr, len)  mseal(addr, len, 0)

