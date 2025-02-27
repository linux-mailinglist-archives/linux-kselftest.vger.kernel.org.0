Return-Path: <linux-kselftest+bounces-27786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6191A484C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784B53B8018
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B141B043D;
	Thu, 27 Feb 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klDz57CM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710E1A9B48;
	Thu, 27 Feb 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673080; cv=none; b=sLpVXKR2bp9hPwePLZrZaMAQsBi+jsTy/iFwiISIXjJImNSALGT764yby9aPsO4hh8//3YVYd3Liq01QZgW+WW3tLTiiULlbHbEoqGBjsesLttWicS9t1dOYrt/Ytkfi78J3TODg1uECmUPgY9g/k8Ya5My7NLhcmR35wVeSSzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673080; c=relaxed/simple;
	bh=1z+Hzt1PdwAxUZ8iMiUW2/Zzstu2gNJqEwovAfe5vR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NExPi+bo7pFQYt+iAlirfFeAwpKSG6gjeNMqK/slRMaMvgWGB67W5s2Jlz623tlCbk6oIu/BTfJClid5OL8my4K43nUOuDUAeL+y6kZDwVbE8LljCKs8MO52ogoLim/ZksI4Nr/xPOY7MRi2+lrz0/RWm94cBJtsiTTgebMWqi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klDz57CM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso7913565e9.3;
        Thu, 27 Feb 2025 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673076; x=1741277876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z+Hzt1PdwAxUZ8iMiUW2/Zzstu2gNJqEwovAfe5vR8=;
        b=klDz57CMM71P+vzU02Fc92Yi+B9/BjTBnuQDylraUwGok2JWKN714hB76Pt/qBTti8
         4G0igqwk6agg+HTSnrSxe0E9b+fiJqsdHCyO2GYWWBNapqk9qmCsRZTyzXkaAg3OPMre
         xdZvPJqA5jZDQ4K2TVBbilOK2xJT6coZdAS5iJggVteb9ZNHfsTvft15tRcgW18M9kwA
         zLwxiCRNq94a84EnrnK2D+P/F6nGdlm0fjOx3kty/RTk9OFzXee1c3Rx2YEOdBv1RdG5
         mE234dskEfljTJiOEIEeM8a+YOPsx1iG1fmBg/D61KBA37F6YndKGHBxsJ6JtDKS3PmP
         Q4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673076; x=1741277876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z+Hzt1PdwAxUZ8iMiUW2/Zzstu2gNJqEwovAfe5vR8=;
        b=vJZ+LbJLU0jMYilcCQP3O6I5Ang7CoNo0bT7GuPe1MbxCefpwF02DHRvqvrT8pWqRP
         cKWIDzs6iE2Mp4yW4A3HpPb6pCIWfwTkfCiSbimixuSk2qiUGhVduok3Ky9c5TIfP+1S
         S8FNhGlguCeTWruIdwl8kp0hRvPKWAJwFgNIKIn8yfriU9YBv5YWemIMnuzVueVfwNc4
         DEUZqHfXkBjzIWKA8KOfep8K43S/UqXJ8p/bNa1bIa94cZNGtRlQBQI6S63Q4F3pAtZb
         rGl5mL9XwPneKuihm2m8ie9cLfdHHCfegIYZLdrbc74y2QdBj2FnWVjHFudCwiINGNqO
         ckKw==
X-Forwarded-Encrypted: i=1; AJvYcCUlvzpkO3RBJjtBvhXssXsMeq1alfDA2thBASNTpSRCTpo34Y7766aXZUEtlVkBbzsMHxzUfXMicm0/TLg=@vger.kernel.org, AJvYcCWaBn9OuZls+/HL7h3VAT3LSn07Q5AGXKqmyjOB4oJXHyKnAFzBdJW7NP3/oNcJFscYkmfXw+ww@vger.kernel.org, AJvYcCX4k149Pocx3NAnEratj9ykAkvIsYymcQ5PnKE0XTaeWIs0oRA/StmChXumn30WlUnYMvck2sSsScovo8Kd4ULH@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBp0bX1useeYoDPeo/LH4XBlyLboxGUGUiCdQLAwKkmi1FAia
	f8uTMSYe1cV5nnnHNS9+p2dddN3BF35zWMZjXtW+KPVJjQu89s/baK61yJG/pkCWzfxnfRnfjEO
	Tyt/S5lQgFIsoX8FIYGEqjPnuh2Y=
X-Gm-Gg: ASbGncuj1afKuMpNxO4lUM7080E/rV7jfDxT/9Y8AlwoopJERyvMljPaqdHcP3jdc0X
	F0RqLI9vViDQVo2eK724o8cBrICzJv7dz+d52WAUMrWW6zLJLxDNnfG4r9zKYLiSCQRv4fthG//
	DW+cdY+vHb61TW3oy2Dy2rycA=
X-Google-Smtp-Source: AGHT+IFfZgVBIMgHAS60gtqUMMB4iTwPuyRrt1xAWu0l2Q1D0A1APbfAlQQkVv12JtGzFFt1nyjl7SNYomywmovKPak=
X-Received: by 2002:a05:6000:1a85:b0:38f:2403:8e98 with SMTP id
 ffacd0b85a97d-390d4f3c49cmr6921059f8f.20.1740673076346; Thu, 27 Feb 2025
 08:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227142646.59711-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250227142646.59711-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 08:17:45 -0800
X-Gm-Features: AQ5f1Jr3aoT8fcBBvu8cqSZiaY9ghCmWDcM2Gyb-jL8U3D9wTjYLu2PPC3eSYtk
Message-ID: <CAADnVQLW1G7xA2X2_rB8iG47_5_7LHXve2aXVwXDvSmbUzkbtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Optimize bpf selftest to increase CI
 success rate
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Jiayuan Chen <mrpre@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 6:27=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> 1. Optimized some static bound port selftests to avoid port occupation
> when running test_progs -j.
> 2. Optimized the retry logic for test_maps.

Looks great. Applied.
Thank you for fixing them.

