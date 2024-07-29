Return-Path: <linux-kselftest+bounces-14378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEF93F106
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D3CB20E28
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BCF140363;
	Mon, 29 Jul 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsjlZCaT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F80135A63;
	Mon, 29 Jul 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245138; cv=none; b=sMiXHYBm8kp2sPYy5r80TLg7mA2vLbBkioC3/FHHlUKQJn666UzFY4AmISyJ0LRM65AKwJx7ubYehI5bDwtloL28goHhQsNNkFUj6XkB9t760vqPmYFXW/gOFfrxSx4GM1H7CcTw4pCAOrSFjcyGOx5edB80tqMurI/j2sflONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245138; c=relaxed/simple;
	bh=GDXN/Px7sT3XLuGz2x/yVck36QUenL3LLygwRSBF8o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k00MOyQs0RIJfqAp1RticHrrMqAy4FxI92R4qgmBCwxN/KOmqA+uRZUWN1tyfLC3jaoeE8jE6MZ35AhsfjMypYwMv60nZAIRKDBhCMJA4TmjS+Sl871iB5wp/6R2Rx09trNTPcEnC+GdzBUfR1ntA9lDvG7rouxvKbuahE4cBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsjlZCaT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc6a017abdso15506935ad.0;
        Mon, 29 Jul 2024 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245135; x=1722849935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRvsG0Mnzi7FmdMnkPufWtMOmBcHwMKR25Zel1SkEgw=;
        b=YsjlZCaT2+seqFQma2UwWbQgi0MnAbH57/kvCc7spwlrDAEOdXkCkTb0jBMJUmc8tQ
         SYJXZtKb6L8IHvIvkoOpGXEeVdMZTUgWS1aOE5T/Ej3hYaLf7sHycy/8a1gADmHMzs8c
         qYjA/ngMKwBz+sA9DuQzBG/1eUGaPeYVO1SVMtssn6GrxYIwMcMNfmKHB2dgPsViKIPg
         F5kkZA+hkZ39Tmpzs8TIQf9nTFhYP/DB93iCRM5SI4lDyQSftZ33snk/dnHpx1kdk1qf
         z2V04yMG5hKIbnAW76YDGBicxmqcwgRSBBaEgRSynyswmsa4+C8xfIaUJGySPPehWmQX
         zTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245135; x=1722849935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRvsG0Mnzi7FmdMnkPufWtMOmBcHwMKR25Zel1SkEgw=;
        b=Ict8QzuIFzh0IuTH6gKz7Yo7ewo+TZtg4ChY+0LGqj9fLUcRSqoCofZ9f8AjJIXYVd
         4JcBXJn66tWSvsFASqAqIxkqe0hYsLewQw46BEiwV6XSya/OT4TOX2/Yk9ITumvrROuz
         ziX+l0tJgO8jJgF61wRrZ4eOE1Vlnx5fOggXpkQEFtmRqc9nft9T2BiQpeeeRyh7fUSc
         LBCXXubhsOSnvT2rduJb30FD7TH2ki/XL+FFuKFHdfaLl7ogZ+UG8y6jYZEIzurU39/b
         m6ldJC5U6hvl8taKNznZfAB3uGT8nYTDwUFMWd+10AGmPGqU50I8NQdiTFytTrjOycPa
         XOqg==
X-Forwarded-Encrypted: i=1; AJvYcCWwXDmh9bv6e1g5lQxjN7T2du7/xe3axvhUAODJNKLzosaVzIYSPBHCpxSWWv0g9lPNijWUw4nmYsICSQh2yngL2ck2GkMPmjyhGz24HBVoqpn/Vol6N5mIe+agL91QZEqfNKWLHUwF
X-Gm-Message-State: AOJu0YyEKoQwt/gRnNlUzl7+94+LdWqO6jKBOwdQC4VPImdEapnckzWk
	55ppfdGm9z8jYWGkdoGudvMK/UMLZ7OmUC3OcabQG6VXsA1vIzhOnSBWj0DC
X-Google-Smtp-Source: AGHT+IFLwa5khv/aHDVxMtQSVoU6DgS9rtncTw3VVOOCsh+a96EXefz+yMLUf4y1iipVpW9c7AvByg==
X-Received: by 2002:a17:903:1c1:b0:1fd:aac9:a72e with SMTP id d9443c01a7336-1ff0489f469mr65241195ad.43.1722245135501;
        Mon, 29 Jul 2024 02:25:35 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:25:35 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Fix error compiling tc_redirect.c with musl libc
