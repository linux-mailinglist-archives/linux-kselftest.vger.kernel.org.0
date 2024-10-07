Return-Path: <linux-kselftest+bounces-19175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69553993637
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268A0281D13
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B061DDC3A;
	Mon,  7 Oct 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf6sfLmi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA881DD52D;
	Mon,  7 Oct 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325784; cv=none; b=jN/df6jdbRxhwVM6L7isrU4XzFix2h5rwPwK5eApHeEMvTQLi7oEb4uFqMAeUweAToQDO1qlfVN92uVBM4LHnyeCpgx9/+uzBtV95qaQab0RlvnHQtmQPeLbCkKnexCl8Z0LjLu0clJwqyGxZgeCMi3WxFWvSHBabysv2fQiyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325784; c=relaxed/simple;
	bh=QhyJG1yefxH1ukiGpEgjlQYVZ/MxwqI9nEfhMYYcmD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubmQNQYwNrW1aKO76z3Swpop5el3x5xC5q8yQrwBzJAmUxmCyKS8hHxPzKOap3DP/dh8H9ytF/Be9khalsCFHIur2c+HMr/EFsgLOhvQEyJT7Tu3Ikoy/uwB4X3mq6jw7jFTWR9rZ6/N5QJe96nXABJ27YeRmGrO/6jRN/FT63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf6sfLmi; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e25f3748e0so47110697b3.0;
        Mon, 07 Oct 2024 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728325782; x=1728930582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9tL+fiEIisanOLXgHGQUAxH9XfudE5xPb2xakDmuBk=;
        b=Lf6sfLmifHkSRqAguKPYtnHm1sWOrpnQoZHLmoJlEccRSq8+IqT5eJ7qAAajbMgH8C
         4kTJJU9FUf1xsA5SpSTKLPxhTS+rxYzXO8Z3vnQLzZjLrrgQ60qzbHB38zhp86Wl1bPB
         FcBlIV+hAoYzhkCtNn6w1WVu1+6YSE4UU2SXGD1NB4s+noyWYtWv0J/ZxKCqxRyKB4YQ
         bS+3eR840EfD58iqjCQrTBrtVBn9XbVU4TSoNVHf/8Z197DlCCKgKDOayUhwdFJryq6T
         6CRrElP4aYINd8v1aTzAfMfl5ekxwrksuamskaoo1Nb91ibFKXfqTq1wwzv4IwVoEWPF
         Jc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325782; x=1728930582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9tL+fiEIisanOLXgHGQUAxH9XfudE5xPb2xakDmuBk=;
        b=i552u8LhjorA6Ri+zF0HLuyTw5Z46AVMex51hre8+3iUmpqif5ioAQU44CEpJJZ7aD
         FEgjxs4He9vy4XzGXLUI3MiI6TonPlbs38DNOJPZxczX9g0by6tTuYSWc8TRhmcMroQX
         sjdKMkxiBE1KdvHQn2J3ZO4kR3aUllqC0tg3lsvBIURSrhElpMvO2kd4zHjqJfLXbJG2
         AjYlYE8YzADD5daZ5kIYqqU4n3hAIiyEkmz8rfpzC6PPfG0IvBG0aIKkNTD9jNVlBdys
         UOWB88eUXsIX9VxNhdsfgD0ksclfUPq+GrVa+mVzAoQ5nbZQZuNpIzwKrFEqdv1L7MlI
         61EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtetSn6wLdeIHj61nDtHv6frR0oDxKB/O91K0xW4DFAD/ZsDmP9BdECK5mAwwA6ts/2iXi6G2QIIHUvVvO@vger.kernel.org, AJvYcCVd7kIBZ1SYaFgF7k8gKikDE8s5VwQNjeLNE9URr27+XdegHneKwDTp5rzVwWg/qL/wKzMwtBBUQwYoxmP2vqNM@vger.kernel.org, AJvYcCWBCE0riUgKfmitWrg09wbVcrfdnQrKrMGNzJOruy2UiV/DmRb56SWnzy4FJi26NghF1BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHuPPqHPjsp55TgsBJSl6XOsXZAa7qtQvhh354xAcmtjoPlUx
	W5icAyJUcWl591NCZ+cWFwngeUhhpFnDTImB8jm0wgOmDezkU1VouZnO/Odo
