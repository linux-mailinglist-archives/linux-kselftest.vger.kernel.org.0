Return-Path: <linux-kselftest+bounces-46579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023A4C8C508
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0D73B63D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E9342523;
	Wed, 26 Nov 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLcrkCNb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042331CA6A
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199068; cv=none; b=OsRRBLHdKhKwiMpYW2VK53sKPeEYBnVLRXjT5dbc2XwY6YfWgHd6CnHM2rFRN+ayZmHWOzpZ2kXldjOPF9c0A9MwRqDObYGs8DWhoStu3VejZFUxX/ff0H++nijxAPHDNDdZCol3EXY4H48iBOfkxZb2WJSBvZM0x1j/1KRq3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199068; c=relaxed/simple;
	bh=AvSFNKiKL+c7A+jWVKE0Bg18iz3X2ZUYRCg6aF1PgR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MgD143UtoZSKfSQnf/NLfc43PzuOMZRGKZUV/n1QCGvH+swW/rHth1TMUO8rMLj/XkS17oalqCny1cwd40/DXWf4jvsEC8jDOOeikayDEe7EPbOxfMGtNVU4M59f4Y9sGPlhQe8gShMBaZ/chTNQfEv0vwG74ErbI5wWmwa5m0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLcrkCNb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b80de683efso353742b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199067; x=1764803867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NmqlILt/SIZo48TbaGQlmIwJAUYztjRVDmwIOHsj6Y=;
        b=rLcrkCNb0Qi94JuYAhH244e6Kr3e44p9lGcPro1K2c8iiX0iL88o6qtJqIFYFm1wDh
         s0C8h8TJHWYh+W5UPgVSkYasPPrPBVSv7yobkQwhE6oN+thUELA8URoZ0Qq1UjL9zyNC
         uEZ9mrI0TEXEAZ7Zxtl9zemUkdw2RFRt4NkxHLA7OrJhqb+GXbTbCxvHyiFeOTnZ967p
         GC6N/lTtKx6nEdvC2NVtzoyD2sJKvrwA9KYl4SzfUENpYNf0egcoBWGon5GqsjaEzxgJ
         P/PgQegCfv31AYb4rx2r4NjLq6nYoY/pU2L5+I+E7vWtRJzM6kd4jFHRiEjj6wExMRjI
         F0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199067; x=1764803867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NmqlILt/SIZo48TbaGQlmIwJAUYztjRVDmwIOHsj6Y=;
        b=NWULAvC6OPe/FZit4bzY3At8TypHMS79URpNVPqgFdmid2QIa1rtn7wiAH04bbeuO2
         34amsrgydlv5edToBZR9MgXUeqCN2293XtdFFEavyQkO7Csn1WN8UdFiMh/46XIXURm4
         8qf4+pV71pZ3o5t7YCHAqmQ8rTn3eRcM5Mg3qyNPMkJbsQJNdE0AKDvfJXyMC/1ygfJF
         uYtyV9teuPQmYHreYt+dtLjcUOUFnxwaa8iiBmCfVLmMrwUptsbhB41BQNSfVm4G4WFn
         M4qqLR+m1lwr48sPskg6RfQGsi8sfQzdSm9E2tHUr4lAIrNAUDAJfNpLQHiVct0zD1a6
         TldA==
X-Forwarded-Encrypted: i=1; AJvYcCVOoq5OHIMM/EgmxmSkfTeeTAU779ecLE4cmDoNfggVtyhUqRQJtOl4IfoqektYnE07RGibVRB7ONZBxzvdVhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/DsKXTEuGVZfT6ut1nFUl1Mk3GvN92lK8zyZNA22J3e9xnmIl
	AJuqapSj0p9Ti1GbBlrQQvZP1XxYdnYWWJEZbP2c6ARY4ioHUqLzV1Jkb79CMdUUIxzTIVEPMnx
	rRI4R53DWHWKE8A==
X-Google-Smtp-Source: AGHT+IFe/Mo3B5TgFhtPN43rvpR/V3Sb3frYIJR1W12Kqz3wnQ9iJPaORUJ41nbeEG+8jvATbp+GIwQQjnw/uw==
X-Received: from pfbhj14.prod.google.com ([2002:a05:6a00:870e:b0:77d:4a42:1179])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:390d:b0:7aa:9e4d:b693 with SMTP id d2e1a72fcca58-7c58e113a8amr24159761b3a.17.1764199066615;
 Wed, 26 Nov 2025 15:17:46 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:18 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-4-dmatlack@google.com>
Subject: [PATCH v4 03/18] vfio: selftests: Allow passing multiple BDFs on the
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
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
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
2.52.0.487.g5c8c507ade-goog


