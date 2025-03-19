Return-Path: <linux-kselftest+bounces-29400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EC3A6815A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 01:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB10884AC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C5C1C8FD7;
	Wed, 19 Mar 2025 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Fgfu4GvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14B1C1AB4
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343352; cv=none; b=R/Fv3h8pKyfaFNGt37DFpcRU7KecgJbHy4+D4Hoc11KZqPUqwewO9G1vOJ9/w8Q6joM/shn9aSz+qhQBW01/n9IYGO+rE7APi+VArpZaL8uJ9U+/Ff6tGvF5kj9ypgluPg0pUXu4VP5rcVW9fsdJ0A02/vx+GnERqPoFG2lhOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343352; c=relaxed/simple;
	bh=vfmaI48yQu2LzbBRsfUKYj71ya/2pybugWom3+MlAb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moERBfz5N+JGJb26OoqKZXgEkmdqKM6K4fyWV3hYULs3KiT9G7IcmoWb5/rXBWCOUzNPQhBeTZuvqhU0bDqZ6EQbO/s2aSaVkjg8/dB5AmEP4YiQTbvmYRFunyR+eMYOjausdlNfSbdLpowl+uGwfyV15SZy4SbvJ5kbHuq0L0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Fgfu4GvO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so7330005ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343350; x=1742948150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2h8ahGEK8NaWNEbWiVu/ZrnscNwqcwDayJj5C9lFzM=;
        b=Fgfu4GvOW7stKhQu5e7z9IC/Nv0oQmJEqDAVI/BLiHzM8QdXiSjIqaUlpvskDPWngk
         M4Hhz1GrWXmXi+HYbhJImPSMiUnprJifoEwOxFpvOZAdYtnHrcj830d1SNiEyFw5h2uP
         z0OEH0Ld/35wCgYMxFW3HKiDEMZ3tg9kH47Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343350; x=1742948150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2h8ahGEK8NaWNEbWiVu/ZrnscNwqcwDayJj5C9lFzM=;
        b=nrruTG5/ZBCB7e+bT4yyD9XCOcS6pEnDqKg9iMIP60Pc1U4cRag+MprEuQHdoqMkVC
         VaFDJ2/kraaPF1KHjrn4uGMSqEpO5UnMlO1+TkCODoLgw06uk5siDdJnwjdCP4vARTgw
         LKBp/m3dkrVJnYvVlq+pZT4DvblFJR4RxZGA7/SoHF7z29P+dsCik93jeuhI1qTqeLdd
         sfeQ02XMxAqbd9+etjWEIKMNV276XsS94IkLl7QtXE3TfAKBAw6/W/p+4TlIsphbd90Z
         02/ebr5wIsc8DtsLsmVDcnMmMEyjNSn+JRHE39nZXmkAjLmDi1oUJz1jzqJf+jLs/zwC
         ck1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAByOxXam0Rvn82fWMP45TZ4DZ+Rd7uDxbeTW8bj3fXaOnGb3MsrhTjxi1XnQoSkV/aZBDsDej7X/aknL4VB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztlUbFkpLGjLiD2fxkF/qVRlnalc0db7kwoawfNwzmNvmse2cX
	UbQepIJXHB+JRwwNMwqXYvb9RJmIE+y5pawFeF3lDXNHV4syh0V/PpwFYfXxSAE=
X-Gm-Gg: ASbGncu9DoYp4jU2ZTcM0uhefB70cx/J34TEHA08PMSuNZUjrjNSkzeXhjeQ1qJZ40s
	mRNsKM6jjkm8o1TPsh3b58O0RaJ0Xm7bqTmo7tDpv+TOBTsKoAl/D2klI8zSevadQCiGjqxXyN1
	7Sy5SRr/Evu4o0jJGPVAgYBpgXKXgDswl3XmvbwR/c70dIHxtpblpjyF9ZiWrO9TCW17vXjLaDf
	Y8jZ9yObnwOTmIMIH8PSq4+0x5Ov3U+7Wx4th8+opDowCTsHscQ6F9uobwtEPeevMRaZsLe7JxU
	yMlMdsZl5BqlN8SxzuoEH41qaGsFBeeeAzzVx8gqeHVZdpJi6+mt
X-Google-Smtp-Source: AGHT+IGTEGf1f8q+q48T1ikUY+fDbR7xEVmvuzHJIMrxwMpGrnPzwUvPjVZv+TsZZ6BX0OHQ1CwSDw==
X-Received: by 2002:a17:903:22c4:b0:220:faa2:c911 with SMTP id d9443c01a7336-2264992ff63mr9690915ad.14.1742343349888;
        Tue, 18 Mar 2025 17:15:49 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:49 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 08/10] fs: Add sendfile flags for sendfile2
Date: Wed, 19 Mar 2025 00:15:19 +0000
Message-ID: <20250319001521.53249-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a default flag (SENDFILE_DEFAULT) and a flag for requesting zerocopy
notifications (SENDFILE_ZC). do_sendfile is updated to pass through the
corresponding splice flag to enable zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c          |  5 +++++
 include/linux/sendfile.h | 10 ++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 include/linux/sendfile.h

diff --git a/fs/read_write.c b/fs/read_write.c
index 057e5f37645d..e3929fd0f605 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/pagemap.h>
+#include <linux/sendfile.h>
 #include <linux/splice.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
@@ -1360,6 +1361,10 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		retval = rw_verify_area(WRITE, fd_file(out), &out_pos, count);
 		if (retval < 0)
 			return retval;
+
+		if (flags & SENDFILE_ZC)
+			fl |= SPLICE_F_ZC;
+
 		retval = do_splice_direct(fd_file(in), &pos, fd_file(out), &out_pos,
 					  count, fl);
 	} else {
diff --git a/include/linux/sendfile.h b/include/linux/sendfile.h
new file mode 100644
index 000000000000..0bd3c76ea6f2
--- /dev/null
+++ b/include/linux/sendfile.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef SENDFILE_H
+#define SENDFILE_H
+
+#define SENDFILE_DEFAULT (0x1)  /* normal sendfile */
+#define SENDFILE_ZC (0x2)       /* sendfile which generates ZC notifications */
+
+#define SENDFILE_ALL (SENDFILE_DEFAULT|SENDFILE_ZC)
+
+#endif
-- 
2.43.0


