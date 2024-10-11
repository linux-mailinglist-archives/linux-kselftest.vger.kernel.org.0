Return-Path: <linux-kselftest+bounces-19485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DA59997C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E9286394
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188948821;
	Fri, 11 Oct 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Ay4eaI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BE6AA7;
	Fri, 11 Oct 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728605300; cv=none; b=H/HU22JTcNOTKKCWdtRCukKvAM+XlIpgBny993GsmoQgS1MbT0puA1YEIazsVX3GGzkY+ik7dtj2alwR8M+wa9ZVE+v6IYoRjI9ohCgtp9Bk8Nq8P09co64uH37hohH3+b+3Wyosku6i78UZxvWeS8d1JkhmfuBbqZfPIv4kGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728605300; c=relaxed/simple;
	bh=8w7nDeldreJx8LzlumjXe3oZTS2omzyIbIhL58VZIlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzvSIFrxEmtcQcwIe+xtM+hgdfbHKYthJpGXGVyh3LAJm2rFEEMTCiTUVdA0z2MFScQJSFB0OlPZFvG9Ou5jdUyLTHNIPqKsFJGl1XqQ79/agLYt/qqMAhkTH/Q26s47xcGbK8WGTzKbsmnT2Mfn7pxrH6Dx0oqprn35sLad5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8Ay4eaI; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1348204276.1;
        Thu, 10 Oct 2024 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728605297; x=1729210097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nh4cL0KF9yExsu8KOk1yBH8TEmcNNSRnVke/5q4xEU=;
        b=J8Ay4eaIQFgv3rrUVooudkms9cboJI0ZorXvhpc+KuKLZDtjqP9AnaHQEIW+IMztSX
         FAidKyQ/D0+pygs84Bxswa6p2Ch6NPGeMazzVAX508ZYeJy/OV8/r7unh08QM9gFz4CN
         ig4Tl2v3VrtHIWNORyLAwXpFUJNnJXwlaVd4dZWrdvvZbKs9ZtmIh3JoRn1BpBWz6ycd
         VSUXLS2tgdsAEdiDbQxY0bCv6MtUu/YlzLoNtaoRowUNidrLgOIxUXeyCZ+8zaR8d0Wt
         HcJfmafYo9SYloAfhFKJEz0J2qKtUwaoab2xcewEsog65KZzmdG8LxM7B4FdtYPDCyqi
         OzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728605297; x=1729210097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nh4cL0KF9yExsu8KOk1yBH8TEmcNNSRnVke/5q4xEU=;
        b=fJKf/iKjT0EPgTSZtb00s1wngQeXrY+yXWO/4muI0WRa+u0hx0DopDHKIiPN5fk6EF
         77C2FBFYH8v0x+YaM610JTOaksl645hsMBUCnFgyKtL8OvQfx8I5gvrgD+dSW72qCNO7
         glDf/xqpj4NdnrhBA04g0ilK4ZG2aD7Rcj++YDHcJfsBxzkxSpPc7MxtCr6lZC7SqwIL
         CsTm3f/Q1VffQtcgCKMIc+e2PDgAcODK/iQTgHFrn30CCKBvxfYTOwTEn1+a7RsY+Ra8
         wlcQoap5WlMj3MuBwKjzYu5GBS3h+wHqcMpVP47S6CPdPDINlsNozDr244amkt5OHGtB
         ctKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOABSqvGishZ98vre2B7vmkSU48vwbirvp2kfG/fPcTGxGjc//FfdQEQ0rQ6cW6r3jJxcrnLPwlIpjOMm+@vger.kernel.org, AJvYcCWi2cmHrLyipBNS+XAT0sPeCvmHbhCcBx+YaAzFJ5fXAtPjla/PDDQ98nsMBZdPEbPzOCMHOIjCDt62hxopqurhzNv4@vger.kernel.org, AJvYcCXHL9nciZTDZDoRl0Gfk09FWHV23ANgkUSZbA7s9zbmOg6oHyypTfFuRLRtSMd10Hh7yPI=@vger.kernel.org, AJvYcCXnW0w3C5nrdFYfqCKiHRZnEJCvcqgg7PhvjrcSelA8r5APxVcKNDY1QkNRAz+pTY7iZXbx5oW6VDGUsbv6+nH2@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaxY/Z9xx7vrrC5XR+DF/C6crlgrQT8t14RDf5wiyA10l/Yuf
	nCJeq7jg0L6+Fmcx6dcWyzrCqsQAaTixkksqFZh0dbiNg6+P2iRAYvi2K5nl
