Return-Path: <linux-kselftest+bounces-28707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CE1A5BF03
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 12:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF063B1A0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00401EB196;
	Tue, 11 Mar 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkJSPrSV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B121DE2C7;
	Tue, 11 Mar 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692667; cv=none; b=kWU4Q6mh8nHmsx61Ov0CpgUnOYBc83l8SHmEF13VuS94JJh+NCY9as4LlMq4/DTSKuTKhJt8+kauk65QKCASN3DAoLVz0f15kbTy4DFZoq1S/riU3cBMY1zILfRUJev/znePteup/oLAobbRfd80g7Twumgtjra+4A1Ir3q99OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692667; c=relaxed/simple;
	bh=IoRaI11noVTRO3MlIxVWAXDvfucnsch2p98lQAzFy6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIL6QhT/c4yweH07qtOlYIX23NABFYRLUig0FngWq0pSl0o4oxkc5JEf/I58+PmptTFXrooZU0QbPBuSq9anFAB/iNX5h8O2DH7MK7yqXGZTb3c4IFLkqOLpSBpq5kjjA7aAatkxa8es64WRy9TSg1NGLhsJ9A6OZLeW9J5PKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkJSPrSV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39140bd6317so1914763f8f.1;
        Tue, 11 Mar 2025 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741692664; x=1742297464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4w3dWTcO0ek704yH3PQq7wHDG4p/yn9ajswVcE2xISg=;
        b=OkJSPrSVtRTJp0S7CNec6h+GnFBHkQ0OUJ30oUixOPZlzSv0GsqjuPYGOTmYv1mdak
         1wFJIRwYHuRCamTdwhptWAg5nFkaYC7Ab3ozlchu/Bor2mfL0FuC4HgCEH8vEko65ELL
         VvEH2mhWIjnkp7XDbE5or7/V9QcXYB92FT8EUKXE9xrg+OnHRRoPWQ5z7mdBGNDr7Gkz
         IbzHTaoQNdnOU5tMcrnLlmK3jC+fJwleB+ZbCVlFvHlOMpY4EJ2H1zpvEAYsU2ipNGI0
         cJmrDSZNVusxHbU/QF5XieSzzQW62f843nNfxXM4/iBoHU2xQYA2giLXGOO6nekY3/f3
         +ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741692664; x=1742297464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4w3dWTcO0ek704yH3PQq7wHDG4p/yn9ajswVcE2xISg=;
        b=ulb2/iAv63xgys/pR83K+WoJpmQfSbQBPg18WXx16+FmjWjXHdz3Y0WNuTnJO5+6mW
         4tdukwKDHJsZcsHXri8DDWa9Lfvp7In10Slv2MIKP5MhR0lFZ/fa9CEn2w1CEpScohjD
         /dlWYmnvF/FzJDuonz2nyKbSOPDrT+/hVFJhd41/loWJGjmw4FJ+3Ya2r5cv+e9g769G
         5kAeW33ecUzxHDpxokB/ZbIU/8S2eL0sezQHTYyoor+CRqwjRn1lrlIzDnMW2x6/I1Ef
         jCfB52Sf6xhRKgYXQ145P8Jos6Ddr3BElxHRKuN9J2EKUJUv3R6IWUyacaLbb5CC/NNp
         lnsA==
X-Forwarded-Encrypted: i=1; AJvYcCUYFgQ19tjyzmW+u5TGA3SqHJ6IBpCAM/KyB+1ZcrA8Sp0ruTtrEXcHj23yn5fi0AWo88J/i2HdOw==@vger.kernel.org, AJvYcCUwDYzXj/uZLNXSVKoClNpnPNGgiAIYZgYOu78YIUam5zhWZ1lpjFGC1Phd3F0vetd7LtcnIuK/jhPnWxllCvTG@vger.kernel.org, AJvYcCV/enF+VABaB089Q49wFeqH3bWiMOPGwL/Jx79bYEYY2gNCJ98hgsjB1j4869Svhaum9AU=@vger.kernel.org, AJvYcCVARtfaRrF1EJgOHVsk4jKFNr3W4gHvj+I8pc4/5I7KvJ68oW6wUSCjS+Y7u3HLdrnPNWJKWWj17dksYIWk@vger.kernel.org, AJvYcCVoLIa5UZ/IKnz6HdX/AJmVbtJqGhz9bgJQyLoBW9g+sVp1GGz67PAQMj2BSgcLkLsqKCP7bWWxyoBogqYGNSLlJdlLB4y4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qofynwxHp6+9qRxf/qOCUcmfWC3Ktofvu1XSody/v/VY5VGj
	2REb3tuhuice2US4+0Z8IlikQK1TtSfQTcpJwhZBybxXeiMiaXPFKhcJLZaAoCfVZXJYq8YbxGA
	6EsTbuzF+plzidQy/KEbnyne1cxI=
X-Gm-Gg: ASbGncuyo78P7i+vv7BwkQe8uLlKkfSMpl2l7hKEU338bhr0KWfpTNzzB5Ox6nFT6Il
	sE9lDALhuSmT559zBK1Fyk/atmgEWSD9Q5L0f69Nk7VlyLdW8w7iOyaYoXmI0WtqgvM+qjvBQbm
	EqODW3WEIBfXN3QuIYp+y9lA96Hg==
X-Google-Smtp-Source: AGHT+IGe87XZZVJaKirtZvvivYUORISGTO6tR32KWWxfSIu3ZPSnyn/0hEdR/rUZWxsG3CGlbmQA1XqzLn/cM7RvOTI=
X-Received: by 2002:a05:6000:1f8f:b0:390:f6aa:4e80 with SMTP id
 ffacd0b85a97d-39132de2a58mr15607923f8f.53.1741692662531; Tue, 11 Mar 2025
 04:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310221737.821889-1-bboscaccy@linux.microsoft.com>
 <20250310221737.821889-3-bboscaccy@linux.microsoft.com> <CAPhsuW4cCkWGnJfxJvBd498iTd3-hMXLg=s7S68vdgPVhdtqCA@mail.gmail.com>
In-Reply-To: <CAPhsuW4cCkWGnJfxJvBd498iTd3-hMXLg=s7S68vdgPVhdtqCA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Mar 2025 12:30:51 +0100
X-Gm-Features: AQ5f1JqKIc1OB9cpJnnWo32OpJeOl2OMwIm1txCqFuyol4JlRHW5vV2C9u8eQL0
Message-ID: <CAADnVQK9UiOoNxR6TE6Oc2SnEJ2i5Jt6pmvrviZ6OrNJhbyV+g@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 2/2] selftests/bpf: Add a kernel flag test for
 LSM bpf hook
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:07=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> > +       lskel =3D kfunc_call_test_lskel__open_and_load();
> > +       if (!ASSERT_ERR_PTR(lskel, "lskel"))
> > +               goto close_prog;
>
> This goto is not necessary. But I don't think we need v8 just for this.

I left goto as-is while applying.
I felt all error handling being consistent this way is cleaner.

