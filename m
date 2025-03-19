Return-Path: <linux-kselftest+bounces-29402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BDA68158
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 01:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129F51893A29
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 00:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6E11D6DBC;
	Wed, 19 Mar 2025 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vYT0YI/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1621CEADB
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343356; cv=none; b=l+zzAs+R1FMvMoqou8yNgEmZXzwjeUSIa38dL9ytfMOhCosXSDeX0uubK59q3nAR9dG4jLj6cZRkP0Y1RQAYZIGcTt3DM5ammYYK5FKDGo3V7Wn6VyYud6oA6w4V28AYf6J9/AbJZyWYWH6VRtHVCDhnWl+YCnsl+YBSOb3kcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343356; c=relaxed/simple;
	bh=l6eI5FceV5Cykwuzpt3OkcP+LeKArrcDOklFOAM4Tzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq5jxK7V8TnxCqe+69FKOSxFfFELXPapYVIO4FCiljh8sNGBlRRVf0gIya1TNw1I8sWvD7R+I2Pgbu9o4CIEd7y3DoPv5oQvhSuI3bJxFmQN+UZBW6tjIlaEjfdm1G9LEeWnSQ19cSZrwC1Y16r3PWADpjP74e9pDLXBS5ntWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vYT0YI/q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224100e9a5cso121496755ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 17:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343353; x=1742948153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCjuaqhwOiDHFc+loZsxbFlVswHaNNd+fRkOYDgDDk0=;
        b=vYT0YI/qIAMQv3nwASjjKB0WzkosloZq27M6ZaOiU5+It2z5k7Ckq1fd8arWHQ05i3
         wxR1l1GQrwWKjpIlNNTBNYB2rEzDuaQJgbUfW/2mHQsbksSmYmMTVPYFOmI7E5UQKA1C
         xYAsqpUnAZ9BU3ZJQJTRdY0g5RYiuHIfb6Iqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343353; x=1742948153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCjuaqhwOiDHFc+loZsxbFlVswHaNNd+fRkOYDgDDk0=;
        b=F6rnNbuCIGRFMzakejz3uDg/Lc8OWZGjz6tWQNQkUemYsnPYK+KHuX15XYObqcvRKc
         uhiYBw1XZ59VwzHXkLMekHWCAwQBY9HmSvYSn43PewWj0BfH7lxDratZt1QBrC2JAYtY
         VEy9UWEsVe3otmbDudn+JW82WOU5X79fR2HEeXTvfVrzyg2Y0mLotgWUrCOlzpCiIh9/
         6yt1DTDRsQL9WPxk4MYwFgXCHtOIdzghMampgRVwowQM+VIS7UIKbOktDaiJNIOuIiCO
         Ao+C3Q0yAmrT3/ghCP5FEc8mpcK9NkiODEoNpdI225qaQ1BTQDuy5BArmfg/ARPTAaSX
         wQrg==
X-Forwarded-Encrypted: i=1; AJvYcCVGNgDNcMD/RIeDfEv0ZcL6NVMzJCtJvrl23khnNSMtBzabtYx7fT/24nsdnrSPXw4bOanHElVAPXThVvo2cKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdVTje4Lb09wbL4B7SGi2GDiInAF6Jcn4HqjUyKQGN3TgsvcV
	kAAIoSkdtkS6rcCqu6owCGYvCchClBHS44zzGrVVM+4KHXNSaiWfryJEL1aZ844=
X-Gm-Gg: ASbGncsaGNUUSSIe1a7rrxRo/fFdH02X4von+9tG75C7CYmnwXaVULAdWgsyUqCy135
	sKtGfeLr6GDwiH1JXiejsUvPuA45iPwddNLMdqIqaQCkMoi3g6kPEFaGy066zsX5Fkts4vZup9z
	ek9AfAmzDhdUMqGhPbV39js3IoDkkkCK0O37+SLfg5i9NxYr8y91WOOnHEjzmgagnpAc0qouMNu
	jUKPaGGRUNjsLtztnxqcaMpHMCmAX+A0DeYk666Uzlay+gwNs0rpY1q9C1usaqKjz8VH4HsJaXm
	rHS7cRXNTj7XLf2IAXMmL0hab707/0Hn6ZYyMIex2JuCz49Qxx60DxjPlb/vDaI=
