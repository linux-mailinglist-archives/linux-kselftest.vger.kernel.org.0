Return-Path: <linux-kselftest+bounces-23793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D39FEF89
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2541883210
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2619D88F;
	Tue, 31 Dec 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hgtjg3Ll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6419CD1D
	for <linux-kselftest@vger.kernel.org>; Tue, 31 Dec 2024 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650839; cv=none; b=WXVr/hVTDoUdW4Amkl6lvdF4Y+MXLQWc20z6/lz56+a7LVjouNuN88k7iMH65ZiWP/tC/2d9qXDxVI1CTx9xspF+XF21nEYNprw+DgYmQjtmKcVupHLf3UlW+r6AXW9fzL6tZoAZq8bZk0kQAx0rp1q1FXWdt2h7kyHcisLNUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650839; c=relaxed/simple;
	bh=GZGMWyQUBw5pvCtQOnp4NjRcrAnPqiX8Obv8YFOqrxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SI7PC3aF+e9JPx79eypvVdUjV/H528eMVqG1Y+rx04MSgDClkGAcTAZdo5SNpiXRbRFE/YIC6KncflCmNPOtOCeH46Oq00ylmWFiHIPfqzN73NazYvv8YicgDEFz3DmaA0kjjZDSG0vD8e2fy+96neil4SwXQMNlT9gNPo+FmiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hgtjg3Ll; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21619108a6bso124268105ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Dec 2024 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735650837; x=1736255637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZgp4jfle0ZGJPd2mHyE73pz/6DhpqLqrjCBngOXHZ4=;
        b=Hgtjg3LlF6mWFgQoo2+KBkF1BmXy0IEDZmvkN1plRzxo5cSpFNxZhTXVvUQj86fdU0
         84k803cFmw4ESrQOj++TFveRCM+oTdInGzO0B4B+NJ4mxykWc/RV5nJQpg5yKdx+UTYP
         yp/xHaf6SEo4H68GFpKT8XCztI1PXo+HLtrM8mc2suo72YjHLfyFuo4zK/z+f+Nvsevz
         9I7WefFLZ/uIkemLkVgC9T8TeUD6EhN6urnTl/tRTw7qdf8uZwVVGmWfyTm/rw4PuiRL
         89mBkZdcgIYcgigyii3OFFA8JoMe5/2onSDEuTFeTLSOTy8YLtMr5rN17FnFuvUztPUL
         kIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650837; x=1736255637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZgp4jfle0ZGJPd2mHyE73pz/6DhpqLqrjCBngOXHZ4=;
        b=jnwclyfQwDlhPFZpPKNuaHfc1wl49QLzm64ZDTqgNBF7f5WR/9RYduhSbG3p2rebZ6
         vsJ/molLeO0jqqlCl+fkXTio1aWetH4zD0wCqJFvbaROYJmy5PYv5F7myZUXLbO3RCjX
         IcdhewVrGeuUU87/1r6B/8aPEPgtPBV8wVxxk6gT0cunU1LS3JqPOqepd/V+dRyOHC49
         phD+lneZ5qscEL/+g3rzjvVLVoAws5Eu9u3beVPFW6qpkg2J4Gjmv07BOxTKGuMgpDJQ
         GcArrXmILj8lR/fkMcU87DKwvb8ChaUX77xlHXFboZEG5hUNaw9Q+ogXKpk4dLq4Irzj
         /GqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqs7jWCWpkILYtOVgdNpIqq8ZPQKSTTlPdYZU5GFU4i/PjfV9k/BnVS5D3y09oFkAZBDqOxtes2sWBbASplkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfb4SjLYBetEtfSZakTeHHyrkwh6VTvHpj/OhocU8OlQD3Hx/
	PNknJdfsfM8A9ObBmKwbby53JSHZsXEjOfnDvQqB98bAw+B6djmcldXlD/woyA==
X-Gm-Gg: ASbGnctlW348XWlUwVJNBWjKho/5C1xE2EqBZLuq8ZwzcBRGvy3WF0REutEY3f2F7fh
	BQopePoGNX+RlQxvMqB5FeRW10aMEma9IMf7cLg0o8qoQHh3Mf37AVeChNHTjjJWF6Gb/N/dPSr
	Vv09ah9fntXgVkl6oWuSJeQPDMyNnzDqoyRZCpQ8XHKIHCzD3Uq+zVVJ3CX4LjhqeyZbdeAt3oT
	tVoQWW7YOC65suQEAvixso1wJjUJpOZYyju62TKLSAaupRLRRJiR9WeXyhIZ8CIWle9NzfkhbsK
	V/ZfqBT/LDc=
X-Google-Smtp-Source: AGHT+IGEg0Sm2+Gv2ELKmcTe/s3eXcD2xxWC9XS2B49nFl0hlJ0LsI4H01w3iCdwEken+HN3bGEavA==
X-Received: by 2002:a05:6a00:1152:b0:725:f4c6:6b71 with SMTP id d2e1a72fcca58-72abde9eb64mr62183286b3a.20.1735650837496;
        Tue, 31 Dec 2024 05:13:57 -0800 (PST)
Received: from localhost.localdomain ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad6cc885sm20994862b3a.0.2024.12.31.05.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:13:57 -0800 (PST)
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
Subject: [PATCH v4 0/3] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Tue, 31 Dec 2024 18:43:38 +0530
Message-Id: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (3):
  misc: pci_endpoint_test: Fix the return value of IOCTL
  selftests: Move PCI Endpoint tests from tools/pci to Kselftests
  selftests: pci_endpoint: Migrate to Kselftest framework

 Documentation/PCI/endpoint/pci-test-howto.rst | 155 ++++------
 MAINTAINERS                                   |   2 +-
 drivers/misc/pci_endpoint_test.c              | 250 ++++++++---------
 tools/pci/Build                               |   1 -
 tools/pci/Makefile                            |  58 ----
 tools/pci/pcitest.c                           | 264 ------------------
 tools/pci/pcitest.sh                          |  73 -----
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/pci_endpoint/.gitignore |   2 +
 tools/testing/selftests/pci_endpoint/Makefile |   7 +
 tools/testing/selftests/pci_endpoint/config   |   4 +
 .../pci_endpoint/pci_endpoint_test.c          | 194 +++++++++++++
 12 files changed, 386 insertions(+), 625 deletions(-)
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


