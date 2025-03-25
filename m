Return-Path: <linux-kselftest+bounces-29736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE97A6ED1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 10:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449831891F01
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F401DE8A0;
	Tue, 25 Mar 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFVgd+d3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C0199FAB;
	Tue, 25 Mar 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896635; cv=none; b=VQlqX4rwlmAT02dFOB7MGU5mgUoEeKUyLXCkTcJeeKkLgK4xGvYV/PMqmvFBjTLwDjSGFxokk+OvEyxjOFOCcKxJxY6G4On29YUDHwkT/PoRapTZnXZHPL68rdIKsCGHYP3YUzJ+Ra6NrPtac47V3N7wzStXIyBrC26iJ3ae4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896635; c=relaxed/simple;
	bh=BvDDzlzdOcqf4BHdU6qJ8FawDbknKtetT8elHms5Yd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxSVxcTnC/WXz3G29AFpRyYqYEkPy2UPYvbYuOkRp9eIIUHkyUJZGffNckPCXN9W/Qzg/V4RabguOjAb9HllXaNlUjcLAaUdqOMBaPl6JZs9OupXNxNFWv7jn4L794Kv2Ir1mivmipsW1hHkoDxKb1T8WS6LXwtaQxkgHvPedB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFVgd+d3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac345bd8e13so956524566b.0;
        Tue, 25 Mar 2025 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742896632; x=1743501432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEgV7dXBWUHlWp9THDdIl69Z+M8XTdqmdjv6ciiL/v0=;
        b=JFVgd+d3101AiHcDUppGvTfflvkX7b1q0nfiii+tjQjFzqrSakMowxratyEC1kJ8vN
         dzqgRBiv6xUDAQN3BsXiREIl7e59olEOEBtPLLyv4i4dfB76AvmMsugaLBLJXNahdk4k
         Ih/uM7kzNuQuR5HDnVLN3jaYcI6R/wGWryvl2muMkqYBztVrs1YBhvq0HV+Hg9+KRJyx
         QE/6enD8gU14OX+B0XILPAQVtwkY0DJnpnsHBHjkksuv3MwdcLuPwt3AZcKwC2Y8N1gO
         x8ducReZwuwrEpg+T9aR1+gNvBFfA1OuPwv7WBpc8f1qFNU9m8aPditkdS9GIm99Qapz
         D5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896632; x=1743501432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEgV7dXBWUHlWp9THDdIl69Z+M8XTdqmdjv6ciiL/v0=;
        b=Izldsdbt73h0rqwEwU/JB+2qqfVX4wCnM730/6H8+Vy2kqjH3Eey4cHlO0WKGfTH+I
         fCQcH3ruj4z8DTzeZVLWvxh46ol9bV/wM4fDzXCC8fEJSNjaAV8gVu8LXgIc2j17DcGN
         PeD/FD2oaMUuqub1HXQsxZvICgSIzQbaKeLb+5OjgFWRj9Vb+Fo3EjQhzaIknzaehS7C
         75HrXqjcc9Yzt1fOjztKzECxvwtvn2xYW8TB8jYieTT7vkUkQ8CQWy7tV+TFl9vHye7a
         B2CzC4UOfSEJWrJiGq3+uehlkbjHm8uVJprzS5AhqmPivmB2plE8IZQYFSxKTFYDmA1n
         /cZg==
X-Forwarded-Encrypted: i=1; AJvYcCUpUAMCAv2kHhjMLTtf8UAMz718xuaWsTtYTOyu8jx5NsU+my5CQJBCOSDQf6zFTcxCkTK34Y+lZ6+hBuQ=@vger.kernel.org, AJvYcCVULTpm/+1NHpwIBpFvU7xRLwF0b4lL0I6KCqm8+YS4NER+5UTFQbCaothC7dsA/g7eCRIcbWqIRfzneW7B4Mma@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfBuMuCNQDGp+3+LNyLCtbrs5PNvh/qFKc6tIt9C+dzfFljYR
	VJiFtjylTJhD8qYx8jQN9Xtm8atM/DBUbGxmNBigd+eINY1zP0Uc5wAtCJxXPG5Uojc5ba4R0dv
	zWHFOjSgrcBUQCD2CBUT75WVGH5s=
X-Gm-Gg: ASbGncuOzRjPvAjwR/MO8rR5qL24qVr0jVccdw1rwwJzGVBDjU97dgFTLEnTzcRdP06
	xqISzQ6uTuY7GltSkqwtT7G3lJZ3ZMh2wgcgwvPU+t+6FzTHZMQ/uZs0SUEiBpvAWaWAsg57CjL
	5gJL1/AyZoZIK3GLzY8gBglmp+FkU7
X-Google-Smtp-Source: AGHT+IGsybLlk6Gei/O6isFxKvdtM4iz5ryq2uJLMcJrXSpZT1dQ7GSgHEo9pIWxQarGx/awZwvUr8q/dPIStNwB2FM=
X-Received: by 2002:a17:907:da0c:b0:ac3:f683:c842 with SMTP id
 a640c23a62f3a-ac3f683c845mr1688462366b.42.1742896631914; Tue, 25 Mar 2025
 02:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <malayarout91@gmail.com> <20250324124810.883767-1-malayarout91@gmail.com>
 <20250324125108.GH14944@noisy.programming.kicks-ass.net> <Z-J3jlYcocf_w4M_@gmail.com>
In-Reply-To: <Z-J3jlYcocf_w4M_@gmail.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Tue, 25 Mar 2025 15:26:58 +0530
X-Gm-Features: AQ5f1JrI8xAwzMwi4u1x_sk952eG-lUxVvQamrG1sXprgY3Bm-WPSFDn1iveu5o
Message-ID: <CAE2+fR_kG1SpE3DZ6cbZL+J8HT25RcaGxYrZP-H+rDFSJG6sdQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/x86/lam: fix memory leak and resource leak in lam.c
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I appreciate all the feedback and recommendations provided. We will
incorporate the same.

Thanks & Regards,
Malaya Kumar Rout

On Tue, Mar 25, 2025 at 2:59=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Mon, Mar 24, 2025 at 06:17:50PM +0530, Malaya Kumar Rout wrote:
> > > Static Analyis for bench_htab_mem.c with cppcheck:error
> > > tools/testing/selftests/x86/lam.c:585:3:
> > > error: Resource leak: file_fd [resourceLeak]
> > > tools/testing/selftests/x86/lam.c:593:3:
> > > error: Resource leak: file_fd [resourceLeak]
> > > tools/testing/selftests/x86/lam.c:600:3:
> > > error: Memory leak: fi [memleak]
> > > tools/testing/selftests/x86/lam.c:1066:2:
> > > error: Resource leak: fd [resourceLeak]
> > >
> > > fix the issue by closing the file descriptors and
> > > releasing the allocated memory.
> > >
> >
> > But but but, doesn't the program just exit on any of those 'errors'
> > anyway?
> >
> > That is, iirc this is a single shot program.
>
> While that's true, still proper cleanup of resources is a good practice
> - and in more complicated tools it's useful to fix even these
> semi-false-positives, to make sure other warnings don't get missed.
>
> Having said that, the error/cleanup control flow here doesn't look
> overly clean here to begin with, so I'd suggest fixing that (with goto
> labels or such) - which would fix the file_fd 'leak' as a happy side
> effect.
>
> Thanks,
>
>         Ingo

