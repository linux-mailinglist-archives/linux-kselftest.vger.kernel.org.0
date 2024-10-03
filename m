Return-Path: <linux-kselftest+bounces-18976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE9298F7FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05912282D36
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C81AAE05;
	Thu,  3 Oct 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4V3Uc+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308712FB0A;
	Thu,  3 Oct 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986999; cv=none; b=UsN2Pg4fkOipKc1OwTDT3K9lJMUUPZIi4PK6aWSd1pKiFYnuJubzv5Zl+j1ZA5rhG+3CWGDo4a6EeorPrDKIfY6EyfMwT1XOcHLlNucHEZra60zcaV/fm3jhfkEWRATsDwa0Xy0ksWcPaNDRHH3B2qDopYIZfnTnt1Jaba6EVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986999; c=relaxed/simple;
	bh=9+oZ518oABV7PI6yFVwppEZ9NFhdPJUlGQC4f0yFNCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=risAmSBT/wxrZhcHjBeOOmPGDjz770B3DLf8kXFfc/fJsc2eScho9Ga0il2dnu2khMXPzG7WWy8oPb0K4IKsoRUSo2cDu2mo9Qt/yRPxYgDhjY2e8nCXsTrcNN66fV3EN6pcz28E2B/Hi14B4LaUH2v9ZPWKC59avV4dR6LJFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4V3Uc+X; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e26290a13d5so1263744276.1;
        Thu, 03 Oct 2024 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727986996; x=1728591796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFCTUd0dO0UDVwnnJDbfec+2Tn/cLzupuFR/1BEJtbw=;
        b=a4V3Uc+XLaZPZPJOHQnMCHSvO3AHDz6yGhhRZPFWfu/qv8yWgJ48/j31Vf2qBO5WPU
         Mc7uTauIowa/X/cYUU1MbtUh94JxBL1shse8i/i99oKhdEdmymtenkccTdW3R+lD5p6q
         +z9YDqp+7oZFJj8SZ1TY9cFgRHqVTNndrQaqZeJ9emjIZzTgxjsQG3ybPcMftvsIwpCy
         750k+bQKGC3Yd1jEnfgYR5T4v8kJzU4RjGb91iCIdDz7p+MEf36I4t4by1mu9W1kGY5l
         MRAmu/ymoWdNyLgMF98mB5tyCVyXqdytJmlKatP540J/EzVsvZEsK6B9cO+dzBhLTrxQ
         YZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986996; x=1728591796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFCTUd0dO0UDVwnnJDbfec+2Tn/cLzupuFR/1BEJtbw=;
        b=pMUvZC/B4rW/rzB1IzC7e5R4t8ZuvcoBH2DRr0ta7qStt1eybjrc8luLE4pwCk1u+o
         InYgEQkGZyYrm2I1SUFjv10qL/01wG/p0IGK+//gyykk3DXfcRasPmHWMGeM3WzcVvMh
         MtqUt5r/mCJLdD6c1ooK/RyfwWo11ylePI7OwKIFPFuzWt2LSGk3HsTEG1lNqSbDu6eH
         1cWLM45MeEYdmE71pNdBH6YnNXUVmqPxXLNfc/4j3zzW36dpCGyP9nSo/GtDLIMIsLw0
         gZpdEL0Ux7g3TKm7I1wM/DaBUE1SS53OhXuHaYNjLVIHXHP1BMP8znYsMH5vug8u6blC
         3EzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDZuleX3f0JDdHDs9hI5BW5IGzDUEWCCOtMimDt5kzkpzhmiTkb9dCOfNaaFx2hFstXv0=@vger.kernel.org, AJvYcCV21r10Dil5i/7Y/hhkeY1MRELT5wiy5E1XvW3rhO2N9yBVSMqFNb9aKX61whXAazHlwZX1cA2sIpdLfK/UVs04@vger.kernel.org, AJvYcCWftns4B30Zn7NEeks1xKcEeQp9z+tLOXYj99dOIBaox7BmCd6ULTGhT6tV6tP7iKIUelxT/In6IoQNrJXD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywio+yEQt0zW1SQMxKf94zaWQlqMk1rV3u3m2q/Ppb5fjpaiyKe
	2p9ThAnXXyZHdRv+eIJOgCpkLqQgUlCOG3aJzdR2DSdyUk9tL4NB
X-Google-Smtp-Source: AGHT+IFdVhvx0nE5ZiUGPx6PA7MtHqKkbau6VLfd2V6uwI/M62JqZgx0niX5vo0Nt+6GqCaNGcQQKg==
X-Received: by 2002:a05:6902:18c3:b0:e25:1b5:edbe with SMTP id 3f1490d57ef6-e2893918422mr360513276.17.1727986996326;
        Thu, 03 Oct 2024 13:23:16 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e2885eb2368sm350983276.45.2024.10.03.13.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 13:23:15 -0700 (PDT)
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
Subject: [PATCH bpf v3] bpf: fix unpopulated name_len field in perf_event link info
Date: Thu,  3 Oct 2024 20:23:00 +0000
Message-ID: <20241003202300.56429-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zv7sISV0yEyGlEM3@krava>
References: <Zv7sISV0yEyGlEM3@krava>
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
V2 -> V3:
Link: https://lore.kernel.org/bpf/Zv7sISV0yEyGlEM3@krava/
- Use clearer variable name for user set/inputted name len (name_len -> input_len)
- Change (name_len -> input_len) type from size_t to u32 since it's only received and used as u32

V1 -> V2:
Link: https://lore.kernel.org/bpf/Zv0wl-S13WJnIkb_@krava/
- Use user set *ulen in bpf_copy_to_user before overwriting *ulen

 kernel/bpf/syscall.c                          | 29 +++++++++++++------
 .../selftests/bpf/prog_tests/fill_link_info.c |  6 ++--
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..56c556fcf325 100644
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
-	u32 prog_id;
+	u32 prog_id, input_len;
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
+	input_len = *ulen;
+	len = strlen(buf);
+	*ulen = len + 1;
 	if (!uname)
 		return 0;
+
 	if (buf) {
-		len = strlen(buf);
-		err = bpf_copy_to_user(uname, buf, ulen, len);
+		err = bpf_copy_to_user(uname, buf, input_len, len);
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


