Return-Path: <linux-kselftest+bounces-43979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B164FC06863
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84BAD5022FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E231D397;
	Fri, 24 Oct 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="F0w4pRMk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA931D73A
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312852; cv=none; b=maPVb6l3wipfT/YxohU4PuiWtF2M9kv9SBP6sK/DacAcR3VlNgnb3/Oa3Vzzn7siUgzfyBMp9BVxe32xEg5VAUWHZhM21ecPpabkhtZHYGV4HGmNpSYJDha1//POlda2jfNTOKwRGVlfsU9KExaUFl81HPRqHoBLVqlfQHV9N8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312852; c=relaxed/simple;
	bh=haLaA7lxMDvRDLFEREFCcYqogj0xnH+XSFGC/4Oul/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApUbux+0m0p4KNH7KKoiZpGFD72xCXvP06RPbKgBOBiHhvKfxwc+VTiDU8iViMqhArg10TdcFzD7nkNY5mcy/uJdg9JdHS9roYY+vGzA54C87wtC9qPCZqzFlu0n84nr2Be5/c7b2gR7DVt9a93mr11rFmxv1CVzedFScgm2MEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=F0w4pRMk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c3d913b3bso3679216a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761312849; x=1761917649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haLaA7lxMDvRDLFEREFCcYqogj0xnH+XSFGC/4Oul/E=;
        b=F0w4pRMkKeRNLAHzOSEZ9I0J5rfLBXQbR3ktGeMgOXOnly7wFGOBkQH04V70IEHk0i
         lJpyjY+gcU2J3q/EhE15knmJkv9KHftHLORTpENavzGt2J87MC99FkqU9YNyg1Loqo2W
         FX++8LQULPRoYW0M68BPoZn6Og+XRg+mITm4sccbxgQyRRGASXRSg48vMyzN2MpkA315
         uv81yTtt6uaTbzcSb+RXfNcAhPC08phLcIRxokALYBe8l8ILwb1vwFqDG717k4PNsxrI
         DIOxCKWDF+JInBssepgO7tzrM1lLnx4Nq9r4f45MGXqkMcRrqrfp1N9IPwe3Zi+Ug7Rs
         oLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312849; x=1761917649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haLaA7lxMDvRDLFEREFCcYqogj0xnH+XSFGC/4Oul/E=;
        b=WqSLg+Y97fkdvGlxs1hfUt0j860XGQDMXlr1eogi9J+dIU32VMDmHHhm2jL+sJSUzN
         2IVmojfOBgaqQYh84tfTVugXx8QZCrQBo10Z5jplctY6pU6+Kw+Ya5Wdug8K8eyAlJkt
         eEWAV4+vLD2qhiyLQnFyrY/ppFL0l4Lb/wDSEgkv62xmgkMKt8L17f1S+PrAdbOV1FH/
         xZmi2LQn1fxAzxKmXXnSDUmT8Q8aYhyY40CT9F8eTR7LHJXLxh/vzpX/hRPvFGLoHFSu
         fX/rkcYzAUoOJnsD6AJmg3RVmiEmvI65a6zIWYfNWp3S7d0B1wqXuVKd08PPKQzvf5lV
         pphA==
X-Forwarded-Encrypted: i=1; AJvYcCWo8gFzFjcRdiDbJRbWvDmWqEtlaq2RLU4Dr/9AFpdKk2cERpRf29oZe+7osii4AXv7I774Ko7xsUSfrjpcc8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkj9YwSp7HQuXok1WQFmX8hqPaeHSm+Una3SBPTtdTLppb/xU
	BS6Xdwtqf6qUS0ZSdmJO8BUo4oo4AgSP7MmaAz+Sme0+ZfvkO8sCNWhQGhU9DNlRhCYop6gV6qk
	WaY/SOylakERjkzCXusldVZ10Wy3e9e8V5d3xeNkgsw==
X-Gm-Gg: ASbGncsXVAV2jADqI541bnL+Jrdt81ug0qEaC/LOhjqcuyOqEYiXtXjYHPY9fTPCnuy
	MAb6Gfuwa4T+BGl1Y0Zfnz0vvFvax54nNeupa2XVZi/Ya3c6oBRi0uVpxceQbQ8vfb8vCEUxOa0
	dolZNT5nIg+EqxpZR+BrHsCm8CegqCLYZbyYGkmWnzeTWtaTeyGQnlrlB/tQ643bmSeGD4MNaCw
	F+zECq5LYbpFDmOjkQ4S7y9sIvEwERmvcF2axByGvQwB6dk7V0xktFoIA==
X-Google-Smtp-Source: AGHT+IEzIAcc3Ex0g+fxYGjBqIzlBf1vJcJLTWbeACMQemDEhzKA6K/edpqUysNPgOqtGsZaZRYXJAcNxrPf4tFjkag=
X-Received: by 2002:a05:6402:51c6:b0:63c:1745:a5cf with SMTP id
 4fb4d7f45d1cf-63e3e10b6f1mr5434005a12.12.1761312848891; Fri, 24 Oct 2025
 06:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-8-pasha.tatashin@soleen.com> <aPnaDxwkvEKAFlRO@kernel.org>
In-Reply-To: <aPnaDxwkvEKAFlRO@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 09:33:32 -0400
X-Gm-Features: AWmQ_bl_g5ZmeO-lTP-LhDGMe93IbEIGbMAHW9grfT3etU4xtd3jfQfdW6oYRhY
Message-ID: <CA+CK2bDUNfHBX=VpCww8ERa__+CUM5-a7pEi=hSu-W+S_-JXng@mail.gmail.com>
Subject: Re: [PATCHv7 7/7] liveupdate: kho: move kho debugfs directory to liveupdate
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:32=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Oct 21, 2025 at 08:57:19PM -0400, Pasha Tatashin wrote:
> > Now, that LUO and KHO both live under kernel/liveupdate, it makes
> > sense to also move the kho debugfs files to liveupdate/
>
> But we don't have LUO yet :/

Yes, I need to update the comment :-)

>
> > The old names:
> > /sys/kernel/debug/kho/out/
> > /sys/kernel/debug/kho/in/
> >
> > The new names:
> > /sys/kernel/debug/liveupdate/kho_out/
> > /sys/kernel/debug/liveupdate/kho_in/
> >
> > Also, export the liveupdate_debufs_root, so future LUO selftests could
> > use it as well.
>
> Let's postpone this change until then.
> TBH, I don't see anything wrong with KHO and LUO selftest debugfs files l=
iving at the top
> level, i.e

It is not only about selftests, we are planning to add kexec telemetry
that is going to be using KHO, and that should also be placed in the
same directory. Let's keep them neatly in the same root directory, so
we can use them for LUO/KHO/Telemetry and perhaps for other reasons.

I also think, this patch is small, so it would be beneficial to land
it now, and make it easier for LUO, and soon to be sent out the
Telemetry series.

Pasha

