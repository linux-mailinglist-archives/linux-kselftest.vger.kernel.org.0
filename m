Return-Path: <linux-kselftest+bounces-38074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B49B15738
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 03:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EE31880351
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 01:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDAF1E835B;
	Wed, 30 Jul 2025 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGnvmT4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE41E520A
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Jul 2025 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840387; cv=none; b=DNDQSacPRZZTwD+mjZlD6Q0+Pvp59tynVOlljmkjm9V7MJBsB7XlblIAdVBCCwNxRMWd/RtIHKMup+PYRnLuP04OWO7uLgCvLJUHmVQuA4etzJf6KyQ+EWiZJOdPWpp5A+rfbfXTVpMc1Yxd4rgi3sJVEAet33RUUhfI1lXSwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840387; c=relaxed/simple;
	bh=9mfsWfmUsxiv7jb5H3bplGyE+CRlpRWvLjb17tNh4ZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PI4K/PGOlQOZ4RraobCqR+7msSThgKGH2AIt9DPh1ZZXHP58RpsXxH7ES8wtfufKOzAqJ7UJonEyqwS1+82Xh4I+ilvJh7nGpzHA1bRBL2FsojT1J5AVkeZY/j4Pqj0M04oFH53HNShxCIqHiEaygTColfRnhSGP5+xrmOSQD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGnvmT4F; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71a38ae2cedso22068627b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840385; x=1754445185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=XGnvmT4FZkWNJnA+CoRcSrPJbdTvpsu7qIg5P/cXi3Gc436+eTrcGlIUo2Y2CxFFPk
         HKT2CPdPqJjvUKFLwznA+WB6Eigr/u4OQ2udiDYqnjrhybLT5fOdDrF8GOYU2FcT5sD9
         +9Y5Hssp+EDog0kHCNJQW/leQOGjcadjZGj+kWKX0k12z2+pQ/jnPtlcOi4BZOCKAais
         85LXpj40z55LhReBZkaBMoIEGzGpUI6s5lCXHJMXdjxHYPaONR5IEYBe/V4IiAvlrqUx
         YyXeN+SUFD77aRxQym9zgNLUG92UkSxC9eSLnGJw3Qs05qovF45RUNnWIlchTkz9oLI7
         Mmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840385; x=1754445185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=JJJ4tf4Kqk7L/AOhLhvLL4jOovDRALy98r60Z0JUentO088uURAvWFzZZLNfCK9/Fm
         +aggLyWDAdQucMyXifzXgF9YsJmC+GKgNzmZ0YczxmDzfTqo4VgHzcoAgocxrTYuz9LM
         rhY2m5qToUir0k63pVr8E7bHxfPuE2HzKjSGr7Had0qcqOUQwzndjuCgZ4iru4Xe73Gw
         sDybjLViNHUDoY4PKmw0tz5G4/c5FI6s4ejDwIIpA1RoLoDjGUAJZgx9BICwt8okIQVD
         6yQFiDAvScgpr6mmch5fGB/XToU/UqkEze3MsEn6TLdHalxCTZo07e/Kb6NooJ14YHcz
         TzMA==
X-Forwarded-Encrypted: i=1; AJvYcCXGq4oJksayR/lfchllYqhER/qBgQtFzq7TjjV8yvkjQqJoHGk1+lf7hSNqS9Co7zIyyoqqLrptGFRA/ZoO3uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYSxdZphserbBBEsCNoTVPnRsR4Rp68av+38P+C+znUr5bnnw
	9QhIZdAubYTUuJF6cAQC1/Z/H/18m/woyEp6zx5JSgeEfcVuK0csrCAo7OCwiwiF5GPoSVum4Z1
	gLfQ8mJGImxDicqmh1b3G6vv5cwV4JOEihpG5KQ==
X-Google-Smtp-Source: AGHT+IFMN87Pheb34MK37buANyT4ygN7EuRFMXC1Jr/7dhlCcyElEAYQTT7X5PQ8XI+jtHMXndENYbmFMJ7WOBut09j/6Q==
X-Received: from ybbgf9.prod.google.com ([2002:a05:6902:6009:b0:e8e:19a8:976a])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1604:b0:e8e:219f:a662 with SMTP id 3f1490d57ef6-e8e315b5213mr2128772276.26.1753840384801;
 Tue, 29 Jul 2025 18:53:04 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:52:43 -0700
In-Reply-To: <20250730015247.30827-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015247.30827-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015247.30827-5-isaacmanjarres@google.com>
Subject: [PATCH 6.1.y 4/4] selftests/memfd: add test for mapping write-sealed
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
index 94df2692e6e4..15a90db80836 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -186,6 +186,24 @@ static void *mfd_assert_mmap_shared(int fd)
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
@@ -802,6 +820,30 @@ static void test_seal_future_write(void)
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
@@ -1056,6 +1098,7 @@ int main(int argc, char **argv)
 
 	test_seal_write();
 	test_seal_future_write();
+	test_seal_write_map_read_shared();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.50.1.552.g942d659e1b-goog


