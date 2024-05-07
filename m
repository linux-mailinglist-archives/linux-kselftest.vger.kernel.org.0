Return-Path: <linux-kselftest+bounces-9650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6A18BEF07
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 23:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3137B1C23D31
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802616C6A6;
	Tue,  7 May 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b25Je7L2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE413C3D9
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118299; cv=none; b=q5N/BLqTtowU1DhEgHTbUgVt6vy5iEKgMG7+TBLC2ZfqgDnJ5w51fQMuZOKU4Ot4LbzpEbJRrfQyO8RPz1jHeAhMMlcPO3XLau+YiigOoQG+cJV7uhchax7QePqjXYTQQYcGn967tAh2M9s75r9uLB17+q4e/0NyJHPlwqnjyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118299; c=relaxed/simple;
	bh=uNS5SgTdf5Lqki4ZbkJSsqctuLHtwyYyPdiI8DfFaoc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qSGnym9TrfInM00w9bRHVfUhhEH+6Rac+2fX5owHvh1gCo1c+hr/zpf9VoVF0K2iRcLadZv/5wMi7HRvLSYEMYdMEik3bcgk6IAF6CmMyXJc9YhkLbPJR+HCPgUO/kFiapBTY/R1qtc6g4HRPxatw9gXRf4D+nZLnsIGwomaZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b25Je7L2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bea0ca5e2so66669437b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2024 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715118296; x=1715723096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLG6gbZomB6DmPXjYL98l5fNcPQGk+fw1rCWyau0VTc=;
        b=b25Je7L2Quzfv3n/I6HkRWZWcA/958eViIpE7eBFiZOQIEdBVFejtYX6J7JOcIj8GQ
         W32hZpavJhwVOJcxeSFosJx/Ov0MC7KMyzdIV7Ahu3E1dPNZRHIfxOmzzxb2qX4yDXSf
         g6TzlrTztE7gJwArtUsIdKTACHu5VfSQQ0A6u+D+1SiRNKf08pufhYA0sXNA3/qXedNM
         TFtW2e+lLCtgIhQMT9C7oWxlGCFN8tpQdWpvapchtmLGdk4HJgZkIzZiWlmAapXiFahC
         MEP3eSgvRLnClvgynwYzfsSPzqg6hs7iP4WWY4O7v7a+RgETr2XXajQ9RUjo6NWc/nzY
         72AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118296; x=1715723096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLG6gbZomB6DmPXjYL98l5fNcPQGk+fw1rCWyau0VTc=;
        b=eUQuDSNp1oXRI4xH3UDkMX7iw+wwhQhqLM8VaRAkFeaa3eScYrB+ZT+mYwxCd/vUbH
         7s3NHzrpuJnzB88nelcCRWfIRb9BCtYfYoKIdbG0bAw4nGCPMk3mN+SPliQg6eYYsiEd
         16R323jPLzYOXOSaDHiuFrGm16H7J4hhWMGJDg+v78MTDRULNo1Ac9y3YPOfA0F4AVU0
         djRHJG3g1D7ZIwlC/XhuEEuSuxpZRjO7KiijdwV4w48kUqN6hOXSQ6x9AWZu9furBIzx
         d4D945g/dHs7UTXYvcIHe2ctIvTdGaGwHKU16W3dM+vg4vPpJ8/u2Bm/ROr1DcjZgTFy
         ebsg==
X-Forwarded-Encrypted: i=1; AJvYcCW4PTXf6/vgdq3dqxvWCMw2XS/EfwckR38x7+yr2TGGKqty2r/niyrn0xhvi4blC8Y5INrhDfGQ24Gd849JAXG1Dedlxes1DIsKrfc856qA
X-Gm-Message-State: AOJu0YyditypTV2ltCiztOFOFR1qL+2tV1G9MsJZ6iwJZS/xIdf6nTkx
	ChEciQ9xTyEpqCqAAtlV4lke4z0ofQibadfc1jvhByllOk3T4mKfQ8ngn8MRTHEUmRankUQITei
	IWQ==
X-Google-Smtp-Source: AGHT+IFDRufPRd20hhB8IsmwhuIIZ1gDaiY3aRkAgAGU63hP6Y69UhIvyGPjEABNQz9R7M3kyPQJ53ZX+tk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:a189:0:b0:61d:4701:5e65 with SMTP id
 00721157ae682-62085c5c5fbmr2405797b3.2.1715118295730; Tue, 07 May 2024
 14:44:55 -0700 (PDT)
Date: Tue,  7 May 2024 21:38:26 +0000
In-Reply-To: <20240507214254.2787305-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507214254.2787305-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507214254.2787305-2-edliaw@google.com>
Subject: [PATCH v2 1/5] selftests: Compile kselftest headers with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Seth Forshee <sforshee@kernel.org>, 
	Bongsu Jeon <bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-input@vger.kernel.org, iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add the -D_GNU_SOURCE flag to KHDR_INCLUDES so that it is defined in a
central location.

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404301040.3bea5782-oliver.sang@intel.com
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/Makefile            | 4 ++--
 tools/testing/selftests/kselftest_harness.h | 2 +-
 tools/testing/selftests/lib.mk              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654d..ed012a7f0786 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -161,11 +161,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
+  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
+  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d98702b6955d..b2a1b6343896 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -51,7 +51,7 @@
 #define __KSELFTEST_HARNESS_H
 
 #ifndef _GNU_SOURCE
-#define _GNU_SOURCE
+static_assert(0, "kselftest harness requires _GNU_SOURCE to be defined");
 #endif
 #include <asm/types.h>
 #include <ctype.h>
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index da2cade3bab0..2503dc732b4d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -45,7 +45,7 @@ selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 top_srcdir = $(selfdir)/../../..
 
 ifeq ($(KHDR_INCLUDES),)
-KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
+KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
 endif
 
 # The following are built by lib.mk common compile rules.
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


