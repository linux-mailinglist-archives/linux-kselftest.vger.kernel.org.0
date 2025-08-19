Return-Path: <linux-kselftest+bounces-39292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C49B2BB08
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F20170D2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6D2773F2;
	Tue, 19 Aug 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj4AlTff"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872F217F23;
	Tue, 19 Aug 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589680; cv=none; b=sfNqViU23STcxgpT7AwhFpcV91lAe9vw4y4q0c7AtOg2uSb8EQpD3b7ngezcw7GU/qKWk9G0PFyOBCbTmdnQzVohqVr2f45qU/XLtlZ0/ER0Wa46gisxCrmlkzE6xmMQe8hPM610g2H6DusQ6UGvAqcPmAoPQa659aulkIi9HtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589680; c=relaxed/simple;
	bh=L5AiGiUokq6cpctKpE8FbgTcHMur4UUls8lnXii3GTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4c0lfyuLpms3mT4XoA4RajcJBBUFXeAPdfXglC+PYKI6o2QgTswUf87/g30rY0OIFDYTujVrcF3IzSQtqlEXkzoo86GhQ+U/2B+QvLK0scakr7u0Xh4GlvVuYAK82/xPXugFOvZtIXIE6ON0VrRiJlS16uNoRGjJzlca2p7DJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj4AlTff; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso5534968b3a.2;
        Tue, 19 Aug 2025 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755589678; x=1756194478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9whsM9Ixm8GRw4RUDKQhq+aVtmxmfD/5P//fgE8tJo=;
        b=Lj4AlTffAIyL3s0AwsaihP3LeNANynPa86wKX8QGkMvJf4BXj7QnG5Qdf4ZYt4bF2g
         AUpUqlgDxbKZ2G24ymBHEAvxVEGoJP6pTgwxhsowdXNjPPgDRnPcPFJbU2Qkmyn4psWs
         3IzzKLZY8wf2x8NrO4Xx4aguqQcPjlngUuJ2uuuiZU/iI1icf/21G5k4Tupc0nuFCnwM
         qf6PBCp2/3lM9STafCzNCUhVZ8HuKN40CzxzTcMw5/xKxz6qcizFiP9xU4huybYDSDj6
         +NeeXdVuqOQeGJDCcHxnoHJA8K7bgVugMpmIKGkyq4SXNC2emsjdzrS20cn3HUCSRAAp
         +acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589678; x=1756194478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9whsM9Ixm8GRw4RUDKQhq+aVtmxmfD/5P//fgE8tJo=;
        b=CSW27t2CUu9XgZtAS/EaXErXEBmezlfktHEYqaA3G5ONibxBByRI44vKA5dOcLWXok
         +xdbp5KWhDR4jfIjhkrJd05oCD6vC49M9ExWzwAX3v/DszXB7X/q0HHDho2cHEgstHBq
         WVV0u/rlT8jWuvhwXwgJEsIm6J1/JVhiEu44/wflxxqwQEZbcq3uAbgiDNE0KPb/ghBY
         GaYansFWe7orkVbMmoSjPZtNwlrr4rDOJAQn9vbN3MjVskxNzBNT73XH9Skr3JUQw/bm
         yQbnuwShmdOBdPq5WRWpa96kgPMLAyOFSTX54thF2UJJP4L2ouBzSPQyMlyna6JFNyNd
         ySyw==
X-Forwarded-Encrypted: i=1; AJvYcCUEuIXvMU5xhDitURmMdMc3izvJb3YVA5+aEjMjGP6ghfPJCiJEh0z3tNW+Qq0tpdw/7lAyVsd1i/34Q3ksezc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3PKicjkJC8jsL73jSQ+JDDINsH7GiGIAX0gNyc0c1eQLLS+Z
	mw2n0CgCAUdRgKJ5/PPaXLUOEhbdNx9jA13fviuSIO0e1n+vtjDb/GeKi4akr20Q
X-Gm-Gg: ASbGncvPYuStUIkN1d+fBq+6pjujirwgyz9mZNEYr44525Lu+GRuGt20svfQm23+UI3
	6oCtGB/gFgKoTxT33TWfDGkIWw7rwzsv5rGQmwrtYY/RGymAg2YWvjOEpqwZFm8TO64LjO/FDsu
	wcswFovGxpYcdBoY2UEJhoBw/G13ViONBiWdS06W2NP+ccE+aVuENnCHM0tzLowWF4h5XGcnJCG
	viwKWrcd1DAhgAr+1GwrWwGC48QBu2UC9X1RVW5UIdjC9vSSUBQZWvbVGisZt5GfocFQ5j4CI34
	2c/xUV+La46KtwTHf5pmIYwJ03YkpjdIHlnXjuRWBRtso0ONF0VSH+4tOzvWJ7I7Ovd1ZAfANO9
	4gVGsgJK9KUAhLo6kPDwZ5zPNcHc8JTGYG224NkXW0GNhfArexVrY
X-Google-Smtp-Source: AGHT+IEPQtenb5aBKyXu4mehY07P0EuLt91eDtvweR0TcTIgXsooaj56afb3QxQjezSXDVAUxwuvyQ==
X-Received: by 2002:a05:6a00:17a0:b0:76c:1c69:111c with SMTP id d2e1a72fcca58-76e80ec781cmr1896224b3a.9.1755589678070;
        Tue, 19 Aug 2025 00:47:58 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4fa868sm1658994b3a.64.2025.08.19.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:47:57 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: rtnetlink: print device info on preferred_lft test failure
Date: Tue, 19 Aug 2025 07:47:49 +0000
Message-ID: <20250819074749.388064-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even with slowwait used to avoid system sleep in the preferred_lft test,
failures can still occur after long runtimes.

Print the device address info when the test fails to provide better
troubleshooting data.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index d6c00efeb664..91b0f6cae04d 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -313,6 +313,8 @@ kci_test_addrlft()
 
 	slowwait 5 check_addr_not_exist "$devdummy" "10.23.11."
 	if [ $? -eq 1 ]; then
+		# troubleshoot the reason for our failure
+		run_cmd ip addr show dev "$devdummy"
 		check_err 1
 		end_test "FAIL: preferred_lft addresses remaining"
 		return
-- 
2.50.1


