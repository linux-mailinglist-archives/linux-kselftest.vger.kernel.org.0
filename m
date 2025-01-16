Return-Path: <linux-kselftest+bounces-24671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93FBA1408D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113AE3AAA6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE136230D02;
	Thu, 16 Jan 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbBr5QPx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92322D4EC
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047840; cv=none; b=XmVk58XXTw7z+gILFaqBhQ1xa9O4QCB1T6gxUNCganCSsTAHQM1ujE++bS+TFysEuC2Uzxdw7Ihxi8rQAbv84zFrFarlpx08GAvAOnbDgxylixpz6WN6+snt91VHs6eFYqg2zsrefBA4epVJFX+VB3rzGcokaV4I/XxeBvqYEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047840; c=relaxed/simple;
	bh=+q6EuSoQRdCStuKR75ZaYH5HhYkEk+3WwLzgqRfh5LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/wCEFqz/B8dXv/GTVMi6L5HFvT9A2svxcWspWVYQeqtr0FHAZ6Q1jZp3q3UU8LD89hPAP9j24uUZAhFyf/qybVba9AUIyAB3dmxGnXr/xzw2Zyp/9lcHHffV3uPrzmnWrPBv8/wVp9m/IyQ1T8vAJZRn8AwvfzpS6zF449BtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbBr5QPx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166022c5caso20395895ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047838; x=1737652638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HMVTtZB5PZNVek3iBGXjvqbfkszo5KlWw3az9DFlFw=;
        b=hbBr5QPxS5wJ/sf9XNXBAAlds/kRRJ7LZdH3eAbhBUJmJj7dNIuMGKITky2R+9+r31
         EbCacVkhgZgKYvxh05KikatJLxEsCQIl+7NaNHc9zcv/LHQDJhjUlwS3fIpYbUjFqlAS
         a8S5tEqyf7LCz3FK5vlLAu0VEusT0SnLyUx8wpaB6uqcrmW/32yFFLmBAdKUxirQ/zFB
         FLuN6qMXHWEZEtrovj/Xg8nW5cmKvWt8661BVv7V4per5RyIUNm6ErTzN6ZpeEW7WmGd
         oTkVIrKSMVPK5mpofWgD9hL7XMnMVHawZAonHkQmWdL/d25jnX514VioAs5+xqKy0JDr
         MzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047838; x=1737652638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HMVTtZB5PZNVek3iBGXjvqbfkszo5KlWw3az9DFlFw=;
        b=kwByGkouS5wWDk59WzoMa3Zrcd4dHVKBh35g3Hz+3CKPds0zRuhWP/coN5hV4joMaO
         ULXyfOPSuVQYo5VTI7n2N2CB1U8zZDH7c8bRdTuyDB5zIG5HPkMFm4fEt4H4sBWVK2vv
         ff2igYxy4SkSe1mobuX8W1Njsf9M1H/4V3BI447qHFtGzVfT+sQizlMVTNyg9CN1MCTS
         /X+UIzuiAdJxae4sWTw8sJNHNjCBl3izonL6qcghQcK4B88qstLK1QKT8E0lD6F9FWcR
         kKEtIESzDLcUS4hvjFyZOH9W/VG+U/Skk+I19KyIDwCPueDOTxA/ky2TRKBywxloubVc
         YJtw==
X-Forwarded-Encrypted: i=1; AJvYcCXoEB3ER84mgySioIJoRgV0n6dJLzEysbx9CWBtv3EzyWtbad0qz9ki3YCaKzZlgNXzmb6A1mlvEAQRoTUylNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2UYZ8rV+gITDW3GGNoiqLRGKT2/pCZWPWr2VNVvAteXyy8/J
	dXctVfylZx9uJK8wb1/aALHWO6JNTZnLdwFi8w45v4tNfgdUU/003BQq3llv5A==
X-Gm-Gg: ASbGncto+76ybavxeLUr5BxCDCOzs1ftTu6bx3SLpCqBvzhGCO+638wpdgAvPMgGni0
	u9q7D6HjXX1FcX9Uw4kY0NOviF7kVKR3QlF111dy2daVIAZT9YJHV/w9/jl/T6nCQbuFZ22PCAI
	hSA2DARprcr6D5Q6iEjnlCAlnaUAutbsxfKqiMfs5T2IV7L6yfV+mD6bfbZWGjOqx643yiDXv4A
	RVvgp6HTEolW7x4kQ2RoAXVhS/a4Gbz5s7pIjD9M8TrgasVFsipzc769vE4sIYSjBoq7CAFSJ+f
	jL4Toy30
X-Google-Smtp-Source: AGHT+IEuUwWU4sucxikCeiRJG0jLZIF3PQjmF7wBgRFqyPOoTlfRakIXx9B6yaNmfRFbdojH/gO9cQ==
X-Received: by 2002:a05:6a00:35c7:b0:725:f153:22d5 with SMTP id d2e1a72fcca58-72d21fd2f25mr50997269b3a.18.1737047838022;
        Thu, 16 Jan 2025 09:17:18 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f1846sm275155b3a.15.2025.01.16.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:17:17 -0800 (PST)
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 3/4] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
Date: Thu, 16 Jan 2025 22:46:49 +0530
Message-Id: <20250116171650.33585-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116171650.33585-1-manivannan.sadhasivam@linaro.org>
References: <20250116171650.33585-1-manivannan.sadhasivam@linaro.org>
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

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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
index e0fcdd8b6434..e96e80d8486d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18002,7 +18002,7 @@ F:	Documentation/PCI/endpoint/*
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


