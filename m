Return-Path: <linux-kselftest+bounces-48094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B65CEF953
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA9E301EC5F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F744262808;
	Sat,  3 Jan 2026 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cYT1LIRV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95923B63E
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401139; cv=none; b=ltt4QzCcXJddk88L/C4cJf/hkJ51FAeAytLRx/LTSjSiCG4gthmA5PLndrHXZcS7ccPd1TkAc0pg5mK6z2WmVhUSNRwsRUHwx3Q1C7w9Ik6V7mn2/9p3EZQQkolqjslqhqk81rPafO4LTFS42QWNeQAzc43Vj/TlSiqD/GpKaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401139; c=relaxed/simple;
	bh=W1ZlcN21O1nUErIL2QddLDLpe6HN6kZRnr32eNyAemQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMOme3MbTXCYrFJDwGkjXSlDhpMtR3yEBIyBZpKGA6XVdXlvk0GmI2C3T3VN8bb8YufhuiOMx20dmJahscbnMJ7XMhkHAbUSn1rSUQP8mqvwPFJ4r7EsZeuy2hsOQwJtaazx92ujobFh4SB4opjpChCc/OTozKLvmpMwbAEWLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cYT1LIRV; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a0abca9769so22701565ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401135; x=1768005935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcv9O2RJUqAVhSh3+8hkyCUs42mqp2c/jNxHfDkP5b8=;
        b=cYT1LIRVvZUZNIWxSZOmeVHC3acOrupFekPaCQrvcqdKHNZsDq3XVW0bGgZETBWz1E
         SUWe7JSF0O8xfOGlZ9ixQ8wMvXXpYjPVc3jsp3YqIhVuxQXyxWgub0G6nVmf7hDqo0Io
         /GSCOyT1rzKT60JY6u6wPvmXuqSCYYYft5xbKeowIQqlJVv4HY3dOW3psxBVG6GotGZe
         InGNsDXACSfUwSUN2OB/ynXVmJF3PsoeR5XKgeDeZRTlJz7+900TdtA19Sat+vF54Gw7
         b0r8sLmIHICIG3dtl8liqQzvtzwnFvuQfETT3KOUtfwkt5vdi7zd+F+Md6j8djIIQfVO
         t2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401135; x=1768005935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jcv9O2RJUqAVhSh3+8hkyCUs42mqp2c/jNxHfDkP5b8=;
        b=a5i2AOdy1aA1SL7Of01OE9I2q5O5HIzUks0he1bAo1yuuz/5mp1hlO+mMUF6+dSaVG
         hqk0TZRI61SS9xW+/MwyjETbR/tL576gIommeil/IzWLRpuJ4YvP87pWducVwOXIl69B
         QLV4UmwduilJfVRsSvfcnB0xzKL3MMC3bF5+l0WLwvbHmWbvpUe55k4Ac9mQ4AzbBTr3
         L8dm3lEWg4sIgPOGOkn70uspZi7rJ2NmBmreARxEXQm4IpY2WQ7dGV4lNJwDMIL3GlAF
         Msgwhtzq4kcTwklCgD9gm61XPzzqwc/LpshcF4NXudQDDfhRTP2mp2vtunN355zOB7dG
         +1lg==
X-Forwarded-Encrypted: i=1; AJvYcCXHcE+5H6h+WmhFqirE2BoSd5UCnrmM6bYPuB1ivuAL0L13V1JWKDbl0+aIofaS9tof58dksB2cggTlleI1JD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdTUNFwRuPcExagi+TUzH6/MrlWk155s4NT5aD32S5WSpBUtK
	AB4cu8+KMhl2KGhiuqOivXbmfDL48Vc8ja+m6UHQ6ZU+AsOad4KZPh4446VTjeZpD9DAglc4JL1
	okAlRWZw7aJkuPZI1x0DH3vGfc6yW/VWIBpDrPSYBKAJvX+PBdAMO
X-Gm-Gg: AY/fxX6NMCwA8ZqzpYskeoXSWEL+N1ltBDP2lqWv6P70PlzKClsZg5SmBJSVW321Cj/
	Z7yY6nTjG/+gOqZWpW1IRQ+0skNUVwZ2rr51zT0AH35YIiJpRhUuRFKVngrKUShA5vP1pXnZAky
	a4E4/NQxKHtHVEGawan2UKhfhfm/29ZJ1O6A4NnhRdsHNBM9quYDNH++OPrA79+zlG9OBGVjGRB
	RUwLVxwW2nirgP2dnnHRq7Bak4dcuTBzPhS1XvVhoDJXF3pNrF4+L9dxf1gh9PYTRnAIPXk5rjo
	2sJM6PFiXgaNH1h7T1FtIIi4YCceBYnzgL5k3drZkJIMwxlr3wDW6JFR/nYwb3yLp43j6XrZFvq
	gkzYouvUn/UQLmo6cmY5c+KwERmg=
X-Google-Smtp-Source: AGHT+IFVCSwIg44UNU7r0AMnF+xe20OgYVh3bcBfLnFf339bcxoBxZ5KSQRqFVbWIPZUso95dTnP5yojbSft
X-Received: by 2002:a17:902:e5d2:b0:266:914a:2e7a with SMTP id d9443c01a7336-2a2f29406ecmr330612725ad.6.1767401134795;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f330c704sm46168885ad.0.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 26171341C73;
	Fri,  2 Jan 2026 17:45:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 22707E43D1D; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 13/19] selftests: ublk: add utility to get block device metadata size
Date: Fri,  2 Jan 2026 17:45:23 -0700
Message-ID: <20260103004529.1582405-14-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some block device integrity parameters are available in sysfs, but
others are only accessible using the FS_IOC_GETLBMD_CAP ioctl. Add a
metadata_size utility program to print out the logical block metadata
size, PI offset, and PI size within the metadata. Example output:
$ metadata_size /dev/ublkb0
metadata_size: 64
pi_offset: 56
pi_tuple_size: 8

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile        |  4 +--
 tools/testing/selftests/ublk/metadata_size.c | 36 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 06ba6fde098d..41f776bb86a6 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -47,14 +47,14 @@ TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
 TEST_PROGS += test_stress_06.sh
 TEST_PROGS += test_stress_07.sh
 
-TEST_GEN_PROGS_EXTENDED = kublk
+TEST_GEN_PROGS_EXTENDED = kublk metadata_size
 
 LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
+$(OUTPUT)/kublk: common.c fault_inject.c file_backed.c kublk.c null.c stripe.c
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/metadata_size.c b/tools/testing/selftests/ublk/metadata_size.c
new file mode 100644
index 000000000000..76ecddf04d25
--- /dev/null
+++ b/tools/testing/selftests/ublk/metadata_size.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <fcntl.h>
+#include <linux/fs.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+
+int main(int argc, char **argv)
+{
+	struct logical_block_metadata_cap cap = {};
+	const char *filename;
+	int fd;
+	int result;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s BLOCK_DEVICE\n", argv[0]);
+		return 1;
+	}
+
+	filename = argv[1];
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror(filename);
+		return 1;
+	}
+
+	result = ioctl(fd, FS_IOC_GETLBMD_CAP, &cap);
+	if (result < 0) {
+		perror("ioctl");
+		return 1;
+	}
+
+	printf("metadata_size: %u\n", cap.lbmd_size);
+	printf("pi_offset: %u\n", cap.lbmd_pi_offset);
+	printf("pi_tuple_size: %u\n", cap.lbmd_pi_size);
+	return 0;
+}
-- 
2.45.2


