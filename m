Return-Path: <linux-kselftest+bounces-19040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B53C9907F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4701C2376D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7D1CACE5;
	Fri,  4 Oct 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPllS46A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0401C304E;
	Fri,  4 Oct 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056418; cv=none; b=k+oTa8cy7FXnTGVkf0ra7Sv3Viw+WJ5P/4WwKLcWTgvwti/Xri386cERN3sVtQiLO20PPxzgPu3PByeL6LKzQ0XtD6MrutUIHVYaezhtgftjDe5Wud4PGC9Yu20gXvtWDNUJjFMUD2XVMAABjeaDKMFk5NyXVf/uwOx62/5MF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056418; c=relaxed/simple;
	bh=Euv26twtym8I8ViPACfZmz0rdd2HjqoJZULpqn4Jj8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljLr3zPyLIhLCe/k3+YhaXS55t32d1iDG+2WvbA03ca40cPEhw2+FEuGufg1mtO6fWcmCNL5Y5f9FhCPzf+fck6j8wZQBOc4Sm9Q6GeXhLZYb1p84YwR7Zg/PGOrtAIaSh5Ij/fNutfGHXwfRVZ7d6zUJW79k7r+H4u1/ZecAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPllS46A; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e026a2238d8so2201201276.0;
        Fri, 04 Oct 2024 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728056415; x=1728661215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6KoRNCHeydTxDQQtS+XEjP2wPr4wL9NFW+2PYjdm+8=;
        b=KPllS46AtEwMkInjX7vpIgk6gnDylyoKa+gvbtsdWT5n1AIQoO9++mb0lAWzQrEaph
         p894vSm8SDDfE6LSBJMEp0kxa6KFAp1yKtQx7ORH6CZKe+SgyWoqoHdfYQzbtNg7jZeL
         oi12GPx3V1SfCLFjCIIypRn35/DLv2YAHsmzC93vEsDiOCH9mPnVhkGhZeS49A2m5eDU
         549XljjxrlNgBQqcA5vzsljFZGQ4idodpHQ+xw1mXtBfE58RvdYHBcObK1yDeoo+y1cJ
         T9iojSGJHl9lJkplOLHy9SY0fZAASWkvtlSUmRiCGBqEHdZeR8Zfwcw54dD2bQOKepzg
         RaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056415; x=1728661215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6KoRNCHeydTxDQQtS+XEjP2wPr4wL9NFW+2PYjdm+8=;
        b=vGfWhk2npn4NqWvWF86+hWLnxBK6CQgNy6nz8/FDCUgmKHGm87UFvcV+Ja65/8xkEd
         LSkWDanuYAU8upT6g9+Fv/FZMH9GPuNk7vjU4JrlHRUysDVqo+woNUZDkEOvS9mFkHvv
         G+DZjXaMSJceje8syy8z6hjoORHCd1UD1a2YLuQZC6xs41NcVKwWkC1InXP5j2oui32G
         1kx/jKhmkoPDc6g4oL64sMauz2Mub9I7qXiXIcDVM5ZSRfA2/LyMwE/BIi4ZeBIuCct/
         XevfP1UbpeAxrAkjXwfReKVgoF2A3a8JLMCb2P/AJoC0NkKRDBz4RvgnTGMe3PA+1Qwh
         bgbw==
X-Forwarded-Encrypted: i=1; AJvYcCUN66JLbizpBe9r+WLUSkZhM4fqLWJci7wlaCpRnxBfS2IcDp2MyG4FbafKUo15C1INzUKAcrtDsYQJsNPV@vger.kernel.org, AJvYcCVHniSkvLsT3NdvWv2u+brRyqhIaAfFFxBdni6PVWkoZG9mPFJAHRA3PqnqFJc2MwjEjoOg4XhnTVXc7I66UHgd@vger.kernel.org, AJvYcCXAC0lrJ3a3P1ptPBkFKXXZXWzjE2pFtzoCNeVHT4x4yfl0lgcSRX1zVAz+kLVkT2yNspI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUmgxRvs/JkS0UrkwaDwJ6nKlXjJd+7UhkiB1AWJ6F2RQbJNoT
	hwMfGgoJraoc+BdaId9KBslbiwxXrk2goZ1ba525LrNUf7CXpDGuAUlqv5QrsK0=
X-Google-Smtp-Source: AGHT+IF9Bq4QQdAzmd9NmXdsP6l/AMlXD+lGIP0cpmqp1tD50O+5Cm3NK4HcNQiat0VUsYoiVd9QnQ==
X-Received: by 2002:a05:6902:1005:b0:e26:d47:4dfb with SMTP id 3f1490d57ef6-e28936dc80amr2497656276.19.1728056415444;
        Fri, 04 Oct 2024 08:40:15 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e2885d2ae37sm628475276.20.2024.10.04.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:40:15 -0700 (PDT)
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
	yonghong.song@linux.dev,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf v4 1/2] bpf: fix unpopulated name_len field in perf_event link info
Date: Fri,  4 Oct 2024 15:40:01 +0000
Message-ID: <20241004154002.10979-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zv_PP6Gs5cq3W2Ey@krava>
References: <Zv_PP6Gs5cq3W2Ey@krava>
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

This patch fills `name_len` with the actual size of the string name.

Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com/
Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Signed-off-by: tyrone-wu <wudevelops@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
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

 kernel/bpf/syscall.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

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
-- 
2.43.0


