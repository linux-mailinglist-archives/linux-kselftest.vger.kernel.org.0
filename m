Return-Path: <linux-kselftest+bounces-14223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A097793C01F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199F61F22171
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873051990D7;
	Thu, 25 Jul 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Vr8XWE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3E198E88;
	Thu, 25 Jul 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903984; cv=none; b=ANJhDjkxTpc4B/VcWDF0QkSMKi6gFWRT8GyqnbAnlG+C/L217S4THdtsyPXrx7+B2mF/FTqY/q+2AQLlOUfLezNahU7ASKNN6AYmuglyHCKNbMeryKUJOtfqZiZkP9syJ8fqHyQPcRha/PWp6TBOLsDQbwWgRf4T53MQAc4cCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903984; c=relaxed/simple;
	bh=vqWRPZxXZr1VXaBlAPOEaWlSc5Dw8PsBqeRFINNfCZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mNk3WPBIHUsdCkl5M9pkW80Ne8mQESySMD1g5Hzu8yOqA2Y0hLvSVzW8LCqKaOu2wJfDAtlBzp/nSpR7DnxVLgsOK94arcDYmQOoC3JNQ8hvWJC4PYHTwSMilwjFsvuxvkISJBw3vlnUDgWbf8GW/EdzUdPFpSXhAfceXYbmtQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Vr8XWE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc49c0aaffso5862985ad.3;
        Thu, 25 Jul 2024 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903982; x=1722508782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jABdSH5QlIuuR/rILejtAmyHlYiiAj61Ro1QLo3FSvI=;
        b=U1Vr8XWESjG1nBMQLMiVQxqo81E3b30pYB9lLHJD6nF6fUp+NO6s84yDH7T9snTV2S
         SDDVlib3kk6Dh4kbS0b2dLRzRbPvkN5CYeboChOMeRDBF4X/IbhwoFuk4OFL+eED/3WW
         XwmHX/Wik4KZJdhwSI4QFh9jI8uRafq0ttw2F0dk9gFB1h9g7T+pudbSoks9WDnJrm8D
         3JcBicEDWW0TG07Vz99oeC5gFdgyJmkb1/UwmYLj5QldD3/MxthfIVDDeXS/ZnLHSnj0
         lGMYlin83gvkvKN3E/9K/jf5YKg+bU+zdWM3f2OemWw7mfPwNvv+PD6O9X+hlxkfpx/5
         qv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903982; x=1722508782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jABdSH5QlIuuR/rILejtAmyHlYiiAj61Ro1QLo3FSvI=;
        b=hzh3p8iaensTEdxJt70ihtxSkXXTs6Foya1UiK13r4LwYVo7lIB4dux7ADUhqE4RTC
         IdYtvDPhSzQezWlqzzH/1y/dJ4URn/6zmC8Idb9qL0Zww/J8tbDeTRFO60ih4+C676XZ
         uVxx6tpiBGqQHY8m1aBFu6Y1xMboKw85XNfruqjjh09+po6I7BAKcnEWVOD5TgbS4EKK
         mtfuZOg4//gCjD2FTc4jWjgJRIDEhj88Zi2zXJk1cnWatlEOZ6+ZKThi9prnM+53oO5T
         a2y5kZpIUUWxNZn+fmsYxduE8gtcrsIot1lI+zJZCIZHnZOvMv/HQwVs6jYSNiEVbfgR
         CMCA==
X-Forwarded-Encrypted: i=1; AJvYcCXy0XliRx1gSItH03c47j2SfZEcYN/FtuTux8YyCeZ7dlvCQGKDTVVogeDylgYiUvy+oQVLQFe/+MsNxfUnoHtVjFZwpyzwAaYi2C03oumdB3w+HHScU2eX//xpj+w9O2i7Bf2uR/zr
X-Gm-Message-State: AOJu0Ywly+glrEBqgqslLgSwu5JY94mni8rpR7jdlmjklORVVPY3E62Y
	qUJtUT+Kni9CatkSZ3QRYFAoy5TBQxTLUrN0OJmbCeJGe6PXjnH6VBoDJm4h
X-Google-Smtp-Source: AGHT+IHM/iy3oTk9jcUWwFLWMu5qhksN0SWwCn+FsQdEito6OPiJkIz7QTPIOK4gtgl94neCWiJpEg==
X-Received: by 2002:a17:902:c941:b0:1fd:709a:2978 with SMTP id d9443c01a7336-1fed92753e8mr15190155ad.38.1721903981809;
        Thu, 25 Jul 2024 03:39:41 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:41 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v1 8/8] selftests/bpf: Fix error compiling tc_redirect.c with musl libc
Date: Thu, 25 Jul 2024 03:36:00 -0700
Message-Id: <f4756c5cd526b2943b76ced76544c8129c361eea.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

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


