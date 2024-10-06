Return-Path: <linux-kselftest+bounces-19134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DD19920EC
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE051C209E6
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177AA18A933;
	Sun,  6 Oct 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiXB8905"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A17155336;
	Sun,  6 Oct 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244302; cv=none; b=QFQlxR1RP6IJM6GyQSu4JNN7Hez9o3bLN86fKaO1eybFo2qwEqxSBZ64PRplEfzXzVQlC29CpsJTx/jzOL68SC0wX1+e2p+cYS0kKVVTJwx6ppUczkaSdwxWgG5VePTVjNiYgHgas1HjnK27PWrXG6GcWpUfN2DCqF675FuN4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244302; c=relaxed/simple;
	bh=JD0ZaFsBGdGyGRUvz7UgbjrYOncXvvoMXQUeqJXz9Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7BMfJ4cXezCnYPaSbCarnOXA3MSw/GJXjJ2HogobxMKPXfa/i1nG+FzN8K8HxCbJ3cMECbxLzxCZ1eLTjNLhwHHJR4XKxyp09DoSfXc4zY/8+BahUGgZ4RBuT0OSfJxQWE8xfinmgR7KxVwfy94DDIfAsPm568QwKojyqD9w1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiXB8905; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2e3e4f65dso6495067b3.3;
        Sun, 06 Oct 2024 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728244299; x=1728849099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfOLbWrnxSwVRrFjZQozO1EugIQbxg//4Wl+zKG3SI4=;
        b=hiXB8905UABJXWv8g84+0Dt67UBIREwb/4ekFYiLioB9n/vp1Z4IVaJ44kirIYkO3b
         WQrik2oz/CQlnw7HpoQlC1rKJmNBXvrbDUB8715xY+4EEujqmUokUQduDBNzMnT1bLmg
         oQBCxyAt+nyF3ue/lBQ6EAvt6JRgXWjqoodTTqjOIVYFU0oRBTpz1/AEAZ9JiC684wRM
         eF7AliK9o/KX8H6LzY3JqJ/bBmedjzUtCQLmXhQ7/c5B9iG6onaR97ND2PpoxHs9Xozj
         AcXWqRPIhTEowbdj/5bisxfU+exVJuxrU2WPtJhX2Ubxjw8IGJda2eKJecF4mSFWlVz/
         qK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728244299; x=1728849099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfOLbWrnxSwVRrFjZQozO1EugIQbxg//4Wl+zKG3SI4=;
        b=v9Hmlu7kMY7K4iAoxiEjvbHwDWMDX/rzASOam4iLLr6QVxHWdkoQp3et9+oSIb62FC
         Xfof7k7MUTo9a4Wj+hBYN5rD+qsDxNVCICveCFjsJmcjEBv32lduSwvw4BjbWsKVUZDV
         LPTmcDlQsN2onLS+oHumIw3/7gDUtzfjmnKea7AHQYYlWZl4EHk4uzOhQaskGIIV/WK9
         uJSt+D7AxR9wSSagAiXtybZd1kkNdCnoGi40smdtr/H5qBmVOhKCPXn0MwjGnrP7xh0A
         amsAml3XZHqk/w7MTywimsy4a0yLZH6auJJzO5VP/t4nj4345/x50n0O8UFAwXWISane
         Yo9w==
X-Forwarded-Encrypted: i=1; AJvYcCUuDYGJvg0+C5zbnh4hBw+1FS0mhe8r0o8XOoatyt20xYl42p/DSV+sd8M76DfuXYXc9JdP+XI51mAW2Hsd@vger.kernel.org, AJvYcCVgUnSKi9iBPGRkOWIWiGY2FHOJeoMX/E1mFFj2mohE+ffr0/OAYPiSY69BWBoJbNUGVDQ=@vger.kernel.org, AJvYcCXjbpnFcZSDQonaQE2K3eN5Yzp455k5d9r7oDJNExlX+UPGfYcHgC7sn5Po3v+gjK1pwair4n8yRaootmsND1AR@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtmFzG+cmaW+zSTiTAesKq/mSOWhXTuisUgXrcjjOT90HNOY1
	BjFcuZWxS5dMUnfUcjOmCjpQiiN+PPjaO5Do3B9P6/dFWTIIxTOH
X-Google-Smtp-Source: AGHT+IFrlrPAmnJaewbsl4jWg3CKdwAPd7mRW4VdFIv+dgKES0+ZGQ3FK27qHG2FYeJOiomZqtXK/w==
X-Received: by 2002:a05:690c:18:b0:6dd:bf29:cece with SMTP id 00721157ae682-6e2c7295b9cmr57113017b3.36.1728244299274;
        Sun, 06 Oct 2024 12:51:39 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e2d93d6effsm7811297b3.100.2024.10.06.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:51:38 -0700 (PDT)
From: tyrone-wu <wudevelops@gmail.com>
To: laoar.shao@gmail.com,
	wudevelops@gmail.com
Cc: andrii.nakryiko@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-patches-bot@fb.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	olsajiri@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v5 1/2] bpf: fix unpopulated name_len field in perf_event link info
Date: Sun,  6 Oct 2024 19:51:30 +0000
Message-ID: <20241006195131.563006-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com>
References: <CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com>
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

 kernel/bpf/syscall.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..3df192a6bdcc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3565,32 +3565,35 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
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
-	if (!uname)
-		return 0;
+
 	if (buf) {
+		input_len = *ulen;
 		len = strlen(buf);
-		err = bpf_copy_to_user(uname, buf, ulen, len);
-		if (err)
-			return err;
-	} else {
-		char zero = '\0';
+		*ulen = len + 1;
 
+		if (uname) {
+			err = bpf_copy_to_user(uname, buf, input_len, len);
+			if (err)
+				return err;
+		}
+	} else if (uname) {
+		char zero = '\0';
 		if (put_user(zero, uname))
 			return -EFAULT;
 	}
@@ -3609,7 +3612,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, &missed);
 	if (err)
 		return err;
@@ -3617,7 +3620,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
-
+	info->perf_event.kprobe.name_len = ulen;
 	info->perf_event.kprobe.offset = offset;
 	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
@@ -3639,7 +3642,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, NULL);
 	if (err)
 		return err;
@@ -3648,6 +3651,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	info->perf_event.uprobe.name_len = ulen;
 	info->perf_event.uprobe.offset = offset;
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	return 0;
@@ -3673,12 +3677,18 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
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


