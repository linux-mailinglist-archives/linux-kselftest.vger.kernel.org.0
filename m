Return-Path: <linux-kselftest+bounces-34188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62865ACBDAF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742397A2483
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 23:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3E1F5435;
	Mon,  2 Jun 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcMlJ2bT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322001C84D0;
	Mon,  2 Jun 2025 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748906581; cv=none; b=lepe1ewf6Sg5y8ZMdCBPoJ7/NbFXbR/rFt0Lxh6sIzIIiKP5IK9pcV8x5FS3u6+rdViZmRtDCm8ngA79tvcxq4C7lN3czO+Kapo6Pbr1AGxilyyntuPQLQZDztva2sqHAW34rEaNVhLQDsiRXdUItGwWayIk7rIIQu9SItK1D2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748906581; c=relaxed/simple;
	bh=l4lNPNZ3NUcwOxlD8zL9Fz88dSmoXnMGOr5KnMPj9Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1jY8bpCyfZs+FMiyxMIHb1meI1K5ScgsLSbGt8laJ1rqXvbZKXOdZVjVNZE/4WAJQ7MbKFpED2ToUFlVyi0cJRVujI1pa0Qc+Fy/SdtZ/rVJ0E4sIV/IQtn0oYbf2HlIuK8NCGK87YErAi96ZypkmuaW/XV9RoGvOAhInfXF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcMlJ2bT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so32187085e9.3;
        Mon, 02 Jun 2025 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748906578; x=1749511378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4lNPNZ3NUcwOxlD8zL9Fz88dSmoXnMGOr5KnMPj9Zs=;
        b=WcMlJ2bTGgBsX4iKTdSvXpTjVci6ClPFsPV6sbjRhue9Cwjf92zr9xbmpQXuL+Nu8k
         aQpJ4dNX0qq4uKKXRrGm0hyYAJQlCxeHUDF6siJymok/dz3ij7/pcoBjzBldsCU3S2fN
         vvRiGKftSd5cjMIUOlA+GGLn96jYeL3pwl6S46QtD39pIT/knwRa3sYlj5cdlxg13LS7
         LeQE6O+5qD8q2FzovLnHijYKJ8vmd+H+PDiu4hfdDBYPaPU8wfEulb6BFLwS9GSDKpOX
         djpQ6vXrC/UC3zS2efLR6WXJqp/GGo7Wbe5rhj3FLsDQZS0FS2kKsiXi5R97Gc2Njdwc
         DCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748906578; x=1749511378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4lNPNZ3NUcwOxlD8zL9Fz88dSmoXnMGOr5KnMPj9Zs=;
        b=nHpoHDtNO6MRDCTiTPeNQxKdkwsz7cvBGz6W+aJleYEsd+DJyWFY4JTtpJygreQuEK
         yJ1FvK29tjGwpvHQKEpmE/2b5X96TZjaMC4HPSqOsi7uZi3tmUGXkp4HjxQeN7Nww8BG
         iQydgchxqrAzSaJbHGRXxcwJaTd1t8dmPM6ezgcqwcxKnpNjB5FwnGnoLy4X28ANQx4S
         20AG5Eqs9WZZTgBnpHhsObNkQUKk/SvIT1ER5BGXQVBZWN9VhnULicHYG4Nfkon/gxTg
         VsWQxLsPAMEFvBgkcurPMFvilb8LiyoblhPDAfKtaPJu2GcJ0z3uZvV2TTUK8ayTPPgJ
         1rtg==
X-Forwarded-Encrypted: i=1; AJvYcCU5uaC0lmlGzNAENEVoPm39btlFAEae2wXIiWEWrdml/WoIV4A2fWhco1h8rXCu9PlYiBRi8SrKGHXlCy8=@vger.kernel.org, AJvYcCVYuSAQCukawlnfkYFAle4evmJVtOl3d9ya1zRJoZi+7g2JTfSsx9Q7YMryZc3Q13tvVwygyOLqSQoW7nlNbC9G@vger.kernel.org
X-Gm-Message-State: AOJu0YwLd153vUyRuXBDGo1AmQg6BH6lUgMUD2240AwgIdvkGRqRY/M7
	4x1wFLqTYutidsqZUNSQZ6RHrPtWaYI2BD8YZrvqycVr1PhYvfhKwDGIHQAYNA==
X-Gm-Gg: ASbGncsG2v3tBLjtWyN2jabOsHE109hmNIHdIjvkm+kGgZtEhI+SwPcWtT5AyKNd7mw
	Miw9jOrRo6hWPo/rvzeK8tpuaJHHxmy4jgJ+AKc/CEw3xYDeHhHc88urb8bHwGUOsM0Y98iVw/5
	bA5oBnZ+jq9fus2KF+g9LUFId+BBOR/MlECV1RiTulhzXxSa/EbpRBp56OuF6WHNaKMJoburTc1
	yA9BUAvDhY8aNL+vAULG/qkuNhUsE/HD06YF3BA1yp6VDqN1V1RBTLCP4qg0pKyqZYrtQGkARG0
	frP2OW0hXTF9ejCv2rn9rR8uJeF2XGjOBiKz2aFi2qE/P1vWVAsEXNxOOjKeFtAeaGFjz24Q7QF
	wuQ==
X-Google-Smtp-Source: AGHT+IH6DsnJBoiQsAc3Tp9KiqWWBaTYvk3z0aYMLUKq3Rr7QP0jqJR9LBj8Sq5TS5iI/BGiHrY1Wg==
X-Received: by 2002:a05:600c:5294:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-450d883b9admr124035505e9.13.1748906578187;
        Mon, 02 Jun 2025 16:22:58 -0700 (PDT)
Received: from localhost.localdomain ([197.63.228.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb80f6sm137954765e9.28.2025.06.02.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 16:22:57 -0700 (PDT)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: linux-mm@kvack.org
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] selftests/mm/run_vmtests.sh: skip hugevm tests if write_to_hugetlbfs is missing
Date: Tue,  3 Jun 2025 02:22:32 +0300
Message-ID: <20250602232233.224099-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
References: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hugevm tests 'charge_reserved_hugetlb.sh' and 'hugetlb_reparenting_test.sh'
depend on the 'write_to_hugetlbfs' binary to simulate writes to hugetlbfs
while checking reservations asynchronously in the background.

When this binary is missing (e.g., excluded from the build), these tests hang
for up to 180 seconds. During this time, run_vmtests.sh is eventually killed
due to timeout, aborting all subsequent tests.

This patch skips these tests if the binary is not found, preventing delays
and ensuring that the test suite runs to completion.

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index dddd1dd8af14..0b55395ee2cb 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -375,8 +375,13 @@ CATEGORY="process_mrelease" run_test ./mrelease_test
 CATEGORY="mremap" run_test ./mremap_test

 CATEGORY="hugetlb" run_test ./thuge-gen
+
+# the following tests depend on write_to_hugetlbfs binary
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


