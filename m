Return-Path: <linux-kselftest+bounces-45444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9292AC5421C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C733AF31A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66034DCF9;
	Wed, 12 Nov 2025 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VeyG9xKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED7335091
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975370; cv=none; b=XvBsPI+pulxDiYByAPg9U6t65veh0dvBmhumGrepwpPfYgn8cvR4hf/bljAKSGzpSEYdCDDMhKKJDAeHO9FU22JOJw2srZFkvfRy/OGfRCo9GgS/7Q6fXo1nyQAGcGIJKj8S0fqo8fSd+P4BmNkL2+HTzIt7xDnDojzVW4t3200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975370; c=relaxed/simple;
	bh=wV0O/8HRi1COZ2mw6Z5bUrb4p7E7HqI9x5yrKJy0SY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0ZkiW11tkc/hrZ+TU1yC+Mbq7lcpFHP/f++HtLQfnsze2mcAPfhT8kPeEnFBZ2Drx6JPnYQ+zn0SEXx3K1/I3epUMtYID7b7TXTsEQny6wDfEvl0D3jnh5bq3Z16uHC4YlRLcRk2NtDCVW71VDIfTHb3CyulJDDyC6CLsYHsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VeyG9xKO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a440d38452so1920526b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975368; x=1763580168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DC4r0ZRTeYB3Y3PVNQCtQJXZ8DKyZ4imVC1cZHVKSpE=;
        b=VeyG9xKOJ/7ESObNlsQd65RS5Ldzij3yWb30jBJ0g5AghZ6o7rOpTS3BgLwAS/KOo0
         ui0NFTpqeh8nyzZTpiRzY8gkCVzACgehanvm4KSDhe8jSNisqOgg9NXcn2z3srZNPOql
         ZA2XoqH9G+Ys979ZyHgp4LdMAf03880Hs6LpExopg7KpPMm5+yp8ldjlm4Zjqs+n3oAO
         eACN0vUu5sVOeUOqcBSHkiqEn6p6InGGT8/JahwkdMJtcyYN6zyh+41pCcxVrjTeI5lj
         kdXKNvC6NpD4Fv29bAtClDwy+KgwQdThBRywMX0/wHyRpkpHeBbhF8/8gSoOWYB8ygGW
         gGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975368; x=1763580168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC4r0ZRTeYB3Y3PVNQCtQJXZ8DKyZ4imVC1cZHVKSpE=;
        b=Jnl5JQf6mOGCNGC3fDiXtX+/euAnfYVJev1UM+a9skRwx32oNKRzqON5gOwh8FwYeb
         ArayTSXIHXA0b2YBJFfVjYCYlp5tZNKouVRASE1yOtLt2NBwY+QjNF29c5SBwoJT4zfR
         xtAjkI8Kj3xwAwzfKo6JAMpBMfx+mJCNeQACOvkzFiNykxIqpIVZYkgCTIjOgtTH2lpE
         +qN2WpB/IUBLIQtRCj+akLpXZOjEiFQ2PXemWd/1HnG+irGFBGZ1p/HViEf7sayL920A
         y4vERdzG3FpZyD82+Tj93Abg2choA7QlOTJzD6dTilVxc9hAK7S5+axODv7ak/vKCaRZ
         pXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt/yZI7KLL5XNH5F/CDpscnTe6P4k+PhFKmY0pA77kVjfkN2UO97Y/GY4e6A7AZRh9OG/uUOqYsnIO27SKu+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMOsvHXgSs6R1MkI6MMVjW9UwRBkoL/GFlFLopK6RxsSZx7Hg
	fajyeJyL2ohMBmgiZnDnUaXcwItdfLNkVPilRX2CziZTYWV0SRFfE/TmnQf+5x0mNVaUyPsOAcR
	cHTMLMBW9mZtKtA==
X-Google-Smtp-Source: AGHT+IEi9Ao+07tIZnXl/ITEY6uR3zgoc99jgN6A24D4IjGR3/HEnyP417iqyrKKSiDM+CBTKzZd9afl0c1FAw==
X-Received: from pfbbk25.prod.google.com ([2002:aa7:8319:0:b0:7b2:242c:6852])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e081:b0:350:1a0e:7fc5 with SMTP id adf61e73a8af0-3590c224b71mr5330399637.60.1762975368540;
 Wed, 12 Nov 2025 11:22:48 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:17 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-4-dmatlack@google.com>
