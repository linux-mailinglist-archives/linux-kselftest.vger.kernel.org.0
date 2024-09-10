Return-Path: <linux-kselftest+bounces-17569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E43497285C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 06:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4351C237CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 04:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E01386C0;
	Tue, 10 Sep 2024 04:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtlrQvnd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36F20314;
	Tue, 10 Sep 2024 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942938; cv=none; b=Gv5Q+923G18LLmSva68xIwazo1FG+3g9ZVu7NBfCYcRbT+0J17L9P9xcOSalgO8FdX5WlvxQ0Wr6PdRlYY6dtRV8EYg83l+oY20dACcE99LKVyvuSre1f0wkBvAjkb28J5sF2wKZpY9U1MwInT4DH7YxU1eARaYPQatlSNQiBW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942938; c=relaxed/simple;
	bh=hIp7TNRrXYd5WV9l4c1aM8w7Mt3i1zs+JkQmk0GEUeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blZf/Fu/8JhCIX1NGOCa70Tdy1ABaUn2YaNnZdobgdkcU+HlAOGLbfTb5VLjDNV4i7iZyB8USXTSqH+UEVbWU/LKdVOe0OeVctr0Sppj/6caP7J3Efrdz/T5qkb5R6kqow4NzoqFmryxBLFe2Rs4MnhV/0SkqXvcF4WYdQyIy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtlrQvnd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717911ef035so3971060b3a.3;
        Mon, 09 Sep 2024 21:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725942936; x=1726547736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9WRe2XBCj/7YNf59BdvwaSXvXunDC75KxgfamhYx2is=;
        b=jtlrQvndcrSsk3NjgN1AHcn616t/dEDap0/Olj8H4GDX9PeEYvuSNR6T0uShG3xj9g
         HWsYucF8hDJkyxc+1Xzc1BnTpc4DFs6m6HUkUknRtNs08fR7AAqeG0SdOAcEeV09iefe
         MNiVcgStNToT/x1N/gqoSAk13H0vRqsKWzgYGhprhXRpYafo1BnYohTm9DBT9wmA9G4Q
         8S0Zd//Lp1u7b7Jx6rEWSh4uOOYxl97NfwozysR4Endd9vpxd6jAT//raX741dZWhkOu
         6d5El4jgKqnpscgK+jdv09+ii+b8Chckfy8QlnpGS5I1bCgaK0jNdcyNHMER6q40zyHe
         MDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725942936; x=1726547736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WRe2XBCj/7YNf59BdvwaSXvXunDC75KxgfamhYx2is=;
        b=B+n7G1yjcYnZLd3zvj+59kALSmsaT2A3DvPPFFrxOldVwX65XBQ/qCTAPy+J+9w/v1
         nSX4JrhXw3BX/Hrudix1JQ7lxlyp74p87E8pIPfYUE31IqGbzE1ssLgxzOE1w3726ylc
         5UETxtNlWj5cUoOH81tOWLFSW6LnIPatp2mwgrvUnVcXJMSJuKDfBMlHjIhFcJmbVmei
         0V/kA3iZJyW3Y0YkHHVW5RITNf6xqx16NyhVu0V7H/8NRvffpRV+G3N3fS/p4RvSmNZo
         AEYwOGysticwEoT/bcVt/C/h/nX+ci8NtLESXBr1l5cHc2Dr3qhcpM45D6ZyJ9dSOc2R
         PGNw==
X-Forwarded-Encrypted: i=1; AJvYcCWRyJLf3q8eZHe6YE8QjWYOUXKzxfWvgI7LcPaQ4sbGDI8P5q09dZCJgYrq6BPsB01FEuIPUBgs9jGIg3/YG4mC@vger.kernel.org, AJvYcCXYLRaMudWreBtvShI1zy47KBK9TXnHMp4p+D2NwAeMeqbwcYGKjfETd+au4fvnDwETyY59aSUA0+Ms3Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywad/QSo/8KMrVK8QIONL9x5tdKyp2RvoHDkTuFDPzfGRozNxB2
	MuLomeA/qfvZ4cJ8dANpHuqXGIAeZBR5psfVFl1P2EyJiQUE8U6p
X-Google-Smtp-Source: AGHT+IHl1Dmr989gdTR790q75cCYV22rhnkUYI1gqQIkJhtaIaYoDth15eQwog0y/B8KlxsCrdQHDA==
X-Received: by 2002:a05:6a00:3cce:b0:718:d516:a02a with SMTP id d2e1a72fcca58-718d5ee0339mr16938324b3a.19.1725942935891;
        Mon, 09 Sep 2024 21:35:35 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:8527:dba1:3ddd:e486])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8459sm516239b3a.24.2024.09.09.21.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:35:35 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: davidgow@google.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RESEND PATCH v2] list: test: Mending tests for list_cut_position()
Date: Tue, 10 Sep 2024 12:35:31 +0800
Message-ID: <20240910043531.71343-1-richard120310@gmail.com>
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
 lib/list-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/list-test.c b/lib/list-test.c
index 37cbc33e9fdb..8d1d47a9fe9e 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -404,10 +404,13 @@ static void list_test_list_cut_position(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, i, 2);
 
+	i = 0;
 	list_for_each(cur, &list1) {
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(test, i, 1);
 }
 
 static void list_test_list_cut_before(struct kunit *test)
@@ -432,10 +435,13 @@ static void list_test_list_cut_before(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, i, 1);
 
+	i = 0;
 	list_for_each(cur, &list1) {
 		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
 		i++;
 	}
+
+	KUNIT_EXPECT_EQ(test, i, 2);
 }
 
 static void list_test_list_splice(struct kunit *test)
-- 
2.43.0


