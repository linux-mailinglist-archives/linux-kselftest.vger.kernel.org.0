Return-Path: <linux-kselftest+bounces-33445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4FABEB20
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 07:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D2D7A3EB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 05:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5EF22DA00;
	Wed, 21 May 2025 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVa9vz7K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB442AA1;
	Wed, 21 May 2025 05:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804083; cv=none; b=fVZ4VSvdw81pHVUnBLC69ljNE8cVCFE7sxfGHtgtJKY4xgjwaL09Etd6TtUr5zSEso2zjqZ0eG15JF9rCWmiyBhusSyZj4oI3OE9zb/i0J8EN2VUbUdajl8nHFlZrCXuW6ustrlAourTFnmx87NinNyv8m5xef2zJjVK+pJRb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804083; c=relaxed/simple;
	bh=Rf0eghCGaFsbU7DUc7aON8zNl77X2c1451dodyfs2+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFz+hIRfh5ImehdQZKf8JFjFeyvNiqZmxqyw1xqJUDbsv6pf2WEr+u1dlYLqiWKQw/6sEec5yXmvfZoCkFbFmqPAwA8gNnwumxzSdGJJbAxVGVNFGogGoBHzkt/9RbN4lc3K43shs1DBWfQIC+wLrDOOaveWHXkFUihzwnrw8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVa9vz7K; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so5478550a12.2;
        Tue, 20 May 2025 22:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747804081; x=1748408881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Egkjcx8dXUY2NPQXCg/DJ7tP6/t8qm4xNMjQ4B2fuhA=;
        b=KVa9vz7K9cS9ncznucEmLmXjdAUPPP9wjvTWuOcBiNCpCyspuV3Ug0p9AobHhwlVM3
         O7zseM9/58gZ5GhSEh9l0rK12tNFO0s/K147lrjUisQvFd8CM+y15j4iWsWmYJDTSpPw
         DxX7IWxRydzhBUOLGKl9KvJnrX0I7KsVLvM2cLi7gAsXi/wvClc9lehbVGFMCgjhEm+f
         hlLaFVtU1+Qo4lf7Oat20vAhXE1ZOyIpyB7bnBMVcatULC8GtzECZJ3xRqh9e9TKcQi9
         Yf+Dl8E9T5JnlQa66hIvifcRAwotSsDQ7PestQjRPDVTUUxFqeFCDk0OReUoQ+colyGv
         TwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747804081; x=1748408881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egkjcx8dXUY2NPQXCg/DJ7tP6/t8qm4xNMjQ4B2fuhA=;
        b=tqUGovGaKC8l+rrTxm2hhDRvDavcECIUm94STKfdLbFmPAr9LZOijnJuYMcCMnJ5Lv
         yNHX+DNbI5p952ku/iefT9t8orcz1/Z0ME6wJmWsHTLq7UFPLKeLSl7Arx60q6UHD+0Y
         VmylmBkkV7Uu8rq1omRckUruQnidclxpL4GOXf6QrbUJM9+IG6Yp2+RfgFChN6kpSu4Q
         o6e8CMXEIEXEGb7Wito89ms0OfcrtxwvlmmR/tCqx+WQp1KgNETIROiLxgvnuaNBHanh
         /t1FeMMtFpVTs0AmY0AL8IRd6plDJlFhWZ5/ZkzOwWQbTYRLyy0iUlsH34Lt7VoCodaA
         oOTA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQ46CuR4652gHtMkSVhBtxQXrSDea+Z+UQskG9JP8BDhmuQlJHMbss3hCRUyx8R7UC4VEOZfiMEclcf2ACNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfA0fhuSKD4Wq1v7DTl+7dT602DIsDN/Y581T6FUhTVylpKon
	QKGwfzuzJbu3gWJBAAjinnrt7iQZ9bbzT4FwqNookX7YFyMz3NIw+2qp
X-Gm-Gg: ASbGncvMU0+4LYaQi0wigy424OO80lokNFgm/Rf5XFDPsRRAXkcMgbEYAi1paWvEZtF
	M4F3eMcdiyXJXBBuy2Uq0IOKMiIa6M73G9nBRrzEk8Z8Vfx3iYSMZnGFlKc4nl32BjXfFdPoAw3
	68iBfQYLVU5U6N1yJEM8wmBr53JuZ4p4QjxwLXIXLytGmcG3c263teb/yZpBTReEqEO9Iv62Dsp
	Rl7a+/GxWGN3Q08SO3WrIxeXTOnXGFnYQ4bWMmKJyLIfbT6PaSvm9tpn9mEVf1a+ohIMZTt6n2W
	Zhpx8ipubzUpd36MC/kMiuRafrCBHKdwd09/y7n+BgWKiNL4dHcWJLvzE3MHH9byZM8ccbWfXwH
	34t5BAph3077vl8H69+GAEpCyWakN
X-Google-Smtp-Source: AGHT+IFylaW5+bTuItRsX8rJFA7S4tAjGIy9vgweiuldLotx0JVuvmHj8HP0u1tMSdwz/m6JS9P7Ew==
X-Received: by 2002:a05:6a20:728e:b0:1f5:6e71:e55 with SMTP id adf61e73a8af0-21621876d2dmr30413194637.6.1747804081253;
        Tue, 20 May 2025 22:08:01 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.hsd1.ca.comcast.net ([2601:646:a000:5fc0:aebf:fcbc:c222:fc3d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf5cae2sm8910798a12.1.2025.05.20.22.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 22:08:00 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH] kselftest/pidfd: Fix typos in comments
Date: Wed, 21 May 2025 01:07:50 -0400
Message-ID: <20250521050751.629473-1-ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments in pidfd_info_test.c

Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 tools/testing/selftests/pidfd/pidfd_info_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 1758a1b0457b..53cb429f5fa0 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -229,7 +229,7 @@ static void *pidfd_info_pause_thread(void *arg)
 
 	close(ipc_socket);
 
-	/* Sleep untill we're killed. */
+	/* Sleep until we're killed. */
 	pause();
 	return NULL;
 }
@@ -518,7 +518,7 @@ TEST_F(pidfd_info, thread_group_exec)
 	EXPECT_EQ(sys_pidfd_send_signal(pidfd_leader, SIGKILL, NULL, 0), 0);
 
 	/*
-	 * Afte the exec we're dealing with an empty thread-group so now
+	 * After the exec we're dealing with an empty thread-group so now
 	 * we must see an exit notification on the thread-specific pidfd
 	 * for the thread-group leader as there's no subthread that can
 	 * revive the struct pid.
@@ -665,7 +665,7 @@ TEST_F(pidfd_info, thread_group_exec_thread)
 	EXPECT_EQ(sys_pidfd_send_signal(pidfd_leader, SIGKILL, NULL, 0), 0);
 
 	/*
-	 * Afte the exec we're dealing with an empty thread-group so now
+	 * After the exec we're dealing with an empty thread-group so now
 	 * we must see an exit notification on the thread-specific pidfd
 	 * for the thread-group leader as there's no subthread that can
 	 * revive the struct pid.
-- 
2.45.2


