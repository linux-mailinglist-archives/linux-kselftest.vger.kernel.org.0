Return-Path: <linux-kselftest+bounces-36151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E09AEF18A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 10:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288FF444660
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A026B778;
	Tue,  1 Jul 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KJ1TdNNK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3A26CE1D
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359318; cv=none; b=pEuCr4BmQvT/a3688NMK6sbBc2eQz39KoC2OarK0LPc7/xuGSuo5hyHsTWJP1PGmuaCBlu/1zLJ0VpIcKFipOo39FxI69BE8mzOFXdWZRTSnvz4bhOY/VmMoJJhwS4Dtb/f5wfan6ctYRK/VU5lQ41oanE/TamqOptfAm8OTJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359318; c=relaxed/simple;
	bh=sNMgYuRRHDM5tU1JOzxhsMgU93et6+sqxnzyafhvyOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0eTa9msHs4U+g0aHy5WhF2+MzI9OlrlLErjrMwcfsQgDvRNu75QwHLpL0I8whFjWEBeN1iKGQqUlwc0EajaE3odRSS28JiZ9BD5EyxEsVF/vSS12hkfcgyi7WL92pNgldkGZyhjcruNKEE65Omp8+KUGUFdwDB4U6lTtwAeJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KJ1TdNNK; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 753133F26A
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 08:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359310;
	bh=3ACJj1pibTp1hDCcnssHwfTz2N2iBLhUH85nRukXflM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=KJ1TdNNKMjjTRUjkVJpWA8J053XSDSeR7/6Mmeopuwt6jUb4Eyb4VtrxTbi1IxHvt
	 cTzrev1yThi477qm4WyAZRHSSLhKNGmc4+Sc0W401BPaoW0aVtvrVALHTKLc7M5O9+
	 ePxou9kt23YyjAPLIqOqogtLEnhvF6591V7Rx6udSqaUj+oIGw1wP/+F9U013/cbmw
	 U100WvdsR47MuxBNTujGPNH8xvYBvjsE6NBKoKJlwuUhoLyiE3Yhk773Om97vKd7Zs
	 dX2cDDPXidwYFbKvdgZdEL+OHHv1GmFTeNbqfLh8LGv4P1DJRPm8CRDLUqypXES9Ya
	 8YI0lFFUjqTGw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae36acd23c1so247778866b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359309; x=1751964109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ACJj1pibTp1hDCcnssHwfTz2N2iBLhUH85nRukXflM=;
        b=L/yGbYBfzKDD+j6QxNjM0O1rorer8YksfkEWk7V0UXkZDgkSISdYsiGeecBSZlypXa
         06+7ruQxaBTGKUHeIzLQ1mCLiBcKpAFILNUMHhDksTiUqf8bNO8NJBRhqnpL/k7DWwwF
         mJLU5y4wrNrawfjZ3X4TQs0qeIL5p2/TFI2IiHQoReRkb33OtPpiV4QdzGYFb+wO/12T
         TMG9fWLr8nfXEhKOmClUr7J3QoOSXXbdsOjYfaN4reWpV8U6mkyUiyxrtg3xnPrftChv
         C5EybcerNQkq6gaNbA9UqyXSq2QGnnRqWuK6eL9PPwHrdci9oxYUodT4BfqgeyyygloB
         l2xg==
X-Forwarded-Encrypted: i=1; AJvYcCVa741HKXcQcvI2wV3mhYiarNrP/Bzu5KIMISD1WyuG+4fJFTtWot+lOw8KuW2Fz+N+P2LwJhyg+pV06gA58y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyANpvl5PeJj4k+9ehkpSNZliCFhpNK6fUFqlJo7rGJtERF6Gbg
	VXqlWne0JFhtouPiTxuazwOhE646tsfVvPNdLasqxPL0pPVTy4DfoX7iqJWsxvScP0DxZ+2erl3
	hYx6A/Kldh9lW6Kyd1DEvYPoJVKZrm5mKI0WuWPka2JLeJDEvsMZ3Rzel/yPYn376B0ThKGBWng
	kclFigRMYbrg==
