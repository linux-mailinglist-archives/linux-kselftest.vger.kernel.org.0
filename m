Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B651536E745
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhD2IqI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 04:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhD2IqH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 04:46:07 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A92EC06138B
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 01:45:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d185-20020ae9efc20000b02902e45ca32479so11181003qkg.21
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jczHCwrsUz4nxGytYAbOYxiwVzhOvP/hHxvtUgEKyfY=;
        b=gF2qYHrDn89JrVsHKfB0auMYhxo5tdLoOGPcZ6s8bOXQ0rnJoYf2p8vyqIEDyUOMNx
         uBMjP2jiho5Djuvtg8p0rVR1hjrI2W/TwZuyWJhKehBBFrpAoSkW2s9/yWyDXpJuXmkH
         GdplhNz8B6ObULbxmKPzDpiLLkOEsttTrqrxXdrLhyif+LGxqSvgBLeeBfbiPHMheV+n
         YO1Q002eC6G4L7pVhvJTzbLWa+Y4aRWS+R7wRnb/IVK+9J6VjtDsDkpz1r3mwu3sXIMM
         dtMOdzWVtGdaKmyMzxMRhDFO8zIsfDUN9IGhjvHzdVAWJOLsGew4m7E1oGPYNywe2HA8
         Adug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jczHCwrsUz4nxGytYAbOYxiwVzhOvP/hHxvtUgEKyfY=;
        b=MrVZMvgLnszhhWNGzkQWp9qZ2K5zvNBSfKO/HLD/KfONAR1rFH/GSCeYu6c81Ytcwe
         K0IeUMZIpRDUvJMmXbc2/pHdRyIH+7y4iqjBj3RnggqHkEmYLzZW5NZpoHV8LPCX4foV
         UnKvqmGcK9SKpm35vBUy3/ielmWhCs0NKAMvOUxey+K+3tYCyI+0jqNL2PueIMaKidZr
         t5HubWDP5xEjAAsNeIzS6kJpwOYCcqVnMQbAwQxLeLgDXaqLoYkkdBTJVc/3ZwlP8b+0
         3XJJte6UdMJ0phlQsFHpxmLGmNr6kdq8366khztNyp95ypVp9E9/nvXLVqwTj8sNK7kT
         dphA==
X-Gm-Message-State: AOAM532heZTXhwH/ARasTvgjzIGO/ES9kjkFSiXOELamRNs/bHvOmekk
        59KA0WC92IC2BHkrX1cQiG638hy5Hohi
X-Google-Smtp-Source: ABdhPJwlSiTQ5Nd0y1YGK9qKbAQ/7M6H6puRAmZzvfiyHIBongleXchfeflsgyh6ffhNstvlx7r6z1R347SI
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:30c1:7a5a:2ec9:29e5])
 (user=amistry job=sendgmr) by 2002:ad4:4c11:: with SMTP id
 bz17mr17371179qvb.42.1619685920462; Thu, 29 Apr 2021 01:45:20 -0700 (PDT)
Date:   Thu, 29 Apr 2021 18:44:10 +1000
In-Reply-To: <20210429084410.783998-1-amistry@google.com>
Message-Id: <20210429184101.RFC.v2.2.I0d44ed3cc06ff2924c1b5e418e0599e1c1731c3c@changeid>
Mime-Version: 1.0
References: <20210429084410.783998-1-amistry@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [RFC PATCH v2 2/2] selftests: Benchmark for the cost of disabling IB speculation
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     joelaf@google.com, asteinhauser@google.com, bp@alien8.de,
        tglx@linutronix.de, Anand K Mistry <amistry@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a simple benchmark for determining the cost of disabling IB
speculation. It forks a child process and does a simple ping-pong
using pipes between the parent and child. The child process can have IB
speculation disabled by running with 'd' as the first argument.

The test increases the number of iterations until the iterations take at
least 1 second, to minimise noise.

This file is NOT intended for inclusion in the kernel source. It is
presented here as a patch for reference and for others to replicate
results.

The binary should be run with 'taskset' and pinned to a single core,
since the goal is to benchmark process switching on a single core.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

