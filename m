Return-Path: <linux-kselftest+bounces-31344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A48A97478
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0C83B973E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6482973BD;
	Tue, 22 Apr 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiTAfIyg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948B283C9F;
	Tue, 22 Apr 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346227; cv=none; b=GUH4YL8eOKvL5Azmliop4ilsIxzCcDxnKW0+h8Q40LlI+fnFISTqa3A1EURFyfbNMIafhGKkeYkCYv6YMijG0tkhZu/FaRdpkTlOrh87m8ZhhDK1Sc9OI7/Z1cKf0QxlodHv9VrXfiat3hA9qLeQ9GTgCN5iMWOrFK5hAnHEh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346227; c=relaxed/simple;
	bh=Z/1vCzlj2/D/r6wL5ZfrlT39ra+H2330JJbpjgDMZTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNDcHEVq3CWZIBPGiOcMDFRYnpMm29wMN/Z+De/nH9EnEUyV+rDXFdyboFcmc3OfR+/7EgDa7sHv11vHm+8YDyiGifbdWHZz6I0rvCAc46e2dsn4Gdalp489rqfLhaKKBgR4Nx6K+hDwVh8V6xxKGAlr0AcCPpU/Z2KjCj/cZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiTAfIyg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2254e0b4b79so84001285ad.2;
        Tue, 22 Apr 2025 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745346226; x=1745951026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hQgTAxdLo2w0MTTOpuUp7zAa1il5ojmf6ztbr/SCn24=;
        b=GiTAfIygOoKcJY1ZzMY8PmzXYWNm/lK1FLSo2r/u2842Sknig0rn5wVpbh34SFlXfW
         heIwa05EPuoM/9smeJgCRjGC/7Dm+9eK62GMIyldjIxn6/Db3Pku37PxzHQgH9P6F+uf
         /Mui+KWzP8y7PQMJH2KTjI3nlb6O2Kyh/Uv8DQPERqvi8CM76v02DbDWxIZwymQshK6a
         fisTPDj/ieIe9IakFvPbN8rpf08xjzssjoNmQW74ylw+7t5SrFqsKJFVXM06+LTEcFW6
         s6A0UCBQ7Oagsbl65Ynt0ykN6ZiJ+VbT+lBcWhNtfcTO4YUsSYRGHaAYP3mpBgxSR9EL
         3DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745346226; x=1745951026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQgTAxdLo2w0MTTOpuUp7zAa1il5ojmf6ztbr/SCn24=;
        b=YRA91b+s9wDJuaQJQdsCpdxQ/zPEaH6mbM9nOFXhHHWjo/mYCHrguAFtJ3noqY9UEV
         nEx7IheqDXKm9D2g7aiToSYfDQXcQlPXdpbdMjST6+ZFlI26DuSQAZPtBJZQeOeEXwAW
         pSNLE69eyMHhUpFcP9zhbeU1PXYYICFHAKYPBBOJN7X1Ke0fBNi2XrFZv5uQ7gbpFqEO
         zxV6fICOGgn+tPCr/jkBciirMfJEJwg+Bgas9aDEioyUfznEagIet3XtVbzMzmbrS8Ug
         KC+DUOu0ZWnd860VSY/5HuZsXj1rtNQFWeOG42aGeEfcrsH6fCGM77cXsfnrpC53fm8Z
         NzeA==
X-Forwarded-Encrypted: i=1; AJvYcCVK3wlskwB/GcMy+B9VEQX/vIJ3zR7gArSJjx7Kq/YB+mn8uP7/qZNZiE3DEjAwIxG8Rd8=@vger.kernel.org, AJvYcCVz3e3sFtKGGf1HhVpMW1LgLWZAu1r6gkEV8eFsr9zh3BU0+30EjdD33538P2lkCTPURSZXOkEQfOAucVk5@vger.kernel.org, AJvYcCWLUnDh0Vxo+nB8ONSZb1BixulG+x4dho1PgS8xG3rax8yKgGVKAcXMkTAMscsv7a9k0Xj/j2piF7aI5Nu7OwQT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoc/1fIXq7clcr2lbTbVHfsKvYvg2m1kkqXXJFB1Upcjh2pl+F
	OlZSTymfJ9aNCuZtjWjDL7x6z3aXTXSPMxsBUZ/UgHmyXuRb4Df+
X-Gm-Gg: ASbGncsafNjk7tm5KYfLTSt8YKNUi8LR0AoPg6ihKzZ8sza/dEAE/BsuUC0JH1T+hBX
	zoYOF9ri0lQTea33DyukbxyRGG/bQH0t+K0c7VyTki2ufk3p5niv2wzJGo0EzNka7+eqBfcbVgb
	DlxSadEtEULEiDcGUF38t8tN4HL2dFO+l51YsyNAJWxu78jFRIPE5562Dg1RsoMPFc+RXwScdB4
	ZNagWhXT5/Xskssk6vW7Q/yfuoHw+vzdheaJ3d1tnqGMOB6x97yYXZdtZclVMqBl3hpkWlCflAt
	/j/N/jWE09fdZCA2KeJLZ1YrDCsxQfWkV2FHPhL1g3E=
X-Google-Smtp-Source: AGHT+IEj2yElv7S+OtDn6fj50+VwciUKjquK168mw1EyDz48lDwHksHN7ry6AtQT0gpO588nDSMHwg==
X-Received: by 2002:a17:903:2349:b0:224:584:6f05 with SMTP id d9443c01a7336-22c53607668mr249398665ad.41.1745346225666;
        Tue, 22 Apr 2025 11:23:45 -0700 (PDT)
Received: from prabhav.. ([115.99.163.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb48e0sm88620045ad.155.2025.04.22.11.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:23:44 -0700 (PDT)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix null pointer check in skb_pkt_end.c
Date: Tue, 22 Apr 2025 23:53:31 +0530
Message-Id: <20250422182331.1188338-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that 'tcp' is checked for NULL before dereferencing. This resolves
a potential null pointer dereference warning reported by static analysis.

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 tools/testing/selftests/bpf/progs/skb_pkt_end.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/skb_pkt_end.c b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
index 3bb4451524a1..db33ff2839f7 100644
--- a/tools/testing/selftests/bpf/progs/skb_pkt_end.c
+++ b/tools/testing/selftests/bpf/progs/skb_pkt_end.c
@@ -45,10 +45,10 @@ int main_prog(struct __sk_buff *skb)
 		goto out;
 
 	tcp = (void*)(ip + 1);
-	if (tcp->dest != 0)
-		goto out;
 	if (!tcp)
 		goto out;
+	if (tcp->dest != 0)
+		goto out;
 
 	urg_ptr = tcp->urg_ptr;
 
-- 
2.34.1