X-Gm-Gg: ASbGncuDowN3WMNXREDuGjMgkEMHCVhazmvRVO1rH6FHFKGKUK/CLcGR68759GyiYm6
	7lCJ7oxlQNLHBJJK8y6MF1I96mGI2kJZHJS4XOFQ+hd+tOIx1rg8MwPN/r7JP7/YFiXFVk1CdH8
	sniCEFHS+i9t8+qeGJWMXPBFuXIFV6FP0DU+8v/wiXgKMGfcSZmCZJjbRT//altjY53JB+1GxQJ
	3CuloQWN5ya7iqGFQSC9QlsDFWQQUsbsehlpeIHuzK8Cbr/XkQQtkrQwW9SaTV9Px7uxRAKNE7w
	h/DsNsI+UrtB/moK1L/5iQoLDfEBGn2Z3+bdsArttQDIntZJTA==
X-Received: by 2002:a17:907:d2c8:b0:ae3:b654:165b with SMTP id a640c23a62f3a-ae3b6542a2bmr37281666b.24.1751359309006;
        Tue, 01 Jul 2025 01:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPvyXkJ7xxlUFVfvGUBKe1qmn9gYzE1YPTdbDiV+whqqCBKDQi+KNw6Dqm3Yw3xYlwRh9jZg==
X-Received: by 2002:a17:907:d2c8:b0:ae3:b654:165b with SMTP id a640c23a62f3a-ae3b6542a2bmr37278266b.24.1751359308447;
        Tue, 01 Jul 2025 01:41:48 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm812427166b.28.2025.07.01.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:41:48 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v2 6/6] selftests: net: extend SCM_PIDFD test to cover stale pidfds
Date: Tue,  1 Jul 2025 10:39:21 +0200
Message-ID: <20250701083922.97928-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend SCM_PIDFD test scenarios to also cover dead task's
pidfd retrieval and reading its exit info.

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
 1 file changed, 173 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index 7e534594167e..37e034874034 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include "../../pidfd/pidfd.h"
 #include "../../kselftest_harness.h"
 
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
@@ -26,6 +27,8 @@
 #define SCM_PIDFD 0x04
 #endif
 
+#define CHILD_EXIT_CODE_OK 123
+
 static void child_die()
 {
 	exit(1);
@@ -126,16 +129,65 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
 	return result;
 }
 
+struct cmsg_data {
+	struct ucred *ucred;
+	int *pidfd;
+};
+
+static int parse_cmsg(struct msghdr *msg, struct cmsg_data *res)
+{
+	struct cmsghdr *cmsg;
+	int data = 0;
+
+	if (msg->msg_flags & (MSG_TRUNC | MSG_CTRUNC)) {
+		log_err("recvmsg: truncated");
+		return 1;
+	}
+
+	for (cmsg = CMSG_FIRSTHDR(msg); cmsg != NULL;
+	     cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_PIDFD) {
+			if (cmsg->cmsg_len < sizeof(*res->pidfd)) {
+				log_err("CMSG parse: SCM_PIDFD wrong len");
+				return 1;
+			}
+
+			res->pidfd = (void *)CMSG_DATA(cmsg);
+		}
+
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_CREDENTIALS) {
+			if (cmsg->cmsg_len < sizeof(*res->ucred)) {
+				log_err("CMSG parse: SCM_CREDENTIALS wrong len");
+				return 1;
+			}
+
+			res->ucred = (void *)CMSG_DATA(cmsg);
+		}
+	}
+
+	if (!res->pidfd) {
+		log_err("CMSG parse: SCM_PIDFD not found");
+		return 1;
+	}
+
+	if (!res->ucred) {
+		log_err("CMSG parse: SCM_CREDENTIALS not found");
+		return 1;
+	}
+
+	return 0;
+}
+
 static int cmsg_check(int fd)
 {
 	struct msghdr msg = { 0 };
-	struct cmsghdr *cmsg;
+	struct cmsg_data res;
 	struct iovec iov;
-	struct ucred *ucred = NULL;
 	int data = 0;
 	char control[CMSG_SPACE(sizeof(struct ucred)) +
 		     CMSG_SPACE(sizeof(int))] = { 0 };
-	int *pidfd = NULL;
 	pid_t parent_pid;
 	int err;
 
@@ -158,53 +210,99 @@ static int cmsg_check(int fd)
 		return 1;
 	}
 
