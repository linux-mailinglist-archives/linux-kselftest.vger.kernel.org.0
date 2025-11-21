Return-Path: <linux-kselftest+bounces-46266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E98C7B436
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00A01357998
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C557351FC8;
	Fri, 21 Nov 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYnDilA6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832334D388
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748886; cv=none; b=I0V9mVYxYhcJRc2+CHjgQgVE/o8y35OEcsir6/6YvH47OvDWCC7D+e+U71681JEux3Efx7GUijLFCudIMPGqJf9XpQKKvBmQVH5aEUkc9U3Ulj+000qjthShgMhWYSNCy1aaXUQ9x3/m6TeNrEcCuRVHb3PpmB1HKDiGqlTMRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748886; c=relaxed/simple;
	bh=Wjo5S3jm4rIHHKDO95Npld0R/MM3G2rBK7det+W9InI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j71MxF+BKaXHJpPnAkBtAq15VTUKYNQG5hMZn/fB23arBiL5qSxj1YjH7UQ0rJOOf8Ua2fJ6oYbFiDJRCyduKHedPWTGUuiDVm1MvYH3Rjycnvmop4mwmIA8pXwN+vYCM4nUtpvEEoOIjEUV6wqC1BZZc7rjdokoc8JuHE9Q2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYnDilA6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ba9c366057so7068026b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748883; x=1764353683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g124QBzcdvPEK+J/83+56gYFpABGkICYbD/An5ySYhE=;
        b=eYnDilA6k6/ZEs5TTKKO4ywrCh60P18AKcvg/PZUOHaSsJANIExPmtpcu/NBoabIAO
         AqJXa6VWjYZznz3oZRUVNBfXByzEcjgVSQM7pBKcOw0cph+BVtt3/JOzOtgB8rKh0Kab
         msvYoeqlO2u0ICxBY5N7FusUGs9bMkijbz/qjkzy0V7dJ3PNrcbzg2UKJ3zP78dv7aEZ
         3QLQJzkiBMqglThs4J/MAq2OdS6b5h7X6ndoSHTRaAB1fVZtToJKqCQHhZ8rIZPkxnrh
         WDAEt7tEpanqgnuYXOnoZKOoADQBiHVLBCZ0Bl/utpLGbdoyOW5/zNBT5+ay5gJajjD7
         UECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748883; x=1764353683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g124QBzcdvPEK+J/83+56gYFpABGkICYbD/An5ySYhE=;
        b=SaJV/jG8SAMqqABuZnrgacZ3fLcFYlnSMcsZFoVsMup1UNOVG+1NXVGy0LH0tH27o2
         MudIzh+gjSDSj6KJTdiT8LlTPmEASXhEkTyrWZkCgZsB0ICHvPmCXS1yB+pBTyh41Lrj
         FV7HCj8lr/bvDQp3XYdHk6ROAmNgn0S7h0jiNEMTwagiO1QgIU+4/hTy7nRnPMsYALiG
         PNSU3ikb3LwUn5r6vphhoqrJDRFTs8L/NdfIbQB2Jx+u6mNXVJIkKgAor09BoetfmXSI
         U2u0xGGDCKTuZdCtwg0LheT3aShBQYwwnYmINgTVd7xrmzIkw2fSKKIjZAfJu6MNWP8a
         auuA==
X-Forwarded-Encrypted: i=1; AJvYcCUvL55fXa/hihOG0EKWVjNdnjgOrrMmCfMLrXoabwoRrFVgo8E0gdU4YdcUy0+SUYJGlA5Y56RSgafHiayCp2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFzj5APObPprLg5d4uNeWxZSYJXbCD2mNOu8pmzY7+qnYlMDj
	0MfXUlAIRVLDOKYwiwXosEKtfF/9yugXTrB9BUsy0ydW/5NhSurI7TdbSND5lSKnHzMK1ePmFPw
	RrWWR0yahjHjUsA==
X-Google-Smtp-Source: AGHT+IE6bTYkPneatI//ZdOy1x5PgnIneKQ606XIGGaa0iqn+syJEbxJdH/cKE3PeHga9Qitv+c9GDWTPxOr8g==
X-Received: from pfjt15.prod.google.com ([2002:a05:6a00:21cf:b0:7c2:a212:2b32])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:22cb:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7c58e601920mr4056673b3a.24.1763748883301;
 Fri, 21 Nov 2025 10:14:43 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:14 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-4-dmatlack@google.com>
Subject: [PATCH v3 03/18] vfio: selftests: Allow passing multiple BDFs on the
 command line
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
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

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
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
2.52.0.rc2.455.g230fcf2819-goog


