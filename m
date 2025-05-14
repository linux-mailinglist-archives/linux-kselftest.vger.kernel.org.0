Return-Path: <linux-kselftest+bounces-32924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C117DAB62FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 08:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789411B407FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176931FBEB3;
	Wed, 14 May 2025 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLm+u0xJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548332F42;
	Wed, 14 May 2025 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747203907; cv=none; b=BP4GGL8Ge+96lIySSp7WOWIvKCfFwdgGovu/RJ2ctYMPX6YLl/jZ0RHI62O/aUTSfwHHFQgRLA/hnUCzDXfFG4Y6hhUptgldWm0/kb7DfVOQEn6E4Se0gKPGBYodi0yT1DtDFpZVIWj3HGd5w1zHvKZWEsO90tZbQJ88ezKqsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747203907; c=relaxed/simple;
	bh=vEjRrrhKGba3tAjU8EN/hoGC1slSv2vkn6NtFzJIEiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSkc0t3yA/wtfxbMNs5NC8JeYxlcJbCD79MftoiCDJXrpVXyytJqCTSqtfluPwoSi58A81U17RHhx3X6o/bwHLPabFT17OOBXGcQ+YpQrdr3jbuDPCVTB3nrLbHGHCSbQlUY3Ko4wtnVfpf/3T2L8W2/KWFfQy6N9rW3Rk2TM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLm+u0xJ; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so1206568866b.2;
        Tue, 13 May 2025 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747203903; x=1747808703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEjRrrhKGba3tAjU8EN/hoGC1slSv2vkn6NtFzJIEiI=;
        b=WLm+u0xJxuORuwFAHNXCe2VRjuJgs9yUcRandZEKbtfb1seHLMMEaZLf1ZIm/iBbqy
         f1ALBflUTR8oBThdFQIVpJAeOeg9PghGL1GBwY+zJPP9ac0xnRIA82ORDj0cDCerTgFZ
         5ZD+C94egGNj6kv4qbALSy0N9MIZHI/uFvc1qVCqY+mQxJFrQzgxEJc+o4w8uh/WLMOn
         D1jjRkz6kyiKH0HFz37mbak1PqAJPUxiK5/rEXzfK/9051BuCW3nCox4xyDGrFWBUKez
         1iuzuiSzfchSo7L0SgMOLMOiznnJJiR6aO4+e+nLAcWm2zU3NVb8VmVNw5c/LG72T6Mz
         pE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747203903; x=1747808703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEjRrrhKGba3tAjU8EN/hoGC1slSv2vkn6NtFzJIEiI=;
        b=oipZwrN3Lzv7CHoqjXID6IyYSYNXAjhPIPKS8Rj+aoriQi42K1MUPTJg0F09XpX3di
         yg946CNe3jYl3F4Ma7bdTaGYgmDODtOpkouxFs6tCeGySE12UDdknC5rZvu8Jahv8vWE
         Sp5SD3E9UVOxGXoeNBAKvbArWrNska/CL7huRnZzF2zpnXmTaRdAxewr3U8dTvDpo16m
         /jMwJFOmYECm8UxWgVSe393KOrsH76zBTX3bqNCkDr8QkvelJavNlW1RdDvikhcMbCIE
         Zb8O9r8qlSpsD4kRiKw2wUvVRL2HBxpWd5TSy2NoqYUHWcpuJIOZM1htLSerZuFC28Fa
         rxyA==
X-Forwarded-Encrypted: i=1; AJvYcCV72aL/TODFrvtzga3cH1y5ckgefj3zvLXcsPA2S43Yq3aG+FowKl0L1c76yLujBFNCFLVmEJ2EySc2cNCFl5XN@vger.kernel.org, AJvYcCWnBzjB+GsdEKJq2GRbkgbb9m2ZIigRcoJ1uVSu9wX/24nCWJDU+uLn1OTuQZX9SMHptlY=@vger.kernel.org, AJvYcCXT0DXueXo8RtSDaKZSAvFb9hTSbK4BWVxA5YH2pQu2qAR0Ma+oRH4pJEeEf7vdjcl1TdO3ENuumvM+BhpW@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsOZJwD79icGRTmgW9UyP1s33bioGZNieuBOEb5UdqF524bNG
	HtncRzVb4QEVxAef4rvmIBHF9++v3jDGJ+MKfGcK9VMsCTLlfe7cfyaBqRSB4tciZ6rNhqiO65Z
	b45jlyEFt9Qkrc0PbGbZVzThgCi0=
X-Gm-Gg: ASbGncuGvi44f+ymV35Ccx2WFJLAyhpaf9mq9PB2YzUL+cWc0wP6gRydv44ZR71uciv
	ZjwhPIlMloVh5/zimw99Ow1g+k8dT4p9Oei51at/yvAr6jYfYpeuWJGuuXNs9apqAIVG3BDmcVq
	XaJWtOEwlctZYD6tmdqe2HU5O/pZbsJxw=
X-Google-Smtp-Source: AGHT+IGp26N/Qy84kSU01eK/5Do0fYdJsM4es4PrHHge+o69giKbvBU1ENd/2FnoaAbJwMTNlGTDVz9olNhPboIJDFk=
X-Received: by 2002:a17:907:60cf:b0:ad2:39f2:3a9a with SMTP id
 a640c23a62f3a-ad4f7292c9amr203602266b.42.1747203903305; Tue, 13 May 2025
 23:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-10-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-10-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 14 May 2025 02:24:27 -0400
X-Gm-Features: AX0GCFtu2D5_c8Hbz8VwjEw3nJ68h3pprbAnRl5y5vgEzz8EGiuxhoCH3nu-9uw
Message-ID: <CAP01T74DY4+n28oWZMS0Sh2FwYYxyMbTLxp8cf+OZ62AS7nOPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/11] selftests/bpf: Add test for Spectre v1 mitigation
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Henriette Herzog <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen <mrpre@163.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 04:03, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> This is based on the gadget from the description of commit 9183671af6db
> ("bpf: Fix leakage under speculation on mispredicted branches").
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