Date: Mon, 29 Jul 2024 02:24:24 -0700
Message-Id: <031d656c058b4e55ceae56ef49c4e1729b5090f3.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722244708.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com> <cover.1722244708.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux 5.1 implemented 64-bit time types and related syscalls to address the
Y2038 problem generally across archs. Userspace handling of Y2038 varies
with the libc however. While musl libc uses 64-bit time across all 32-bit
and 64-bit platforms, GNU glibc uses 64-bit time on 64-bit platforms but
defaults to 32-bit time on 32-bit platforms unless they "opt-in" to 64-bit
time or explicitly use 64-bit syscalls and time structures.

One specific area is the standard setsockopt() call, SO_TIMESTAMPNS option
used for timestamping, and the related output 'struct timespec'. GNU glibc
defaults as above, also exposing the SO_TIMESTAMPNS_NEW flag to explicitly
use a 64-bit call and 'struct __kernel_timespec'. Since these are not
exposed or needed with musl libc, their use in tc_redirect.c leads to
compile errors building for mips64el/musl:

  tc_redirect.c: In function 'rcv_tstamp':
  tc_redirect.c:425:32: error: 'SO_TIMESTAMPNS_NEW' undeclared (first use in this function); did you mean 'SO_TIMESTAMPNS'?
    425 |             cmsg->cmsg_type == SO_TIMESTAMPNS_NEW)
        |                                ^~~~~~~~~~~~~~~~~~
        |                                SO_TIMESTAMPNS
  tc_redirect.c:425:32: note: each undeclared identifier is reported only once for each function it appears in
  tc_redirect.c: In function 'test_inet_dtime':
  tc_redirect.c:491:49: error: 'SO_TIMESTAMPNS_NEW' undeclared (first use in this function); did you mean 'SO_TIMESTAMPNS'?
    491 |         err = setsockopt(listen_fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
        |                                                 ^~~~~~~~~~~~~~~~~~
        |                                                 SO_TIMESTAMPNS

However, using SO_TIMESTAMPNS_NEW isn't strictly needed, nor is Y2038 being
explicitly tested. The timestamp checks in tc_redirect.c are simple: the
packet receive timestamp is non-zero and processed/handled in less than 5
seconds.

Switch to using the standard setsockopt() call and SO_TIMESTAMPNS option to
ensure compatibility across glibc and musl libc. In the worst-case, there
is a 5-second window 14 years from now where tc_redirect tests may fail on
32-bit systems. However, we should reasonably expect glibc to adopt a
64-bit mandate rather than the current "opt-in" policy before the Y2038
roll-over.

Fixes: ce6f6cffaeaa ("selftests/bpf: Wait for the netstamp_needed_key static key to be turned on")
Fixes: c803475fd8dd ("bpf: selftests: test skb->tstamp in redirect_neigh")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 327d51f59142..53b8ffc943dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -471,7 +471,7 @@ static int set_forwarding(bool enable)
 
 static int __rcv_tstamp(int fd, const char *expected, size_t s, __u64 *tstamp)
 {
-	struct __kernel_timespec pkt_ts = {};
+	struct timespec pkt_ts = {};
 	char ctl[CMSG_SPACE(sizeof(pkt_ts))];
 	struct timespec now_ts;
 	struct msghdr msg = {};
@@ -495,7 +495,7 @@ static int __rcv_tstamp(int fd, const char *expected, size_t s, __u64 *tstamp)
 
 	cmsg = CMSG_FIRSTHDR(&msg);
 	if (cmsg && cmsg->cmsg_level == SOL_SOCKET &&
-	    cmsg->cmsg_type == SO_TIMESTAMPNS_NEW)
+	    cmsg->cmsg_type == SO_TIMESTAMPNS)
 		memcpy(&pkt_ts, CMSG_DATA(cmsg), sizeof(pkt_ts));
 
 	pkt_ns = pkt_ts.tv_sec * NSEC_PER_SEC + pkt_ts.tv_nsec;
@@ -537,9 +537,9 @@ static int wait_netstamp_needed_key(void)
 	if (!ASSERT_GE(srv_fd, 0, "start_server"))
 		goto done;
 
-	err = setsockopt(srv_fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+	err = setsockopt(srv_fd, SOL_SOCKET, SO_TIMESTAMPNS,
 			 &opt, sizeof(opt));
-	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS_NEW)"))
+	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS)"))
 		goto done;
 
 	cli_fd = connect_to_fd(srv_fd, TIMEOUT_MILLIS);
@@ -621,9 +621,9 @@ static void test_inet_dtime(int family, int type, const char *addr, __u16 port)
 		return;
 
 	/* Ensure the kernel puts the (rcv) timestamp for all skb */
-	err = setsockopt(listen_fd, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+	err = setsockopt(listen_fd, SOL_SOCKET, SO_TIMESTAMPNS,
 			 &opt, sizeof(opt));
-	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS_NEW)"))
+	if (!ASSERT_OK(err, "setsockopt(SO_TIMESTAMPNS)"))
 		goto done;
 
 	if (type == SOCK_STREAM) {
-- 
2.34.1


