Return-Path: <linux-kselftest+bounces-32105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EC7AA6607
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7A5465C38
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EE7257AC2;
	Thu,  1 May 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmsEPb0N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82414AD2D;
	Thu,  1 May 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746137288; cv=none; b=Gm8+Eiqr89OLMNjTf/2RblZUTJlIEAJSzxnoEaX7wX+Dhvz+cCQ4NEiPNDSp5kZohuIuSZS1WyIp7oVH6MWYh6mKCzU5iiU9V3GN0V8bUWwqGZnR+T6NLWEQCEJ0aAjbLE1UbAoOvHyH9Ir5BSHKFpZbSUAwOdXmpYD6Rv6oKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746137288; c=relaxed/simple;
	bh=7quJAgqtByXNTdZlZiyaqw3qQ6ApoXnPxA/dYk2LZiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erZx/v544ijkV56sbVbHRTp0ptY8D3C4StD/5TDCbzGTtF7CfvUAr7zzsUah7w8N+A+xGUkY9O+zBda5XBOmsGJ+wmyuEmDc7V7lSvZTwAuaWsw5pyKImy9m87BMFAidrBwKd4xdu24qMqBpSAJlVGcD5cfL/kZ3tpwCfgNrYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmsEPb0N; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso2518143a12.3;
        Thu, 01 May 2025 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746137285; x=1746742085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7quJAgqtByXNTdZlZiyaqw3qQ6ApoXnPxA/dYk2LZiw=;
        b=mmsEPb0NdtFudML8olBVccOrX1KmXGJw1GBsFsNdi5O7nxSOBD5lb6ncvFBo0h6dyt
         mNKkqpLd0/aUxggI/CUGx0n89xfxGlyZohmsRi7Xc76NFTyKeUwLqvLgN3LVrHZ26n5+
         +uEsh0LyCwSWxK/7F264oPU5oYObDBQc1L/V2MRYM7Xa0IwwJYEMZ2piGU9yAvmiUIiB
         gpKEQWChOOWEDxYRR6ROhDOdBMNn0Y52OzJri4PH2zPxE/sD2gYs6KkkrisancEXyOHE
         vAM68nWz6EN3uFzeI0hp2H+sU6YNtHQRnOMzO5/dp0veGrRC89fTajzADPKHpfdlAVug
         pC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137285; x=1746742085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7quJAgqtByXNTdZlZiyaqw3qQ6ApoXnPxA/dYk2LZiw=;
        b=ZgGruMXFOld72RPDiuDCkszzKV0H5N4BRt8DjL54DhRZdT3Dtl8+EPVOmf0CBbxLng
         q69D+UQ9WhfbGMzaN2EOmzk0DLwuvEeLM/i4cVz5E8pHDfSzSX2So3UOT2pWe7W5Rr2C
         YHFWWTw0r2GHW11Z9oD3oaCH8TQwNEAuqzqM7cvSV3raItb4JgflDKsbHbFO6THhOmwr
         /hflq7Fn5jnVISYdMVPhC4yGD196+pezYO66D7sSlcxp2SYA+SQr84S3yt1oFnT5RI84
         kadxZFjOsV34Ie22DuqTgthC0YvaSad+8e+UHHcKa2qGB/uYROk+CtowB8FRli/4hwSR
         bDZg==
X-Forwarded-Encrypted: i=1; AJvYcCUS2u4gZsGYwQE6D/EjTglSNLvm4t1FeQuoLe7ra/TYOqz5EnO0P/qSK58YIBi/xh+TzCJ81IsveAlIk1ozsyzl@vger.kernel.org, AJvYcCVeWYVu5Uhod+wwm8QoSSNoZwUPGYSqoCJCZI1OYymHlnXdhJjGAkGoh9tGBYpGNd3b50o7otOFYYcuuHap@vger.kernel.org, AJvYcCX4lsLeXueyIFibNhrNRMOB/PdhiUgdzSpDL+KOmwKm6Jwhj+VkloNLcR6gK8HPOL4Opdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEeJ0m2MxfqOKlYZQMl+yBLqUfqiPS8FO2FldJr0ov7VHQfmG
	wrhTpQUUyRQ+TjJ5CZhkieXUVpJuoGsjReD628z4sGX5qe1BX8ZWbxbtokRyXZmuJLoiwGfXOxO
	Wgbc8c/OcpRAEJYvYT9bwmRI0XJY=
X-Gm-Gg: ASbGnctJEfkhiPJMln2vpZiowreTrc+aRZi+jIKvDON/wv3c8k4oKMJYX0W0Wfktgzz
	voiYqMvteby8333iQ3s8CncPbisq9lbYmV1HDKjkbnlAwkI+dVHtC1AO3JWogYLNwuX7IUCPaWU
	W+DiTkXdjtU8cocBiGqH/TtaroHT+PfuiatDjLlrbaLl4=
X-Google-Smtp-Source: AGHT+IEpCphxCqMgTrla7wQvz59TQTpY+aaLkW8rSW5jI9j4mNhEMH7gT93PVUghkBIu58Z86lHq44KdoKbiLLlzMQg=
X-Received: by 2002:a05:6402:27d4:b0:5f4:5a6d:20c9 with SMTP id
 4fb4d7f45d1cf-5fa77d559e6mr348036a12.0.1746137284554; Thu, 01 May 2025
 15:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-5-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-5-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 2 May 2025 00:07:27 +0200
X-Gm-Features: ATxdqUG83OGzyF1YRlc-RZCuhJkMxQqfI4mWekVT0IBHPEfZLUOvcZSUG01W9MI
Message-ID: <CAP01T75Eg0EA5jmVQs=FFFbkpZPP2rHS-HTO508rQS5CwC2h=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/11] bpf: Return -EFAULT on internal errors
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
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 09:48, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> This prevents us from trying to recover from these on speculative paths
> in the future.
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

