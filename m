Return-Path: <linux-kselftest+bounces-40806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04EB446BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 21:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C99E1BC865B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE76276057;
	Thu,  4 Sep 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU1xd9A/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FB31E7C03
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015459; cv=none; b=uBnIVOht7+Vq1Zzy/BriyEF5P2Sh1ebQrg1IUP0nbLsI7FXDyqAXpvafysQe8KC8BWAllSX92+yC8Up4SLboLOikihx7eZA/14PepIcmgMC32dxC2EQFYiHgTCoFUpX/XNxrJuQXGyPmu63ur9fWLeN3a3EbnAMWjbXJeA/i4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015459; c=relaxed/simple;
	bh=y/BbCZOfutrrGdIEhnUdoJS38e3K8+RsUZAJr/I/qpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbZBtTSeoz0VpKxhopQmbwg2AcNG4SmLQ0AMY7IWGpk6zZ2B7q6XUgZQvDtTIHY2oLczOD4U8tgRssBw/AQa37N41sxppAeN1HngQ0Hx6A1qsfpL4ymWLTZiAZdjGJRxkZpXy5aJ270H2NhDQ/ON5TG1zt/gCAXstjiWGiWIMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU1xd9A/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-560885b40e2so2384e87.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Sep 2025 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757015456; x=1757620256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3eHPEufl9xUtgWD3aqAgCiDundMmJHck6jY2E0vTjQ=;
        b=UU1xd9A/T1WZWgzvK4d+Fip71c4GQu7kKDBPeTGZhIct2fEV1DlaX0atkEu37YoMqs
         kGRY//IHK485odl9w7YzByqSziFbVjqIONeOR42S0vbyacIGLY0JKNN9KjGMC+vjJNAK
         /Jr2h2eSFHozHzXsqyxlu++SMMQKtmOD2LiZAJxe7zW1ZMrtCze8/ULVIQv01Qyu6rPh
         YMerxr9L0u+DTUiSqROFik1tGTGqQyo46ej56y8Y3lIwu6yKQdPGXsNluZ5NpFnR3B64
         Vc4gLJEtbjQTTZDWLk18Otd2Z8JS9uO5ooK3UYptcsWp0f153GCr8JL+nGoPlKIGiKLI
         4V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015456; x=1757620256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3eHPEufl9xUtgWD3aqAgCiDundMmJHck6jY2E0vTjQ=;
        b=wrR/AyH8VLsDqGVHyQiEdug1sgEg1RhNuptH9NLddjQwhrduCkV1vrt4eAjAs6gMCt
         C0ewBc0JojkymFpbMUeoH3VKpmDqhAdA5XTE9WJpnj7MXhPowqkfE5KWrhscp0j0YfVH
         Y2Rcx+/PTXY5OglP4hOME3fQZ3skSimwurjQWiENOwoXUJamPvEkrMl5iex7e9tOr20l
         3iWCEPHAn7id1cc3xvXGrw1EhRNLLpeQuNc6DgTxt7/Eigsi4EC9xVaZCb0ldDCejC5o
         o1/Iq4wPb5LtRfEUl4PruWRs/BDQ6AAw+EwHq0fVDN9feLSahF+XN0HaRN2ZP8CNySCW
         l08g==
X-Forwarded-Encrypted: i=1; AJvYcCVxjMnjigXxLesJkDVklQPbK5oUfM3JzHOS7XFsIbrAqAkhbQB7Y4mRZWLWBqseavto5CWtYL8j6ikrbOVRsrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAQX13uuhK0wd0emRN3czqV8Gr1uoDHdJGCMeXtEeJG4DTySz
	pJnPLx77YkurnMWiL+ltsfoRbUeS0dFUqhkROXxbTOuTA3CphLiNangbF8YY1JIOPKXa34TQqCf
	VSCA/MYr9/3IXP9KpDjalGw4uZc4Dm2AaZW57+aQD
X-Gm-Gg: ASbGncsznvm7vXYYLx43rcpv32ZNBD/ntm2BQlEQySSilS+bxv8VrpZftYzLxc+Ndtk
	BceTqdBkOsaLUWdHXALUsA6iDyki5KOFJvcydX80mbr/emkO1ZonAGcx+e4CIW5JfXNxPbWKld9
	l6K3Ow0AhxnfQIsYVP1bCgXaQbtATszYhqqkAzP3DUFncQJx3jmmjKPPGyeOjcVXGptPJBK8/bA
	x+w8XDJ5dMA3ZMYhZ0KyJOmU3CIjIC5RllNLmhcpA==
X-Google-Smtp-Source: AGHT+IGAlYfo5wIBw3AY98IGAb3xSMB0Z+//3d+kFVon2XgHollfD4NDHAER8NA7szkq38D/pq1qQ3gl/Y+Zfpl4qFk=
X-Received: by 2002:a05:6512:114b:b0:55f:68fe:76d4 with SMTP id
 2adb3069b0e04-560dea6b1bbmr50021e87.5.1757015455655; Thu, 04 Sep 2025
 12:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904182710.1586473-1-sdf@fomichev.me>
In-Reply-To: <20250904182710.1586473-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 4 Sep 2025 12:50:42 -0700
X-Gm-Features: Ac12FXwcU_yEonQJHBSkDIvESK_yJi9xHlVf4i2Knv57VrlclcFjGd0j6CV8QsE
Message-ID: <CAHS8izOSq+mYmP58eNqC5WFTvXxh+s8gRSrTv6YQdq6jn41pMw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org, 
	joe@dama.to, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:27=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> devmem test fails on NIPA. Most likely we get skb(s) with readable
> frags (why?)

I would expect if we get readable frags that the frags land in the
host buffer we provide ncdevmem and we actually hit this error:

```
  1                 if (!is_devmem) {
  0                         pr_err("flow steering error");
  1                         goto err_close_client;
  2                 }
```

which as it says, should be root caused in a flow steering error. I
don't know what would cause an EFAULT off the top of my head.

> but the failure manifests as an OOM. The OOM happens
> because ncdevmem spams the following message:
>
>   recvmsg ret=3D-1
>   recvmsg: Bad address
>
> As of today, ncdevmem can't deal with various reasons of EFAULT:
> - falling back to regular recvmsg for non-devmem skbs
> - increasing ctrl_data size (can't happen with ncdevmem's large buffer)
>
> Exit (cleanly) with error when recvmsg returns EFAULT. This should at
> least cause the test to cleanup its state.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Either way, change looks good to me.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

