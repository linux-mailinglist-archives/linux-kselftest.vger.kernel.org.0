Return-Path: <linux-kselftest+bounces-32914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2D4AB5C04
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0F3189AD10
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7381E8328;
	Tue, 13 May 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URTQH995"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD492EB1D
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159616; cv=none; b=V3aO+yAOh+ZDXKJtCok9InpApCQYvpjtCYUqozrCFwjXcSdt6wZgNer0I8JESiJ218PdYy7FeHlbUMpFocsA1QTIjyVhvN0wbrr88l+dc5vCn3N1oen4FMuIDSm6C66HG2MCHjOw1+o2QdcS2mOhATUkWJ3izHLzr6ZwBMNqEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159616; c=relaxed/simple;
	bh=yFRBvohKdlZ7B4RWAFGUxev84xRH0/iVU0WAsNtNfHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJmFA5mYHCwt81u0XOUflM3UL66mEeKLGxUJFS24lqxkUn1gyufdExuYLIAx5uEeYPWfRpXUwds1UOvEqaaq3jxGGhwlIvX4psu6hX9h4Mg4NhuTSII2m/WkKCpkTv0thX0JrDqyTeGUb8XCylBTpTOubkYD6D8bXttk3qt3lbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URTQH995; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0be321968so3675027f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747159613; x=1747764413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45Sal1szolo0FzhZOdc/VH7IQpuY3JSh8KROU8WIfeo=;
        b=URTQH995TSrFMNgqzfspWCW9nToDx5rX+STWEmw+puaPmEHx1+MiGz+UrFY9oyweGd
         JcOEg0yIStUMo3L1sLSELLnB8fxSXmS5gnS0BeGhRr3vDuswxxKCCY9cdUQNzn1Dgwys
         SMi5YI6PHKWH0PJydOR7/4khMZQ/1oG2Cslge5x9JhSIsOJFFXx5zYSlYvnvNH8PHxt6
         fsIhBpLwYdgwOiltFlYzATXkgH+YQ5UPhUsdbfZjnuFIhdppiUgX6Mu5/EDXEPJT8E0r
         pi5UYEm27WKpd3xlETLyEWFgfQexpBQMCJ9OXXPQ5Klgdpt0IU+J2lOnlWyghnxvxAQ8
         Hj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747159613; x=1747764413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45Sal1szolo0FzhZOdc/VH7IQpuY3JSh8KROU8WIfeo=;
        b=dMM7wrrQgEwUmdjRBBST47dmiis/KmjRfn4m8W2eAIbrlv9X9FZ1G6HuyvUSqKY2Tm
         ALUYw1pOgzYqb1IRHMKPZwg6P0B5ys00hgnOoJQSwV4yY1z6/CzwNJgEW3jtCXpjdpHA
         uOGDW0YolhP5nvQ4Wo9Yo5YcTGziwhYShp0lCVVdYdUEN5TevPoJwEgKFuyw31H8T0iG
         xtwXaNihFygiCMlYdt7G/iFT/nU9CdQ/6exmfNu4Yg1WOTqcDjrrA2OgscTZG3+nwS93
         vD2Oc5lM5U4AspC0BiXjO6W2BaxETvBUlG9ZiT8a5/Dnfrcz/7ZBhxlOFBd6ksPfgFVv
         OFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxSKmdChZHwbAzUiVbF26zWZqKPAVLlvDJpyImHafNB3HLdvxthDAzo+eq7lOnoeWjHOXmFywKziRwfj2AVoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXj8usai48VO5/+yLebcNh7SMzMYwCKL/berZa7KqTks7q6Gm
	1WaGMNv7F9gp/V40AlY1t0AcPO69hDVzHyC1mDmbBf/GTXrzh+Tn
X-Gm-Gg: ASbGnctVK32zE3D1WvFAr2TdlQifzJtCVGQRZhAJI246td0F/OEvy5cxZ6BBLZbRxEg
	fKTdsHnQzJGA3Kb4qoo796ssGsomuYqnEr5yTAHjDJBpL42py2uTDcaocPNguSO64DIUDN/xRZ/
	4tdYscbqTKiiEOidCZGRc0JigAmlWb2edtTORr753zpJ66g2UujfarZ+LMwqhTYr5JcAgSeokod
	3WqfTiJpPJ16UsNWNO5llQKCU4WyOH+wn0HGV/c4G7bMrEWtQ6kU3wDiyzSU6EmIX5MUBNfHvNM
	Ta1Cy7QausDZzvigO3SyRXpQDB4O2ygsOlV7nGOMKFCnTw7vTbqBc370pV9TFoKBTuE9+dZNTax
	KWAfenN3m3GSAVDsXqTUiLMXNjT9XR6G2yePOWKcBWsKq
X-Google-Smtp-Source: AGHT+IFRfPrf4vvsJMPf2/qJFtsS/TjgGxZQaWiKOf7Djy7ys6wLUTu0Oi9ef1cJKLAca3b4bxYWGg==
X-Received: by 2002:a5d:648a:0:b0:3a0:b1de:1be0 with SMTP id ffacd0b85a97d-3a3496c271cmr244133f8f.31.1747159612531;
        Tue, 13 May 2025 11:06:52 -0700 (PDT)
Received: from localhost.localdomain (host86-152-218-15.range86-152.btcentralplus.com. [86.152.218.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687ae10sm174900785e9.37.2025.05.13.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 11:06:51 -0700 (PDT)
From: Thomas Thelen <tommythelen@gmail.com>
To: linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org
Cc: Thomas Thelen <tommythelen@gmail.com>
Subject: [PATCH] Fix typo in 'limit' for bpf test
Date: Tue, 13 May 2025 11:03:37 -0700
Message-ID: <20250513180543.33488-1-tommythelen@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Thomas Thelen <tommythelen@gmail.com>
---
 tools/testing/selftests/bpf/bench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b..b25db4142126 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -497,7 +497,7 @@ extern const struct bench bench_rename_rawtp;
 extern const struct bench bench_rename_fentry;
 extern const struct bench bench_rename_fexit;
 
-/* pure counting benchmarks to establish theoretical lmits */
+/* pure counting benchmarks to establish theoretical limits */
 extern const struct bench bench_trig_usermode_count;
 extern const struct bench bench_trig_syscall_count;
 extern const struct bench bench_trig_kernel_count;
-- 
2.48.1


