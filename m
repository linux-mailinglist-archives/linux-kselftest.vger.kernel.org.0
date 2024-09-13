Return-Path: <linux-kselftest+bounces-17919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3A97776F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 05:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434E11F21E8F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 03:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122121B12F5;
	Fri, 13 Sep 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9qbmf7V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875588827;
	Fri, 13 Sep 2024 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198914; cv=none; b=Z29h1ZwCIt9JV/OT1GuMsUQqdUdHPmR6DpubAFxY6df/6J0d6dJ6s+O0FA7v2/knMCYijUsWUVZ/P6lDxCSnFvrvYxZXUevJMpw/+R1CzBX9zlCKykrbOpB47r1a9paT1u+LHIEeocahZAATpwizarb8e6r2dWfyMFZwXi6rd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198914; c=relaxed/simple;
	bh=WiG+fM+7N9Q40JfTc9raIwTA9+J99+5kuXFj+tWJcxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yus5JDmE0Rh+u2k5oWdhpazE77In3LlymjI98XD+eAFkOF2/yUkvDQhKWVBtWqUYS0VjFTs6mfNpa55RgxzgsLaYWLYOcwsqXt+ztN7K5dJURjStuOqMpLTzjFxVt8AkhMOMed7MFjYjt2Vja3MbDLztcfgTzztII056dKCheE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9qbmf7V; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e04801bb65so230510b6e.0;
        Thu, 12 Sep 2024 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726198911; x=1726803711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiG+fM+7N9Q40JfTc9raIwTA9+J99+5kuXFj+tWJcxo=;
        b=J9qbmf7VqLdUqE6aFJEeSQpw0yTHFLfB+E1LyS40l5DuWdn4kp+9J5CYSU/nMCCYyE
         rZaxU3h1lk9l8lh1q6bQX18MVm9XYtdQ84Ee4QSRJtVowkt6ShxTlmsGsonmZw4EsfqQ
         MlcGSXam8KrcSRBo43jMN71D4HMjT/2TDNoIK0HZa2bmyKvjuLIfhpaGTgBgbCl2nOJy
         A8PBX9UMnwpDvleHonXD7BBE2LHixTvmpODqsHNz7rCieuTbh1rMZ20Xfov/X87DjSns
         sEZ1B9/s+TRHoB4IPhNUTOSn1lbHbPiU9r6twdNYx2PwW2qS6OfnL8+XEIajl6IrJUz2
         amdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726198911; x=1726803711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiG+fM+7N9Q40JfTc9raIwTA9+J99+5kuXFj+tWJcxo=;
        b=rISF7FWNK9jZ+fZwti1ept/KCPbU98R7ec01hPMGFaW+zKwakG0HYmhGf480djx752
         KmgOPpv9mGPAcfUAZDiYUAhAd63XxFl/0mjfMMxMewJJyP3whRbHAPyaRGFyksOzIxU6
         NGGfYpdfjsXRxKdjRoo3ntXkktLIUGSb2F5jAIKxzkuhojepkC4tl3Td7eBB65tqJgUF
         Eux3CyX2J/SYQd+7y05R+2/4NBvKpC5A4tp9FbeeL0AcX9oNX2vV1s6j6lisqY0Wa0wa
         VOXGQY9sxKclKAaGKdahzFuwgBp5eCPiACj4t6z1wTJzLchDcQHZpFWhmxvOg1QgnCjD
         N5jA==
X-Forwarded-Encrypted: i=1; AJvYcCXqgCJ8gcB0N6qe4Y3hZ34edUUq1CtdgCMhVqc7fzzeGVen4m2HpkipvN06QJUM7NdKTiuTCr1RQfkU6dB3ItVd@vger.kernel.org, AJvYcCXye9/nouwswlb4g2G0kOZFkpMgvdAXxYutoBh5nTdMu/zM5bot+JoE6+Ih4oR5uZNS6AkwJupvfi41C80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUkY7Y//E/pyQtPleXlC3ieynzc/c7gfrEy4X9MYgk+AkP5jQ
	YnR3zfyqrQ0oxbmPjD2Y8MeeJ+x6XJiOiSdS0Kdj2+Q4RHb61vCGVONcqv6imKdEG6C+lBcwnCP
	3J9Zf3wU8WMM+lUv6MwIKLYSKoo8=
X-Google-Smtp-Source: AGHT+IFapc1fMjHxFBGJ0qkUtd+XJG4w0zAhtt6ixANanpzleOSJATkFV4GdeXlL/n6mICeMMpYCQrQW1V9fRfCBD5k=
X-Received: by 2002:a05:6808:192a:b0:3e0:45ea:7fbe with SMTP id
 5614622812f47-3e07a1103c3mr858054b6e.13.1726198911381; Thu, 12 Sep 2024
 20:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
 <20240913022635.751505-2-zhangchunyan@iscas.ac.cn> <ZuOv55YsorfvhlQi@ghost>
In-Reply-To: <ZuOv55YsorfvhlQi@ghost>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 13 Sep 2024 11:41:15 +0800
Message-ID: <CAAfSe-vQCG=RRGwxEEWR-HE5LGH4XniMWi=nTzOOQMrW_fvRUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/mm: skip virtual_address_range tests on riscv
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Charlie,

On Fri, 13 Sept 2024 at 11:22, Charlie Jenkins <charlie@rivosinc.com> wrote:
>
> On Fri, Sep 13, 2024 at 10:26:35AM +0800, Chunyan Zhang wrote:
> > RISC-V doesn't currently have the behavior of restricting the virtual
> > address space which virtual_address_range tests check, this will
> > cause the tests fail. So lets disable the whole test suite for riscv64
> > for now, not build it and run_vmtests.sh will skip it if it is not present.
> >
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
>
> Which tree does this apply onto? It is failing to apply on -rc7. Also,

Oh, it applies to -rc1.

> since this is the second version of this patch it is good practice to
> put v2 in the subject like [PATCH v2 2/2]. Anyways, the content of this
> patch looks good!
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Thanks,
Chunyan

