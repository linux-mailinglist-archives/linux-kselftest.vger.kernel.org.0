Return-Path: <linux-kselftest+bounces-23121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B69EB9EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 20:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F1167749
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F1A214225;
	Tue, 10 Dec 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XB/+Kbto"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF4214234
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858054; cv=none; b=pYfGhoSRCu/eWsQzk9q/JPyk32DkOTOoXuB7IBoqc3bsDib5MFr9rZuTf1EKt45NWFck+E1yPQV7qasd1sg4VQWCgyOCusqbBTzTAfVTw7sLXwh+IBcah8XurCEigkZGj3KJG81pKIsyHG2xSotH525eba0iG8882FiPsTmpCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858054; c=relaxed/simple;
	bh=Ktozs3TxtIvoiWuLqIp07E08Wer0m0MdC4yIE4HkHSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGCkzQh49tB/9D+WYXV8L4WmhpZxeH16dMq28q2oZaLUyFAfLRWPUQyV0obN2kJViQxb/TvxA14g7IqOWVnwGKSo9diJLTqfJkCmPktRFIayQs82I6+OzMxomMrX1s+Tm+SMxsTprySPcnMHp3ZrlgeJP0+o0eRn8IJvol/8uLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XB/+Kbto; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21628b3fe7dso34303115ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858052; x=1734462852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGZYGe93XYnwpPCetlELRil+jhnZS6KVmyET+MljDnQ=;
        b=XB/+KbtoK485fcPDblLVqiGT6DX1xihh1Ve5l7HEkMPSkewF80yzVGt6fPxfug8uyP
         EJ9Oi9fdwbmBg1mg4V3h6HTdXqltcSiSmuA8+4PRwTFLEGz98iT9DOzO3aUMiBQuOrYk
         57R9ODayhgz6A9n3Ie8qfHD01jUY7cKYfpjzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858052; x=1734462852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGZYGe93XYnwpPCetlELRil+jhnZS6KVmyET+MljDnQ=;
        b=FxC297A5u9vazOcbW+jH9mdLorQF+NslFIshxA73JXaDsWzSez5yTUrFo6fXaJtard
         gChEphQS+1UtqxlFqPgPausn7B2H9BPKPK4ZIf2nMP3ayrhfhWf9kqoajbATqfGLNkke
         ZccWIZk8o8Z1qapHw0RA3qo6S133k4fI8xs+HF90zgZC6drN/HNG5bfV3Ma0BaSvuWlf
         FBgL5DjlVvE1G2d/JIC58vcxIcnl/3cZAKVtrs5za4371LrYYELrfFT6gLJsIikVHfDC
         6knqJ+v1v+bp5JlYa7CSQ8KWT9c2Daiz/xq4SFJEQbOhJPQdbmUX3J9NonMM1qfEqMWD
         lRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbnfwZMAwrJwVx2OLQ0tjk/setwy6AWO7gIgaxo0VsDskaSzAiJ2kT5atzSkBSiQimr6lwSlBoU9PMc2XVhZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoguiXKeMYtTfif26myehkbSZwmJdCFf9drrzT8j3tBAFiAbv
	+sEI/36024LFd5NOxUb/4S1kEU7O2jDfbPXMYE8xHpAdbQL40bhRwQ+PxcUQDNJZ9bHTlAPMqXg
	=
X-Gm-Gg: ASbGnctFk9C3lfvOMyP6G0ZMwUJFOjTse3QbQXEPz2Yj+qo/NFaxtKaLklE/m7okemt
	/ZBmnf9RNwlB7SDsYUcUrzvlV1G9gedehSVOVmMXKTxfoVOhihgPH0BWKFoOJeyVYKdsVC9V1Qy
	QDwiTIMnLRBaDCFHLS9Aq6f9HJrXPDr2hme5lYUb+VKatmF0GKYr8mIDeoFCDRxJMWBSVAUXWmz
	qxygMTKoojaVHH00zzPalbpp4vyI16gyjsQ1NI3978/R0xR/IH+/im/J8VMsYlQ5eL9Hbyxdkwn
	sG6g2ZwEpOb/nQSV
X-Google-Smtp-Source: AGHT+IERXAaqqiMd5mOzuFLvZrQd9StHnBG8/hIZg4z03BXT5k24eR9dZkYbgceUnjEuaFJTxHifoQ==
X-Received: by 2002:a17:903:18f:b0:216:7761:cc4d with SMTP id d9443c01a7336-2177869bfe5mr3528915ad.55.1733858052118;
        Tue, 10 Dec 2024 11:14:12 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd37745f99sm6188134a12.10.2024.12.10.11.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:14:11 -0800 (PST)
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
Subject: [PATCH 2/4] drivers: base: test: Enable device model tests with KUNIT_ALL_TESTS
Date: Tue, 10 Dec 2024 11:13:31 -0800
Message-ID: <20241210191353.533801-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210191353.533801-1-briannorris@chromium.org>
References: <20241210191353.533801-1-briannorris@chromium.org>
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


