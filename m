Return-Path: <linux-kselftest+bounces-22387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36659D47EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 07:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E48528260E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC41AB512;
	Thu, 21 Nov 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Hn9o4x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A81304BA;
	Thu, 21 Nov 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732171710; cv=none; b=EkN0glDif0vSdoI2CMWNkSEhu4I8gO+FNbqZ8FgzsFpkCNZEjzpxHUHJzEeFj1dbKdLuMxfSSlDkkZ1ja/SJPlttJyb9L3amPrX1WYshZ9NF5UJXs1zTBZs7Kfft04Z2UpKgovVBo2O265T/CeiYuV4Svqm4sCWbU2QdeEQHVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732171710; c=relaxed/simple;
	bh=YfX9oubTDydKFaHgS7KZTyccQ3e95I92JuuUMpoYoCU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QCQSNCH1TqhAQDvmEdFaWs0d88YAoDbCx1KPP6+/PuaiB0iTgS/H1nDHuaYcq88JOR/34iWlX5AFkcWSeUnUwtnuQqZE0Pk0zJO2hYbuPag7JzoYArX4VO6QfB1/iT0BF7sHSZNZSxcBA8d1adnEGlCinUfFlDa83DjChc3A5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Hn9o4x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cb7139d9dso4916265ad.1;
        Wed, 20 Nov 2024 22:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732171707; x=1732776507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tIcAqmCgEQoi8yKvEQ79/4FA1Rbgsf1Y6lBfaNNksQ=;
        b=Q8Hn9o4xxgtwIzQ5NudMh76uTWRf88Ykvt4ZzQh9rh6DoiIn3IZAGMFIBICO3kQRF2
         jhhKjO0V1yyXJ+fUFHU9I49d3bcj7xE9q/q/8Vxkr9s7GUwGPXcU9xoAHNmiQAfNteCP
         mvmKmzqp1jbuZCHyw/PSL3xvSIUhvjuTU9UzvJm31DSDvwugaiMbxfRtaRNev2VbCC6W
         9sGrnL8+qTZpLblw5hPkfpXmU5X7R0lwIVgDbY+B6dYZO4IcrrcC5WBOR/EKp2LtJPf1
         BGhJX5+ZDFHWzipGAYcpV4ewOBHF2rHegFgwpry5V34neejqKRyUcuqlJMrmF68JZDrV
         zFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732171707; x=1732776507;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tIcAqmCgEQoi8yKvEQ79/4FA1Rbgsf1Y6lBfaNNksQ=;
        b=UTuOB+zACFE5gQCeLZCCVzplZVgnprDwGwG7X7BSCCgjsUkv+LXWoNltPGixmwrsDv
         xiawFvToMmVuAbj3XmN4cfxdBYyKAl9eGm9NF81FM5GYo+49oLL+ossQvqjZ6/1F8lOg
         01qr7c4A7QemZl97d8vIYUx4CFrDPIcRmRsY5acB3w6Cm1EP1fFLvEIrilZL5+VPvF6C
         pIN4MFOT5WuKrymp/XH7wHXIAd2Lr0oWQZmk+7McfEQsEFjuhoLRIBjmKySobAhiBhvD
         f+JO3HSDcyXa5zabgLeg/c3VBw1M5cmk+UxTGsctrYFe5jxm0YfbACzlVwNPo2LN2FPu
         InNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnBrRu12apJG189qW2G24MqnhznPHBdIDPdFjIf5RqV+6h97YA38MW4Y91xqtRQ6dk0KB49WwIsxh2q7QjhmA2@vger.kernel.org, AJvYcCXVqltfjxm6dweIqWtcTf0GvA2w7xsBZuMx7ceQ8hEViQ+XX9CWGVUFij7xk/4uGrToohg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4ukYbJno/tVDEiCy37DTBjdE2RWuGGPTt/utYCM54f5S/Uq3
	q5Rz1to+X2waNcTFQYpKd8r0suYXc42G14ecBWEABuo4CtQKygvl
X-Gm-Gg: ASbGncvsEthTHXMkC1f1qFN1u0pNMsWrdO9p7xtyqT/a3kcu2uL0NFMB/2hwjIU6xpn
	OmMQkDh9D4E5oSSakDmwvxX5YxFJ8VHSyLZ7/23FNSkAMKpcjSrq6/qPFCxccUT55IzzuPKdpZs
	KJ9cgGVsoMG4NIZiUOtQDdtBZeLFysXoBhZ/42h19uDCY/DhgR34lLjF4cPWSJhoHLRxU06kzsx
	VEnebsf36063Tu6DaOFfw8puYNLjjWs+uauNpFloG4LT2akKM0=
X-Google-Smtp-Source: AGHT+IFVHpBegCHkObUu2ZH6Y1DcVsSztEW4WH4JUfj+snch29Kbqo/y8+QChcoSIE7c0JrRDYcydQ==
X-Received: by 2002:a17:903:40cf:b0:212:65f3:e00e with SMTP id d9443c01a7336-2126a38b022mr67805425ad.19.1732171706773;
        Wed, 20 Nov 2024 22:48:26 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212880d16dfsm6264045ad.153.2024.11.20.22.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:48:26 -0800 (PST)
Date: Wed, 20 Nov 2024 22:48:25 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
Message-ID: <673ed7b929dbe_157a2089e@john.notmuch>
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
Subject: RE: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michal Luczaj wrote:
> Two small fixes for vsock: poll() missing a queue check, and close() not
> invoking sockmap cleanup.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Michal Luczaj (4):
>       bpf, vsock: Fix poll() missing a queue
>       selftest/bpf: Add test for af_vsock poll()
>       bpf, vsock: Invoke proto::close on close()
>       selftest/bpf: Add test for vsock removal from sockmap on close()
> 
>  net/vmw_vsock/af_vsock.c                           | 70 ++++++++++++--------
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 77 ++++++++++++++++++++++
>  2 files changed, 120 insertions(+), 27 deletions(-)
> ---
> base-commit: 6c4139b0f19b7397286897caee379f8321e78272
> change-id: 20241118-vsock-bpf-poll-close-64f432e682ec
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>
> 

LGTM, would be nice to get an ack from someone on the vsock side
though.

Acked-by: John Fastabend <john.fastabend@gmail.com>

