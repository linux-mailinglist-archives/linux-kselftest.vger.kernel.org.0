Return-Path: <linux-kselftest+bounces-47373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA5CB40F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 22:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DDB6305C4C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 21:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007E32D42D;
	Wed, 10 Dec 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOIq7GgJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EF2F90C4
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765401404; cv=none; b=MEBkt56hsdkeLKbguW0VcUFcOCPZyRBjU14BdUgsvZNTqbzLoXP3/dPCR+WY49Vb+9C+Ydp/P8HBQuvnkDXykECDlBGwjazyICNjYNTrpctjEGwWyo4Ye05LfzLLddmW1vqf/tGhls76kSzns8og27Gf0hiut9YqcgQed+DVVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765401404; c=relaxed/simple;
	bh=mr8MKA14m3hru5UbYvO5bVCKX70QVtF6+eaN8vBLjUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNqts7umohaMP2igwtFR+8MhwRhwTDxiFSLNJPg0rtWgZzEZxrJudlj8kE/dDZrRfX/Ejj3epsYQX3akE3s+wDfStPuVyShLmFmqxa+YSyJDorFlzlTEQiIEynljdx7MkfehNHQ++769xICmMOS0QjgnfYRyFGblG8axtTt+HXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOIq7GgJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso370267b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765401402; x=1766006202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWAaI77IK3V9A6IwXVo0vX3o908zHo/+nth9jNlQRds=;
        b=nOIq7GgJbajxrTEj+kkhmrVN7lhZjPOwj9Ob3F08UtuYVne2HuFTqsuj8F3V8pidL5
         MsSn/LwNy96E6C6UxtoMPjX9++v3++pqyrzUfcuu/8bUdCH+PNLc9akCyj2za5Yv2F7W
         2Cq0e0LzruQXfJg1x0uO3SkxoY64b/KU60txBhTWC/IzYpRHkMDx0kQwbCcRjKbD/MLK
         uq6EBhk2P9jjtaGWOIU/7wUksU/8j9u+98RazfhR266Van17jep4OCCBpyoYSEyegsxW
         B5kMiGvbZ7XwTd0JAo7H31wtLxngmGOxDzrPDJYi9dP9qIHoSYdv9DIo8IZ7+t9OD7is
         0VZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765401402; x=1766006202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWAaI77IK3V9A6IwXVo0vX3o908zHo/+nth9jNlQRds=;
        b=WeI8VSI4q+MC79y3b+kcP6QuoRljMnUGNsDOEIQ3254Mh2B6heRGVpAa0uU4ZlNO/U
         Rhgqw87NYIyxOu4si7U/4XTgL/2SGiQBvubnaaMjNRq+rP9TmgYBtM/0f6d5vjKShneL
         8huHjgTGlWTIetbXtxywoQzrcHO6tlXVQS/7AFlcYBiskUmZTzrwMNF9SNTmpFq0Yl9A
         kjuG4SvMqwuHadviReoW+8T6fjtYUEF3btWN4F2iNimJOa1ACgUJCtTV5MzU+UIbXqdD
         TDJTz/JlLq7OGYm8i10qZz+1UFQsAoS6CtzMmj9CUsOxug/U67ZUFO1JaDkfXvwdXekK
         j4pA==
X-Forwarded-Encrypted: i=1; AJvYcCVaxFPaKiUefduxC+GaCu+NE85r39FSJkLJETJMybeHz8slZIKYfhHgRHcnP3QXRomE8xTvoGv6UU1CCg0pEP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykNevMD8H9GWtbLCyutrRdjk1GhRCpFySgvPdHinB4uMTXdpXV
	b4+Tt0zxu4hy9MFy7mNLi4oDFmL3AVnV9j8id0xMn5AcyPZSZoOPnRAj
X-Gm-Gg: ASbGncvoWOH/M/rhyJwvZIx4r+etiQoyTY2EusHuaY4Uj+LhITRo3EzNWoT0xgvUDhP
	BxQ6d3wGCjIEqhfyco01UklGbFLWzdSNKVYNrrfEX+7NZoue1GvCzzfH39XMjgOcNqUD31jSEfQ
	IanDH7j9ID4CraOKT49KERU10sLSf79yeS7H0OyLJkc43AX48kqZewRXl7+edrvTETV8lOp1ysY
	/AY1FU4EGpX1O+NKqC/LgaTqBMkNySXH9t8vIP8BuecjFIGsyj6BxQQVGreSSCnzp30XFBb5vWv
	eA0fI5H9hqXeVRuvFvh+oFzSnhaJHxNzBnlT+PBdk0ORUpXL0/o/CRJ13lb4bY4PTztEN1PdOom
	i+37C8fkeEA3KaHMqgn1+sZnmENiKrgNHmpv/+m02zDMPHQTTu/12TW/tpYRDwwAraVT6FOKRTW
	M8fO1/dXku0jtCIQE8q+TVzYQUOaiIFswHttudIEs=
X-Google-Smtp-Source: AGHT+IE2ULD1yYKY6ybGe7FNDn2kZdxGAEF3Iv6t0/+g1Icyf6iWWfIVjfCStoCP7aC+K+nu1WterQ==
X-Received: by 2002:a05:6a00:2789:b0:7b8:16af:3bbc with SMTP id d2e1a72fcca58-7f22d3023famr3337030b3a.31.1765401402189;
        Wed, 10 Dec 2025 13:16:42 -0800 (PST)
Received: from localhost.localdomain ([202.164.139.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4aa717fsm424373b3a.36.2025.12.10.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:16:41 -0800 (PST)
Received: (nullmailer pid 989870 invoked by uid 1000);
	Wed, 10 Dec 2025 21:13:57 -0000
From: Kathara Sasikumar <katharasasikumar007@gmail.com>
To: jgg@ziepe.ca, kevin.tian@intel.com, shuah@kernel.org
Cc: iommu@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, yi.l.liu@intel.com, nicolinc@nvidia.com, alex.williamson@redhat.com, katharaasasikumar007@gmail.com, Kathara Sasikumar <katharasasikumar007@gmail.com>
Subject: [PATCH] selftests: iommu: fix Warray-bounds in get_hw_info test
Date: Wed, 10 Dec 2025 21:13:42 +0000
Message-ID: <20251210211342.989850-1-katharasasikumar007@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_hw_info uses a smaller user buffer on purpose to check how
the kernel updates only the fields that fit in the buffer. The test
created a custom smaller struct for this, but the helper function later
treats the buffer as struct iommu_test_hw_info. This makes the compiler
warn about a possible out-of-bounds access (-Warray-bounds).

This keeps the test behavior the same and removes the warning.

Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
---
 tools/testing/selftests/iommu/iommufd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 10e051b6f592..f6aceb65313f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -755,9 +755,7 @@ TEST_F(iommufd_ioas, get_hw_info)
 		struct iommu_test_hw_info info;
 		uint64_t trailing_bytes;
 	} buffer_larger;
-	struct iommu_test_hw_info_buffer_smaller {
-		__u32 flags;
-	} buffer_smaller;
+	struct iommu_test_hw_info buffer_smaller;
 
 	if (self->device_id) {
 		uint8_t max_pasid = 0;
-- 
2.51.0


