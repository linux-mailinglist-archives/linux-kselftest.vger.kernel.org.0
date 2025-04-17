Return-Path: <linux-kselftest+bounces-31065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED573A92119
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173D04627F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD324EA85;
	Thu, 17 Apr 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1T4QKxz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D56A13B284;
	Thu, 17 Apr 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902984; cv=none; b=P1eg1hgKB0hkDiNF2ts4zepP521qJ/oDMdRgSX8yZuF3ZvYQzeq5QlcyMD+KEeku/VhR2F6aRFEJPWPLK1CKv+8nN7BsmLeG518YIIJYsnwTUE9XGB3h5OD7GGy0Xrh2DejzwJuHYrA4jS+KMgn3GILsU/552AKOb1tzjxfhwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902984; c=relaxed/simple;
	bh=vDNG5J9YAZmJBFEjNzWUNvLcAiYSMgvFIBv1Cs3g4Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myYA6qi2fJmfvg6qQelM+7m/fJSMUUzW6MZmHRcXgGWFW50qKtQvIWHp081Du79HQHQyn+rNYi4kSQ2h8/o2pjUmRGA7BCBIi9DyoV5n9PC3u8GgY7YIgAxlpVaOHyUm48IfRTullxjZYc1N/cOYzeLgfNxd5Z0f1buGfQNP3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1T4QKxz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fd89d036so11989065ad.1;
        Thu, 17 Apr 2025 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744902983; x=1745507783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGJV1Ku3aa6Fj3ZRTmxbpDxz0v5EhwO8uuj7pE4kers=;
        b=h1T4QKxzRipgY5LtJPtoJFgyjMZsGdlB6gcdCGuqHdZn6MmBKxZjCZAb4LHLlnIo4V
         P8tazfoClkKuNQ5OePrFk3T+zna0b4wyWPc2kZnSUcJCeBcYRNQ9z8mgwUNmUh/MSP6S
         pWLB9l9HNRh8uhwh24H/4C5g+Blz3o2yl4bqfazK3dw0abe9rvHkM8omw7JQMHT85DkJ
         AifpsF4+lvdyuOPQytnSeEZ4Vpctx2TErO73sb8Yz6sEieUbf4NL8rEIYDiAN7Vu3plg
         R07/OXKaG1pPPsJFWG2grw43tFV+Hywn2rD8maKC9QWQx4922i2DhHJhpKN9+NEqKTeN
         RhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902983; x=1745507783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGJV1Ku3aa6Fj3ZRTmxbpDxz0v5EhwO8uuj7pE4kers=;
        b=GjeGpWEK5Rvb0B9+YKM+whS0HPlA7fPBWwVR+SiFdgC7DovJLlTwjadPsHVDqvYtak
         Y9v+1APzBxlGnYaoJjA2lll7EW262+GrIG+GRqMcdWgd5KHRaBtEIN/YqZh2CJLdbaa7
         ZAUJx1SqeqlYZ61GCk8gO470RVqUvSpgvmgnTF1G/wGbppCwqF2XOjwg1Q+dqZlVJy22
         DEdpkINBCy0wmqorUaAMuTEGJWc/PKUniKuZcEnvV2DGhGzWwg+xSveryG9eJqDMgglJ
         IUMKq2E7ABztgqnwboU6umggqw/Xh1G9rzb6Y73GrNZ5FNpwTSl3vJQTXbRT6W8/urn6
         7HIw==
X-Forwarded-Encrypted: i=1; AJvYcCVkHpEJns5nBqSg9CO36xGuMi8PskRfOZocJw78d+crToM6SiH9NpsGl9KmrFcs3M/maXuAsUMaAajAXlI=@vger.kernel.org, AJvYcCXfJlBk2i4dj7SN5HsedwYF/GkVT6k4mvBMUhh0mITkWYvdpPh9iTw23lCSmWwOz6dKfUmwVAbLIdIMuEEwXoTq@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8/vk+CaEwe6QSxLLS20h118dshgxexCA6GPD00WFCPLhpbKJ
	lVxrM4PfZmzdGJRYB5xT6LBoJ/vLixYOO8t0zxj6aHnZ4fFLaHm4
X-Gm-Gg: ASbGnctUcgART2A38evJW1riXg1i46730jKo7zxIp2+WryvUwEWaZ7OGR2erGiz9EPM
	niT3IxALB5LYl4jyZvBRJKsnRWOtnMWV9O8Fw9EEGaF4f+Y9XO/zpmTiGz1ijhlUYAt1mJUyIhL
	YLfUdRoriNxc7gP/3ywQBSVAUHpnzPkM2KSeQaR3DqOgvyb82bU2yIcg6sZ0zR4wUMBrGpssCgD
	r+VQoN5r3DFUtF2iRv/XZ64yYkqUqGyFzDEHmv34DO2yBGIHD9/HCY4TFjjLgRisNXDj8K5F/Mh
	6yuDMxema9hLG6TdL/zypR/SQDiHVSiw9+Mpcy55tbLg
X-Google-Smtp-Source: AGHT+IG+wLg8wXvjlJtWOVI44i/3+RsuqEERrigBNLWU2Klwvg217IuWdZgjADFAT32x3vs1lQqR7w==
X-Received: by 2002:a17:903:40c6:b0:224:f12:3746 with SMTP id d9443c01a7336-22c359172e3mr88735605ad.30.1744902982679;
        Thu, 17 Apr 2025 08:16:22 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdb97esm773125ad.219.2025.04.17.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 08:16:22 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
X-Google-Original-From: KaFai Wan <kafai.wan@hotmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v3 0/2] bpf: Allow access to const void pointer arguments in tracing programs
Date: Thu, 17 Apr 2025 23:15:46 +0800
Message-ID: <20250417151548.1276279-1-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we try to access argument which is pointer to const void, it's an 
UNKNOWN type, verifier will fail to load.

Use is_void_or_int_ptr to check if type is void or int pointer. 
Add a selftest to check it.

---
KaFai Wan (2):
  bpf: Allow access to const void pointer arguments in tracing programs
  selftests/bpf: Add test to access const void pointer argument in
    tracing program

 kernel/bpf/btf.c                                    | 13 +++----------
 net/bpf/test_run.c                                  |  8 +++++++-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c   | 12 ++++++++++++
 3 files changed, 22 insertions(+), 11 deletions(-)

Changelog:
v2->v3: Addressed comments from jirka
- remove duplicate checks for void pointer
Details in here:
https://lore.kernel.org/bpf/20250416161756.1079178-1-kafai.wan@hotmail.com/

v1->v2: Addressed comments from jirka
- use btf_type_is_void to check if type is void
- merge is_void_ptr and is_int_ptr to is_void_or_int_ptr
- fix selftests
Details in here:
https://lore.kernel.org/all/20250412170626.3638516-1-kafai.wan@hotmail.com/

-- 
2.43.0


