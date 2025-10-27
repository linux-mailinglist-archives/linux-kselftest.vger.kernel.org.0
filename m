Return-Path: <linux-kselftest+bounces-44144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F61C11B1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F337A4E1D8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19533320382;
	Mon, 27 Oct 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kToQRqn+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E952BEFE1
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604177; cv=none; b=s+9oWi6/9n8hAkSjMNYSobLImjkEwirCTvoi4UJRDVQeSEBqxjGYEBrMUJ1B3sKEV8qbzTgr9sQGlXsBdBik9HrE+NEob/hoJfI4ati4o6hlwv2Rbt+OqopvCsva46jnPfMxiJBwCBP5VUvaMVJO8++JL9EP4/DuiT2p1J4J2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604177; c=relaxed/simple;
	bh=qCctqqmuCWipVL8GughzbbRKWgiygHwz0qUsY2oTFoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1bI+k+pDhxo94LQk1v619d8z4dH8oVo3Cm3cMO5Q01eepX+n4KjNY3xZgta+vHwT3AeK8qahFuSdtNhLRd1nwhUHqZTtf6pK1JJOiHjd+mHfAP8dZv6zAW1fn4QYAGUxyBd//l2QRS300qqK1Oy4QKm38TZdB6yFmNu27BL8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kToQRqn+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-592f3630b69so6301444e87.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761604174; x=1762208974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8OllJa5cnTv18Hb5rtu0WqFYbEpD7McBb4G8sNHUxU=;
        b=kToQRqn+PEEG+R3IvfTjjIqd+nquti/ZSLKp6Dc04aL3KGtosM4af0ue6FMMOto/Js
         +PMUAAoSr6Bj4fKGKFJvPSHRnP5tUK5nAFtpPy6bueLjxPZD6eFRsEPevhLFaLBh/ogU
         RTB4u9aVdraOaHrZ0mDq3Xf11ixRa1/Y/gv4Ot/892rUflWLYJueKJO63fjpeuxxcG1c
         6TT6ia9cXfDDps3HplQm/aj3Pk2RzNVMhF/Ewy7pb4rOQx22BJFTGVovLRg+0+T/k+/s
         3SDVNIDwbonnN53SylI6rEc/zQDeHGzIJk5mkJjd86GZ18eBfbCDwbwDKW28WsxlmhmJ
         xhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604174; x=1762208974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8OllJa5cnTv18Hb5rtu0WqFYbEpD7McBb4G8sNHUxU=;
        b=uSPbq6pULrImj3TPkKZFPeZAVcaMx2OkYPYz6KbLi0vce28u7xxVj/4dYngwEAkXag
         FkWjlLOvACDXFrjLuW9QK+6GM2jEWtktXeaFIhbKIVPXDTTPWYIQDNEkCjj5mZoYvqny
         MivrMJBgeNrBDB672feVHJ2uiYTPLYV47nfuoWgyU547keBpTOOite7acW8dF/d8/o74
         IrDJFab+KzKFVuhn12JBwnxPJgU2xDehK+0IV/51NkBfwZGf1FXdOrwkVeP+7dd6U8Jd
         izGMsT3xZW2ryGIWusfai7Hk0M+kGp+i8olu8bc3h4UCDZosCRZAIEQrZtKATw7MIqWZ
         CvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Uc6SQJXYqB1x6+bf4/fWuagpCIHtORj6Pt1kucy5zyM076fMZuzKVRTrlvz/GaRGRc9iUMeIMYSNpn08oYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz3bMfkyWir0OtO6CL79FN80+XrRIFYnKJ9vEcBzIR2Wrjl29y
	Wr8xY3WS4i32wHtMQKV5FcF/PI3qKAjebfVvlKGbBPNPoesAbOEb8zF4TqBLe7Xlx149wq9aHcJ
	NcS1FSs6skMhoWtODNf7a8HDw36jZVCOH4Co8tfUl
X-Gm-Gg: ASbGncv2BeAEmu6Cc2OzFF/IgUTdWkwyIteIJ4VESRZn6p7M4Q3JR1aD6FX9YqMmziw
	nTtwoO3QfnRoSPX/uTNRQBoB0x0Jzq6HXSmhiApBxTyhRPz9SPMV6bAR704TSRP7UPNxMV9e0bb
	K8PBP5msP8/1XS6XrXJxTtczImkod9BxuSQFVw7Zxndqv2NDyiA+2i2rNgvn6Pst8J/4BN4yf7j
	eVwi+6RtbqSEroIrUG7F6gJqzeY2zbN/7DOFhsPKxAdV0JU3ZY0NsDPX5MLxek29cHdgyA=
X-Google-Smtp-Source: AGHT+IG3oQ1hLD3e0hS3PRFF5ObbhSTcrKhhLRIEURqvM4Ky9aK8pSzbBQH6dOSSLG+Z8K1fnWad+2c0m7IK5ji+AAc=
X-Received: by 2002:a2e:9a0b:0:b0:376:49b1:7909 with SMTP id
 38308e7fff4ca-379077694a9mr3618351fa.49.1761604173336; Mon, 27 Oct 2025
 15:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <20251021000852.2924827-2-pasha.tatashin@soleen.com>
In-Reply-To: <20251021000852.2924827-2-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 15:29:05 -0700
X-Gm-Features: AWmQ_blnDmlMSHWHiBFbsh6uAwbzzxnGfxP2Tc8ntIAjm82iRY3rUDbemvTKIT8
Message-ID: <CALzav=egQiF6tanYxR9Tow7TnT_UK9bNAR_4DQ2P=2EJ+H4ZJA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:08=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> It is invalid for KHO metadata or preserved memory regions to be located
> within the KHO scratch area, as this area is overwritten when the next
> kernel is loaded, and used early in boot by the next kernel. This can
> lead to memory corruption.
>
> Adds checks to kho_preserve_* and KHO's internal metadata allocators
> (xa_load_or_alloc, new_chunk) to verify that the physical address of the
> memory does not overlap with any defined scratch region. If an overlap
> is detected, the operation will fail and a WARN_ON is triggered. To
> avoid performance overhead in production kernels, these checks are
> enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.

How many scratch regions are there in practice? Checking
unconditionally seems like a small price to pay to avoid possible
memory corruption. Especially since most KHO preservation should
happen while the VM is still running (so does not have to by
hyper-optimized).

>  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, si=
ze_t sz)
>  {
> -       void *elm, *res;
> +       void *res =3D xa_load(xa, index);
>
> -       elm =3D xa_load(xa, index);
> -       if (elm)
> -               return elm;
> +       if (res)
> +               return res;
> +
> +       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);

nit: This breaks the local style of always declaring variables at the
beginning of blocks.

