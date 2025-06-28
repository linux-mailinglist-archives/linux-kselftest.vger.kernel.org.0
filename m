Return-Path: <linux-kselftest+bounces-36028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C9AEC586
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 09:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887E03A4B16
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1D4220F58;
	Sat, 28 Jun 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQbSvLnH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6649219A8E;
	Sat, 28 Jun 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751095098; cv=none; b=R68m5/A7UogKKE+eMS1eAbe9qXPElJBK7udmDJ1UlG3TUUkeU5XTtkBBkBQnxzyButVzVVqkcpDppwedKSHHvIWOIpaEdJ0nuvDRFkdZKn0Ez8w9o/oc54hiHOivVldPbJGHythFaKAxpfIofEPiFZjW7QpJ7ERQNGNbebMCDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751095098; c=relaxed/simple;
	bh=0febcdAcwynBf2IwlKyQYt1dntOoEkTW1nH+f8APtlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xy9JlWs5doWNtWBpJAslhhwl39zAHNMo5/3y4hunh3gTLPan1z052/KQw2Tfiam08USBuCoktPJ705i2aiS8F9KhE+0TgWqDO5TzuxeHR4wBAq21mmXP/a1fLxMY6wPlciUwWx76kW9jC5MUNt9JrPb++TB9EFZtp0CcoqSHXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQbSvLnH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31305ee3281so389541a91.0;
        Sat, 28 Jun 2025 00:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751095096; x=1751699896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0febcdAcwynBf2IwlKyQYt1dntOoEkTW1nH+f8APtlU=;
        b=GQbSvLnHW0lb6DNbTMrwYvLwoTztamHbCxRCxmEzn4H96ANNUloQTVDE2QRkJEKIon
         PqXpdW24mY43WD8w6ucY6WG54J0IX/lmfOhUdAxmpn69bG/NefXu2lyKuvDTyL+Y3XZT
         SoO4udDTIo8TYA/6Tyl5NIB64FF+h9wiP2iuQf/KTwkmczc3JAz1fYKWdvtdK3QFlw5m
         Ysg4bOEqVybyz8JobF+MeaO1da6WOdYhI/AMq/4xh87PtB8sOyLC5v4Kap0+Vvicvls8
         t1VsGTTzqMsJFupyHsgI6GyEKyRjx6POBuSQfTHAVJHWZX3UkL3x2DRXYOYag7ORQOIJ
         abag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751095096; x=1751699896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0febcdAcwynBf2IwlKyQYt1dntOoEkTW1nH+f8APtlU=;
        b=mF5oFRkxoxlOJa7iesidKDvaEB+F+vMTfMO8aU76IukvINHiFi04JL0sWE3iiV71Dw
         QIJo9cvT+vrOZCGaQ3m1h5UNkkJtCRhOW6E2F3DIAz7q1r/FJiHnRBAVDGvx/TmjtfEF
         erGHyz33OJABcsRKgLZZ4DsgpPDIgs7fqkyG5QSv506vihwCdeSTL/l5DIL0TbaEyBfP
         fPOo9a4yT/9ftW7usBMS8EEryC6ofaf9J/KpSM6N4PlfNi/x6yfyHH8KEVG+NeAZy3fl
         aQwS6Tc0/4QhD/kKgX3nzS9H7Jw8wNxiQHEIfwFllRYitc2/KA0ak/9kgOdNxbGinEdp
         nyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk71rcoJQYn/l1itkse1Itsi/1L6461yOghjh+BZRSifLBswzQptgWldkkNhgW7MEjSArhTAoB2fEDzn7+dSkR@vger.kernel.org, AJvYcCUzowaKN7mjGGVdOfi2ABYAdEC9KcBuOGrqPAFjKfZcJF8snIFLgDqateN6GeivefnNFPyYV8biMCc=@vger.kernel.org, AJvYcCWVBNqUxXiOAwQwrDklXwL5AkfSIyL8Xmz5EIHJrP4Zeukg5rYqqc6iF3BD3BCleqkV7p7Tyr6N48XZOcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypUi3gtYAaKzdXZy0TeKAqVnxpuubhadLvCn7aLcfHiifnupU8
	Nze0Pc2fe1R5FvqVgfFxAIcko55we+OQ2QVUAO4uR5TB5IijDcdSs3JhhyXhkP2/HIxs0q0fCJW
	xbPpvzoVt6xwcfzlMUsyau6tzIXRVphI=
X-Gm-Gg: ASbGncuV5uk35Ij85yTIcMAFp9/GNZFObdHFYONfrRAD+De7dhuq5CF9D3VQ/40LnPL
	IPue+paEv2Otmq9GCrHt1iQZia9Wun1e7JX7c7ZC6VSN2MFJDTBCsPkjM/yUKOGWe0mZAQMSQ0l
	wuTaDfN3T+MDd4wOpLs1NFQ7QTsSkj6PAZ1ysXyvE3DBRwpfz61NItCw==
X-Google-Smtp-Source: AGHT+IH5LaSkNoggDQYpXdHzsHorCHB3OugN2pInV692ztgRKLp8l9wMjej6EUufsoKeOpCk3LBfANKPFwm6lZJXh84=
X-Received: by 2002:a17:90b:51cc:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-318ec43c0d0mr1085996a91.5.1751095096142; Sat, 28 Jun 2025
 00:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627065320.9315-1-work@onurozkan.dev> <CANiq72mMEEdP1ZG2brhLWgjaQpnwG+Mcxm43B0hAvZuaq-=jBA@mail.gmail.com>
 <20250628070345.5499a7bf@nimda.home>
In-Reply-To: <20250628070345.5499a7bf@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Jun 2025 09:18:04 +0200
X-Gm-Features: Ac12FXxNJGj7oMRLRluBODeSjNbnYZFjQxJFGCReld2J8lk997KNAcKWnEbxQ_o
Message-ID: <CANiq72m=gU-SNcCB6YY0riUsdr+p4Nd6As=vuxpQk4A32RZeAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] replace `allow(...)` lints with `expect(...)`
To: Onur <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, airlied@gmail.com, simona@ffwll.ch, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rafael@kernel.org, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 6:03=E2=80=AFAM Onur <work@onurozkan.dev> wrote:
>
> I already tried that but it didn't helped. I was able to make it work
> with manually hacking the `init/Kconfig` file.

That should not be needed -- the `/` command should tell you what you
are missing.

Cheers,
Miguel

