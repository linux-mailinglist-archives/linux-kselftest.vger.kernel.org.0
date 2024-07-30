Return-Path: <linux-kselftest+bounces-14488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F169941FE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 20:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6213A1C23580
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB2C1AA3E3;
	Tue, 30 Jul 2024 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hXeM36iD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D718A6D4
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364918; cv=none; b=hP3E219SNO+I6znww8TG199ucYGvQZJerrSpuzfWAgTlwZ3d9jaFoWZ0rgEjjMAKaOzJ9VWTshQnEwbHKgh640ASa+3SICGG8UKwGhY1wpIM0g9o5uB4ETuHmIwGPOHlVrFPYzZaQD2BiIVpnFdidihAgMJM603B7joDW30PyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364918; c=relaxed/simple;
	bh=eVwjcXh08v/BloRCWi+Au5NPRXGgBtqnMqSrhA86WPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+EoB7gYiu93A776oqKBBpOnaLbgNqhtJj0e6pROJYv7DdThi04BOrqA/V+jCGrO/AhOJt83r9bMjBBY9+NvDzkoMQgge7HM9PXbBxKyjcyThbmdm1Eyje6q4Lz/T6aCyNHWClZmN02W0UYy/wSLFUD61sOkBfMS/I777MQ5ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hXeM36iD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a8cada97so24438076d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722364916; x=1722969716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFMubqDRuXqmoPI75vXrJ4qmre3+FeuST3BNycNrURg=;
        b=hXeM36iD6OHIsil52wi4n4FE7dcH7zsMPiZ52xBq1wkrJ9bR9xcA2JXbKrb1Qs/Bhe
         Sg+W9KcYrRGs/cSbbm7sM2Yeeuj8rKg7bs8FKl2PSthrEEPsHKRsy0whzDjlpb+bQk7H
         qTWZmXRUQl5YiYhQPWr6R22sXQTgHrfRmrxC52AejtOJbCQGECA1JoF0snwkdGvxc6MY
         j9/wi9ukXD9NnBUwKsZDYqvEf+GCfGWBKGo0bdjFBUIHoNkYXsLs6kB1m7Reo22TGmeg
         kL/YotP9qHGB8OBwEXZnQLuO77mydYYqnBClkoV0NF4PqmVOCTSFh4VQe4fEANnAzgTa
         IQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364916; x=1722969716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFMubqDRuXqmoPI75vXrJ4qmre3+FeuST3BNycNrURg=;
        b=g9V9dQOG8jiw5ECUWMkvXCqbM121ZFCv2oyjB0qEI27Vb2dpQAgZRzqsjHkks6QYb4
         JOGdFW7O+8rdOxwjHQpbJeNLFrf7Qn7dUPlgHDMiH6kU0CaIkuT8gujGXuqpG1OYI7bz
         vGQyPGTSpXKLYCsKoeFwN8Of9fvszAL8PJ5LuMfxThXcYWF/8fOmEciXtWRTGGVmLjN5
         PwvZ17LKgfOtEIv5R/rtYHNg/P9If53U+KAovmtwb/k5jrV/aqNAP3axVNUInwa4Bica
         a3EeQYrQF7BVrljVrcl1dXHjX2ff96vIEsZ8vDxYr0zXS5kORJ+7GNAO3zsuX19W5xgV
         rS6A==
X-Forwarded-Encrypted: i=1; AJvYcCWZk3tRMKkVr/prJm//S0u+59jK7bib0hcRXYIX8KrCMMstxOVg+tLB2pHX0fManVJYTQIrQH8Kna/9wfbkhCWMuGQCAzqN+BKI953z0bnf
X-Gm-Message-State: AOJu0Yx1Oh+tN0S6x9/PewNFT8YtpKreD9YZU10yx7u08AFv5z7kYWAp
	mezSlj6OmhT5j67FRxhTKkPuPESAfSj5lMtRBvY/DiqlSFnbjQZ9Yia/vXZ3FKc=
X-Google-Smtp-Source: AGHT+IGqMyyvOhsKtdiERws+A5taOq1D0dtDaWZ6YlDnhO029w/RAeUiX/89Qw+mJRbm+r6IQGTcBg==
X-Received: by 2002:a05:6214:dc6:b0:6b5:434:cc86 with SMTP id 6a1803df08f44-6bb559f9338mr224388956d6.10.1722364915909;
        Tue, 30 Jul 2024 11:41:55 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb07bf7sm66132716d6.137.2024.07.30.11.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:41:54 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	almasrymina@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	axboe@kernel.dk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v8 3/3] selftests: add MSG_ZEROCOPY msg_control notification test
