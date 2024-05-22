Return-Path: <linux-kselftest+bounces-10532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89C8CB7E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1201F29885
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A07153BF6;
	Wed, 22 May 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMSiG7N9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA1153BC3
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339709; cv=none; b=YR14/k2Iy3azY+gRs5Q5of1jVuVyBu6jr1ORT5w6OBlZLh4elLDf1V6jgp/tf11f6tCqORsLlTLmBNT+o46F5ZljaYrK6MQ+v55QwLH40ndWOHbZfNUiIA+8vH5TK1kILBe3qhg/NnK1cYvjKVeCV+gAannTtELQFA2y28qEx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339709; c=relaxed/simple;
	bh=Zy+x1uRprdnX1Tlrv8ZyVGm6ZAlOs3M7f83fVZKsXqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHMDvH56UlJI80T7oUMUjs567IJzob6bApWmnY+zqnlX0QQUDtDvrAY9YuLQp5JeCz6h9GZwL6UQ+rbg2a/IulEMtIM9y9C0gG4NPLPJ+GmS15nL8HVkHhgYw6gPEUft8/7MzJducYrnu4SUQmRwKbNH5kfhNbWHJIYDXgWxTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMSiG7N9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f2fbeba118so30879135ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339707; x=1716944507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1dqiMTNBgzJveM+1U2NKL51RHxmum4u5pgeXNwn+APY=;
        b=DMSiG7N9Vx2N2aLHs7pKdX+UM9nRKSI2SRAXwfTF8VvgCG7vmSYeuGBFpKseONTkly
         xnhWF5U7VrddZEJCQV0We2gKBLBv8lBfSLasG8whRSjEYUwOuGTosP5xYUja4qatAWHC
         lyesj0KwYyDzu7Rts/PhiZOLQheVAvHMdzWnG9iqwrWpH1rcEEZrSXejcbIwxgvpSePh
         1d3+1PYH27+QoNZ3LEj+VvxN9d3YfTDQqS7PPSkoqJfEsEIzgGjMRNK4cNeKLDi1oBkC
         8t8JK+ntIy738B8VB4/p/4dpFbzBeYYfOMs32dsuvpBs41kK1vx7XM1T9LT5s9cbw8NV
         L1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339707; x=1716944507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dqiMTNBgzJveM+1U2NKL51RHxmum4u5pgeXNwn+APY=;
        b=mywSpZZRztcyLDGQ2BAfZP8qrcJpEubePppMX3dOGObJU4MWlm581w6MwwBrfk+2jk
         fxORTaZGsI77Rz5xVD64tZeyG463a38H8nDw3gc6IQgfLpfjceCaMNA90h7c2Gi1xrpb
         JRdDs0wx9QcDibB2OknM3gprFblxmoh74T1Y3MVYf2rGHSQkvk45JOU68lbQ6eUGBqt5
         Jcf3bXbiCxSFM4miEyvG6RHJtCPqWiuGg8IOXsDeb8vSoJokmlEi7lBSm0lP71KJP0JG
         GLjjXBeepxZuOyJlU3haMGrcS64xwEB97oda0XtJ5lbDcHgkkxxqYXSy4fw9eBzLExi1
         VRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcOogKgT/5i+H/nNz2Ucy/S4W6i4S/J57Ula/0SEt1QI/71U6NwsCoc0uDrG0ZjYxxpt+nVSRTKAc6E5t4AyiqO/ROKcphyL4V+McWmzsV
X-Gm-Message-State: AOJu0YwDNEvFrNqEKPaxc9Wp8rY7hRFQG0bDHHKR3TgyRYWePsyubSpE
	2t3hBLY1SRBuYW7V1C3foyV6kuqLPGZaQZWZ321RfYdKQCBmH4igIa7vuUaS5o6uRwfTpOZuSw6
	GYQ==
X-Google-Smtp-Source: AGHT+IHx//11iRXfF9jU7Y+WwJe3/GdLuBAfz6WDem92qdspDh3/TEq+7NzW8GllbYjjYjpp726oyFnk0SE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:22c4:b0:1f3:aeb:321c with SMTP id
 d9443c01a7336-1f31c9e8135mr338475ad.13.1716339707160; Tue, 21 May 2024
 18:01:47 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:31 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-46-edliaw@google.com>
Subject: [PATCH v5 45/68] selftests/proc: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..f92a8dce58cf 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -23,9 +23,6 @@
  *	/proc/${pid}/smaps
  *	/proc/${pid}/smaps_rollup
  */
-#undef _GNU_SOURCE
-#define _GNU_SOURCE
-
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
-- 
2.45.1.288.g0e0cd299f1-goog


