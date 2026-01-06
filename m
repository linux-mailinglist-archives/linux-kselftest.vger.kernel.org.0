Return-Path: <linux-kselftest+bounces-48247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B74CF6283
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3EA0304290C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09B238C36;
	Tue,  6 Jan 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AxZuJH8w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E9223702
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661096; cv=none; b=L3PYjUHb2IqRo+mRuTgTLAbDC7sjUn/O9dPm/3a1bA32AScgCqYSe/KhEMuEpVF75EwcIan3sF196tkzdFKASkxT4py3b/TB/FV4Wh/gClrXSRw2lUfTH1DdcDP1XESKz8kJumkD+S0hcXDiNuLHKy5hOX+QFXXQZBgClqvRFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661096; c=relaxed/simple;
	bh=W1ZlcN21O1nUErIL2QddLDLpe6HN6kZRnr32eNyAemQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izr1IL/bPLAgN3PH2syvZmK47JHy2vz6l7d4xiqDmA2qTUFAfVl73TvnZvtSDY48mIRdQPhMYfxhM3xx4AlDq1ERyeOo6dLmkH69hqvv/FVq7G4rylNc6hnNtBnWbRWrqoWDwOYDxsMxw7LDXDhHui7bwJ/QFJTnUTM4MxrxIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AxZuJH8w; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a3051bc432so682025ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcv9O2RJUqAVhSh3+8hkyCUs42mqp2c/jNxHfDkP5b8=;
        b=AxZuJH8wbIWQSNz5LcKsA2GGBvgRfyBJ7Dn9hAwLesIOcKQ3VWosKqTwS8kZh9LbZD
         OxlO4igUZkWA6OFWW7sVl/f8igL+ej9Ddz9gG4AQahlVVzOFg1DuXUsKegs0oUAl1q5a
         KCLSaxf78MpvZV/5lb/ZJW7LutOWGxY6COLiVWibjjiu3uuOF42X8fSo/lJfLRaxW/3W
         0EGiwEogd1prEzl8M8TB0lAfy2NSWhGQ8kwBHHylb9f+T8i/5zNnXzzefFBTuiOkZJqe
         Dc5Er+0NLH+WJmGD4M15mK43U0iPKne//IrWWx/PzqWr25ga3eXWvdOLDyXDdVn0WIao
         5D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jcv9O2RJUqAVhSh3+8hkyCUs42mqp2c/jNxHfDkP5b8=;
        b=mnEkFW5PyQvCbIWsdGjPSgk+PSvNcjKaeyjTNTylza3jyK8KGFOSgrT5z07U8Zd9wV
         cnbWKt8ZGVavkZNPSM0z5lda3m+lwwAS+C+8CjjC8q+mbYf+duEuwIJk4Ihug/wEg49f
         bsU0scCTNTYSH8RE7qHeJ3wcWRV9BwWruz1ZfLHcnG0iezeo5nt6MQqs6pr0YNBPMRgD
         jFBRt4TbjRY42N9Y4IQSoJbbuIhS7iHSLA3M5uOgHm7DtkWK0sKuMELKbH+NmYVeUoXG
         I50wucoQX7nvBmnvttTiZrxytJ/WhTYSKUCL6/Kc1PEZJyA9RpvUY0ORZ99uAuOPpnu4
         60zA==
X-Forwarded-Encrypted: i=1; AJvYcCWaPekAZ1CvbqdTiuyun5yYRbit8irn9tLRBfSjXKOvyLURbzwRx/4ELD8qB86zdfO/0t5OuRch1PO/PLPrIkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsBViGf6K5JRHUzdkJZZv3g5Mvcuq3bGo6Jg2TR93EEjxtHo5
	IC7x+XYS1fXqJIZ41w8O3klxBH/G+3YqGcS9tFmxoPe4z8zotHomUSv0pCJQBJna+F55MpyZ5nV
	kt9RyCeoGsezkA7iXLne24nfMPDMaU2b24z6B
X-Gm-Gg: AY/fxX7MdKGlSn+lvJOGbYw8ufFZNkpTY3oohdHsxqw3ZSzsPsOsj3b2YR3Bs4tSGfZ
	CXAm6zIENUm011keqWsNUBP8AjVlgaUBZCW3okWp5ivOMmUWLXno8R/n1HUTfnQ+ySfj12x6Ezm
	zbceFcWFLrGbarYL5cxPRqD2Tw63dV7idkJ2nT2VDf9N2bqc1tCZvPwn1sht2JunZvhtJRToc1o
	qmfmNNb90LmTurW22brdyiP95FVP3OL9BF0NnlhPMkM9c0Y/ZlAbi05MbzeSupBe8sCu2Ebm5Hh
	ntEw/QN7NurE5kLD6/j9VjeJlpUTI5JePaKdaDoJbEJf/MWWqpJxrW0jaIBD0ltexPQUWp20ZZw
	z9bofR7McxkrAakoQ2OGCIShJgZDIzCzblpI1WxT7Aw==
X-Google-Smtp-Source: AGHT+IHLQX9+6t9gQS5XXoTmsg+XV0v3ZeAzjuEnNtQMHHDKs8HvmssZR5sNGfICmbVWpPQD/SfXOwS3XIFV
X-Received: by 2002:a17:902:c94c:b0:266:914a:2e7a with SMTP id d9443c01a7336-2a3e2e2a904mr9242545ad.6.1767661090901;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c6017asm874605ad.27.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 62C8834173B;
	Mon,  5 Jan 2026 17:58:10 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5472CE44554; Mon,  5 Jan 2026 17:58:10 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 13/19] selftests: ublk: add utility to get block device metadata size
Date: Mon,  5 Jan 2026 17:57:45 -0700
Message-ID: <20260106005752.3784925-14-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
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


