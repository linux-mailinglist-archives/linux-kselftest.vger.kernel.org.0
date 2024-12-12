Return-Path: <linux-kselftest+bounces-23234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B67999EDC8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 01:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8971889991
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644E2AF05;
	Thu, 12 Dec 2024 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZQPYGCPB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058C4685
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733963533; cv=none; b=k5tEf90zHPOp9nWlig6GZh3/mWJbwpEly9fkeyKwaO7oNJFOGIyEit7pDtgQKI4vPG/erOMk0jQwnLbS27+LJHiu29TSJ4y8UbTnNBRMgKiXTg8JctafEGYXMJjj4CYks0A5wLX6XXufAJ2B1uY/7o+2QCZi+uicy2v/H+AZwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733963533; c=relaxed/simple;
	bh=D4wKzLL6P8kjio2DoNo6T3LLiJX47WeOUYHZv/B1uik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9rSjSkzGbm7IGpxQ39COCGJUeh2QpuK/XqokunIE9BgXA5eACMMxXv/DrTC9FNVjtPn4yOTw9VUFkEPUKdW3qokXvsIPelPYP97SZ/SE/B9cW5+6vYrTC6uHrwjwwks/60I/pJEZ7QNU/XsQ1gXtTturIswZ2zjpBEiDJ8al8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZQPYGCPB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166022c5caso292115ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 16:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733963531; x=1734568331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8D6ygKlZnTqTfL4YWEBFZxFC5MoNr1XcjZ+M09PQhc=;
        b=ZQPYGCPBoxvFCCUqXwtUATpD2ZE5Fnq9gKIsBoOlyDyuGTGijm2XYpDMgoaOlejtHX
         G1Tv3i598PxbLDaFpIQllPCCNTjQXRFUnHn8Kj9kCaIwG0UVByNeI//mj6JnlLhRwmho
         Xxno8fw2kcbHhsktG7mlsoQyRFX+Fa3RCs2iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733963531; x=1734568331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8D6ygKlZnTqTfL4YWEBFZxFC5MoNr1XcjZ+M09PQhc=;
        b=NIZtON8RzD6ib8ZeL/5v1gry6IcXRXdMm2pLoTd7QNtIV7s2CYKJe30pVRGGpeLHd0
         0hKlNHzwnwZ0pX3sD9UszlguHAdH3U++sD8PpzK4lQx34SYy09l34mvja5OlOYvt9bch
         30UVOmx/APL4Xhxy0kZYFcfBTh2pQzlgF0WpKqEGNnV+TeiFuc73TzL3KQjdcHK6a7pp
         TpL+iJ+qdjIqA1fOvSoJLYdINhzia5CVlJ0CjL14dtTwWXd4b6jll/sQerwefhYPSX32
         nR17Vp+oG0a1QhhobXAl++qVCxU9dvAgUrsRMNNZ7IlTYTbyLF29x8/4tTE/uI6CJ6CA
         2Q3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwdxZ/NYECbjQInTrlatrhE2MblwuE70mEjIpz1tcMXsOF0WekIj4PGj8p/TmxWgxSmyXPMW9qPaiCo5dUPUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsB3XZDwLbjWzhPqoqHNz83gaaDcCuhmk9453DwJMRHC7kwck2
	PLvi9MxMlpz5E4msyOU85T/diHJL0L/EYiLLM787pjBW/5Ebl4iPSF1f234G4w==
X-Gm-Gg: ASbGncuVyURlqCYMBXK26PQzENeYBvVxqGVLke+k0QoWHdumMH66Go0eQfgKArWJQuH
	ZKU1L8Osen7NOVGza/eAYZxVGYGaEIy5RqDR8bCDCxW7ZRfYqJ8hIx/rCdPYhl0b9NEeiTvy+av
	4HGbPzKHO2aFHRHOC/eKnbzvGQ6yXQZCIMC+NtPWnc8Q/0POm9RKUi4Nl1pDvMGglhW00njj46r
	4fUBnxxcg5o7DukW9hVIzF4PbxyvM4q2ot2ltccvWMkE8htFz6K23loc6NnOx6u1Ci5X7mKC7ue
	zCQmg7P1JaFrjDDkDAo=
X-Google-Smtp-Source: AGHT+IHkPbKs3MqtSv9QsOis9HgYSk80Xsrurh11pKn4Z3ghlcVU8XnfyIU14vl7WdQ/uQmhi+CZqw==
X-Received: by 2002:a17:902:d48c:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-2178ae4c25dmr25271915ad.5.1733963531278;
        Wed, 11 Dec 2024 16:32:11 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:b1a5:9c72:5742:89e0])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2163724c42bsm70938605ad.174.2024.12.11.16.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 16:32:11 -0800 (PST)
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
Subject: [PATCH v2 2/3] drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
Date: Wed, 11 Dec 2024 16:31:40 -0800
Message-ID: <20241212003201.2098123-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241212003201.2098123-1-briannorris@chromium.org>
References: <20241212003201.2098123-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per commit bebe94b53eb7 ("drivers: base: default KUNIT_* fragments to
KUNIT_ALL_TESTS"), it seems like we should default to KUNIT_ALL_TESTS.

This enables these platform_device tests for common configurations, such
as with:
  ./tools/testing/kunit/kunit.py run

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 drivers/base/test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 5c7fac80611c..2756870615cc 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -12,6 +12,7 @@ config TEST_ASYNC_DRIVER_PROBE
 config DM_KUNIT_TEST
 	tristate "KUnit Tests for the device model" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config DRIVER_PE_KUNIT_TEST
 	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
-- 
2.47.0.338.g60cca15819-goog


