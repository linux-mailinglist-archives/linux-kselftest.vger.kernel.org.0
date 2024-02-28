Return-Path: <linux-kselftest+bounces-5563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA686BBD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 00:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AADB2603B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4C72922;
	Wed, 28 Feb 2024 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQ5RFpWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBA7292A
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161220; cv=none; b=PeC20FqDI51rl9AzU/9iZBUwAGQ3dcuHPy//JgX7xs1a7UR67r6GjvFpxoEOMmOgF/lBOOeX7UldCWM98qIexj51GlUsZmZK88YA77sgwgjAp/YUibost7wn1QpU2I54XrFMFnFrIm/LNPNreeiUXItlkJD5+DDUBqyFpgfStiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161220; c=relaxed/simple;
	bh=w9b+viWMNeKfgV+J2kHVNJBYQcvE+Z5QsH2BWI8zYbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vxj5Vpn0Q6ZONvE01R6H3plzglYR0695jbzuv4J7diU3QCuYKFsiw4K2uy+2skUlguMabK8LK1S3w+Ha08+HW/uBIbwKteQNI98FKTAijO60MC158xFgRM3vZGGFRx7iSaTPWIJZSWaKu/vnkUyvKPpCk14uJaDRJveyMihi4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQ5RFpWq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-428405a0205so61801cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161218; x=1709766018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HopOMhsdcEXeddljk1n/xV5v9vRitHQfeTlE00H1als=;
        b=rQ5RFpWqtFrYnTjUnWf/wec8CW7gfi4ss2dES6Dif/YjWa73nYL3NMBtoqtDvHHaYe
         ad25Xd8PiFbwN8aLkdUVX+pWEinmCLNLItCWkDCUTZQeOrvn7qHVzNJLrFxMSe1FNhuW
         mWR1VKR7S0cj/QK9CObk92JkQt/+P4Mpf662aBqaEgWESIuW+HlmdyYb//hIhPOhRfsq
         QJnq69LccTZK/kCRo/NiD6cYxXDhwFlRzVTCGo8Iv3UyLWlAVmmt21kp72T2lfblql9S
         UeiifBk9U6kW6fL9iU9DaPCPRSKiFtKZMDl+vn/Qa2mL+9dO+nfnAEsjjeTBpkDZS1U1
         skhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161218; x=1709766018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HopOMhsdcEXeddljk1n/xV5v9vRitHQfeTlE00H1als=;
        b=jQswtrB2oGZC+s26n0+XZIZ6djXFpDXx/pbNjn31DIlu5qADYlQpNL+lbRlrwH+D3i
         Jh49sifOweohy0sAp1sWcDm8W99LMu0iEQpBXcu6BtNLyb21aHxUDejEYyJlx9fiMA+D
         suyPIeXVC5RzizZkvYr7K2UurwHEOM6L3hVbJ0qNXAu8foMOyr/lfMd6bBz93OYwkQnB
         AgLpzAMbxnvyRbe3FJN4X5zQ5J3O60ukxGV2OqxStQfCcyKrzrQFuXkMxs//V1au50vT
         DKyV/75kLyU7DlZGlK7tFqVnLOJQEIMMoWOv8MxrCoFBopMz6SQL8OOpPjUPZyzcGD2W
         zMpA==
X-Forwarded-Encrypted: i=1; AJvYcCWNRzEeHJqFm8gqXnMC8t6gI4LpgHjv1Bmp5V3BHEH0iT8QkVUD2Vs625bZtbJPbu4wTaF8TGJbTe/qkrbgE/g5HVYI9dAhJ00BCscqQYwe
X-Gm-Message-State: AOJu0Yy49newbzBkKwTPpsMXHWSpq6oL1FXzb9BdO4XdgAkLIcoc2xIf
	K/UhtRsQirOYZQgQ8/NKp1GNL7y/rzxKlPHDASURb98KROgSkUKsS7YcleBQSGQw/KC6YBXZ/L/
	jBGPlFGYfcPEtk616yfMRQdSDFWPa19yAJ3BS
X-Google-Smtp-Source: AGHT+IHEIl48iHJ1KzuHiKAjTB0tNQfgDXVFK6cKBoNpo/4g9vj3G+jFbYTISECOdJryun78YLwqHmKV20w8Yw4SezM=
X-Received: by 2002:a05:622a:250:b0:42e:b8da:1457 with SMTP id
 c16-20020a05622a025000b0042eb8da1457mr19090qtx.23.1709161217908; Wed, 28 Feb
 2024 15:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208204844.119326-1-thuth@redhat.com> <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk> <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com> <Zd-lzwQb0APsBFjM@linux.dev>
In-Reply-To: <Zd-lzwQb0APsBFjM@linux.dev>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Wed, 28 Feb 2024 15:00:03 -0800
Message-ID: <CAJHc60xqbrH5cgSm5URhxF1j-+X7PVD1WkqEBRKENo-GeQnsnQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Mark Brown <broonie@kernel.org>, 
	Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Shaoqin Huang <shahuang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Oliver,

+cc Shaoqin

On Wed, Feb 28, 2024 at 1:30=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> +cc Raghavendra
>
> Hey,
>
> On Wed, Feb 28, 2024 at 01:19:48PM -0800, Sean Christopherson wrote:
> > but due to a different issue that is fixed in the kvm-arm tree[*], but =
not in mine,
> > I built without -Werror and didn't see the new warn in the sea of GUEST=
_PRINTF
> > warnings.
> >
> > Ugh, and I still can't enable -Werror, because there are unused functio=
ns in
> > aarch64/vpmu_counter_access.c
> >
> >   aarch64/vpmu_counter_access.c:96:20: error: unused function 'enable_c=
ounter' [-Werror,-Wunused-function]
> >   static inline void enable_counter(int idx)
> >                    ^
> >   aarch64/vpmu_counter_access.c:104:20: error: unused function 'disable=
_counter' [-Werror,-Wunused-function]
> >   static inline void disable_counter(int idx)
> >                    ^
> >   2 errors generated.
> >   make: *** [Makefile:278: /usr/local/google/home/seanjc/go/src/kernel.=
org/nox/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.o] Error 1
> >   make: *** Waiting for unfinished jobs....
> >
> >   Commit 49f31cff9c533d264659356b90445023b04e10fb failed to build with =
'make-clang make-arm make -j128'.
> >
> > Oliver/Marc, any thoughts on how you want to fix the unused function wa=
rnings?
> > As evidenced by this goof, being able to compile with -Werror is super =
helpful.
>
> Are these the only remaining warnings we have in the arm64 selftests
> build?
>
> Faster than me paging this test back in: Raghu, are we missing any test
> cases upstream that these helpers were intended for? If no, mind sending
> a patch to get rid of them?
>
I sent out a patch in the past to get rid of them [1], but Shaoqin is
currently making an effort to (fix and) use them in their tests [2].
While we are still reviewing the series, we can apply [1] to unblock
enabling -Werror and Shaqoqin can re-introduce the functions as
needed. But, it's your call.

Thank you.
Raghavendra

[1]: https://lore.kernel.org/lkml/d5cc3cf1-7b39-9ca3-adf2-224007c751fe@redh=
at.com/T/
[2]: https://lore.kernel.org/all/20240202025659.5065-3-shahuang@redhat.com/

