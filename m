Return-Path: <linux-kselftest+bounces-48495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1454D01D92
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 10:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F5430693C7
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF09142EEA5;
	Thu,  8 Jan 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SrZ1Hv1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4242A13B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864023; cv=none; b=UFVDVuyLEbedLb6q+ZgmMiBhRj7yE5xQX2CsOjU40bH0BZ0Oz53amOib/mjQiJefD1xic8+Dp7URHvswNkLulXakd1ls1AiivQ7Jh2aA12ytU1eQXc8przcF/4vmoLlAvRECY6MdxHS+sz2hH3fuw3V21nknhEUgVc2gKP6jLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864023; c=relaxed/simple;
	bh=9OzlcL0OMkkabAm5Bt97yjXJPRZ7G2AIrVYrMNNwlrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkVTMJmajtuyrCyWETY7VBZ3CyWcQb6jnezj6J0/KldD1iOLtWN2CtCVd7LDqvGzZDQvAhAuc6qcDQqtvI/SCr35cKSZV3m3qy68ngJZ6xjTmdfgjgcBTHQMFqVtAgmJiZ7wtLzq13geZSB8NA00Hu5n5LiHLZ9oDGZ8/KeYL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SrZ1Hv1q; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7c72c3547e8so420301a34.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUiKvIP8HCqd3i2lEOpd43ZYOvZAdiFALGFMxkbZ3Lg=;
        b=SrZ1Hv1qHYthTgwMEqzYS4jICA7jn9BHX9xFIFQ8APtlvxobZbpvzDkdlhH6K8548A
         A90m+jwNC1vuqW8z/e0yxJhrmkfifeHZzcHKTxIOKBJeAQ2FtZepRJELUl5Q1G7kh3Rd
         eRePO0cb/zgNRQH4l06WiJ4nt9Vtsv84YfAGZPRcaFt7N+D+y/GOtphLCXsZWUwCra24
         B1sxlysGhVNeP81LlDxLH6Idt7hyIOLghscpCuuHakiap9gkED5ayQibw0eppeEX8sOI
         m0BrqV4uhbRpgXhVVFM4cqs16OQU55mDWuk8UI8bc1U84bZAU5UGdcPujf3lK3MsmHf7
         Ts6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUiKvIP8HCqd3i2lEOpd43ZYOvZAdiFALGFMxkbZ3Lg=;
        b=AWf0pom3zZXkFwCporsPjDFwvY/Mn1s7Wn2hX6OvXfAqpvOnI4ojLwVvy9s5U7bgTo
         EwVzFhoEkWCgg6XsSDLwB4H+cgCY8IYVeFnzI/qzaRr0XIN+Lx+BZAlDEKgdCBvT+dMq
         D3mVeDnzsJUln+nvKFA9qMydyjNyR/XA/Ohe4N4SLuKUKSbNEibWcYudNNxUZPzTvUMv
         S39arq7/Pl/12gD2nJBAFBPOdyBvu/KlCB3KrmUBeyund86NyrzITFwXLgQTSCYIrYk4
         fKwDC/97+NOXjO9Ky3mR3bxRtPQCi2gdGOAJqsHeSA8MdE1h4hW1gaomACwYgW17afM1
         uLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFHMf0BXaBPvI7rujGSZ3EMVW02UbbUio4tIliR5rnN3kH/Vlop+B7DyF5GPio1KzPWqWqaB9fd31Xx2JF5EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrOfDsqn4uWnQwBPlIBURJBeu89IYfixjRc5QKSzJ6AtLykd0
	TXTGYK1SxwFttyFzDAHZlrTEJLLhmzrW3my4zRDBbh/AVCw1AERIgc3G0SL4FUY66ENtTQNGr3H
	eIv9nWo2IGdf4owkx8/AZX88KR+3AK5qpLJ0Kn4peXxTJAg0X9Auq
X-Gm-Gg: AY/fxX4oJ49JJekn0bDEhmES3eeZVcusq/SFjDoaC/m8AdHqw2ZJnyaF1vXVPXONIeN
	lvyQshe6APO4ph1fGWpSyGfStHID33Fppi7ngBuELWNcVLJGyvloHxhKbdTKy9q9DSj3OiwuTzm
	wI7niObuNiZ0E1GODTQuO80w+pfXLiqMAAMxov2h7j7PF3tEekJdFvf0qMGfZAj/Gs5mOOL6MGN
	zWt5wV9ogYhj2vOOKWUwK2AYEJcsQsUTSVyXALQfyorux/rI0FrHopbN1XACBDE+YzE8ZZRGucO
	Elz3dS2vsoLFr/m/z1wz+6+NIQgGnuIPRdLdOKQPBWD3LVvJwQZfdOl4JQ6JwxlCzeb6eP/oAWf
	OE+Q1hKxvFVKDZFl+Vn0cIWimwpM=
X-Google-Smtp-Source: AGHT+IEMYn8qGLSHkK75uAAuzyF1tc5/kRXEa/H/RxheREPQOHr9VMCDWdd15D1Qh/+p630u8i3hRg7auOGU
X-Received: by 2002:a05:6870:b3d6:b0:3e8:2323:867f with SMTP id 586e51a60fabf-3ffc094ee9emr1931424fac.2.1767863997870;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa4e3e739sm837429fac.7.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E12183421AE;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DC198E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 13/19] selftests: ublk: add utility to get block device metadata size
Date: Thu,  8 Jan 2026 02:19:41 -0700
Message-ID: <20260108091948.1099139-14-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
 tools/testing/selftests/ublk/Makefile        |  5 +--
 tools/testing/selftests/ublk/metadata_size.c | 36 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 06ba6fde098d..351ac6438561 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -47,14 +47,15 @@ TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
 TEST_PROGS += test_stress_06.sh
 TEST_PROGS += test_stress_07.sh
 
-TEST_GEN_PROGS_EXTENDED = kublk
+TEST_GEN_PROGS_EXTENDED = kublk metadata_size
+STANDALONE_UTILS := metadata_size.c
 
 LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
+$(OUTPUT)/kublk: $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))
 
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


