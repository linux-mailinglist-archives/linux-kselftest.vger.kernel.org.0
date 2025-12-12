Return-Path: <linux-kselftest+bounces-47465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3691CCB7A46
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2B22300501D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B485228DB46;
	Fri, 12 Dec 2025 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="divnrOzi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769C290DBB
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505503; cv=pass; b=tBRrE5LMwtmYBs6RdPOXB6oxztHJFPfL3fT5pm65mGNFPHb6hgNBm8hIjr6h9A9YAMcg0Lv/7dEInZnMMt9CPkssGqWscXGGaaCH1QEqeydAy2rUrCloc2WmlNDKC1bxeBM+EnHIXhj/0u8YDXNGRB2hAsgGpiZiF5Ih+uTRQy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505503; c=relaxed/simple;
	bh=Ao4814nx/MeyiCjtOPdPxV2RF0Pfv1gFdV6IO+0/tn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5XrIY8lq0RXkn1VYQCJDaJH4IpgQ2YbbL1yjAwqyLG2kSqD/cDylf+LabNMLfGuDZuG49AgHvWqvhOisEX7PW8hCuSru+U51qxhMVg+IA1bjtbFZgjMOPOs+/DZ+6+UXa/eLoV55FmPgTCHFeLI4DtcfmDPXmiP/X84Zjg3qo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=divnrOzi; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso97935e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 18:11:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765505500; cv=none;
        d=google.com; s=arc-20240605;
        b=Kz5wNfazMg2RlzZ/K31kK82/pK63STopi5pS/EyK5m6N5j/zb/WjFlDvdI4dmeRHBd
         2iOWkuufx+lYzS2NzVBnucPp1X0uWkt2KH6G6C7FsqY31DRvAh9DZx459jxAAdWY86fq
         izE58fnBMpvofCS4h4nSn9GamZH2RlNbSPlSEJBpK0fn/2yV/TcBp7Fi7V6TKn/hr8Ri
         QFKIzzM7RXnZC+p5wAIjohHSKiN+jDDUEYLuF5ToMyLi6r6wMfKgauKZSWQ8Mw/3RNLY
         UdALDxmAwvRU9tgRsylUa0MlsIsOXNuWWxngLzMqfN+WgBBLuBWG4ZkmJagRXDLiaQYA
         67pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KKXbQJ7VyOdfJwU2Y+H1IueDoIplm0PygWT6mOen4rY=;
        fh=vyc96Ojw94Tfs4lJCoMKPy/Gs+32ioH9e8DVqz8FwZg=;
        b=k/vQ6t/q58SCjkbHcbr+OkA2COmKfBgN3XJYtko0P07zrV0hHFeXzRigoYzHKyFDvj
         F/f0xQMGuXg78uVQ9dexBQZSuzNami4T3kAOhWcRF/aQRe1nmaVcDA9c++YCawHS6iYg
         Ylhzsw510zl3GQaX5TAMYCOeCzCz2FHhfVDSOo4VBUumYLYCIc/+wFkoOl2jaqUCKT8F
         IaisuGvV0SGjL3B/7jyXTr3ajp52cHT4fCSMl/j1NrFrC6nQCqclDsHHeb9FMxpOGjgh
         4gTH9k38+JMZ3aiBBpuvjf2FiQmpSyMf1q3p5oXr3i+VHTLqpemxxgCWE9Uu0NGvyBJx
         iJPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765505500; x=1766110300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKXbQJ7VyOdfJwU2Y+H1IueDoIplm0PygWT6mOen4rY=;
        b=divnrOziFRtiWda2qrRi+EnQADEWHOiyVoT23OEJJ9Bp9yIIdJ08XSWZ6dIa0silaY
         Haos2vM+ZaXZY47mYO1Fp3k0LSfujevBFFwvpCKx/7C8l3YypmR1TkTZCXpo9+c3XVDb
         Jer1sD09fPf94LndtbBkJdpPPOb+CjT1hrhcHPW4vc46ibzUbvQPgwRJ97C+u2SAqV96
         7zUdvUHmS/jhASWn/TLZ+0v5wPsxcnhgSA8n62Z65eweDGeUAkkDw0h5GJSAl73gFnai
         K7Mkqlb7si9CM+D8OrusRpjJQLH84nf5i7UpnkDDlWCLleDPKyJXrKZ6oztuOKSHKWWB
         PArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505500; x=1766110300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKXbQJ7VyOdfJwU2Y+H1IueDoIplm0PygWT6mOen4rY=;
        b=lmg8yuL/YFs7TnKKmua2wkCrChVIzg/XUa7GLwhFBuQdcqj/PLPCzuWMK5URdji9Sw
         o9OGuNX/mZdWbH3MHQRm0ieBZlzvkSWN5zn3D4tyP0vUYylRxEFvSUaDmxvphhz3EiyB
         n0rQ8UNIWaSJqMxMZJX/cGC1Njc8ArOmPjZrnF8JOubn6Hf26nMvV/vPMG2Fa/ooqT2K
         zDoXAX5libVZUz9YWgqiltc/WuJkbTgbf0uxPTsfX6dPyOHhe8oVKN4985srh4xa4ei4
         MNDoTiRHy2O6Sv8D2wnpaC7n/o6v65f+VDOvh2xTZC9B5hSOsLK8cuHPaY+Kau9tn/E+
         eQJw==
