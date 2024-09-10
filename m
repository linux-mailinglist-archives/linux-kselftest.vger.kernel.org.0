Return-Path: <linux-kselftest+bounces-17683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13B9746C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BACD1C20BA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B401AC881;
	Tue, 10 Sep 2024 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPrF7ut9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EE1BDAB5
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011908; cv=none; b=HrAIHr9huLqdaZ2lOWXYyy6uCa2+zQa2PPv4Z1kzh/40D+ZoyAcBXL9RKWxMhpGtsULFfw6PZ69Ccx6KlJV+utUTvgRf4qKRB379XJsuxakgq7+ajALDGjMXnWiIQvrhRsDmQdF4Ps5kfKzd5d42VC/Zt9fvzSqbpLsHZEaIeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011908; c=relaxed/simple;
	bh=XiY3BKQF2LguGns0tGK1hRv3k4qaW06a47f+QLg/xl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XwUm2gPWF8QHWWoovnKBNzBtxVbVN74jYoBmy9gOpCfhlQUK7X57Ma7siwmsMCzv//IESt+4WfNkfo7OidMwZ/4Do2zpC2tVlYer/N54qGEzyb7QdRgzsATFWcX3p7hxcSf3s+dR2w6WnX7z/59SjAo/NQ/P1+NGd1ufCIFoiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPrF7ut9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-719064437cdso2348267b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011906; x=1726616706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNwyUtrg2ydCG7OEuuYFt3GviKLhR33B3wmqNjEPlY0=;
        b=GPrF7ut9yZpPR4ISa4MMHpXUP/tg2Qk5c2Yp1SvNZW2V0nZ81Ql436VsbZQwMPFvOX
         Edwz51Cgs2fGmaN69ASSuae2/16qtajVpnU1ijwojUmZgPhOsuEXbuD0fi332ITaU57y
         CdctyCvRWHV1KGbpQEwpKt0zC0sABM6eRk9y+YEXcqXMpbHn1VCkjR6mupHbZAY/biCq
         mEWfL404K4u9t9c/aqHbw626QQPdW6LSLhH2Auerl2DnOkcPzyphyhZHF/vxt+h1MqnM
         6ahIf4Vd49oUlt6/Ui2kqHkvztH0wgEigvb/WwPfVm3P5+pcAinKptA/eBx9VpmGIm3n
         hPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011906; x=1726616706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNwyUtrg2ydCG7OEuuYFt3GviKLhR33B3wmqNjEPlY0=;
        b=KNu6HRgn1bHptRpEL2pNuUbKvTijf0T5yVfzNqqM7ZIpxesh6rJye4ldHEdVrTy9df
         IrkFG+W69h57lugSdB9DOxxO71JY9vVgi7a3kxosgh8XZGEVZVufRTUuiadWoRnQWpb/
         NqDxgZ+S+A+SrEsL9lcgrlTRFPDKAlfcaloMxia27kGtTuNC85IQ8eJhFE4we9PM0iKm
         FgV2w7tkasKAAF8+9pgKxOqRcBazCbtTKvejVHhCZz1dO19M+CMsCKH1bcD0xhLEFJX9
         lBw//fyEMEEmSk0INWPttPZpe3mHV7l1Q4KzO+Xvx+F/UywbDJhuEnp52Ht1VQmVt498
         xRgg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3BMSHvYpX/RNnxNsdGOmbYBR7xnJvO1gwEWFWvIXGmh+PVAHaDqg1RMA5VoK0T8cug8Cbn6bHuvLxWZ5X1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYdvA9fIHW/z8qi/d4RXip/xzjjLxZVBwQ/2OqLNXhuVaGoPO
	SO4BTl0tOlWvdGWC4CyNB8tAfOKpvzxOEqdvukF+oahltU4UkBN7qNQhYR6Eljj4ijT7YjAwCrV
	WIap7SHKe9bA1Rp1axbTNWA==
X-Google-Smtp-Source: AGHT+IEcZ/ghxITnGvgKkAKwRaOU4W9SdtHb2nrXhbk+ACBlgEJVwXnXXaBkRqqDbpe8CxVzylPUbg24aRXjUe363A==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:81c6:b0:718:d8af:4551 with
 SMTP id d2e1a72fcca58-718d8af4650mr30583b3a.1.1726011906107; Tue, 10 Sep 2024
 16:45:06 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:51 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <6bfe8c9baabc6ad89ccc2c4481db2b4983cbfd8b.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 20/39] KVM: selftests: Add private_mem_conversions_test.sh
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Add private_mem_conversions_test.sh to automate testing of different
combinations of private_mem_conversions_test.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