Date: Tue, 30 Jul 2024 18:41:20 +0000
Message-Id: <20240730184120.4089835-4-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240730184120.4089835-1-zijianzhang@bytedance.com>
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We update selftests/net/msg_zerocopy.c to accommodate the new mechanism,
cfg_notification_limit has the same semantics for both methods. Test
results are as follows, we update skb_orphan_frags_rx to the same as
skb_orphan_frags to support zerocopy in the localhost test.

cfg_notification_limit = 1, both method get notifications after 1 calling
of sendmsg. In this case, the new method has around 17% cpu savings in TCP
and 23% cpu savings in UDP.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 7523    | 7706    | 7489    | 7304    |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 8834    | 8993    | 9053    | 9228    |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 117.42% | 116.70% | 120.88% | 126.34% |
+---------------------+---------+---------+---------+---------+

cfg_notification_limit = 32, both get notifications after 32 calling of
sendmsg, which means more chances to coalesce notifications, and less
overhead of poll + recvmsg for the original method. In this case, the new
method has around 7% cpu savings in TCP and slightly better cpu usage in
UDP. In the env of selftest, notifications of TCP are more likely to be
out of order than UDP, it's easier to coalesce more notifications in UDP.
The original method can get one notification with range of 32 in a recvmsg
most of the time. In TCP, most notifications' range is around 2, so the
original method needs around 16 recvmsgs to get notified in one round.
That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here.
+---------------------+---------+---------+---------+---------+
| Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
+---------------------+---------+---------+---------+---------+
| ZCopy (MB)          | 8842    | 8735    | 10072   | 9380    |
+---------------------+---------+---------+---------+---------+
| New ZCopy (MB)      | 9366    | 9477    | 10108   | 9385    |
+---------------------+---------+---------+---------+---------+
| New ZCopy / ZCopy   | 106.00% | 108.28% | 100.31% | 100.01% |
+---------------------+---------+---------+---------+---------+

In conclusion, when notification interval is small or notifications are
hard to be coalesced, the new mechanism is highly recommended. Otherwise,
the performance gain from the new mechanism is very limited.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 101 ++++++++++++++++++--
 tools/testing/selftests/net/msg_zerocopy.sh |   1 +
 2 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 7ea5fb28c93d..cf227f0011b5 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -66,6 +66,10 @@
 #define SO_ZEROCOPY	60
 #endif
 
+#ifndef SCM_ZC_NOTIFICATION
+#define SCM_ZC_NOTIFICATION	78
+#endif
+
 #ifndef SO_EE_CODE_ZEROCOPY_COPIED
 #define SO_EE_CODE_ZEROCOPY_COPIED	1
 #endif
@@ -74,6 +78,14 @@
 #define MSG_ZEROCOPY	0x4000000
 #endif
 
+#define ZC_INFO_ARR_SIZE (ZC_NOTIFICATION_MAX * sizeof(struct zc_info_elem))
+#define ZC_INFO_SIZE	(sizeof(struct zc_info) + ZC_INFO_ARR_SIZE)
+
+enum notification_type {
+	MSG_ZEROCOPY_NOTIFY_ERRQUEUE = 1,
+	MSG_ZEROCOPY_NOTIFY_SENDMSG = 2,
+};
+
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
@@ -86,7 +98,7 @@ static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
 static int  cfg_notification_limit = 32;
-static bool cfg_zerocopy;
+static enum notification_type cfg_zerocopy;
 
 static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
@@ -97,6 +109,8 @@ static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
 static uint32_t sends_since_notify;
+static char	zc_ckbuf[CMSG_SPACE(ZC_INFO_SIZE)];
+static bool	added_zcopy_info;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -182,7 +196,26 @@ static void add_zcopy_cookie(struct msghdr *msg, uint32_t cookie)
 	memcpy(CMSG_DATA(cm), &cookie, sizeof(cookie));
 }
 
