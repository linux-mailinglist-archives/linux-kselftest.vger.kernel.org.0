Return-Path: <linux-kselftest+bounces-38784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915BB22BCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53D51A27F9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DFF2F5329;
	Tue, 12 Aug 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkX5stmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098F10E3;
	Tue, 12 Aug 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013059; cv=none; b=bfxCKyaP5L3r6vmwS+EozOlsmN2WhaF5LwKm+Ph9ExNxu/ymOn6aKkiqWRJbhda+eefTrEuWJVNSTFG2g6y+q9zPw3Cjg8WbXVpmxbeeVWPz6J4WuniX+yer5/RsPVW0ZMYzEJZ9SZVJF++SDqnN+yAywmy8kQ/GGb/Kx9L0G24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013059; c=relaxed/simple;
	bh=0jz1kEdq01eWZaBFOsITXb/WcBKFjNiX53rgt3BOXRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdfIhXmqmG8joL3+4Oq7obAP1rPCjkNypjTlnrIyCV9YkJu1JGQcrKrGrnNHinrjHyGyvAzjx80HDN4i4hC2cd5OA5hkkk6L8LJy+OA2lpwatj1Oef3SBrtVx5DegqggvXBTz5LMGMQWpr9LJCNH4MCI6zgtRh8kVKuah3lb9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkX5stmy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24099fade34so41134005ad.0;
        Tue, 12 Aug 2025 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755013058; x=1755617858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnA3wQhwicH01DrI97DSCPT/OMKNvf36iGTqbZFNSaY=;
        b=PkX5stmyYZIaAjFZCcwFnEs+bsdCvtXElELriAlRsGQOdKC8sPIev8/lqpKNHS+NAE
         4Hx/SyJPVpk6xQ/+TLdAMi2bsDT7SzYv9xl5sPQiJ0qozIRM+ZmPcc6etCzrG2tNInoB
         Ke7UIaod8NiH7yDkz6JpIxnMA9OyX5grEPAFjgSA2eLApw3sCDovg8DHQLVXQXU4Yokl
         QRXdJikBG/rEV7N8oCj1YwjzTfvm9kHc01suOLtdzm6nRATb2RYZzruSh+tiqaxDdYxh
         FLGBzrc9DbYsl6Sf0awCH6DYAOtBqTrhxX/Pp5GQh6w5pYTkjjGrLaR9AZldjhd3nCVS
         mBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013058; x=1755617858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnA3wQhwicH01DrI97DSCPT/OMKNvf36iGTqbZFNSaY=;
        b=FHS7cS/rqFwlfYiA/OvmrovT0i+dgD/GG7dgBY0cXr8SGQGoc+WUrRiNev+wPF7Cx4
         1r65N9nlwDgJSpnChTbqaEJ1wOBHBmPbfAvshBbO2JgCpKHdiLX3KhLtlo8t2WghEEmZ
         4lqidxcRu4Tg/xPjevMzqd2kEbScdcxWTAE+PxNbYjaxx7aUJaQ4xae48zJKY4ECgVSm
         hzbq5lj/wlXq3VeNPgpv3lzTgXBQOZ/sBnzNSnzUgSKkKbnKFbP8818i/7osRE8QnNg5
         Uyr+i5kF4tlllfsvdgGE9qg9R7hUCpHDxp0ov2nSOAjDhXFJujssM9EbUyQxyOvVqx09
         hpyg==
X-Forwarded-Encrypted: i=1; AJvYcCUifbVU9dSda5t995Bi2jtcogmLOseAmxxZ44FhGTaGYAK4BhJfRNitOEJVIuOr+lj29/I=@vger.kernel.org, AJvYcCVXYsaXdF+IJ1tSRK50eRpt6g30sPDca7MLiowuHZntoZJxQyDeiZndiL+J8n9G3ZdDhrcd9ZaS955D0sM9@vger.kernel.org, AJvYcCXZLIqaXsez+e/Y0zDF1yGeeKq7flVBEAcBQpVZcmBTHkgjP+ecyINlMhzjmnEY8W3M1Zi6jXz8KukzXXjcG/vy@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4T9t9jf6n1f/MEmjZzKVjaZOxRxhnsqf3QCsQ1CJOWu7FIal
	TrMyMYdb25Gam/zvr55VnwxhExQd+HGvp0LV5uwze7K++hwP+VMonnPu
X-Gm-Gg: ASbGncsdleST56KjmsVDQxiqMpEi2sq2tPUgp/X0Y3Up1hRp3CLwEgvf1g5cW21+DbM
	KjqcVUM+KDqW/+3N1f07o0OJO8HljuaiH+/hmDU0I4PwLHyVn/483ceY7BbN8hgyfGAasM0cY+4
	q0Dj3qVMrIrSl+R1nzPOo5skHmN0WwOqhKArH5Yt8I74r3g3NUUQwO9p/uB9uGAZ2/fG65QmgKg
	51YD5TwnIWL6Zw1zFAIfhauNXwgqHW+byPaJwoCO+IihTmGahp7JpvIrzy4gJaLa6WBNHj1Jzjp
	i4TLyYyeGKDBXb3WNGV2Ijaxn2MKk3Nh2LoBsbqyfi8ulu2wbbtCrl1DakaMWi8v5aCOuicXMvz
	FaXu1RK8XCyOFyWypo1EzNavRCIDUGFLB8wqpzvk2PZLWHi4qAISn4r2pHw4p
X-Google-Smtp-Source: AGHT+IFqd2CWZuEfvfO4qN2rt0TfIpt1Fgx7A+xrLrIH5v6SuL06/j3hqPSNwIJI5pREio0g8s253Q==
X-Received: by 2002:a17:903:3204:b0:234:a139:1206 with SMTP id d9443c01a7336-2430c11d70amr1760275ad.40.1755013057618;
        Tue, 12 Aug 2025 08:37:37 -0700 (PDT)
Received: from shubham-HP-Pavilion-Laptop-15-eg3xxx.. ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabda2sm304011925ad.163.2025.08.12.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:37:37 -0700 (PDT)
From: Shubham Sharma <slopixelz@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubham Sharma <slopixelz@gmail.com>
Subject: [PATCH] selftests/bpf: Fix typo in kprobe_multi_test.c
Date: Tue, 12 Aug 2025 21:07:19 +0530
Message-ID: <20250812153719.36465-1-slopixelz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a spelling mistake:
- comparision -> comparison

Signed-off-by: Shubham Sharma <slopixelz@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index e19ef509ebf8..f377bea0b82d 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -463,7 +463,7 @@ static bool skip_entry(char *name)
 	return false;
 }
 
-/* Do comparision by ignoring '.llvm.<hash>' suffixes. */
+/* Do comparison by ignoring '.llvm.<hash>' suffixes. */
 static int compare_name(const char *name1, const char *name2)
 {
 	const char *res1, *res2;
-- 
2.43.0


