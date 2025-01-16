Return-Path: <linux-kselftest+bounces-24668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C37A1407C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 18:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C7F1696E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A222D4DC;
	Thu, 16 Jan 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyE9E+71"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026122BAD9
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047827; cv=none; b=JliCzJ5i80tI/gAcUG7CxM5Qw/s+a3ad8ehzZ3rjsD5IgZWwYU+h7I6E309hIZRGjt6kwKR43dHIiFeWhq74Wcpyxe5ySbWH/74hjLpjPzpiuO1AQcz7nXdZRmfXYm/lcju+/kCUry3MrtJwHc3EKBc8yd8y7wn/a4N0S7VmW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047827; c=relaxed/simple;
	bh=Cfls029jt6+1ViuA9omlvupSKnHGsOVELSd35jNeE50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p6hC7vDnz3xcCYVDMXZbo+cWvPh1FYCT2YH9BCdnxe66vq6bQ7kdkA9vEoOAmvq5v8uuBwAfpw2sF0lXL3qn++AWCI40pWn5VyOZ5gY9qCOWts1qXGp4CAr8WxoZpCXc4jVFYEQMX5rU8gpmhJI0TB85KYutYZaY3Tx6mNsVKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyE9E+71; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166360285dso23431235ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047825; x=1737652625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfmKxAUKcXZh1619YtkrCCyWijhCyYLpsgHJ3rMHb7w=;
        b=jyE9E+71SoJ+JhA+9wA/PxCkbh0c90ex8MWW4y6MPT4Vl5NRs6FoyevbTM17xEbtXp
         clOawCyi1boGuL84okCDU3xtjP+1kj0t2eJRNvhKZ8LtYTfnUX6VLES2spmcmAzbbVTg
         6NXK9gW+8mPeqhk04Q2btgAB6Vi0R/Ys11NvchSVhqyYH46l28jYegLY9eLMmyX7uKqe
         p1QPzOhpicI81mjkKXHlD1Wh1816VKOAehhBE9g76GtGa31AvIOYiHjRQBn9EMnXNaR7
         aurQ6Kd6XZCf1kvNk5fv5eiNvNQ6MwcpskQwWVpPzyV1ciVWI8PZtOrX8jmaDeTnOmtW
         3PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047825; x=1737652625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfmKxAUKcXZh1619YtkrCCyWijhCyYLpsgHJ3rMHb7w=;
        b=r1tCt763tYKVu629FrHObACdv4byeeS927h+5BQDNV29FfuGioPV86sDG2xqjuAs5p
         7jXmw3+uKrWWFDIiksYfljFjISh8k50DJXKaH0twubQr0W16n/yaJ0jlVOIodjLd2sqV
         NCrxO8HnreMKehW1LOKnPFtkWRA6LLSvT6eluDDYO78froFOh14LxrcrvtiUFRDoZcc1
         10djkYH8uBnfuIn6jwfopMOM9YNv59S4h/GriePbbJ9br5rblMb/3qiIOm/TDe7gh2yl
         cVZEoAxcb3vxRBKw/2sN2ULIxtsdwljjm0G4f3y5AYZBjNIukmPMnPm9eiajdrkdo1Ye
         Q3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa7fsrmQzFqPm1jM7wOHE+kEEqNLnPq0iIZqFw8VNXzWwfp2gnSKdUMLSgk66Z8sQTID4E9SluBP/vFpOhLQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVGleQnAebvLDFUTkrnRTfVE6kP26lf8duGucWeNieiDXErVe
	DcCw0XlnT58irCHzHo6Chy/15pPVTpw1j9UxqPO652B4iRm1PKwOZxgpauKXvA==
X-Gm-Gg: ASbGncv3OxyoOxqcgBpGXUrm31I+BdQrxcgHOptgBueUBnQOL/hBcXYZRfIJ60DTeGd
	9yXjMKLRe4W0PSjkHmpmrP1zC7sb2KwcZQXZ82LEjl1RqZO7yknMBeYkUwmJ/r7trQ8DksR3gkr
	VAYdWVij+d3ZUY3P1P8iTea9xY+LoZ0cP3oAhU3OPoqhOSiPvOd+eBpcKiWuarTLj0+56JD3sOX
	DVWzNUev/GgEI7wSSQ6WAqedYPvxm/Bf3MTM7LxmJf0pHO/i3njzMkLJP/Lo2nSzgZfcP/kDrAk
	4Pm2OGrll1US5H+aWZhm2g==
