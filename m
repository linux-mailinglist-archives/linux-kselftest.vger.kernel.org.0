Return-Path: <linux-kselftest+bounces-48590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6880ED0848B
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 10:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7BC8300923E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8363596FA;
	Fri,  9 Jan 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu4kA1Xq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA83590DC
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951828; cv=none; b=FwvVYhxKrdsRxWTzP8O1p7qb5tDys0PakZwkJzUP8SRpfp9dm3FvP85XAaM0rq9ecOdSvzzp0sLsHI3XpP9CtNqw9Tzg3HgaX0uLiMz+FDdr/rlfppw8HRTPxmi60Ln0+7cD84SzKZFr2Qn5ignWTQGZ2VmxqYLVcHquOqlcTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951828; c=relaxed/simple;
	bh=TxWUp/vZuNzaqFFdIfCZxGiBiiSIJIHvuKooHlWr+Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfWltC1bP6Qp2QOSttRa10f2VOU3l50mhedGLTDJoafR7oyNfZ3slcWUHs96m4vUEMyJulaxVSvpRRJzYve23DbGBVouTPRax5PViBy5wKDRQjbJI0fIY3+WYI2PH4vjrew3eBwwYmWYb4Ry4Z7BELPPkjWPNkYSEyObYGemb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu4kA1Xq; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae61424095so3759274eec.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 01:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767951824; x=1768556624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVR++7bqwaGzshLDMxL5A3NUDG9yGpndgGQgdOmBwC4=;
        b=Mu4kA1XqVe9Fq8w3UngLjaj/QZr7z0D+oXYK7333/e0Hid3ROk5IqFSb7EpLZAq7vn
         lO2agacP/lVh2TnCYaWWDY6NRbY2wUe9onp428HrWjoUo7O36wPetAb136ALdqxUQpHu
         sUDc2uT9DrvqdLZOau3y9CAeEZSxBgZl7KgKoTwSDZe3WZMp5R17k2bn8ez3d1JtFjUI
         /mN5bCHeocAd1QEOPfhShZkSms1RrPr6Fzi9UiXUz+mWynLx6j3YSdcGXhF9I+8g/0qE
         3f8UXH/rY0oKVa/hh+XNh8uqXokXY63W7bWHZ+4grquSDFaiyEri9W6uJv83xIYFtqGi
         B0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767951824; x=1768556624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVR++7bqwaGzshLDMxL5A3NUDG9yGpndgGQgdOmBwC4=;
        b=nThNlIFOCxirefaD95m+ZIMQNQwlKDOcu3l68TlkMS0byQtZCiG6scnByCkBBiBefC
         kDTwnbUZafarUwexu8n/B7HeLnwrbK5jXoKQEOxZWeOBY7XRuhntHT809ZTqQJECkTge
         Yc7W8r/NYOmWU0AUkHM60hSHM1K648sVM8dRvtVUkWYWelRP3ka/n5drE8sH9dB3mvOc
         EXcDBlFCjtytTtL9zIgE608MP8wWrJRBha03b8bdPTqzokK0EsmK/1U+BAg1UoUR8DtE
         /eRD9oPtRKXj9LdsC9hbNnrnBZVlcDKXqB9FzE+j58ShIyKF2uZk3EyoCan+OVagdAE6
         +Qng==
X-Gm-Message-State: AOJu0Yws+uA45CmVdRXrIbUuZFIpj7dplQdkA421jKY7GHXeG1iwOBnK
	n3xrNhbEuxa+Esy6aogVsNBLQSf/LIbhNAMKZFTuOWrPmBzGXst1ZrFaNJWjQr9uVaw=
X-Gm-Gg: AY/fxX7TsW9jxvYnxyK+BkOxAzf5x2ZjldqJ73ab9492u4f2ODENerdWNO9cu88Lk8b
	AOKjSIe+BJLwE16Zb2Cgaj2UEfttAfR4xHUXUmUCcRTPuRPqhI0Dir9anZEnVHJe+ZQnue7gS/n
	78dkCwpPYqrq/U134zja7rjFgI7gCrevHfHbwtw6jAz2DyKFB7UTgaam7kCM1VR+6bEjUnp3p9T
	2wzyTtLKIDgeTnAvQGNFKp/HgQvuwU9ERP5/aFfqrqRa0Tupp9RulF3PVUGILa33Zt7/VC1vi7q
	7+7dEfhmGp4x1FVdbcCkR4J6JtOFaU6wkNbHOuDk9WUTkh6hKhP7Wm+BHG2BOW7Q78zQ2aI6B2t
	9N8H6veDQXbju8c5OXskdFfOFtzJVFcuk4SQJxlnm06dzOPVG0IrIljh/Twb4LYpVbFJBT7vWyF
	Qv4f1a6kvi6OkAIw19HsuuH68QPdaias4Qe5w6dlI8ZXdifRusAzS03YWCrFL1+4hgU9crZVXw+
	mnHNDq0rTHdqQ==
X-Google-Smtp-Source: AGHT+IHB5QJdD5AO07uoxln1g3xpAtBnQnQZAQqVFp/MRhQwe+YcNlRyAU1jyANGoSCE9ePUYdnK/g==
X-Received: by 2002:a05:7300:ec09:b0:2ae:2bb8:a6fd with SMTP id 5a478bee46e88-2b17d29cd36mr8621603eec.24.1767951824225;
        Fri, 09 Jan 2026 01:43:44 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53f0sm10743499eec.10.2026.01.09.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:43:43 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/mm: ksm_tests: skip when not run as root
Date: Fri,  9 Jan 2026 17:43:13 +0800
Message-ID: <20260109094313.52307-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksm_tests writes KSM sysfs knobs under /sys/kernel/mm/ksm, which requires
root privileges. When run unprivileged, it fails with permission errors
and reports FAIL, which is misleading.

Skip the test early when not run as root to avoid false failures.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/mm/ksm_tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index a0b48b839d54..c22cd9c61711 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -766,6 +766,11 @@ int main(int argc, char *argv[])
 	bool merge_across_nodes = KSM_MERGE_ACROSS_NODES_DEFAULT;
 	long size_MB = 0;
 
+	if (geteuid() != 0) {
+		printf("# SKIP ksm_tests requires root privileges\n");
+		return KSFT_SKIP;
+	}
+
 	while ((opt = getopt(argc, argv, "dha:p:l:z:m:s:t:MUZNPCHD")) != -1) {
 		switch (opt) {
 		case 'a':
-- 
2.43.0


