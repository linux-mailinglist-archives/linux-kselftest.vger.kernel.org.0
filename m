Return-Path: <linux-kselftest+bounces-43723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60FBF9704
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 02:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E719A7022
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6C42056;
	Wed, 22 Oct 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="G3Bqj0g0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817E339A8
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092144; cv=none; b=UiyBj3lgPpeoaRe/rSlSlfdaJIMo9n4Mfy1DE6et8jd4nCrNVBfc+//Jio1sLKcvdyXcGb/+kMwfjGUnCHGceTDtnNU0LFqbZPY9Ka9dWmkVFjpsBCYMgxVXNa/aqmpw9JkP9ny3q+DHhBGxhnBVsOq6SsNjsmzuInUqfdtHV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092144; c=relaxed/simple;
	bh=QYMZVxBtPxYE6EZ33C1HyrkU93u+VGFDqSaut8Tc8WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lah+h5lPhDwHdkNj4YIGa6Oyi/fdhnsV3BYJu0WNoNushJqkDjj22VOxn4PdCMdCCj8sArjQrc78pxxAqrKWb2vl5a/HGUjo5To++Nva0JLAotkAnsPFQkR6AySxNcLVhOWUEBMjEarHmluCj/3zXiBHeg/4AmZOVs6mfYUH65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=G3Bqj0g0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so10062246a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761092141; x=1761696941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLtBMolvhxZ2nYZ7lKeFnDTLrdScVQzTUS7wwB8pSBo=;
        b=G3Bqj0g0xeWEZUc5Zh8TZGPqunr0+nw/v+B/GQzXSSE3VnxL90ic5vKhcPSEKcWZAb
         clhmQQJLDOj1LU2nE0RfCYy2T4w/SQ0VN2DwLPOodO2R9T8ghuiX4qLm3mXAk7UH6NpS
         qKrnE9g3avFQEuGRqq4v4uQUTd1rhIStJsFpJKlY3EDWgiYMcIV0nsPW9UL3PZT7SX8e
         GfDescpzt0BMIt2sZY48QG+KVWBcy32yJjBoPjBcHffNyAsOxV16iVLxkVq8X2tMVi5j
         qA9M0o6uoWEZSme5FIzzn5U3/QDqCoSKqi5zEnCVlli6RoXuKBlaE28o1mOYxZXfGMSf
         NutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092141; x=1761696941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLtBMolvhxZ2nYZ7lKeFnDTLrdScVQzTUS7wwB8pSBo=;
        b=i9co6/kLLxEDp7QzR39fWTum1UmmT8k4lUEsHwblEnLHUQvqo4BhT1osSPqLsnl8CX
         wga8Hby5YAO2CiA7nvOKEnGXF3ZhLFjDJIfNHCaMNXeFSlw/JqPSUqcqp3wDLJ8vtQmK
         w4nxStLEh4IOshndz3d3bEIDERMTNnUm/+PLIpwEDOH+YiEoZE9eRIWsgNcud5mkUvMa
         CsIOKqHZKvIhHpcMYvqhWvu8WzmYYRiNC3EApGHCq1XBJatHXAKWVRDntyBC0XZBiwRI
         LX3Oib+jzHVeIa+cvau9J+FyfghV7sfiHZyIIewFVAVP5dO6bY/X8q1xIEqNxtvdDgGG
         ODiA==
X-Forwarded-Encrypted: i=1; AJvYcCWAJfbU72CuBmtkk6pxh8kqs3IS7D31MnRDUIb3Kt+yAjD4+CsIpc7cYjJNphhKhU/EjhU4U+5jlRraEOQxQio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNmllsk/EJhxXGVmfs4iTShe7YmSUQq3EIqV0JwRrt3DTaGQ33
	tQ26U99j0lwsn0ovNdLrIes+08qV/Snq6IMsnPtGS8hYk3o0QyJpBTy119f2hBcGCcM0zkSSToq
	ulJK+HBwbbZlq8nASHpkXj11IBpNSuNT9hUOrM5xXmg==
X-Gm-Gg: ASbGncsV6aX97JQwRHTpCMT7tCJDQ4VEJ1h8dGNg+V3APsPfEtzq/NBVuZr8S8Zeotw
	rlTPr71rFFg8oQQzq+4nVInmROQ8Arq4oqOgXCbkQQ7DXzltEMnuswj9SbrZ2ll4m47nPc6xOwX
	LAYLZ6mS5efuZiioZVz1LNex/KuX+NCphxas7xw3L9TFJV/wg04gTBK67sG8kfmiIW3RSB6OnBh
	I9PCN3yZOuoRTQkBFMlgSD11yGJG7gbdhzqqDFvyxUulBC3rEj9z0v4/FqWBaN7lVPy1vgKenUa
	tqQ=
X-Google-Smtp-Source: AGHT+IGEuNUf1RCSQwHL6z3gwL7zUADiyfawv+wMX5M61bryfLVp3bld3mKFx8Y8DLsaMjtsAzBcptrVbG9BZA3Wnzk=
X-Received: by 2002:a05:6402:d09:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-63c1f6f6269mr18383154a12.34.1761092141269; Tue, 21 Oct 2025
 17:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <aPchmxfh4ACM0vY2@kernel.org> <CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
 <20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
In-Reply-To: <20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 21 Oct 2025 20:15:04 -0400
X-Gm-Features: AS18NWDlyfI6cWth3r_g0r1Pr5LDh2e3c5ckbdEBRacQjSIvh3eM9w5sLU_efF0
Message-ID: <CA+CK2bDPLAS7EM--stHkZkx8FSgYBjDOz6FdvWBYrdHwZpZZjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, brauner@kernel.org, corbet@lwn.net, graf@amazon.com, 
	jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org, 
	pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:53=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 21 Oct 2025 12:04:47 -0400 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > > With liveupdate: dropped from the subjects
> >
> > I noticed "liveupdate: " subject prefix left over only after sending
> > these patches. Andrew, would you like me to resend them, or could you
> > remove the prefix from these patches?
>
> No problem.
>
> What should we do about -stable kernels?
>
> It doesn't seem worthwhile to backport a 3-patch series for a pretty
> obscure bug.  Perhaps we could merge a patch which disables this

We are using KHO and have had obscure crashes due to this memory
corruption, with stacks all over the place. I would prefer this fix to
be properly backported to stable so we can also automatically consume
it once we switch to the upstream KHO. I do not think disabling kfence
in the Google fleet to resolve this problem would work for us, so if
it is not going to be part of stable, we would have to backport it
manually anyway.

Thanks,
Pasha

> combination in Kconfig, as a 6.18-rcX hotfix with a cc:stable.
>
> Then for 6.19-rc1 we add this series and a fourth patch which undoes
> that Kconfig change?