X-Google-Smtp-Source: AGHT+IFxRXXkyXYrbz4bkr7Zxus1zEAxwXPdFVCO/p5Eqbpv2MrtpmYKCXpDdSRinH+YQu1wXePscg==
X-Received: by 2002:a05:690c:39c:b0:6e2:767:8a64 with SMTP id 00721157ae682-6e2c729eab6mr104318897b3.37.1728325782187;
        Mon, 07 Oct 2024 11:29:42 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e2d926aec5sm11377977b3.2.2024.10.07.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:29:41 -0700 (PDT)
From: Tyrone Wu <wudevelops@gmail.com>
To: olsajiri@gmail.com,
	laoar.shao@gmail.com,
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf v6 1/2] bpf: fix unpopulated name_len field in perf_event link info
Date: Mon,  7 Oct 2024 18:29:32 +0000
Message-ID: <20241007182933.8841-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZwOWs_XrBtlTGE24@krava>
References: <ZwOWs_XrBtlTGE24@krava>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: tyrone-wu <wudevelops@gmail.com>

Previously when retrieving `bpf_link_info.perf_event` for
kprobe/uprobe/tracepoint, the `name_len` field was not populated by the
kernel, leaving it to reflect the value initially set by the user. This
behavior was inconsistent with how other input/output string buffer
fields function (e.g. `raw_tracepoint.tp_name_len`).

This patch fills `name_len` with the actual size of the string name.

Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com/
Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
---
V5 -> V6:
Link: https://lore.kernel.org/bpf/ZwOWs_XrBtlTGE24@krava/
- Use simpler buf check while keeping V4
- Fix netdev/checkpatch warning for 80 cols exceeded
- Fix Signed-off-by to use real name instead of git username

V4 -> V5:
Link: https://lore.kernel.org/bpf/CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com/
- Check that buf is not NULL before retrieving/using its length

V3 -> V4:
Link: https://lore.kernel.org/bpf/Zv_PP6Gs5cq3W2Ey@krava/
- Split patch into separate kernel and selftest change

V2 -> V3:
Link: https://lore.kernel.org/bpf/Zv7sISV0yEyGlEM3@krava/
- Use clearer variable name for user set/inputted name len (name_len -> input_len)
- Change (name_len -> input_len) type from size_t to u32 since it's only received and used as u32

V1 -> V2:
Link: https://lore.kernel.org/bpf/Zv0wl-S13WJnIkb_@krava/
- Use user set *ulen in bpf_copy_to_user before overwriting *ulen

 kernel/bpf/syscall.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..b5a7e428ac16 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3565,27 +3565,33 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
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
+	if (buf) {
+		input_len = *ulen;
+		len = strlen(buf);
+		*ulen = len + 1;
+	}
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
@@ -3609,7 +3615,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, &missed);
 	if (err)
 		return err;
@@ -3617,7 +3623,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
-
+	info->perf_event.kprobe.name_len = ulen;
 	info->perf_event.kprobe.offset = offset;
 	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
@@ -3639,7 +3645,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, NULL);
 	if (err)
 		return err;
@@ -3648,6 +3654,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	info->perf_event.uprobe.name_len = ulen;
 	info->perf_event.uprobe.offset = offset;
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	return 0;
@@ -3673,12 +3680,19 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
 {
 	char __user *uname;
 	u32 ulen;
+	int err;
 
 	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
 	ulen = info->perf_event.tracepoint.name_len;
+	err = bpf_perf_link_fill_common(event, uname, &ulen, NULL, NULL, NULL,
+					NULL);
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
-- 
2.43.0


