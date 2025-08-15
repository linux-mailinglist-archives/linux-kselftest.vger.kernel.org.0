Return-Path: <linux-kselftest+bounces-39109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1163B28468
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886273B73C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1212E5D30;
	Fri, 15 Aug 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hujAPVHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB792E5D01;
	Fri, 15 Aug 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276724; cv=none; b=MSjnr6tcD0sv74VdfwAP+BRDLfKSFwy5Cw/AxZjfIuAsCMKyoPAjCMMvt3j3PjDWkQgXpH93+5AcTQKtFv18G0LivxPvIdM+tzGYuq8/pKEnFkq4H8aL7HgkDR7MUqEi9hb3MK799u2pDLtbbdVBeeOzqPKF7mK0tZujToPFisI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276724; c=relaxed/simple;
	bh=x/eQ5T/Y2xKfN/pPvQynA7CPWVBQZTgkNUc/ATBpy3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WieKBTk9qN0vr+j7IRyuRvCtdoCMHBjLPT6u+Uf5/XzW89AIVlkSbIznrCRXNxoab24qdjSYpqMLd9evqQcq2+E2r0BHq6zvEjjQ+S+h2I5HJ9IUpy2eS0M4RxCZhHxMSTAByhfvsph2pH8AANKog5OloBCAhb0EYHNMnh3FROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hujAPVHK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24458263458so18673285ad.3;
        Fri, 15 Aug 2025 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276722; x=1755881522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mST8g2ZgOoFqntACn2g18PfHFWyVsn3eT/UQGou6mA=;
        b=hujAPVHK9Yln/2Wsmo7xPpciBJTjmX/QdNf6VDdXpEXqPMck9+VGgHeSugqvLNPLva
         vRwEX6CTNPQ1bT0/kLAQMcugw0bwnvXilmwg4LiPIUAAJmgw03K1AthBMXRyl936ZEwC
         8f0yj9+0JggwYd5Vii25AnwkGjiP0J5yi9Kzvi5t2dLKvD0sViDbrl5K0l7li/GgTpti
         sGCbhw9QVt/q5krrJwfGRDVGR3CRSg/YSvrihKG5R2wYjqwMDWe2+z7ysRMmNn2Ewa36
         Qfwdedd7iu28JPa8sPh+rw+CjK4O+3nSXxv5lwkvLkSOmUmh6ZmQ4JFUxRy1dzjn+KPF
         dx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276722; x=1755881522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mST8g2ZgOoFqntACn2g18PfHFWyVsn3eT/UQGou6mA=;
        b=ZmzoEzOJjipUYVxktuovS4mvCmF5tOwh8jH4jqHi7hijAxSjMG8iUQ34d6zfUZLBwC
         LrkEt3VC28HfBF8rff5UBYBmhLuzhYmTYgV0AIs9Nh2nBQRhf+OJKLR1tZxRqOFDFXgH
         G5qbRTuPn7mTRHU46GoNRLPdfFlVGT6JlQYnu6zG9Uz+gJBDUTgRQEQYZO1QDj2furiL
         02UI0Kd8dYjwtURDf9pKbTV1teCZjYHIT+IMYC72iDweDMtZcsXaq/awIJMxBOMYexaC
         IzXQWnbkC+094q0RDDbFupkZNZ26kZEHHEcaiStAiZdaPYS/f9zwbpOrpwsamv8B4Am4
         HX0A==
X-Forwarded-Encrypted: i=1; AJvYcCVnftn+M9EVMwuUu7/Eu3wmEY2llOpoRwy589iE9Wc60Zj5zEmNc//2bx6d2D95TKpBqi1owSlE/wJ4Ymz1C6xB@vger.kernel.org, AJvYcCX04FahZz3rbxeoDzDNqmyHI5aNmlbH4YkpHk82eYO3aJO6UFfJJYRWnvMrr/mpDt4/mmW1fnpzbu2xK78=@vger.kernel.org, AJvYcCXPZ5UTfIZYCNe6cljJI4txUEifTAFdYuUGe+FYBM0PKShkdtYAbkwHZhpNJyxgtIXdH+hrKEyABt8YHSD7nCyF//88X+vd@vger.kernel.org
X-Gm-Message-State: AOJu0YycfpNPY7lcX/VpzOiRecRkLoGlp6+FbgKWRM1Nj/wdTtA9lBfM
	nlfc8lJWzdDbsICYKExDYK8/dFhvi0NXD0+mkXk4FcTEbsldLoBVZ4Yq
X-Gm-Gg: ASbGncvrwhBZQmpxNhPBaV2ceY7TEcOBawSaiNNJrS7BPED/M7hNQ1OJAsxfhKIop9C
	CAC+8LohR0JxrE5UQYyhMVVPA/4DKTJVVquuBTlY9KE/HpDY7Mfw5fQe2lCaKkZ4bYUfq0Yhxl2
	I7tQoWFJ2UEtk3TiX6973plXR6uUeWervWQMUaAA/1cSamBc8+iscIKRmnKm8+4QgAHPvq+Ym3a
	gZGGDUJN8SMr+PdIk8KNQaHD8XNirDRGPziELTiQ6QX/pv4rajkJaDPIK5v18UITa1JdpXuMgnv
	TD7CWQKui9seyMtQ4vstCq+A21BNT4+yXwdJKtHBiiE3GD4xBe4InnS5Rifdd3Jvlrap6FRNLvU
	KqpR2kO53l+4GtEpjVsyYsL99Mg==
X-Google-Smtp-Source: AGHT+IFaIGRG5l69hsOSGWYl040A/tu0+gqoTQTrAfX6O+iI+P4Piv5NKOktlkNubRPL926At9mD3Q==
X-Received: by 2002:a17:902:ea06:b0:23f:f39b:eaf6 with SMTP id d9443c01a7336-2446d94654cmr48291535ad.46.1755276722370;
        Fri, 15 Aug 2025 09:52:02 -0700 (PDT)
Received: from gmail.com ([157.50.13.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fe22sm17694525ad.133.2025.08.15.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:52:01 -0700 (PDT)
From: hariconscious@gmail.com
To: mic@digikod.net,
	gnoack@google.com,
	shuah@kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: HariKrishna <hariconscious@gmail.com>
Subject: [PATCH] kselftest/landlock : fixed typo errors
Date: Fri, 15 Aug 2025 22:21:52 +0530
Message-ID: <20250815165152.17046-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna <hariconscious@gmail.com>

fixed typo errors

Signed-off-by: HariKrishna <hariconscious@gmail.com>
---
 tools/testing/selftests/landlock/net_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 2a45208551e6..2dc0eca25ed3 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -1587,7 +1587,7 @@ TEST_F(ipv4_tcp, port_endianness)
 				       &bind_connect_host_endian_p1, 0));
 	enforce_ruleset(_metadata, ruleset_fd);
 
-	/* No restriction for big endinan CPU. */
+	/* No restriction for big endian CPU. */
 	test_bind_and_connect(_metadata, &self->srv0, false, little_endian);
 
 	/* No restriction for any CPU. */
-- 
2.43.0