X-Google-Smtp-Source: AGHT+IGyJJUfiVi7domxxVJWnLd5oPGvI2NnmEftJelHGqwd1vZMeJiUnL793ZEEGGeMZjX9WP3DFw==
X-Received: by 2002:a17:902:f60d:b0:223:3b76:4e22 with SMTP id d9443c01a7336-2264980c773mr9656025ad.6.1742343353358;
        Tue, 18 Mar 2025 17:15:53 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:52 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 10/10] selftests: Add sendfile zerocopy notification test
Date: Wed, 19 Mar 2025 00:15:21 +0000
Message-ID: <20250319001521.53249-11-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the existing the msg_zerocopy test to allow testing sendfile to
ensure that notifications are generated.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 54 ++++++++++++++++++++-
 tools/testing/selftests/net/msg_zerocopy.sh |  5 ++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 7ea5fb28c93d..20e334b25fbd 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -30,6 +30,7 @@
 #include <arpa/inet.h>
 #include <error.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <limits.h>
 #include <linux/errqueue.h>
 #include <linux/if_packet.h>
@@ -50,6 +51,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/sendfile.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/time.h>
@@ -74,6 +76,14 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+#ifndef SENDFILE_ZC
+#define SENDFILE_ZC (0x2)
+#endif
+
+#ifndef __NR_sendfile2
+#define __NR_sendfile2 467
+#endif
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -87,6 +97,8 @@ static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
 static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
+static bool cfg_sendfile;
+static const char *cfg_sendfile_path;
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
@@ -182,6 +194,37 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
+static bool do_sendfile(int fd)
+{
+	int from_fd = open(cfg_sendfile_path, O_RDONLY, 0);
+	struct stat buf;
+	ssize_t total = 0;
+	ssize_t ret = 0;
+	off_t off = 0;
+
+	if (fd < 0)
+		error(1, errno, "couldn't open sendfile path");
+
+	if (fstat(from_fd, &buf))
+		error(1, errno, "couldn't fstat");
+
+	while (total < buf.st_size) {
+		ret = syscall(__NR_sendfile2, fd, from_fd, &off, buf.st_size,
+			      SENDFILE_ZC);
+		if (ret < 0)
+			error(1, errno, "unable to sendfile");
+		total += ret;
+		sends_since_notify++;
+		bytes += ret;
+		packets++;
+		if (ret > 0)
+			expected_completions++;
+	}
+
+	close(from_fd);
+	return total == buf.st_size;
+}
+
 static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
@@ -550,6 +593,8 @@ static void do_tx(int domain, int type, int protocol)
 	do {
 		if (cfg_cork)
 			do_sendmsg_corked(fd, &msg);
+		else if (cfg_sendfile)
+			do_sendfile(fd);
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
@@ -715,7 +760,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vzf:w:")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -767,9 +812,16 @@ static void parse_opts(int argc, char **argv)
 		case 'v':
 			cfg_verbose++;
 			break;
+		case 'f':
+			cfg_sendfile = true;
+			cfg_sendfile_path = optarg;
+			break;
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		case 'w':
+			cfg_waittime_ms = 200 + strtoul(optarg, NULL, 10) * 1000;
+			break;
 		}
 	}
 
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 89c22f5320e0..c735e4ab86b5 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -74,6 +74,7 @@ esac
 cleanup() {
 	ip netns del "${NS2}"
 	ip netns del "${NS1}"
+	rm -f sendfile_data
 }
 
 trap cleanup EXIT
@@ -106,6 +107,9 @@ ip -netns "${NS2}" addr add       fd::2/64 dev "${DEV}" nodad
 # Optionally disable sg or csum offload to test edge cases
 # ip netns exec "${NS1}" ethtool -K "${DEV}" sg off
 
+# create sendfile test data
+dd if=/dev/zero of=sendfile_data bs=1M count=8 2> /dev/null
+
 do_test() {
 	local readonly ARGS="$1"
 
@@ -118,4 +122,5 @@ do_test() {
 
 do_test "${EXTRA_ARGS}"
 do_test "-z ${EXTRA_ARGS}"
+do_test "-z -f sendfile_data ${EXTRA_ARGS}"
 echo ok
-- 
2.43.0


