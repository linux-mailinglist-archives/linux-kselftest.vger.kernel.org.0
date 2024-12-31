Return-Path: <linux-kselftest+bounces-23795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4E9FEF93
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 14:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA66D3A2E28
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFB71A00ED;
	Tue, 31 Dec 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZPkARi5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93319E975
	for <linux-kselftest@vger.kernel.org>; Tue, 31 Dec 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650851; cv=none; b=cma286UjT7ldKlCk8TEYvbptXBF7knDuwIpJ0eYPG/ccyjNaYRL6blOj2KGAQgWcyxe4f5wGt9bknCJRCGO6cyGRpbYsOobStNZlXWUJzkoFKw3eaq/Uhawkwv6TtZVfjON/ebhN0xqdc/9VoPjfV731YHQsQUkrJzh1+9Vvoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650851; c=relaxed/simple;
	bh=v8whFl/jk7+v9u73VH0q13g2zK6IQeJsS/9Wvy4ZCpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOFoDJIP/y03oj2k6BzzPibz7xLowA1VQnFrI4OHnoF6wry4EH86j1LFDp8yrGiQeWU6siGp1sFB9xtBNZfRP2o4Dy/qPmb/sjnMlXfXe40eCz5un1azFYJTZ8sCumbjfn19N68PdJ0XBQuUwPpZe+QPWKJeqM2OGbjql+8RaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iZPkARi5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216281bc30fso153142565ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Dec 2024 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735650849; x=1736255649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa1jN/asG74sjrgB8hwyWegLPzfHxpGYS7ycWDuiTK0=;
        b=iZPkARi5ILpnlbjIA6sF6rkZRFmUSmelceldXdyim1pBlkmujFr054ET4conjc9LcM
         jqFL9If4hDJ6C6YLkmHdFrGQKuLbvni14/KfTX58cuVi86lyEK2Wp4RIa1/NG6lusp5e
         XtvevibR+Dx5SDgH+w7VtLtnsKf6qioMik8av+n3Vcq01lI5QCo96cwS/VyNqPtTpyp3
         6LNazUmJ3dk79peWBZG2/yiui8hVJ2ca71JI5mJMmjZyoPBgNKp6GDDpGjhV1C+p3u/L
         NOn6oyYO73uoF/BXF1K/FyrRC3Hk1qoWdKDUSPNQWuLeJ4vJYba3PbZDLWs/427azYH8
         29Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650849; x=1736255649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa1jN/asG74sjrgB8hwyWegLPzfHxpGYS7ycWDuiTK0=;
        b=bwmz3Lz3g6mCbpYwCa26deV6e6HF/GBHo2lRxaRO7z+d/IG/jDDTSBmp2oelNu3/rp
         0blgFjzoiJoMVYrLZsFAIT9EPLXe0h/oT5ZFq32sE396fsZuM3glsSm9VEDewbTEKe4l
         b5Aues2sDGH8bN67swfdeU4nps7PR8q+K/NRoO6U3kqwqTDZXSU1nYKMf/YVE+o5Sh+0
         GDeegy+V0P3Bm937rcmNTnHyTXiQrZg+60lhi5hfEZCL+5XwL6U5jlPxmCprYDMJAfQa
         tBhhxEsE4YK8J0oz1cpYmVlXY4lRtKiXp9e19kMSdHS6ul0jFQpXiy+EYl4jwGAKnGTi
         ZGuw==
X-Forwarded-Encrypted: i=1; AJvYcCX77Sio4YFSmtCBdbm3t/KDkXmEPBsX648OeBSLC8fJaiZZMrWfehYBKVbgdq/zCdZbFoOH1ED1Pu4UAjpb1+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAAidD72UotNPuBi0xKUZJaW9N8nKoVrMGIUcuiXwozKQUk9N
	6Ze4+1ov/AqVePRgMlO58rZjaExHlWr/lUNoAS4j9UYNbWduYrBKAdl7FmWL1Q==
X-Gm-Gg: ASbGnctybPvPfWruopAsyZGhSRGB2aJ/mkg+p9LrmrY79DN9xaAKUaha0CZ06FB8aJB
	n1wN8IcmUbQ/9vq0vssTIGkMz0H80F9qt+twmc7ewQuRz+4IqlhzBP9uqLJXGHMQIRb6lt50Q3O
	liIa4w50X3IoPYbuLu2CGQi0yfj5f5udC/OF3oEgjJlV4Nx8ERQCsH0LMW/T6MYNa2x7lmNPqzz
	eIC791lJ3xQ8bMc4Jdqm3IZ27xn7Vp9sQxANl3qMdPtlOob5I8tB1skfqb2+my7RZoc3znFzfbe
	Xt8UacYEEqo=
X-Google-Smtp-Source: AGHT+IGZUa+Nt5saRgpUAg+RSZhQyxrVDXNDUEbMn6mYhhN1yi9azaKToiDiWgeEgiAtKmbQZ/2U4A==
X-Received: by 2002:a05:6a00:124a:b0:725:f282:1f04 with SMTP id d2e1a72fcca58-72abde846e5mr55442921b3a.18.1735650849549;
        Tue, 31 Dec 2024 05:14:09 -0800 (PST)
Received: from localhost.localdomain ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad6cc885sm20994862b3a.0.2024.12.31.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:14:09 -0800 (PST)
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
Subject: [PATCH v4 2/3] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
Date: Tue, 31 Dec 2024 18:43:40 +0530
Message-Id: <20241231131341.39292-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
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
index 1e930c7a58b1..0e611b845d50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18003,7 +18003,7 @@ F:	Documentation/PCI/endpoint/*
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


