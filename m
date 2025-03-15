Return-Path: <linux-kselftest+bounces-29120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFEA628A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 09:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1CC178449
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291E1D619F;
	Sat, 15 Mar 2025 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioV7h+V/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184B8633F;
	Sat, 15 Mar 2025 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742025974; cv=none; b=D4NJNhOA1IOIOQ+haJ3D3mB8XpDUHITTmr5jDcsuzPYawj7ZlYKhv3+6BuEXJZQxe9497oLCMtD3BKBkad/TXL88KykcJi22f/VJf/KCp2+Jr3oE0f5a8IzeAnzasV1dl/LHXYrYJ9nofpuABBJZSZOEUClAeEz7yDGUCTluoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742025974; c=relaxed/simple;
	bh=KnAUZ9wnADDd/J6Z+y4qbTn/E10Mg7M2sjiLjv1pVXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4b8MThFjgbCTgTAvnfMtsambo8ctmePC2CTHFxVaoHGlrmyKt2cgTlXmwMtlArqZ1ZfA0NxUJ9BOtpnkocFlNOVEg7++klqAPm8WLkRsr5ETf4GDmbju1uu6YII68zgUR+Xq+SSTb9Vn9mgAHTzAXggks4boKKHDvEKkpBk1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioV7h+V/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223959039f4so60689195ad.3;
        Sat, 15 Mar 2025 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742025972; x=1742630772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnAUZ9wnADDd/J6Z+y4qbTn/E10Mg7M2sjiLjv1pVXs=;
        b=ioV7h+V/BRuAuJ52pTxyQFMEenXzwmCIO7/ndppE5GA2zvdLBQ/HHL73BNQD5seKiN
         saCMDBooqjpctSe+Ew35NfeanDEJM0XTX7XEaKPGCUntrpGDUJJkjSJm3cNMT3S1LFhl
         4xacG5mMPwQJQ7Id3n605xPY+AwOIoLbrvpJyQKuZ7dYJ1kUEUhQDX5nJQh4Fl60alt9
         vn/UQFuctm4ulR4kMu961wVc0gHduu0IlWW1TWlUlg8AvdksRpDfleuikw/0XxKsJ4EL
         sBUZ57/EHEpWMbXqjGiOT54rfkTadx6GhXEVLxPge4ecaW3SsE28hKy4yF8bELMDsmfl
         QeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742025972; x=1742630772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnAUZ9wnADDd/J6Z+y4qbTn/E10Mg7M2sjiLjv1pVXs=;
        b=DUrIaEPmKQ04XXreoXyFTnOx+SsmKLdWFofEEROVDN8E3jPWFxM3DH14CCwXSauZPL
         uT3LpEzGKmGheF8ylrBnfNsJoH3vm97pOM8lPt4ZEJ2BBE5i0HGu5rE93wKyLzWmVl4y
         8oj8HOM0lgHZgTV7u9W75g4prWv+f7qG3dPbl/CMB6eHFHzB2xtz+gNpKFhcMjNkzM1L
         +arMShecKM8JUaLww3F1dWVFOqqkVnlrqQk6fyQ+fqYYHfz44JglnYqr8mXzGcyX44nt
         JR3n4xsOGRt+jdeiegQ9vzSIo0yJUCcMiV+La7BuhdHyoriC2KhuLTOeUosEm4UG0TTu
         21pA==
X-Forwarded-Encrypted: i=1; AJvYcCUSvT4lOynRoplBODVCrzxXUhjEa1U1PrHsulS/sWicFEGCwp1GCbcd0YXh/ZEezLSKB6KrVpLi7+EFPVwZ@vger.kernel.org, AJvYcCVMe+xPl50KFQZzFta7HzNP0enc5qd0wwC7q2AQurjEbkNNns4VmoeEXr8mKG20oxm6PU5a8Hx/reoHDXd1eubX@vger.kernel.org, AJvYcCXsOcD38hFWP9xwUshxkgFOxEtLSUmDt9wJ938axGhMszY40qCmYlClejCXBQEV1UxII3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11aHZ47FoYtqFUika85LL3ScvP+y/VAjluQO+lY49ZLXS+YK/
	O0KfOItItaNlDiUVoULXih/GzK3s0obW+vFYuc2aHLsTEVDhAy54
X-Gm-Gg: ASbGncvc3d+z+38gRHelH2QVHEEDw61tGB9cRT7cQb8tHk4pOQHNTq8P8bYgjqy1bwh
	TeDdZHSM3QVHdbA15UVXWIIS9AsD5EaFhYXCUYurVBM+ZcbRYbTYeMbJj3kfUBybxpLj13RZKzo
	MYstPZmUWTGUO9/cEvtjIX2B14nMybkuxeaqFMk8HDg4o/sZfLLWOTiAq59/OJ0t0hvqwgbI/y5
	e25LqWygApWKbPC4zGGZHNez8PaqUgCyjZdnjl28WfsencNVzjin664s3dFElmLi6EwBSqRMwm/
	dZvhhODTwOTFlRasxJ1AttHMxVaZdPL2+YwJ5O+aus9RcCfqHcQ=
X-Google-Smtp-Source: AGHT+IF5en4QKMgNNQsnpb5bVapdvySxgKqbFwNsEVlqfpqV1XchMWc3wIfTVYjTbMqNNkcnfGZ7tQ==
X-Received: by 2002:a05:6a20:9c8d:b0:1f3:2a83:7548 with SMTP id adf61e73a8af0-1f5c13c9108mr7253771637.38.1742025970286;
        Sat, 15 Mar 2025 01:06:10 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9cd03bsm3832109a12.8.2025.03.15.01.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 01:06:09 -0700 (PDT)
Message-ID: <785b4531ce3b44a84059a4feb4ba458c68fce719.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/11] bpf: Return -EFAULT on misconfigurations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Mykola
 Lysenko	 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Henriette Herzog	
 <henriette.herzog@rub.de>, Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Matan Shachnai <m.shachnai@gmail.com>,
 Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, George Guo	
 <guodongtai@kylinos.cn>, WANG Xuerui <git@xen0n.name>, Tiezhu Yang	
 <yangtiezhu@loongson.cn>
Cc: Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Date: Sat, 15 Mar 2025 01:06:05 -0700
In-Reply-To: <20250313172127.1098195-3-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
	 <20250313172127.1098195-3-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 18:21 +0100, Luis Gerhorst wrote:
> Mark these cases as non-recoverable to later prevent them from being
> cought when they occur during speculative path verification.
>=20
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

The only pace I'm aware of that might act upon specific error code
from verifier syscall is libbpf. Looking through libbpf code, it seems
that this change does not interfere with libbpf.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


