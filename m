Return-Path: <linux-kselftest+bounces-29814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CFBA716DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 13:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1E97A55AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4EF1E1E14;
	Wed, 26 Mar 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmYzKXr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED87A57C9F;
	Wed, 26 Mar 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742993032; cv=none; b=o/ZINRN6SUFtMWo4zGbbEKcUJzzLHsbOKVXxZDXexfqESUXZ+72mIZhfjreVXi9psgB8u0NzHlLi4jwnxvtMul0qwZCMd+k80LJCTniSfF7/i08ZL3Tlu3XqYtLS2tjKcft/A0nCoWTFlrLJM29PF1oCmDIWnhLyrF9n/BtDxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742993032; c=relaxed/simple;
	bh=y/fk5fKjjzL4ukQRptQc3n83PShLp3cHuHqSoFsaP7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=at3F4UczDI2ChzUVdBUuPgrTpmQhEdJmCESaAswAIqR3dBjeemLT6+qhDapXyVr7pLFTy4RXSzBCkZSye5Znh4vLKaVf2+/wqVtxlVFbxWP2OYPKP2f4ERBr2FDr81Nf7tuuQRWisdKdG06IKhry32YPl7NTPeX4XXj+kYF7YSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmYzKXr6; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso809760276.0;
        Wed, 26 Mar 2025 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742993030; x=1743597830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Amp8ZyCu9CKjhLpb+I9YkMW1dEF+3WzD+1rz4IUnCpk=;
        b=CmYzKXr690iSlDUhRhIR5W0CZ1htzoHt648peqN+jI1KoYCxNxHSeMnrixMW/u/2Yb
         FsOrOpy6g7ujJMirUgpOvNuERHqfh41qRObNF3/8HspJNhbs8TNecYOKTDoi2jwbXyyH
         7eM4468EigJSW66tc2P38+pmnL5h2md6x1GPHt9fKmuEH+wXkZyXQkMU4L7X7N9h0gcC
         LIzAbajTLQ95FBSDLYl8pc5N50k2KfvqUND3myM/V0/qVKnlj318ksdwntenRQXAZoub
         Ll2zhPOudOfL2SSaG3LhzZ+nRg2X0V4pMdEHb2YRZZ7RQ15+Gr1Zo8rUIutZaxbCWT0W
         F7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742993030; x=1743597830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amp8ZyCu9CKjhLpb+I9YkMW1dEF+3WzD+1rz4IUnCpk=;
        b=Rbhaj63UR9LPJS/866tyOXGk2+ThoKTXiul3/KkbB2aBqsmAsaVDu/zraFtK0q12oQ
         Ke8CGVtpnY5M9SQah+YEfDMXvd89ZnCTCAWyva5qIB56/Ubn6CS9dtPrmAkg4Y7UUxnV
         yNcpfDEPScqAziKATwJt0OOQAc7EQj58rLbiTvcCMMuEy12Vat9s68Jj0zXTzn8oaMJL
         gsASEjxOv7SaReGwjV2LzzwohUWc8hnd0FITlnHvFnYa0nwYvjWIZNfIy4JpWbKis0Cr
         X2khzGo8gl58Qx/PdcGDJV2hVYUvOc308zRcixOsYqRZbAkcY4KLS8cjhQr3QTUu9VWA
         epeg==
X-Forwarded-Encrypted: i=1; AJvYcCWVZz2OZ8c4E0uBMfBmNcoYXx7QXWrO3qp+avuCcss6On7Efy5463msJgV3B/tSDpaWxtTyhs0l@vger.kernel.org, AJvYcCX+ybe4oflIIpGQM24X6OlwwZNu7utuERhPDbYWdgjeGeNFuh4daGyP7IXZrEylaesCNiWgAtuOZZqY6+I=@vger.kernel.org, AJvYcCXvnwBZSPafQakVmdKw0CnlGAKp8dW0/UFFqgu63twq+xG8d9RMbrr/K+3alFC/wJYL/XN2ukJDv4i0PWMideFn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BGzGHfFCo2bq9jm6phfqnMC0+eDHpQmFiJDoi0LqbGoL06iN
	E3v4yst1GeXbLaRWwwwlGmFLkVsC2MfOX0uMs5f2qkyeZ5xd0iuabOsHoLEjuh93SohaAXRIwtY
	0XtthBYoTO8JV/mQQS2UIyKRJ+RM=
X-Gm-Gg: ASbGncuQdtaymsldWV6WL2n5B7gzCNW86Sa0YXtD2q3yA+igYZS8vQQxownUubT5EOG
	gUErpWpesrBQdZNddatBnrTq8e63Wi9mPXc/liEyv0oGboZObbb1Es36w+H1eeAnfBjPTXMPkIo
	09lGaVjHfvM6WFfaV03rZVn2kmVvjZxqhxisQAb8ZkZovRE8Y0+cxZLOSDF7E=
X-Google-Smtp-Source: AGHT+IFkvobMbaSO9WjOFFFi0TFkk8AMZfKjuovz7NPfXP+Q32aIymRGtDa48zKqzC2gM4+tHZ1iUQjyuULWnSAWo1A=
X-Received: by 2002:a05:6902:1b01:b0:e60:b135:4c07 with SMTP id
 3f1490d57ef6-e692ed3bdb3mr3898013276.15.1742993029738; Wed, 26 Mar 2025
 05:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
 <20250325020802.7632-1-dqfext@gmail.com> <58712444-1de7-4076-b850-4c6035792931@openvpn.net>
 <CALW65jZ=Jngf0THLTuWHuhpQb0NDM=4x4HN_Xj922nmq71EMUQ@mail.gmail.com> <bdcc035e-24c2-4469-a0fd-f63494d74169@openvpn.net>
In-Reply-To: <bdcc035e-24c2-4469-a0fd-f63494d74169@openvpn.net>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 26 Mar 2025 20:43:40 +0800
X-Gm-Features: AQ5f1JofMqZICNlYxEgbGnec4lmbH1e88pHT58xTj_OR2iU5XUXml6rajqFB6mM
Message-ID: <CALW65jYBtu3Uew9k=aZS9BNdqH6fJ0bqWVFNVeqHJxqSYzjebQ@mail.gmail.com>
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, 
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Xiao Liang <shaw.leon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 6:22=E2=80=AFPM Antonio Quartulli <antonio@openvpn.=
net> wrote:
> >> This is not what we want.
> >
> > Got it. You could replace it with
> > atomic_fetch_add_unless(&pid->seq_num, 1, 0) and check if it wraps
> > around to zero.
>
> What about the first time when seq_num is 0? It will already stop, no?

The initial value of seq_num is 1.

> +void ovpn_pktid_xmit_init(struct ovpn_pktid_xmit *pid)
> +{
> +        atomic64_set(&pid->seq_num, 1);
> +}

