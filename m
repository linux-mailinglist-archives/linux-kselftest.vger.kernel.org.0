Return-Path: <linux-kselftest+bounces-3454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF9B83AB76
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA87294D83
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA827A70E;
	Wed, 24 Jan 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoHhygbg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133C77F2E
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105717; cv=none; b=nldJSUyyMsNcS8P3YYSsMdROnRFBRXYeVjHLeDjknUyEgzQQdLXpJah+MPpduIX0JoePL86JG8a4g49VEIyBLl/xudxdZDj4X550ROhfEvqp3z2nq2EVQ7BX7pzUqFJFY+SLQhM2a5EBgJU6kAFmx5rvakasLxdI7QRRwo4fJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105717; c=relaxed/simple;
	bh=cE2W5KfsS/6abmLqZjvi1Wi0V0vV3k55AMuKwFWLxQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsh9NIcJ+9lrFDqFkygUONnmiuXU/iyLiMsDElYPgo/tZzqyRiUMavSl17mKM1mZ6UHn4VIQ+bHCTYkIfPERKTQ0qMu0dnzm/3M8xFAv1av/WuGS38+dSXadK8kxbL1Fhr39N5foapmZIynRaQxfnDha3s1sl3SjgNbVoLSWJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoHhygbg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7ddd999bso6316158e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 06:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706105714; x=1706710514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXWpKvuuFDRe0zzHcqHQWgdjThR4TPIPgqd6iq0g85c=;
        b=uoHhygbgkRGKW0AOymPGmBPfX+S8edJ2CS3+AQkFdE4A4dzLgoDwtON3QVLisH6zIc
         oQALN+yZSjNjlYOfSpYmNwsDbEpj4YkD2RnveO3UZEqS/lQUlso29Rgmd7ez0L4SZh3Z
         M1OUB4POLJ2Z/FKVgM84h4oQwqDjylVlJvNTCGAcAHrPMlGO4bN8HDj7zvrE127IIL6L
         IWtIQWvZbTlRaJcWzX9AZlDyAPdCdRXJKrC8lhuvR2DwfAQhT6MqZqWnO9ZhpGrPTBZh
         /DrhFyyDRyLBu+V/Sl5+/heE3LHNNjswkaT6B/NGM7N4pUH2GNqdZZ7p2OMDBAgz9Z5o
         fEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105714; x=1706710514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXWpKvuuFDRe0zzHcqHQWgdjThR4TPIPgqd6iq0g85c=;
        b=aKZx87Q8WRKICe2nkB2iddk4lIFY1aiU+o5S17Sz50x4XFQAvnAiNL0T3VgJKuW1ZH
         nSU7/4Bj+YTkMBHqma+ldXIZvyOfvT5aLhggI88XIT3Ao11b038q1/zSLSQxX4pkM8be
         qtACUaDP7mkhKtq+rilQWeaPCxYA3seWP+XTv8lO1ACsvxYA35sCdH56HKojeGwJfmYe
         NOZtYnID/5dCeVr0cT2t5Xxj7n2Xj1YDuLzAznlWgOxuCgpEHoklnz83JHo5fBxdq3aC
         PAY6JOge0oK7i2/TYP+Mu8a/hxc2mKDPd9P2xTubQlvafUTmQDF/77hTR3xtQEAGRBJF
         HFJw==
X-Gm-Message-State: AOJu0YwURt7WL6tlg6SnKucEhqpCkHn+EYLIlNHebXZY6cUZcnBOKtl2
	QqxspkEFGmWud5iflmSwX46GUTWM+EWG+eCCtSbiDbH7ubhA5m9GRBDYH3jrC4fpg65O4nxOZHF
	lLPn4nA==
X-Google-Smtp-Source: AGHT+IH1z0g9TaKz1LWxOeu/E1gh1nmHd+p/Mcap/m+sFaxrPQm/m1RYdgfMqihKVInodCKSpHNIkw==
X-Received: by 2002:a05:6512:2210:b0:50e:74ea:525c with SMTP id h16-20020a056512221000b0050e74ea525cmr3950398lfu.3.1706105713953;
        Wed, 24 Jan 2024 06:15:13 -0800 (PST)
Received: from ttritton.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm12399097ejc.29.2024.01.24.06.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:15:13 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	bettyzhou@google.com,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 1/3] selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)
Date: Wed, 24 Jan 2024 14:13:55 +0000
Message-ID: <20240124141357.1243457-2-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240124141357.1243457-1-terry.tritton@linaro.org>
References: <20240124141357.1243457-1-terry.tritton@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unshare(CLONE_NEWPID) can return EINVAL if the kernel does not have the
CONFIG_PID_NS option enabled.

Add a check on these calls to skip the test if we receive EINVAL.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 38f651469968..5e705674b706 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3709,7 +3709,12 @@ TEST(user_notification_sibling_pid_ns)
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
-		ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+		ASSERT_EQ(unshare(CLONE_NEWPID), 0) {
+			if (errno == EPERM)
+				SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
+			else if (errno == EINVAL)
+				SKIP(return, "CLONE_NEWPID is invalid (missing CONFIG_PID_NS?)");
+		}
 
 		pid2 = fork();
 		ASSERT_GE(pid2, 0);
@@ -3727,6 +3732,8 @@ TEST(user_notification_sibling_pid_ns)
 	ASSERT_EQ(unshare(CLONE_NEWPID), 0) {
 		if (errno == EPERM)
 			SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
+		else if (errno == EINVAL)
+			SKIP(return, "CLONE_NEWPID is invalid (missing CONFIG_PID_NS?)");
 	}
 	ASSERT_EQ(errno, 0);
 
-- 
2.43.0.429.g432eaa2c6b-goog


