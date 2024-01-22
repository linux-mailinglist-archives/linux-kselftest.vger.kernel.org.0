Return-Path: <linux-kselftest+bounces-3296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D35835D9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D77287CE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765DC38386;
	Mon, 22 Jan 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czxzXa5g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B617BD3;
	Mon, 22 Jan 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914354; cv=none; b=asPR1hQ8l5n7/HhrLJ9sNlr/8FNw+aWjY1RlbQC5Gr6xTBOlf0G7DeEeupItyFqbkMDnDwyY53B6aquEIfZsyMU+fPczsUWSHIr0jgZj9MA+2pKc68BdU9R4O7PDEF4QRkOFjB5ZFKJARUF5VrSAEouCXRFThkqOWB0Xk0TRWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914354; c=relaxed/simple;
	bh=oU82unBqvQ5mdFr+0Nr0rH6NaSCZpJs/X0cgnszPWVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KngTH56Q+9930xQwdFb5OweFD4tqZouUsxZv5IwJjqblfYOCLpRLKbJGLUg5D4vqqLLr5xZAUrxaZVoeuta1n5oJ2BJowmWQR7EOSOyiSHSB9uztSrnYHxvcTvGRy1XgpRcfA0mj/PGPwQVAFK9NKoTHTTHZJHSzhXuBhTaO00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czxzXa5g; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so1206319a12.1;
        Mon, 22 Jan 2024 01:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705914352; x=1706519152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhwGWxcbPOpbHo/55u3AIW8AkFtTdMCetajdGpRSW20=;
        b=czxzXa5gOw/8jD0NSLmZNTURoUUh/O2avir/kMNH6j+1TZTeZ/DfPN9evybFyfTZpS
         31dgHPFKQEtwqRCB/EBb/XOtxbT6ULNIiRo+nwoobQ2r19w4BqDAZI74RVQxHbcB6c/b
         UYxUm0tTVMXWbtiPAH1xd32tuEI5jXhSIkEEuvAoGoUfXVIXZ2GNwA0WOOaUswnBpwei
         Krx5/UBi76taVcrZU/MWZ6PCiOaMQt3HjmNjQil4YAAysqRv7TLR4s3KpCgSd4T6f2NM
         4kQ2ZxgM2HGOA8qrHtRX7Bx2sSMeOC8B4CiA7kORht4g6aWPuGNLHxSJrGpwDQk6jOd0
         5+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914352; x=1706519152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhwGWxcbPOpbHo/55u3AIW8AkFtTdMCetajdGpRSW20=;
        b=TRJ9a4UTgWb/ZNUWXsxH3r5qeUjOymJ+nAgcMh9Gg5Mx2oqQxtVYsyPEuu/Cb9Njuo
         0URPWBYivKrmyL3SBLMmulrazzIoBLcGpodGNZH1pza4Uz+k0BcQXqg5B47UX/uXHT3R
         BwkRDMkckRRgbwik5A1AokuBcfT+vsLl7+X7DRiq5uMXeq6nRHfUY/kfpuRrNX4ngPZx
         3KKihpfkcL/o0pW1zQJNh1eD9fH/Ee+Dbq8EDLtb3O6RG0jHVJ8ZrJJsQluYEhHyaTyS
         PzYxHMBrdEYaLY1lv78Gta3Zwq8Y/SzzxVC4yImYtchwc4HDnjGsqCEqPLF5JXVQv/BU
         H9Dg==
X-Gm-Message-State: AOJu0YwoG9kygMVsk05VNzly+5fOHTn1ekkpVZpz9P4nCAGPVJ7AqLq3
	GW6ZzNpzDzqn+EVw7is0YOwZd+g+IlFQd6FkyuvadlLYdjDlND3dqVewTuyqYfVg5g==
X-Google-Smtp-Source: AGHT+IEjopxaC7bTadYAAbIpAHAu3O8nhcxC+GnLrP4XmkQNaNxGKo/Ze3X49PMxioxxyKkhcjMubQ==
X-Received: by 2002:a17:90b:3791:b0:28e:7363:10fa with SMTP id mz17-20020a17090b379100b0028e736310famr920952pjb.92.1705914351811;
        Mon, 22 Jan 2024 01:05:51 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090b004b00b0028cef021d45sm9186216pjt.17.2024.01.22.01.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 01:05:50 -0800 (PST)
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
Subject: [PATCH net] selftests/net/lib: update busywait timeout value
Date: Mon, 22 Jan 2024 17:05:44 +0800
Message-ID: <20240122090544.1202880-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The busywait timeout value is a millisecond, not a second. So the
current setting 2 is meaningless. Let's copy the WAIT_TIMEOUT from
forwarding/lib.sh and set a BUSYWAIT_TIMEOUT here.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
Not sure if the default WAIT_TIMEOUT 20s is too large. But since
we usually don't need to wait for that long. I think it's OK to
stay the same value with forwarding/lib.sh. Please tell me if you
think we need to set a more proper value.

BTW, This doesn't look like a fix. But also not a feature. So I just
post it to net tree.
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


