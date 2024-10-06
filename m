Return-Path: <linux-kselftest+bounces-19135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A39920F1
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 21:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4E91C20AB3
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F418B499;
	Sun,  6 Oct 2024 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhaMyNpp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510A18B477;
	Sun,  6 Oct 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244304; cv=none; b=kip0Ewh+RgXksqxuoysVk8LYG61UleovLF+/Q6SClUFdlGEtERSoauyOgks3og41m+t2YBEssokv1q2jH3eypW9+8FzycxVujbEYoQAPg9DyaOPvLXsYjdY0jpSj03fDxb53FVbWYvI/fVw3pWVVW9BmzyqgdMVBVyBVARytquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244304; c=relaxed/simple;
	bh=F6qNZ4jlOg2hxLaEoE0zteqiQizJ32UnDSEHdaKR2+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbL8CHQawZ0j7AJyq4cyuYxrju4I+eMyacJOtM5QS2sb7SjvHW2HCn9p/ucEibDDyXvSk5K+/IR4msfmxMKZrVxwXfza71ikuzsLwgFLV+9ExRf1RtTE7xFbaKRnWbD2Q0bbkPGcbH74GFJf1oESsGX7AxTGRhQrpwDl/9KZHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhaMyNpp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e232e260c2so30174547b3.0;
        Sun, 06 Oct 2024 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728244302; x=1728849102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgmNOd8EkUBDOGblASHH/LKqu14LjdmFfgpTO4kLaMs=;
        b=KhaMyNpp0mZ6Ksyy52MqrD3D4FBKMeRK5QbfO/Qeu8uux4nyFJP6DTHe3wHCw4Okqr
         /A5jf3Sy5gvENWT/J1MAc4jrFPdJFta1/hm4KFYyS+a8+s9SQjtrsYiHQit0axumk3Qd
         eDjbg4/4wVymW5HXbeiCAfSWLWgTJeCzlSZpu3BjwzD9ZpHqe8lia3IyjXq3pyI6Q9Ob
         n9f8X9ivtXtFMeuksPQLnmtfPQeJTbNhVITCfENVRAMgpJgGtBNwh3C1eHcSN2REU+xQ
         qBydBJ+zF1YNbtR0qc8A1Hbz/Qbkidm9s05Q0e6al4IJOon883ixZUstHUH80TK51dEt
         u/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728244302; x=1728849102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgmNOd8EkUBDOGblASHH/LKqu14LjdmFfgpTO4kLaMs=;
        b=q5oouMGeaMInUAFbIOsSLxyhilvjwqzboOfI4ZPKfZHpefhpsb3AdpVgkt4RMo7lsd
         K9VOJxHBInZGLiXVpw1YaLlfW/I5+S3CsqYNKpEtK+EhNYZ9abFc0Y7lHC0k+RUKgLFb
         b/GV+2zCb+iwghdwEDb3w1zS1SlW7oCIE64NLRVfClvkab9YzOL6xapxy5+OuD4y4m4h
         oCQWaK0jvkolWJUSC7mCGAUepTiJxsgIh1VxNXot4X5za6v0mVLfKCBcHcVxt627c3Vx
         5c4UNwg3/fX9IXuP/JFoaMFy7j6G9lj3Rx9GCbC4h/bbJEIPu0iykvSOoV/qae/6sxer
         JMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Y2x07NYrjqmI4p0QHuLvYvETABDExl4CjLXXSwWXubk/zEqmMk74KXPVWMAFfs7o3yuyay0wXd+HIT48@vger.kernel.org, AJvYcCWWlEbu6NWLL4IDIRovlzNDCQfEu/6PXTVGEDde44d3D64GnH3zHkxuUoLI5IWzi59SJJU=@vger.kernel.org, AJvYcCXFb3lCHVpj2Sn+37dGeY6xLn5/U8u+80akIYgrqZARnmCILa722mbZiVZ05C60j3MwFPFViHjwy2RNueksC+ec@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJ2gvEJdRFpQPFTAwx91PIgME/UPPNUWbXk9yUrwoTFKc6t9r
	31hSGaYI/WMYHADOzU2Ko0Jz/ej7taTfWM918kSWK3sDAp+KEBPw
X-Google-Smtp-Source: AGHT+IHJ4Y+l0uGKYZTgkpq8oWf7hB6gKjf/FcldLHpxWSCpLotRWX+Op5SKYWGCGwO6pYnlcfvGCg==
X-Received: by 2002:a05:690c:d91:b0:6e2:ad08:48fc with SMTP id 00721157ae682-6e2c6fc6ad4mr79656147b3.4.1728244302288;
        Sun, 06 Oct 2024 12:51:42 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e2d93d6effsm7811297b3.100.2024.10.06.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:51:41 -0700 (PDT)
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
Subject: [PATCH bpf v5 2/2] selftests/bpf: fix perf_event link info name_len assertion
Date: Sun,  6 Oct 2024 19:51:31 +0000
Message-ID: <20241006195131.563006-2-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241006195131.563006-1-wudevelops@gmail.com>
References: <CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com>
 <20241006195131.563006-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix `name_len` field assertions in `bpf_link_info.perf_event` for
kprobe/uprobe/tracepoint to validate correct name size instead of 0.

Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com/
Fixes: 23cf7aa539dc ("selftests/bpf: Add selftest for fill_link_info")
Signed-off-by: tyrone-wu <wudevelops@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
V4 -> V5: no change

V3 -> V4:
Link: https://lore.kernel.org/bpf/Zv_PP6Gs5cq3W2Ey@krava/
- Split patch into separate kernel and selftest change

 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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


