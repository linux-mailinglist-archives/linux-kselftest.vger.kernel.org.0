Return-Path: <linux-kselftest+bounces-18934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A1B98E562
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 23:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815931F2190D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB005216A32;
	Wed,  2 Oct 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3jwyDvj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70C1D131B;
	Wed,  2 Oct 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905226; cv=none; b=FWDW1jAKbHfTnR399aBIdA+RNRqMrf/p0WEGM0XNSxjE8AqdYJwAn86B4Q7XIhDnwZPimtN3jZ6HKFmMV/qm2zG2Xg6Zh41qNDvLwnoMNLDlAO4IVH7KA/Nz2r62Z59ZsxF12wHyLOkEza60H0GsIG2BgfElKYKZR1PtMBoJ1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905226; c=relaxed/simple;
	bh=UdLqCPMku3yoqDyZ60QNT+ENwoD+VtSCx2uVEwWJ+20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwkjzQYK3GaH1vEGIaDfGeYpIzJ6TVw5vgInJxUIi5TAcVYQKbJbRPW+2VMWHF3bopoL2xw0PG539k0MOqPw8LNIu196nigmvbjAA5mrxsJIoBRRJ5c8rTHkmSmashSm7Gq1Tj5I65e7w/qxDrERVLY1QcE7+mMvAgs0PeFWpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3jwyDvj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e21b4d7236so2635637b3.2;
        Wed, 02 Oct 2024 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727905224; x=1728510024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3WjlMY8Ir6Tz8SPlE6MeCpymkZMbXRALtxACpzNU9M=;
        b=N3jwyDvjI8FASejldVJiAK6LWByXf/02v19LscTFUPK/RDvc3u7by5i/XH/yrCCQ90
         M1Zsc480qBdNMRGslZEQO58j7ehunRsD+V5dNs3o/kHLfGV+rTZiDneGxOXBONTq2BGA
         9tKxoQFmdC753rsiCUqXohqEXsJfn8uDHPF14SrNjdYp6nONt7Cj7G/eWNC1jYgr9iaX
         y8srDZSA5NB8oLB9Ze9nHDmhiaTnkXBUwLE9PBvRIq/rMYWui6UiHAydvroGQCZ6lE0I
         tAPMn4PQQ620DEgd61QHSoltgobUkjp2f70/a7knlPg16WtHQMDh9J29iylVPhGWTjCQ
         zLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727905224; x=1728510024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3WjlMY8Ir6Tz8SPlE6MeCpymkZMbXRALtxACpzNU9M=;
        b=AdNYTDmMQiQ/K+PKq7ZaTrdlAAdTL8acI3SnZI36XSaDza7Yyb+T5NQvUxbjyOPhSK
         qEeVoHDV3xhy7d8BL40bsw1YE4416jD7yHQPTSiEd6FRtMgZVCOcTLXDKpn9rUtlOb8r
         Zn52BAYKLs24a/nXbt6oNUAu67obJFLvz3xKNgi4M8nyvlBDMsk+uCswjiBloxvuzRMn
         PnrzWn60m7nebJ64gJqnwPFPb9w4zToFE7orPuWRL9ZfwYMroCMLxKd0wjUb2E8/dD2d
         OXnNIYtuUbhAds6ehVkMY8afYdlKhXHuVOv/RPz2OtaZvtmIHczRbQqY+bLqIr0twfuL
         hSYA==
X-Forwarded-Encrypted: i=1; AJvYcCVXDZwdvYLh7La9/Z6xTWM3pFWPZwkVl5EgkizhskBkHSjdZVApm/rnp8CQzMKEuscjD3XCc5SAhSquCZlZ@vger.kernel.org, AJvYcCWRj2NuC12pO4cNWQYDWeIjtkb8YZakBJ+WJUJDKMMGD5hllQlefxjLqbtiKk5pTNnwnHg=@vger.kernel.org, AJvYcCWt9P9fSejmgCETBIMjy5E8uwADy/2egY+YTiyk54szeIEBSWMuiSk25YNpHCn5rk2CRJJaZaQNtpb5dMvo7E8L@vger.kernel.org
X-Gm-Message-State: AOJu0YyrbMs0Jor7yJGS1wONrfvy5GA6rsMsU0MclHjmiciPnLlAL2f1
	Z2x5DaoSTRUU8OqANoMSS5IJxh8HPSFqOOosX6FCJva3oQOR1z5w
X-Google-Smtp-Source: AGHT+IEcDPllfLjYQWJkhhE24JOJd/ZGL0bY9JzZJYNf+DmiEROjHPNXe6MW5mhxO+gzMdiXlMtBAw==
X-Received: by 2002:a05:690c:6612:b0:64b:89cd:7db8 with SMTP id 00721157ae682-6e2a2e051f7mr46406357b3.28.1727905223964;
        Wed, 02 Oct 2024 14:40:23 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e245386789sm25896017b3.104.2024.10.02.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 14:40:23 -0700 (PDT)
From: tyrone-wu <wudevelops@gmail.com>
To: olsajiri@gmail.com,
	wudevelops@gmail.com
Cc: andrii.nakryiko@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	kernel-patches-bot@fb.com,
	kpsingh@kernel.org,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v2] bpf: fix unpopulated name_len field in perf_event link info
Date: Wed,  2 Oct 2024 21:38:39 +0000
Message-ID: <20241002213839.13790-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zv0wl-S13WJnIkb_@krava>
References: <Zv0wl-S13WJnIkb_@krava>
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
V1 -> V2:
Link: https://lore.kernel.org/bpf/Zv0wl-S13WJnIkb_@krava/
- Use user set *ulen in bpf_copy_to_user before overwriting *ulen

 kernel/bpf/syscall.c                          | 29 +++++++++++++------
 .../selftests/bpf/prog_tests/fill_link_info.c |  6 ++--
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..26cc18693924 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3565,27 +3565,31 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 }
 
 static int bpf_perf_link_fill_common(const struct perf_event *event,
-				     char __user *uname, u32 ulen,
+				     char __user *uname, u32 *ulen,
 				     u64 *probe_offset, u64 *probe_addr,
 				     u32 *fd_type, unsigned long *missed)
 {
 	const char *buf;
 	u32 prog_id;
-	size_t len;
+	size_t len, name_len;
 	int err;
 
-	if (!ulen ^ !uname)
+	if (!(*ulen) ^ !uname)
 		return -EINVAL;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
+
+	name_len = *ulen;
+	len = strlen(buf);
+	*ulen = len + 1;
 	if (!uname)
 		return 0;
+
 	if (buf) {
-		len = strlen(buf);
-		err = bpf_copy_to_user(uname, buf, ulen, len);
+		err = bpf_copy_to_user(uname, buf, name_len, len);
 		if (err)
 			return err;
 	} else {
@@ -3609,7 +3613,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, &missed);
 	if (err)
 		return err;
@@ -3617,7 +3621,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
-
+	info->perf_event.kprobe.name_len = ulen;
 	info->perf_event.kprobe.offset = offset;
 	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
@@ -3639,7 +3643,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, NULL);
 	if (err)
 		return err;
@@ -3648,6 +3652,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	info->perf_event.uprobe.name_len = ulen;
 	info->perf_event.uprobe.offset = offset;
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	return 0;
@@ -3673,12 +3678,18 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
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


