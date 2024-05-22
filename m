Return-Path: <linux-kselftest+bounces-10552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 144568CB849
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BE51C20C29
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180EB15CD64;
	Wed, 22 May 2024 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ+xhW3X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC815B99B
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339760; cv=none; b=omKZmnY3V0UBftvUkHaifeeGknOudQ4C1e6S1UNYGTLUiDJ7YFqwPuC9jBsfNkUkFVSU98ZyuFcnYncTcR4QicZOYJ3yY/ULeOdUvDcKME08+4a9nVl3+3Oz33F8Ge9n0aDFvnJsWNqPoFu6es+MOnnUhy99Q6SFOZDlauzOVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339760; c=relaxed/simple;
	bh=4TJ9KnGVL7+630dLfE+B26mDy9GQEt32Ng1AK59vk04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=svU+HGVu81B0EXeGcEzqNTItGRsKaQ5iZE1ZRuGxYGtahdScrEFFWnX76CdBozv9uBLhGUurYrP/owkAJoJhK++EX3Q+uA/Gc1N/WxDACT7+8x5MIHVb0U3RBZRlA2OSBLoZ26zI6hFH0xF9ndnniF5yOMW7HLyDQFlosrGzHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZ+xhW3X; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so12785570a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339758; x=1716944558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EY5v4vW6zuGUWHn5v3Q67qpIi54gAcWCg0e6EyybCAo=;
        b=bZ+xhW3XF5p3WUl6h3YDmNelPNKHBtgynK7HIuwayLHp4DS3jkNIYQkCLcQe8RGjVU
         DW7a3+HhtbMjWvbI5wHAgCoH3YWEAkhRDE8r2JFNE5mhNKReYC+WW58KJf0L/9r1SbYm
         Kl24t+i2Pi4FCm/8IXLxGgfLTyUcHKVzw8l34BnhT3mFkDXUTXPwHC4XTSPBIWRbVGEf
         v++KLTreaJR9jV+0haHcRMDJYVBm7k+732cD7IwyZgLfoS+uIjtm7i031p5HAgI3x8Cp
         ZRlJYXcXgI0ow/0ttMK9wjakyy8MS8sVj0HiD3n+TGwXO0NGkO/LQJkVKR6fT+v7V1VH
         kXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339758; x=1716944558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY5v4vW6zuGUWHn5v3Q67qpIi54gAcWCg0e6EyybCAo=;
        b=VzIcvwRtHV73PRUvz4dHbpnjnAeBUKOqRQ4H7WR7Vol81dMCL2CBy9pyqMMLdhwcS/
         OyzQ5FvMf9luCtRJFWjUUsZNlDJHYzJ//ESJSPX7WPVwbAAdpcXla6khnrcxhkyxjEVN
         vfz54jPwZo87RX3PxbcN8GESQpEBj59LQwjspGcUgwvTK7DZZIK3ED4LpCj4usdEvMN1
         nimdj+c5adraKAxrfXXFc8ao0C0uenf8TZhdAi9r4tKQlAlJRI2eMIgBMZpQ13imfe5z
         motx5PDKwVhYqCmp/JxcAvtdQ/dVI4g09ldNU7lVBB3Vi0fs+WRHiE2HmpsLq2AEYEm9
         lMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZWHIncH/JORrDMLag0k7CJzsOnfVZ1DF/KiXKwpvz58TGgLd+BSSRoCcPuVEkY6V87Kif+Ff6H599n+Uy+SZupxHteAwsQ0UTo4Xq6Zh
X-Gm-Message-State: AOJu0YzNpCPY5DrcCsk3hlf1HJ0+wyHHJqD5PxdUfISFwFse5I4rcHnf
	tHV12l8C82zNksVRa7s9zHPx/CREJOjKwLXI05hRfk6cVFBKGCuyCaHzzPdxisEiUW+pKYFY2Da
	Rzg==
X-Google-Smtp-Source: AGHT+IEx273+qW/DV4uOgH8Knay37/ukzBb9Gp8aRj7jknrJ931FW//nLLnnBAL0LEjWeDb8f6l1RtSdL7g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ecc6:b0:1f3:82d:95c0 with SMTP id
 d9443c01a7336-1f31c9dc851mr382085ad.12.1716339758083; Tue, 21 May 2024
 18:02:38 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:51 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-66-edliaw@google.com>
Subject: [PATCH v5 65/68] selftests/vDSO: Append to CFLAGS in Makefile
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Instead of overwriting the CFLAGS that is imported from lib.mk, append
to it instead.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/vDSO/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..fd36979435b6 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
 
-CFLAGS := -std=gnu99
+CFLAGS += -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
 LDFLAGS_vdso_test_correctness := -ldl
 ifeq ($(CONFIG_X86_32),y)
-- 
2.45.1.288.g0e0cd299f1-goog


