Return-Path: <linux-kselftest+bounces-26336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03680A30480
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 08:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581B6188A259
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF071E5B8D;
	Tue, 11 Feb 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqomc+Ec"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D48128819;
	Tue, 11 Feb 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739259094; cv=none; b=AKfhVBG+iEER95zwnTGy2oFPtYZ/JNDf0e3WkLJOm2AO7AN071kiDGOnM8JI1StvxkwpTCRdwu8vt4HsDHyuBWAVUnQCMsrVN/iNsBbOPo5JKlu5z2kqGBnnPBn84fLkNwBQp2RQQzFYxqs7YuFXmO4RFO4ung76kzz7UEvFeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739259094; c=relaxed/simple;
	bh=fNXHZD0w81zVXb5WMwE53i1fejXnfLGbij1wF8RDOLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wttk61aKgwNvgpElNfy2n130mvgmkfmDeDx+ILKRvjf+jGPOgETdulLUGa3sWFe1Nl4E89cqA+01UmdDcdqQbKuCnv4OXK26kw2L97DY7L+ahyTcDnpRPB55M7daf1kL3nXkW7heSlMf6VYpfc1PLbXaUizI0f8E8EkhgrJ3JZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eqomc+Ec; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6a47d617so45973025ad.2;
        Mon, 10 Feb 2025 23:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739259092; x=1739863892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTH7Pm5uOLfD5YPyyOM3Aj+5Tf2V89zBjuGRtkm1M5Q=;
        b=Eqomc+Ec4f8HzCKQSOY8u4l+px0Wwu4fov2gr5J5FyXOpZjdV1hcurW9gRxYcn6i+U
         Y7gT/rX4RdIjEPbZUX+OZ++tGN6BotVN33ljT/mSXxL9VUFAKtSEFJUu33dATCdLSdzl
         /fQuYVqAw6ro7tvbz/CtilCn5k8PA4czy4QiaE08UMKQluxaCVW6zZLV0QLjOm9zVcau
         ECw44SZmFvdcLA+W6CG4lTlTeQKvsQP6zzIx43YjIiW79CSvvlyli+hSzAeqRN8Rkd83
         t2ypM7HQT8WSyXww4ysdSefCOEtWO1uSp/3adXwl23wPZc++kv4fvveM/Gua+BsULS5s
         EkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739259092; x=1739863892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTH7Pm5uOLfD5YPyyOM3Aj+5Tf2V89zBjuGRtkm1M5Q=;
        b=EJfMfM0eBYB98D53Ncx0/+sR1Bt66k53STmuvRl5hKaIB0LIw510TgYaHDz4Ae2wOd
         0gUpVKvm7d2BdrPQca30Y2n6JwF+N6vjGsi6Di0FDRfgb2AY6AAMJfUmgdOfnybbcjPY
         1lzYxZoo+2KjzH1rQzA0LdWzPeR1bb8YmVn5X6RW98xKIMdg6ts5i0R2MOj87v9bpkvV
         m6TeQ0RLyYu+QXwtO65xNptlw9dTq0O0CcMpTEs6PTSprJRpV1CkTBEyAgG3Ud4QSryh
         dhG9Jdtr5l8ImUGQJVjEs5EjcyXDkbr+doOF8C37q4NbWhDskMHgbMyLK5todE72RIiU
         lTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9xa/k+gaKGa6DNkFAfSfRM04lTlgCrKJopkl0Ped2GSgj/WtgQWSkpkACwNuNWPctwN2CwZoJBHaM2/WFfdBB@vger.kernel.org, AJvYcCX+l3XX/3/uJs3SO4xxIacAbJRp+VELcgv8n7rniPxNu1Y+dtTFQBVUrP/I9tv4NarPRWyXLq4U/GgJg6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEsAXhBDooK6ywbeLqRVy6bV/K2NRHWMUa+CWXoiaj6N3Kh+l0
	E05VM310/AJPsTFDREhxm50KsEP2QO4YWh3XwKPWkRlg8eDdNoEzzaZE/oWff14=
X-Gm-Gg: ASbGncs1vDO56IGWigpPbEcHRMuCYDp7vG+QnuPE0VO/AHMP3geG9MhVckl+6oMuY+Y
	l6PbFrzQk6dmKmriKFD/2otzPbZX2vkZYRr3Rx3zSDS0C9jUs6hvOTjUJyPjjyB8ch4Mf4TWM3h
	D1gnPsh5tVMjkNMonv4YiA9GtrYEqlxwSdBdsFlXQjYTTYwdrWSncIbYCH71T0anvAPOcyXjzxW
	wsb1EpP1XrOesU/1ZDblXuXSTy56K6uvrewedADmaL8s4yjo9zd4Q87FlcMCyFq0uHMOPZ8Lm/d
	4QbgfIBytuvGcgG4odKI
X-Google-Smtp-Source: AGHT+IGs30M56X5gAKQnZAxB9fHIUoYBdvgrpgSZIn7PFxqdfYyq2SNPZej4vAjy56zlwVX1mmBcEw==
X-Received: by 2002:a17:902:c94c:b0:21f:4c65:6290 with SMTP id d9443c01a7336-21f4e6a0641mr305340305ad.1.1739259092134;
        Mon, 10 Feb 2025 23:31:32 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687e68bsm89975435ad.169.2025.02.10.23.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 23:31:30 -0800 (PST)
Date: Tue, 11 Feb 2025 07:31:23 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
Message-ID: <Z6r8y1U4C_s1-3jV@fedora>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
 <Z6b67YBbERi5v9gt@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6b67YBbERi5v9gt@fedora>

Hi Jay,
On Sat, Feb 08, 2025 at 06:34:21AM +0000, Hangbin Liu wrote:
> Please hold on this patch. Our QE reported that with bare NIC, the
> backup NIC can't receive the NS messages even after joining the multicast
> MAC group. But after remove the backup NIC from bond, the NIC interface
> could receive the NS message.
> 
> This is weird, it looks the backup NIC dropped the NS message somewhere,
> even using tcpdump (the NIC will be in promisc mode) I can't capture the
> NS message on backup slave.
> 
> I need to debug more.

After debug, I find it's a driver issue. The issue exists with ice dirver NIC.
I tried with a mlx5 NIC and the patch works good for me.

So I think you can start review this patch when you have time. I will debug
the ice driver later.

Thanks
Hangbin

