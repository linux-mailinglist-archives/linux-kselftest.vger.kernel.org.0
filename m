Return-Path: <linux-kselftest+bounces-46576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF39C8C4F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D56AF350359
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E231B10E;
	Wed, 26 Nov 2025 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcwit3Vd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577D308F1A
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199066; cv=none; b=MFFV4mFhBXDZQAii5RYEG8stk2ZWkQKMT/qF1zUyrhIYB+IM3P2DeyR6xgkVFQ5s7zB4h2b7dl0SvlPaV7e+6U3W5Bb/RNC3SWW9+Tw8tu1yrQ6skw7ZRd3BwqlO3Gz3WWCehMIYkNyAa0934B711RCgpVHQxr29pIpv2Y+tWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199066; c=relaxed/simple;
	bh=syip/vtxgc0scKvCnUJN/SD/jcLGmSspCTDS/9yj+FU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rnJhYwt2x+DjXdYQS4tsHVvHh6gx4HJyo/1Yiuq/2apbwj8gGX5PgAUHS1SL9I07KP1ynPOBcKDo0n3/XECIBTO2iQjgMTWqKmDUfLZToZi76ui8+G4tF947Iu41/mp0g/NuLjQ8hI0PtuQ61lUkKikWZv/PrEXqk/S4LNFN6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xcwit3Vd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297df52c960so4836745ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199064; x=1764803864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7657QzqYC5tw1S9kkHW7dfOPGuJbn/ahSFH3Z3YWAgY=;
        b=xcwit3VdnRnzCsxBGwOarx6fKCa75dUTzjuAs8tuatDMd73PW0rlr3GDGChX/CaLn7
         YCqZP9GqCla5CyirXwR/ICBN8ZKFf20sPXjvUAYUmyEjywmfy9MgdEFNLWgqkA1N1ymQ
         oh2akUXrt73j7dpJDZdQ7T1O4qPzFlw7ucSQ0pjJ5YBg2jAhmCTOQvb7MEwFwX+9IJgy
         jgIPAv5Ovuw+viR0gZ9SPB250t7xLUnjNvmMhh7o61+dW6Mp7udd0bz0Ydb+txyJew5m
         ICkV1PqxQJ4NcnrDvgR5wZtIj6ZN9nIKpdCpDc9KLitGkDHP0xa4dy/4s6/z4mGIQulW
         T6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199064; x=1764803864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7657QzqYC5tw1S9kkHW7dfOPGuJbn/ahSFH3Z3YWAgY=;
        b=oDl75UUM7nxVULZ08XSYAWzc8wETDJ5G9j3KTL208/BMBMrPpkLPA6WPwltex86t8k
         Ye9OAbAy5ZDym0Kc/q6djD3TtH2EM69i+PtF8f1UdBGtqaM6tjiV6uXgYCrMKNJLR+Hy
         K6z/y21rJ8nNNQJnD83xwu+sR0GKXWzCzfAhMf2bx2W1KSlazwrpnPKSzRWU3G+ax2ZS
         5uRKD6o+Z/7tpm43dS6pdaZGVn6UmyRhxcbdQhB4dmxBJUgfwefqo898j1CB9h7gvrms
         LoAA/0l6/mxUmOrn0FhSYNxFWOx6mjLTEgqjiCWKeTKRhykW49wTM8IyOXhbZaEBUW6K
         LimQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQiGCHAvM/OVtliwg/dUMJeD6oW8wKlc+UFFJnsk0IHgx2gYzSoNVdva02WQmdCkr9oeovbUgMb2wG5sLAiL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfXTAakhC9GUrz+lOrw59Ul1Lr11WLSAYNamY2CdoOuwcu/c9
	d9Ick7gjW6e3AebvwdmpPZlMyAEL3kunvLLEkQwJPwpojhe0PtSAWem7JspuezAKukpabRBthuv
	pxcSKMx1k8XrjSg==
X-Google-Smtp-Source: AGHT+IFrqvW2CE4KsCsRkyATGhzcCKUihm9f3LYFtC7yBj8cCKiJpFrrrqtrKxxf/wwvyfsKZ1awzoJWJb7HZg==
X-Received: from plda10.prod.google.com ([2002:a17:902:ee8a:b0:298:38d:87a6])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b84:b0:290:cd9c:1229 with SMTP id d9443c01a7336-29b6bec4961mr206414255ad.19.1764199063649;
 Wed, 26 Nov 2025 15:17:43 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:16 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-2-dmatlack@google.com>
Subject: [PATCH v4 01/18] vfio: selftests: Move run.sh into scripts directory
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move run.sh in a new sub-directory scripts/. This directory will be used
to house various helper scripts to be used by humans and automation for
running VFIO selftests.

Opportunistically also switch run.sh from TEST_PROGS_EXTENDED to
TEST_FILES. The former is for actual test executables that are just not
run by default. TEST_FILES is a better fit for helper scripts.

No functional change intended.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile             | 4 +++-
 tools/testing/selftests/vfio/{ => scripts}/run.sh | 0
 2 files changed, 3 insertions(+), 1 deletion(-)
 rename tools/testing/selftests/vfio/{ => scripts}/run.sh (100%)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 324ba0175a33..ad7fa4071c20 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -3,7 +3,9 @@ TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_driver_test
-TEST_PROGS_EXTENDED := run.sh
+
+TEST_FILES += scripts/run.sh
+
 include ../lib.mk
 include lib/libvfio.mk
 
diff --git a/tools/testing/selftests/vfio/run.sh b/tools/testing/selftests/vfio/scripts/run.sh
similarity index 100%
rename from tools/testing/selftests/vfio/run.sh
rename to tools/testing/selftests/vfio/scripts/run.sh
-- 
2.52.0.487.g5c8c507ade-goog


