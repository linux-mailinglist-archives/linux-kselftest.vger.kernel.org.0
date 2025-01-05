Return-Path: <linux-kselftest+bounces-23917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F762A018AF
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2D816232B
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839AA13E3F5;
	Sun,  5 Jan 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULsK4xyV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931D7DA84;
	Sun,  5 Jan 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736067189; cv=none; b=Fs7/xpiYSmCMAlPLw+lHRXnIO10rsg3u5tm/YVxvCAC7QUSlzYchRjkBCcJoTNc9u6QE6HpnVT7aiZIZSWkyl0gi0YuoqPl86/f47yZYV5+vFFWWye7r+yWSHrLRxqZzZATDVU/hwqMTDLgVkrcWtC0ruJzA5U3HTC06Yrl4H5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736067189; c=relaxed/simple;
	bh=b9n0Nfj91k3h2Q0NrLnOiA5u+xyBUwsV4tN9YTKRxUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4pK3tOaOc4t9nYDX+NCvLHREjJfEqupitRWbQIvwohZFprZ3Hg5+bm4CnBS2WzKI0TzlBS1ccOg4GGx/xIeukl6lVMfnfTnol4qIS2cEU8SGVw77AA14y4FVREUZltxGxbx3U3JMG5Ig4WAVElJCjOPcBY7uPWIc++2DhcuN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULsK4xyV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso14722816a91.0;
        Sun, 05 Jan 2025 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736067187; x=1736671987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNHzGCV835rfMgYwKPqKqPeLuQwNVSkguSfQpszEKyw=;
        b=ULsK4xyVINCH78BB3PgFHtpqn9rm6+Zmjln+GXRueAKH1xJQ0LboDCIe/YRwv0NEF5
         SQAH4u8LHvIwxClZWABi4k3uJBAG3W8VDIwUTV5k68zEvDkVqrS6FoUwrIWKP3NHXtH+
         GnFsnNZhq8HJN4NiXwtm2Tqg7/G9t+EJ4ed9zbIvNof3tRIJBC9AbUZeJBBPbmGtl7Vm
         7yuWhZsmfGpaO3UoYcxeNp1JqlJsqIW/CEglIteWYzAjXtjUpbrDQIBuj7HPb746Edsq
         nULEy+WAed7qcoxbVzbdG1zSqBMHU+rFZXUUqRBamvzEf4ElzQTT2ibm6qwMpjfpgNo7
         8igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736067187; x=1736671987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNHzGCV835rfMgYwKPqKqPeLuQwNVSkguSfQpszEKyw=;
        b=u+dDchGEAOKDbLDaG1b2Pv9a10SotZnMrCm7mKospU4dDNOXJiw0mKmrD8U9+PHGz6
         b1PFL4ZoxbpUp4BtVYgaGsYcdHOD9igHTUsevnmbCdHWRpczCPJE0z9WbCPLAKIhWI2K
         8U2gJ48nXnOgwzJ77E1dzPzRl6WYBrUiZZlm7twFopxsiROQkfub0gkJzdn4jupp9vlb
         Y4+G6LX7WJ5LUsJN+3MSr5+0ylur5FWCSNnoJN8awQJJ55MfClJLFkOFTx27Xonbd9eN
         uDFrYgwuEsaGwm89wOpTIPdU6+N3DO+wzSYULjojcdgfYj9TqentgAdPY0z7vub5/rXX
         LEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUXhAPTTPBymfILqexc+131WBrvt9VAg+Xaq59zL+vJm707Umw1xCrDRbvECsVv+lGW/IHP3cqiom1Vu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBj911fZC2CPrLghxi8c6Ivo3AEqjhgktzcS4dhPxLt9PxcvQn
	Sa7wmERjjzGTMNpn3ML5zIahQERGgttSLecMjEyAN7gn+BaeoVMVvGKwqg==
X-Gm-Gg: ASbGncutspccvG+tifi1TSdtmhCxwo4/Q90ZPHszY1eOkRke3aCZXTik0h9rBf6LIWw
	CpqgL4UqDytoGzSxkAjhktfyIX954oIJgVbl2KfY6OXVQuf3jHIzd+c5RU4fXDy599RKuJ4YSQX
	v9QvShROA58R7f5E09OnhMOG6kEAaB55AIsifyovOkAl17iUnD5sn4iLfhFACH57wE4mKTBBVOR
	Vv+XG6+TqdiGf4qWf5Em8ttSJr17dwuJ5DtthB8mcA3nBwRsW6PORN+/vFRzTm/sKM8rw==
X-Google-Smtp-Source: AGHT+IFlC4dVQZZvXJNZNdAYLGXLNVWSD5UzQIqsXKoHwEhxX/ETCVK8nKxgqQVIWvGDmYu91xJSjg==
X-Received: by 2002:a17:90b:2e0b:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-2f452deb50bmr84985061a91.5.1736067187281;
        Sun, 05 Jan 2025 00:53:07 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c53sm272600815ad.54.2025.01.05.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 00:53:07 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v8 1/2] selftests: tmpfs: Add Test-skip if not run as root
Date: Sun,  5 Jan 2025 14:22:54 +0530
Message-Id: <20250105085255.124929-2-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250105085255.124929-1-cvam0000@gmail.com>
References: <20250105085255.124929-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'ksft_exit_skip()', if  not run as root, with an appropriate
Warning.

Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
outputs more effectively.

Test logs:

Before Change:
- Without root
 error: unshare, errno 1

- With root
 No, output

After change:

- Without root
TAP version 13
1..1
ok 2 # SKIP This test needs root to run!
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

- With root
TAP version 13
1..1

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..657b64857e82 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,10 +23,22 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 int main(void)
 {
 	int fd;
 
+	// Setting up kselftest framework
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	// Check if test is run as root
+	if (geteuid()) {
+		ksft_exit_skip("This test needs root to run!\n");
+		return 1;
+	}
+
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			fprintf(stderr, "error: unshare, errno %d\n", errno);
-- 
2.34.1


