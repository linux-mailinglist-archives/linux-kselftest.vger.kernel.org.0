Return-Path: <linux-kselftest+bounces-19248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E1D9954B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55008B218BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC681E0DDE;
	Tue,  8 Oct 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV4EG8JE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8474502B;
	Tue,  8 Oct 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405818; cv=none; b=vEAhpmV8CI0z3GRIYsjbaNGwyXnNsHWXsVnte+r8P59K0JNHP8uqf7WCvrEGP0LjTr/ptBvBnWSqbQdjwmfNWOHA9sfxx8fQ1/raW0PZwjSB9VU6/8Yvvmj49DFi5iIFzBT00Z/6lnVcTKDulpza+kvZBiWvwxitwV6K9jz4znU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405818; c=relaxed/simple;
	bh=a6xG2Qx+iV9wVYwK5a2sX4ZdZzlDJlAtb0ad58N2V9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fw3gBLGkwdQGnND9oyyHgeKnSAk3hWiw5JXVi2I/pN66/IgTi1iZ6XEM93+Ko4fcWKIWePZ/vhCvm3sPHXrH/lDuzfOiNzSW6g8serhaw4JFhCZ0eA0jwHKtPVCyrVU9Wb3j2VuJJcjDOwDKR/fmuL29Gr6grwAPkKIwI8wYwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV4EG8JE; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25ccd64be9so5117455276.2;
        Tue, 08 Oct 2024 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728405815; x=1729010615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR9WjKC7K2hGHBOzvzMeFrqylRLIUG2ZjE/dLz2Xa2c=;
        b=UV4EG8JElwWCyvcNoVMXBVcVmQsDCYdvc4ipslJdq/sWnT+OVl299iiqqktPMMPofr
         x2KVH1VY3b/X4wRR4B/gSvULZOyiEFgGlnvLak8Sje6Ey8h6pvywoIG+nsGaVCLyaQdN
         3a/E9SmB4b5SbLnzcvXOFisGW+wQzFa9RcOrja5Qgct9mqnJ3VoWsidyycD2wohFHUKm
         ajpV2cV4kB4LAsxy+GZwBMc0Kg86Zc3j4aKIH9djw8vZME2CV4N0n3YfHu5Bnm7lzZNV
         5KCzg9JsMvtAWeXkD85Sa6toeplO/2Nlhd/fw4Nf2je26oqFXqdEWLXgqlg81jVPZLW/
         c1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405815; x=1729010615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RR9WjKC7K2hGHBOzvzMeFrqylRLIUG2ZjE/dLz2Xa2c=;
        b=UqFGNRYQaMPDUa9M6O4JXWnvuy7Cv5cwTIjJpvaqTqvNEkUI/zO3pCSHANaNcdRNtA
         mxHGC6ksPtZDPDmlq4AsP+Y89smSVUI8xgCYYYivo/oknpOiF4ezWAlckfRWPs45xs6+
         6e0UXxvGTF2Uq8UkfXcvjY0A17gXMcFO+umko7S6+yKhdoMmgqz0GIsDLBx65A4SYgQ6
         EBkS4qir8EkDE4OQXMGOiyGV+XRq3dy3iE7lDz6Hdsw+hpd+rs4FaZljcj4VqsfIsa3Q
         lqhdGRaIJIhRfmC6XD2nTO+KH1UYzX/7vfiR3X0I9VMNoXeBrMRpgjnWb9dk7k8TUcIN
         gOOA==
X-Forwarded-Encrypted: i=1; AJvYcCUftVXjoZ0OTNLSKrEbnhMfWeyuPXm0Th49EU/VojjKhydYIszd+Ui6wp40QDik/oREz4HWXyDKtdM06FRo@vger.kernel.org, AJvYcCVPlbLcIinNOxO1roHIXprZpi3lj1hGucqjHhzS8ZyTTuy2eths6JXDV39xtptEl5O7E4E=@vger.kernel.org, AJvYcCVSADshLXk23XZ9ijtrGld14xj31y3Urg8tg0NjAGUJGtxI86285jXBCVXjRHVdBEBMCdE3Y/aPSt0G/K9Yui9l@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPybQVyXeW4cO4cU/KC/IcksIBQflrvEmxQAApuW0dUzwE6CH
	MP7s3moO+GT3uz9a0kDb4lK/o+ROwuwZq9BoINIs5qb7C44OFPXo
