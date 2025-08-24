Return-Path: <linux-kselftest+bounces-39801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1ABB32DBF
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 08:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952EA1B250CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 06:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FC23AB8B;
	Sun, 24 Aug 2025 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrZ0MbUN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DF23AE9B;
	Sun, 24 Aug 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756016085; cv=none; b=liFwEEpaS1p/xbZ4ZkggrDpOv/hrEOmPmIjsnVDiyUZ5D7hrIurtojw5zOJHhxvqsdtIpDQ1chY04wlR9mA9ZZLsbiANxPEWwyggXqjXjfPjhN1/jCp0uxPzw//dIXct5A0MDowwy4Yc1NSDkZEMecqo4zamRavrgxwb6Y2Ucrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756016085; c=relaxed/simple;
	bh=dEFjZ0irkD8kkz4VLaw3rsm64cw0sBJqoMvvNXPG+uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bX7bGi1HP0o+vVpVhCGxY0FmjmaaCqYSeNLNcWQNpnkLhZWRvtpJbshaJdpJ1sonznQ1zDe4cmiUZ0s31Bs9tJU1lHsioQSMvA4Ug/WQXkB0YQpT9lf7VnLt3Fn0UduRXNo7lJyjLSkFXTIj0MyjqkZC0tzkEe4u/7OJo1Wo8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrZ0MbUN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3006732b3a.1;
        Sat, 23 Aug 2025 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756016083; x=1756620883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfzDzbQEvI2nMK5aWsczii03Df0gZy+c2/ZhXQWQ8fE=;
        b=VrZ0MbUND8s/mU5LAGHtwXlhtXkLtbdfk4idVH7Lgpqf6e2EPzMkIqFlN1hu+szpcW
         Ik1MTiuKhrxKWAoGwSyX2J4O0p9d2beS3TJm2V/RYqREAdZTMc7N63J5a41vU1buSBuA
         f9W2mr/SyE66jtwWU1LwvYYbcalIHgQtsYCjnNGCZUcVXc4gYlbjE21LUDleVa6pk9uW
         nHovaPNE4TDIiXaN15UDNDZUiUfuAAAb8diqJh6vkmQGifIo0SFf0ND8FPM/HKj6SHdM
         Lm1BDeH0AdRmJpgBrXHxf9v9uZN67rT8Mus9p5OMNWL8oeaRF7mV/cZWrCPu5ALJo3ZQ
         7Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756016083; x=1756620883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfzDzbQEvI2nMK5aWsczii03Df0gZy+c2/ZhXQWQ8fE=;
        b=lawwsHMOH8rgC9KMxnOAPRpd7VCzTJLCBxJHjxUA9XzfIBwaQOf0GGIiHhNKsBXBg+
         lPcckmCUlczj1iro+Fun5gbklznklhKJ8U39q//Qmm/QGN5v8F7Y1jbDY/NkR8pvEMZR
         XaUi7AS8uXlSfXONd2jKh5k28qbwZFi3eeiGihC6s3WXuwuUI6MhCgxQZAhFNY0esR88
         9ugTlDUKj+zB1fkB1nKrX6y0s59bMSO3Ory6nIZMhdU29ZRQmHa2eESSS09DKNZFcLU2
         Z1sSVNTmLajxPXIxk90ZTKBEWsWZAy7M2tFkMsKv/JSg5ojOnlic8fEJnJZYZF39MP8o
         ge5A==
X-Forwarded-Encrypted: i=1; AJvYcCUrQ4cf927BddfEqJBb/ZPCJa3shqiuqeoL8WxsIgKcL5+aRB2I7lpZMQlDO1zvOUE8V+Hj53j7oX0=@vger.kernel.org, AJvYcCWOBPQpxGUIyA3WaIl7DbzYT/LacvOpJWL0go6XUI/o4gjoqnUYg12BUsu6U9v8ZcqC0BT7YXnmt/tcopJ6mLHe@vger.kernel.org, AJvYcCWXfoql8KzH7TuKjHQsOjEIBAKmeFQyBnZWMszd1FId83Lhl3GTmC2eNCXdxYFGNhY9WvD+9kfUt2viQO+E@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ft4xCA2mGbvnz+7hR3r6uNKeAIuDjj0y+eTZvmNIoHwdUpvT
	Kv+OBHIG0VxNCbBBc+RwYjT3iys9chihRkbZzpQxnBa0Aa5i/ttHi7eX
X-Gm-Gg: ASbGncvVd5+gp+fUvbbpg3RdHGvCOhK3JMOI54M0O+9CqavwtfYqjDJwqLB591WfsCx
	+hioj+8qXS7EJ6kUr/A29yq+DaiNxzBB1sT5miyaVaFv9+9LXE4XUZVHYE63HbMhyBdLp7Ayeil
	cab4X2fFjT1ROkVjNCWarscU/hGwzGyJDlSz3Y/pHdaBAEo+DlmFuKVtl0rPmyU5NHKmWh4VftM
	3R74Rnfb7tOH2gnegkr0xCQrRmP4L3p30ZOLdIFBJzvFJW4fO9CvXV4TfYbVinhf9+m4WNIdMag
	PLLZlWLG/+w7vsP3kYtQvclF+vEMeYD1iGr/5dqEEICm0OZi1tyRf9NXYd0uVd9nZ8tMi6dD3eZ
	CeNhL/04JTW5iP3U9O1VTe2Lcz/2BZqBdEZbScypKThiu/hP2l/RY
X-Google-Smtp-Source: AGHT+IEqAFYx6AisrGgN6ojBhMS+11Jpj/ZwAjl0loDmwXyLPUL3fcKiuqDVFbHLxkK8FpX3ngzJtw==
X-Received: by 2002:a05:6a00:3d06:b0:771:58e:5b1e with SMTP id d2e1a72fcca58-771058e5effmr111559b3a.12.1756016083290;
        Sat, 23 Aug 2025 23:14:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770529149bdsm1654943b3a.98.2025.08.23.23.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 23:14:42 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 3/3] kselftest/arm64: Add parentheses around sizeof for clarity
Date: Sat, 23 Aug 2025 23:14:02 -0700
Message-Id: <20250824061402.13432-4-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
References: <20250824061402.13432-1-vivekyadav1207731111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Added parentheses around sizeof to make the expression clearer
and improve readability. This change has no functional impact.

```
[command]
	./scripts/checkpatch.pl tools/testing/selftests/arm64/fp/sve-ptrace.c

[output]
	WARNING: sizeof *sve should be sizeof(*sve)
```

Fixes: 0dca276ac4d20 : selftests: arm64: Add test for the SVE ptrace interface

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index b22303778fb0..90c56b38dabf 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -115,7 +115,7 @@ static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
 {
 	struct user_sve_header *sve;
 	void *p;
-	size_t sz = sizeof *sve;
+	size_t sz = sizeof(*sve);
 	struct iovec iov;
 
 	while (1) {
-- 
2.25.1


