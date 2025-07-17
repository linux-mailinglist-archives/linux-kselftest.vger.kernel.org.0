Return-Path: <linux-kselftest+bounces-37508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9C0B09052
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9881217CDB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423F1E379B;
	Thu, 17 Jul 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="ZqIrr+PF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720051DC9B5
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765323; cv=none; b=bLZ/hMyZZyNnq0GHVCms2KIpR47ossBB/6v2dJuAgI5VZPPf0FYGqLtsTzOjA8v1Yf8+xwQRPuqMYzWERoLA/1JP+cqfSqTOOEzUWoPKN01NVEPizQS2DY8WyBFw9/kfCX8M9syNEg0v8iYG7iCr8cH7kb5nTy2ff6sWg/jVESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765323; c=relaxed/simple;
	bh=uYKefjG3jk2C3YLsqcotNnT24i2I/xBuxxVY0arOB/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1BoIHOR6EPu72lqcx+otZW33Q1cSWgpCgKxD/46B9p6jYVV+3S6E5YHBAqjEOLaevLhRhOetRXOVfMSSJzIHYWmaJqp+ldnEsKl6gTWMi/1g07DOakxokbqAdVkILViatVzDYtnNfNR2FC9kTiRPwLZjLfHVt9QZQRTSi5uRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=ZqIrr+PF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b45edf2303so962634f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1752765320; x=1753370120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJMJTA83WH07DjPioIXnI5GHGg29vRTdXy8ees4Pv1s=;
        b=ZqIrr+PFzKN31PldRkheEEhTCXz8PcjQzVlwEyUr/+8PivtPDSYctC1thKgNJblxq9
         J2i8Vgj50Qtwt3QRCYofwIwJRSnD3D1U+N+GdjYzbB8ETmDaPhDEr0oEkq96zPYyD351
         tjerzJTLpt8UfKW5vM5VJliwEqD1A1+7whs54ls/0SjwnG1u1E1uJk7bjfwV2Pc6Y5Hg
         9POPNXfNb3z/okBUA3TgZ3N+wSQaqy4l4jpDAzhywpwbNjLltVN/nclpM9EPmyjZ1N8f
         LJIdrihd9B8sUTm4LuP86p2jS/IPOwXK/2Vr/+PpH/tcu0DGJOBLCbgW6/4+yVWBpDdY
         JlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765320; x=1753370120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJMJTA83WH07DjPioIXnI5GHGg29vRTdXy8ees4Pv1s=;
        b=uFARLkcO42GQgPbdg1kbHTu3shsY8QlcbXiHhe0hcBpjUP1keURYE1grcXzc1cnnzu
         ZaLSrJvGH4sKxzoel1M+zYDEN9b5LArCj0AtPslCx76jr9LmMw7/86+KA0t1qBOGYpbM
         8tvQ6IBFTD6s4d7zH9OZOjsa4z46xKsDRbrc4Pm+iKe6Fy6uo/OifGwfJdQm5bKFKR/I
         1HtogC1Plu4WA7UznSBFAYMIPEOzjUMGc0DsWvKbEw/pfizktntrwkPAdrNntRpRBIJb
         zFDK6gscEnt/l6pvIcwDKu9kOjjlkiVjXlp7KD4rBCia9Wmv7p2Ywq485QuMzdhpbKc+
         Itcg==
X-Forwarded-Encrypted: i=1; AJvYcCWeZ+0orxh0/2Tv3fRVyqT/3FMMz97WNr413KLPDKkDOHwt8VVBTpO8dMdFNnsyVYnI7GzNBya6bFM6534I3a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5CFfhNikI7KjYwgJuS1FknQ2nfyT84alSKDNBugjnOeYucHS
	Xtdh/JM6KRydDIxEZQGHqFgokcaRDZrvRmmFBBFAI5VUDwVF+Yca+yp/kV8IEy4YVJrONX68HFp
	2F2OWA42A+IN7emLsiHV2kyhMuO0TeCRvvySDDOqTCA==
X-Gm-Gg: ASbGncvJEjRqvJ7E2gBZGNsjqQT7K54ht4Feqh/eC49Gev9qy21zWv/nGRbmIUejI9x
	SP+BMN7z0H4KRAp8G/E6KtmS2k6Yyz8mMF98PQdcw6cNEc5peS09QwJD9m5JGs+2wbMclB+oVNx
	RCQ7FbKOJpSUBDQg19FYxwAQ07G47xiQJTZb6Gb/OOkMUZBjjmTZmzV84u+6AtLNEgeMj+gRK8b
	dQRIw==
X-Google-Smtp-Source: AGHT+IH3RQURYv6RUsyjhfCjPnbq76Yt1tIeE/r4l/zRFxghwDcy4thWAtjf1Qmjm4sX2AEpW3WUl8KV2Dpd0p1Xyr0=
X-Received: by 2002:a05:6000:658:b0:3a4:eeb5:58c0 with SMTP id
 ffacd0b85a97d-3b60dd4f752mr7612559f8f.20.1752765319635; Thu, 17 Jul 2025
 08:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
 <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com> <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com>
In-Reply-To: <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 17 Jul 2025 16:15:07 +0100
X-Gm-Features: Ac12FXx5_43sdjKCTtLw8gtm46jTfSh3joljtt9boX2xFAkNZRIJX-9H7H7z2co
Message-ID: <CAN+4W8i+PqYDcJjWk+g63W4kdKvhFKSad61q-T=JJky5m7j79w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> __pa_symbol() should work for start_BTF, but would be good
> to double check with Ard that the rest stays linear.

Alexei,

This code in the arm64 setup does make me think we'll be OK.

kernel_code.start   =3D __pa_symbol(_stext);
kernel_code.end     =3D __pa_symbol(__init_begin - 1);
kernel_data.start   =3D __pa_symbol(_sdata);
kernel_data.end     =3D __pa_symbol(_end - 1);

Using these as start and end only makes sense to me if the addresses
are linear? See
https://elixir.bootlin.com/linux/v6.15.6/source/arch/arm64/kernel/setup.c#L=
217

Let me know if you want me to double check with Ard regardless.

Best
Lorenz