X-Google-Smtp-Source: AGHT+IE4K6ioe96/WwXwQgwB3BD+iGa6p0U9fUsNejykt2Jcg3bdDKhsMaK0ZRHAWIzRFEI21bmusA==
X-Received: by 2002:a05:6902:1747:b0:e22:3ae6:fd04 with SMTP id 3f1490d57ef6-e28937e3a6emr13564901276.32.1728405815058;
        Tue, 08 Oct 2024 09:43:35 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e28e500b5afsm498103276.44.2024.10.08.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:43:34 -0700 (PDT)
From: Tyrone Wu <wudevelops@gmail.com>
To: andrii.nakryiko@gmail.com,
	wudevelops@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-patches-bot@fb.com,
	kpsingh@kernel.org,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mykolal@fb.com,
	olsajiri@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH bpf v7 1/2] bpf: fix unpopulated name_len field in perf_event link info
Date: Tue,  8 Oct 2024 16:43:11 +0000
Message-ID: <20241008164312.46269-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEf4Bzb1JzE7OPieODoq7H5hg_z2WwkBZo91dyGuRQ56cJ03jg@mail.gmail.com>
References: <CAEf4Bzb1JzE7OPieODoq7H5hg_z2WwkBZo91dyGuRQ56cJ03jg@mail.gmail.com>
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

Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
---
V6 -> V7:
- Use *ulenp suggestion from Jiri for user name_len
- Set user name_len to 1 when buf returned from bpf_get_perf_event_info() is NULL

V5 -> V6:
- Use simpler buf check while keeping V4
- Fix netdev/checkpatch warning for 80 cols exceeded
- Fix Signed-off-by to use real name instead of git username

V4 -> V5:
- Check that buf is not NULL before retrieving/using its length

V3 -> V4:
- Split patch into separate kernel and selftest change

V2 -> V3:
- Use clearer variable name for user set/inputted name len (name_len -> input_len)
- Change (name_len -> input_len) type from size_t to u32 since it's only received and used as u32

V1 -> V2:
- Use user set *ulen in bpf_copy_to_user before overwriting *ulen

 kernel/bpf/syscall.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a8f1808a1ca5..8cfa7183d2ef 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3565,15 +3565,16 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 }
 
 static int bpf_perf_link_fill_common(const struct perf_event *event,
-				     char __user *uname, u32 ulen,
+				     char __user *uname, u32 *ulenp,
 				     u64 *probe_offset, u64 *probe_addr,
 				     u32 *fd_type, unsigned long *missed)
 {
 	const char *buf;
-	u32 prog_id;
+	u32 prog_id, ulen;
 	size_t len;
 	int err;
 
+	ulen = *ulenp;
 	if (!ulen ^ !uname)
 		return -EINVAL;
 
@@ -3581,10 +3582,17 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 				      probe_offset, probe_addr, missed);
 	if (err)
 		return err;
+
+	if (buf) {
+		len = strlen(buf);
+		*ulenp = len + 1;
+	} else {
+		*ulenp = 1;
+	}
 	if (!uname)
 		return 0;
+
 	if (buf) {
-		len = strlen(buf);
 		err = bpf_copy_to_user(uname, buf, ulen, len);
 		if (err)
 			return err;
@@ -3609,7 +3617,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
 	ulen = info->perf_event.kprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, &missed);
 	if (err)
 		return err;
@@ -3617,7 +3625,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
-
+	info->perf_event.kprobe.name_len = ulen;
 	info->perf_event.kprobe.offset = offset;
 	info->perf_event.kprobe.missed = missed;
 	if (!kallsyms_show_value(current_cred()))
@@ -3639,7 +3647,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 
 	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
 	ulen = info->perf_event.uprobe.name_len;
-	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, NULL);
 	if (err)
 		return err;
@@ -3648,6 +3656,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
 	else
 		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	info->perf_event.uprobe.name_len = ulen;
 	info->perf_event.uprobe.offset = offset;
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	return 0;
@@ -3673,12 +3682,18 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
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


