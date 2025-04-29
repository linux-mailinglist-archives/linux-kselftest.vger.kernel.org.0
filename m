Return-Path: <linux-kselftest+bounces-31957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC86AA3BA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797933BD4BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3A278E4C;
	Tue, 29 Apr 2025 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LwqKwcsW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D95275867
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966473; cv=none; b=f+4MxUhaIaV/mL4IGvj8VnCy2CPDoUuOfMJ+ozRBJUunAIwKtokbmLESlqGpvjNUSCR4mSdPI4PN79mPbpvdg0VAzGrlXVWeqdmUsjtZX5v+0DDoBmss6VRUD6WLlEPKRLxxtQKct4Od5T/DcK18B9DDHZEVqufx8YCn7lNcaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966473; c=relaxed/simple;
	bh=yLjCvoCe6VXMT5MsUjHgKpFFAFBbBtQRcr91r8jHk+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvrRdKhINQX+6Xwiix7gZ5qKgzs7rYMo3Sch+kJXcVcB+uvupr+vUOhGqtB6yvTZoDwmnheeliSYkTh5yvVwEMyhNo2qherlAqy+KOMlwHG/IoRBgomyoW33w6gATauMTDP0MPSsDSnQMapdeMUcEeUsEYIAtwNBhQ9pwclQn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LwqKwcsW; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-224171d6826so97698115ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966470; x=1746571270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFNtS618ufyKJDtfH/r/PyGi4nE5aM2nCuyHf6tRb3Y=;
        b=LwqKwcsWiHCt0Ma4fVElW3asrerOszOKpN0s0hzAvtiMJPqCAoFGGvNNRgXDX9Cf7S
         ZYYWkvnueOR5YH6AXoBwp0ywutmIfIL3iSN8+Teu8N6RDD3EWiY3Ct8gx7dVdnZEMVZp
         Wf6c1/JNeztMCGffl7q1cMvUUBiLKdMGDg2aJdDNpqlYr/67Xsi0VqjgqIHeWotNTtgp
         dj5oVroce5AkxbB4/g0K13X/nGEXXOANwqaGmtE2vylF3hHmcWvBK0NlKV+kX61Nq66m
         b5dMFMF8yeUIP5we4+t9qiZA/D1ApZ/o/DQD564ytiq/CECJq+z9Nx4m7LeFo5bVfUZI
         EjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966470; x=1746571270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFNtS618ufyKJDtfH/r/PyGi4nE5aM2nCuyHf6tRb3Y=;
        b=qvAZJ0QQEHIPRE+No3un4e0eR+QA/OxCjhRzB627gb7SdMhmYukwE7qdwp5gjE/jnp
         Yjh+U6Ln3ICrlYpzJAKbtASlYpT04mHOwp8akomEr5CLQ40LfErHKTiIABrLllUA8PJd
         hnq/VrG7kLXkLhOv4RZeSxNLfrnjtSOEW5MUCJhSJNNIqxpF9EHVMdPIltzCgUNXRNw6
         7GvRfMScA2HPZduYhK1USNjDM6YEh4cQKO1X5yjgT4RIEA9yXHAX24u+R8UODkctTOSG
         XiybHf7ujiRXLgXFXWpORKTuDqHN/8YYi2ZqRWCAe3AmKaP5cSeBxszyYi68nvBMvH/y
         QZRw==
X-Forwarded-Encrypted: i=1; AJvYcCVJvCRoD+8CC/X0Fo+QYJuGNFczvFOvEkMfhS6LRpgtf4CENZHj4mp3bNhq5TS1QCdzbaVHvqEmUbgr1niBWFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAMYNedyFcuKV13G4Zmi+ArAjmY0uZyQGRM5G5bIIl4sq1JTN
	uPUZYUme5cvXt/irdbIf+5we7duT0G49wQUEVZ2CXcyD6b1QInac5tFZjABffWaYI3maux/4CTM
	tbFR0e8suA9ytxjYJw9A9NTm+88JK5ItRfW9+IsyJHTlRQTqB
X-Gm-Gg: ASbGncsQi6QN9UOEjisLH4WP5h9a3hS8PIPW0p7sLKVP/KuZ93RX12RCsfyB9f8DmnS
	UrgaCZcwyADsqv9rvhUSRcquHx64xvYJLBCI1gQ/pER5+7Mo2N1RUEUaBXobapeJb8fXc54e4Lz
	jEHTmoZ+Q4c/oDCPzMTrZX/lAeD+uyx/OIF2kjgO+CzXLZgABlWNlNLxrVU4290BF02x2DEv9j3
	xdYor6dTIfzJlAxKwj1Rg0c4Ut+BKJaqCjor6xa66wG/YsvFazhN4MDTsgGP8G8RCfMGRKxT+pq
	LKspoSXrBJ/PbYxAallF7KrhQSysbs0=
X-Google-Smtp-Source: AGHT+IGBZ7D6TEnAUN4d7huIcnUzTzs2CYiqo4tm38ieihvVaysSOYFpmF+9wSpzUkmmpxVwAfixH06NtvV6
X-Received: by 2002:a17:903:3c66:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22df57638e7mr2895685ad.8.1745966469787;
        Tue, 29 Apr 2025 15:41:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b15f7ec226dsm809653a12.1.2025.04.29.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:41:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0055634034F;
	Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E501DE40EC9; Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 29 Apr 2025 16:41:04 -0600
Subject: [PATCH v2 2/3] selftests: ublk: make test_generic_06 silent on
 success
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-ublk_selftests-v2-2-e970b6d9e4f4@purestorage.com>
References: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
In-Reply-To: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Convention dictates that tests should not log anything on success. Make
test_generic_06 follow this convention.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_generic_06.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
index b67230c42c847c71b0bbe82ad9de1a737ea3cb75..fd42062b7b76b0b3dfae95a39aba6ae28facc185 100755
--- a/tools/testing/selftests/ublk/test_generic_06.sh
+++ b/tools/testing/selftests/ublk/test_generic_06.sh
@@ -17,7 +17,7 @@ STARTTIME=${SECONDS}
 dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 status=none > /dev/null 2>&1 &
 dd_pid=$!
 
-__ublk_kill_daemon ${dev_id} "DEAD"
+__ublk_kill_daemon ${dev_id} "DEAD" >/dev/null
 
 wait $dd_pid
 dd_exitcode=$?

-- 
2.34.1


