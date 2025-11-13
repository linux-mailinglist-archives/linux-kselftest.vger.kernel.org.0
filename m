Return-Path: <linux-kselftest+bounces-45591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9EC5A4B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 23:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB693B1917
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495B326924;
	Thu, 13 Nov 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6Ilp+n7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62E315D3B
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763072065; cv=none; b=TNicpMSpsAIEOT834scehDHaJiZ4XwnoL+6l/UgYjKVuV5FyEmle2ObB5Iu2/U6K3j6nJndAdMmWGWlyyxxnyNcVzcBuf46p9VvmCkoDts7LdYNJbAfvCnNtRi9J9QyziXzy2VFKxKWvbXi+jFkYRgg2fKksyF0SKmi3Cup89OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763072065; c=relaxed/simple;
	bh=vg2n9jgyf6Un8yroS0eZ9RJEclmxHEAIxafM2FtYloU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFaLUVlRO++jxPx38MuagzGuPWPbEQPsCE5ByUGNVGmD9Q2/3yffX9kS5LdayKaQxe1VBjf3wua6qJFfILazjOZeDi10snM2rbL7jLAIqZ8JhglThrmMYvX8GbwMaSgyxm8dzL7jjAsxopE64Zr+yTba1/ORePjDgNKjQY6YJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6Ilp+n7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477741542bcso18975e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 14:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763072060; x=1763676860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7JRornaiplk0uZKMqz9STwhUMyLeMRJwxelXDphyMs=;
        b=q6Ilp+n7pTN4+s4aQsfVwd8VdZlJEgIq9zdYAR/33q19ER0geRYo1QEysrFMwV2E3l
         pXWZBeQxzsFBvjBEyAoWSqnJcCpWaA1WiOwjXHZgAxuLQfeSKWo3wy94l5EfwuOjQ0DR
         C0EnayLvOwdjaCa7dJeaR743KyE4+C+scFCHI+NDi2azRKiJcp1JfhDPaDk/coIb3fAa
         fEERTY6L9K253ca9ik2xF0Zxx2SZpjGWvq6wmDzVXj7kV7Vid2VPyfuPHgDbyYHvNOM3
         YyYriFbnqgeb0ZFOhN7rYO8GMMACLXRFkX2fO6hsSD/6lYR4PKJzcIRH88qHDTxWTwPQ
         U1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763072060; x=1763676860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7JRornaiplk0uZKMqz9STwhUMyLeMRJwxelXDphyMs=;
        b=pzHBf1HwRk9IcfDEsbUSlMrbCmChnLeb7FZt229spCwDwWqL4YrLKkL+D+hxMWIN/1
         V3m4qNy/Ahfsvm1sUyCFWAN4YZ5Ak0czXPmVnqWSwlvTPVDDv/4ND9lAhjvPOH9j6o9W
         XSzeBborJ4yybv9LTll0r3PQKpE5QPkh27dA2bpXJE+tfGGNR18p+nFDUDEcUWpvKu/D
         sMVkHUNNDgJFZ8ZBcxJMbY5SCj2y/TC4bCQu2ZNsfkIFTQ0deG6oTURtwIgJsJnxIrpI
         3jSCOEIOMLD9cP8EiUoJu+DGn68ZB3t6WK93BEFEIkC7jykh5KvtiUDOH+rY2LFLBwlY
         CvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz6y/KZ6zzaZrN8UQSLPT2nkJVUbtV4c+f4pXwt0wN6v59TnwGtJe3iz/8v6Vzsv7o05MBRnXnbnsG7p5keZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/aG2r2Ux7r3yR8YyVvteGAhiEvT7GxdRav5r8r7oZyfK7XeZ
	uLw5scPVEoy9tqozLVqzlHyfMQ1UbfnZo/OvTmnMnv55AH48kpXw5GxIka03adLBXwaQrvhZf8N
	O4Wd+mhJ22dnAC6toms44lApYYz8vdIqd7RWa/g91
X-Gm-Gg: ASbGncvdrJo7/yxEQxJedghMpIzOmT0yFfFZ7MRgrjZDwCTkKneSaSc0YejnsRJmrVG
	w5RoQHsREW3S2mp8cvqnwFPYQuWrOQ6zpq364ye158rs9Dwv7EnhI+8j1fhr6GV4xc9LSBDT//t
	lbPjRwmGK3IxFIBtetUZ4hvqyON3+FCsGSRWJAQd8YJvmRypZ+i5WxrZwwdpM1ordd3U9+7Wrv1
	Zwoaw1tx8DPQCrhZ3QUtJgw18Nh+fZtJkDf0DK/nsz7zMt/gdsqkDCpeL5NIREbaY/ZxRjDePWq
	9dXKhWI5NQDIkoZlkfCK3vChTA==
X-Google-Smtp-Source: AGHT+IH1dTN9h9lNDnRTlh4UyFd6aH1+EDMlfhkx9gNk7p2AjcKqv19bBUUeTsmBJjRKqPU2Xh2SmzFkyX1KkJheFqs=
X-Received: by 2002:a7b:cc99:0:b0:477:772e:9b76 with SMTP id
 5b1f17b1804b1-47790b11bbdmr102735e9.7.1763072060296; Thu, 13 Nov 2025
 14:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185903.1372553-1-jiaqiyan@google.com> <176305834766.2137300.8747261213603076982.b4-ty@kernel.org>
In-Reply-To: <176305834766.2137300.8747261213603076982.b4-ty@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 13 Nov 2025 14:14:08 -0800
X-Gm-Features: AWmQ_bk6n8j-0ORtQ1jAf-pM3nvvAf6VB8V4V3Ju58iczpjKI42PYMXub9cNtfk
Message-ID: <CACw3F51cxSgd-=D46A6X6GptEZS8-JZ_MnB_yK_ZR1wktunYRA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
To: Oliver Upton <oupton@kernel.org>, oliver.upton@linux.dev
Cc: maz@kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com, vsethi@nvidia.com, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:06=E2=80=AFPM Oliver Upton <oupton@kernel.org> wr=
ote:
>
> On Mon, 13 Oct 2025 18:59:00 +0000, Jiaqi Yan wrote:
> > Problem
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > When host APEI is unable to claim a synchronous external abort (SEA)
> > during guest abort, today KVM directly injects an asynchronous SError
> > into the VCPU then resumes it. The injected SError usually results in
> > unpleasant guest kernel panic.
> >
> > [...]
>
> I've gone ahead and done some cleanups, especially around documentation.
>
> Applied to next, thanks!

Many thanks, Oliver!

I assume I still need to send out v5 with typo fixed, comments
addressed, and your cleanups applied? If so, what specific tag/release
you want me to rebase v5 onto?

>
> [1/3] KVM: arm64: VM exit to userspace to handle SEA
>       https://git.kernel.org/kvmarm/kvmarm/c/ad9c62bd8946
> [2/3] KVM: selftests: Test for KVM_EXIT_ARM_SEA
>       https://git.kernel.org/kvmarm/kvmarm/c/feee9ef7ac16
> [3/3] Documentation: kvm: new UAPI for handling SEA
>       https://git.kernel.org/kvmarm/kvmarm/c/4debb5e8952e
>
> --
> Best,
> Oliver

