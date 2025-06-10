Return-Path: <linux-kselftest+bounces-34533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1CFAD2BC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 04:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6F416943D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232917C21E;
	Tue, 10 Jun 2025 02:08:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669C29A0;
	Tue, 10 Jun 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521309; cv=none; b=FXzPrOyH32QpTS8fQzmEYHVO7+QMAdxVUpP6QDtPRi8jdRKtZn+KzC7gF7AwIsVWFU4VSpWSYc8GsEtIV0RthtOFyC5GrRMTNm+dr9jRYHjG7dxj9uLuC+kwsv3tGIASva91mUlGcFDWyi2+S/2yqtremJSxOgCvEIJEGlR/qDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521309; c=relaxed/simple;
	bh=PyVS5Ca/GiCDjbyHz8ZFyNBYLTm39fGuhScpF+ABEW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFQkiQER9QuzPkf8TY2f/C6SMPqYTNvluA3w/oiXIAhD4bZJBOv5yPlcRZs3Gac6t0GSDDRkEfQ4y5+PSlTHlSmeLBlyzV+G1P2wcCilkoS4mLuJNiuxMNn1xSQKd8rbzbPOkfkbFVRuJey/jkXx3O2yU3BJ5xlLSpb8AgG9a3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6faf66905adso31003396d6.2;
        Mon, 09 Jun 2025 19:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749521307; x=1750126107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5l7crO49tehMluY+s3MQ7KZSQ7naCKKBXJdEzrIe1w=;
        b=UHkuo/6RBWz6bBeh9om4EXzLuXLOwk+5BDlYrk5XoRIxVR7KkuUSLrvYugLum5NuLY
         BeyNZvi0aIwCp4ZnzTwiYF04fHMEJD6fCskBdrHskiqNV8WWhcJChteqaWMXd1MWkmEs
         V6MQhOchN57Zidx2qoktgEiVJAR2QG8jXDIzrbswY6rHAEXFxx4NkfuGj2Q8Vzmf8IYA
         nWG0bpL4XBj1AoKD055WTnWSYM4diPg3BJzZvRqXlzXJyTE5YLnEzn4MlBCUfkuLwkBI
         Rxc46OFmYbLRgqEmliieuVe1cF0cyfdHa8nBW/m9qCBy9Dt04li1RjEOx/aC3BSAD0sv
         96Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU9OXb80lgL2Hx9yHgYnYBFDzd3Y+HOAp9dfizAcpZ1KiMhOFvQwVxIKM3tBoDZ+bzA8D61RZu69LdFaHq2gR2D@vger.kernel.org, AJvYcCWukedVIyZqs+87Ea6DFhVrkpDKXp8P8qcM7WQ65JVglK6ZkgFoc3JEGhDsjaKx90PF+VPjMN6lQLapf0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlvaBy4NO5hcxUvN6cwYsNNaLZpp9lRloH2HMBWvQzyLpEsYNY
	UEIyqaNDJfclGqDEcPwZ1KcIukH9wEEfjHpkjyTw5sDtdZSeb5oJkv9cd/eIC+KMNMo=
X-Gm-Gg: ASbGncvI4niELIVVcTMkX4/WRLkcgB51PRaCQZnR1QBiFt1XANucHswUTUstBSwBgIT
	Y38nhXEJXFQu6Os8wdsyFR24UVzEJIYoByUOZtluyYVbgDW6JHsOF2RtWtz3aOikUV5tCV2Dij9
	YfAz7C4XG1rU9JzNlcEpvOOQkuwTej7CDCKfOiRenb5hGoX5T3ZMtn3StecSM8zyV+ZKbY+mxT3
	Jdik616zx4CSOPZvWk8cj5A+NfMxK8jq+DigvK71dUaU4Ej/rezYqx0z/Swt96PuTPK+GU9A6rZ
	IOqXyvH74xtYYdBqNoBAio3WEGk3bgrEQOT30VjiSRMZWHhpVbdoTqXcY33/hp9zIxS9pqG/a1D
	lLnPXBOJE5s60LRtDcy9OTw==
X-Google-Smtp-Source: AGHT+IHnuIE8PHQbLq+4boGMp7B1osfy71c9ZqsPZsrjBrra+rmbDHqteKOSUy+BJmkLvwT1ldZVSg==
X-Received: by 2002:ad4:5f0c:0:b0:6fb:16a:da41 with SMTP id 6a1803df08f44-6fb08edeed2mr258166956d6.0.1749521306683;
        Mon, 09 Jun 2025 19:08:26 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac83besm59803656d6.28.2025.06.09.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 19:08:26 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Chen Linxuan <chenlinxuan@uniontech.com>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] selftests: Suppress unused variable warning
Date: Tue, 10 Jun 2025 10:07:45 +0800
Message-ID: <20250610020758.2798787-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running `make kselftest`, the following compilation warning was encountered:

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  490 |                 chdir("/");
      |                 ^~~~~~~~~~

This patch addresses the warning by
explicitly suppressing the unused result of the `chdir` function.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 63ce708d93ed0..34afe27b7978f 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		// Suppress -Wunused-result
+		// Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425#c34
+		(void) !chdir("/");
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


