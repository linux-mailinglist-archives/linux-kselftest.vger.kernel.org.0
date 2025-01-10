Return-Path: <linux-kselftest+bounces-24167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B4BA083CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 01:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBA1167F47
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774A38C;
	Fri, 10 Jan 2025 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH8/HJ/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1E161;
	Fri, 10 Jan 2025 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736467729; cv=none; b=LOmRYvB8sO2FUE9kOf4gACGwhLVgAUXySztb/5j0pWh5fyku2IcpPLWtZCrVrMKDlo3KqFIrfbtPy5lu9EMLNI5wkMfSYbeUdR68RYYBot+DS71k9Xf3Me/95Z7yuHEWxMoxM3Eysssjnqcb945OvoiTZGXegNPDlmHd4tXj6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736467729; c=relaxed/simple;
	bh=LpU4T6DaL3TYqZnZsYt9+zHKNo+/yDhg0Yk04hh59vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPcb8FN8KnI7FAI38piuJRvKn//V6msnbos9yBX3URGF4vPCR/3hbuXrZGnBTcdDvF4hX3pPhnTNIWaC9PvjKXw2GWDBguWa7/VXHYGq0+g9JHPy841pDHt5auT1XjRI+t3o1r0hbSmIqNYu/iOngiTjB2JCSI97+DHIjJZu9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH8/HJ/c; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso307203366b.2;
        Thu, 09 Jan 2025 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736467726; x=1737072526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gi77FsVTSDY2PGejmDaiqsIfWWJUepdiBPVKpA1a4Q=;
        b=fH8/HJ/cO+S1bn58kcMMlP9LW1e4p6lryD4jtgxdXknEqvvXbRXduae9uWU9xi622j
         Ah7B2Pvzkc3blkgWsjH3oXaB7SeQetmYVOl7vKMnpflNUqrwFhc8joQsw0XCbXD5a7DX
         8dn/mvabJgklzKwMpXbHDYt0SjbYzl8i6/QytmoPGY6jK7Qg68KszOQHiQ53OrjnTwL8
         SroaAiJSd4nq7vKhSVRC2dgwafbd+xuxEsyy+bOw46bcuwSqfKhzxt6xgArPSHEVFyYR
         gLgCEM5nz5hPsBJ5jxJDQkFa5i4wnVurU+vqIdphsNIqxYfLAcOuQQ1dUrFp2AXDYFzZ
         5Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736467726; x=1737072526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gi77FsVTSDY2PGejmDaiqsIfWWJUepdiBPVKpA1a4Q=;
        b=cST7ym6So+d3xIgW8hwnAp3eG0wFELJB6wGk4DOhbpSfY6OELIzwGIsIwBrxS4wgrI
         IQDnBmiJDDb5XpnQotHN9Vmr0820B4UqPRWju6eWrC2qitOhmJC+yp/6tPharXmkY+8M
         tjxkPU2nHI/AcHfQ8I4FrNK7WPppJQQDZCwiMtcTWHr0jYMas2AZX7hIH7NheRVAJLvr
         g0im4eOltEHOF0xLNVuV37aJTGvCRrOhnY+8uU3XXBU0dOfSP46EDb3IXft8+8fATQpg
         2Dw8TlUq1jiwWhrPV3lweBGyze7YesisPU7GXaAuf6vxXn8ayQYc+w2H0dS+FB1c+0jy
         NlTg==
X-Forwarded-Encrypted: i=1; AJvYcCUn4zE4VQkLceaVaaIv4R+Azd3OpXHpafLL8Jhc/vVptrCpq2CLhRNsVZPrDaA17BhbjELc1PgZ+UFAkzA=@vger.kernel.org, AJvYcCVat448ZcSHy41lPcZDQjP9z1GSUdEdYAkKmdLKDqq5btOpxBCGBdk87HwOmdcc54cNJ8KLtkExeQMCGKvKh4RD@vger.kernel.org, AJvYcCXFjHZZ3C5BVnGD1KHCS0RxzWsicUFH99fh8dwPjulTyNwLPumv7iuvhtvWVHUaDZ7UII81JPmw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Sm/l6oqfkIpz8obx9PgrquIK6s7oeJfHBXGCg25ZeNS3ts5L
	VpZ7IfLxYbwI53ZzM6UwY9N9473QKTShoAVHx3QsOLzt+avSk40q
X-Gm-Gg: ASbGnctGGEm9fRR8sbVBrqr/+iFkAW7EkdloLZkcryGi/iKGBmD8r9yxcNB364sQC22
	Jb9yeWs6UKhRWL1HLmu6+zlSydCw8UQ2DKq6XXqCExMH2GFlrk53mD1ofiO8JWldAdTbgn4CjZ+
	yhaHcxFVrMx23a8dw0YnNm5DA8cCh64nTzo2tl2JEVisUzJ1KYrp4Xg377SLQpKPeEK1buUcY43
	nvrYALeI1yPv3lbQ1h+IsVpxyGr/2gbxJ3FMooqsk2f0FKACKYZf2/O8+q4LYPVJDl1Q9wkQTLv
	FVX6fQPAHupf+xZneD0hIpRH7IRZmUU67JbjS1V3c5Q=
X-Google-Smtp-Source: AGHT+IH0LN6QHv/PuWuj1kAEYuzbMeSziZOq4c9hDvuDYMGslPC1RtswM1vpV1FdaCivW+ftzY9fLA==
X-Received: by 2002:a17:906:6a15:b0:aae:8843:9029 with SMTP id a640c23a62f3a-ab2abc91605mr863231766b.48.1736467726100;
        Thu, 09 Jan 2025 16:08:46 -0800 (PST)
Received: from alessandro-pc.station (net-2-37-205-162.cust.vodafonedsl.it. [2.37.205.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90638acsm115734466b.20.2025.01.09.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 16:08:45 -0800 (PST)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net/forwarding: teamd command not found
Date: Fri, 10 Jan 2025 01:07:44 +0100
Message-ID: <20250110000752.81062-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make kselftest TARGETS=net/forwarding" results in several
occurrences of the same error:
 ./lib.sh: line 787: teamd: command not found

Since many tests depends on teamd, this fix stops the tests if the
teamd command is not installed.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7337f398f9cc..a6a74a4be4bf 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -784,6 +784,7 @@ team_destroy()
 {
 	local if_name=$1; shift
 
+	require_command $TEAMD
 	$TEAMD -t $if_name -k
 }
 
-- 
2.43.0


