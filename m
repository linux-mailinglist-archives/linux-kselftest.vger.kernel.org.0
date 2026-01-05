Return-Path: <linux-kselftest+bounces-48230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF19CF5235
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 19:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EFD1303B451
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E705335093;
	Mon,  5 Jan 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UN5dRM3z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92482D837C
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635697; cv=none; b=L5ZlReBNnrZ+qVXu8nzUg7q0+/rfz+MlrupFxowVx8jBgGjc3gQzCuZCOTqIkcxWaSJdHz7Ug6clwBZuwX2BONjASlWrflrleJxp0gf8cwSiO1diTaFv9UnOsdXsF6yvSmamW1GW7FSIiAoGGMYs5Bt7crU8k3AE0AJ5ya26+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635697; c=relaxed/simple;
	bh=3exiw0thvbCtX+WLOhnht9nO6z7rXw54qNFKoQqhAuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvrsLTej7QAShgz2xpBkTLmazyifez7xdbxFPzR6Ze8q86Tyed/llZZQf8F9WKFHzCpXhGNn80yWI+kUV/62Gtie9E6WRJqc0Ya55TSstyf2y9d39g7eaWz82kr5Vxw6cad1HAHmIzTXMkhQVsvDrzRgsUTAZR8XkXK5ZHf836U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UN5dRM3z; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37fcec29834so1818511fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767635694; x=1768240494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKzk+CxxnNt9ZNHbY1DTzzVJyV243CDMIdk2HW5f4qU=;
        b=UN5dRM3ztSXkZHfhID6ClvBESyiWxxz4sPV1ufIJGKf/E3BFKB5tA+z6nHJ46yRawk
         EMSdDrmgh445S/1GVaZNcxlEdxDsmNacFx99q6Bez8Xa03+sO3oGaJw2FAbZCZF+IoSS
         BQ4QELKiCSyJxeePrT13U72odBGZNhEvweBMS+HOePiiZE/DTea1Fje8ZrXNqYvfi67z
         b3JojZFMraQQu3N4ppNwi8J/ZCIcHvbW9WdMjvC99HiyPNswN1Z/ZiX9NtFodhartE7Z
         c7hiyaxMYrJH8E58ecEYqs6EN7h3CNmUm9b/cSQFlderY5RMovkpXsndF9baBIlg5OFl
         30ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635694; x=1768240494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKzk+CxxnNt9ZNHbY1DTzzVJyV243CDMIdk2HW5f4qU=;
        b=MB7dj2lNuoDkvRYHrLiDfJcaiZFvK1MV2HCIlXxwpZkic+CerYLoL187qIv+6/K74u
         jjqxRi0vFbL6B4qljcMIelxZ2C/MtyNgHNONtsU9Mc7L1W6HhF2vaQg+5ikQE+N3jP2i
         2DLr1IpMYrcrW+2J4PWzVQs3b/wMcxJwOaFb3iFjJ4MinhcI0pQa+8gqeSbM3cL5AwKX
         hkcF5fwkKSzVjmXZWok97DBWkPw75Gzc3UAyM2mdaZo08D9+nMTjCK5s5ABl7YlvBFFV
         dv3ETWmCtCCuzPY1wgYsi9ot4VybqIa0dki+mJYfeiHCnABxddYFduIN0xaFo40JrSVC
         CGWw==
X-Forwarded-Encrypted: i=1; AJvYcCXdTHSZNGoTw1pMvQ9nO/1uUKPFt9xCi18pzVAIjlIsNhP5uFsntacKYL7OgUs3eq74IibDHC/veogCq4MOAzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZru/WJ25Kt2UXMYZYo1npTnzspXrHiyfEIlKvZ4BWNJwy9TK
	2RhVQ+irQOqtCwLDE6+Y+k7pLbV4H0ysbbjR7ocn0ODx5kjPALM4naNH1APFsk+oRIgwcAwQR4k
	m5bXMPyL4VbGm2frO/htIakGrpCLDVR0xxQJJx9wX
X-Gm-Gg: AY/fxX4ftHHAlayBXlSKzmSD4XpxZr1OpJ76wjufdUnPCe55sZQgeNu5cColaYvx8nI
	LXIpvMO81WJgMaUnQgpOLcTxBjlQNEvU+MTwMEvrL7EtpVGbvEN07z76KfBeGww0NSHSy8ehiHZ
	7Z0yGy2NxjQMVnfDyVTz0Y9dA7lPxFKxkD2ohh1j90aklYBf975zqFx7M8fun1wA37/q9UpHBWl
	PuBYMasgA0Oj55swyrVVMm010tg4ooA+01jmcsx/VFiL19zTP18aajvUYzf0KEgznSfi+GL
X-Google-Smtp-Source: AGHT+IG1OlQp7L7xGRo0uQarvmhbCxjRiBs9CCPI1n79KwlTxoqllow+YbWs7GIzqxYb/LvpuhvZzbuvoSSvtdK3ah8=
X-Received: by 2002:a05:651c:511:b0:37f:aa88:83fb with SMTP id
 38308e7fff4ca-382eaac1869mr377291fa.32.1767635693427; Mon, 05 Jan 2026
 09:54:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-20-dmatlack@google.com>
 <f0439348-dca7-4f1b-9d96-b5a596c9407d@linux.dev>
In-Reply-To: <f0439348-dca7-4f1b-9d96-b5a596c9407d@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 5 Jan 2026 09:54:24 -0800
X-Gm-Features: AQt7F2pamlADbdQVNO88tt3y4iAorzOwRP2E99cUQN8k3LcTYOLnYFBdkWya6hg
Message-ID: <CALzav=duUuUaFLmTnRR41ZiWZKxbRAcb9LGvA5S8g2b5_Liv4g@mail.gmail.com>
Subject: Re: [PATCH 19/21] vfio: selftests: Expose low-level helper routines
 for setting up struct vfio_pci_device
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 8:04=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> =E5=9C=A8 2025/11/26 11:36, David Matlack =E5=86=99=E9=81=93:
> > @@ -349,9 +351,20 @@ struct vfio_pci_device *__vfio_pci_device_init(con=
st char *bdf,
> >       device->bdf =3D bdf;
> >       device->iommu =3D iommu;
> >
> > +     return device;
> > +}
> > +
>
> In the latest kernel, this part changes too much.

Can you clarify what you mean by "changes too much"? What is the issue?

