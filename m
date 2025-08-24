Return-Path: <linux-kselftest+bounces-39814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA78B33340
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 01:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120CD3A4224
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Aug 2025 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86CC1FF7C7;
	Sun, 24 Aug 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePaYGx0c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359B1991D4;
	Sun, 24 Aug 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756077590; cv=none; b=FZ6nVYa5rvGfpmWgFkpkfqR69J9ZHUZntZV8txy7mYxeYXKhuPzHHuwi1/yNTHtoXsCVSCKKpMmO40Q4XB4oaueILSU17XTtdStAWrSDrAL+KIZB8xWyJK0pw1bb3CY0QNcYpDUg62DnJ5EmURcjK9Mnxbl4ztc9UuHh8CoWmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756077590; c=relaxed/simple;
	bh=xs5BMCegfIqJONLHKBflgvssLR5EU8lHoB1CnTpHgGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cm3ttARyQtEDWskKhsNzlxiQMfS/kHZ1kAsl/scK95j9VbnCDSGQfcELiRd3JkscbUbJbhAL3sbPbEz37tQ3H8/AaFBKZCwPVpYA1iDjxSaWSbp7fJ/GBAx/1vfGwdNOM3dxSnisXKJ3g5eDWnfusp2w6Jpf4LKK59iz5gubNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePaYGx0c; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55ce5097493so3554768e87.0;
        Sun, 24 Aug 2025 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756077587; x=1756682387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmM40kFHu7y6w1kDElLTxjdz9xSmHdOgb73sn9dXdkQ=;
        b=ePaYGx0cs1z/6joQ1oKiYCCUNXV+MFFsUa4DO0C1gH22V2+kySE2GD74qf2yPSDZz2
         O2iZB12tjZNTN2po+SDBDgMCAWVFl1XAkBdRHv21s2OhvSqJW9yTIuXVfwK/i5Rc7am8
         7wewC6BG+Pf5LYqGS8f412mEx2DvFDR0Jki3FB5EIRHGtVCVQck4GqzKPCO+X1xTT05X
         wjgD1kHoohVg5ZkoswSPwteVrruRwL9T0Dfz72GjyFzC3akfBFvIPqO/VE0pr4h19msD
         k4KGYUe2bdxAUi1y2iUj2SypB6sUDVaaCNxQggASIQ+NfsoNxSj/FvlmIq24j0AvCf55
         Et8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756077587; x=1756682387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmM40kFHu7y6w1kDElLTxjdz9xSmHdOgb73sn9dXdkQ=;
        b=MJaoL0HzwP7UQ24BbZooiJtksQlY8Iw19CRMNNSRYwQmIGzZ65EURgsm/kn0dE8ncZ
         YVwX2KtGzd5pif9jUn/zWUqt+F9iVuIZk5YRhRuNxmugpa/kHq0CX435cuQskIvnO/OQ
         8VJhXoLhquLtkXoJLmNMwljZag4OU89aU+N6pmjGuq+mpXM4VT/lJFCcY3byf9Pp2FRa
         7FxKWLSVGT4bioAkj1nYJ2GLvWJCVvgUqm/t69yQESz0iwoeaCJvH5h92tkcLIJrPgkg
         pO+NZNOecbwU9dsEoHNoyINshrZtiN+eGHcSjYAmHswCn9zKe9nssNuhTdbq3hKp8aGj
         h8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU2JTzv1YTN1NvAnoJXvDzEWjOTHwk7g9efzPf81Jo318q2nUbPAUo7p7K6GtoDGGNU1GIiF3yCnjwlvW4=@vger.kernel.org, AJvYcCU42G/145UUEukeBxsA1yURfEelpceA6gM+6VeDJmgul48Xv4z3CU3fkdr2yvd02uMa/nD/Ci0WZKxxzI39dSPu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qBHGZUh0o0zHDOCtec3WIod0Kn+IR5KlwpF/GAhc455opP/S
	pv3pF/QnpI4FP5W4KCGWlfRyW1e3CE4NEsttSpgmjCLOqmEliCVo7s1v
X-Gm-Gg: ASbGncsRqnXzClF4/Pob7jKHyuuPJqysf0omf3AmImmYN/DpYq3eNm3KytBKGp7CW8p
	NRAAmt9bGr+r6rifxVc7Q9X+OQErF3mce0BaFSJ1Acl6nDrS+6vloEaALSrTiJ6cFzhrNU/mDJx
	Q9B8sQqfaN97eAqtDA5g0Cbh5MjdY7fYE19CFVnzbzYpSpXpLiSFwDa+LsuJdaJ1dekG3MCNoFE
	ghYMOx82U6W4Qwo+NcRhXdL6rKsK/SgGevybxfsz5KOfecIIXbsYqYhJLujW3rDYLIN2iYOPEyS
	fe7RddW0/jFizxLN3V8fMcQLDlmCYKh6Bc41ajD1Iw2pchLQ+TOmjV3lRHv4i46a5E7B4903JR3
	NYxO9R+ZRRVhTOD6vzeN7WZRrcFa8tsqxktWRKzsNJn7nEKdyD3oXNyG+FjIpzKh+q3zM71MzUG
	CIacl+OpxGCY1BJJK/+tTd9JbIbXHyRWnXucimRz91N8JnZ0TLbD4cFQ==
X-Google-Smtp-Source: AGHT+IFH8Gguydnj/gZwYUIqVoUJZDcXxQXD16TPLJVRIthpGvYhR/+6vI99F1aFwVlA/sgsldzduw==
X-Received: by 2002:a05:6512:234c:b0:55f:42b8:b11 with SMTP id 2adb3069b0e04-55f42b80c99mr817992e87.45.1756077586954;
        Sun, 24 Aug 2025 16:19:46 -0700 (PDT)
Received: from ip-172-31-45-110.eu-north-1.compute.internal (ec2-13-51-206-214.eu-north-1.compute.amazonaws.com. [13.51.206.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c9a199sm1294898e87.110.2025.08.24.16.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 16:19:46 -0700 (PDT)
From: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
To: nphamcs@gmail.com,
	shuah@kernel.org,
	hannes@cmpxchg.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
Subject: [PATCH] selftests/cachestat: fix grammar and debug prints
Date: Sun, 24 Aug 2025 23:19:42 +0000
Message-ID: <20250824231942.3910-1-mallikarjunst09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor grammar in ksft_print_msg() output for better readability.

Signed-off-by: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 632ab44737ec..1417d7fb7910 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -76,7 +76,7 @@ bool write_exactly(int fd, size_t filesize)
 		ssize_t write_len = write(fd, cursor, remained);
 
 		if (write_len <= 0) {
-			ksft_print_msg("Unable write random data to file.\n");
+			ksft_print_msg("Unable to write random data to file.\n");
 			ret = false;
 			goto out_free_data;
 		}
@@ -183,7 +183,7 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
 				if (cs.nr_dirty) {
 					ret = KSFT_FAIL;
 					ksft_print_msg(
-						"Number of dirty should be zero after fsync.\n");
+						"Number of dirty pages should be zero after fsync.\n");
 				}
 			} else {
 				ksft_print_msg("Cachestat (after fsync) returned non-zero.\n");
-- 
2.43.0


