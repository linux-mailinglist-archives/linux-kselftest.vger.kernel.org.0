Return-Path: <linux-kselftest+bounces-16379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A6796043D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E071C2255D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAF0199392;
	Tue, 27 Aug 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSOVsqvg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464A199245;
	Tue, 27 Aug 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746792; cv=none; b=theGISjKv8kDvO3Xf9IpooA2J6Bu/4AQXIjVGvB9e4MxGCjqgG4lM3Sgx1AZE6sRheRjUYplnNrl/Wmi7Pc378fWkh6Io6FCDoyt1LSezZymbWArpAZFR/5K7rdir/OdkOODm052OGWgzQoahuefYwrzhNXnJvzwfbIrkCuYzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746792; c=relaxed/simple;
	bh=bpgfcprmBTJWNfLrc7TSdPUFEpBnpZH2Bmmf4BSxQKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkgTXvPAM2KMwQlSRkpl+LxN98LeSSvJJ7I97qyueqjFiNa7XWAr7QLAmeTUDALEU+53KSkVS9exzPDX7vG3kAVpl0s+o+yvUmOgOq4Kz+43KOntqgSmPHMg2b4+on16k3Z4+zHtJs4xdUMAkj3s1jriNrWEZf6IjEFknOGP6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSOVsqvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA918C5812C;
	Tue, 27 Aug 2024 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724746792;
	bh=bpgfcprmBTJWNfLrc7TSdPUFEpBnpZH2Bmmf4BSxQKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iSOVsqvg74pQSXvPa71YbGcM0QtUq+NJfj0ko9Z3X3AEKdTewThcKWLfVvKS7oGeG
	 1dQTQGYM5p+uCM4NhmDFZan863nSenonfRW64yYoO1JD9HLjRxN26CSbM0pfatdtS3
	 GyFB8PSQvMAAD73Gestaud+tFq+PnCKiojBxRSCVhuzJRB/jxoBL9dCoNU+CjEOXyc
	 DHvDO2iNdDUEGHtg38jYj0yKyukIZI5Bk1LSnIy3VBZbfH76SFIVEqZSZP6d5Xadgf
	 m190EWDEwv/gTuYS1nNDjNIBMJmZeQZbNlxy+66hFVH5NfqqaVRiatLYwJFSCsi0hc
	 nEooOwkwq1iSg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 27 Aug 2024 17:19:31 +0900
Subject: [PATCH v5 3/4] selftests/hid: Add initial hidraw tests skeleton
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-hidraw-revoke-v5-3-d004a7451aea@kernel.org>
References: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
In-Reply-To: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724746785; l=3976;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=bpgfcprmBTJWNfLrc7TSdPUFEpBnpZH2Bmmf4BSxQKw=;
 b=w3oZaIu433/6Ox74nsNwm8eOKoTu/RWrej5smgof/HONxWqcGa4qf0M6IbcWySwL2a9ZCE/JM
 DsJL03v5omFBYLGSbQSFJVobvTTfFRn5FKZMbop/EN5vmzpQQhm24wU
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Largely inspired from hid_bpf.c for the fixture setup.

Create a couple of tests for hidraw:
- create a uhid device and check if the fixture is working properly
- inject one uhid event and read it through hidraw

These tests are not that useful for now, but will be once we start adding
the ioctl and BPFs to revoke the hidraw node.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

---

new in v4

Changes to v4:
- dropped the common code in favor of hid_common.h
---
 tools/testing/selftests/hid/.gitignore |  1 +
 tools/testing/selftests/hid/Makefile   |  2 +-
 tools/testing/selftests/hid/hidraw.c   | 90 ++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/.gitignore b/tools/testing/selftests/hid/.gitignore
index 995af0670f69..746c62361f77 100644
--- a/tools/testing/selftests/hid/.gitignore
+++ b/tools/testing/selftests/hid/.gitignore
@@ -2,4 +2,5 @@ bpftool
 *.skel.h
 /tools
 hid_bpf
+hidraw
 results
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2b5ea18bde38..72be55ac4bdf 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -32,7 +32,7 @@ CFLAGS += -Wno-unused-command-line-argument
 endif
 
 # Order correspond to 'make run_tests' order
-TEST_GEN_PROGS = hid_bpf
+TEST_GEN_PROGS = hid_bpf hidraw
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
new file mode 100644
index 000000000000..37372709130c
--- /dev/null
+++ b/tools/testing/selftests/hid/hidraw.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022-2024 Red Hat */
+
+#include "hid_common.h"
+
+FIXTURE(hidraw) {
+	int dev_id;
+	int uhid_fd;
+	int hidraw_fd;
+	int hid_id;
+	pthread_t tid;
+};
+static void close_hidraw(FIXTURE_DATA(hidraw) * self)
+{
+	if (self->hidraw_fd)
+		close(self->hidraw_fd);
+	self->hidraw_fd = 0;
+}
+
+FIXTURE_TEARDOWN(hidraw) {
+	void *uhid_err;
+
+	uhid_destroy(_metadata, self->uhid_fd);
+
+	close_hidraw(self);
+	pthread_join(self->tid, &uhid_err);
+}
+#define TEARDOWN_LOG(fmt, ...) do { \
+	TH_LOG(fmt, ##__VA_ARGS__); \
+	hidraw_teardown(_metadata, self, variant); \
+} while (0)
+
+FIXTURE_SETUP(hidraw)
+{
+	time_t t;
+	int err;
+
+	/* initialize random number generator */
+	srand((unsigned int)time(&t));
+
+	self->dev_id = rand() % 1024;
+
+	self->uhid_fd = setup_uhid(_metadata, self->dev_id);
+
+	/* locate the uev, self, variant);ent file of the created device */
+	self->hid_id = get_hid_id(self->dev_id);
+	ASSERT_GT(self->hid_id, 0)
+		TEARDOWN_LOG("Could not locate uhid device id: %d", self->hid_id);
+
+	err = uhid_start_listener(_metadata, &self->tid, self->uhid_fd);
+	ASSERT_EQ(0, err) TEARDOWN_LOG("could not start udev listener: %d", err);
+
+	self->hidraw_fd = open_hidraw(self->dev_id);
+	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
+}
+
+/*
+ * A simple test to see if the fixture is working fine.
+ * If this fails, none of the other tests will pass.
+ */
+TEST_F(hidraw, test_create_uhid)
+{
+}
+
+/*
+ * Inject one event in the uhid device,
+ * check that we get the same data through hidraw
+ */
+TEST_F(hidraw, raw_event)
+{
+	__u8 buf[10] = {0};
+	int err;
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 42);
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness_run(argc, argv);
+}

-- 
2.46.0


