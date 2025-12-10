Return-Path: <linux-kselftest+bounces-47355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC64CB2212
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 07:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65826300F594
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2132D0C84;
	Wed, 10 Dec 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w7gKrt3n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C967080D
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349936; cv=none; b=L7aQQVPxtsXCk1iGdro79/p82bHQBXRVCfnigQIrKtD2ip0DmrvUI0HPW84teSD/MCIfQCjNXSAHJMa6csatLpQw3fDQFYFBTMn7SNpyXuZ9wgM1+zTVT7e3FrhsoT717O51s2WkyqZQtL+g5bv+pr9ofK6Edh1hZPuP4H+9Lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349936; c=relaxed/simple;
	bh=THPoYoDTXC29pDHKC8NpCnASR7FPfwocyqPquLTJYtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uixhBqp5mCIQkYg5CR6uoQOkoYa9l7X1utUoDMqKhXK7Wjd4LyOw902XeRnjJs0vgNYbxgsTkrs37jQHOd+zOZhKinqD9VnC6y61+7UZ+k2V0JiUH/3C1jVJrMNhgcNX5oIWqOoCiRDd2sFYOINIn7/j0wI/C2Ke5XQ4+BzHyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w7gKrt3n; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7a02592efaso710026366b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Dec 2025 22:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765349932; x=1765954732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfcGy/jrwgO2tjYlLkO7+dbE7v6zDZcTujy1srN/gno=;
        b=w7gKrt3nVaWga2P8MEZ0qw1NJuzWdKPPlWCrGPOnK/ata4z7kO3aFtVixSKhFUZs5f
         CAanVK53hnd+tiiMBknUNfyiiSn8QOFzw7mvGbFsASjcmvWEghdReUBWibtYOlfXPc4r
         2xzQuyuxO9uiNI8YO3MGEW6dsbMAlDDDL89pkbBZ+Kw/1x/RavJQic4byd8ac+DqucjI
         49dwu9FsiGtY/aNz3d8Y7BXqGKrmQs+zSwD5I3x7yWY4V0eI7YNJQl+d0lXTVMP+soKz
         ZJg8M1M42fRqt+9gjzc8SpVyayc6Wyz7LBTCycJgwYY1qw7AG7nTDawBRnIIawJ8rK/h
         i4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765349932; x=1765954732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfcGy/jrwgO2tjYlLkO7+dbE7v6zDZcTujy1srN/gno=;
        b=s6fxWjHulgXrKFz8B5AwNVeX8d6uC3M01q0VtsfqcufubHnGj6LIvQ8eeYq+DaCVI1
         Z0mY3Dqn+WDjrslTb9dY8jc8aYPPFbNFxozaCBoV0Jas+uHiP5JF5+YlZKySNBu6N+9Y
         PoLL8SJefND2zJaZbpRi0yVKSg7OYujB2XXAJpa9ZnPRM0Qu2qb+p4Ngu5ORVY53fY1Y
         8kkBol470z89GeUCRdoz5DOah68HSMW2m3ykxzNsa68hwg+UbOA2b1uM0grEkPEfzgUp
         g1u+Zcmtpg/nFMWziEyYnRkE63S6PE6xevwnHR3Jd3r1LwUayQ3P8EfHzsQjUM5/0Pt0
         3zsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUY31CSIeiZk/w4k/SFC0SzI/kW3DRZfSJ+WRgeUUHKqdQ0m3CUv4h3FUBMZTl4CSAlXPTIWQQgBRde4KxS9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1XC8udRv5G5txiiEMWnCffY952cz+4Rot1KYx4Zyu3JmQaBft
	/BGvuQAkA9o8dspKeU+fh67l+b8nYcdZwg3SM7BpEffB1WfCUZt6I3Gksf1bs0YA68QhGAEom+o
	zAvRw
