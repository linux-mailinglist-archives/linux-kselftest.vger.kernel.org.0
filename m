Return-Path: <linux-kselftest+bounces-25071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6EA1AFBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 06:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F9016D63C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 05:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6901D7999;
	Fri, 24 Jan 2025 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgwUZUwC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A8155759;
	Fri, 24 Jan 2025 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737695658; cv=none; b=J34hCNn8GsJcjLyMKZC+x5Q7Rsa6cuXfxdqtnPj9A9Y6nxMKnkwgztvnfOFcZP+HIlvA9iMiMdwJWWbnfg0VFHF0iW+G06Gj52DsSSBbhPabmsHF3b5uzhLsyqHo5xcT+thZjTgMGKpy1SUR27Cz0MucffinorSeTKPTzu0d4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737695658; c=relaxed/simple;
	bh=1iHB2RMbkiM1ZKPiAR2chCSHhw/1N8h3lgL5DnTbYIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiW20oDY6I0cUjVq4B4gy3II+fBknMJvNN1Kj95kmEj+wn4UwelAXa5eLQolMFprdY0CmcAG8bsH+HijYwfRGEh6WTCFRgmuCu0G23jrpkGBJksCTB5RbODVTI/nXesNVJjARCXdBoVuuUdgj++Cy9VS9x4yr/+Geb+HLuvX9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgwUZUwC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4368a293339so18703355e9.3;
        Thu, 23 Jan 2025 21:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737695655; x=1738300455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iHB2RMbkiM1ZKPiAR2chCSHhw/1N8h3lgL5DnTbYIc=;
        b=PgwUZUwCmLuUhyu5RZP23rRrd6lKyTV48zq9r342Fyc4G3J1p4H2lO5AxF3lvQa7Gk
         osoKMkjzfDuCn03mtCrKoP2XmiEDmCBADSVPOG36g2S6G43kgI8gl8bddgspNc4cSpsw
         uGxjcsA+ApMzYj3acEC80sdJ0yzzUPfUjIgvqrp96oZMdJ7b7plZQb4pNsjCrn965JR8
         ZlOHPDVT2EiqwmdJUClY2tyWByrHzro/UG3kPRCLP7//UiIJjBXmmd+RMsLi74cVMZzf
         t/QC/Y+YFM4uTnTZR6Cu0j9ij6m7cHqtzsUaqzQIRPMOD9fPIDWT2nIs5DJqrpSDC8fu
         XLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737695655; x=1738300455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iHB2RMbkiM1ZKPiAR2chCSHhw/1N8h3lgL5DnTbYIc=;
        b=kIHD7EsZsH+1r5khz8rHpV+agGPUjJFLFIy1UyP+6wPy1LQssEgmKh7fOq8nkiOv9d
         o+ybvZ6/c1W7wEPRtUEKt6p5e7Mlw/etixGqwNxQDTDUNvZjGgVRVX5WUhoo02dyjAwr
         fffkdQZ/K6q5vnr0O2XLKMwUEUi56KIrk852MJj0Abv6GEvaMZVLHrXE7mxH8lRnfUcJ
         2qUzztvSmlyVJnfL4WhRTrqJI53wmWvZHBqbYs06zVpn4tYPKR+DMfduBxrubyR8qTe3
         iduw4pJGCTiNeh9rCrkQn21YqFrAyV4/avvFLU5FDsnt4Eu4gACrWFyaivlgDmYmiSCo
         ZlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfRopuOXfUdG4ITDeGOFpufd9iSOIKlsz2c8HW6mesfxz6CPuHLxG8P/1OAh+8Yp03u+D15XLn@vger.kernel.org, AJvYcCWdjOrfYYsp9dwqizxOTKQczfLmMrGeueiUJhe1GMy4RrFUloSSnIwbvIt59DiNRhU1LhgT6DHn96RdzNQ=@vger.kernel.org, AJvYcCXzWklTQ+yfXnfB867wXGbXFrD9YRcy5ueOHpp9bo+YXldbxAnX9F+ykZ0vBKWNQSdRQA4YhgBPSviFkFlfiihx@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfFbsjY1NYMAMzaIDb+U+9qVeYNsJXgl5QGHW2r5gT0IZKSuT
	gaPvPXng85otO1ZUrNo+wKBAwyR7yIFxbPXJh0bDLsAex3n6n4shhT+61JJ4D5z7VX/VCh+vG5q
	4WeRu+/2nbuRRn0DKcMozA8RpNlY=
X-Gm-Gg: ASbGncs+sC05zKevBywsjTZlHM3gSO9Bn2UdHAxUPRdSlD7d0FJ2ltiMd2iO/H1y5T5
	tOmZi2gikIJNxPo0L3s8AihAFtU3YgoYGeYfoNV8Rvmw2U9riXIIZxKg/dO1052zwSiufyncu6Z
	Fp0K9d2rluyuWNv9U72Q==
X-Google-Smtp-Source: AGHT+IGKqUWxI37W+QASCGhJIn/tj/hEXFdJ7Xi81uBkm9HW/mY8sOJIghyv5lNNFus5ZOXpryd52UYtxZt9cxVxc1Y=
X-Received: by 2002:a05:6000:1449:b0:386:3825:2c3b with SMTP id
 ffacd0b85a97d-38bf5663880mr26622584f8f.18.1737695654834; Thu, 23 Jan 2025
 21:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122183720.1411176-1-skb99@linux.ibm.com>
In-Reply-To: <20250122183720.1411176-1-skb99@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Jan 2025 21:14:04 -0800
X-Gm-Features: AWEUYZlg-44KfCUU4IxkEVk22ELBcFVz62GkQBrzb_dtdVb57gHVqXlpNmRgMG4
Message-ID: <CAADnVQJcmyMmxPfSaKgqMiCDZP=Pe8-Jf7NnEdfgxejvZr+44g@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix mix-up of 4096 and page size.
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 10:38=E2=80=AFAM Saket Kumar Bhaskar
<skb99@linux.ibm.com> wrote:
>
> For platforms on powerpc architecture with a default page size greater
> than 4096, there was an inconsistency in fragment size calculation.
> This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
> to fail on powerpc.
>
> The issue occurred because the fragment buffer size in
> bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
> the fragment within the shared skb was checked against PAGE_SIZE
> (65536 on powerpc) in min_t, causing it to exceed 4096 and be set
> accordingly. This discrepancy led to an overflow when
> bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag=
)
> could be greater than rxq->frag_size (when PAGE_SIZE > 4096).
>
> This commit updates the page size references to 4096 to ensure consistenc=
y
> and prevent overflow issues in fragment size calculations.

This isn't right. Please fix the selftest instead.

pw-bot: cr

