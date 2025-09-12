Return-Path: <linux-kselftest+bounces-41430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B787AB559D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 01:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4BC7AF88D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568EB27587C;
	Fri, 12 Sep 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5CQp2O6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3CA25F7A5
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718594; cv=none; b=NxrLwkVpuGsdMrD55dr07PGfgr0dMiaH6+zMf7/iWKOK7Yf4EPbz8ux7XJSDgaBIcrYO3CWDCbccxAKy7lq89ZtYtO4nMVYInO0432137mK8MMDwUQLxt8cUQTYE/F5zurO9LUoN3c6fUo5trfOA7SoQua3eat8xmtPjVUARfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718594; c=relaxed/simple;
	bh=GRUOPBmcHG5rwny33Aqll6uFm6c2yeYTGyp3ev0i/kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlCnO2XoaiPZIFyDICxPxIhmNRMwRIzQPz1nZOVpmTFdJx+RAkS8zIFSL0DHm4YF01rQwXK0NJbGggwTqWSn4sBwdk2RfjtIyLjr2YR4BP+gK6xLYgsfbqiG84JlK2F9Fq7KkM+ljQgmAhZ5PyoDNGSP0tQguiMEVe4aJxOD0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q5CQp2O6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so2220325b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718592; x=1758323392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj2EzCDO/uH/NVYiO2SSDOzQUMFnuWGG6J5ju6LXtrM=;
        b=Q5CQp2O69f1yH3w5fW9x9Vrg84tpfjAUvhJtgMCnUCzUFeFvlm813v6Sr/CNWCF63T
         0G+cA2SxVWsib562VIodjvXc6z0nYLTbGJaAlK6AU3sQ+Hmx2hvSRDEJsnJZ5sMrYRAf
         EGkdmHL6Z2/XcMOqmHTAFbLl18ZZxFRVnI1HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718592; x=1758323392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj2EzCDO/uH/NVYiO2SSDOzQUMFnuWGG6J5ju6LXtrM=;
        b=J8SVt4QAa51R0K5AH9dlXZW1A+GPGrgrvMPWHBG3YydhSxIFOG50ssdbt/L3TD5PTz
         b+zEP58AHvAlEv5o+d6q728hHgNErikjjuTz3Tb7SsTN48hKP7TFeMzmgYVSXFG+zBl4
         JNxEfEC2EzR/57qR8ZSlSU7XRGdrAFgCLHSi7Yp+HjJBwsq/BtWxabZd1hwcQHTkU66a
         NFt2VJQR6Ls+N9XY8xX7dOGWgvHR5aGrWLrkczCRSEf9Vi96uvfzJZw5LoOGO7fDDyam
         sEESHhVYOcjN75eTaVHQWH3DAdYrMMbPwNXmtdpt7K9YGoRCRQU88mQPBJV2VLcokcHl
         S7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS08peibCNYQrq5hf4e8LlZ+y760fHRqMxUFEF7rHX8BvpEG7Mhncv+eQK37aShx9nQL6q48kZoz0mllnMasI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdLif7bdKnz7gI998r5LTrjRrGArmRR+tcZ+q5RrLYFJg84pc
	gq4TxEtk8+WK9ZgDhmV2teiBmM3o5zaxooLIXNOQGfMH9d/5wio8Vhlh2oWhmMJ/k024pfmqN53
	3D4Q=
X-Gm-Gg: ASbGncvOmhVAcBy7ws51iOz0r0G06QGBm4XZO5QTSikQFqY6OJsW/hhv4iBOtk8G9R4
	/WG9bzrrtN+BmAqImUAbxlisxFRMYlIATlV1UO6ymiOvDkhp8CLaSvlmGlN5UIy3Qg0R09HfQdF
	iiLLOeZFuCzLQtknx+1lCmkQrAGJ0PG7fQbSVLCqoet869jYz4qBQ0TtS9BnF5kE+VOVQG21Jaj
	tXiuZzhCP0uGlK7oUgexJrzKufIPGZdMHLqQvR3xkziJmUQUK3KY/pTFFf4YYW/nFT0oZfknj5z
	J2z128cfrkEw1EGANBm8hHhMnPE+kNeFi7FViHD/Dsxg+BoHXGbI63UB1eaeqQYpeRkwYR5DLlX
	3tZo2YJeKcnk5Lfw/MVnKVJro8VC7NFlx3/aaNx/R0wvYCzFF4HEruEOp9PM=
X-Google-Smtp-Source: AGHT+IE5DR0gvGWUro9z10EvotDyakdL5SHVeYZ/tNuNggcehVsLSaHVKcMNLMyAhxmQVoCyYfqTvQ==
X-Received: by 2002:a05:6a20:9147:b0:251:9f29:454b with SMTP id adf61e73a8af0-2602bb59347mr5854185637.39.1757718592010;
        Fri, 12 Sep 2025 16:09:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32df97c3b9csm1227762a91.11.2025.09.12.16.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:51 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in modules
Date: Fri, 12 Sep 2025 15:59:31 -0700
Message-ID: <20250912230208.967129-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series primarily adds support for DECLARE_PCI_FIXUP_*() in modules.
There are a few drivers that already use this, and so they are
presumably broken when built as modules.

While at it, I wrote some unit tests that emulate a fake PCI device, and
let the PCI framework match/not-match its vendor/device IDs. This test
can be built into the kernel or built as a module.

I also include some infrastructure changes (patch 3 and 4), so that
ARCH=um (the default for kunit.py), ARCH=arm, and ARCH=arm64 will run
these tests by default. These patches have different maintainers and are
independent, so they can probably be picked up separately. I included
them because otherwise the tests in patch 2 aren't so easy to run.


Brian Norris (4):
  PCI: Support FIXUP quirks in modules
  PCI: Add KUnit tests for FIXUP quirks
  um: Select PCI_DOMAINS_GENERIC
  kunit: qemu_configs: Add PCI to arm, arm64

 arch/um/Kconfig                           |   1 +
 drivers/pci/Kconfig                       |  11 ++
 drivers/pci/Makefile                      |   1 +
 drivers/pci/fixup-test.c                  | 197 ++++++++++++++++++++++
 drivers/pci/quirks.c                      |  62 +++++++
 include/linux/module.h                    |  18 ++
 kernel/module/main.c                      |  26 +++
 tools/testing/kunit/qemu_configs/arm.py   |   1 +
 tools/testing/kunit/qemu_configs/arm64.py |   1 +
 9 files changed, 318 insertions(+)
 create mode 100644 drivers/pci/fixup-test.c

-- 
2.51.0.384.g4c02a37b29-goog