X-Google-Smtp-Source: AGHT+IGHCqVnUp8laxBsrAyjTEfGfl8hihKER1EIrc5smmXCIpNgLm5tAWS5wI017Ij/vv1nkBYrHA==
X-Received: by 2002:a05:6a00:1bca:b0:725:e015:9082 with SMTP id d2e1a72fcca58-72d21f11f2dmr41551752b3a.5.1737047825224;
        Thu, 16 Jan 2025 09:17:05 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f1846sm275155b3a.15.2025.01.16.09.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:17:04 -0800 (PST)
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
Subject: [PATCH v6 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Thu, 16 Jan 2025 22:46:46 +0530
Message-Id: <20250116171650.33585-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series carries forward the effort to add Kselftest for PCI Endpoint
Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
based on another patch that fixes the return values of IOCTLs in
pci_endpoint_test driver and did many cleanups. Since the resulting work
modified the initial version substantially, I took over the authorship.

This series also incorporates the review comment by Shuah Khan [2] to move the
existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
migrating to Kselftest framework. I made sure that the tests are executable in
each commit and updated documentation accordingly.

- Mani

[1] https://lore.kernel.org/linux-pci/20221007053934.5188-1-aman1.gupta@samsung.com
[2] https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org

Changes in v6:

* Fixed the documentation to pass max MSI and MSI-X count to configfs
* Collected tags

Changes in v5:

* Incorporated comments from Niklas
* Added a patch to fix the DMA MEMCPY check in pci-epf-test driver
* Collected tags
* Rebased on top of pci/next 0333f56dbbf7ef6bb46d2906766c3e1b2a04a94d

Changes in v4:

* Dropped the BAR fix patches and submitted them separately:
  https://lore.kernel.org/linux-pci/20241231130224.38206-1-manivannan.sadhasivam@linaro.org/
* Rebased on top of pci/next 9e1b45d7a5bc0ad20f6b5267992da422884b916e

Changes in v3:

* Collected tags.
* Added a note about failing testcase 10 and command to skip it in
  documentation.
* Removed Aman Gupta and Padmanabhan Rajanbabu from CC as their addresses are
  bouncing.

Changes in v2:

* Added a patch that fixes return values of IOCTL in pci_endpoint_test driver
* Moved the existing tests to new location before migrating
* Added a fix for BARs on Qcom devices
* Updated documentation and also added fixture variants for memcpy & DMA modes


Manivannan Sadhasivam (4):
  PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
  misc: pci_endpoint_test: Fix the return value of IOCTL
  selftests: Move PCI Endpoint tests from tools/pci to Kselftests
  selftests: pci_endpoint: Migrate to Kselftest framework

 Documentation/PCI/endpoint/pci-test-howto.rst | 174 +++++-------
 MAINTAINERS                                   |   2 +-
 drivers/misc/pci_endpoint_test.c              | 255 +++++++++--------
 drivers/pci/endpoint/functions/pci-epf-test.c |   4 +-
 tools/pci/Build                               |   1 -
 tools/pci/Makefile                            |  58 ----
 tools/pci/pcitest.c                           | 264 ------------------
 tools/pci/pcitest.sh                          |  73 -----
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/pci_endpoint/.gitignore |   2 +
 tools/testing/selftests/pci_endpoint/Makefile |   7 +
 tools/testing/selftests/pci_endpoint/config   |   4 +
 .../pci_endpoint/pci_endpoint_test.c          | 221 +++++++++++++++
 13 files changed, 437 insertions(+), 629 deletions(-)
 delete mode 100644 tools/pci/Build
 delete mode 100644 tools/pci/Makefile
 delete mode 100644 tools/pci/pcitest.c
 delete mode 100644 tools/pci/pcitest.sh
 create mode 100644 tools/testing/selftests/pci_endpoint/.gitignore
 create mode 100644 tools/testing/selftests/pci_endpoint/Makefile
 create mode 100644 tools/testing/selftests/pci_endpoint/config
 create mode 100644 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c

-- 
2.25.1


