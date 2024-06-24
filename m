Return-Path: <linux-kselftest+bounces-12583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39065915A7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 01:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79CD285E90
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70F1AC241;
	Mon, 24 Jun 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwTIR7H1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AA1A2FA5
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271765; cv=none; b=YYy4hwsweEJuo9563PSFocCUBL75iuQosPXG97BIb4T97jGfERU9FXjcd3LefEzNvSKlQ5uQ0NkHm+6uG5IOyOPRHwcbI6S3b9ZwdyRcmdinMJQEdMdTwmma7q4zYAkfj146vJH47t9MhYhbAv7L7nu0eIS/VVzG/vAn7ChzIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271765; c=relaxed/simple;
	bh=J8ziRZLZ6OEx+woE/eS0qKgArMtBUzmObf9KlKhPFtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QGggXUeewq8wWdeKNZHblTfhg0hDGyfCxnz0lKKHz6qCTOLX42ap4/ijKQil0JiTRj0PuewDvsKVTF8di8aOlJnkh6bU+FubwjAyMbGgTmraMos1sWtBVZO+Ts5c8V/I9sop6Bo4y7c/hCkRWLeN7c/aInhJ8SFF8n5UhacRqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwTIR7H1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7065ba27265so5056433b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271764; x=1719876564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fldosNIASu5foth+y++2astaddaovQjRCjbJvozT8Ew=;
        b=jwTIR7H1efPNt4w2hyVN/DZKsJ3SQIrjGzy9VE83Y+RaBBCau4f5hKBIc0sLsoRBU2
         WKC67vHOgMZk3E3m2qX3acnxdEala5uMw4X35nhRcht+kr+hpJZl2Ji0rGyHIYIe1cJr
         tM6ibNvjpNgLPN+OVoi9VKx0nnvv94dodMTC25Rs98A8KdIz26t1OLkOBjw3qoM2WspG
         PTtshNgJYjg0KCaZLM97808IIByl7psGX1ktzjZVx30oH/umXOm2t+isf4LbhTtpAY/p
         chpt5Cgebsx1x06MEGvE/+h0N31GZ6kloOitTVMZNDYCH2UFsL+VXjBxbXoLRD29cu5h
         OPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271764; x=1719876564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fldosNIASu5foth+y++2astaddaovQjRCjbJvozT8Ew=;
        b=HwYmnwWzCqpZbGHRGfiqUdl/NI3rozCaQT0gYZ/Z3xNW8SztNsuG7B6iNruNnMGlrW
         BmyPeMAc1kyR+4pVYvsLc4YC4Okh8b3OZsWQV4TRDUo+KKQ7boCLi59gAFczlmKv0BnT
         PnvVzguLK8Dx4syw8/gLiu0DN6GaD5SEusT3E4OxbgNoUrCJqAV7mRqzNLkz2Jsxr3G1
         yeNdae4AuybEER+NZ4M2OTd0neztekon0Fr65BpINaRyoVH/EgY6dN8uSMfEPIzW1CeZ
         aHzyIzp8VquHl/K5fiog9iNbUCXz3LwXEilwZSuwtGgquAU+RqgmWd8wBhavqxrAUwyG
         32xA==
X-Gm-Message-State: AOJu0Yxydk8A1LbSvzM1tJx6m1L/uO8p4otmLwrlt50//M4XE9kXq5xv
	BYaDOXKZXWp/NNUTXyupdvZJvIOJNzr1CH7rtV+lRxnMoLZm+UIiBaEZDKnCkYTca7MBa/PPZsW
	8FL1g+cCCgWfBiEI5+CO9MKxFYNDDDHpTVLb/sHnAp4nCCeRj2VSnUsiEKn5JuXX7dfpGFYdogJ
	kcDzgY4M9E5FO3IZ5HTrQPnpMOdlwZ7coIck1wCHMBbdqq
X-Google-Smtp-Source: AGHT+IHgIjs0ZNjmgMymaYfJ8/9bZ93vYmLowFGFa4rCwsJRE0/Jc/du7SfPX0zd6RD0YkkBKKfvO6Hly8E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:908c:b0:706:3421:7406 with SMTP id
 d2e1a72fcca58-7067454bf95mr299109b3a.1.1719271763360; Mon, 24 Jun 2024
 16:29:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:14 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-6-edliaw@google.com>
Subject: [PATCH v6 05/13] selftests/futex: Drop redundant -D_GNU_SOURCE CFLAGS
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
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 994fa3468f17..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.2.741.gdbec12cfda-goog