---
 .../x86_64/private_mem_conversions_test.sh    | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh

diff --git a/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh
new file mode 100755
index 000000000000..fb6705fef466
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.sh
@@ -0,0 +1,88 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only */
+#
+# Wrapper script which runs different test setups of
+# private_mem_conversions_test.
+#
+# tools/testing/selftests/kvm/private_mem_conversions_test.sh
+# Copyright (C) 2023, Google LLC.
+
+set -e
+
+num_vcpus_to_test=4
+num_memslots_to_test=$num_vcpus_to_test
+
+get_default_hugepage_size_in_kB() {
+  grep "Hugepagesize:" /proc/meminfo | grep -o '[[:digit:]]\+'
+}
+
+# Required pages are based on the test setup (see computation for memfd_size) in
+# test_mem_conversions() in private_mem_migrate_tests.c)
+
+# These static requirements are set to the maximum required for
+# num_vcpus_to_test, over all the hugetlb-related tests
+required_num_2m_hugepages=$(( 1024 * num_vcpus_to_test ))
+required_num_1g_hugepages=$(( 2 * num_vcpus_to_test ))
+
+# The other hugetlb sizes are not supported on x86_64
+[ "$(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 2>/dev/null || echo 0)" -ge "$required_num_2m_hugepages" ] && hugepage_2mb_enabled=1
+[ "$(cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages 2>/dev/null || echo 0)" -ge "$required_num_1g_hugepages" ] && hugepage_1gb_enabled=1
+
+case $(get_default_hugepage_size_in_kB) in
+  2048)
+    hugepage_default_enabled=$hugepage_2mb_enabled
+    ;;
+  1048576)
+    hugepage_default_enabled=$hugepage_1gb_enabled
+    ;;
+  *)
+    hugepage_default_enabled=0
+    ;;
+esac
+
+backing_src_types=( anonymous )
+backing_src_types+=( anonymous_thp )
+[ -n "$hugepage_default_enabled" ] && \
+    backing_src_types+=( anonymous_hugetlb ) || echo "skipping anonymous_hugetlb backing source type"
+[ -n "$hugepage_2mb_enabled" ] && \
+    backing_src_types+=( anonymous_hugetlb_2mb ) || echo "skipping anonymous_hugetlb_2mb backing source type"
+[ -n "$hugepage_1gb_enabled" ] && \
+    backing_src_types+=( anonymous_hugetlb_1gb ) || echo "skipping anonymous_hugetlb_1gb backing source type"
+backing_src_types+=( shmem )
+[ -n "$hugepage_default_enabled" ] && \
+  backing_src_types+=( shared_hugetlb ) || echo "skipping shared_hugetlb backing source type"
+
+private_mem_backing_src_types=( private_mem_guest_mem )
+[ -n "$hugepage_default_enabled" ] && \
+    private_mem_backing_src_types+=( private_mem_hugetlb ) || echo "skipping private_mem_hugetlb backing source type"
+[ -n "$hugepage_2mb_enabled" ] && \
+    private_mem_backing_src_types+=( private_mem_hugetlb_2mb ) || echo "skipping private_mem_hugetlb_2mb backing source type"
+[ -n "$hugepage_1gb_enabled" ] && \
+    private_mem_backing_src_types+=( private_mem_hugetlb_1gb ) || echo "skipping private_mem_hugetlb_1gb backing source type"
+
+set +e
+
+TEST_EXECUTABLE="$(dirname "$0")/private_mem_conversions_test"
+
+(
+	set -e
+
+	for src_type in "${backing_src_types[@]}"; do
+
+		for private_mem_src_type in "${private_mem_backing_src_types[@]}"; do
+			set -x
+
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test
+			$TEST_EXECUTABLE -s "$src_type" -p "$private_mem_src_type" -n $num_vcpus_to_test -m $num_memslots_to_test
+
+			{ set +x; } 2>/dev/null
+
+			echo
+
+		done
+
+	done
+)
+RET=$?
+
+exit $RET
-- 
2.46.0.598.g6f2099f65c-goog


