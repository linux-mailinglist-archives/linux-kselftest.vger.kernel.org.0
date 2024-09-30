Return-Path: <linux-kselftest+bounces-18702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73898B13F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 01:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1D3282A61
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 23:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DF186E33;
	Mon, 30 Sep 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5yxE/fh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8E2C1B4;
	Mon, 30 Sep 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740778; cv=none; b=TYDqnuASONInZUgYAmVIxC3lu0K6+0Sdq/A6yvwV/s1BM1rr+sxE9XCPxSqzxZwmIqvBElH+DxJj60hz5FLwBaC6eT8RtSeIPScQozc/3lWrmoDe15nOrAXWu/xlNos3SE05QFficbCxU1wjBIT9YoVO3MCmSlrZC6J/0WppT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740778; c=relaxed/simple;
	bh=bHJTfIv/bQKEaDRRNzyllEiHmX2BmrRj0mXBc5jpiMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfzypiRkN8xEdNQKl1ZTM1a+jQLwshmCSkLynBXkdYNnqgOT2Y82MEhuDzyINp1Ct5jIO7BbE6exAuBBF5be9bP3EivYXxQtul27q/OBi890Y2YFxeUvoKXkucKVWa7qiuXVwu4kiNM5LCw0V1vNgJnFm9Pl9IKVEjGsdeqTyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5yxE/fh; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e260754066cso3028164276.1;
        Mon, 30 Sep 2024 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727740775; x=1728345575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Omp0TCRUqYPq/kqA2kywyGRQS2WH8xmPRfAWQrDh08=;
        b=H5yxE/fhiA+XdAzS1wFlIZdwYJF5FajVlA3HPr9KgYr6Z0u45bMU4jxTRv3ByGN6AC
         FnTGlgd3Vlrcag6A0ea+isZgv1cJszVQToq6JjLIpTrqqtskKksfw79rJkdUMgO2EF7T
         CT4/x3pGxgjRv19HIRTStiVzxanYrx4bMSk8eHIsU4B9L3ipb8lwqmiK9xhI/jw3fUNi
         beg0c1wRWIidN8f1xQFSXTQtlb+vynuRPUvGmVKIV/6ofPDwVlk5s7xEl9aPkxvKrg5G
         dSKi7aa62BdeksYOhoxcuMD5yRthuBQgc5iyzXIRH+FGOzyn+z79Rbg3eJvveiN8HMew
         Ge7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727740775; x=1728345575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Omp0TCRUqYPq/kqA2kywyGRQS2WH8xmPRfAWQrDh08=;
        b=qS1v6nCAvC+s1sTXR8DwDYqNBwlklLw1wOkMyCj8iQjlssgPk5zqfQhk3YEO8nLHd1
         skV9MOPDXCSajWMuDvNDHuybWFFc17kVQnh69t9LREjY4162HKdW7uUfAH2iofxse7X/
         LaKCSuMdzCb9fNkoPz0I0mL8EiaLn0Bw4zZXshfucUY9ogzQjZ2v7PhdhHZbBphmWGCr
         CWiHrcQoZHouAdEJ9sniK5TvF9R7OE8vlX+AhiNFgjNKVze2UiRzfEeGkfkMRquYQnZp
         +u6LQreeFneC9kzrsMcf8jUvDAjDNcGJam0AwkHSfM1JWPISO8lWgB50+lSbiEsbBdO1
         cefQ==
X-Forwarded-Encrypted: i=1; AJvYcCVall4QuH+77d2oq32Jf60MG1rAse5UKpaq8ayZ3NUK2e+o5XoHOGYngPyQxwHdgZDcTJhNEJVUcpU/4TfKVCQt@vger.kernel.org, AJvYcCVjQ4dF+wkZcaYH1vlnoGCobUxeEzE+xUsvHsN11cD6JWyDPT33u6AtkOaB0a9xiFzRGuORbhq3oJbF9jQG@vger.kernel.org, AJvYcCX4XMNINf2bNzlJ3G1kB+Znyc7hby8Zn1lwnzXE/K2BiSGcwzaCwW3Nzwu6dCtWKHDYtdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybaoNrNBw+Fz+KCDaVDTDlb/OFZXXS7O0guhFccLzhQ8IwTtU
	WTWQvMw7QYBN17HhlvnuLKkd5VlerfkZds8seLjgV5ARmb7Flxwy
X-Google-Smtp-Source: AGHT+IGfhUcsgW0vXTpQM/RQpsEALLTzaOy9gzajslyDHkJNDwRuqCj3icvML3SzIvbGJP83yw/24A==
X-Received: by 2002:a05:6902:a0a:b0:e25:e38b:a46e with SMTP id 3f1490d57ef6-e2604b158ddmr10631946276.1.1727740775564;
        Mon, 30 Sep 2024 16:59:35 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e25e42210acsm2701553276.35.2024.09.30.16.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:59:34 -0700 (PDT)
