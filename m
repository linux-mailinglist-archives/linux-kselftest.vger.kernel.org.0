Return-Path: <linux-kselftest+bounces-8267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7338A8B91
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 20:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B041C23A06
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2818C1F;
	Wed, 17 Apr 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jllUXDVf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDCFBE55;
	Wed, 17 Apr 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379760; cv=none; b=rcSuUH7yRdDifzX31YVgSHpqGgsfyI5qfVo2VcZmFetGntWd301Rc13q20qOxldoOSj2JXwpCEeZiNpIiXkyelUBGz+nl9tbjPWCeX11O/MMY7wEYUWOgcrdwDWfpV/x1OuUl4Ea++s4q69Tgo75ZS4hzWPY1QZvwVQo4EFCfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379760; c=relaxed/simple;
	bh=5ZzmwJhl3Y2zPSlH75Q7MuUxPX5P1ljTDT9NrR78cbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H6cxHMIwvQ7F9HUGg1X0q1jET6MsdZYK2+r6641UKs8TDhjXHEUpadZ7uwe63WJO0M868JXR9zbGgipTK4kkfleuBdGrzirWA+Hv8J/Om3ezBDrxm+kvVire+RxweVxcZaMiiPilWjYWTmxjfFz+J2ZfzEOkcQ0e4dEO/7v6+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jllUXDVf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518e2283bd3so6399586e87.1;
        Wed, 17 Apr 2024 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713379757; x=1713984557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IyAFKAJgIfEStrNfT67LkdDfKM3aFOk17Et0vZT8co=;
        b=jllUXDVfGY8qUWGkv7xDZsyQTx8XCDyvVVVZr3m/8sAlya7qJJbEEpfO9fEKvfr+11
         5SmRdGLZUqoCqAaORcKJ5P9VV2Bf4JVHRo08JJovQckXAD3qQk4Vz9h6drBlBKCGq6uf
         bp2J7dKvnQqBlUda/BoQGooV2THy10ygP9rJLye2M6m06Nfo2wswQ1p86H0ZITklTS72
         w3ayrVq4O+ChZb8fQhkxl+e5CykmJbGv9BppW3D0EBumrY5c5t8rPoUTmIStPfeCdyrm
         bw5cYDIdpzHJZL5zp9abxPrIZTHrc+BSGoWzgWwPJRW57MRxU7Aa+APjMNe+Uc4Ft47H
         qfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379757; x=1713984557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IyAFKAJgIfEStrNfT67LkdDfKM3aFOk17Et0vZT8co=;
        b=iLwCzKOC3uZG8NsFZs0aX+8o6S/7KANuKN7V8SrRH7D0Z7RK4ivmzSCHgMxFn8LnGs
         IPvVwtXPKxeKzYDfCqaM/3PxM+zQZ/J88Kk3urlg1FX4uN5q+/75o0TunSKrCrD8PfgQ
         XOfONHBjC7cHmte+Jtt3JYmeyCOmYFVhRBniLaNovqPpU1fdpt3GZpWFaJ5TRQC54P/D
         0D3yrJhVBftn1A7JbyLpPldTQxpDQmxfH1DX62zIEwg7p90poU8OEG5LigQO4QsxnoW4
         csgjvTC6u88AS0AtBxgvZZ36Dp95XlC0JpRc6Pazd5n1zweAY/qyDUkDMHYNqoLHZZtm
         lFog==
X-Forwarded-Encrypted: i=1; AJvYcCWTTHGNYv23DqSU7nkt/rMrN//wBW0Wm8//v0V/beK6/oPzUmad97PGTnEXBl00VvmRRt9cjgSDr/PCL5Z3e/GuknOsPSQqwDs3444PiKzmv/HYDxq9NYOy2qy1dxbY1AvfDwFdsBEkC8BhNQPL
X-Gm-Message-State: AOJu0YzwVfK+7aFxjJEvRacirFqIkJmWEh4SPJIbnlBS7i7R5kZxpVrY
	ra8h65pVGw2jJg+NHZwtFpHofYkY8ZFecDOmsBE6Iq+XcSPZ+xfS
X-Google-Smtp-Source: AGHT+IFjeZypMhZ2KjvyQn1kWQYnQi2jRPUMWA27bpYFD9y1prAMm2bW8GiX26hBbx4CbZvI8U6AFQ==
X-Received: by 2002:a19:434a:0:b0:516:cd71:9bb1 with SMTP id m10-20020a19434a000000b00516cd719bb1mr90038lfj.38.1713379757270;
        Wed, 17 Apr 2024 11:49:17 -0700 (PDT)
Received: from localhost ([185.204.1.218])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b0051925dd92dbsm631172lfb.214.2024.04.17.11.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:49:16 -0700 (PDT)
From: Amer Al Shanawany <amer.shanawany@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH] selftests: filesystems: fix warn_unused_result build warnings
Date: Wed, 17 Apr 2024 20:49:13 +0200
Message-Id: <20240417184913.74734-1-amer.shanawany@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following warnings by adding return check and error messages.

statmount_test.c: In function ‘cleanup_namespace’:
statmount_test.c:128:9: warning: ignoring return value of ‘fchdir’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  128 |         fchdir(orig_root);
      |         ^~~~~~~~~~~~~~~~~
statmount_test.c:129:9: warning: ignoring return value of ‘chroot’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  129 |         chroot(".");
      |         ^~~~~~~~~~~

Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
---
 .../selftests/filesystems/statmount/statmount_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index e6d7c4f1c85b..e8c019d72cbf 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -125,8 +125,16 @@ static uint32_t old_root_id, old_parent_id;
 
 static void cleanup_namespace(void)
 {
-	fchdir(orig_root);
-	chroot(".");
+	int ret;
+
+	ret = fchdir(orig_root);
+	if (ret == -1)
+		ksft_perror("fchdir to original root");
+
+	ret = chroot(".");
+	if (ret == -1)
+		ksft_perror("chroot to original root");
+
 	umount2(root_mntpoint, MNT_DETACH);
 	rmdir(root_mntpoint);
 }
-- 
2.34.1


