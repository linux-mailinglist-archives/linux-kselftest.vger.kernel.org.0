Return-Path: <linux-kselftest+bounces-33673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B180CAC29E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53811BC4A9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEF29A33E;
	Fri, 23 May 2025 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUmVSEay"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299AA47F4A;
	Fri, 23 May 2025 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025799; cv=none; b=N2dymyx+Zc5qdhMjQqasmVth9cs0OzzaDSPZsYI2W2teuodwdSvmSXQxN0+GyYvnI2Hy0BJHnRw6j2Py1xeRMwGL7FNv7bS1iSFyANu9seNRxuGImOP4jY94sLASMKuilPrivrnu5PSHW9M6Y0Xtp+QwsuyVWb1ASW6CP5zw+UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025799; c=relaxed/simple;
	bh=gs5K2rq/cBIABkj5iFdt3STh54GNK4JoTpG2QNUrWDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=or19p3k/vuhm+5yhw1jhRiTbVom+ultgjznYTViKCYyC2D1w5Rn6OxjGBGYnGs+qtOn0kWPMkn7zlQTjwg5ZOxGKAqdoXo73HZjSxlnaW7no/8CJuM8IYoAOyDre3JiId91g7oklYQ64S1tU/SSyqGwL0vIbGQ/KLTakNeze19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUmVSEay; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so1537495e9.1;
        Fri, 23 May 2025 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748025796; x=1748630596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btTTfvQ93Rrp+cfCkaZPBbleiZuXCpTdB3DJ5XEH6Kk=;
        b=lUmVSEayn/cYUyPyN2IkHTqlKQmtePCfj0cVAHbMtNnVnlv6V1fDoT5cs1iFrlPcLR
         V5h3tpob3Z2JWCG+cYgx5RieSkaJWV0DbNGjq/WpnaATQRqkkBgKQShBN+hZd0xZCuEw
         GD4ZYzv1sl1Pg+6k8KRSI+fmVEMp/ynn3pRZ8kw8uCexlTb0kVVsLKnN8/rhwiaqOv5p
         Whg65Hc3tmVuv9cZZaTN1p+C26eulZuWYHAjxvQjmkURM+C10UAKQZq9/VK/5CuyCrvn
         yb+0y9Vv468q60AB3I6GUEBOaAanYfBJ7UgxhjfftTWa0DEn4oHUrd1dv9pt1cPiplK1
         1Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025796; x=1748630596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btTTfvQ93Rrp+cfCkaZPBbleiZuXCpTdB3DJ5XEH6Kk=;
        b=E6zTQtflGqXsNC6YlPDRzPytM8cMtwAQhOF82ayFofC7jvIck55AE3WQhujT3wSy14
         N/e3EcyUL9IfeVwwIut8PaPYFQEKiD2J1Y9vzF8for+7cVxe6MGx+Qqti2EeQMzULEJK
         WaTriB/tzJX8KgtKu1cjVj1K/cKj0q+jrbgUR02gwtEyk+9wSit7V0/dHijp1O7+OjpI
         zRPMs3waurb8BiDjozoGVeTi9axOYnU10olRABwiEsLXztZ64g/TrYizFg08myyGRGkG
         BwoTgqWDwK1VvRDEQbEvWVMmt6S2RAGv94Sbj96c7YpZYsO/W8FdB4Mq7YTDzU8G7M9A
         Wrow==
X-Forwarded-Encrypted: i=1; AJvYcCW0tdDbBPqAj96S6mGJAGy87NsNxwSkx/MhRnNe+xyyS286zgvTUmabWlA9gDK6BO6BBFYHQ3TZyFZBqR8=@vger.kernel.org, AJvYcCX2jS3lyt/R3Be5NioH10Ih38iUzytti2yDr3Yz8O1aXfP8bp1vWl/PApSMo1uzrlpf7EeBfj4d5xIE/GWdq1dv@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+vscOsKmvpJrRp556rKAwdkwrzsGF01bABISJyUVltXw6TmJ
	hsljMTNqYK96ZvDXtBVBgg7I02xlZNG+ZH+NbVxGK9e5d+7+hOvKnESn
X-Gm-Gg: ASbGncu86gVHYo7UnwSonupVEPhNVx+/Og0j7k/iBgPmoThoreLBTnSWn5EsttLvEhd
	SaYIqVBJYpepUhasFY6w4W96iGJS0WTKVk457juTMyjO0v3Kr728v19tf91cABclIWLeh0oIddU
	PsEY+Wakg2ng11pRQIHVexF4VGGGZMWCA3/QgaBlylO9PCSRlDr0VxgK/zq6S5i0Dg5cPEEcRbS
	74Z3/BBbKYWqKlZM5HQf6A/+XTeOJB0ENREGGscPQhQWLl6WudUN46x0yNDAGCrLUPIZ6q9jMSb
	SgSdZsurW0lOr/BjFaA68bwVYehBu3us6DIvdarvRRDqY8ngZGHwq7N57jzfa0WtoaRpXhV01ZC
	TzcY6eFJnjbAw
