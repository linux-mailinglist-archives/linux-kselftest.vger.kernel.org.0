Return-Path: <linux-kselftest+bounces-24650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D22A13B39
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B333D169707
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5322B8AF;
	Thu, 16 Jan 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpFWMOwE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84B22B8B1
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035499; cv=none; b=k0lX0CjA2KjPxw2QGzUdv7YIxRGZlxsql5hatkGsGWIlbZFbDNFRHpzg99rvNXc1oWV6E0O+qsqKNEnvieOYDb6YGEYnpesTIgwdOEzDjsJbSxKa//vpt+ChluCmLnykv8Kk+1CAjzGl8T+NnkIMKaNHMZX5euaedOyu2L2qzh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035499; c=relaxed/simple;
	bh=lzXM+x/0dG8xtmuHPW5f4xUizx5SRzessJQuGEOtfSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOrxbTaFRqxSVmZfzoJPG6i3tc7+XASAvAOqMDPFtIdtaLqyDhw09ZMBezOms9sQ4Jy35a4qk3R+4uOaSGCtUSw5NO1mSpv5VuMIQqVR8Cc+ZJfhjQiQQTmozP4zyUE9T+wCuGyQ1Qw/Auf1mZU2HPS9feJwh92jjS+xsniNB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpFWMOwE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f42992f608so1439609a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737035496; x=1737640296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwth0QdId0PFtWOM/UQBq1TUmIYD++//t68/X9EYdaU=;
        b=mpFWMOwEF7HsEHguGRsRwjkoGuarLsmWwWn97xPi9FOrJBEwY9dNzJ8aN+fE34wGJq
         k5eced5n74X/RuLDvLIqjsJE8CJaWfMCwTiv3b1xkJfEFlsxj+Kvn86NnyS0qjWvstLs
         Oe6kgEwp0inmo+DO7VvtHJsSiTMOKHWjZH6WaC2tt/kce4fysWNxXNXR5a1hvhXkZ/Jv
         XcFxG4xg2PPrPfWejpoe1bc4C6kPBSB5vyu9kbSJ8AGdAklm6ZXnN1qjpEjv+3im1O5Q
         LIjIZbjPTyaE6eEVSlrx/sgZpyBqbsWovDr4q9hc+heYj/oUB4YQGEXjMBZU/AQtRZM0
         jq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035496; x=1737640296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwth0QdId0PFtWOM/UQBq1TUmIYD++//t68/X9EYdaU=;
        b=jL0oeKCGQTTB6ty/2ZEvqE7CQ4b/nHXP9QCjw6tvWRswCj3BvhiUX28ydn/MAmrjoX
         BiXYcg1rkWD9jpZrTUoezsKAkc40k2yl835Tb3Xo16Flu7eLtFKn7kocsFMPhE55Bfdn
         GTcoy/l4PIG88SBRIDnIW9nCfqQRfNCiFfMWtKvGuwumWSan1G2a4TtnK5DGIZqPQko8
         +HoC2DBkRw2dYHSrm3JmKtnF6L7pKxpO/Z4e41bAt6gf/UJ3BvrdUiaLSqoR7Q2hSOIc
         w7syUaHyok6+1scA257dGnCSM6rjk6QgSozOoMzhguGKebd3/z9efKAN83jzSaG23Fcp
         +tpA==
X-Forwarded-Encrypted: i=1; AJvYcCVekBHHMP1sRuM2yh8Q3QvDyM45c1KbH8XPZKq+F9oU9uVmvRELHLprmlVxtQqO73HJI0AyCORGcIw5QVxwImc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknHfPQPVZMyyT4nfDnvvobuRz2buZeNHUU+gJXZcTKXxlzUk1
	ssF+Vo0w4eoReSUEjHMjx++UDvIdjpqLoAf3K73a2/OaadVaCMYAwwWVgfYfDw==
X-Gm-Gg: ASbGncvddy287KpnX49fnyEbCQj2e7PMKc5kg6tTrGUGx9vqJMF6fZoMwu6UgFeB8ae
	9ruu6rDKum8A/MOvgwsxCD9AJtvLT6EW18UKg0U6MElsQEty+yt1/2IekAU+5OWwqNvDYz2C20e
	yOyZ7tNuVhme+cBpSPWS5Q3DAzsRt3cxOA1jDZ3mM2egu1jUi6Kpf6rLBL5BcTj4JzRpdbKiR2D
	kCjSP9R2VqxRB5wx876xBAWHVGhhj//fS7PKhluknOLRWm5pPxuCHRStVwUPaYKZO+JyBOUbQrX
	FkvnHID8
