Return-Path: <linux-kselftest+bounces-18664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1B98AAA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB491C217A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698211946AA;
	Mon, 30 Sep 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTilO01m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC322193418;
	Mon, 30 Sep 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716003; cv=none; b=WtpsXEVNMb2sUhJwdOmtQixODjKtGcYPi1uxYtSy2BpudaYelg5cTARettOIIC2xTbfCzimGSnvG5bLwSZwYCwHoW/HXzw+1uE3VZyFLC1F3UHdJ0janSbUflQwvci/LpRUEmUfJtaGpLlpMLroYoX3C9oJ9R4CXDaSfXR8JKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716003; c=relaxed/simple;
	bh=gBTZm0qel59rf2nazqaG+rGOSNEbmSx4yfL0zPuENSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jD5IhAgKipdN5zsNpPaI85GmMZQXgbmkNvT9oVM7Sq5FW/cY5npRkr/QeQrUBPay6MI8GE0LhXgNPA6/oQz0HfhXWARschyFYbXjXqeu8GtFc6cFjFr97JzXHY/qNvy/XxmPn8jBGIC29QyplZ650KXkmebyWXC88D6MzwKVTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTilO01m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b64584fd4so13738835ad.1;
        Mon, 30 Sep 2024 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727716001; x=1728320801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0MlXiYwjMZlX3vVvCbEpiXF5sFQCQIwXFayCcI9mB4=;
        b=mTilO01mn2VM0gF/7Hj8QAgykQFnyyDaFjmBByQDr6EjGvsOVJ75YiXIYyedD2CVB4
         9B2AnqSz64o2P2FB9GFMibK6fSzpJcMSxFkTMK2HZEYY6yc8ypsqspXORCmv72jwyRvf
         sWEjg35rnkn8TKmxWCGyROGL/m6rjHEMLpxxZDTXF18KXd76+Pm4G0YJlQrOMs9Fn43S
         kAdQALimTyytTmPizfOMBYRNIZDr3mdU7MZXprokXGgTvFIlE0hJGBQHlH2qmgVfRFH7
         BydjqWKh3ev1DShnJ4f662CxFB4cwKeKcXjX6ldo2yw8JAgpRF8cOi0dO5LmDeiPRGNu
         dezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716001; x=1728320801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0MlXiYwjMZlX3vVvCbEpiXF5sFQCQIwXFayCcI9mB4=;
        b=ak9lSGGWqRiMz9u3x5YCaS8smuyDz/vwjrSCb/yRkTVQnbA4H6S69qJoVLuUZyHvFB
         E7ipv36fnsUBu8Pqj+zExZc8AnKQYtmT1NN/XtFOos+NN2qI+B0lJ30HbZ2wuYcEbw8w
         MoNJiM1vnL9f9v/bNpdNnW/RQ0D50luF7wrp8IeaozzLCaQ1qIrdZhEMvcRmIQ5s3aHv
         N9XuimRXIyBVhm1OeGo09fuWDH5OVot2AKutuMe7Kj8WiK0PpLeGD2Tqr/xNm9BNpNxG
         t0k0lCfUS2jrjxvByssIHFVJlMnPTqOjfWb9n0zeDETVQ00srvRzuwTpXDKsJGrvVUrV
         2JbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAEfHFONUIgSO4gz1vlLf4lYeYXUuLzid1U1QCNFpjk86zOrIfSA1HP6wFw0H8JzFvq+icwkfOysGFCqPIYMmH@vger.kernel.org, AJvYcCXXAJmY+86mmaPR1UVzhWXNiqIc3kd8QDeC7sQdrHHXDOAHx0QsST/HjtmQ5NYskELi/VDGHxFA28Ekx4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWpvJ0MIy7nWVO0vdw+0Sus0OpTEkr30eBvaHYqTYqrDft8f9
	9L/TUIA0o717foOO7q0UDwJAmLf36jWNBFAYXBnxcPoebV68Sml5
X-Google-Smtp-Source: AGHT+IFZv/8q75D+x/nGXcEml6wjQf5GmNH8KsPKiQl9tof96mWfClweN69x/Aqgub4VHBcy39zz1Q==
X-Received: by 2002:a17:902:dac1:b0:207:1737:2c66 with SMTP id d9443c01a7336-20b3786315cmr218894545ad.35.1727716001135;
        Mon, 30 Sep 2024 10:06:41 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:3559:c485:151b:c363])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d61df1sm56726315ad.18.2024.09.30.10.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:06:40 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: davidgow@google.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RESEND PATCH v3] list: test: Mending tests for list_cut_position()
Date: Tue,  1 Oct 2024 01:06:33 +0800
Message-ID: <20240930170633.42475-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mending test for list_cut_position*() for the missing check of integer
"i" after the second loop. The variable should be checked for second
time to make sure both lists after the cut operation are formed as
expected.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 lib/list-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 37cbc33e9fdb..b4b3810c71d0 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -408,6 +408,8 @@ static void list_test_list_cut_position(struct kunit *test)
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
 }
 
 static void list_test_list_cut_before(struct kunit *test)
@@ -436,6 +438,8 @@ static void list_test_list_cut_before(struct kunit *test)
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(test, i, 3);
 }
 
 static void list_test_list_splice(struct kunit *test)
-- 
2.43.0


