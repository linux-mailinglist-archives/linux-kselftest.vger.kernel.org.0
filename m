Return-Path: <linux-kselftest+bounces-16888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA3966F78
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 07:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E42C1C20BBA
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 05:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986037E0E8;
	Sat, 31 Aug 2024 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPeg55X9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325963C30;
	Sat, 31 Aug 2024 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083239; cv=none; b=iDN6a9jImxWyhRhF8DSCCbfDI1UPrdco6UVOU0askL4nDSgd8buEIra38Ls9LNHL5QqdLtO9DlQralcsrz/LG3rMlVXNLWFk/zLIXtVC8+JImt7BHM5Y+8Kz7c48FRgOsst4fcahsiNgCYO+avWk0RbNVjHQ9XCQmLDu9CbqWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083239; c=relaxed/simple;
	bh=u8imtR1wqjX5vtSYhiGWTIpQ9iFad42AOyF4T1X0eQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=USXwITDWRMLndlbVqVcsuMoh4XSLPUTpGTy6SU4uxz8NNG/peQNZ2i74x7lffEKp5TFlX2TY7e3QbeMvzijDxyVDCigoNDS7OVg61YRi9Nf38hMqOdk7Lr2aZDNMhfhrZsnqg8D0ED2erQlfHnjmPukK97ozfQul5dRIxYjq29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPeg55X9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d86f71353dso929455a91.2;
        Fri, 30 Aug 2024 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083237; x=1725688037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3qdCv/34SlaBM7I6zxUMTcENRlUyUZdBcHJE/PR9fU=;
        b=OPeg55X98vnQkweC5R3CM3dan8GEjnib8lJgUvNpRz4/LtNNvEGIWUqv5m2mragH68
         /J+5BTo5FqkPzHluzrRYMbqvnCrb7u8DwGk9UJxCnXF03mBHhvkst5zfUg/RyNYU7hXz
         pgjdWDGFgHS6a7ugruYy0+mfVSxxUYxkXfF+ytNnFPw2Uq9J1fHj7NxEF65hWRtY0J1S
         MiHihbl/8FJYL0jxGmlkK4bGU5uPPrUmNWCiBjEUpJp9dg8sJgs/wOQOQgCv7tQOVCx5
         rWrfROvhSH7p0EvSMeKcBmk1jEJahoQ2lgVsUybI33uzrIH7hN3D8G6QqSu8EWW7vpTZ
         qI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083237; x=1725688037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3qdCv/34SlaBM7I6zxUMTcENRlUyUZdBcHJE/PR9fU=;
        b=WRJcvaZKS1CtKcFw4J0R9WZMZ8ImC9qAIp66JR1C/lPOWSVMdQYy5YlQ1eDp3is4Vk
         F1icB1FymIPVwHnTBfRENvfRPi6w8Ddn6dfc/Pcqj3WDANdxT0p4YnZwfewxHJSBfOMr
         wRopw3AxkDj4iKr7Xr9cFng6SPLqEkZAjFAvhdIysK+lOxXGbHzm6KHdvUFLzJkbvDwO
         znqHN52B+bX7m6P+wYXEnZZnoFv9We5+boa3QzkRn5BMeK7G5x0mGlFdbky0EKHl5boQ
         u1MN4wz1/ZBfyBGDfbfRO6w2wHOgaXM5dTVWhjKmfcitK/U1dnnp815JmiuO1XRMc6yh
         6Yqg==
X-Forwarded-Encrypted: i=1; AJvYcCULhMP/jamvKQF01sAPX5JDk5HrShYmWcLJGbpVYQS1tdJsyh50hupIDH2M1ri432UmbW2h+RTwOb0pPuNW@vger.kernel.org, AJvYcCVEecsTiTbQPu+dWZiSZD154sDWnF1UTj0iOa3okWDS2BsMSMv2c82ExaK2e3ljWPpqLa36zAEs8Rq9ovpzelLC@vger.kernel.org, AJvYcCXC9y2vHFm8nXdDQXoOhdakqBDUUdhGQGyP+ycVscIhz0SkLX8V83cqJgIE7V+D4/eMbMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3nkT/g7Qt8GaBZAKpjd4EWRGIxSw3+9g/qTlyV5wFdb91xgm
	m8lIm/6UgeekkKHpZO15ch9+3w7rIBCWXj1BiFIRMPlWmkIRX3lM
X-Google-Smtp-Source: AGHT+IHXwInMq6af8y1ipsdH1bz4MMYFrRFxEv5rCJC6uklQHBzukPu6RFf949bPS/zf1NsivGruXw==
X-Received: by 2002:a17:90a:1090:b0:2c2:deda:8561 with SMTP id 98e67ed59e1d1-2d8564b146fmr8448470a91.41.1725083237325;
        Fri, 30 Aug 2024 22:47:17 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d89b12f585sm430713a91.41.2024.08.30.22.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:47:17 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	aha310510@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf,v2,1/2] bpf: add check for invalid name in btf_name_valid_section()
Date: Sat, 31 Aug 2024 14:47:02 +0900
Message-Id: <20240831054702.364455-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831054525.364353-1-aha310510@gmail.com>
References: <20240831054525.364353-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the length of the name string is 1 and the value of name[0] is NULL
byte, an OOB vulnerability occurs in btf_name_valid_section() and the
return value is true, so the invalid name passes the check.

To solve this, you need to check if the first position is NULL byte and 
if the first character is printable.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC names")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/bpf/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..f1e91bf367fa 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -823,9 +823,11 @@ static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
+	if (!*src)
+		return false;
+
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
-	src++;
 	while (*src && src < src_limit) {
 		if (!isprint(*src))
 			return false;
--