X-Forwarded-Encrypted: i=1; AJvYcCXkCn7dLGS5q+fsbIevJl07VXNGPIguKmg6/b6TrOWYKWdIwhrKyDHS+FbvBrj9eiyWUwo2qKe3uX23PalpA64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gpx2jOD2bkTgm6ZW1rK5zilOWLYP6+WYiPD22Ms6p/29+BjM
	dD4qrDwBAEKqFoSSYUlNO2e5LU5UN+FNwn6DOCNnwppINSaAryWhm7cU8dDld/b7gzgV+JpcgbG
	VsvQeKK+zyh0KCp7YnOBRW03oRNoUK1JPFrumTaxp
X-Gm-Gg: AY/fxX5fCmLaEcigVG5lSqcMhBkP/qJrC0WDAKLM4NMb4qh/RRhjwBHmV9A3FGNPOyi
	ydogzZRepP1F/OkqBC8aG1zNHBHp+/+T4cUH5geHNVtVx363CkmHotfntTjdi4yJUBh7UYZ0Q9S
	K6ps6vUbarZAAiygVVr2Hc/tRWowocVLVluH0pmiQrhRTBt2O6WgeDqTjGoVF+pYhMGk2p6B2mM
	szp/0i7idLGuq91PIH7/OKH04C1k/pzek33NN9GjYvmXgdeavPlfvBeDTohlz5Ohj9FY5I9S7H4
	DsXjprZ+2iFNWiX3xaf0ha0GXuSy
X-Google-Smtp-Source: AGHT+IFYskZ/bgUJL8oh+IWDpPaPCx1TyYrhdztCLLCAnfYuBrsXrdmOgn4LN5g44F9X73hGi18eDted1V3Fai8KP/w=
X-Received: by 2002:a05:600c:c04d:b0:477:95a8:2563 with SMTP id
 5b1f17b1804b1-47a88c67cb0mr445965e9.14.1765505500063; Thu, 11 Dec 2025
 18:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1478ac09-8134-5551-13b6-c7be096262af@redhat.com>
 <CACw3F52i_Yr+8Gd1=H=EMi7NnVJ8WCgMkaG1dSe8FD7PvOsW8w@mail.gmail.com> <86sedgop86.wl-maz@kernel.org>
In-Reply-To: <86sedgop86.wl-maz@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 11 Dec 2025 18:11:28 -0800
X-Gm-Features: AQt7F2ruwRGIX7zw26TKkYRQ458cNr4PLpCMeJupnhA1pZONZUfBkBxbqR-PLiM
Message-ID: <CACw3F51usGLY+ZAqy3WEW+cBxCQysHDuM3ebvC-Adkwf_+zP8Q@mail.gmail.com>
Subject: Re: sea_to_user sefltest failure
To: Marc Zyngier <maz@kernel.org>
Cc: Sebastian Ott <sebott@redhat.com>, Oliver Upton <oupton@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Zenghui Yu <zenghui.yu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 10:19=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Thu, 11 Dec 2025 18:04:48 +0000,
> Jiaqi Yan <jiaqiyan@google.com> wrote:
> >
> > [1  <text/plain; UTF-8 (quoted-printable)>]
> > Hi Sebastian,
> >
> > CONFIGs seem alright to me. Do you boot kernel with cmdline options lik=
e
> > "default_hugepagesz=3D1G hugepagesz=3D1G hugepages=3D64", or dynamicall=
y set up
> > huge pages via "echo 64 >
> > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages"?
>
> I don't think this is irrelevant. The whole thing seems to have some
> logic flaws, see the extensive report from Zenghui[1] as a reply to
> your series.

Perhaps my test is too coupled with my test environment. I will work
with Zhenghui to improve the test for people.

>
>         M.
>
> [1] https://lore.kernel.org/r/3061f5f8-cef0-b7b1-c4de-f2ceea29af9a@huawei=
.com
>
> --
> Without deviation from the norm, progress is not possible.

