Return-Path: <linux-kselftest+bounces-46556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D828C8BA55
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C79E84EF6EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2C34A799;
	Wed, 26 Nov 2025 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waKmfsHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E1340277
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185795; cv=none; b=OkdySbSBiYu1xSBKzPBTxhBcMpiMvfxiHMgi0uzH6LP9ktxyV5ul5cTRvVXQOtE1eROOr1d8sDQKBveg2IRaVwIUoEhjhXaa3/YD+BXNOcTWJfQvWsCt9uQcHCKClC0dtqHz/W6dlmB5ZDbC7CAfBcl/ne8utAIPgFVKdpn6Gb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185795; c=relaxed/simple;
	bh=LFB03j9PyPhBeg5BZcBtpcmf2J/k1pT0XFgVYS2afs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKEWMCryppph9/tp0ntuBqOxJ+zwZ4iEdhwCAPr35DmLbXw0oI2j+Kv8mwcO8H6grzre76f/LN2egUaL/TcVpbZH/mqD/xaVRXIPqKlUFwXJIsKCxizU4wB5mTuk3IABssdP8SSB6gIWbg8ErLj3uNvH/tNP8GaUwkf0QQtuyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waKmfsHn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343daf0f488so69229a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185793; x=1764790593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=//f12vbddhO9W/g+moaY6VE/bxAGwxrPiDFdKTDdMcM=;
        b=waKmfsHnHN8Qp4RhFB59K/gDbuRnMgiIYepTlz7bbV0o4GkBzC3d7zIYCJyZg59L7P
         k/gixU//jivw4qIRUD4wrQ5XfjZd89bPqTIa52V/bHqXt0peGTzcI63o+vP8ycv7d69f
         XNqkmRN3mfJlQG1SOyWVJTWmJ3FoyuQbcnbO7eTT9tdsCn+lRwRVs5UgFXusMTHO7U6u
         1GbugwU+TdP5cmCpI6+GfmlSK+vaKuYitP9vHFgHfP/T6+lAa5P0k40NwuJFbA5KPFT9
         0BS+5tXeLYhMVCNrGy+LVLgTy0CgzAq2PQkSaYlaB+D+0ZcJd33kA3crdW20RXust5og
         /P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185793; x=1764790593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//f12vbddhO9W/g+moaY6VE/bxAGwxrPiDFdKTDdMcM=;
        b=LntDeqlizKC2K0wdI9ZcnIDOVIntpxANvrAEgT2HmIkDbxTtJUQm3MTaFVvuP2qFUO
         GtWYVzMqJRKE+1MDm+4SL+I0NnUz3mOFWXsS7AuP46zZU8vwG7QcIsuQgwRKeslPnEQT
         G5EwBPfe4mghWDPuIsmpYEvA+lCWWkYkXC0ul14xNXo1+3f56Qg+2gRAh7bMySvg6f0q
         WprXLT7pnxJIgW5LHnT4d1UWvKtdsnY2fkZ8BO4s0rcw0SYwfVaSqxjWnK6RWR5kI63L
         BrMphKl3wi1CAw5wjdvC7ISCh2dyUQhZiFxaDgEJmED2ithDSJ39/ayXc3ivojhX2vyN
         0+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWdEf9mOIM7FWW84yGJzDmmjCzf8gjcX8RxNybn69DXW3JkAiSyEtEVNV1bWFTb8/CoiSUbBNsyVNMLJLjEEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7ULw9RWUZdOcFndbKKBH99L0OMQwHRHQmHQ9d9Z+i2WvQb5g
	9ArpxWIsoJr/4I+Tg/gtIYLsWDhpjxymCoc4DgI58wMkKojn4zqvXMdLeej8UHI897dWEjPgayN
	ZajY0+jvVVdWZSg==
X-Google-Smtp-Source: AGHT+IHkKNcU5wbIyBeDLHpLT8jvQv8C3h64QCysVij0yc88H1dhFuteaCqt+2xeK1d/SIGvHBUqJRnU1SfUBQ==
X-Received: from pfbly20.prod.google.com ([2002:a05:6a00:7594:b0:7b9:55bc:4970])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:329b:b0:35d:d477:a7e0 with SMTP id adf61e73a8af0-3637dafc474mr9254985637.15.1764185792706;
 Wed, 26 Nov 2025 11:36:32 -0800 (PST)
Date: Wed, 26 Nov 2025 19:36:01 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-15-dmatlack@google.com>
Subject: [PATCH 14/21] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Add Makefile support for TEST_GEN_PROGS_EXTENDED targets. These tests
are not run by default.

TEST_GEN_PROGS_EXTENDED will be used for Live Update selftests in
subsequent commits. These selftests must be run manually because they
require the user/runner to perform additional actions, such as kexec,
during the test.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 8e6e2cc2d8fd..424649049d94 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -22,12 +22,15 @@ LDFLAGS += -pthread
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): %: %.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES := $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O))
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(TESTS_O))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O)
+EXTRA_CLEAN += $(TEST_DEP_FILES)
-- 
2.52.0.487.g5c8c507ade-goog


