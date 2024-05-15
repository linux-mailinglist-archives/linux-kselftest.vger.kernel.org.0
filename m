Return-Path: <linux-kselftest+bounces-10216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B18C5EF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D6F281DC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3932C2E3EB;
	Wed, 15 May 2024 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="58HSJxwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C102C848;
	Wed, 15 May 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737702; cv=none; b=rFdN4/IcJYAstzNl1oJhNrNO4cVF58MDeILBsFNIs5F7lS4xJHFu4NX8ZrJzhN5VfOEy0jAtXxNi62RR4sv0e+FX4GNK4/JrrYJOPHYlVDesNp7XERF1PFkvcMMVQmH3pQRS8wddJ2IIrlkAtftcJnJBi8EbK/SWGLI1AH1AuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737702; c=relaxed/simple;
	bh=nwi7XSp87KyMBhuDwVzMUgWk96d9Z2Gf+1P/43zA+uU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=QojHrjX3NS0irPja6JwjcDn8ukuAPS1uma0aarUXoS7U3dhM8VjzSjg5pbfJ/hw/ZgZuyr7FSgVYcr/yw8uGlbV5klkYAER8H2c24kFK9649NU7dMpOV5LbUwTpYOohHpyrx3R8TMDHmZFzd8S2Tmba2vWes90iD1kSQei99nRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=58HSJxwI; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=nwi7XSp87K
	yMBhuDwVzMUgWk96d9Z2Gf+1P/43zA+uU=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=58HSJxwIFFDunvAa6ffAS+xegRSfK9Kml
	vIQU3QINWU0zu0uNNtl/ENkzETD9jZ0lhJ06nfZdsJes7RXcWA6OhA9yzOm7tnw8OBTYw2
	nkhlSw6lB6LwhOXn2y0DPj+Iu9/Aq6Usg3TElJUvwWK9cZ3CdGHOTs55P7DYpnWVh7LocG
	TnO4X+Hs1BUsMQAYK6Gffm4lLs1scWLFvnrAhO199CaYsqcXZFdp+k+ZN84LSLI1k6/2WQ
	u3B1Ommwx+T/L3JIgcTsk8IM0iNy1iHRGpnBfBuIlnCWUEXEOB5vJR0nqyx0MJSkzcIocI
	DW/cwgN0Gm7PWphRbO3/Y3uOveMEA==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 55a0975a;
	Tue, 14 May 2024 19:47:46 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    gregkh@linuxfoundation.org, usama.anjum@collabora.com,
    Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
In-reply-to: <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org> <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org> <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com> <16982.1715734632@cvs.openbsd.org> <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Tue, 14 May 2024 18:20:23 -0700."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31351.1715737666.1@cvs.openbsd.org>
Date: Tue, 14 May 2024 19:47:46 -0600
Message-ID: <84192.1715737666@cvs.openbsd.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

Regarding mprotect(), POSIX also says:

    An implementation may permit accesses other than those specified by
    prot; however, no implementation shall permit a write to succeed where
    PROT_WRITE has not been set or shall permit any access where PROT_NONE
    alone has been set.

When sealed memory is encountered in the middle of a range, an error
will be returned (which almost noone looks at). Memory after the sealed
region will not be fixed to follow this rule.

It may retain higher permission.

> Maybe some atomicity rules have always been true for BSD, but they've
> never been true for Linux, and while I don't know how authoritative
> that opengroup thing is, it's what google found.

It is not a BSD thing.  I searched many kernels.  I did not find the
Linux behaviour anywhere else.

> > (Linus, don't be a jerk)
> 
> I'm not the one who makes unsubstantiated statements and uses scare
> tactics to try to make said arguments sound more valid than they are.
> 
> So keep your arguments real, please.


CAN YOU PLEASE SHUT IT WITH THE PERSONAL ATTACKS?  ARE YOU SO INSECURE
THAT YOU NEED TO TAKE A TECHNICAL DISCUSSION AND MAKE IT PERSONAL?


In a new world of immutable / sealed memory, I believe there is a much
bigger problem and I would appreciate if the Linux team would give it
some consideration.

mprotect and munmap (and other calls) can now fail, due to intentional
address space manipulation requested by a process (previously).

The other previous errors have been transient system effects, like ENOMEM.

This EPERM with partial change is not transient.  A 5 line test program
can show memory which is not released, or which memory will retain
incorrect permissions.

Have any of you written test programs?

