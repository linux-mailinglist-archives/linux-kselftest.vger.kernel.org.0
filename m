Return-Path: <linux-kselftest+bounces-35147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C3ADBBC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 23:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0325C16EB86
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B81F09A1;
	Mon, 16 Jun 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBceuS1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9545415A86B
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108606; cv=none; b=bYwSZXhL89rSD8vuPWPpn0/PiUtH5A30kni8QopP4IwqYemjp0uHd7lxbFQT2raRFFMuy2fo55lgROASKb8dxu4TM8JLuNe/LCjgY5ilX5oW0WX7SpoefjkmvG6/mmdM5puvmrF+NS4k3khSUtPu6Ic1sZVyTd4R1/9g1XZDNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108606; c=relaxed/simple;
	bh=rf2528MAQI0SWjfQ2N2eH8l7992Txi+rx3ktL0H7dPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6yp8iBUK24sky6lqJ8sRD2n6q+WfU4js27Ndv+jsV7y6ZSMo4wTDRlPUGzs0E9lOVWQZJ/9H9PPOEXH7H1cJtarHgyDLAzvf5lV/34SZJDmAD7pPJs0DiUXp/cFGhJmEe63xG0dhXEPX3uM/I/Osyj8UxNVTKSUXrscKrSlTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBceuS1I; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c49373c15so3860693a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750108604; x=1750713404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjB2AvHvP/l5fSBXrpAm9tdfGAHdUE2jUdUZTcZ29zc=;
        b=aBceuS1Ig4ex+ei3+b5oLVoCBvM7quJ/YpqEFAlX4olK3rqiOker6t7Fw6JtnSUeFO
         6QvdCucrkwBi6T4qNja2mIYsjAVF2lf7fiQi5GYMCIWa2hy4PJ3zofsZOjrJEEN1Wjna
         PI9NBdwSj2dhsWWNGcFxr01toteVkEbEmzyD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750108604; x=1750713404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjB2AvHvP/l5fSBXrpAm9tdfGAHdUE2jUdUZTcZ29zc=;
        b=RXqU35Wvd8JdtbKUOb7aXWCUeCMazgQ1dnz9U9YGVx9OELDVfd0SUKxag8ifxQcVhK
         FYpxF2sTtcj5gU2Onz3CaWBPOrUdGRBQJu65KQCWCL6MaRub1OAZX8NCQ6I8uuPjWUgR
         b3i2l0VquXgzXwA/lgwnPvCamvft1pNsRLnSuqclhe0SUG4TsNGZ2P4xTxK1IE8Fa0DC
         QM62t8E8tSWpSk6KNUk6LWRQckbUim3VegyEyGz9TSO0wMzAQ3QEwuO41/6XfOaZmLFk
         ISuSKnVTFFlzw/9LuPHFPj560z2OSjPawec4NkVtTwBCPWRjB0f/Oq7wPASs4R+PEbJY
         Rvrg==
X-Forwarded-Encrypted: i=1; AJvYcCVUDzIAAmUhv0FrACOvB6Jffz0JqN0LabJZyANV98UFxsK4AY9/pIbeq71tplqhDf2GitVxVwUW2VJMpGJXLs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfyWvGGP/+LHd0WTW0uSIoYQQY1cbqt5/DBP2s2XLEkMdUo5Yc
	kwgwI7PbukCp7wvA1uxC1zEc2I+w33l7XD/PowXp5OkwobiuvQoGFG6wE6BAEqnKFw==
X-Gm-Gg: ASbGnctqYYXQv1WUFMYJbRPCgqYD7J6C88oWvpNFS9LuDexlkXmDbJfhHqurxkUm4zJ
	8rRYe8P7/jyRJpXXI1N6RauUq+R2HKwZObCoK8lclBG3gyVcvq974NsNaAd71eQv0LmI4jyJSFJ
	aJ+eYJorhPkaohG8YQceg1+vYh2mGRoUBftm3hkJnxjQtjnB7pcL+0HCHxJM0guer6mlrJYc49v
	KZf6Tf1ttTsgDbOnyKExpcvex7JI8PF7PAccPGf5C8mfsYgiCjbJzmmBIy9lH4ruXUvovAsyx6v
	IvlCLZsqeP8I5ZK/hIlvGBtUd4uWjOdNfwk3wETB79hfNnm8WwtP1cP2U3o/Olq7HLeyykkkJ+n
	OknEQa0rq8LL6Lm4jzQeSAUx3
X-Google-Smtp-Source: AGHT+IGe1ufxDgVDGZOcSm8F8WWBMKf/NVeCmCDL4jeI8CLDLMqKlTjQVroioLV9TyiCAOtjfQpatg==
X-Received: by 2002:a05:6a21:2d04:b0:21a:df04:3285 with SMTP id adf61e73a8af0-21fbd5f20c7mr16177374637.22.1750108603884;
        Mon, 16 Jun 2025 14:16:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:aa5e:e3d3:2ccb:2f3e])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe164400dsm7419675a12.30.2025.06.16.14.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 14:16:43 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Cc: linux-doc@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] Documentation: kunit: Correct MODULE_IMPORT_NS() syntax
Date: Mon, 16 Jun 2025 14:16:33 -0700
Message-ID: <20250616211637.111358-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The argument should be the string "EXPORTED_FOR_KUNIT_TESTING", not a
bare identifier.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 Documentation/dev-tools/kunit/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 038f480074fd..066ecda1dd98 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -699,7 +699,7 @@ the template below.
 	#include <kunit/visibility.h>
 	#include <my_file.h>
 	...
-	MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+	MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 	...
 	// Use do_interesting_thing() in tests
 
-- 
2.50.0.rc2.692.g299adb8693-goog