X-Google-Smtp-Source: AGHT+IEhJMyQ5+kwReRF5tts7vdrVrQIwphK7fmHz9MuEMkK32Y2vAgf1FBbLfUvBLl0VAASWxHolg==
X-Received: by 2002:a05:6902:2b12:b0:e28:f322:8f97 with SMTP id 3f1490d57ef6-e2919d62508mr675619276.11.1728605297181;
        Thu, 10 Oct 2024 17:08:17 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e290edf37dcsm548028276.1.2024.10.10.17.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:08:16 -0700 (PDT)
From: Tyrone Wu <wudevelops@gmail.com>
To: andrii.nakryiko@gmail.com
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	mykolal@fb.com,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	wudevelops@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf v2 1/2] bpf: fix unpopulated path_size when uprobe_multi fields unset
Date: Fri, 11 Oct 2024 00:08:02 +0000
Message-ID: <20241011000803.681190-1-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEf4BzYo12vao0GPYPC=3SMTzc5c8kZSFCE+D63ACgtjs7QhVw@mail.gmail.com>
References: <CAEf4BzYo12vao0GPYPC=3SMTzc5c8kZSFCE+D63ACgtjs7QhVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously when retrieving `bpf_link_info.uprobe_multi` with `path` and
`path_size` fields unset, the `path_size` field is not populated
(remains 0). This behavior was inconsistent with how other input/output
string buffer fields work, as the field should be populated in cases
when:
- both buffer and length are set (currently works as expected)
- both buffer and length are unset (not working as expected)

This patch now fills the `path_size` field when `path` and `path_size`
are unset.

Fixes: e56fdbfb06e2 ("bpf: Add link_info support for uprobe multi link")
Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
---
V1 -> V2: no change

 kernel/trace/bpf_trace.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a582cd25ca87..3bd402fa62a4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3133,7 +3133,8 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_uprobe_multi_link *umulti_link;
 	u32 ucount = info->uprobe_multi.count;
 	int err = 0, i;
-	long left;
+	char *p, *buf;
+	long left = 0;
 
 	if (!upath ^ !upath_size)
 		return -EINVAL;
@@ -3147,26 +3148,23 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
 	info->uprobe_multi.pid = umulti_link->task ?
 				 task_pid_nr_ns(umulti_link->task, task_active_pid_ns(current)) : 0;
 
-	if (upath) {
-		char *p, *buf;
-
-		upath_size = min_t(u32, upath_size, PATH_MAX);
-
-		buf = kmalloc(upath_size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-		p = d_path(&umulti_link->path, buf, upath_size);
-		if (IS_ERR(p)) {
-			kfree(buf);
-			return PTR_ERR(p);
-		}
-		upath_size = buf + upath_size - p;
-		left = copy_to_user(upath, p, upath_size);
+	upath_size = upath_size ? min_t(u32, upath_size, PATH_MAX) : PATH_MAX;
+	buf = kmalloc(upath_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	p = d_path(&umulti_link->path, buf, upath_size);
+	if (IS_ERR(p)) {
 		kfree(buf);
-		if (left)
-			return -EFAULT;
-		info->uprobe_multi.path_size = upath_size;
+		return PTR_ERR(p);
 	}
+	upath_size = buf + upath_size - p;
+
+	if (upath)
+		left = copy_to_user(upath, p, upath_size);
+	kfree(buf);
+	if (left)
+		return -EFAULT;
+	info->uprobe_multi.path_size = upath_size;
 
 	if (!uoffsets && !ucookies && !uref_ctr_offsets)
 		return 0;
-- 
2.43.0


