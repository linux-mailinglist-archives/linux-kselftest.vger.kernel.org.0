Return-Path: <linux-kselftest+bounces-23161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034F9EC65C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79795281D26
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81C1D86C0;
	Wed, 11 Dec 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpwPq8Yq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B451C5490
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904108; cv=none; b=gNJ3NLDg5dPm6ZJbdUr/ton/vo3een4OvEDvDEd2AbdpMWgWTU+qhMmZGmssOS9RCDQfsskiNoINPT2z+hMGP59xnwM1p16y2L1RSYMNWZ6IyjMuDBcR4lbJS/XtMp8pHC91F2kbhbDLprMMjybEavLDuqh3ZW/ZZ3+lx1XPr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904108; c=relaxed/simple;
	bh=lWn6bFGNd/3JKefZVdI9nxhLKSncMF+8FCLHmP8ExpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+gok55olv/HzIc8R1lnx92eIzK5oPG6xtAuC+WjXfTAN1wWKi+wxsAUh3DBTh4Rn7lk6rZ2vYUoPzwifOJApRXhOT8Ixki5hPQ8MDyZ7HeUau1cmICJdxYmnT5iM4NsO5jqQOoLD727P9sbD+5rfYHuj7I/gLs+n1vc483oFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rpwPq8Yq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-801986033f9so660755a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 00:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904106; x=1734508906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oI3p2DNU6VR/r2E24vXbkA5gNVpP0sFqur3k9w/neH8=;
        b=rpwPq8YqSHbVISHHK6s7/YRpyVYPaSuQNJQC2c+D7ROlrM5Ju4oR01FBRufBieRpZ9
         rI1BoyhPckvtr7aqNRHUA9KR4G7g+2Z9GVaV0CU7LhAs4foAh60W03f9X7csq+Mx+5fe
         hMi7Sq2PmVfPdGp6wFhl4oXq8/GTdQijW+NkuJbLdqoxJ1SXjiz65iVuIS36dEKw49Kb
         M9h6KGXn4VtNhb+y1ZwDNX2b+Z7gxyUwOlDbvJOxG8fHY0qeHDBAe53/zOLgiuKIa6Xt
         CUXgGTYfsC1NOfRjp6qCRXMu9Ndg1GY7wXFurU/tF0igVi7XKvpJcooiHm/FpcrU6HTA
         VNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904106; x=1734508906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oI3p2DNU6VR/r2E24vXbkA5gNVpP0sFqur3k9w/neH8=;
        b=Fe+5v/QrGf9DtHL2uYKvmMF5xswzWbbYqjUxU75nQRd1T78CpjUxYbSD5/2hyTzvte
         BwLM0ECisyeDI1SaO4s8pfxoEp9FfXniD0iPl2Apj+RZLqLQA4F2sxTp+QfN4STPCL9w
         INHV6Njkvrwzyar0kzIfsNcoTxB087jxxNN9k5PamRCPQgbU4vakKr/6OoFgXkgglhsh
         dlFx6qHpjpmLGcgMGuHH78bu2tFXZ+U0dd5KJ0tbARibqGBJym397JNSesadwntyiQeq
         OcXDzSBx21ibqu4dKV5MAyoaskdvIjb7/Bku5H08KP1XSw/zrvGpFc3ATr1218KBhSjs
         WUAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDl8CIOlOa3ovx93deyu59QqD4po5OwgYN6nOa8f9tgWayHRVzbk2iwVfZwGhKmUzPQhJ0memK7bZDCJrAfEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeqfFYjU5sFOCkRpaVyYmPN1bSV3b3Bgm9fzLHLDT5vywqzIY
	TJHwY46Pk8As9KQftL6WeLpFuGFAGeWE85pKBqtU1wKn0QDnuhim4bhzFmNkDA==
X-Gm-Gg: ASbGnctbhXB8JuAUOe5YTea7+AJXEzMqQSP4w2uTWTTxmFc/Hf8LTz2S+l7SHNjoIEn
	8ATwIcjO2uGynocQMAWnfJa73mXkq5bDz5mxMpaFse+kc5zf9l6R90BmG/Pfna8ZBUzr64Lio1H
	ffkerfjCceIxya/Yr91V/E8CZWpBJ0ZaayLJ5Ofxv/rLCBQEKXlUICx0oYMrPllHL/hlPI3dIpO
	v1aBRt6gIvEm+YbzfsvLT4oYFcc/ukscEMDmTS52Tt+OL8DntIuMRx6pOHs98T4AMPLw0H6OQWH
	EPe9
X-Google-Smtp-Source: AGHT+IFI7gkOkC6T+qAcAj0nkeYuAIcC6kTVp/ygQd04PdZ7LAeRQwUaf9QpqzZHybol1ibBhqYTlA==
X-Received: by 2002:a17:90b:3147:b0:2ee:94d1:7a89 with SMTP id 98e67ed59e1d1-2f127f8f7eemr2987456a91.1.1733904106330;
        Wed, 11 Dec 2024 00:01:46 -0800 (PST)
