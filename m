Return-Path: <linux-kselftest+bounces-12582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F59915A7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097AE1F21ABD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DA1ABCC1;
	Mon, 24 Jun 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiUnGhmx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01C1AB36D
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271760; cv=none; b=ZGLkAi/Ugf+QtcIx0XJ5pKs3GpZfoxM/63s+z8MbnPQtaT+G50FmBu4K9oMFM/I65dx0nae5FVqeUCdedxYhpzf10o8/x4D99tFCavWdLN6ApIeDl0OUDxZXWlhJCzeRvYSqgnKzIf6yjwHGgGDK1Bu2Jcye/8NvR2xrln3iNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271760; c=relaxed/simple;
	bh=pWNExpY/MivG68WT1LbkW1rwtOz84qP9M9G1/+5QF7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZS3+dSA6eQlqQhQYPxToXjeP/FOkGgeLjvxBsAI45g9KbefxSffmK/z7o3xX8pHkP3bqeJkAOtHlW3gOdaNZ+1cgTJugh0RDeH7Q9tezkTtJDofCoad4qV/0isz3eGFYd9sPm0f+g3fa68QNKddTz115w3Elg/UMsl1gmNiLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiUnGhmx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c559235c6eso6427257a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271759; x=1719876559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdSDNYLWJB5rZ7zGFIgNmO8T8+rT5KpGbZz7pQfLV3k=;
        b=kiUnGhmxP+8xn283Y1uWLIy4YUf1VPp9upceJJQpng11npk8ZLAcLW7MR1mf1lUI4B
         IFH2DwZs28F1ljW99sqswwz6X21pGT53nzHpfhHpRsEal6EPpfDKMDedV8i0hzky4mZP
         1vgZ0rRXaTSCek0xBsLbIqcW7euQwDdFx9KPACfzeh/AAzdGf/KZxYYJ99A2OnKCD+bL
         MNcKKqSY8cCSYb5GUO733joCCapmKcvEOqnh7limvZqfVTaNgS9Tusv8dm7I8iqr7otg
         5X8fdDIBGSbC5oIwOOZzNChC+4EFC3wolmy+G9A3WOAhen3vDaTtwOuJwtV6VxNCyoSc
         A+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271759; x=1719876559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdSDNYLWJB5rZ7zGFIgNmO8T8+rT5KpGbZz7pQfLV3k=;
        b=Y3aXYwFAiutR+nJlyZqCSx/t+rMjKIZRbVWVFqt13Q1BXYuOn1ALSZH/JJzRmm8n7N
         0DUa91XSTeZrV4KB272jdbkuOr96OFBVxqllJPnxuVFtjaT4F8xm7C5kscRa2jXk9K3V
         ehVlL2oVBgfYIRpjGMg37tVayvSsU33ERgf+mLsKMFvBh6zhToIK4pAmCEeKEtHNPDiR
         lEEwIYZu3dM7eE2QmdMfxwKHWzDiAl4SZ+TjyNaW/O9Ei/+ouBrPUHlVS9ewGX4PBOqg
         3SCwnKYXy8M7Vn8EKwCa1pN1wDI0u+sON4xdBi7G+FFW9DBgssrU/Ns1LownccwQzb95
         Iq6g==
X-Gm-Message-State: AOJu0YxtZMLT/79PrQm15lVNSWM/qa3fsSV16zNIv9AfAgmL2bdwjGrB
	DXJNCn1U+UwraHTJkEAxMUAEQZRiqHPNr6u2YuP9hDOob22pVfULyCsuMPnM2dYonjGkciRvbYX
	r0y2A9lXmm/dyG5HAIf+La8KeLnZN/lfgmnInnqrd1qyTMqSW6TYPsRmjHzCYuxPredo0/TzEzq
	uJl/Fltl/tjQva7b3heTbEnp0NzCUPE9zpqC0HIkOWZYIC
X-Google-Smtp-Source: AGHT+IGHwhaq3SpDsE/oDwZF6fJSdoqdJu1qur3CUdYhennVxCDTZQrp6vr5HFtn29b7yImBHRAcKRn1tcs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:3d43:0:b0:71a:1f6f:1d0f with SMTP id
 41be03b00d2f7-71b5c3db10amr17532a12.6.1719271757877; Mon, 24 Jun 2024
 16:29:17 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:13 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-5-edliaw@google.com>
Subject: [PATCH v6 04/13] selftests/exec: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index ab67d58cfab7..ba012bc5aab9 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 ALIGNS := 0x1000 0x200000 0x1000000
 ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
-- 
2.45.2.741.gdbec12cfda-goog


