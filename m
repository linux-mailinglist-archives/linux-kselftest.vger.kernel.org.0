Return-Path: <linux-kselftest+bounces-29615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB201A6CC74
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 21:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EA03AA5A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4823536E;
	Sat, 22 Mar 2025 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GQieJjcr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60D235359
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742676266; cv=none; b=sDujIdtwIJufm6IpkfnMOkZQ4OffhtuxBvSiCulT9eLa1lrniVQLwbJqYW8A2ZzAF1AriH1EirpkJgQz3CKZx/Uw1GFDWZ5KLcNsgOIPzMOc7zjQQZf7U/TNS8SvzbEimYyETq+Y+zIhbvdkIaMcg/Tey3ZY+HolBJ8WpRJ5GL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742676266; c=relaxed/simple;
	bh=UKlciIrjeezvhboHb0wpfeljhOCf1ywpYrDH4+tDbI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmMFolZ3F114Vredsx6GfnKU06sU18uUq53gGXlyZMPIMs2uULezkMDucwRmGQGm/sPvFO8bsedHIGeeds66kRLntjx+2M89UGPFnHVHL85qUnQfEZYcePY8+JBY7VaBNUc5simANYDjr9R6SNBqC0uJyG3a5YlMLq+QFIohFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GQieJjcr; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f768e9be1aso39793067b3.0
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 13:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742676264; x=1743281064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+vTxWBkSi57+4WfhJ24nlBMfZiKcsmbPvtMMRe99nY=;
        b=GQieJjcrcWmiEj5M05POaTOS17Jp9Q0qocinbVA6c9w5Ejje9YXldSOf/9G0cp4Pc9
         7maup0mffpTRwLL9FZx5bN/iBR1nxNDsMOBmU9n4qjqvBg6Ot8LsttV94D0Y2U/k/G9L
         F62InBFMOJ8rXWyhpgJOplGNLR2sagMJdL9RWacXvz+qzGHaHnqGQO7jxBZPIgKz0wpW
         5VozKYI5YUaCI+YkiP9hM1e7rVOrCVpnE/N3DjZQ6odMXkWyyB96HRji6UdE90pgb9hE
         XiEAezRM4c1Q/SbN0jWp4BM89vKK//gdp+hVwKPvulYlAaze4TM3Ubuc2Oe9KYKuqrBs
         0bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742676264; x=1743281064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+vTxWBkSi57+4WfhJ24nlBMfZiKcsmbPvtMMRe99nY=;
        b=jqG1QnGUhXRtUqQKcreJfT+fzN+uPl+O56Lddvy1H0x1vIhawC2Lprn4w6frk1bH3K
         R40Yvs1iYuTE8Z83u715avg3sia+AV2wnBifkBH3CIKMxUPZe4jTy5R+zluwHdnguEB8
         8yxqt61JIM8plkkyQOKs/pUy/55SY3ARrAicbWmM2N9ghwbaz3j57dhggcjRnU/0soOt
         umj99EKAZsjXrrwkcak6FmYa9tUgAEnYk1/tndg0WRrAqaY+iKovBqm+9mDn9Dwd8ub/
         SUbpSlsx2EJ+otPZNuwPkKysUPcr3WUna5QgFy5hLj9t0RDJ3n8/wdlkvOvNL8PC/0U5
         F+nw==
X-Forwarded-Encrypted: i=1; AJvYcCVIDc4a9WCAetCyHpNtmIN7Q0x90DkU+sRGsROhSF58g0OQsayxnE7+snFIDQMx1GPmI/+Spu0ejWPeCMi9hLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkhfIfORxA54sIDkJ4TyaTfEG0sqD+MSluGzRr4UVIUKgzQrl
	EMI+MCQfi9KsTEesRr98Pie/E9KYqXOkgX0MU580gUz0rD/SQ1KcnECS+RGnYXxOh3CenRYznHO
	C9yRlJgg6pXxCUR8HmMivUWcmrPoADTnaCmoj
X-Gm-Gg: ASbGncv05SwEUz9zcpQ5MYAc28FEi7v0/TT4wfJGecp7RKk+dOOfZ/lP3kC+AksRITd
	Tn8qpV3Rrar5ozxFfY+0lYpuTELfHbsKs9iXiKGJtbZ2T8naKFYw0Pu3OWhaRQ+wea6l3/i/JWM
	Uh3r6lT0Z5qDPhJGr3qB1q/rWUjA==
X-Google-Smtp-Source: AGHT+IFcKv9scbpPRaXEmfEq8UTNsrOWBSBmEAVu84IGUkNbStpZPTP0X6nSe1KdmVF1IIRaxjZIWblNbdfkJkrFAUw=
X-Received: by 2002:a05:690c:290f:b0:6fe:5dba:b190 with SMTP id
 00721157ae682-700ab33324cmr140033307b3.11.1742676263726; Sat, 22 Mar 2025
 13:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com> <Z97xvUul1ObkmulE@kernel.org>
In-Reply-To: <Z97xvUul1ObkmulE@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 22 Mar 2025 16:44:13 -0400
X-Gm-Features: AQ5f1JqeAnjTq6zKFyRLTvg80Cofo3Oa1gVwBdukxtEf_asDyE42Nwb-Nf9BM5s
Message-ID: <CAHC9VhQ4a4Dinq+WLxM88KqJF8ruQ_rOdQx7UNrKcJqTpGGG+w@mail.gmail.com>
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jan Stancek <jstancek@redhat.com>, 
	Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	nkapron@google.com, teknoraver@meta.com, roberto.sassu@huawei.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 1:22=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Fri, Mar 21, 2025 at 09:45:02AM -0700, Blaise Boscaccy wrote:
> > This patch series introduces the Hornet LSM.
> >
> > Hornet takes a simple approach to light-skeleton-based eBPF signature
>
> Can you define "light-skeleton-based" before using the term.
>
> This is the first time in my life when I hear about it.

I was in the same situation a few months ago when I first heard about it :)

Blaise can surely provide a much better answer that what I'm about to
write, but since Blaise is going to be at LSFMMBPF this coming week I
suspect he might not have a lot of time to respond to email in the
next few days so I thought I would do my best to try and answer :)

An eBPF "light skeleton" is basically a BPF loader program and while
I'm sure there are several uses for a light skeleton, or lskel for
brevity, the single use case that we are interested in here, and the
one that Hornet deals with, is the idea of using a lskel to enable
signature verification of BPF programs as it seems to be the one way
that has been deemed acceptable by the BPF maintainers.

Once again, skipping over a lot of details, the basic idea is that you
take your original BPF program (A), feed it into a BPF userspace tool
to encapsulate the original program A into a BPF map and generate a
corresponding light skeleton BPF program (B), and then finally sign
the resulting binary containing the lskel program (B) and map
corresponding to the original program A.  At runtime, the lskel binary
is loaded into the kernel, and if Hornet is enabled, the signature of
both the lskel program A and original program B is verified.  If the
signature verification passes, lskel program A performs the necessary
BPF CO-RE transforms on BPF program A stored in the BPF map and then
attempts to load the original BPF program B, all from within the
kernel, and with the map frozen to prevent tampering from userspace.

Hopefully that helps fill in some gaps until someone more
knowledgeable can provide a better answer and/or correct any mistakes
in my explanation above ;)

--=20
paul-moore.com

