Return-Path: <linux-kselftest+bounces-32922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1070AB6113
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 05:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28D73AC451
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 03:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C21EA7DE;
	Wed, 14 May 2025 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FNhhNUjr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7891E47AE
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191993; cv=none; b=TBIsRWpj85fMfLYitHU2QxMCg3MvT+b2yHVmtXhqrRkMJmKqFdlQTnQd/SvHN8LfVH6zndBMf2mJalHUMle5C18O88gWt97d7oIr1ahVZzuIs7Z3y7ZJjO9lF2EBzzhqAKq9IKQHh6Af6SesDPPIznoHdJeHfk8z/BxL/2xSqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191993; c=relaxed/simple;
	bh=QJlpMcodJFABVCXdqNlhN3+5p9vJ34o3HcUPNXekMzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUxZ+NzixJQRCcASY/fQu5UHsfi/ptaMdGMVI2X7IcnJvrgjxSDvv0Z1V2ks43cQA388BItVZ2F9VJp44WNVwrOvSEcIegTEUpwCO+Jm4yEuzjGaVVZnHAni2pR2ov+5CEULjzbN033CQoGJqi3xwHNUV5EunSS/lQUdVKnsPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FNhhNUjr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7080dd5fe92so56225577b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747191990; x=1747796790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmR0DV4kjICn6tOrrkeV1rJdypEVd85y6xmhHZSq2oM=;
        b=FNhhNUjrSx+AJS72l115atQjxUP4IWUNhyviHRegB2IcJIe4ENlgd2ir+F7sS/piRz
         6e+NeTRDx6lOapnzX4Zpni2YEQzz4b1YsLz5AGv6NG8kvi1gsisFfac9XCbpKYD+B8Xn
         W+XwhJEW044rXo85B1YBqQ3ZLzafj225fXZeNWrx1UF7eoeLmqfySND+MaaIHgfjzUtF
         1TDK8NdtQS9lFZgCzFtWiF8sZmDVI6nqVrtfjLTzjt+t2PcaHQvDvqceqC2SUrMMMJzU
         IpSiBdeW4UNGs+UcG9+JpSjTEZvkuGWBuTvOzmkgvlfjLEVEGUJLq3L0kW1S0ZofGX0J
         zzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747191990; x=1747796790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmR0DV4kjICn6tOrrkeV1rJdypEVd85y6xmhHZSq2oM=;
        b=XoStqO3z0VX1s9r/f+Up81Nil/pTXLrvJQipjWthezc1LMovvETrH2vcNLpU3wy9oP
         norgUT0nDV7x7M1f+10d8gFtzGd035akVXlCzARoW3Dini/+ruXkl8SuEHalPo1UglW4
         Dg8acgqIeW112ljLfOruLytWDP6c8Gb6nL7ErrV4q02YP9YD5SojiE6R5gYB+wSfXygW
         JSYOdj8XlTLWnoxtPtFDesMRpQCOLKdka4zyZpZ9+Rgupp7I+nwGa+4MoYKalxMh36yn
         3TCZSt8pVc4Mv5Qx7G7CqUsbN4yvTBCbdvqsVBY+hoa26Hz7G0n91kbYVTDetS9xWCFK
         C7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmrHXbKi1jHiaHiUQ3IoNQ7EoZ4o7lm1tRSwvuUNrPw8GEkN5KVO7+PdXiLq58lpioqbsOeOPAen7/j4jvNyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxScnHd9lsC8KGrTbkqgQBgHjyNjU9taA9XK3ofqwJVDOCPX90k
	Q6vmI4eMY8XucAHXWLTnzOTqPLOe7oFaGYBd/GU+d0kJz6TlihpHAmpuH+w1B49uPBRNnMRYyVq
	vbGIEsNzcUHaDl62KDfk0PGY2/36Ae8CAbRqM
X-Gm-Gg: ASbGncukltarbEe5usyzil5joxU0+AFB/XE8HibNjXeDy0asyadb93XyocYi4bnARDI
	rvHmAWID/RjuaZXmDt78YGo/pylvSDvvQOmu+26FaeLM9upVeJHjJHdC2guVVBWveTBxDRp/gUS
	NlPo854sK8MqxIS+vsSHjS/NwGG3bcj23c
X-Google-Smtp-Source: AGHT+IHoF4lWdSffdXGrv/OfRi9mN4zsQKU0Wx09452hnzxCArs6kDfkdHSQP63wj5stxfEFYGHGU4RZ0y2yDDB9wL0=
X-Received: by 2002:a05:690c:6809:b0:708:b7c4:89d9 with SMTP id
 00721157ae682-70c7f12b587mr29661517b3.11.1747191989825; Tue, 13 May 2025
 20:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com> <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
In-Reply-To: <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 May 2025 23:06:18 -0400
X-Gm-Features: AX0GCFtmtl8iZvt0__SZY16ZDtDEOONW5PvqEMj_YT203ANGlWr4B8M9PmCIO_o
Message-ID: <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
Cc: bboscaccy@linux.microsoft.com, James.Bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, 
	dhowells@redhat.com, gnoack@google.com, herbert@gondor.apana.org.au, 
	jarkko@kernel.org, jmorris@namei.org, jstancek@redhat.com, 
	justinstitt@google.com, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev, masahiroy@kernel.org, mic@digikod.net, morbo@google.com, 
	nathan@kernel.org, neal@gompa.dev, nick.desaulniers+lkml@gmail.com, 
	nicolas@fjasle.eu, nkapron@google.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, shuah@kernel.org, teknoraver@meta.com, 
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 10:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>

...

> The signature check in the verifier (during BPF_PROG_LOAD):
>
>     verify_pkcs7_signature(prog->aux->sha, sizeof(prog->aux->sha),
> sig_from_bpf_attr, =E2=80=A6);

I think we still need to clarify the authorization aspect of your
proposed design.

Working under the assumption that the core BPF kernel code doesn't
want to enforce any restrictions, or at least as few as possible, I'm
expecting that the BPF kernel code would want to adopt an "allow all"
policy when it comes to authorizing signed and unsigned BPF programs,
delegating any additional restrictions to the LSM.  With that in mind
I think we need to agree on a way for the BPF verifier to indicate
that it has verified the signature is correct to the LSM, and we need
a new LSM hook which runs *after* the verifier so that it can inspect
the results of the signature verification.  While it might be tempting
to relocate the existing security_bpf_prog_load() hook, I believe it
makes sense to leave that hook before the verifier for those LSMs that
wish control access prior to the verifier's inspection using criteria
other than signatures.

With respect to the LSM hook, since it appears that the signature is
going to be included in the bpf_attr struct, and I'm *guessing* the
best way for the verifier to indicate the result of the signature
verification is via a field inside bpf_prog_aux, this means the hook
could look something like this:

  int security_bpf_prog_verified(bpf_prog, bpf_attr);

... and be called immediately after bpf_check() in bpf_prog_load().
As far as the new field in bpf_prog_aux is concerned, I think we can
probably start off with a simple bool to indicate whether a signature
was verified or not, with an understanding that we can move to a
richer construct in the future if we find it necessary.  Neither of
these are directly visible to userspace so we have the ability to
start simple and modify as needed.

Does this sound reasonable to everyone?  Does anyone have any other
thoughts on the authorization aspect of BPF signature verification?

--=20
paul-moore.com

