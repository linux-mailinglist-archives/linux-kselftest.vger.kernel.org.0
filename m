Return-Path: <linux-kselftest+bounces-20480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A999ACF41
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6929D286AB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64671D14E4;
	Wed, 23 Oct 2024 15:44:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047991D0799;
	Wed, 23 Oct 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698258; cv=none; b=N7xrxsobiU6u0upsV5ZUhsA5p0kVwN4Uu/nMiaFG1uykhDji5qbZj4Tor7cdeV9zVp3UxUtIM37RRPDr0OEKc5e7M71hTgR0nVgKbVJkIKQo99wMCte4V9IxFjPKUyWeosyNL3AkdWjzB5QsmeQ2CHenvKJWWao83BfVltYhdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698258; c=relaxed/simple;
	bh=QNIVoaUG6HoJ02+8aCHTzhZtbDvKJFEGC7k27W7G0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9pAOQqij2Bl6lbBAm13jEziLwj7i6zWBi/20JLexuMZUuDTSPHeHAr1xi8KCvSYQXs11nQIlu6gjqvMZOeztYMC1qUnccO4OMAfqzEP7WZTAIzbWwlITOfVCtLnsV5wRX50niPtsQR34GG8prFeW59yBAKPisRuG7yANOdFJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so779477b3a.1;
        Wed, 23 Oct 2024 08:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698256; x=1730303056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLuAo808h43hPUqDZon7CMUoTgxLTq7GJOn3Y6RziyQ=;
        b=jgMTHa5gbSUl9OxBuAc62Q4nBsyk4AGrvjF8pK5EcE4pppmYyf03xybhhxtG3FoSHM
         KmSUW9rLrh3/lHjk3Xg6kzboCq3CJxQWu3mVIroTOhH1/7HF088bgX2LwpcBoa01W9mT
         XpKU6tuycOrzJFWgj7sVjXU6Y6Yu8A69EVKVD9dT5m9emP4yEb+csvEsXdxodiNLS0za
         aWX4c+CdgXOX0sJe/XnBPzEdA2nBcWA841tPyk7cAWSQtL61eIooQhi6G6TzDJYYcYU0
         Tajs71AQGGM2stfb6UAuPTbwoECcHjhExflStRMvLv7LHtjfclxUNPWD0Xfx1aO9MP7w
         sr0w==
X-Forwarded-Encrypted: i=1; AJvYcCWL3cW5cwSZfKYxAuCSm+jtjHwmakVPDOVFuMFNvPH7tyRmJNFT5Cp45TrlS73iA+NaUNhehceW8yo1kXXYnyHN@vger.kernel.org, AJvYcCXxj/iKuiQeT2sISzZx8E0tx22+su71jEULu1zWb0XB43Vnr/PIKFge2bgGemGY8vQWof4wkl86fcoZotw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2cm2R4Dpm34QWmzooapfz0Y1kiNeYfjD7GiWiDjtVYusGvdv
	U0WfB4rsPs6ahRWZftWMe4vOtqtfejHhEgfvklq/v/CC+8OkWlee9xlrnjA=
X-Google-Smtp-Source: AGHT+IEOaI887BOI704vql0OLz3gq+9dRFk/uA2lyriK37cKHhq3KVNlDCQI2vpUYt6hR7vam91DcA==
X-Received: by 2002:a05:6a00:1142:b0:71e:76dc:10f7 with SMTP id d2e1a72fcca58-72030f79cd7mr5038113b3a.4.1729698255965;
        Wed, 23 Oct 2024 08:44:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d14sm6713485b3a.16.2024.10.23.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 11/12] selftests: ncdevmem: Move ncdevmem under drivers/net/hw
Date: Wed, 23 Oct 2024 08:44:01 -0700
Message-ID: <20241023154402.441510-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023154402.441510-1-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is where all the tests that depend on the HW functionality live in
and this is where the automated test is gonna be added in the next
patch.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/.gitignore         | 1 +
 tools/testing/selftests/drivers/net/hw/Makefile           | 8 ++++++++
 .../testing/selftests/{net => drivers/net/hw}/ncdevmem.c  | 0
 tools/testing/selftests/net/.gitignore                    | 1 -
 tools/testing/selftests/net/Makefile                      | 8 --------
 5 files changed, 9 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/.gitignore
 rename tools/testing/selftests/{net => drivers/net/hw}/ncdevmem.c (100%)

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
new file mode 100644
index 000000000000..e9fe6ede681a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -0,0 +1 @@
+ncdevmem
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index c9f2f48fc30f..182348f4bd40 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,4 +26,12 @@ TEST_INCLUDES := \
 	../../../net/forwarding/tc_common.sh \
 	#
 
+# YNL files, must be before "include ..lib.mk"
+YNL_GEN_FILES := ncdevmem
+TEST_GEN_FILES += $(YNL_GEN_FILES)
+
 include ../../../lib.mk
+
+# YNL build
+YNL_GENS := ethtool netdev
+include ../../../net/ynl.mk
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
similarity index 100%
rename from tools/testing/selftests/net/ncdevmem.c
rename to tools/testing/selftests/drivers/net/hw/ncdevmem.c
diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 217d8b7a7365..a78debbd1fe7 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -18,7 +18,6 @@ ipv6_flowlabel_mgr
 log.txt
 msg_oob
 msg_zerocopy
-ncdevmem
 nettest
 psock_fanout
 psock_snd
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 759b1d2dc8b4..22a5d6a7c3f3 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -97,10 +97,6 @@ TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
 
-# YNL files, must be before "include ..lib.mk"
-YNL_GEN_FILES := ncdevmem
-TEST_GEN_FILES += $(YNL_GEN_FILES)
-
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
@@ -110,10 +106,6 @@ TEST_INCLUDES := forwarding/lib.sh
 
 include ../lib.mk
 
-# YNL build
-YNL_GENS := ethtool netdev
-include ynl.mk
-
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
-- 
2.47.0