X-Google-Smtp-Source: AGHT+IEIf6A5ITb4tMN5jWFVaQrJuPvBxj/idWyk2BGtcSoNKdogEi/l4hjPspx/BdXMbMa3HJwdBw==
X-Received: by 2002:a17:90a:d2d0:b0:2ee:7a4f:9265 with SMTP id 98e67ed59e1d1-2f548eae0a0mr50023824a91.15.1737035496265;
        Thu, 16 Jan 2025 05:51:36 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cba9csm3341229a91.24.2025.01.16.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:51:35 -0800 (PST)
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
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Aman Gupta <aman1.gupta@samsung.com>,
	Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v5 4/4] selftests: pci_endpoint: Migrate to Kselftest framework
Date: Thu, 16 Jan 2025 19:21:06 +0530
Message-Id: <20250116135106.19143-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate the PCI endpoint test to Kselftest framework. All the tests that
were part of the previous pcitest.sh file were migrated.

Below is the exclusive list of tests:

1. BAR0 Test
2. BAR1 Test
3. BAR2 Test
4. BAR3 Test
5. BAR4 Test
6. BAR5 Test
7. Consecutive BAR Tests
8. Legacy IRQ Tests
9. MSI Interrupt Tests (MSI1 to MSI32)
10. MSI-X Interrupt Tests (MSI-X1 to MSI-X2048)
11. Read Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
12. Write Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
13. Copy Tests - MEMCPY (For 1, 1024, 1025, 1024000, 1024001 Bytes)
14. Read Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
15. Write Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)
16. Copy Tests - DMA (For 1, 1024, 1025, 1024000, 1024001 Bytes)

BAR, DMA and MEMCPY tests are added as fixture variants and can be executed
separately as below:

$ pci_endpoint_test -v BAR0
$ pci_endpoint_test -v dma
$ pci_endpoint_test -v memcpy