From: tyrone-wu <wudevelops@gmail.com>
To: olsajiri@gmail.com,
	laoar.shao@gmail.com,
	andrii.nakryiko@gmail.com,
	wudevelops@gmail.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kernel-patches-bot@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] bpf: fix unpopulated name_len field in perf_event link info
Date: Mon, 30 Sep 2024 23:59:20 +0000
Message-ID: <20240930235920.125417-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZvqLanKfaO9dLlf4@krava>
References: <ZvqLanKfaO9dLlf4@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously when retrieving `bpf_link_info.perf_event` for
kprobe/uprobe/tracepoint, the `name_len` field was not populated by the
kernel, leaving it to reflect the value initially set by the user. This
behavior was inconsistent with how other input/output string buffer
fields function (e.g. `raw_tracepoint.tp_name_len`).

This patch fills `name_len` with the actual size of the string name. The
 relevant selftests have also been updated to assert that `name_len`
contains the correct size rather than 0.

Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com/
Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Signed-off-by: tyrone-wu <wudevelops@gmail.com>
---
 kernel/bpf/syscall.c                          | 25 +++++++++++++------
 .../selftests/bpf/prog_tests/fill_link_info.c |  6 ++---
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..90b6add4d0c9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3565,7 +3565,7 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 }
 
 static int bpf_perf_link_fill_common(const struct perf_event *event,
-				     char __user *uname, u32 ulen,
+				     char __user *uname, u32 *ulen,
 				     u64 *probe_offset, u64 *probe_addr,
 				     u32 *fd_type, unsigned long *missed)
 {
@@ -3574,18 +3574,20 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 	size_t len;
 	int err;
 
-	if (!ulen ^ !uname)
+	if (!(*ulen) ^ !uname)
 		return -EINVAL;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
+
+	len = strlen(buf);
+	*ulen = len + 1;
 	if (!uname)
 		return 0;
 	if (buf) {
-		len = strlen(buf);
-		err = bpf_copy_to_user(uname, buf, ulen, len);
+		err = bpf_copy_to_user(uname, buf, *ulen, len);
 		if (err)
 			return err;
 	} else {
@@ -3609,7 +3611,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, &missed);
 	if (err)
 		return err;
@@ -3617,7 +3619,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
-
+	info->perf_event.kprobe.name_len = ulen;
 	info->perf_event.kprobe.offset = offset;
 	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
@@ -3639,7 +3641,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, NULL);
 	if (err)
 		return err;
@@ -3648,6 +3650,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	info->perf_event.uprobe.name_len = ulen;
 	info->perf_event.uprobe.offset = offset;
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	return 0;
@@ -3673,12 +3676,18 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
 {
 	char __user *uname;
 	u32 ulen;
+	int err;
 
 	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
 	ulen = info->perf_event.tracepoint.name_len;
+	err = bpf_perf_link_fill_common(event, uname, &ulen, NULL, NULL, NULL, NULL);
+	if (err)
+		return err;
+
 	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
+	info->perf_event.tracepoint.name_len = ulen;
 	info->perf_event.tracepoint.cookie = event->bpf_cookie;
-	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL, NULL);
+	return 0;
 }
 
 static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index f3932941bbaa..59077f260404 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -67,8 +67,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 
 		ASSERT_EQ(info.perf_event.kprobe.cookie, PERF_EVENT_COOKIE, "kprobe_cookie");
 
+		ASSERT_EQ(info.perf_event.kprobe.name_len, strlen(KPROBE_FUNC) + 1, "name_len");
 		if (!info.perf_event.kprobe.func_name) {
-			ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "name_len");
 			info.perf_event.kprobe.func_name = ptr_to_u64(&buf);
 			info.perf_event.kprobe.name_len = sizeof(buf);
 			goto again;
@@ -79,8 +79,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 		ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
 		break;
 	case BPF_PERF_EVENT_TRACEPOINT:
+		ASSERT_EQ(info.perf_event.tracepoint.name_len, strlen(TP_NAME) + 1, "name_len");
 		if (!info.perf_event.tracepoint.tp_name) {
-			ASSERT_EQ(info.perf_event.tracepoint.name_len, 0, "name_len");
 			info.perf_event.tracepoint.tp_name = ptr_to_u64(&buf);
 			info.perf_event.tracepoint.name_len = sizeof(buf);
 			goto again;
@@ -96,8 +96,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 	case BPF_PERF_EVENT_URETPROBE:
 		ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_offset");
 
+		ASSERT_EQ(info.perf_event.uprobe.name_len, strlen(UPROBE_FILE) + 1, "name_len");
 		if (!info.perf_event.uprobe.file_name) {
-			ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "name_len");
 			info.perf_event.uprobe.file_name = ptr_to_u64(&buf);
 			info.perf_event.uprobe.name_len = sizeof(buf);
 			goto again;
-- 
2.43.0