Subject: [PATCH v2 03/18] vfio: selftests: Allow passing multiple BDFs on the
 command line
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for passing multiple device BDFs to a test via the command
line. This is a prerequisite for multi-device tests.

Single-device tests can continue using vfio_selftests_get_bdf(), which
will continue to return argv[argc - 1] (if it is a BDF string), or the
environment variable $VFIO_SELFTESTS_BDF otherwise.

For multi-device tests, a new helper called vfio_selftests_get_bdfs() is
introduced which will return an array of all BDFs found at the end of
argv[], as well as the number of BDFs found (passed back to the caller
via argument). The array of BDFs returned does not need to be freed by
the caller.

The environment variable VFIO_SELFTESTS_BDF continues to support only a
single BDF for the time being.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  2 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 57 +++++++++++++++----
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 69ec0c856481..0b9a5628d23e 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -208,6 +208,8 @@ struct iova_allocator {
  * If BDF cannot be determined then the test will exit with KSFT_SKIP.
  */
 const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
+char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
+
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
 extern const char *default_iommu_mode;
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index b479a359da12..eda8f14de797 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -868,29 +868,64 @@ static bool is_bdf(const char *str)
 	return count == 4 && length == strlen(str);
 }
 
-const char *vfio_selftests_get_bdf(int *argc, char *argv[])
+static char **get_bdfs_cmdline(int *argc, char *argv[], int *nr_bdfs)
 {
-	char *bdf;
+	int i;
 
-	if (*argc > 1 && is_bdf(argv[*argc - 1]))
-		return argv[--(*argc)];
+	for (i = *argc - 1; i > 0 && is_bdf(argv[i]); i--)
+		continue;
+
+	i++;
+	*nr_bdfs = *argc - i;
+	*argc -= *nr_bdfs;
+
+	return *nr_bdfs ? &argv[i] : NULL;
+}
+
+static char *get_bdf_env(void)
+{
+	char *bdf;
 
 	bdf = getenv("VFIO_SELFTESTS_BDF");
-	if (bdf) {
-		VFIO_ASSERT_TRUE(is_bdf(bdf), "Invalid BDF: %s\n", bdf);
-		return bdf;
+	if (!bdf)
+		return NULL;
+
+	VFIO_ASSERT_TRUE(is_bdf(bdf), "Invalid BDF: %s\n", bdf);
+	return bdf;
+}
+
+char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs)
+{
+	static char *env_bdf;
+	char **bdfs;
+
+	bdfs = get_bdfs_cmdline(argc, argv, nr_bdfs);
+	if (bdfs)
+		return bdfs;
+
+	env_bdf = get_bdf_env();
+	if (env_bdf) {
+		*nr_bdfs = 1;
+		return &env_bdf;
 	}
 
-	fprintf(stderr, "Unable to determine which device to use, skipping test.\n");
+	fprintf(stderr, "Unable to determine which device(s) to use, skipping test.\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "To pass the device address via environment variable:\n");
 	fprintf(stderr, "\n");
-	fprintf(stderr, "    export VFIO_SELFTESTS_BDF=segment:bus:device.function\n");
+	fprintf(stderr, "    export VFIO_SELFTESTS_BDF=\"segment:bus:device.function\"\n");
 	fprintf(stderr, "    %s [options]\n", argv[0]);
 	fprintf(stderr, "\n");
-	fprintf(stderr, "To pass the device address via argv:\n");
+	fprintf(stderr, "To pass the device address(es) via argv:\n");
 	fprintf(stderr, "\n");
-	fprintf(stderr, "    %s [options] segment:bus:device.function\n", argv[0]);
+	fprintf(stderr, "    %s [options] segment:bus:device.function ...\n", argv[0]);
 	fprintf(stderr, "\n");
 	exit(KSFT_SKIP);
 }
+
+const char *vfio_selftests_get_bdf(int *argc, char *argv[])
+{
+	int nr_bdfs;
+
+	return vfio_selftests_get_bdfs(argc, argv, &nr_bdfs)[0];
+}
-- 
2.52.0.rc1.455.g30608eb744-goog


