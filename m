Return-Path: <linux-kselftest+bounces-15342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984AB9520D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550DA28203A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409DE1BB6BF;
	Wed, 14 Aug 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLcZMwbz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E081B9B28;
	Wed, 14 Aug 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655683; cv=none; b=qCNo+LCSYazsvm8zPUkfUgRXrMZD5grNdv+yl10ke8Gb1v3nn2vyWDD/RRmAkqxT8hWauD79aF/gXGjNzzB2Ldzj9HGy9Pwj1t1ZAoNwrAI9s/KGxNG+dm6MP30LrlB6xhyzD5xguqshE1NIVz/esknnujYijB58IP9JOOgj5lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655683; c=relaxed/simple;
	bh=5KiMiGMO0+fP9EAr2iCqOfLLXM7bfW30N/BRrU6S01U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMtRWsHlLPcPUyCkqNQDZ7EVnnMbgQ1a29sDUYd7SXI/2cVPgpurZF2F8X6JPfT676tYOBlWwkYTqRBi6GylOM9skQ08FvrBVAub5DVAR+aTGOcNKXQASnSIT/yhMovbtZuU/97YWF+0QQf9kAmEvUl3hQKnMyuPyY4g+7i31gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLcZMwbz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd65aaac27so7987885ad.1;
        Wed, 14 Aug 2024 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723655680; x=1724260480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kNWX28Qr8ufHC9hLkI8IOVeCXr80mqcgSghAfdwkDc=;
        b=kLcZMwbzOPARHjvd1x7ijPLJyxVzsY2O/E6gvmPDzbnw3ow24SOcHuPx0/HLvP3ctL
         gQlvOO3/2lfyf5T6DsaiNiaZoMD4nvw9lO03MvZ6cfR8M3EXw7buXK8fW0EvO4l5yFFF
         24MuUs752xxZnqR9NdulPp5OLsKugT1EpGESlO69ularPGcHjc4Myk3kZ5dRdFaK+WIf
         PNoOjzftMNJzhapPQFt4OFWRNJmb5QUdNPRGEW/0euFbrk598n+n20qIMbAIQsKWKnCd
         fIJAALn/nQXgCgcUVPr0z6OVG8wGq/cPy4apm0bvyLQuI1S21AFwrjmaciLytsKGEBz6
         dJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655680; x=1724260480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kNWX28Qr8ufHC9hLkI8IOVeCXr80mqcgSghAfdwkDc=;
        b=WVX53IQOJvPl+RhEd7qsWvym1YXPA7L2MmQGZacU9Lz2hbj0CKUNCT13gYVBy5Fu6B
         P5d0ujXX3POG9vhJ3czGgAuuLE0dxGX6ma3aPdu4B4/hXyxzL6fw52d7nzPYZheq2sT1
         ZJjMcLjTYPLac0K9zoPSXCwHGc+LumlpgIhmx0xubiD9sYZ0Vx32Lhp5rbh4JpIypMNE
         0KwVsictNuMIx+knvc7ZYkCAZtTNiqiCRZBfCad81uZECJv+XTSv+sOahg/VueG1aPCR
         l4sIsgji+ZUP+A0aVALc3ds+S7vFn0XktbT64TKraj7oOywGo/ZMq5GrSDziYTXOuZdg
         IGxw==
X-Gm-Message-State: AOJu0YxPCGDqJEfcJ8xzuFZ8ZAIF8XR+XSzHG46XaIs99uNhUdFvT11x
	nuVC0cp1UV4vKhzZ97XpT/tNYGcwU+d9jcKEt8pXnYa86B+x/hF0x/OGzaQHxl+Oyw==
X-Google-Smtp-Source: AGHT+IHAoMnTLyfFSa2S1Rt10lGttkpwIZvQar+4DQSq03gYC8xiTgYU0L8QKwZNzCcmbxizcVtruA==
X-Received: by 2002:a17:903:22cb:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-201ee4ed160mr4510105ad.26.1723655680321;
        Wed, 14 Aug 2024 10:14:40 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201cd1bba6bsm32081335ad.225.2024.08.14.10.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:14:39 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	shuah@kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Date: Wed, 14 Aug 2024 22:44:03 +0530
Message-ID: <20240814171403.32374-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'expected' was spelled as 'exepcted'.
Fixed the typo in this patch.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index cfc849580..62eceb385 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1347,7 +1347,7 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 		size=$(du -sb $tmpoutfile)
 		size=${size%%/tmp/*}
 
-		[ $size -ne 1048576 ] && err "File size $size mismatches exepcted value in locally bridged vxlan test" && return 1
+		[ $size -ne 1048576 ] && err "File size $size mismatches expected value in locally bridged vxlan test" && return 1
 	done
 
 	rm -f "$tmpoutfile"
-- 
2.43.0


