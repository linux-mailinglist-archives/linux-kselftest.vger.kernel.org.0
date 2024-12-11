Return-Path: <linux-kselftest+bounces-23158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BBD9EC64D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0F188B04D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4D1CC899;
	Wed, 11 Dec 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kw9QLeIG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F141C5490
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904096; cv=none; b=tnpDIkYRATJWww38mKAAzv3weWq4bEHH9xvWklolI89y+RfwNDDkQuRrJLi6WkqoWqmzXe683EwFcZ7miZLT7jUmuFDs0rD082M63FUJGttZHiNN3devlwaC5J1I7j9gtrqJQp4oM8IFFa/Dab/LXkOha+xSl1kjGK2dCAhBG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904096; c=relaxed/simple;
	bh=QDCClO9+ruB6VB/58Ynw02ygmft+gwI7j3Au7lq3IGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c8COuMbFEM2u0rlu8ZJfu5XgFpNkxdIZ3v88HEaB4+s0uUZJkzWBGlTrOOZ36NiXnTwVa9kDKXXS/rNnQWD27ZexxznO1zFS/eMzKwnbls4Lzq/tbOv1K5jQ5xbRT4Iao0OjNBKButY+yU1B29baOExSng7TJQ3eCzFC774mD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kw9QLeIG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2162c0f6a39so3884905ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 00:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904093; x=1734508893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEGhXU+QLmJOzGqN5qm96MkDiJr/KItzUXBN99PYXic=;
        b=Kw9QLeIGLVBhc/sFBNOd/koF+J7e7iofTdd3cKtJy5akBc14RHKsVd0Jzy5jgidxTA
         aFmNJ43oPSrEF2jQfyIxyRn+M4evk2CLGUm1qa1G9Bn3xpI8GjjQlTr2utiPWvAojg9M
         CWD1YBryWRu1kLH4NPjKQ9XHpZYO4TcZgRkVTxOBBLmiLEkxvXEivsx4wAin4CuRZquV
         Sylj1ZWyX+hl8zTGkxNruJ3hnbeVemJu8HEKrPHN/pmue0Td5b+84846GJH8TRam74Iy
         D/64YFOyV/zO66lnJbU4Cf+4m4fumOddtCtj8CyVRx0vA41DOaxaHy/Pv0ziSNak6tw1
         9dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904093; x=1734508893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEGhXU+QLmJOzGqN5qm96MkDiJr/KItzUXBN99PYXic=;
        b=j6Ap51+Ixwd+vwh3ovsqgXfQdogM3I/k0xpFZeS2OUnifW5VlpevsELt3cnLj0BOP/
         U3Uju6Bg55nNhA9nOz54WKamr4UiQR3IksSabI6mUQj2hCuHeacm7QD7vd5U5rFxJBVQ
         YK8xqT+TexFzq3otO9e86x5ua2hhsrMs9+JOaKbgSuACaNR7Gwr53S58ZTC54+6Y7nsw
         GEbFa4pIgUDDIixwvE892vro6WdTjjDslHVSCm/LPD17Bl76QgdQ3eJcYvULIILs6/YJ
         bIbPewrD0kSJDxz+dLvvdTi86DizthbR6hEldCuzvZZvAkrgAhwg+PWvV3/OMz0MY+p+
         QDLA==
X-Forwarded-Encrypted: i=1; AJvYcCVDUvSwSJV94kBmNIid38NX6Z2Eg6rSsTk/X0nEEile/OwGOIXbL3fqqNnaQNOrCbXEYzRso8z0sI36fnSSNJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOKKh9mBiIsykt3QKxFa+Y7XajnrhkQGoMlQbKXuzUPIV9CGm
	dzyojxgyG6wY+Fs6jwC+VdXvFIyI7DKQuS708bz7/pUqIvo3alGqr7fhM5MOoA==
X-Gm-Gg: ASbGncsRgFP2ZJajuHTVFIKWFWhTpRsEmknBijkKC4X49U23MJg1PogP1CLMDiFTJj6
	h0mOs/k2Z7DAAE4iUPq7cGaV38k2Dcs/BFAbeEeFNvWPhTb5uW9s929r9UjRilK5kguaEJSJeDH
	kM6p8ujHcEk9pLVkF3vJ/EMFGhM8fHiLutUwFbbVLmveBNDOOjYmrlCZ3OmBnD4kRN2Xzl/Yw2V
	lblyHFxxLkzl1VLLfnpTnwMT1JRnVZcDRMoLrBcAeuSRoYSrU/lWkjPWfepoWp5GGXCv0hJHlML
	COnV
X-Google-Smtp-Source: AGHT+IEjpYTPZZfgdWB4UyzQkMZqnr6AOgFIDYrlPTj+b2+sChMPtg1c+as/xrmzdknyus1FwtOTkA==
X-Received: by 2002:a17:90b:1f90:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-2f1287a38a2mr2651334a91.8.1733904093408;
        Wed, 11 Dec 2024 00:01:33 -0800 (PST)
Received: from localhost.localdomain ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b93dsm12929775a91.51.2024.12.11.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:01:32 -0800 (PST)
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
Subject: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Wed, 11 Dec 2024 13:31:01 +0530
Message-Id: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
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

NOTE: Patch 1 is strictly not related to this series, but necessary to execute
Kselftests with Qualcomm Endpoint devices. So this can be merged separately.

- Mani

[1] https://lore.kernel.org/linux-pci/20221007053934.5188-1-aman1.gupta@samsung.com
[2] https://lore.kernel.org/linux-pci/b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org

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
  PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
  misc: pci_endpoint_test: Fix the return value of IOCTL
  selftests: Move PCI Endpoint tests from tools/pci to Kselftests
  selftests: pci_endpoint: Migrate to Kselftest framework

 Documentation/PCI/endpoint/pci-test-howto.rst | 152 ++++-------
 MAINTAINERS                                   |   2 +-
 drivers/misc/pci_endpoint_test.c              | 236 ++++++++---------
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +
 tools/pci/Build                               |   1 -
 tools/pci/Makefile                            |  58 ----
 tools/pci/pcitest.c                           | 250 ------------------
 tools/pci/pcitest.sh                          |  72 -----
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/pci_endpoint/.gitignore |   2 +
 tools/testing/selftests/pci_endpoint/Makefile |   7 +
 tools/testing/selftests/pci_endpoint/config   |   4 +
 .../pci_endpoint/pci_endpoint_test.c          | 186 +++++++++++++
 13 files changed, 373 insertions(+), 602 deletions(-)
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