X-Gm-Gg: ASbGncsIwfng0C6NUSfmCCx4EdMZt1AeK47jSTu3KLnKyveZUflPqWYtk6kpV0EmJIN
	UaxUdJy9QFZMcPckaFdFobVMIgbrpvMEPoEu8hpYIFsY3ZUrXEVDqrKdKvL2lU4kU7aNrU+zcIW
	4jbeKPOAfqxs36m7Ya6jV3kfs1HNHa9F80GLlMQZ3eoyC9FWFaNGp0APYV0jjXBt8X2faqUQ6L1
	08dHjd6XJHt+ov4Dj8W3q2obtx44JUFyhGxPn7g5iS6HEl/jNWK4zpGYSbTrYdxgx8P0xh7zkxh
	2M4ujdky+R91MUrnYKTe3o02Vu9PQ+9e3hlRAEzRXk9JSHFqivjiP+DRQLGLp11zb0JkrENWSsN
	oxCcuJ11+zFBCDoISfkN2Bo25O0UiFbMfsC2MI3/xtmSHRsIlzhBZ6U6MqAEAV9TwtIPesu+TRJ
	KBLOn+X9UY05rjjurf
X-Google-Smtp-Source: AGHT+IHJCRVTy0+xoBKVn13TAtHtLqeIGI1sTODG36SuKWuG00pB5GJIrZJsCqrtQ4D5PhkQI2dWhg==
X-Received: by 2002:a17:907:7f17:b0:b79:f9b4:4c5d with SMTP id a640c23a62f3a-b7ce841c519mr133901966b.39.1765349931989;
        Tue, 09 Dec 2025 22:58:51 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b79f49c94fbsm1580180966b.53.2025.12.09.22.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 22:58:51 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: Rae Moar <raemoar63@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH] kunit: Drop unused parameter from kunit_device_register_internal
Date: Wed, 10 Dec 2025 07:58:39 +0100
Message-ID: <20251210065839.482608-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=THPoYoDTXC29pDHKC8NpCnASR7FPfwocyqPquLTJYtY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpORogGehTGmFeX9UyGI5pMiU9A5Dg3kd0kUdhX Y2wnnGMyluJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTkaIAAKCRCPgPtYfRL+ To2PB/4+Tq9FlaEkcr+vn95tJkbwLCmf8DfkfLUV6vOq2czK8NXbQ6BQTwIZwl2d7EDZNO0WAcT ERg+f0giZdHxs+RDEXAnbvOQindJFooOxLkFAFAP8GOsQJCKyCmWoW7LwQhHvflO5z9bu9+wnOw 7NCuNx7Yd5L6rw1sCTJy/DLweKpUsS8MCinssF3OvZ3Dz2Eb66fo694XAWPK1N0ZMpXaI1z428L bwKZ7SSjtCltbP4AaaR7u0VGRpUjFup2Jp+gJcdfSooHLy9O6+fQ6YFD0s9s/fH7PiFR1D5mcfJ 3x0oTq9HqJ7GPSOWiU3OiHAhWZO242VtEbVUWMn/OjaaTvVq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The passed driver isn't used, so just drop this parameter.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 lib/kunit/device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 520c1fccee8a..f201aaacd4cf 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -106,8 +106,7 @@ EXPORT_SYMBOL_GPL(kunit_driver_create);
 
 /* Helper which creates a kunit_device, attaches it to the kunit_bus*/
 static struct kunit_device *kunit_device_register_internal(struct kunit *test,
-							   const char *name,
-							   const struct device_driver *drv)
+							   const char *name)
 {
 	struct kunit_device *kunit_dev;
 	int err = -ENOMEM;
@@ -150,7 +149,7 @@ struct device *kunit_device_register_with_driver(struct kunit *test,
 						 const char *name,
 						 const struct device_driver *drv)
 {
-	struct kunit_device *kunit_dev = kunit_device_register_internal(test, name, drv);
+	struct kunit_device *kunit_dev = kunit_device_register_internal(test, name);
 
 	if (IS_ERR_OR_NULL(kunit_dev))
 		return ERR_CAST(kunit_dev);
@@ -172,7 +171,7 @@ struct device *kunit_device_register(struct kunit *test, const char *name)
 	if (IS_ERR(drv))
 		return ERR_CAST(drv);
 
-	dev = kunit_device_register_internal(test, name, drv);
+	dev = kunit_device_register_internal(test, name);
 	if (IS_ERR(dev)) {
 		kunit_release_action(test, driver_unregister_wrapper, (void *)drv);
 		return ERR_CAST(dev);

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.47.3