(no changes since v1)

 .../testing/selftests/ib_spec/ib_spec_bench.c | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/ib_spec/ib_spec_bench.c

diff --git a/tools/testing/selftests/ib_spec/ib_spec_bench.c b/tools/testing/selftests/ib_spec/ib_spec_bench.c
new file mode 100644
index 000000000000..e8eab910a9d0
--- /dev/null
+++ b/tools/testing/selftests/ib_spec/ib_spec_bench.c
@@ -0,0 +1,109 @@
+#include <stdio.h>
+#include <time.h>
+#include <stdint.h>
+#include <assert.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+
+#define PR_SPEC_IBPB_MODE 2
+#define PR_SPEC_IBPB_MODE_DEFAULT 0
+#define PR_SPEC_IBPB_MODE_SANDBOX 1
+#define PR_SPEC_IBPB_MODE_PROTECT 2
+
+int64_t get_time_us() {
+	struct timespec ts = {0};
+	assert(clock_gettime(CLOCK_MONOTONIC, &ts) == 0);
+	return (ts.tv_sec * 1000000) + (ts.tv_nsec/1000);
+}
+
+void pong(int read_fd, int write_fd) {
+	int ret;
+	char buf;
+
+	while (1) {
+		ret = read(read_fd, &buf, 1);
+		if (ret == 0)
+			return;
+		assert(ret == 1);
+
+		assert(write(write_fd, &buf, 1) == 1);
+	}
+}
+
+void ping_once(int write_fd, int read_fd) {
+	char buf = 42;
+	assert(write(write_fd, &buf, 1) == 1);
+	assert(read(read_fd, &buf, 1) == 1);
+}
+
+int64_t ping_multi(int iters, int write_fd, int read_fd) {
+	int64_t start_time = get_time_us();
+	for (int i = 0; i < iters; i++)
+		ping_once(write_fd, read_fd);
+	return get_time_us() - start_time;
+}
+
+void run_test(int write_fd, int read_fd) {
+	int64_t iters = 1;
+	int64_t t;
+	for (int i = 0; i < 60; i++) {
+		t = ping_multi(iters, write_fd, read_fd);
+		printf("iters: %d, t: %dus, iter/sec: %d, us/iter: %d\n",
+					 iters, t, (iters * 1000000LL) / t, t/iters);
+
+		if (t > 1000000)
+			break;
+		iters <<= 1;
+	}
+}
+
+int main(int argc, char* argv[]) {
+	int fds_ping[2], fds_pong[2];
+	assert(pipe(fds_ping) == 0);
+	assert(pipe(fds_pong) == 0);
+
+	int disable_ib = 0;
+	int spec_ibpb_mode = 0;
+
+	if (argc > 1) {
+		int done = 0;
+		for (int i = 0; !done; i++) {
+			switch (argv[1][i]) {
+				case 0:
+					done = 1;
+					break;
+				case 'd':
+					disable_ib = 1;
+					break;
+				case 's':
+					spec_ibpb_mode = PR_SPEC_IBPB_MODE_SANDBOX;
+					break;
+				case 'p':
+					spec_ibpb_mode = PR_SPEC_IBPB_MODE_PROTECT;
+					break;
+			}
+		}
+	}
+
+	pid_t pid = fork();
+	assert(pid >= 0);
+	if (!pid) {
+		if (prctl(PR_SET_SPECULATION_CTRL,
+							PR_SPEC_IBPB_MODE, spec_ibpb_mode, 0, 0)) {
+			perror("Unable to set IBPB mode");
+		}
+
+		if (disable_ib)
+			assert(prctl(PR_SET_SPECULATION_CTRL,
+									 PR_SPEC_INDIRECT_BRANCH,
+									 PR_SPEC_DISABLE, 0, 0) == 0);
+
+		close(fds_ping[1]);
+		pong(fds_ping[0], fds_pong[1]);
+	} else {
+		run_test(fds_ping[1], fds_pong[0]);
+		close(fds_ping[1]);
+	}
+
+	return 0;
+}
-- 
2.31.1.498.g6c1eba8ee3d-goog

