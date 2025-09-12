Return-Path: <linux-kselftest+bounces-41434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47446B559EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 01:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AE47B5CFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB0028C009;
	Fri, 12 Sep 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQRUMNRz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC92877CB
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718601; cv=none; b=RoNOXl5qg5wYF7alaUmpwX/84n9AuFxYnqqLAH3E5Pzj4T34LX1e5wXBHWxQANRn35BjPa51FvTPSEBf1jJklMvjIf4TSbMqYnxQI7FMmJQmesHxTipopJeuJi5e2o5CUiorbippf3e5iVUNYbUEv1mPoeWReUZD2xryVybD05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718601; c=relaxed/simple;
	bh=YEh//s+EtsJjGeLO13TxNSxxYq8mSsN2ket2o0T8fSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFNHfEcMAdzEb8SR0i9XzqTEwG/ZZRxwDMyfSZsQaPxBJusF4FeagvtxzjRse4PUgyMRhVZZkGjtXv5huGiGrOlfGOXYokXjlu21UuKihFVY3Prw71+nVIFQB0VQSFu58Iymjn4Dkblus1tGfJwpQReX7tOhivm8JXWy6lvNm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KQRUMNRz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32bb1132c11so2671370a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718599; x=1758323399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=KQRUMNRzLQIwOB9SGgCZ1b7r6/r4gdYltSkJpKKYpVE0gy/yOkd/lgR2sxXv0RsNZs
         bb1tIWazv+Bj/yXnD8NLciEBJU/5oUttJVhftH88p4beIUfOkrE+fCxcM1ez6l63Qa0y
         NgQA7SH+iE4cEOkAMfz/iB2jsQ9aTcB8BQbYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718599; x=1758323399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aqQsfYpqczFMN6xd995B9cIuPxzc6IeMNO1DIuGzJc=;
        b=OTYn9da8EJhHdRsmzItAxaMV9QX6XUD2/bXuXyIhwx6dQSIQQ1vBfXLbwSV2/iF47g
         7zOn56CvgXk//uQLq2rxrarvyZWJbsfl34aXMqkXs7/pSgdbkuOlMsamPHYeYysm9w75
         TJQUJFx1YX9HhEWzKyK2eGYAlWAzKn8WAoKZX7yWOr2Un9BfPOqgTJJWCeiLI0YIE4fk
         GKUI9BuEtFoBaYKkguYOTfNJdSYRHKJsVLn/eHmo3GGnjAzeQQe4hoO9MvptQy8jsplO
         ynMsVx2X6rjPX6T5rhYA+MsIBQcFwk0I+pRK/FJc70XDy9qTKVbF+53UzPdPCAHi/lRM
         MGGg==
X-Forwarded-Encrypted: i=1; AJvYcCWewTTVbLuW7ybqE81v4S6IKevcDE2Annlzzl5newPgnIDOcvlnGOjl94aXTXl7M18LwRFZOS+gk3I9VaQxvs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0OF5vaVK4MAQXhIOSprDwIy7NWGMdxQLAvnhZ3yDB1/zNHbB
	yLMeU7gbK00hfPwuJTvo67EZHkS2m+6nhQt1OmFHfywXoP97nQ5wu8JetWtTFnheCOaJiOCApXy
	LxqE=
X-Gm-Gg: ASbGncv5AY3OjOZuCXeN8bJwGdQ6+FLuR5S0KAFxIDj/ESJnpSAG0APCz3nMq2MFQh3
	xeM7CHsKVPIK7oaP/dQb1UqpcwrdH3t9hofjkCktw29ozZ+0o+MBsNnHN2jLsKtGDwPrI4LOSDx
	KljChwoeLIvDcUwqY1va34mg/e8hU6xb2/rG5pF3qCes1GdYlJWieUo+TniPJ0oD8qYNx7wETq4
	d/KafBeXTVo+TSESDiIsqCwQfP5BUNEOCO+AYScWPF8BjP/nNyWTXumhtLy8+g/UdnKN4sWZpzL
	gAAFUZaTVBDLHJ557OhE5e5us3aKrvs1Fff5iOgqNn21ACOriScPcrifJAKpdQIITmuqWmzncm+
	BeiqYAbEMWnc15R1KUDsfE+2HIHC5W5YbjwlU5OZ7imnix72yf742HGXmP9A=
X-Google-Smtp-Source: AGHT+IHahHShoB5Ii1WzvFIbd2LUrSYt+MXYAQPhHq31+WasztFuE5rlFSFzEb7dWV7UvuA2EIiQ1Q==
X-Received: by 2002:a17:90b:4d0e:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-32de4b88595mr5567635a91.2.1757718599221;
        Fri, 12 Sep 2025 16:09:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a35b7e31sm5643608a12.11.2025.09.12.16.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:58 -0700 (PDT)
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
Subject: [PATCH 4/4] kunit: qemu_configs: Add PCI to arm, arm64
Date: Fri, 12 Sep 2025 15:59:35 -0700
Message-ID: <20250912230208.967129-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To get some more test coverage on PCI tests.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/testing/kunit/qemu_configs/arm.py   | 1 +
 tools/testing/kunit/qemu_configs/arm64.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/arm.py b/tools/testing/kunit/qemu_configs/arm.py
index db2160200566..101d67e5157c 100644
--- a/tools/testing/kunit/qemu_configs/arm.py
+++ b/tools/testing/kunit/qemu_configs/arm.py
@@ -3,6 +3,7 @@ from ..qemu_config import QemuArchParams
 QEMU_ARCH = QemuArchParams(linux_arch='arm',
 			   kconfig='''
 CONFIG_ARCH_VIRT=y
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index 5c44d3a87e6d..ba2b4e660ba7 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -2,6 +2,7 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='arm64',
 			   kconfig='''
+CONFIG_PCI=y
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_SERIAL_AMBA_PL011=y
-- 
2.51.0.384.g4c02a37b29-goog


