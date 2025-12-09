Return-Path: <linux-kselftest+bounces-47334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B393CB13CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C7B30FC298
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238430FF3B;
	Tue,  9 Dec 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Got1IYJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894FA30B510
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313582; cv=none; b=M4OUhkRQBt04vlQDv0fCq4pXprNxNk4HtM5KgcZj8kqFoMnWvrA87tY3CJcGEC5szKsQHK7V9cqZxnUnRcKMBLgh3wAIdWu8v68MmKcZ2oXODpAoKhU0IrBhok8BWDdhwFLXdBtT9nwqVQ+vGV3QQOnjshkYNyRYmKAZi6EbaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313582; c=relaxed/simple;
	bh=cVZBJahaKSTV176PZqkKWritcCQlQjwr4hNs/Lq4IcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jtphGOd71MGkBHl+wyw+ORK+ClnVBrPFRB9utPD2zYlvQxgo/kv8lrMcHbpwa9qB/C+GV/Xf361lD5jOpepGfPp8V3wAnGUnaz/kEewuXQmzPnGW3a+aBV8NH9Qz8kgkPqOddSed0kc+dkCqqHs7SWWSVrnN4pQPOhHBl+La/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Got1IYJO; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7cac9cda2d0so1402853a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 12:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313569; x=1765918369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kv1AwMKfqms6xWA28lythBC3EJWNFQ3+8EnRHrSdP2Q=;
        b=Got1IYJO00h5P1davEuycOm1UGjFyaMfrkPpm+u8Yz2HaFfRknONhttZReTLHMJzQs
         +T2VLVmumTKfCH6H+8t35C84qWr4M2Jt8q/DsfGaDEWl+pPStGqIoBZySY+8M1OfCJ9Y
         mH40ttQHMV7PgmfkfoC9kYMRTY7DhSSUgTIS32/c+JHArl/b+ma/De+fN3jAhagbTdmD
         z3tl4dWaAQAHQbEb3RY7q2Uvr+JY+ZsKIFH1TTvwwlEjEaO84D4icqoEEqgfSYJXK2/V
         nl+YTAJKwtAgfKrHbhxQAA6WNb4chr/I0pOC+0r6FPMf9D+zyu57CBfinC2VjuRaGARb
         MqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313569; x=1765918369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kv1AwMKfqms6xWA28lythBC3EJWNFQ3+8EnRHrSdP2Q=;
        b=WW0M4u6J9WJAwvc4rKVHNIcPk/zdgtPfqRP01xe8tUmjJLhCzkBwMlAsTez9cJqEs+
         WXoWPVJjS3RjOLfy1jqR2sUSGWMI6iTj7fQEJgBNWxqTgO918sQ1Nol4YZzVQzVNI9KI
         PtqPSVdK0YYxlAyWseKyk4RpA9anM5/yHPweMhuwDpYrJRlovfcsZdTg+Z5oh1aVMsef
         CtTSxXM059Hk3p/3ZTT7cTQdzQeCm+ia4FzYoPtm9AXcR+eTSNlnAKgrSLDlvckZ2KJx
         vM+LIw1aPJaHP6qUiN3Bx1fRVIQjZu0jSUxTv9hYQJZ2/qeNHf8urBPuMPE+25ImpZP5
         luyA==
X-Forwarded-Encrypted: i=1; AJvYcCWyWaQR6FWYrqV4ElxWa10hI/NdoktlOJZdDXuaxrvpbwGIHNN7s21IYRUjZu5N2D10KyTQqLRfuKTv0OC5uKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+kP+Kmv0As9A7zH+nL/LbAoU78TL6Cl00hkSMuns8TRw8PfW
	0En8ItjyUPWTgSWwkKvK92zTK4MVST7OeUuT9q1/MW5dKb6up6k56Ar9xGLp3DVbleRJTL7ndI4
	BsxPlQVHlUZomjdxg7dSLeFXOaA==
X-Google-Smtp-Source: AGHT+IHsfvWbHL/8tFP4Ochtqb9Gms3M4fhZnid/Y2W+XVpjJijy4/NNK2sgiQPwkhfDucK/Gz477ZQXRQW17NPhgA==
X-Received: from otfh13.prod.google.com ([2002:a05:6830:224d:b0:7c7:6609:92cd])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:2685:b0:7c7:5f6e:f26e with SMTP id 46e09a7af769-7cacec2e507mr73093a34.24.1765313569578;
 Tue, 09 Dec 2025 12:52:49 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:20 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-24-coltonlewis@google.com>
Subject: [PATCH v5 23/24] KVM: selftests: Add find_bit to KVM library
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Some selftests have a dependency on find_bit and weren't compiling
separately without it, so I've added it to the KVM library here using
the same method as files like rbtree.c.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm   | 1 +
 tools/testing/selftests/kvm/lib/find_bit.c | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 148d427ff24be..f44822b7d0e20 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -5,6 +5,7 @@ all:
 
 LIBKVM += lib/assert.c
 LIBKVM += lib/elf.c
+LIBKVM += lib/find_bit.c
 LIBKVM += lib/guest_modes.c
 LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
diff --git a/tools/testing/selftests/kvm/lib/find_bit.c b/tools/testing/selftests/kvm/lib/find_bit.c
new file mode 100644
index 0000000000000..67d9d9cbca85c
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/find_bit.c
@@ -0,0 +1 @@
+#include "../../../../lib/find_bit.c"
-- 
2.52.0.239.gd5f0c6e74e-goog


