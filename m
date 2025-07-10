Return-Path: <linux-kselftest+bounces-36896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B151AFF599
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 02:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F271F5465BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 00:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292788479;
	Thu, 10 Jul 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSt5x58k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC582576;
	Thu, 10 Jul 2025 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752106775; cv=none; b=VQy6Txlv1Lm//jVXbKHXH7rlfti5xlFlGQ/dkbh6/pC9uAJzTZlKm0d0iy/zqIEJuG/I+ZTqhFv4cBDbUpoX8DYX32LYwoLXuW6RAlFxLWmpwpzM5QxF7hHwp3VQVn/f9U7MpPQGVHeBo2W1zHmGelTFIV2GYXpxmYSXqyXjuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752106775; c=relaxed/simple;
	bh=JmOsx5cBItV32FNWImzlQTBoy6p+tMlQ3/JbFRpfLZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TbQz30DC6M9W97ST5VQNbBaZvxvTguosrnSbCWGculzfDVVwFobGqFwTOgNMzGdP3SAdSQ4X3lIXLIuO/i0EaklL2Uqg1oBdXo27WgjskU47QHo5sTHvEIkUMr2n9ITvmBZe87p3LkaGWWWUtnZKiWNqMtKIMKeF041wtWgIJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSt5x58k; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so233172f8f.3;
        Wed, 09 Jul 2025 17:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752106772; x=1752711572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji7e37qngWvjbl+0kQwPCSQJoUjgF+G1Qx/ETbmkYcI=;
        b=GSt5x58k3UvybWtYT6epK/Yd3eBrskkvDDB/EFp1LVtTXITgC+kKWRoTTIRQw4Aqa3
         VVqCwRMA0O73U76mi5aRJ1xBX3hrZ76lPcahLCZlQLe5tQXkxcwLGQpv9orItIsUTcI6
         1ENa4vd+3E664cV7SZFt2U+T+S1CgW8SIKzmKtNwQavySGU82OLt4yuW5EddYxo0RWWt
         Ajw7DV4P3IUnIH9p357yUkhAlUk1B784SFLyGL8nTytuypcIfuLeh5M+DnyPA2MynCLR
         f+13Ir23fQJJXRdY3fnykszFJ8Z3lFbJ/g9lSuLqSNAVkFNJW0YZ8qdxFKBC853uRWbj
         VP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752106772; x=1752711572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ji7e37qngWvjbl+0kQwPCSQJoUjgF+G1Qx/ETbmkYcI=;
        b=au28e2QDjYbpxaGrf6ox28S+M+hCDb7Uy5QCyOnqfZs58Auru3XgMGG9k+4VIeoFnc
         Wqx4iERyzDJe3MPXIFWuGyhUI3jFnRtxROjlWGpWb6vYOP1hHh0ne9qqUSQr3Dad5f+j
         G4HNnOnzGifDSKZrxKCYA5ApV6wFa6B8DfDC+u58VHZpPXOQ6h8eXMW0bAHf6HhJeifk
         tdf7H19P4kfvsJfZLC9kaAjuYL/HrkjDAg2PewuVBVxADRUm0UwDV18v2eGmwCF0NDjA
         ppW+gS2vdlbXi2l9GwQnQUD3kEkHfPfEG9Sl7l8kNv4WkUqUXq8X2A644lAo3sC0ZDDh
         0z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5OKfA9O/LCh3Dp4JECjQNwwwpmYZBLQDo6ARb1LkkK2JfV57RLv6+pU2OKhLfVUHADNVyR6o/CV16kt2S79F7@vger.kernel.org, AJvYcCW7Vxzh/Z8e/jt9sDKJN9IFfdCcxQ6urQQU8T9I5j4kzDpTrw0+Tb3pYS/HpVQN1uIA/OEQXVA9GKgvbVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCChgPeUsvvCb1z5esBkQpKq4WWVNRr/WFoKCf+x706TvzKEV
	OGkEp9gBXP1An7hCM2juasI4/dJytc6/YwuuNBgddtMd3kIqWFo9Nu2b
X-Gm-Gg: ASbGncvy0EUSz3tAqQmpoVLy6NsCzXXFwKNV++OMkT8JCxVnY9pLgKP8v71V4uDazn1
	40JGx82XbZSwrvaeXoiI1ZpVSVK4goyiN2FnEgwUJmEkHLdcnTOas+R3IWOqdyXV6Wn4RjmNHQp
	eXDIk0R1BrSJKezfGihaId6fEMni535t4DcufFKGOJ6cKlgY0ItCVAKnI7xYAYqkC6j15wPJUHa
	xW7t1nCRUtH+HUAQ2IwARjuj01bj1DSNByliNNwEsJZxBuSdNe4wOSZN+LYAJyxh+gq6ABhcBa6
	iJUSLXmCgxZa9Mzroo5W+Ng837CWE/QbneguH9/aUx3t7SV2G+uCOd9B2DoLc5DRcunXxmDCMKs
	yF9AKAnWv7OpbYyzSjKEg+05+z10fJxgwmMu2GIoLq2pllA==
X-Google-Smtp-Source: AGHT+IF2zfYiETZK/hwApSPfG1ch573CkkficunrtEPCOTlBj/gs+csdtyHjkL7czN7gu/UA45Izww==
X-Received: by 2002:a05:6000:2008:b0:3a5:8a09:70b7 with SMTP id ffacd0b85a97d-3b5e86bbb56mr454001f8f.38.1752106771498;
        Wed, 09 Jul 2025 17:19:31 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-91.cust.vodafonedsl.it. [2.37.207.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd462b2fsm2860945e9.9.2025.07.09.17.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 17:19:30 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org,
	amir73il@gmail.com,
	jhubbard@nvidia.com,
	jack@suse.cz,
	mszeredi@redhat.com
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/filesystems: Use return value of the function 'chdir()'
Date: Thu, 10 Jul 2025 02:19:25 +0200
Message-ID: <20250710001927.4726-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to use the return value of the function 'chdir("/")' and check if the
return is either 0 (ok) or 1 (not ok, so the test stops).

The patch fies the solves the following errors:
mount-notify_test.c:468:17: warning: ignoring return value of ‘chdir’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  468 |                 chdir("/");

mount-notify_test_ns.c:489:17: warning: ignoring return value of
‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-
result]
  489 |                 chdir("/");

To reproduce the issue, use the command:
make kselftest TARGET=filesystems/statmount

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 .../selftests/filesystems/mount-notify/mount-notify_test.c      | 2 +-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 5a3b0ace1a88..a7f899599d52 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -458,7 +458,7 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		ASSERT_EQ(0, chdir("/"));
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index d91946e69591..dc9eb3087a1a 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -486,7 +486,7 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
+		ASSERT_EQ(0, chdir("/"));
 		unshare(CLONE_NEWNS);
 		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
 		umount2("/a", MNT_DETACH);
-- 
2.43.0


