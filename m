Return-Path: <linux-kselftest+bounces-36486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04301AF8356
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 00:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67B87AEBC1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 22:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF102D0C89;
	Thu,  3 Jul 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dTzItRc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D052BFC7F
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581443; cv=none; b=e73tdMSF3ar7F7oQX8QFqGefVBiR4svglxTlG475SYRDxqdSkQSz45rAkwB8YauKuLRA2npZRA3QE9hTkAzvzXfvTR7WZGK487gvQaT7AaCD7WeyWvER97iFy33RvtWbNMsN675dFRb42zi1DYHV7R2EhmuyK/JNhK8JMng75ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581443; c=relaxed/simple;
	bh=sNMgYuRRHDM5tU1JOzxhsMgU93et6+sqxnzyafhvyOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abyLCr1eHvequ4v4+YNiisaMH49KrV2q+q7rNUKEtX9JnDqxBMKcqzjm6W+LqgG4ZXJhaCaPX+FpZYCEfvXyMQ6ZzqC9Y0VYxK3zUpgtmRtyqVAZdXvzUxhXz3Sg1M9D7wShn39InH6GUDRW4mRuSXQuTZlEPUTQyo1PrSKyyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dTzItRc3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 464B93F66E
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581440;
	bh=3ACJj1pibTp1hDCcnssHwfTz2N2iBLhUH85nRukXflM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=dTzItRc3tRWZ9WyvPDeZydhCj7MteCnozbLvi+ROMIhfTG/BTlGy/JlZZqAnFjMre
	 cyBSESbJNotX/MyyO1yW0vQzIQgAKFh1u8iMC2ZdnPOKXYcE+7tmWTyzUqYGiJ7IT/
	 JRK//QOSW6jHoXeDCq1fWd71GNyWxYaqRyDt8WCU1vbj4weFRHii0NcDh+2GMrV5M2
	 lbMZLtBtpFULVbyoTsQ+Rls5iTMxE6ZiF5/jMm6zThVlWXrEBNKKH5Q6NBTdkRYLp9
	 b38dAEMUCWVPYZVhkppw6nuvjrhP0JdadsipDiiPHpNDUQ8/QPrx0mBFLC3zf3tqYi
	 78/KrgUsMEtWw==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6076ad0b2f1so243275a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 15:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581438; x=1752186238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ACJj1pibTp1hDCcnssHwfTz2N2iBLhUH85nRukXflM=;
        b=CqHDtyomqXjMaUlz6BVD8cDPLeuuZxPGlugvUDPGCnzmxiNryXzH4zwQkeiP3ePJMQ
         F6tDSJ4zZ8F0sFmbpYH8IOepa7j4nD+BraRprWeILyBFZbc1rcaY8IPSEK6iT6c8hcjq
         H8hVCNapkgxpVv43RcwvHbeVzcn8Sp8pXMRUMDXONP1RRM5d/hE1fVeZ7awFp+Za0Fa9
         1BVSqK4ux3mtxpd17Iqn4rzVXXX9gNo0Thal6v9l9Ihfn/WAiHxXCufMjakzWzxc1vNV
         JuL23zDKHUvJKNqqTLVM+JVw+5tA1ys0T1rDuJINmsQPMEwGjhAOOendfPwG5uH44/k6
         uyVw==
X-Forwarded-Encrypted: i=1; AJvYcCWx1rULPem34WtIFE/IS60M7sZ+LS4lsqc3li4oJUvJPtBk/NurLcfKuLZrPkTg+RXYrW68bPlhv28yD/u5w5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYGyThuGWZbz5ku8ogaA7qs68HPVS03Zl7tVR6O0zWEsm4Wd4
	A1ylydViTt18TF0Y35CA/N47tAjkmQ91LPuWhDQRDs74THOjj5MIaPR9pKYNtROCM3Y70Bfmzrz
	rG+0DsqoEj/pxtmPbt/3Nib0pDcAn/+ay1473eq6sl1fPNSqnxMvLBADRrArD/7TCCUlcSlnJyl
	QnytihPtAyZg==
X-Gm-Gg: ASbGncspii7qKpO3wps7Blm3Y0obxNHHIw77bbNcNaipfJjipuWwrh9HMML3lnLB1me
	CJGJzpQkrfph40kYH2PCfv4VIOeTBKKyxmKlCD6bva1JQocymdPfILUENgg70GB5Q391HHk5Goq
	Ah+Sc74hKqQljkej76QA0X7MNjpk7IKuzV5l4qPAQR71hRI2nYVqONgbJK5FW3nfeFOyHHqQ+lM
	KHvrceZA3E6z153YTf4P8+YcRjgr80hwOLAM4q4Om8Re+3M1gQxSlho3K/0K+bsRE6LFBDF46Vy
	A5712vK7Eurq+rXEXCttDQk+bPsvhcs2O44gjm1wQGwsY77JKg==
X-Received: by 2002:a05:6402:1e8f:b0:609:b263:41d3 with SMTP id 4fb4d7f45d1cf-60fd35ccd36mr251531a12.32.1751581437566;
        Thu, 03 Jul 2025 15:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGlaGtUtTk/shaqKHwURRpox5xAWe2POPldC6erKPQZ/gqhODJsBfGMjz4VC064N+v+5R1VQ==
X-Received: by 2002:a05:6402:1e8f:b0:609:b263:41d3 with SMTP id 4fb4d7f45d1cf-60fd35ccd36mr251502a12.32.1751581437110;
        Thu, 03 Jul 2025 15:23:57 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:56 -0700 (PDT)
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
Subject: [PATCH net-next v3 7/7] selftests: net: extend SCM_PIDFD test to cover stale pidfds
Date: Fri,  4 Jul 2025 00:23:11 +0200
Message-ID: <20250703222314.309967-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
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


