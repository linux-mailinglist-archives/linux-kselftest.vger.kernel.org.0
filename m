Return-Path: <linux-kselftest+bounces-43452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEEBEC17E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29210408F0B
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80221208D0;
	Sat, 18 Oct 2025 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9w0DEBy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B51388
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746048; cv=none; b=r7fiK9i2PQBthhHhjOvyANigkWk+iJ5hkjE/y7PVLrQmfwvgR+DOCNSxK2w5KTQX3YqIqarFBgYJnj36OWsVZKxr+IaFEEIfzMcNeTMwwpob9JWfqbuuYcg6kCvJFYvU7WolV+nSrw7pOpRj3xidnxEvEGxEopxi0xnHisqdYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746048; c=relaxed/simple;
	bh=jNj/t1fXmQozileACwtwMKU1XXKgVwEcRRV43j27iqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOTw5I28srIWzPYFG1Bq9PCxiNGNY1IYUc/iHoXYdOMVIn27kKdDhOUq7rVDzgd7WWEQRnVvJnZOi1B0xvkpRNNIWRFoEB8Tec7XWvBkN6jZzih6m9NBN4zxZSqUJMXJ/gNm+tAeELItDZhhoNKKaDGGR0gJTt5je23sTJ+o0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9w0DEBy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33ba9047881so3245459a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746045; x=1761350845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIRdeTDVJnSPIQ4l7UYy+dVw1HMydqx25E2KK+QEeEY=;
        b=y9w0DEByeQX4BZdteKUn9Iyw6KYGLPnqvMcGfNHzYxRpE4CNCyI4V1j9OjtQMedxt+
         lYTPw0H25yPHlVCeD8Nj+zmLIfS2Wtm7KVIXQBxeEWrHnILfM68vSQwGMIcEN+I3KKZp
         JG8ex+PBT/nOyq9BwcbGYcpMnmIpSetgtA3iZ1O0VHdWpLY8fEC8g4kuaLMmazORCcas
         3DsBomkoqdU8Es6FOmmOvzx6MrMqTtRfRWlXtnv6zU/0L1I1VV9yj3G7X71k4hopdAwr
         bL3viY6dvsBKl8REXR/XIsgOG3J5jq70qRCVoooZWgyT3dXo0WW9J4YfJXCJqtA52LEj
         DXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746045; x=1761350845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIRdeTDVJnSPIQ4l7UYy+dVw1HMydqx25E2KK+QEeEY=;
        b=LXCcCyXPKdKWibrx9169o3h+FC5Q7y45wWIdyBfNAuz0IP6NpDgTskh91zISryVewn
         VVq9A0YjUEZHyR81kHh2tFs4zXbDzQBA/Rb8eaP+jgj8CVnwzZCpR2sgxV2z8JLmW6Hw
         Oa67Dyx7gV99FS0qFSazu3fUP08x/qj/fDfc5i50G6AVvgRL4HN0UDWtQRqlBqxDbT5t
         ZZkrm+Q7ml7hzsNKG5KF2xbvT+4VsdUOljwIOXeBd09gscmLALHoHPcV3jIh3cneZ83r
         bOpTOyGWU+MbLbMRWnJVkNNRO9RTw45fFTXw3wVYucC/LNAF5k9Wq64u0kJ9J3VFwCTK
         rDpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGfKTiC+sRwHRGeOJJ6AtAVdIVOyrB3qNYopfOmWsDNnkuYlLl61Dyklz94SI2Vefk3mUnNOzlydrF9KK2lyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpp/otx29bc9QaqFeU/9RqS1lf3LhKnYFeXm6HqihT0RFlkLSa
	YypCy0JVA4YXypuCPxy+lCRaAcQ78JZvEJ2GjBookMvHB4USKQ5LCe+bhSGY+wgd+Vcu+bktV6F
	9Gq87CWXxeg==
X-Google-Smtp-Source: AGHT+IGpNneZjiyeUgiPSOA0Ff+L/EkC9zJCByYhGlasmrVLxnfDuFjE0n/3azWJkzCxNEVHDOKe34jfRpQ7
X-Received: from pjg7.prod.google.com ([2002:a17:90b:3f47:b0:330:7dd8:2dc2])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f82:b0:330:c522:6138
 with SMTP id 98e67ed59e1d1-33b9e0a80f6mr11300701a91.8.1760746045501; Fri, 17
 Oct 2025 17:07:25 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:06:53 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-2-vipinsh@google.com>
Subject: [RFC PATCH 01/21] selftests/liveupdate: Build tests from the
 selftests/liveupdate directory
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

Build selftests from liveupdate directory

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/liveupdate/.gitignore |  7 ++++--
 tools/testing/selftests/liveupdate/Makefile   | 25 ++++++++++---------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
index de7ca45d3892..da3a50a32aeb 100644
--- a/tools/testing/selftests/liveupdate/.gitignore
+++ b/tools/testing/selftests/liveupdate/.gitignore
@@ -1,2 +1,5 @@
-/liveupdate
-/luo_multi_kexec
+liveupdate
+luo_multi_kexec
+luo_multi_file
+luo_multi_session
+luo_unreclaimed
diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 25a6dec790bb..fbcacbd1b798 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-KHDR_INCLUDES ?= -I../../../usr/include
-CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += $(KHDR_INCLUDES)
-LDFLAGS += -static
-
 # --- Test Configuration (Edit this section when adding new tests) ---
 LUO_SHARED_SRCS := luo_test_utils.c
 LUO_SHARED_HDRS += luo_test_utils.h
@@ -25,6 +20,12 @@ TEST_GEN_PROGS := $(LUO_MAIN_TESTS)
 
 liveupdate_SOURCES := liveupdate.c $(LUO_SHARED_SRCS)
 
+include ../lib.mk
+
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += $(KHDR_INCLUDES)
+LDFLAGS += -static
+
 $(OUTPUT)/liveupdate: $(liveupdate_SOURCES) $(LUO_SHARED_HDRS)
 	$(call msg,LINK,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
@@ -33,16 +34,16 @@ $(OUTPUT)/liveupdate: $(liveupdate_SOURCES) $(LUO_SHARED_HDRS)
 $(foreach test,$(LUO_MANUAL_TESTS), \
 	$(eval $(test)_SOURCES := $(test).c $(LUO_SHARED_SRCS)))
 
+define BUILD_RULE_TEMPLATE
+$(OUTPUT)/$(1): $($(1)_SOURCES) $(LUO_SHARED_HDRS)
+	$(call msg,LINK,,$$@)
+	$(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@
+	$(Q)chmod +x $$@
+endef
 # This loop automatically generates an explicit build rule for each manual test.
 # It includes dependencies on the shared headers and makes the output
 # executable.
 # Note the use of '$$' to escape automatic variables for the 'eval' command.
 $(foreach test,$(LUO_MANUAL_TESTS), \
-	$(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
-		$(call msg,LINK,,$$@) ; \
-		$(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
-		$(Q)chmod +x $$@ \
-	) \
+	$(eval $(call BUILD_RULE_TEMPLATE,$(test))) \
 )
-
-include ../lib.mk
-- 
2.51.0.858.gf9c4a03a3a-goog


