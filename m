Return-Path: <linux-kselftest+bounces-43469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B7BEC250
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF176E9485
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7C241673;
	Sat, 18 Oct 2025 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5/RTL53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668792356BE
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746077; cv=none; b=FH0mdMn4J64sTENQPDoFy9/oLv6irPYAkCAzha/dnCfeBqe0xeo+3jJi1lDmXs1D0YAPRUF/qnx866wnS5NG7RoiZde9v38EdP2cZ1P0wZAJ65WtmiCj46+QvLe1XR8oLRoczIxzOzvCm9UYnB1K6H/PxxpPSHN8dqR0K3llYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746077; c=relaxed/simple;
	bh=vicAzr5G8Nj5bOl8kj0FUCuW44ReHeVMHkvxO4eBHz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F5y2NLQfjvMDigAAHiZTneJegGJAquclBi1ttx/htxmvTGi9RPkGVPps/TBjL9mtOwyV8kqw6gXo4TnjfHa6vvviNXp9jyD/wMmYJKoGMqiX3P1q4uHGROfWNbcD0IDWFeJrsb7pzQYAsFcyshqrix3QMcBd6qytklghQftsN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5/RTL53; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-336b646768eso2815420a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746075; x=1761350875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzsZ79Fc/eYrSb6uSl+QE8GB+MXNffylOcBysTYipsc=;
        b=U5/RTL538N872HxOtaXPLwywRcEmzr7k54UR9c5A92Q4Ta2gMkv4b/nP5GVidOQY38
         Amdd1wcy/jGp7t7+ByNp+KCEPjwzTv0hlABEZafnlifUsbJgUEozGuy64L64qsHU2Lfe
         XhmdnCAQr+/oxj98zFengad+R7jUgg7LQSqPcoCoV4ia+9e1uGI/0GkSLRWHfE692Jsr
         B+L10BhIalXvtHkhKFCusMJ5JbEkcaPoTjmUd8lvINi6GEJN6rJ9CslUOMls00eeSJUg
         5OlJQ2B+tWULlzgbdg6RvvJ0RWXFq8caAl4XLjTuruAHcs0WvFL2JGmFO/ZyznSMiSvT
         k3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746075; x=1761350875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzsZ79Fc/eYrSb6uSl+QE8GB+MXNffylOcBysTYipsc=;
        b=t169d0ewQRfgNOjB5Lz8zvju6Za9PjDJ1NydWaxQa6uJb4fsqMeQzc2Deapoigee91
         TRUyT1X/SWsGOt2KgDvUbmx9b7mL/NZre8AS0WeaizMgiWrudH8TCMIEiyZAQ0GPjmiZ
         WtdjIbljJW+5Y55C7z3zeBzdCCN59dKWFv0t97qqrTiNOpbGcMEfZCO2GdUIItShU1p8
         XiyaPDqgFDwAmV6h/Et8PRBRBr6zPVO6R6UNE7O7RB0JUW+fqHvz9qO6m8ataxDUXbzA
         CWF9NHDrIHGdH2VZwSVb2cEKiSM0uuVg47Yu1zgi2Ib1QN0eV/7EyXrH2T7o/N1/JjoO
         QpKA==
X-Forwarded-Encrypted: i=1; AJvYcCVmJScY7nPqun/RSyv6M3+UQ3+Mlj/hzeWioFvYj0lHoZHrUjHd4hEdJR0enN+5HjAe8mHLb2sJwn6GTybvidI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXCgpRW3ygoaL+nf3s4ZLa09Ownuy6S7Ib4IOhw6KUWSeMAyN
	1FYnweDHmFOLjM7nNSXCL6vi8KBW/I6XdZWs/0g+/zkcOHzYQR2xcqwSlwj+obeKbc948k5MF/L
	/z7SvN942Rw==
X-Google-Smtp-Source: AGHT+IH5Agotaie8Yfpd4OzcADNWVRMuZUwHnAmsdAx38ewjmLDznR7pF55YyI5GG3nzDG73A6J4oF7pzhXs
X-Received: from pjbgq8.prod.google.com ([2002:a17:90b:1048:b0:33b:da89:9788])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5386:b0:32d:ea1c:a4e5
 with SMTP id 98e67ed59e1d1-33bcf85128emr6136432a91.1.1760746074698; Fri, 17
 Oct 2025 17:07:54 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:10 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-19-vipinsh@google.com>
Subject: [RFC PATCH 18/21] vfio: selftests: Build liveupdate library in VFIO selftests
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Import and build liveupdate selftest library in VFIO selftests.

It allows to use liveupdate ioctls in VFIO selftests

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 324ba0175a33..c7f271884cb4 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -6,16 +6,24 @@ TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_PROGS_EXTENDED := run.sh
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
 CFLAGS += $(EXTRA_CFLAGS)
 
-$(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+LIBS_O := $(LIBVFIO_O)
+LIBS_O += $(LIBLIVEUPDATE_O)
+
+TEST_GEN_ALL_PROGS := $(TEST_GEN_PROGS)
+TEST_GEN_ALL_PROGS += $(TEST_GEN_PROGS_EXTENDED)
+
+$(TEST_GEN_ALL_PROGS): %: %.o $(LIBS_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
 TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+TEST_GEN_PROGS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
-- 
2.51.0.858.gf9c4a03a3a-goog


