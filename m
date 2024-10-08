Return-Path: <linux-kselftest+bounces-19202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C8993FE3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40D9288692
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1B1E261A;
	Tue,  8 Oct 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBtt3wff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BB1E282B;
	Tue,  8 Oct 2024 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370381; cv=none; b=a5bU/SYWglisuF7ie8cDsdLiYvKoPzQaq0NYo+1L395JfD8X+1mKBWsUunVf1steORqVuejyrY/hObBtFw4qWGHnGnlStSD6SDw2b97eMbxbzriJmLDUwrN4vKMiZ9h/CUn/xz56gRx/4NWu+pOi6RJRbIh9fNnY4VGkq/xQ7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370381; c=relaxed/simple;
	bh=9VUithL9olPT3+zRusGcptvwsS6sjrR7a4P+b6hBSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsttiN6o8UcizXKetDgrq29cBX9tjlZJTYzoxbMB5wtFOnd76zw3lAPQqJIVblh3ysXeyoAGQe0PHPJDkRfXPmGEf7ma3Qa9KRirfwBDl4NPXzRyzoI+TbiSdMACISCbZI4bIQrUbz+XsRYh7YVto49X3YtG1Jq9jKSvAnsp2ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBtt3wff; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea0ae67df5so1485884a12.2;
        Mon, 07 Oct 2024 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728370380; x=1728975180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nZtsxSvHO0Hn2DKrEwb0Prd6BKwuA0KF0Jd0oWoumw=;
        b=LBtt3wffS9RKyDJQ+DlaMK31Km6VWfEP4Q3uPAjxGS80Li4Ck7BYyqBA5EO2UJgBwE
         CTDxEqBoi3yKKfXtfQq2+XA6WlRAMHaZPKSdgK21AWWBhGTMUF+arVg2C/EhGLNZx/fU
         pZ7X4AGcUEzhSGOC2Q2DXAwyldi0eC2PKVPDFJ84RSeTfAPOOtYNCA/3hoJHvJfouCTH
         nqjrDAlfsrGydzI/h1xfSt9eSkCdkW2zWruzfGsypW4SJSBpwxDsIztvE/YyLZW5epOA
         3zGYpvVHcl7TjSBMtI7nsXAKm68Ijj+cW0hOlrUO4YJFvL/Sb8XXDnm7rYlSYVj2Ltrx
         m0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370380; x=1728975180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nZtsxSvHO0Hn2DKrEwb0Prd6BKwuA0KF0Jd0oWoumw=;
        b=SMadQikTWSUfmavBnmLKpyT44YP8UFWiVms3I/0ejAbGx7WAM10xrNOlXdOI6J2WFs
         ywjpX0xCcqTHdB9NKLrQhjX87Dnskn4+dW7tWhCUb7hBfBzAaX05aZI2KTZiAc9muWSv
         bTUT6vUNaCyGJQLDfWHcnLqcAthczY2iK4kuK869e9Kc/D1uhjm9FYcaGb5fWZqZF/wA
         UD9zfqAMHtKkGkdCswBfJbnC0rus2mZEB7Yx7ULYarqCXCVnUEj51Z6j/Q8AjdOZ5lRq
         jAT4jnP8oACs7a4ZDJMJ43IlbZ7bSEp5TRjWxwH83g+fHllvFkFrRCc7C0lQZFrb31Fj
         c3NA==
X-Forwarded-Encrypted: i=1; AJvYcCU3sx4y3t4DCIl6TihA0/PGgVzBUiIK4kHRvbABwfcPbl9nl6LF2HjWFNYE/fedFcHOquY00R8oMLb7JJH90NTI@vger.kernel.org, AJvYcCW/Le2J4G+YJF8SWB87rtiKviD6t3XFM5Ol7JqeggVsdUJ/ulp9MKt55en8U9b2DD9G0ulAoJzgh75LT40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxET/VRXbP8YUBk3fVOzgMtUsGlsvDHCa9Qr73JhOoipy1bwQtF
	B8/ahN5zkEjG7gWZJ4KoT8I58bsato/4XNuu05FcwvmDQgyZPFXk
X-Google-Smtp-Source: AGHT+IENgOIl/uSh6Mzkir7ryCuR5icE44R9obsBFWfQKRnOm1drBbK/yT0nBJW3yiXIhu6dNe4jsA==
X-Received: by 2002:a05:6a21:4d8a:b0:1d0:3a32:c3f8 with SMTP id adf61e73a8af0-1d6dfabc77amr21185781637.39.1728370379614;
        Mon, 07 Oct 2024 23:52:59 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:bb25:5583:9ce3:ab6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e28345fc46sm799826a91.50.2024.10.07.23.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:52:59 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: davidgow@google.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RESEND PATCH v4] list: test: Check the size of every lists for list_cut_position*()
Date: Tue,  8 Oct 2024 14:52:53 +0800
Message-ID: <20241008065253.26673-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the total number of elements in both resultant lists are correct
within list_cut_position*(). Previously, only the first list's size was
checked. so additional elements in the second list would not have been
caught.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
change in v4:
	Amend the description of commit message, make it less confusing
	and focus on the correct check which is performed now.

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


