Return-Path: <linux-kselftest+bounces-24646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8EA13B23
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D679165184
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55722A4F9;
	Thu, 16 Jan 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JmsH+sKH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E7142900
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035479; cv=none; b=SRqWq3bg8PRx87Lp5I6G0wCLiJ/QfOkwBUwruQVbjhvGC1Oj4OuKM8WuI7+uGptr4Q3a676zfGMXue0Wh75AZtXNhL8/Us4ioHyLKZSzKtDf8w5wO4WoZEGGXEfzIo3x237uu0tIwmRC3dDbyAqX5U2hZp96Vq8ymSgUsNrs6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035479; c=relaxed/simple;
	bh=Gp57mcKd4H6V9tMGggL9wEffpyrpwiCBzSwMuIwZN48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMbAdl9ploWyZWWxlMVAZZzRzxtvDWIEHXWtmqHahOLEmMZXbof9xAbaHyTvfJugOBwZl5sVSovmYBBDJndPS5/os1t9cHlSvnWkOOB2lu70B1MkyG/wWAFcvHCAo5y9rRMKcTPfjQvDKXJSbvgQ2Cx83jH16YK6O32TAG/4h+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JmsH+sKH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2efded08c79so1409799a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 05:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737035477; x=1737640277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42ozmyPbA8iS07YaIxZBxB7CkuoT27mqwYUto+/6GVQ=;
        b=JmsH+sKHwzBWgc0Zk5iMf3QdzhWRge4yl/PxNbfW1eIjNsVV3Wm6TlYH5/4TELK6yr
         k2v3+NokId3JPn++CvmjYzNYNeH/9aKSW3XDmQGmKjYB6lWkGCMcYQ8UitNdxR6goNO3
         zy3UT3tbEeNFFP6bbYnJ5AAnar8f2jIW6T1wwXGf1xChwfCD6tkoENtPreR8YJmjlTtW
         OOYH4VnEhf6REuYGPpYlrxFPhdiKb/Gow4687T5PDX2JWBmM8lYHA60sMqx1RYU3/IRA
         nY7nIdVw8HNwX2Sq6Yn3ipqsjJ3vIKxh4QkZG8wjzjn2yZYWkwBWNFYdj0TgWwcqliMJ
         MDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035477; x=1737640277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42ozmyPbA8iS07YaIxZBxB7CkuoT27mqwYUto+/6GVQ=;
        b=TZNymnkFCUArPHI8IvpsgzrVjdoFa9o5m7CKK22rh1MnpwOONGz+72oDyGdFRvSEKz
         gkF6FFnQneMB46ZJPuq8DPBfoETHMZbZ1An9IdNZZuOsmDD9W5HrOGUL7D2qWcR18tTz
         9NPBsLv4cVHfBvrSX7qSWFwtAiNl5qD+s6mvjISHkx6kGTw7vDfPul6Mo3aqI+CwtuqM
         bSqvqtEdlqZNouOy01OlOHoN9HxVe4qNuCQSsifVBq2j1jsg9+uT90Vabt8DBXabbXwZ
         aCmUIqjqGSj+MeVpLcFeu3s0sFrha0Mc8szmuXqEvNkEdc5XfwZEbZ3UGmFKFhqCzzNf
         dagQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5YUagkF3LtHptI8MxN8nBPfLUPGOfAv1NYYL8eTjzTSufpBGrwsW+h3kZ8DwEjwjR7cHfPk6vK3TMDn2ctCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnH9CRdeMkAb/GU0JXMNz6Jym56yBXMJenU3QKXVXuDa2+CZE
	5C3wBMJMsX+5nO5t64czbFn0CHi2KJBPKKXdMeyvQdeGOup/6FQObPql8yLp8Q==
X-Gm-Gg: ASbGnct6OAHszt+tlQMh656659f7DYRnTmdjg+GgLHV+GvS4kOcZw/xg1kZB5Wnznxt
	0eHKwwSqklzQDneTeJ6tqeVc6fg9126omESjCxDC7PbqnjHKa0kGvFPUJ5/s9DrOsTdadDZAKAc
	5/u2Tc0shEHVsFWsWdxCpQJl57KteS3IwLh+oEHKr6QYsItAhgFDiOs62frJjFKLGN2YnKPr388
	IcnZkPP9AvlJm6t5PKAgVhWg5S6qNJQ/Q18nv92qJ6EIzoEotPF+Lts/uqT3kLZl7ykleI14hWy
	7OWt3und
X-Google-Smtp-Source: AGHT+IEX8/Ny3dsmWxBIlvJ3fzo2GZ7qHDhSMNgplIU4BNArd2U/FG0sZ8Z3ZFSCTkzPgP8y6xneUw==
X-Received: by 2002:a17:90b:2e41:b0:2ee:96a5:721e with SMTP id 98e67ed59e1d1-2f548eb25cfmr57172567a91.12.1737035477595;
        Thu, 16 Jan 2025 05:51:17 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cba9csm3341229a91.24.2025.01.16.05.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:51:17 -0800 (PST)
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
Subject: [PATCH v5 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Date: Thu, 16 Jan 2025 19:21:02 +0530
Message-Id: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
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

 Documentation/PCI/endpoint/pci-test-howto.rst | 170 +++++------
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
 13 files changed, 435 insertions(+), 627 deletions(-)
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


