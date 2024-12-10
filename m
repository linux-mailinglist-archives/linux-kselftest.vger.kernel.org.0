Return-Path: <linux-kselftest+bounces-23119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EC9EB9ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 20:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE5D1888C79
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912320469D;
	Tue, 10 Dec 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PibYboMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A01BDAA2
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858050; cv=none; b=BE1oBKBnIgGpG7hLuOOoST7gcGIcDIEuZ3w99nfStTb4S4MUcrE00iu/dN1GMbG+uecFwiVPMPyRtqpgFbe1gTWmTszpKoct4g5drHbMlEh/C6T1XJnLDcQHrrXQ6/H9gkp53LXTiap6VqUKNYcXK8xPc/YybLBySxhy0YLY58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858050; c=relaxed/simple;
	bh=8nB9LfqUIlx893EnVEn1oyPaKNloRLzhICUSkzKGANQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=luqybZHQgqfczYKfGY7/A5W/EyAhi/lUFTchcF3/Ldjt7dsZBzUzPuXGDYq0/6lmFXSzk+AYhIWuokfVoVJUnRa8JXKHTpfQ00vv9UtJQQnjtXAioQOLtrQOc7TFuElZ8s7ujhhKzVZB4OdZ71iYuOcIMqf8NfxLRXAGaaJya/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PibYboMV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so4695964a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858048; x=1734462848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MysYNOOOtjPxn7x1jZehpCDsgb3N3i+OrdKPB7nkcnQ=;
        b=PibYboMVU0w6jXbXBOCttKgijsfjv5A16l8vN/gCKYXQ95pQnZW0hSI13v9OkqKFuK
         8wlOe8MKJZTSTt1PPaOEcRLv9krFmhHBs3QSBV9bPcDgM7DxxZJz9BJVxpU6rKHpM+Js
         0BmQaPGMDXP5Z1IAoygaYzsSLyS7PbOl+3oQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858048; x=1734462848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MysYNOOOtjPxn7x1jZehpCDsgb3N3i+OrdKPB7nkcnQ=;
        b=JbmgYSbR/KuDSI7LTQPo/eWxi3BpXmk0qN8ih11zBzFiupMIYqb+bZuCzxpQGRW8dr
         nbSzMGkDGKpc3o/a0f2Of5kBaFv6SfRtR4CCwDazeqMGlMC94MObNEQi2jTqhn1QXiEs
         OWSRqOW1u2ODU+NL0ty7XJ0gJJXHlUnUsgK3Ud/RU/E6b5X1tT9s/RTOGYN7jfVFaPd/
         9Hi65+eKT3MfrOXGzarXcPW1p7bbCgHeKH0MeA3UkQMO2wGG3tpgVHadJc0ZCHPgRJFN
         ysVMZQ+G4qcZlUMzI5UqLKRLOotNvgkIKD9rZHnd3rCvXzoh/mqotMOB0q9vNjYNLsI9
         Q5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXQYh5ZK2WNCKNndg0K9WM+FhFp4SsEbpmSBEsGoIs0y+HtqHAH06Fbqj9kbloU0AVvbxsDHzoV21gMbheLvng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAP2e/vs8/TX65HWiLGykFVX/jGZWPHkc1o3Ddisok1DYV9zIg
	8Rjs8MmjvKe7+GG7vrx0O9HJPRDpVxRyKUn2dhyy5xlWND3NvU0cLSKKgvGSHA==
X-Gm-Gg: ASbGncuO32K87R94PohlLYJndXLdWZ8IcqrDtTCtC+T6D7ZQWbUbcon20ltZFIzbyCr
	wuTystU7LazmVsTUfS2YHuWBWhDKE1aa2yVbFFKc1LRf8NSsiLfYqrC9NGFCAaSx+mkMfPWPShK
	otMc4XFHUVAyqXlgTRs+apKBZZ1dQKzEGbvKyTsLzUFOjByp7/QE0PJ9o1xZd9UqXGRawXZM4IY
	zJg0VReBM4GiKd3GsqJAj2oXwfjJdF40nz0hVMnMYWaKEtT6u4a1g2dwZTMuTEwYPoQAnUcRQ6w
	cXPB4dT8Waw8qeKx
X-Google-Smtp-Source: AGHT+IG1Y3K1qZ9CQcqUnkQEHUVS4XwePEyG43iObCbw1CEpZyvCGhCju0fkg5G3HVvnA7tqXu0KEw==
X-Received: by 2002:a05:6a20:3943:b0:1e0:ca33:8ccf with SMTP id adf61e73a8af0-1e1c1360edamr639374637.34.1733858048251;
        Tue, 10 Dec 2024 11:14:08 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd2f40dc81sm5905791a12.64.2024.12.10.11.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:14:07 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Rob Herring <robh@kernel.org>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-acpi@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/4] drivers: base: Don't match device with NULL of_node/fwnode/etc + tests
Date: Tue, 10 Dec 2024 11:13:29 -0800
Message-ID: <20241210191353.533801-1-briannorris@chromium.org>
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


Brian Norris (4):
  drivers: base: Don't match devices with NULL of_node/fwnode/etc
  drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
  drivers: base: test: Drop "devm" from platform-device-test names
  drivers: base: test: Add ...find_device_by...(... NULL) tests

 drivers/base/core.c                      |  8 ++---
 drivers/base/test/Kconfig                |  1 +
 drivers/base/test/platform-device-test.c | 42 ++++++++++++++++++++----
 3 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