Co-developed-by: Aman Gupta <aman1.gupta@samsung.com>
Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
Co-developed-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
[mani: reworked based on the IOCTL fix, cleanups, documentation, commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/PCI/endpoint/pci-test-howto.rst | 169 +++++------
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/pci_endpoint/.gitignore |   3 +-
 tools/testing/selftests/pci_endpoint/Build    |   1 -
 tools/testing/selftests/pci_endpoint/Makefile |  59 +---
 tools/testing/selftests/pci_endpoint/config   |   4 +
 .../pci_endpoint/pci_endpoint_test.c          | 221 +++++++++++++++
 .../testing/selftests/pci_endpoint/pcitest.c  | 265 ------------------
 .../testing/selftests/pci_endpoint/pcitest.sh |  73 -----
 9 files changed, 300 insertions(+), 496 deletions(-)
 delete mode 100644 tools/testing/selftests/pci_endpoint/Build
 create mode 100644 tools/testing/selftests/pci_endpoint/config
 create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
 delete mode 100644 tools/testing/selftests/pci_endpoint/pcitest.c
 delete mode 100644 tools/testing/selftests/pci_endpoint/pcitest.sh

diff --git a/Documentation/PCI/endpoint/pci-test-howto.rst b/Documentation/PCI/endpoint/pci-test-howto.rst
index c4ae7af50ede..7d0dbad61456 100644
--- a/Documentation/PCI/endpoint/pci-test-howto.rst
+++ b/Documentation/PCI/endpoint/pci-test-howto.rst
@@ -123,9 +123,9 @@ above::
 Using Endpoint Test function Device
 -----------------------------------
 
-pcitest.sh added in tools/testing/selftests/pci_endpoint can be used to run all
-the default PCI endpoint tests. To compile this tool the following commands
-should be used::
+Kselftest added in tools/testing/selftests/pci_endpoint can be used to run all
+the default PCI endpoint tests. To build the Kselftest for PCI endpoint
+subsystem, the following commands should be used::
 
 	# cd <kernel-dir>
 	# make -C tools/testing/selftests/pci_endpoint
@@ -133,104 +133,73 @@ should be used::
 or if you desire to compile and install in your system::
 
 	# cd <kernel-dir>
-	# make -C tools/testing/selftests/pci_endpoint install
+	# make -C tools/testing/selftests/pci_endpoint INSTALL_PATH=/usr/bin install
 
-The tool and script will be located in <rootfs>/usr/bin/
+The test will be located in <rootfs>/usr/bin/
 
-
-pcitest.sh Output
-~~~~~~~~~~~~~~~~~
+Kselftest Output
+~~~~~~~~~~~~~~~~
 ::
 
-	# pcitest.sh
-	BAR tests
-
-	BAR0:           OKAY
-	BAR1:           OKAY
-	BAR2:           OKAY
-	BAR3:           OKAY
-	BAR4:           NOT OKAY
-	BAR5:           NOT OKAY
-
-	Interrupt tests
-
-	SET IRQ TYPE TO LEGACY:         OKAY
-	LEGACY IRQ:     NOT OKAY
-	SET IRQ TYPE TO MSI:            OKAY
-	MSI1:           OKAY
-	MSI2:           OKAY
-	MSI3:           OKAY
-	MSI4:           OKAY
-	MSI5:           OKAY
-	MSI6:           OKAY
-	MSI7:           OKAY
-	MSI8:           OKAY
-	MSI9:           OKAY
-	MSI10:          OKAY
-	MSI11:          OKAY
-	MSI12:          OKAY
-	MSI13:          OKAY
-	MSI14:          OKAY
-	MSI15:          OKAY
-	MSI16:          OKAY
-	MSI17:          NOT OKAY
-	MSI18:          NOT OKAY
-	MSI19:          NOT OKAY
-	MSI20:          NOT OKAY
-	MSI21:          NOT OKAY
-	MSI22:          NOT OKAY
-	MSI23:          NOT OKAY
-	MSI24:          NOT OKAY
-	MSI25:          NOT OKAY
-	MSI26:          NOT OKAY
-	MSI27:          NOT OKAY
-	MSI28:          NOT OKAY
-	MSI29:          NOT OKAY
-	MSI30:          NOT OKAY
-	MSI31:          NOT OKAY
-	MSI32:          NOT OKAY
-	SET IRQ TYPE TO MSI-X:          OKAY
-	MSI-X1:         OKAY
-	MSI-X2:         OKAY
-	MSI-X3:         OKAY
-	MSI-X4:         OKAY
-	MSI-X5:         OKAY
-	MSI-X6:         OKAY
-	MSI-X7:         OKAY
-	MSI-X8:         OKAY
-	MSI-X9:         NOT OKAY
-	MSI-X10:        NOT OKAY
-	MSI-X11:        NOT OKAY
-	MSI-X12:        NOT OKAY
-	MSI-X13:        NOT OKAY
-	MSI-X14:        NOT OKAY
-	MSI-X15:        NOT OKAY
-	MSI-X16:        NOT OKAY
-	[...]
-	MSI-X2047:      NOT OKAY
-	MSI-X2048:      NOT OKAY
-
-	Read Tests
-
-	SET IRQ TYPE TO MSI:            OKAY
-	READ (      1 bytes):           OKAY
-	READ (   1024 bytes):           OKAY
-	READ (   1025 bytes):           OKAY
-	READ (1024000 bytes):           OKAY
-	READ (1024001 bytes):           OKAY
-
-	Write Tests
-
-	WRITE (      1 bytes):          OKAY
-	WRITE (   1024 bytes):          OKAY
-	WRITE (   1025 bytes):          OKAY
-	WRITE (1024000 bytes):          OKAY
-	WRITE (1024001 bytes):          OKAY
-
-	Copy Tests
-
-	COPY (      1 bytes):           OKAY
-	COPY (   1024 bytes):           OKAY
-	COPY (   1025 bytes):           OKAY
-	COPY (1024000 bytes):           OKAY
-	COPY (1024001 bytes):           OKAY
+	# pci_endpoint_test
+	TAP version 13
+	1..16
+	# Starting 16 tests from 9 test cases.
+	#  RUN           pci_ep_bar.BAR0.BAR_TEST ...
+	#            OK  pci_ep_bar.BAR0.BAR_TEST
+	ok 1 pci_ep_bar.BAR0.BAR_TEST
+	#  RUN           pci_ep_bar.BAR1.BAR_TEST ...
+	#            OK  pci_ep_bar.BAR1.BAR_TEST
+	ok 2 pci_ep_bar.BAR1.BAR_TEST
+	#  RUN           pci_ep_bar.BAR2.BAR_TEST ...
+	#            OK  pci_ep_bar.BAR2.BAR_TEST
+	ok 3 pci_ep_bar.BAR2.BAR_TEST
+	#  RUN           pci_ep_bar.BAR3.BAR_TEST ...
+	#            OK  pci_ep_bar.BAR3.BAR_TEST
+	ok 4 pci_ep_bar.BAR3.BAR_TEST
+	#  RUN           pci_ep_bar.BAR4.BAR_TEST ...
+	#            OK  pci_ep_bar.BAR4.BAR_TEST
+	ok 5 pci_ep_bar.BAR4.BAR_TEST
+	#  RUN           pci_ep_bar.BAR5.BAR_TEST ...
+	#            OK  pci_ep_bar.BAR5.BAR_TEST
+	ok 6 pci_ep_bar.BAR5.BAR_TEST
+	#  RUN           pci_ep_basic.CONSECUTIVE_BAR_TEST ...
+	#            OK  pci_ep_basic.CONSECUTIVE_BAR_TEST
+	ok 7 pci_ep_basic.CONSECUTIVE_BAR_TEST
+	#  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
+	#            OK  pci_ep_basic.LEGACY_IRQ_TEST
+	ok 8 pci_ep_basic.LEGACY_IRQ_TEST
+	#  RUN           pci_ep_basic.MSI_TEST ...
+	#            OK  pci_ep_basic.MSI_TEST
+	ok 9 pci_ep_basic.MSI_TEST
+	#  RUN           pci_ep_basic.MSIX_TEST ...
+	#            OK  pci_ep_basic.MSIX_TEST
+	ok 10 pci_ep_basic.MSIX_TEST
+	#  RUN           pci_ep_data_transfer.memcpy.READ_TEST ...
+	#            OK  pci_ep_data_transfer.memcpy.READ_TEST
+	ok 11 pci_ep_data_transfer.memcpy.READ_TEST
+	#  RUN           pci_ep_data_transfer.memcpy.WRITE_TEST ...
+	#            OK  pci_ep_data_transfer.memcpy.WRITE_TEST
+	ok 12 pci_ep_data_transfer.memcpy.WRITE_TEST
+	#  RUN           pci_ep_data_transfer.memcpy.COPY_TEST ...
+	#            OK  pci_ep_data_transfer.memcpy.COPY_TEST
+	ok 13 pci_ep_data_transfer.memcpy.COPY_TEST
+	#  RUN           pci_ep_data_transfer.dma.READ_TEST ...
+	#            OK  pci_ep_data_transfer.dma.READ_TEST
+	ok 14 pci_ep_data_transfer.dma.READ_TEST
+	#  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
+	#            OK  pci_ep_data_transfer.dma.WRITE_TEST
+	ok 15 pci_ep_data_transfer.dma.WRITE_TEST
+	#  RUN           pci_ep_data_transfer.dma.COPY_TEST ...
+	#            OK  pci_ep_data_transfer.dma.COPY_TEST
+	ok 16 pci_ep_data_transfer.dma.COPY_TEST
+	# PASSED: 16 / 16 tests passed.
+	# Totals: pass:16 fail:0 xfail:0 xpass:0 skip:0 error:0
+
+
+Testcase 16 (pci_ep_data_transfer.dma.COPY_TEST) will fail for most of the DMA
+capable endpoint controllers due to the absence of the MEMCPY over DMA. For such
+controllers, it is advisable to skip the forementioned testcase using below
+command::
+
+	# pci_endpoint_test -f pci_ep_bar -f pci_ep_basic -v memcpy -T COPY_TEST -v dma
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2401e973c359..50931cd6aff2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -72,6 +72,7 @@ TARGETS += net/packetdrill
 TARGETS += net/rds
 TARGETS += net/tcp_ao
 TARGETS += nsfs
+TARGETS += pci_endpoint
 TARGETS += pcie_bwctrl
 TARGETS += perf_events
 TARGETS += pidfd
diff --git a/tools/testing/selftests/pci_endpoint/.gitignore b/tools/testing/selftests/pci_endpoint/.gitignore
index 29ab47c48484..6a4837a3e034 100644
--- a/tools/testing/selftests/pci_endpoint/.gitignore
+++ b/tools/testing/selftests/pci_endpoint/.gitignore
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-*.o
-pcitest
+pci_endpoint_test
diff --git a/tools/testing/selftests/pci_endpoint/Build b/tools/testing/selftests/pci_endpoint/Build
deleted file mode 100644
index c375aea21790..000000000000
--- a/tools/testing/selftests/pci_endpoint/Build
+++ /dev/null
@@ -1 +0,0 @@
-pcitest-y += pcitest.o
diff --git a/tools/testing/selftests/pci_endpoint/Makefile b/tools/testing/selftests/pci_endpoint/Makefile
index 3c6fe18e32cc..bf21ebf20b4a 100644
--- a/tools/testing/selftests/pci_endpoint/Makefile
+++ b/tools/testing/selftests/pci_endpoint/Makefile
@@ -1,58 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-include ../../../scripts/Makefile.include
+CFLAGS += -O2 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
+LDFLAGS += -lrt -lpthread -lm
 
-bindir ?= /usr/bin
+TEST_GEN_PROGS = pci_endpoint_test
 
-ifeq ($(srctree),)
-srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
-endif
-
-# Do not use make's built-in rules
-# (this improves performance and avoids hard-to-debug behaviour);
-MAKEFLAGS += -r
-
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
-
-ALL_TARGETS := pcitest
-ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-
-SCRIPTS := pcitest.sh
-
-all: $(ALL_PROGRAMS)
-
-export srctree OUTPUT CC LD CFLAGS
-include $(srctree)/tools/build/Makefile.include
-
-#
-# We need the following to be outside of kernel tree
-#
-$(OUTPUT)include/linux/: ../../../../include/uapi/linux/
-	mkdir -p $(OUTPUT)include/linux/ 2>&1 || true
-	ln -sf $(CURDIR)/../../../../include/uapi/linux/pcitest.h $@
-
-$(info ${CURDIR})
-prepare: $(OUTPUT)include/linux/
-
-PCITEST_IN := $(OUTPUT)pcitest-in.o
-$(PCITEST_IN): prepare FORCE
-	$(Q)$(MAKE) $(build)=pcitest
-$(OUTPUT)pcitest: $(PCITEST_IN)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
-
-clean:
-	rm -f $(ALL_PROGRAMS)
-	rm -rf $(OUTPUT)include/
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-
-install: $(ALL_PROGRAMS)
-	install -d -m 755 $(DESTDIR)$(bindir);		\
-	for program in $(ALL_PROGRAMS); do		\
-		install $$program $(DESTDIR)$(bindir);	\
-	done;						\
-	for script in $(SCRIPTS); do			\
-		install $$script $(DESTDIR)$(bindir);	\
-	done
-
-FORCE:
-
-.PHONY: all install clean FORCE prepare
+include ../lib.mk
diff --git a/tools/testing/selftests/pci_endpoint/config b/tools/testing/selftests/pci_endpoint/config
new file mode 100644
index 000000000000..7cdcf117db8d
--- /dev/null
+++ b/tools/testing/selftests/pci_endpoint/config
@@ -0,0 +1,4 @@
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_ENDPOINT_TEST=m
diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
new file mode 100644
index 000000000000..c267b822c108
--- /dev/null
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kselftest for PCI Endpoint Subsystem
+ *
+ * Copyright (c) 2022 Samsung Electronics Co., Ltd.
+ *             https://www.samsung.com
+ * Author: Aman Gupta <aman1.gupta@samsung.com>
+ *
+ * Copyright (c) 2024, Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include "../../../../include/uapi/linux/pcitest.h"
+
+#include "../kselftest_harness.h"
+
+#define pci_ep_ioctl(cmd, arg)			\
+({						\
+	ret = ioctl(self->fd, cmd, arg);	\
+	ret = ret < 0 ? -errno : 0;		\
+})
+
+static const char *test_device = "/dev/pci-endpoint-test.0";
+static const unsigned long test_size[5] = { 1, 1024, 1025, 1024000, 1024001 };
+
+FIXTURE(pci_ep_bar)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pci_ep_bar)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+}
+
+FIXTURE_TEARDOWN(pci_ep_bar)
+{
+	close(self->fd);
+}
+
+FIXTURE_VARIANT(pci_ep_bar)
+{
+	int barno;
+};
+
+FIXTURE_VARIANT_ADD(pci_ep_bar, BAR0) { .barno = 0 };
+FIXTURE_VARIANT_ADD(pci_ep_bar, BAR1) { .barno = 1 };
+FIXTURE_VARIANT_ADD(pci_ep_bar, BAR2) { .barno = 2 };
+FIXTURE_VARIANT_ADD(pci_ep_bar, BAR3) { .barno = 3 };
+FIXTURE_VARIANT_ADD(pci_ep_bar, BAR4) { .barno = 4 };
+FIXTURE_VARIANT_ADD(pci_ep_bar, BAR5) { .barno = 5 };
+
+TEST_F(pci_ep_bar, BAR_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_BAR, variant->barno);
+	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
+}
+
+FIXTURE(pci_ep_basic)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pci_ep_basic)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+}
+
+FIXTURE_TEARDOWN(pci_ep_basic)
+{
+	close(self->fd);
+}
+
+TEST_F(pci_ep_basic, CONSECUTIVE_BAR_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_BARS, 0);
+	EXPECT_FALSE(ret) TH_LOG("Consecutive BAR test failed");
+}
+
+TEST_F(pci_ep_basic, LEGACY_IRQ_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 0);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set Legacy IRQ type");
+
+	pci_ep_ioctl(PCITEST_LEGACY_IRQ, 0);
+	EXPECT_FALSE(ret) TH_LOG("Test failed for Legacy IRQ");
+}
+
+TEST_F(pci_ep_basic, MSI_TEST)
+{
+	int ret, i;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+
+	for (i = 1; i <= 32; i++) {
+		pci_ep_ioctl(PCITEST_MSI, i);
+		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI%d", i);
+	}
+}
+
+TEST_F(pci_ep_basic, MSIX_TEST)
+{
+	int ret, i;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 2);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI-X IRQ type");
+
+	for (i = 1; i <= 2048; i++) {
+		pci_ep_ioctl(PCITEST_MSIX, i);
+		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI-X%d", i);
+	}
+}
+
+FIXTURE(pci_ep_data_transfer)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pci_ep_data_transfer)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+}
+
+FIXTURE_TEARDOWN(pci_ep_data_transfer)
+{
+	close(self->fd);
+}
+
+FIXTURE_VARIANT(pci_ep_data_transfer)
+{
+	bool use_dma;
+};
+
+FIXTURE_VARIANT_ADD(pci_ep_data_transfer, memcpy)
+{
+	.use_dma = false,
+};
+
+FIXTURE_VARIANT_ADD(pci_ep_data_transfer, dma)
+{
+	.use_dma = true,
+};
+
+TEST_F(pci_ep_data_transfer, READ_TEST)
+{
+	struct pci_endpoint_test_xfer_param param = {};
+	int ret, i;
+
+	if (variant->use_dma)
+		param.flags = PCITEST_FLAGS_USE_DMA;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+
+	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
+		param.size = test_size[i];
+		pci_ep_ioctl(PCITEST_READ, &param);
+		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
+					 test_size[i]);
+	}
+}
+
+TEST_F(pci_ep_data_transfer, WRITE_TEST)
+{
+	struct pci_endpoint_test_xfer_param param = {};
+	int ret, i;
+
+	if (variant->use_dma)
+		param.flags = PCITEST_FLAGS_USE_DMA;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+
+	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
+		param.size = test_size[i];
+		pci_ep_ioctl(PCITEST_WRITE, &param);
+		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
+					 test_size[i]);
+	}
+}
+
+TEST_F(pci_ep_data_transfer, COPY_TEST)
+{
+	struct pci_endpoint_test_xfer_param param = {};
+	int ret, i;
+
+	if (variant->use_dma)
+		param.flags = PCITEST_FLAGS_USE_DMA;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
+
+	for (i = 0; i < ARRAY_SIZE(test_size); i++) {
+		param.size = test_size[i];
+		pci_ep_ioctl(PCITEST_COPY, &param);
+		EXPECT_FALSE(ret) TH_LOG("Test failed for size (%ld)",
+					 test_size[i]);
+	}
+}
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pci_endpoint/pcitest.c b/tools/testing/selftests/pci_endpoint/pcitest.c
deleted file mode 100644
index b96cc118839b..000000000000
--- a/tools/testing/selftests/pci_endpoint/pcitest.c
+++ /dev/null
@@ -1,265 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/**
- * Userspace PCI Endpoint Test Module
- *
- * Copyright (C) 2017 Texas Instruments
- * Author: Kishon Vijay Abraham I <kishon@ti.com>
- */
-
-#include <errno.h>
-#include <fcntl.h>
-#include <stdbool.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/ioctl.h>
-#include <unistd.h>
-
-#include <linux/pcitest.h>
-
-static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
-
-struct pci_test {
-	char		*device;
-	char		barnum;
-	bool		consecutive_bar_test;
-	bool		legacyirq;
-	unsigned int	msinum;
-	unsigned int	msixnum;
-	int		irqtype;
-	bool		set_irqtype;
-	bool		get_irqtype;
-	bool		clear_irq;
-	bool		read;
-	bool		write;
-	bool		copy;
-	unsigned long	size;
-	bool		use_dma;
-};
-
-static int run_test(struct pci_test *test)
-{
-	struct pci_endpoint_test_xfer_param param = {};
-	int ret = -EINVAL;
-	int fd;
-
-	fd = open(test->device, O_RDWR);
-	if (fd < 0) {
-		perror("can't open PCI Endpoint Test device");
-		return -ENODEV;
-	}
-
-	if (test->barnum >= 0 && test->barnum <= 5) {
-		ret = ioctl(fd, PCITEST_BAR, test->barnum);
-		fprintf(stdout, "BAR%d:\t\t", test->barnum);
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->consecutive_bar_test) {
-		ret = ioctl(fd, PCITEST_BARS);
-		fprintf(stdout, "Consecutive BAR test:\t\t");
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->set_irqtype) {
-		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
-		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->get_irqtype) {
-		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
-		fprintf(stdout, "GET IRQ TYPE:\t\t");
-		if (ret < 0) {
-			fprintf(stdout, "NOT OKAY\n");
-		} else {
-			fprintf(stdout, "%s\n", irq[ret]);
-			ret = 0;
-		}
-	}
-
-	if (test->clear_irq) {
-		ret = ioctl(fd, PCITEST_CLEAR_IRQ);
-		fprintf(stdout, "CLEAR IRQ:\t\t");
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->legacyirq) {
-		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
-		fprintf(stdout, "LEGACY IRQ:\t");
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->msinum > 0 && test->msinum <= 32) {
-		ret = ioctl(fd, PCITEST_MSI, test->msinum);
-		fprintf(stdout, "MSI%u:\t\t", test->msinum);
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->msixnum > 0 && test->msixnum <= 2048) {
-		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
-		fprintf(stdout, "MSI-X%u:\t\t", test->msixnum);
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->write) {
-		param.size = test->size;
-		if (test->use_dma)
-			param.flags = PCITEST_FLAGS_USE_DMA;
-		ret = ioctl(fd, PCITEST_WRITE, &param);
-		fprintf(stdout, "WRITE (%7lu bytes):\t\t", test->size);
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->read) {
-		param.size = test->size;
-		if (test->use_dma)
-			param.flags = PCITEST_FLAGS_USE_DMA;
-		ret = ioctl(fd, PCITEST_READ, &param);
-		fprintf(stdout, "READ (%7lu bytes):\t\t", test->size);
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	if (test->copy) {
-		param.size = test->size;
-		if (test->use_dma)
-			param.flags = PCITEST_FLAGS_USE_DMA;
-		ret = ioctl(fd, PCITEST_COPY, &param);
-		fprintf(stdout, "COPY (%7lu bytes):\t\t", test->size);
-		if (ret < 0)
-			fprintf(stdout, "NOT OKAY\n");
-		else
-			fprintf(stdout, "OKAY\n");
-	}
-
-	fflush(stdout);
-	close(fd);
-	return ret;
-}
-
-int main(int argc, char **argv)
-{
-	int c;
-	struct pci_test *test;
-
-	test = calloc(1, sizeof(*test));
-	if (!test) {
-		perror("Fail to allocate memory for pci_test\n");
-		return -ENOMEM;
-	}
-
-	/* since '0' is a valid BAR number, initialize it to -1 */
-	test->barnum = -1;
-
-	/* set default size as 100KB */
-	test->size = 0x19000;
-
-	/* set default endpoint device */
-	test->device = "/dev/pci-endpoint-test.0";
-
-	while ((c = getopt(argc, argv, "D:b:Cm:x:i:deIlhrwcs:")) != EOF)
-	switch (c) {
-	case 'D':
-		test->device = optarg;
-		continue;
-	case 'b':
-		test->barnum = atoi(optarg);
-		if (test->barnum < 0 || test->barnum > 5)
-			goto usage;
-		continue;
-	case 'C':
-		test->consecutive_bar_test = true;
-		continue;
-	case 'l':
-		test->legacyirq = true;
-		continue;
-	case 'm':
-		test->msinum = atoi(optarg);
-		if (test->msinum < 1 || test->msinum > 32)
-			goto usage;
-		continue;
-	case 'x':
-		test->msixnum = atoi(optarg);
-		if (test->msixnum < 1 || test->msixnum > 2048)
-			goto usage;
-		continue;
-	case 'i':
-		test->irqtype = atoi(optarg);
-		if (test->irqtype < 0 || test->irqtype > 2)
-			goto usage;
-		test->set_irqtype = true;
-		continue;
-	case 'I':
-		test->get_irqtype = true;
-		continue;
-	case 'r':
-		test->read = true;
-		continue;
-	case 'w':
-		test->write = true;
-		continue;
-	case 'c':
-		test->copy = true;
-		continue;
-	case 'e':
-		test->clear_irq = true;
-		continue;
-	case 's':
-		test->size = strtoul(optarg, NULL, 0);
-		continue;
-	case 'd':
-		test->use_dma = true;
-		continue;
-	case 'h':
-	default:
-usage:
-		fprintf(stderr,
-			"usage: %s [options]\n"
-			"Options:\n"
-			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
-			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
-			"\t-C			Consecutive BAR test\n"
-			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
-			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
-			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
-			"\t-e			Clear IRQ\n"
-			"\t-I			Get current IRQ type configured\n"
-			"\t-d			Use DMA\n"
-			"\t-l			Legacy IRQ test\n"
-			"\t-r			Read buffer test\n"
-			"\t-w			Write buffer test\n"
-			"\t-c			Copy buffer test\n"
-			"\t-s <size>		Size of buffer {default: 100KB}\n"
-			"\t-h			Print this help message\n",
-			argv[0]);
-		return -EINVAL;
-	}
-
-	return run_test(test);
-}
diff --git a/tools/testing/selftests/pci_endpoint/pcitest.sh b/tools/testing/selftests/pci_endpoint/pcitest.sh
deleted file mode 100644
index 770f4d6df34b..000000000000
--- a/tools/testing/selftests/pci_endpoint/pcitest.sh
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "BAR tests"
-echo
-
-bar=0
-
-while [ $bar -lt 6 ]
-do
-	pcitest -b $bar
-	bar=`expr $bar + 1`
-done
-pcitest -C
-echo
-
-echo "Interrupt tests"
-echo
-
-pcitest -i 0
-pcitest -l
-
-pcitest -i 1
-msi=1
-
-while [ $msi -lt 33 ]
-do
-        pcitest -m $msi
-        msi=`expr $msi + 1`
-done
-echo
-
-pcitest -i 2
-msix=1
-
-while [ $msix -lt 2049 ]
-do
-        pcitest -x $msix
-        msix=`expr $msix + 1`
-done
-echo
-
-echo "Read Tests"
-echo
-
-pcitest -i 1
-
-pcitest -r -s 1
-pcitest -r -s 1024
-pcitest -r -s 1025
-pcitest -r -s 1024000
-pcitest -r -s 1024001
-echo
-
-echo "Write Tests"
-echo
-
-pcitest -w -s 1
-pcitest -w -s 1024
-pcitest -w -s 1025
-pcitest -w -s 1024000
-pcitest -w -s 1024001
-echo
-
-echo "Copy Tests"
-echo
-
-pcitest -c -s 1
-pcitest -c -s 1024
-pcitest -c -s 1025
-pcitest -c -s 1024000
-pcitest -c -s 1024001
-echo
-- 
2.25.1


