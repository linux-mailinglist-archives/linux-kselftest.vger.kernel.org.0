Return-Path: <linux-kselftest+bounces-23232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2CA9EDC89
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 01:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AADA282DCF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 00:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317EEEA8;
	Thu, 12 Dec 2024 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nc7bITNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44996B640
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963530; cv=none; b=hVwp44Z3P8bEPakLv6zz5ucKLGpIbRAFmtHbttUoIXxdR2tTZF9Etmp6gHnOaKtZzdEQEw9NPel4Zy2IMrhAlHN9IVeObLLITRYJRQmQLJ1OIySbsFD/sF4FeLe5GUggV0YpSPW6RWxamzc5J69pQZ8WObt97uTfZcIjGJd2lZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963530; c=relaxed/simple;
	bh=9kO61ZlGPcl7dFYka2HYnU+xP59g92BlQiU0gEiaYl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PU8cOa90TJMODWdNPMP8jlCwrDYJkf7OqpM4CSiwGVCVGMU0XTB5C60INechDrmUoHDYTO3WY7+rAiZMBrxv7QOXI/ev2gXIZivgl/HE7LoIBjhFda7X9z6ncTGm/y8AR/rAgHLRAUzvNcBpX2S0PlnIM8zcgBA26ERhgXZEa3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nc7bITNP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so41496b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 16:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733963527; x=1734568327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTF8dFZlFmvGoOByeJT7iwvECiXZqdDMFsMPE4teEEM=;
        b=nc7bITNPa5Jhb4bCYdCI/oF3NfY7zRVcxQVSHea7xwdHEEo0yvN8XvECs+IZzsY2cE
         77hyBtiqHPcKYF2W/3p4OjX+r5zxZo7lNU/clPgwuKzBuMvEbgZA5yjKXNy5kRmqWbn0
         m2g64D2KLfHL9kwXw+IrS9SVeJLnqih6zznYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733963527; x=1734568327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTF8dFZlFmvGoOByeJT7iwvECiXZqdDMFsMPE4teEEM=;
        b=hFgfRvTxRFyRgeMHfiw85H0dewpBe1vC5OrsAMQUPNAJ/ypzIfh6K5qo5O8i6vVTbE
         yjdbcxcftVS5+e3nsCIfheoOrT1f8RRhNQ+Vp7VZTEe0FsG//zyp/KY3yr9fFqG7/9S2
         /KEv6WEManMLcNfCYbQcHQzM080Zu3+cCth2UD5fS9YCzoz/Qnt3ErY6cmonL4RPTppY
         IHLbiALz2s14G8MBvtW/R2UdXl0hoUVjSxMFC0+nxxpwuiGsoFkUzlj205JLBetYAtkf
         y0BkB5yI8IuaPXytSrfU9KaGilEbBQAft8MmtBt1siWWS4QwcD6tDdpxXA6l2EipOvvG
         7oew==
X-Forwarded-Encrypted: i=1; AJvYcCVi+gtV44FV9kktIs/VfMj8Anug4Jf36QTMgaorQVkXDosP/3Nehnh7q5wkRHNi2h599p2clsbqtSA8xstGzA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94x+jG49HgoxcVFR/Tq6HwjIeIRWOqdtonfNnncCEa80RY8NC
	STao8xJGCOeDuD7GqnfvEToUR2wMCNM0ipZRRq0IfpDLSaLqpCfiMmoGiP3eCg==
X-Gm-Gg: ASbGncsAVsqgdAinzltsVcmBcFkgI6NWY1XBVMc1HYxU7COMRYXfmEL6lJgeYmkuCre
	d5Up5mu4qL3KxTKqvkFdzrYXC5HUIbsKvVAOXjTZTJIgZn70+Gz/f4712ASL+m3tXhmTMhtsm21
	vb+lKQqpjbiC2Eq64Hi9BLQix+Zh5/U+0SEFEWyjan058mTA3YdwvYnPxqt7yxPHV15JaPrldxW
	eCrmrecjXaDE3H7xg5Yq5i/UKK0snO7cwF7pOoSWoukoJwnxO+EC//phSs+goThA+LpVkD1p9+C
	dIMKuhsSe7tpXyzKDgA=
X-Google-Smtp-Source: AGHT+IF9hWAD9aUf+S3fa+2a8pemMqg9irC7ssRKMiK7NlVwiAbJNV9Xft3Ls5fHvtS/o8epppYizQ==
X-Received: by 2002:a05:6a20:cf8a:b0:1e1:a0b6:9882 with SMTP id adf61e73a8af0-1e1ceae41abmr1401141637.17.1733963527634;
        Wed, 11 Dec 2024 16:32:07 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:b1a5:9c72:5742:89e0])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd3fb02955sm7442187a12.81.2024.12.11.16.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 16:32:07 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Maxime Ripard <mripard@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 0/3] drivers: base: Don't match device with NULL of_node/fwnode/etc + tests
Date: Wed, 11 Dec 2024 16:31:38 -0800
Message-ID: <20241212003201.2098123-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series:
1. makes the behavior of_find_device_by_node(),
   bus_find_device_by_of_node(), bus_find_device_by_fwnode(), etc., more
   consistent when provided with a NULL node/handle;
2. adds kunit tests to validate the new NULL-argument behavior; and
3. makes some related improvements and refactoring for the drivers/base/
   kunit tests.

This series aims to prevent problems like the ones resolved in commit
5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if one
actually exists").

Changes in v2:
 * Add Rob's Reviewed-by
 * CC LKML (oops!)
 * Keep "devm" and "match" tests in separate suites

Brian Norris (3):
  drivers: base: Don't match devices with NULL of_node/fwnode/etc
  drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
  drivers: base: test: Add ...find_device_by...(... NULL) tests

 drivers/base/core.c                      |  8 ++---
 drivers/base/test/Kconfig                |  1 +
 drivers/base/test/platform-device-test.c | 42 +++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 5 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


