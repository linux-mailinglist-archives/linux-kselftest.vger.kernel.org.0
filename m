Return-Path: <linux-kselftest+bounces-10205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC398C5E2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245461F216F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F171836C6;
	Tue, 14 May 2024 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="w3jmiolY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FE1E491;
	Tue, 14 May 2024 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715730454; cv=none; b=tjziR4e/sCTlYVjK2lskFJJ3dL4W+hgNFwR4yyIRaWdkFyg/JMygtPyIweZzCsDFjThCSZnKKhPqXdUxkuxOaLdBJkZBC71sRcoV8bAsFOMnir83K0mLXMEVtgOOy11GKcZ6qBsd26bfdWgwwyfkdW2Li5uiqpk3ratq2RPfqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715730454; c=relaxed/simple;
	bh=1rwfNpf50aTPtb80Ip2O+B+pjU7fjXSF51Ls8a9PAtY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ko3d4GldeWa/4V3ydARYS5sWKSGxRFc5tScgPZxxGTZg5lGIgwmhGKe7hzoP5j1Tz9ZLtJuLyt9ybIcf8jl0mO12kZLIJgWYi3nKFmejV3hKuwgY680CH/2NskCx6FD9h5s+TrwX1GfyIKiAxgsJwxZlbg6Q3gPagWAuvTXDCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=w3jmiolY; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=1rwfNpf50a
	TPtb80Ip2O+B+pjU7fjXSF51Ls8a9PAtY=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=w3jmiolYozzwXCDaJGlzE5ZoZaKGpcix0
	0z5OoNzmAs0Pm443g2gWqiJee/dXJ8hyt1VSANoXCAjPfbosI7dWN1YGKtnq8Ov6CV/qNG
	zwkrtcAPKRaLMALsW+JNjcs4cj6NrLtvfYtahvZpBzTZx4IaBRTBu5BRYdvHF/Jfo3fC3B
	osPSeUaZSTQdt9mWAVJR++Gx5nvHxLWInVSGLBqLUDaJyRAUVb3QNkv8qNdN0/pWS1qYJZ
	2rHibAKs2IvwBkqQkjTz5jv7Fab+MtUsZl5Dx1M+XBDQIYLMOxG3OnzokZAtPlrQCmfjW8
	f5KGRZSe4qM95Hm3t7KbGcEFpyL5g==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id ba1c6f5b;
	Tue, 14 May 2024 17:47:30 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>,
    Jonathan Corbet <corbet@lwn.net>, jeffxu@chromium.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
    usama.anjum@collabora.com, Liam.Howlett@oracle.com,
    surenb@google.com, merimus@google.com, rdunlap@infradead.org,
    jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
In-reply-to: <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org> <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org> <56001.1715726927@cvs.openbsd.org> <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
Comments: In-reply-to Andrew Morton <akpm@linux-foundation.org>
   message dated "Tue, 14 May 2024 16:01:50 -0700."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45809.1715730450.1@cvs.openbsd.org>
Date: Tue, 14 May 2024 17:47:30 -0600
Message-ID: <92453.1715730450@cvs.openbsd.org>

Andrew Morton <akpm@linux-foundation.org> wrote:

> > I worry that the non-atomicity will one day be used by an attacker.
> 
> How might an attacker exploit this?

Various ways which are going to be very application specific. Most ways
will depend on munmap / mprotect arguments being incorrect for some
reason, and callers not checking the return values.

After the system call, the memory is in a very surprising configuration.

Consider a larger memory region containing the following sections:

  [regular memory]  [sealed memory]  [regular memory containing a secret]

unmap() gets called on the whole region, for some reason.  The first
section is removed.  It hits the sealed memory, and returns EPERM.  It does
not unmap the sealed reason, not the memory containing the secret.

The return values of mprotect and munmap are *very rarely* checked,
which adds additional intrigue. They are not checked because these
system calls never failed in this way on systems before Linux.

It is difficult to write test programs which fail under the current ENOMEM
situation (the only current failure mode, AFAIK).  But with the new mseal()
EPERM condition, it will be very easy to write programs which leave memory
behind.

I don't know how you'll document this trap in the manual page, let me try.

    If msealed memory is found inside the range [start, start+len], 
    earlier memory will be unmapped, but later memory will remain unmapped
    and the system call returns error EPERM.

    If kernel memory shortage occurs while unmapping the region, early
    regions may be unmapped but higher regions may remain mapped, and
    the system call may return ENOMEM.

I feel so gross now, time for a shower..

