Return-Path: <linux-kselftest+bounces-10169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7E8C4F15
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 12:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334141C20AF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A88139D13;
	Tue, 14 May 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SprSUAb/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7055C1A;
	Tue, 14 May 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680363; cv=none; b=PX0sYMPbdqKA9M7rakMPvxNd4QrAy8f4D1k5+v963wR8TXLYfCWAIWXjtLtdvdC6HSzBrP4KBL+Y2924DpFUUUGXE+Px+8UQCRBwN+fSp22keo9sfZoH2r+XYDuh2W6MACkkFVbwrd4fktdW1cDlJO/Kb7SHgtXFRdXXaZsOGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680363; c=relaxed/simple;
	bh=qQPs/RR8CzraieUgoteO0FaGhWNGB9R+qGNZhaCRM5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNufSIuFpyH6LFUEXX0ArcSnPf8mGijoTFNpqrP7Vj2X+1UQ0cPsodv1FKhfDI53ilTAImzW+tPsQYEu8Kir+D9kRbO7gcqD3MC5D5jtjPZRLUp5CONBXSFZ/xP6nsafWI9eqi/YpzEeW6/eiLAQU+CYfGMYjJAFcNIIUK/uc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SprSUAb/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed96772f92so43202855ad.0;
        Tue, 14 May 2024 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715680361; x=1716285161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFfP3mz64I/XOp3gx3OATpkgLA0E1TNomVcVvuvhZP0=;
        b=SprSUAb/lQHHZ7E3Y8nlYj3SVjcpy/7CWvj6Vdmpeoq5REciq/zQVvSzwc2eU0xbi5
         L9uq9zubk//MQuejHtUpWpkGSHjWtzvPE05Eh2N8G8avJNju6fqxKmLEpYsKcT3WrUjX
         sLlVQSS/l3mjOi3hV46uYqukTk1GtseZL+zya7lhc3rXuUPXIUCqGhbaoo0V1CQ+lGbx
         I2r76NUXDEmNWWkoYsEqOPKzQ/CnR+JrhJ+bFeAjfL3KqlstXOcNoyfpqGsp5BlOqJtS
         +YEp92IQavtIe8p8lxBtTk8nhgepgloGbsCubxcFY6RlFk/PfNFfhD+y4GoKcCRNMDKI
         Z2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715680361; x=1716285161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFfP3mz64I/XOp3gx3OATpkgLA0E1TNomVcVvuvhZP0=;
        b=AxbFBfKEkgw+a1Jum/okdAkVW6trCwGIM8FbaQ0QdLoDzBwNWEbvoEtRbCXuwRxl7k
         V+sM4aNy0fsgI6wcq4Rk0JXA1/doW9TLthEh6yHoqwn+40BSP7DwE9XsF0WZ+VxqsDe2
         /w9tBT5Zieqxkb6XMneHX+bCD43UQ+lzhweJWSHLibQfvFQJyhETXlmdCTNuznrh8HtO
         t/UJbEvumwczfLAU33oCnyo3e/SzkDA3iFthhilSquHUl3nudWMVd08Yh6TAzhdz6Hoc
         DM7gTikaAL8lDU0IRjOsipx/MVDLU704+TDfkZ8hmUknOjlBRqp8gncWHfT9MOgD1Jtd
         LZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8uOtWXKgJVYTcYdNtTxkCKaWjipG31n/sYHoPEowbUM1ACUTw1QGX6vVe98q07VyNIlkfoPGGh8TsQIrDmRed5HymEM5xoKoVK6/k1cFS
X-Gm-Message-State: AOJu0YxJmI8enHvzL1z6t9kRjrL0djChAJZSeqDaSxaAreyjhWIvUVFz
	zwj9QO8x/Gak6U7dJm9luWMepAIAO0sRnqsm250+KG8zRY61ceijc9ithCPhLj4=
X-Google-Smtp-Source: AGHT+IHUu136zWycDASDkbcbItzfJk6e0j3+jTBu17osPkQw2LJFVcxd8eZnTdwlaeuEiSUB4voT6w==
X-Received: by 2002:a17:902:684c:b0:1eb:fb02:c454 with SMTP id d9443c01a7336-1ef4404966amr119717435ad.53.1715680361112;
        Tue, 14 May 2024 02:52:41 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad7dc1sm93451065ad.89.2024.05.14.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 02:52:40 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests/net: reduce xfrm_policy test time
Date: Tue, 14 May 2024 17:52:27 +0800
Message-ID: <20240514095227.2597730-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check_random_order test add/get plenty of xfrm rules, which consume
a lot time on debug kernel and always TIMEOUT. Let's reduce the test
loop and see if it works.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/xfrm_policy.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/xfrm_policy.sh b/tools/testing/selftests/net/xfrm_policy.sh
index 457789530645..3eeeeffb4005 100755
--- a/tools/testing/selftests/net/xfrm_policy.sh
+++ b/tools/testing/selftests/net/xfrm_policy.sh
@@ -293,7 +293,7 @@ check_random_order()
 	local ns=$1
 	local log=$2
 
-	for i in $(seq 100); do
+	for i in $(seq 50); do
 		ip -net $ns xfrm policy flush
 		for j in $(seq 0 16 255 | sort -R); do
 			ip -net $ns xfrm policy add dst $j.0.0.0/24 dir out priority 10 action allow
@@ -306,7 +306,7 @@ check_random_order()
 		done
 	done
 
-	for i in $(seq 100); do
+	for i in $(seq 50); do
 		ip -net $ns xfrm policy flush
 		for j in $(seq 0 16 255 | sort -R); do
 			local addr=$(printf "e000:0000:%02x00::/56" $j)
-- 
2.43.0