-static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
+static void add_zcopy_info(struct msghdr *msg)
+{
+	struct zc_info *zc_info;
+	struct cmsghdr *cm;
+
+	if (!msg->msg_control)
+		error(1, errno, "NULL user arg");
+	cm = (struct cmsghdr *)msg->msg_control;
+	cm->cmsg_len = CMSG_LEN(ZC_INFO_SIZE);
+	cm->cmsg_level = SOL_SOCKET;
+	cm->cmsg_type = SCM_ZC_NOTIFICATION;
+
+	zc_info = (struct zc_info *)CMSG_DATA(cm);
+	zc_info->size = ZC_NOTIFICATION_MAX;
+
+	added_zcopy_info = true;
+}
+
+static bool do_sendmsg(int fd, struct msghdr *msg,
+		       enum notification_type do_zerocopy, int domain)
 {
 	int ret, len, i, flags;
 	static uint32_t cookie;
@@ -200,6 +233,12 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 			msg->msg_controllen = CMSG_SPACE(sizeof(cookie));
 			msg->msg_control = (struct cmsghdr *)ckbuf;
 			add_zcopy_cookie(msg, ++cookie);
+		} else if (do_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
+			   sends_since_notify + 1 >= cfg_notification_limit) {
+			memset(&msg->msg_control, 0, sizeof(msg->msg_control));
+			msg->msg_controllen = CMSG_SPACE(ZC_INFO_SIZE);
+			msg->msg_control = (struct cmsghdr *)zc_ckbuf;
+			add_zcopy_info(msg);
 		}
 	}
 
@@ -218,7 +257,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		if (do_zerocopy && ret)
 			expected_completions++;
 	}
-	if (do_zerocopy && domain == PF_RDS) {
+	if (msg->msg_control) {
 		msg->msg_control = NULL;
 		msg->msg_controllen = 0;
 	}
@@ -466,6 +505,44 @@ static void do_recv_completions(int fd, int domain)
 	sends_since_notify = 0;
 }
 
+static void do_recv_completions2(void)
+{
+	struct cmsghdr *cm = (struct cmsghdr *)zc_ckbuf;
+	struct zc_info *zc_info;
+	__u32 hi, lo, range;
+	__u8 zerocopy;
+	int i;
+
+	zc_info = (struct zc_info *)CMSG_DATA(cm);
+	for (i = 0; i < zc_info->size; i++) {
+		hi = zc_info->arr[i].hi;
+		lo = zc_info->arr[i].lo;
+		zerocopy = zc_info->arr[i].zerocopy;
+		range = hi - lo + 1;
+
+		if (cfg_verbose && lo != next_completion)
+			fprintf(stderr, "gap: %u..%u does not append to %u\n",
+				lo, hi, next_completion);
+		next_completion = hi + 1;
+
+		if (zerocopied == -1) {
+			zerocopied = zerocopy;
+		} else if (zerocopied != zerocopy) {
+			fprintf(stderr, "serr: inconsistent\n");
+			zerocopied = zerocopy;
+		}
+
+		completions += range;
+		sends_since_notify -= range;
+
+		if (cfg_verbose >= 2)
+			fprintf(stderr, "completed: %u (h=%u l=%u)\n",
+				range, hi, lo);
+	}
+
+	added_zcopy_info = false;
+}
+
 /* Wait for all remaining completions on the errqueue */
 static void do_recv_remaining_completions(int fd, int domain)
 {
@@ -553,11 +630,16 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
-		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE &&
+		    sends_since_notify >= cfg_notification_limit)
 			do_recv_completions(fd, domain);
 
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG &&
+		    added_zcopy_info)
+			do_recv_completions2();
+
 		while (!do_poll(fd, POLLOUT)) {
-			if (cfg_zerocopy)
+			if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_ERRQUEUE)
 				do_recv_completions(fd, domain);
 		}
 
@@ -715,7 +797,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mnp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -749,6 +831,9 @@ static void parse_opts(int argc, char **argv)
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
+		case 'n':
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_SENDMSG;
+			break;
 		case 'p':
 			cfg_port = strtoul(optarg, NULL, 0);
 			break;
@@ -768,7 +853,7 @@ static void parse_opts(int argc, char **argv)
 			cfg_verbose++;
 			break;
 		case 'z':
-			cfg_zerocopy = true;
+			cfg_zerocopy = MSG_ZEROCOPY_NOTIFY_ERRQUEUE;
 			break;
 		}
 	}
@@ -779,6 +864,8 @@ static void parse_opts(int argc, char **argv)
 			error(1, 0, "-D <server addr> required for PF_RDS\n");
 		if (!cfg_rx && !saddr)
 			error(1, 0, "-S <client addr> required for PF_RDS\n");
+		if (cfg_zerocopy == MSG_ZEROCOPY_NOTIFY_SENDMSG)
+			error(1, 0, "PF_RDS does not support ZC_NOTIF_SENDMSG");
 	}
 	setup_sockaddr(cfg_family, daddr, &cfg_dst_addr);
 	setup_sockaddr(cfg_family, saddr, &cfg_src_addr);
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 89c22f5320e0..022a6936d86f 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -118,4 +118,5 @@ do_test() {
 
 do_test "${EXTRA_ARGS}"
 do_test "-z ${EXTRA_ARGS}"
+do_test "-n ${EXTRA_ARGS}"
 echo ok
-- 
2.20.1