X-Google-Smtp-Source: AGHT+IGbySv0kJkzhoWrw/RDGSmd5NY01lUNmRSyAzY3QDkI4nh5xMLz5f+ebRm9TH2KKXtfV5Tq6A==
X-Received: by 2002:a05:600c:524c:b0:440:69f5:f179 with SMTP id 5b1f17b1804b1-44b51f4c57bmr45533255e9.7.1748025796031;
        Fri, 23 May 2025 11:43:16 -0700 (PDT)
Received: from localhost.localdomain ([154.183.50.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f74cce5bsm145897875e9.24.2025.05.23.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:43:15 -0700 (PDT)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: linux-mm@kvack.org
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel-mentees@lists.linux.dev,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] selftests/mm: Skip tests dependent on a binary not built
Date: Fri, 23 May 2025 21:43:12 +0300
Message-ID: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello.

Running the mm selftests from the kernel's root directory
on an x86_64 debian machine using:

  make defconfig
  sudo make kselftest TARGETS=mm

the tests run normally till we reach one which stalls
for 180 seconds and times out according to the following logs:

```
 -----------------------------------------------
 running ./charge_reserved_hugetlb.sh -cgroup-v2
 -----------------------------------------------
 CLEANUP DONE
 CLEANUP DONE
  
 Test normal case.
 private=, populate=, method=0, reserve=
 nr hugepages = 10
 writing cgroup limit: 20971520
 writing reseravation limit: 20971520

 Starting:
 hugetlb_usage=0
 reserved_usage=0
 expect_failure is 0
 Putting task in cgroup 'hugetlb_cgroup_test'
 Method is 0
 >>> write_hugetlb_memory.sh: line 22: ./write_to_hugetlbfs: No such file or directory <<<
 Waiting for hugetlb memory reservation to reach size 10485760.
 0
 Waiting for hugetlb memory reservation to reach size 10485760.
 0
 ...
 Waiting for hugetlb memory reservation to reach size 10485760.
 0
 Waiting for hugetlb memory reservation to reach size 10485760.
 0

 not ok 1 selftests: mm: run_vmtests.sh # TIMEOUT 180 seconds
 make[3]: Leaving directory '/linux/tools/testing/selftests/mm'
```

Logs show that the executable "write_to_hugetlbfs" is missing, causing
the test to hang waiting for hugepage reservations.

The executable not found means it was not built by the Make system.
It is mentioned in Makefile:136-142, and only built if ARCH is 64-bit

```
   ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
   TEST_GEN_FILES += va_high_addr_switch
   ifneq ($(ARCH),riscv64)
   TEST_GEN_FILES += virtual_address_range
   endif
   TEST_GEN_FILES += write_to_hugetlbfs
   endif
```

So, for some reason, the top-level Makefile provides ARCH as x86.

My proposed solution is similar to existing virtual_address_range check
that is to check for the binary, and if it is not found, skip these 2
test cases: charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh
since they directly and indirectly depend on write_to_hugetlbfs binary.

This is just a workaround, the root issue of different ARCH detection
when running tests from the kernel root directory should still be
addressed. I am not sure how to approach it and open for your suggestions.

Note that this issue does not happen when ran from selftests/mm using
something like

  sudo make -C tools/testing/selftests/mm

because then mm/Makefile's ARCH detection runs correctly (x86_64)

Kindly review and share your thoughts.

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index dddd1dd8af14..cdbcfdb62f8a 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -375,8 +375,13 @@ CATEGORY="process_mrelease" run_test ./mrelease_test
 CATEGORY="mremap" run_test ./mremap_test

 CATEGORY="hugetlb" run_test ./thuge-gen
+
+# the following depend on write_to_hugetlbfs binary
+if [ -x ./write_to_hugetlbfs ]; then
 CATEGORY="hugetlb" run_test ./charge_reserved_hugetlb.sh -cgroup-v2
 CATEGORY="hugetlb" run_test ./hugetlb_reparenting_test.sh -cgroup-v2
+fi
+
 if $RUN_DESTRUCTIVE; then
 nr_hugepages_tmp=$(cat /proc/sys/vm/nr_hugepages)
 enable_soft_offline=$(cat /proc/sys/vm/enable_soft_offline)
--
2.47.2


