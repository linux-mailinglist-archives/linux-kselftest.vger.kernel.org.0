Return-Path: <linux-kselftest+bounces-23474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E712B9F5D63
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 04:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC5CF7A3FB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 03:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2814AD38;
	Wed, 18 Dec 2024 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Psd2rbq6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D44A23;
	Wed, 18 Dec 2024 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492253; cv=none; b=BS69UHMtrhf5wHSBm8mRRAXlff6pivTl6uhYo8Mq0tA8MY3imyfMJmRwDLX+SBUDR7iwgp1XS5KzNermr6IHi6e6rpfgYabOk6slT3DiUr6LN2PbtftUesm+667kfBGeLYbGo4FMmPz4lrwbZoGBPZNN5p/9qsLPB2lFIaTvsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492253; c=relaxed/simple;
	bh=1TaZy8LbZok9k7/bfQHsxcHss8JJBsnuk+zvzcUjHHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=W+fQCA/ahfm6tr8thbtfQI7PUSecIxP7F2SyHB6qqJr0qlSLJysrQIat9qAtAFzerM1ZjujDCOdYI2XQQLD0WXBiz3y8sa7IiOWBqUUPWGAz500lmQRlMRatOVbzoQ8/ovZBZ7NgZkfElZr02UUJ6UbwFHOinJkX517OsTeYVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Psd2rbq6; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dccccd429eso34550416d6.3;
        Tue, 17 Dec 2024 19:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734492251; x=1735097051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFNeEwirO/h58hmP1aJdwpws+9vkTVfElh866GVv4Hk=;
        b=Psd2rbq6Voi8TTeI4tvjeFMb+O7QerrTLUqqf5nxBp/gYg61xvBKm+uAmb0trXT/et
         igr8ot6vXMXLJEt4Q3TlJmG/pWXkyBCnVC+L9L0JYPZWdbGmd/HV4bw0+i2XzRKtchg5
         Cf2D6wu6fZInALWNmFvlQmoUtkBsX7aPtAvtDl6xDFyhwW9Oasjd6ISzYEv8CjZDTH4m
         pVpMvrA09kVMFQmoyCw5ZMZzv9zkA/ZQSHj5Hr3YAvFdowyCzX7szN2PwlapRCUbcvA3
         bsO1XKeiQf7xyA3S3kXD3xqH0fYpB51WUiOOSiM344aH2Xl0jpPRlPu/h+MB1oQ5Lqq0
         PxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492251; x=1735097051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFNeEwirO/h58hmP1aJdwpws+9vkTVfElh866GVv4Hk=;
        b=aAsC1W8JuMXIg5h13vKU/2WgldOQNmdi+axo9BdhzIO2WT9TnWCMVlhLo85qfd9F4Q
         DkiOADRhhOm1kKivportgksihURXAIIumnVDyF0g6sNF7qeauzANw8pp/Xys+ot7YDGa
         cc+4LiiAWUXzyc3uJYFUXXfBv53PtY12RzKGWrsyzPRUVZ2xSvFTRUQ9jJ2lglsvTBX0
         n9CFzYWwR8CfYhI9avV6FHcOOLWjimx2F/tl3a9WA1lJM4GbVMs4ijqy+FqfvI957TRE
         csbsefGqSCQhSJumlKm7ez4tHGKDapt85lWgj3woOXl3EFPIkfL5RrAV6RuEt856l06t
         BPdg==
X-Forwarded-Encrypted: i=1; AJvYcCUDPvI2pqNAYjl47+daFEur2p855E1QZBhLQfdFw8W+XYVyXAf6Hh/ijxFCWRHyRtl8KeS4fwfTKmmPJ61crgT/@vger.kernel.org, AJvYcCVZs/U8hkqdud1ffaccZmdYiyaKqY381sNrgop819Z+nzfpib3WzJ4vfo872p9usl0q62DpRMLGLOv5WEHl@vger.kernel.org, AJvYcCWjw453rxuG9KyJc+KPO+SOrYBPvilDglBChWh8z8dbA1qreyPk0LWS+eZ2melPwBbRYes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0WAdDbeI8itPgYXKW+R4B6L848rqswMmoLZXIzESFzW09Xhr
	LsuQUbVdjZ1q83uAMpLmEIuEN4J3kdDIEeGeLxdnNcNH4BeMQ0E1
X-Gm-Gg: ASbGncsVstEx8pa0MSAsfmIuvmLmvGif8Or7VMRGbi3hY2bHpSmsNpD9Aj2Pe58nCX9
	ynMb9iO4LDmxj4XMg5o1UCpeGtaQ4r63FB4ffTl898cpD3W88eys40gBmty1XMFyUDGB6V5js9O
	YQ92ruS0jbG/0wfN47Ry4gkyhRGoiJ3G1WcLLEULMMJnxzc2CF4bL4gbdBnF3gQORH27oo3wRL4
	znczu1zouP09BDyLq3D3bbVQzgxJSaavOAtrm+NhbUg7ILFtwwvM7dmF69qCuqS2iKu9Lswcc5b
	V4EremZAWCejBAEiCi68zn8EorVyR3A=
X-Google-Smtp-Source: AGHT+IGylr/Abx7AhqtBcEoi9bv3r0KgSCW8USByO4qXDCg3XZkgy59Wgjeww/7i9s5Jn0hmg4JGHQ==
X-Received: by 2002:a05:6214:194c:b0:6d8:aa04:9a60 with SMTP id 6a1803df08f44-6dd0918c15amr26922756d6.7.1734492251110;
        Tue, 17 Dec 2024 19:24:11 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7b7047aa6bbsm381977985a.3.2024.12.17.19.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:24:09 -0800 (PST)
From: Matan Shachnai <m.shachnai@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@gmail.com,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	m.shachnai@rutgers.edu,
	Matan Shachnai <m.shachnai@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf, verifier: Improve precision of BPF_MUL
Date: Tue, 17 Dec 2024 22:23:33 -0500
Message-Id: <20241218032337.12214-1-m.shachnai@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch-set aims to improve precision of BPF_MUL and add testcases
to illustrate precision gains using signed and unsigned bounds. 

Thanks for taking the time to review and for all the feedback!

Best,
Matan

Changes from v1:
 - Fixed typo made in patch.

Changes from v2:
 - Added signed multiplication to BPF_MUL.
 - Added test cases to exercise BPF_MUL.
 - Reordered patches in the series.

Changes from v3:
 - Coding style fixes.

Matan Shachnai (2):
  bpf, verifier: Improve precision of BPF_MUL
  selftests/bpf: Add testcases for BPF_MUL

 kernel/bpf/verifier.c                         |  80 +++++------
 .../selftests/bpf/progs/verifier_bounds.c     | 134 ++++++++++++++++++
 2 files changed, 170 insertions(+), 44 deletions(-)

-- 
2.25.1