Received: from localhost.localdomain ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b93dsm12929775a91.51.2024.12.11.00.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:01:45 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/4] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
Date: Wed, 11 Dec 2024 13:31:04 +0530
Message-Id: <20241211080105.11104-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just moves the existing tests under tools/pci to
tools/testing/selftests/pci_endpoint and adjusts the paths in Makefile
accordingly. Migration to Kselftest framework will be done in subsequent
commits.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/PCI/endpoint/pci-test-howto.rst          |  9 +++++----
 MAINTAINERS                                            |  2 +-
 tools/testing/selftests/pci_endpoint/.gitignore        |  3 +++
 tools/{pci => testing/selftests/pci_endpoint}/Build    |  0
 tools/{pci => testing/selftests/pci_endpoint}/Makefile | 10 +++++-----
 .../{pci => testing/selftests/pci_endpoint}/pcitest.c  |  0
 .../{pci => testing/selftests/pci_endpoint}/pcitest.sh |  0
 7 files changed, 14 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
 rename tools/{pci => testing/selftests/pci_endpoint}/Build (100%)
 rename tools/{pci => testing/selftests/pci_endpoint}/Makefile (83%)
 rename tools/{pci => testing/selftests/pci_endpoint}/pcitest.c (100%)
 rename tools/{pci => testing/selftests/pci_endpoint}/pcitest.sh (100%)

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index 909f770a07d6..c4ae7af50ede 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -123,16 +123,17 @@ above::
 Using Endpoint Test function Device
 -----------------------------------
 
-pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
-tests. To compile this tool the following commands should be used::
+pcitest.sh added in tools/testing/selftests/pci_endpoint can be used to run all
+the default PCI endpoint tests. To compile this tool the following commands
+should be used::
 
 	# cd <kernel-dir>
-	# make -C tools/pci
+	# make -C tools/testing/selftests/pci_endpoint
 
 or if you desire to compile and install in your system::
 
 	# cd <kernel-dir>
-	# make -C tools/pci install
+	# make -C tools/testing/selftests/pci_endpoint install
 
 The tool and script will be located in <rootfs>/usr/bin/
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 21fdaa19229a..f116f78a2ec5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17794,7 +17794,7 @@ F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
-F:	tools/pci/
+F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
 M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
diff --git a/tools/testing/selftests/pci_endpoint/.gitignore b/tools/testing/selftests/pci_endpoint/.gitignore
new file mode 100644
index 000000000000..29ab47c48484
--- /dev/null
+++ b/tools/testing/selftests/pci_endpoint/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+*.o
+pcitest
diff --git a/tools/pci/Build b/tools/testing/selftests/pci_endpoint/Build
similarity index 100%
rename from tools/pci/Build
rename to tools/testing/selftests/pci_endpoint/Build
diff --git a/tools/pci/Makefile b/tools/testing/selftests/pci_endpoint/Makefile
similarity index 83%
rename from tools/pci/Makefile
rename to tools/testing/selftests/pci_endpoint/Makefile
index 62d41f1a1e2c..3c6fe18e32cc 100644
--- a/tools/pci/Makefile
+++ b/tools/testing/selftests/pci_endpoint/Makefile
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
-include ../scripts/Makefile.include
+include ../../../scripts/Makefile.include
 
 bindir ?= /usr/bin
 
 ifeq ($(srctree),)
-srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
 # Do not use make's built-in rules
@@ -27,10 +26,11 @@ include $(srctree)/tools/build/Makefile.include
 #
 # We need the following to be outside of kernel tree
 #
-$(OUTPUT)include/linux/: ../../include/uapi/linux/
+$(OUTPUT)include/linux/: ../../../../include/uapi/linux/
 	mkdir -p $(OUTPUT)include/linux/ 2>&1 || true
-	ln -sf $(CURDIR)/../../include/uapi/linux/pcitest.h $@
+	ln -sf $(CURDIR)/../../../../include/uapi/linux/pcitest.h $@
 
+$(info ${CURDIR})
 prepare: $(OUTPUT)include/linux/
 
 PCITEST_IN := $(OUTPUT)pcitest-in.o
diff --git a/tools/pci/pcitest.c b/tools/testing/selftests/pci_endpoint/pcitest.c
similarity index 100%
rename from tools/pci/pcitest.c
rename to tools/testing/selftests/pci_endpoint/pcitest.c
diff --git a/tools/pci/pcitest.sh b/tools/testing/selftests/pci_endpoint/pcitest.sh
similarity index 100%
rename from tools/pci/pcitest.sh
rename to tools/testing/selftests/pci_endpoint/pcitest.sh
-- 
2.25.1


