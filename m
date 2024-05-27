Return-Path: <linux-kselftest+bounces-10731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06EA8D0927
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FFCB25E17
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98A15E5D1;
	Mon, 27 May 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8WDPhKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210C15A870;
	Mon, 27 May 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829373; cv=none; b=bMpKh/f/YKLOs8eIQpPOXH8rplqpz7FpKAD4s6Praj2KVxCv3ihWrbSpXABVIQx3NP8XZs9uxddwTrATP0jeeRt/w7lmnbbfc90M6pgrjPCM1wiITonhfOw5jN3wylJcCKnBgZEMT1ksHoydz1jV0GLPwZEg1W2dK/vurRmwAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829373; c=relaxed/simple;
	bh=HuufMUl06tKaoCf1fvMHkMRw5RUO9CTNBZfFJ++j9F4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GPUHAv2Avg10dofKLv85NJRvLB8OWC6uQe1LCtpkGZUpZz36YS532WwIY3YQkeUYV6j8LE0HpgCyOmi62Hh2t+8f7b2LjjABg1HWgECLPyK8wG+D/D12moIjjQjGydnsdSFbuyllcaR1wQkI8OeS6cMiqV/udf5p00Y5Y3MOozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8WDPhKG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a6a54416so76375ad.0;
        Mon, 27 May 2024 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716829371; x=1717434171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCL0QMy+Ly73P6vs1+MeDV5qAwekWDUkZdhexh4ksow=;
        b=E8WDPhKGvTBJIPtfe4R/v0nKkNCRxE9jK2zf75CoDC3HYwetC8+0i6urynncWBUkTW
         SfcH4ZPUA4Lqnd1eSo6dbePIXFslMpX4Bxz3tUAoaYAENC64iRgG98owoyYcCYFCxqZy
         +kp0ZNMWF+r9omr+0tMbRrLXqHqC5oawOyzQns+C/fkc1EiNU2BeIgL6EOIxY0pRsOaX
         KhFjbi077cszxo/tgcZAQWqvwLyoJAw5oBe5wZx1uJlS15sB14d1VDEqoWwDQkcVGALg
         IFbgqVMm/IDMsoG8IrEVwCTtsD/Nl2rOnOhSkPaFppkeBSM3A3erHV8GM6fnURWVJVKg
         0qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716829371; x=1717434171;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tCL0QMy+Ly73P6vs1+MeDV5qAwekWDUkZdhexh4ksow=;
        b=bwZrrl/r8gL+MbdNKq1VvhZ4M1EYjO70wwiBxuAv2dBta3bcJ1nGdjdbLcfvlLpmsl
         ENqzh4rLTyrI1p4iVFGhCZ/iURy+ey0ynzcSOyuT/9B82dR7cR/YljvMAM+EaPedbPvE
         k62eFt+/MseBp19o3tr7sGh7BXPFw10vRkRk/0B1wPU4W28QS3KltL17pNG4u5KKt3y6
         31swnuMmveRaGS+HMV6HXa/22Xf/y3onzug56XN156zTm++EJFIgescfVq2O+2QBfHqr
         q0OwqWl4XDEs9SQfy70x+9t7IztPvQ+JzPadzDmhi9EbQcAydYBXoWYpsTrsLc0Ho0kN
         k1ow==
X-Forwarded-Encrypted: i=1; AJvYcCUUB4pcMFMAXELC45AWCDaGULQAQwxMw75cOD8aPf5FjCIHff8HqzJDmrpYBjeuzvD/GJm2MdpPPbJYJtfYzar1Qtg3mfbZM6qoEL/VLtnp37NZv30HF079EGiEugIqg+opdXV9
X-Gm-Message-State: AOJu0Yz+e7PYOTRjowhoO3IUUvHt+vYj5C4mKoP/8ttPXJv/1UjNpern
	bcdz91EXs7rkZn/bMoJ+GwaNKxj0IuL5+G7diiSEuA2notvQeA2J
X-Google-Smtp-Source: AGHT+IHv2KRHulQpfjNbRpU0ZNk6UKwSl4yDia/usKLNi6d7oc9+0t125YVDRVssVv3Juubp+LhX6w==
X-Received: by 2002:a17:902:fc8e:b0:1f4:a04e:8713 with SMTP id d9443c01a7336-1f4a04e8cd4mr47832295ad.28.1716829371142;
        Mon, 27 May 2024 10:02:51 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d1b46sm63393815ad.110.2024.05.27.10.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:02:50 -0700 (PDT)
Date: Mon, 27 May 2024 10:02:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Geliang Tang <geliang@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6654bcb9e376e_23de208d5@john.notmuch>
In-Reply-To: <08b20ffc544324d40939efeae93800772a91a58e.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <08b20ffc544324d40939efeae93800772a91a58e.1716446893.git.tanggeliang@kylinos.cn>
Subject: RE: [PATCH bpf-next 1/8] selftests/bpf: Fix tx_prog_fd values in
 test_sockmap
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The values of tx_prog_fd in run_options() should not be 0, so set it as -1
> in else branch, and test it using "if (tx_prog_fd > 0)" condition, not
> "if (tx_prog_fd)" or "if (tx_prog_fd >= 0)".
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

