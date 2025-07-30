Return-Path: <linux-kselftest+bounces-38073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FCB1572E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 03:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8600A18A6EF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729731DDA31;
	Wed, 30 Jul 2025 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBOh/fBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5261D63D8
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Jul 2025 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840350; cv=none; b=aJjkqFznqi/Wbsi6KDQncGMW18q6kaF/zQC3REndpuGU+NR17L9wuRd2TlvRu9hlc0BdPO5Fl+ah1NmxH9J8qJuO2MzUPbS7z9oN0kg7vNThiTjerFF/MCk/cwolkXYFNf3MN0Abqu48BubApwVSzGbYOTTWpAQfmFZmGhU0rFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840350; c=relaxed/simple;
	bh=bIVPwrpO8SrMLjgS/y8qvrWq8I4eF4yscR03ISo0OQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rlmgitkcu6QOQ9BX93PcsBwPUi2wFZ2jRFgriSQ0qKIpjGhCo7h0ESo1do/WH6lKOBjwOAJBhQ3UVzKBgtTKQbT8lHa0vNOFTAUPKsyu8dcfOgBg0xS9GAqx82MdntjlyOrc2ClKimxV7loRpvee3cTgi6W0M1A8qRGwUdXkYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBOh/fBX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so8076492a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840348; x=1754445148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcBRucushUU6rMWx+KeKiW2WO5qBqS7bIQG8Zk8QoQw=;
        b=EBOh/fBXaEpyHYYJ+4cnA34whrOpGg0jOUBxRLpPMyIr71nOlHoVtXSEZo68MPxKvo
         s9tZ9g6ABN4112qdFLzsyolDJcKq6s7hctdBHvJgL6hoy5s70zusS4kuHWPWoUnLlICw
         530ZZKzg8uIUuMeRfJqC8qTR2lh0xypaN+K1PsS9QhIRuvXqt71aZtxqFIimlFgtB4Wv
         Ew53SCJ+uS1cDoNSDZL0l3N0NRWAmD/Emggot0l8dR9WvJTfyStfLCwUesCbQ6lMOvd9
         y5+Qz0cFewBhCkriYa+kHjQv9973iw64xVUWqUJqrMiWkkoK2voI/PPAqDb8EOupC7tz
         aJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840348; x=1754445148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcBRucushUU6rMWx+KeKiW2WO5qBqS7bIQG8Zk8QoQw=;
        b=rC7wIYTRP5zQFFCQOqVEw5qBiBR3Un3WIwAyuoTVYtf4y3uTX4bB+rNcOZ7+fQuAXN
         yK0yQYIT9C79dxZfNCgkkz25aMYMjiASd/PCUqXN2J678tdndZQCoaI+J4nael39mn7+
         iv/jdj/4+8pMTo5S3bqBa3E1mPkZoIwgdq3XrpLAptjMMCe/HBjstNca3iac0qZVrAlR
         TPHsu2o+XYOuzX0JehEqvFEagrEnZswirL0CcTPEjmWGd3t5Oz2mSoF6zhEHPVVVxZvz
         Ywp8+TnyVRzvFRLcICMW+cMv/JTYej246gZtVjt6u5bYPx7EENt7pbB3uaVqYRf15bWi
         x0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4cOwJBdiAk9XAFNbXoxuKqr1GvkBsT9GYUN11GaXtvNM7TPzUr7r8Wy+04gz7nsxeSTD5rX9ajrh0E6MUlaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUk9l2kQyuxSIG4PIpaahxMuqT/weZ55gfe3bTMX9cvPkIsAvX
	bkV4eenPgKwPzE7EX7sE8CFxcZn0A3zO8EPTLvkEGFk/SkJJw+Q5OVU1VyT0w3R9Ay9zyISyJ9x
	QF7jcIv+BmoibNpczr+0z6JDEUewn/ueDLolmIQ==
X-Google-Smtp-Source: AGHT+IE23LD9yVsS+V/PgdTqtW8WBwiQ9hdiSM6bhPMm6ER5hSMvzDyXariShK+dE3ICIYS0XsOyr4cw3Hi4E8K+1123kg==
X-Received: from pjg11.prod.google.com ([2002:a17:90b:3f4b:b0:31e:a30b:c50c])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2882:b0:313:23ed:6ff with SMTP id 98e67ed59e1d1-31f5de1eb23mr1873302a91.1.1753840348105;
 Tue, 29 Jul 2025 18:52:28 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:51:48 -0700
In-Reply-To: <20250730015152.29758-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015152.29758-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015152.29758-5-isaacmanjarres@google.com>
Subject: [PATCH 6.6.y 4/4] selftests/memfd: add test for mapping write-sealed
 memfd read-only
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Shuah Khan <shuah@kernel.org>
Cc: aliceryhl@google.com, surenb@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Jann Horn <jannh@google.com>, Julian Orth <ju.orth@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit ea0916e01d0b0f2cce1369ac1494239a79827270 ]

Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
assert that we are able to do this in a test to ensure that we do not
regress this again.

Link: https://lkml.kernel.org/r/a6377ec470b14c0539b4600cf8fa24bf2e4858ae.1732804776.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: Julian Orth <ju.orth@gmail.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index e92b60eecb7d..9c9c82fd18a7 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -285,6 +285,24 @@ static void *mfd_assert_mmap_shared(int fd)
 	return p;
 }
 
+static void *mfd_assert_mmap_read_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	return p;
+}
+
 static void *mfd_assert_mmap_private(int fd)
 {
 	void *p;
@@ -986,6 +1004,30 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+static void test_seal_write_map_read_shared(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-WRITE-MAP-READ\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_write_map_read",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_add_seals(fd, F_SEAL_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_WRITE);
+
+	p = mfd_assert_mmap_read_shared(fd);
+
+	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -1603,6 +1645,7 @@ int main(int argc, char **argv)
 
 	test_seal_write();
 	test_seal_future_write();
+	test_seal_write_map_read_shared();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.50.1.552.g942d659e1b-goog