-	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
-	     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
-		if (cmsg->cmsg_level == SOL_SOCKET &&
-		    cmsg->cmsg_type == SCM_PIDFD) {
-			if (cmsg->cmsg_len < sizeof(*pidfd)) {
-				log_err("CMSG parse: SCM_PIDFD wrong len");
-				return 1;
-			}
+	/* send(pfd, "x", sizeof(char), 0) */
+	if (data != 'x') {
+		log_err("recvmsg: data corruption");
+		return 1;
+	}
 
-			pidfd = (void *)CMSG_DATA(cmsg);
-		}
+	if (parse_cmsg(&msg, &res)) {
+		log_err("CMSG parse: parse_cmsg() failed");
+		return 1;
+	}
 
-		if (cmsg->cmsg_level == SOL_SOCKET &&
-		    cmsg->cmsg_type == SCM_CREDENTIALS) {
-			if (cmsg->cmsg_len < sizeof(*ucred)) {
-				log_err("CMSG parse: SCM_CREDENTIALS wrong len");
-				return 1;
-			}
+	/* pidfd from SCM_PIDFD should point to the parent process PID */
+	parent_pid =
+		get_pid_from_fdinfo_file(*res.pidfd, "Pid:", sizeof("Pid:") - 1);
+	if (parent_pid != getppid()) {
+		log_err("wrong SCM_PIDFD %d != %d", parent_pid, getppid());
+		close(*res.pidfd);
+		return 1;
+	}
 
-			ucred = (void *)CMSG_DATA(cmsg);
-		}
+	close(*res.pidfd);
+	return 0;
+}
+
+static int cmsg_check_dead(int fd, int expected_pid)
+{
+	int err;
+	struct msghdr msg = { 0 };
+	struct cmsg_data res;
+	struct iovec iov;
+	int data = 0;
+	char control[CMSG_SPACE(sizeof(struct ucred)) +
+		     CMSG_SPACE(sizeof(int))] = { 0 };
+	pid_t client_pid;
+	struct pidfd_info info = {
+		.mask = PIDFD_INFO_EXIT,
+	};
+
+	iov.iov_base = &data;
+	iov.iov_len = sizeof(data);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	err = recvmsg(fd, &msg, 0);
+	if (err < 0) {
+		log_err("recvmsg");
+		return 1;
 	}
 
-	/* send(pfd, "x", sizeof(char), 0) */
-	if (data != 'x') {
+	if (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC)) {
+		log_err("recvmsg: truncated");
+		return 1;
+	}
+
+	/* send(cfd, "y", sizeof(char), 0) */
+	if (data != 'y') {
 		log_err("recvmsg: data corruption");
 		return 1;
 	}
 
-	if (!pidfd) {
-		log_err("CMSG parse: SCM_PIDFD not found");
+	if (parse_cmsg(&msg, &res)) {
+		log_err("CMSG parse: parse_cmsg() failed");
 		return 1;
 	}
 
-	if (!ucred) {
-		log_err("CMSG parse: SCM_CREDENTIALS not found");
+	/*
+	 * pidfd from SCM_PIDFD should point to the client_pid.
+	 * Let's read exit information and check if it's what
+	 * we expect to see.
+	 */
+	if (ioctl(*res.pidfd, PIDFD_GET_INFO, &info)) {
+		log_err("%s: ioctl(PIDFD_GET_INFO) failed", __func__);
+		close(*res.pidfd);
 		return 1;
 	}
 
-	/* pidfd from SCM_PIDFD should point to the parent process PID */
-	parent_pid =
-		get_pid_from_fdinfo_file(*pidfd, "Pid:", sizeof("Pid:") - 1);
-	if (parent_pid != getppid()) {
-		log_err("wrong SCM_PIDFD %d != %d", parent_pid, getppid());
+	if (!(info.mask & PIDFD_INFO_EXIT)) {
+		log_err("%s: No exit information from ioctl(PIDFD_GET_INFO)", __func__);
+		close(*res.pidfd);
 		return 1;
 	}
 
+	err = WIFEXITED(info.exit_code) ? WEXITSTATUS(info.exit_code) : 1;
+	if (err != CHILD_EXIT_CODE_OK) {
+		log_err("%s: wrong exit_code %d != %d", __func__, err, CHILD_EXIT_CODE_OK);
+		close(*res.pidfd);
+		return 1;
+	}
+
+	close(*res.pidfd);
 	return 0;
 }
 
@@ -291,6 +389,24 @@ static void fill_sockaddr(struct sock_addr *addr, bool abstract)
 	memcpy(sun_path_buf, addr->sock_name, strlen(addr->sock_name));
 }
 
+static int sk_enable_cred_pass(int sk)
+{
+	int on = 0;
+
+	on = 1;
+	if (setsockopt(sk, SOL_SOCKET, SO_PASSCRED, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSCRED");
+		return 1;
+	}
+
+	if (setsockopt(sk, SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSPIDFD");
+		return 1;
+	}
+
+	return 0;
+}
+
 static void client(FIXTURE_DATA(scm_pidfd) *self,
 		   const FIXTURE_VARIANT(scm_pidfd) *variant)
 {
@@ -299,7 +415,6 @@ static void client(FIXTURE_DATA(scm_pidfd) *self,
 	struct ucred peer_cred;
 	int peer_pidfd;
 	pid_t peer_pid;
-	int on = 0;
 
 	cfd = socket(AF_UNIX, variant->type, 0);
 	if (cfd < 0) {
@@ -322,14 +437,8 @@ static void client(FIXTURE_DATA(scm_pidfd) *self,
 		child_die();
 	}
 
-	on = 1;
-	if (setsockopt(cfd, SOL_SOCKET, SO_PASSCRED, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSCRED");
-		child_die();
-	}
-
-	if (setsockopt(cfd, SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSPIDFD");
+	if (sk_enable_cred_pass(cfd)) {
+		log_err("sk_enable_cred_pass() failed");
 		child_die();
 	}
 
@@ -340,6 +449,12 @@ static void client(FIXTURE_DATA(scm_pidfd) *self,
 		child_die();
 	}
 
+	/* send something to the parent so it can receive SCM_PIDFD too and validate it */
+	if (send(cfd, "y", sizeof(char), 0) == -1) {
+		log_err("Failed to send(cfd, \"y\", sizeof(char), 0)");
+		child_die();
+	}
+
 	/* skip further for SOCK_DGRAM as it's not applicable */
 	if (variant->type == SOCK_DGRAM)
 		return;
@@ -398,7 +513,13 @@ TEST_F(scm_pidfd, test)
 		close(self->server);
 		close(self->startup_pipe[0]);
 		client(self, variant);
-		exit(0);
+
+		/*
+		 * It's a bit unusual, but in case of success we return non-zero
+		 * exit code (CHILD_EXIT_CODE_OK) and then we expect to read it
+		 * from ioctl(PIDFD_GET_INFO) in cmsg_check_dead().
+		 */
+		exit(CHILD_EXIT_CODE_OK);
 	}
 	close(self->startup_pipe[1]);
 
@@ -421,9 +542,17 @@ TEST_F(scm_pidfd, test)
 		ASSERT_NE(-1, err);
 	}
 
-	close(pfd);
 	waitpid(self->client_pid, &child_status, 0);
-	ASSERT_EQ(0, WIFEXITED(child_status) ? WEXITSTATUS(child_status) : 1);
+	/* see comment before exit(CHILD_EXIT_CODE_OK) */
+	ASSERT_EQ(CHILD_EXIT_CODE_OK, WIFEXITED(child_status) ? WEXITSTATUS(child_status) : 1);
+
+	err = sk_enable_cred_pass(pfd);
+	ASSERT_EQ(0, err);
+
+	err = cmsg_check_dead(pfd, self->client_pid);
+	ASSERT_EQ(0, err);
+
+	close(pfd);
 }
 
 TEST_HARNESS_MAIN
-- 
2.43.0


