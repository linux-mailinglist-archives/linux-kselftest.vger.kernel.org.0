Return-Path: <linux-kselftest+bounces-32083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A9AA6002
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C999983618
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876F201270;
	Thu,  1 May 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Nz18OdUV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8B1F9F7A
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109711; cv=none; b=XAlkABluOmMjBWlqxS5MN0W3+YTQsBam2h9GGmvWIVcOuSUx/WSjbUMUrYJMiNpzi+PZbXWSky4fxqxQbg7bc8qmr5aDdPy+/p+NCZS5GQscWkD3qQR8p9KdSF8qmoPgHgan7EpcbpsQV6WUYbgya3hjg9AzX27PURswsD2+NRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109711; c=relaxed/simple;
	bh=bsz764YfWE4MRTb/rqiHtlptyqwMLFB4ZEx+pwwq78M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e4mMhXY+VB6bMKD3p6+QhPmQeDb1II1pRu2SxdPjj/xu2waAfn/Ii18wFdoZmn1hrGvt3Lh9J2vztw7d8Cy32gzB08376snxmEmh5JkcameXCKv4VLIEAuZ5qQ011wDs8/JEjVGAWQKBm2soKTas42vc1ie2DRwinOCrLptMfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Nz18OdUV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so7805995e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 May 2025 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746109706; x=1746714506; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StVEjYMIl6wQyDKAupy/1mKYeucD0OYxvq84SFVjyeE=;
        b=Nz18OdUVPqtfO1CS81ZnZncxcGyeiNFrAzEeWVYMUMZXtJaVFIeU9ypYHo5k9OX9ka
         DH2Vq0YPwxNGy3ry5h0VrD5aUvwG0P5KggRCmQUAmpIurDioH/qiLuhuv9wLpvhps3SF
         q7IWQquVRvqH7uD7oZUkEbG3ZzGJ9gijK+xwPdn8ue4hXSfLmrx/VX7sKi6Pn0ANyKH0
         IznUj/vEXZd+STczZM8JmlO6JWHm/GIdDxp4u0pLkuoudBr3dBdQPrJRY0cudkdfxdPF
         n9r7pAPpEOQLYH7SDhBBjXCz1V/AUDZW2l9Wq5dR6kJQLZja5O1jNxu4m7YUDbGhYX1T
         Is5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109706; x=1746714506;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StVEjYMIl6wQyDKAupy/1mKYeucD0OYxvq84SFVjyeE=;
        b=v0dRs42YGNXI5du6FDNft9UAEgZ8mCmbNi/ZEO+ofyDAZDuMPRIhbc65k0zURjcexK
         ueaiHKsY613UlBt0ss0N6F1VfDuQmNeukafqw6tdd/Gpiiusup8cEFG4Q9/Jxe53xV8F
         xTnGzhTurMR+rxjemoT0r2T72ebINhCCKoMgxi3bs2FKn7Ekm92qlTXgqlyWy8kJWamI
         L8RhZyIP4CuH5zq9Ki6UoRle8FtnDpwJ7dYTB4lUc882r6j+bxhmd9JFRZvtdmMRUwXU
         RkBEnvi0K8JzBXBB+W1FYcBN+8ZHuA4YLLuz6Jzuxw7v5rxtqACSQzqAHU66YRn631zC
         cN7A==
X-Forwarded-Encrypted: i=1; AJvYcCXCdyOKfxdFyR5pDjeLYQ7IMAX3BmZULypKnwRAMwDcSlAXC4Si/+8+LovYN3rPXdc1Jn+FoWXVMl/lnIbgfeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQTVIZBkePyTKouAeXIoyd196yxSZnJ2+5lYRw8FUPBMdwtAXv
	TOvJFy8RMinMOb9DzVK2kcKRXWBKzGA+XpDWbV+fAahfhV399KRMzXDqV0PdbI4=
X-Gm-Gg: ASbGnctHiRP+8zErS9tTdme0rl4hrp6mLMPqqZjzhqwM/4qkS5ZKaP/Pg/+6EQTTuFp
	LNDiBmx8Y/E2xj92Uj8QURjxF99+1L4l+gACRJxjR/WmPI6lVPvTz2/Un20r1pJscfLop5zhdE2
	wv2Zx6tK3Mik8M67SDImh+pwo9bHu4nkfDGcLlkvztm/1nvUZXvsIlIhWRy3k38RUTrFwgb48vQ
	/R0wbo9vObBlLQoelA8oiAo5dAuXlFaiAzGf0bAVWKWZv/nevPdnnPHL4g1z4rcrlA+oP7mHEPw
	CCEWDb1iXxk3LOxtG61IoSPz8psAQ9TWaQgrazlVBHxX5GBHkrx+QlylYU/MTtGFQ2ezimkwfeO
	TFTZ4PIGWbOGa044Ju26VOkXaZkD5hrnCPH7x
X-Google-Smtp-Source: AGHT+IEPSk+cQIgonsEsIg1aqlii+4w8mjQ/IOfqZ7nsCbNMR2MfqFqMDG1cn5sRDjMY3mVaDu76ig==
X-Received: by 2002:a5d:59af:0:b0:39c:1f11:bb2 with SMTP id ffacd0b85a97d-3a08f761da1mr6037739f8f.22.1746109706055;
        Thu, 01 May 2025 07:28:26 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d15dasm13908445e9.16.2025.05.01.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:28:25 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Subject: [PATCH bpf-next 0/2] Allow mmap of /sys/kernel/btf/vmlinux
Date: Thu, 01 May 2025 15:28:20 +0100
Message-Id: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASFE2gC/x3MQQqAIBBA0avErBtQwxZdJVqUjTWQJloiRHdPW
 r7F/w8kikwJhuaBSJkTn75Ctg2YffYbIa/VoITSQguJ2R3s74LOzQEVGa37znRkJdQkRLJc/t0
 IS7DoqVwwve8HbY5dLmgAAAA=
X-Change-ID: 20250501-vmlinux-mmap-2ec5563c3ef1
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
With some upcoming changes the library is sitting at 5MiB for a parse.
Most of that memory is simply copying the BTF blob into user space.
By allowing vmlinux BTF to be mmapped read-only into user space I can
cut memory usage by about 75%.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
Lorenz Bauer (2):
      btf: allow mmap of vmlinux btf
      selftests: bpf: add a test for mmapable vmlinux BTF

 include/asm-generic/vmlinux.lds.h                  |  3 +-
 kernel/bpf/sysfs_btf.c                             | 25 ++++++-
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 79 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)
---
base-commit: 38d976c32d85ef12dcd2b8a231196f7049548477
change-id: 20250501-vmlinux-mmap-2ec5563c3ef1

Best regards,
-- 
Lorenz Bauer <lmb@isovalent.com>


