Return-Path: <linux-kselftest+bounces-3444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE883A1E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 07:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446FE1F2AC33
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED1E57A;
	Wed, 24 Jan 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0/PKMB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF5168A4;
	Wed, 24 Jan 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076838; cv=none; b=P5x0pZmcHkdAyz28Omlg/T10HWtbTLvVEu72EpJibskGv+ao2GRnz2LvRHSjInsPHrCoX1v0UGPlKBf+ScConVB/74bMQalkKz94GncipNmphUteUIL28syX+aq4BWqT9EWmLKRvmGtwFVsxjX6Q01/mi6xCdnY67FY8i9NC6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076838; c=relaxed/simple;
	bh=wpswii9EBVuc5OSgXjq6DMvx27D/iKdrgOPy+NO1nVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILo7qjJO0t9eMCXtZEJdmXFG9hKx5j8ucuXRkDIe63saAmyNZdbf99yOBXI1gwOztXTaGBbdKse0VnREAnW4Ly/VrRLj19xOR08vSXGRdxfuNny8zoL77gp5V4zjY0np078ZNEfgxLGlwRHbbuhs/5ZHA9DjIVf9xoGvt4quADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0/PKMB2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290da27f597so780862a91.2;
        Tue, 23 Jan 2024 22:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706076836; x=1706681636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkrEiZ9sNClSHrh1shdqnEb0FJh7Da1ZFgpqsIzqCCY=;
        b=U0/PKMB20hdzSd+6pGH1e2Na8NJaFWOPSCxo8CPXuYhXLn2+NqgHk7jDaAG/PyqIKz
         P38iR/uIH+xcu8tX2DxrBgvePX/cdmNt+k2Qe6CkROoZPuL9t9CKXzCCsh+6bTQeF5l0
         aASeYU94KbQryyKb/Xxjle+/AAILBpIb8KsC3hUG5ti23Kfzx56TdDmByvRjAwrtIs9u
         yBHzz2rnz87RfbCFZLYHsI8qzrMeyt4CgT05O2X1NKZEfp9G4OBT0MV12sgk00Mv3pOh
         u+MxRKuEAlqh0/jn8iy0mIh5QqS1DKqUCr8eaF8+vgvOqADGLatwGPzcXYv4TjCr1OsF
         tLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706076836; x=1706681636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkrEiZ9sNClSHrh1shdqnEb0FJh7Da1ZFgpqsIzqCCY=;
        b=Ug71Hn91XFpA0hJTLa1VlvnoNSGyI3QW5vA36A+5QjS/PpZ6nD4U2Rww9VRJ7VW2Ng
         j8lm1Lglp5N1gN3M0AW+y+tZtYnnn8BNHscwychNymUblerPomzxuZFzxmg5CBJK7QUl
         RSeSXFwuNcR5cp0UZfTNZEqa2aPeBBJV9ZwL4F+sA7spBQB/hno4CESBEwe/Wa42hfjk
         3qkubiMD+zFtw+0lwRh9V8tZyV110/1o1/2MBMUHuMinuxgjfaMBFyeMjbP3e2CtABiC
         IYy+Vn+vWsHOKOyKRp4MZb8PPHKJsLwb+pxoBX1TsffCMlqI51IPbKY2gIQ1Od43dRHc
         oh3w==
X-Gm-Message-State: AOJu0Yy01NxVwNZJORZYDHjHtDV+TIJt8E65CIQ0PeJQadd+sB+GsIT9
	WrrGCFv+6KA2eomeHQ3UactV0wnJxb3UC6Fy4rOhpI0S37s4MYhqYPSnmqGFs85aSK5E
X-Google-Smtp-Source: AGHT+IFfY9RYa/RcIAGAWONhUOJzUt8fYja+8oo78jzIGqoRKSOe5qvEM8ERbNm3iFKjoeqbCiKs3w==
X-Received: by 2002:a17:90a:f3d6:b0:28f:f1ad:ca6b with SMTP id ha22-20020a17090af3d600b0028ff1adca6bmr3213704pjb.85.1706076835684;
        Tue, 23 Jan 2024 22:13:55 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sh11-20020a17090b524b00b0028cdbf2281dsm12800714pjb.48.2024.01.23.22.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:13:54 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net] selftests/net/lib: update busywait timeout value
Date: Wed, 24 Jan 2024 14:13:44 +0800
Message-ID: <20240124061344.1864484-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The busywait timeout value is a millisecond, not a second. So the
current setting 2 is too small. On slow/busy host (or VMs) the
current timeout can expire even on "correct" execution, causing random
failures. Let's copy the WAIT_TIMEOUT from forwarding/lib.sh and set
BUSYWAIT_TIMEOUT here.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: add fixes flag. update possible failures.
---
 tools/testing/selftests/net/lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index dca549443801..f9fe182dfbd4 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -4,6 +4,9 @@
 ##############################################################################
 # Defines
 
+WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
+BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 # namespace list created by setup_ns
@@ -48,7 +51,7 @@ cleanup_ns()
 
 	for ns in "$@"; do
 		ip netns delete "${ns}" &> /dev/null
-		if ! busywait 2 ip netns list \| grep -vq "^$ns$" &> /dev/null; then
+		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
 			ret=1
 		fi
-- 
2.43.0


