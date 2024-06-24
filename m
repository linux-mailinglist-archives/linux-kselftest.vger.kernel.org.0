Return-Path: <linux-kselftest+bounces-12590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0ED915AA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044821F21B39
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D4F1BC070;
	Mon, 24 Jun 2024 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xL6REk6U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD11A2C01
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271805; cv=none; b=T5itRO289Njd0ZlyQU4cIT25KVov/ufP6ryaTMQXMwztGXTFx3E9b5bwU6utj+3C1t9sv6Kt1y3xHEIye7Chbw2XcZOUngCFFjzmbdOTL/4ISnqSv3HY6R3+jBTDLMtEu7w5XSUrjZSsARlx5mp+FQCCSaicZjIrSqRwN7dNx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271805; c=relaxed/simple;
	bh=HKl8DYXudRkj2nEiXmQj8vs+8XvlCafs7fYfuFr5khk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DeJyRPigBFRrN9+Ru6BuRGb8nYUGAvp/9qjpv0eNrmFR6Dy9LdlsSBAG2tmCCYemKVvMyobecc/nQ8BqWjHzIyu1xVdRlP67RD0zq/c8NxEX8AfkzFzbUDup+05WBoIjuvu0b6b/NuSvEDmi/zE0muhmWON+1rg5Ym/JilQpi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xL6REk6U; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so3896025a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271804; x=1719876604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=xL6REk6UqBcxaXZ7cFQ3ehfDVC9+jhA/Fym84uuhJw05TLR0P6Q/Ba+pDfVZpWvq5j
         nKpgi3uUEZC5XQJY7M0TIsOPxZDlgR/z0pr4eFLaGvwZOcrKy3H9QoHb92m1t+EJhplM
         qXlIU1ISOvjfglD3m5q9RvaodeFquBhHl5bOZ6NImUvw4edbBFFDL6vYMhciXPhwBA8p
         w0aSFU0lXYihMIMQgNBDGjGXxUfRCquLc1UCHdXezvi7xiixaME5zBs0fwk6EF/wGmCe
         AW76rSmriG0Md4zvuuFfi9Ri0Qpq4wC7vDA6iBAWj7rzCoTeR43aWMvNxOi0Blbh1E3y
         0fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271804; x=1719876604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZG4i3dx3G3awn1LpAYu9cuCTYByH4EPhFHcmFTw+5I=;
        b=YpafKd58Qyq5UTxYWogNU7VqGbstSORdEXRuFAQ3T/HQprM7jInerknPa7EdoU9BNe
         6hnBOyorDy1CllVQUFiNqWG+fs264g6kYwoHOWCVpEsn+fyMvmh8UHe0jkH1Sl5dAM3K
         5RIdcBHy14vTktM+6PIKFoX2s10N6dawpeaQ171Axn8zervKQT55bI/Tz6co0ryvHXbj
         512K87ZuzpAIOQNH7Zw3To2E/+YTYRyxBLPClA4qHf4Le+A5Qp0qyzH9ozgOorRtUCXF
         TyzZqQ0keEY6eygEROMeaqi5/j1HySmaAyp/V5nyDJsYjCfWBGfd6CdmiRAFdrt48RQn
         DwsQ==
X-Gm-Message-State: AOJu0Yz0SAXKa7h8IlT9ASQTxOHdNy7RWBlFWoSMtHw+Y8pYY72dsfyF
	E26+8YK9XncFGE7eMs6BVyqgKld5MlPYtOC3afmjxf8aeI4+1Hic5pXV/1Y+ZU0i5TCZ6HUshHX
	kAKdovLT2yUMbsQwML4Al7N8LIcbEB4CPBoP9F3mHcnloeR7OOpYdVHLTRJ1LLyffIL7WG1yeNG
	yPc0M8LKmTR0B1PJw35wAhXo81RjR/5StW4GQNZE3+/cCL
X-Google-Smtp-Source: AGHT+IEfb9KUh1OpOD8DwIk/54klv7dSo/nLX1YPQZQ44FjQ7tb2FCGqwu/ay8BBa1IDIHl2DafOvSF/pwc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:654f:0:b0:6e9:6c12:3523 with SMTP id
 41be03b00d2f7-71acda64918mr19622a12.10.1719271802360; Mon, 24 Jun 2024
 16:30:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:21 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-13-edliaw@google.com>
Subject: [PATCH v6 12/13] selftests/riscv: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.2.741.gdbec12cfda-goog


