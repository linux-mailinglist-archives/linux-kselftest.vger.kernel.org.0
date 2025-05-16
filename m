Return-Path: <linux-kselftest+bounces-33225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB80ABA456
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FEA50384C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFF27FB08;
	Fri, 16 May 2025 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GHEga/nS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594FA23504E
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424970; cv=none; b=uH1u2+hgoGOEQTnIDNifcFpvH3ToFnoqQ4ybG5/yJKoo4fjoaebBz5frmuHSREeYXuJQS9NCyYoSav1vzew4RBjTMLXTEWjG1vM17wTD08ovB1tvaP5HLWB+YjC07pUeiieuZJii8yOw1RLurRHs1jsOZjQRh+E9vAbXrA76zbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424970; c=relaxed/simple;
	bh=nLoaIDD6+TJAz0bOPeqNCjl0kdmqqVG70rJ0R5xo6R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSFeu3BGtql98xpfYzgGTUz9fI+lDuuuekGJeWv9JVZHa8Nn+SS8cuUy9FYLzkaccuoe8mbkIlMLUwwdGBd/z7o+TkNYH6U5gEeydYKezNmJ1NoXrN6Vi8604BZbjgB0p7TlTDHnG7D6Zez0xQkcwq00+j9Xp9mSz1LKhVtl06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GHEga/nS; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7ab544d798so2058275276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747424967; x=1748029767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l/0xKrDAl3wR6FwPFmxGX5JGMTUvNTKlZKVf0AUdss=;
        b=GHEga/nSbOA1NOTKKNMj+qfMQhYeZT0tyuw7OU0zuP/+aWac8YeezxVc7HhqfEtlIP
         bG7NmcWMmodUR2VHQ0XpWCUVmqit3mmgody+RR0se8Uuk7p+WddTL4RLFGmSMycy+M4H
         GypumqnW/xWJ9xFtD5LxFhKlJ8buDs/w8eH8UahaHPBAULZkA815EZTwqqy2bGipbm+F
         5uDygxoduGWw3IGF8qMWKxyms+GBJ3JjeYQHkOULd20GmIttOP5FqoP8yKmNPAvZgNGT
         G4XrA47ELF7PtP3/OQ411gCDdLt4jLgX30U2i2SdP9GtIz0J0OLRv7gVvLpYNMVPWH6a
         pYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424967; x=1748029767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l/0xKrDAl3wR6FwPFmxGX5JGMTUvNTKlZKVf0AUdss=;
        b=xO94hjggRugoxxH7EIv0xmWRqIU4oWOU4M4yEjIkyB2P49WXawile6pgkGPnyjWkTL
         +ML6ZM+i9PFhKGqT/WyTduzI90FBai/mHHTHhS3b81S4D1WtfiQyEvwIdQkJV7Y8FKem
         oPAWVXeS1LuZSLbJigDyAB3T0dyPMmtTXlW63T62n96SXjH9R6RMRMC7uHOUiEYvy4tr
         rFCf2OPrqMTsW+2IE9uXO1p3+BOBk03tkd6xyYT9s3e3eIRpd058BsjOZXt9phPoFxYU
         btgc2JJ86+wn6VLnPC/IQ5GFa/60/lOLLDITrn9ePBiDm9jPx9PaAvWcqmuP2VaYRk+t
         Jubg==
X-Forwarded-Encrypted: i=1; AJvYcCVrHkGA/FnwcBfgFt2MS30hkcnxYy1J6dt9nOriQqbCCRXzys3aJqsKvLxlU/i5l8tNU9xGYjQ+LkPMgLZHWpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpHS9OOsQUTJpz5Xq6h+qvsL71hlyxKcYrwxZ2naOTplRsSbb
	7uE2OSc8Lit8eV/kKRUPHCKqTEP8Irmq78Lz6lMtoJ4ZF3Iho4JAjWo/NbO4Rb1b2Oez8qloHDz
	fzuSqmKy0KnZqWX+gz6VnQmuBSnlgGunbFCbP9HmS
X-Gm-Gg: ASbGncumsGkbNxtX0zibd0Ga29qIpvlQmd6niRENrpuT9aOLiOoGwOy4nBtj6QaawJ/
	7hVu09uM4IsGCydeJpHcRO/vVr74LwMyoHrKgb6A6E880u/JmK2w81dolQOzXtotRZ8bcfTnC6W
	1q+M1VFa/7kDXu5sx6OYvWrtZIRw5/yxVU
X-Google-Smtp-Source: AGHT+IEQIkzEpi0E3fz8WZlSmcfqapgq69lMRohpEoCb3vyZJS8ONyTw2i0/vIHmtC9UeMyPfp6xvEAOklEV9x0FCwo=
X-Received: by 2002:a05:6902:1b09:b0:e79:7ba6:f8d with SMTP id
 3f1490d57ef6-e7b6d3bb248mr5339420276.7.1747424967244; Fri, 16 May 2025
 12:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
 <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com> <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
In-Reply-To: <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 May 2025 15:49:16 -0400
X-Gm-Features: AX0GCFuBXEBi1NnN_9kfsOxw-5nGHtwLhBNF6-R1ixmmmxe2op_6asanhCRDNXU
Message-ID: <CAHC9VhTeFBhdagvw4cT3EvA72EYCfAn6ToptpE9PWipG9YLrFw@mail.gmail.com>
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
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 2:48=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Wed, May 14, 2025 at 5:06=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Sat, May 10, 2025 at 10:01=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> > >
> >
> > ...
> >
> > > The signature check in the verifier (during BPF_PROG_LOAD):
> > >
> > >     verify_pkcs7_signature(prog->aux->sha, sizeof(prog->aux->sha),
> > > sig_from_bpf_attr, =E2=80=A6);
> >
> > I think we still need to clarify the authorization aspect of your
> > proposed design.
> >
> > Working under the assumption that the core BPF kernel code doesn't
> > want to enforce any restrictions, or at least as few as possible ...
>
> The assumption is not true, I should have clarified it in the original
> design. With the UAPI / bpf_attr the bpf syscall is simply denied if
> the signature does not verify, so we don't need any LSM logic for
> this. There is really no point in continuing as signature verification
> is a part of the API contract when the user passes the sig, keyring in
> the bpf syscall.

I think we need some clarification on a few of these details, it would
be good if you could answer the questions below about the
authorization aspects of your design?

* Is the signature validation code in the BPF verifier *always* going
to be enforced when a signature is passed in from userspace?  In other
words, in your design is there going to be either a kernel build time
or runtime configuration knob that could selectively enable (or
disable) signature verification in the BPF verifier?

* In the case where the signature validation code in the BPF verifier
is active, what happens when a signature is *not* passed in from
userspace?  Will the BPF verifier allow the program load to take
place?  Will the load operation be blocked?  Will the load operation
be subject to a more granular policy, and if so, how do you plan to
incorporate that policy decision into the BPF program load path?

--=20
paul-moore.com

