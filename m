Return-Path: <linux-kselftest+bounces-19176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 050C399363B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 20:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE771F2391A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC481DE2C4;
	Mon,  7 Oct 2024 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEFMvpmz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BB1DE2B0;
	Mon,  7 Oct 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325787; cv=none; b=CgIc4UXsBTRNO7ec/5S2SUYJWUM+vOJIrTCZDOFe7EXVMNVIE7XKuRK8Zi9C/7dEHt5zRfIWeA4pao8iUFnxF7SnYn90gFHjx4vc3gFxd3vXOXuEic39ul3gl4g/W53i9ayqjA6Cs+01FPpehSEJcIwPhedD5cCHGXlvsuEubvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325787; c=relaxed/simple;
	bh=ri+5vORU6Z2647LmAWlxJov2NHRhwxzdffD+zF2ft/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcK2r/wjzUCS/SV+C/+k0q4YKaqEcME12u9LGH3LPDivGhoxWKB2aCMOTopnt70NYnXnAgaPVvfV/yYj5FPQ+KjYsBX5aut+Jm9QQJRfVCZP14jKviHzearxlC7kMMgaZlK9kYVRYSfFWJeGMnJw9ILQBKi52sTmy4QMQFbdnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEFMvpmz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e427b07dso14913567b3.1;
        Mon, 07 Oct 2024 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728325785; x=1728930585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LeOq9745w+enIdw7Sz/F2+ECUOxh+AVgX0peJ2oj1k=;
        b=lEFMvpmzU3H9pGjsLSdBw0pHm399e/yZwjq4iTiAbFw4Oqj0AuIMv1csPJBMZKOymt
         iS71yPjWPVxLfBiP1YAdk5Qi4px4rJ3aFJyByGoDqTRMyJCgXQD9EpoVNTqSnwfv3L61
         dSTD8GBBAvQSaotnPUaX9uOFgtvD90yVDgDB0kB175c/8wKAgQrKH1zEgXeuo21+4N0j
         v+9WT1rEIoYDjrGDIUvBrvjP/tV3qEK+/0KkxqIUyE//d/gF+iqmQZt+iN2LzV5RNQB3
         nFzsCV7S5uMtM23vSrjgY3YQ4qx0r+2gZA4tZ6HPa8L/VlYMZciZT8QGxwx/RE6JpvHp
         TdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325785; x=1728930585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LeOq9745w+enIdw7Sz/F2+ECUOxh+AVgX0peJ2oj1k=;
        b=sBq9NVLiG80c0mx1KYWhwVmIvpE5O9fYB8xn1mEayVbmzuzGfKZoo9Vsfk8bf15tD2
         AGzTS9wLuHvRfkRlJ38/bWnCYVWOtV4NA8Ccl39pyVTerl00xr0UkvremfQpOcmf8oNU
         gYq2zv4X5Z4gl72FN+N1WqZW4/cIHGOWRvsywaHyHaxJgXOPVKPI7RzbJu8Rv9ppzfw4
         SfUfzV1oeeSyTIh+2NJpjm78SGGOk+qHgDACGS+xbEhYRAYm8peHxk8x8IlqGli1oBI5
         n+wr7M2DxJt93jksOkgf3TqrSuUJYwtREES19YX2tfewrujnbRAG27ut4Pw+b462CFRU
         jkSg==
X-Forwarded-Encrypted: i=1; AJvYcCUFPK282tICUHPxr9GNxmFpfMchjuZ8cv8AB2WBfRjoxUnUUJKhchv28BS18HRgujHcYXWre8jDyt+1LUcIUgQK@vger.kernel.org, AJvYcCUm3UMBY7wGgMCk7xMtBQBbfCi6visoJZjfRJtCs0vSRh4nv73JZrCDzlKL4s1ni/FE0XE=@vger.kernel.org, AJvYcCXRLsOXn7jN2ZI0eMo8pYykGq06n4PBfgbWBeLnQW81suEIb0Y7YiXvvETRb3YINk1CVg86I09GXZeNzPQx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3JITimgyhcjDfsHZoiY3ESrAKxNRsbYVJCdBw4IRZEBahsSP
	wyFD+gZXRO6PkMl3mBSXYcBc1xp0zPBhm+C3088f5J1+mE+eq08k
X-Google-Smtp-Source: AGHT+IHsVRojMWv7By7eLdIuLyMLlSGHYgCYoelDriLkYh6zlfLF0oGcJd07xxEL2NOkDe8SdUEMeQ==
X-Received: by 2002:a05:690c:2d05:b0:6e2:a129:161e with SMTP id 00721157ae682-6e2c72b1c93mr80206977b3.43.1728325784973;
        Mon, 07 Oct 2024 11:29:44 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e2d926aec5sm11377977b3.2.2024.10.07.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:29:44 -0700 (PDT)
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
Subject: [PATCH bpf v6 2/2] selftests/bpf: fix perf_event link info name_len assertion
Date: Mon,  7 Oct 2024 18:29:33 +0000
Message-ID: <20241007182933.8841-2-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007182933.8841-1-wudevelops@gmail.com>
References: <ZwOWs_XrBtlTGE24@krava>
 <20241007182933.8841-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: tyrone-wu <wudevelops@gmail.com>

Fix `name_len` field assertions in `bpf_link_info.perf_event` for
kprobe/uprobe/tracepoint to validate correct name size instead of 0.

Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy16-yb0Snztmtg@mail.gmail.com/
Fixes: 23cf7aa539dc ("selftests/bpf: Add selftest for fill_link_info")
Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
---
V5 -> V6:
- Fix netdev/checkpatch warning for 80 cols exceeded
- Fix Signed-off-by to use real name instead of git username

V4 -> V5: no change

V3 -> V4:
Link: https://lore.kernel.org/bpf/Zv_PP6Gs5cq3W2Ey@krava/
- Split patch into separate kernel and selftest change

 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index f3932941bbaa..745c5ada4c4b 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -67,8 +67,9 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 
 		ASSERT_EQ(info.perf_event.kprobe.cookie, PERF_EVENT_COOKIE, "kprobe_cookie");
 
+		ASSERT_EQ(info.perf_event.kprobe.name_len, strlen(KPROBE_FUNC) + 1,
+				  "name_len");
 		if (!info.perf_event.kprobe.func_name) {
-			ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "name_len");
 			info.perf_event.kprobe.func_name = ptr_to_u64(&buf);
 			info.perf_event.kprobe.name_len = sizeof(buf);
 			goto again;
@@ -79,8 +80,9 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 		ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
 		break;
 	case BPF_PERF_EVENT_TRACEPOINT:
+		ASSERT_EQ(info.perf_event.tracepoint.name_len, strlen(TP_NAME) + 1,
+				  "name_len");
 		if (!info.perf_event.tracepoint.tp_name) {
-			ASSERT_EQ(info.perf_event.tracepoint.name_len, 0, "name_len");
 			info.perf_event.tracepoint.tp_name = ptr_to_u64(&buf);
 			info.perf_event.tracepoint.name_len = sizeof(buf);
 			goto again;
@@ -96,8 +98,9 @@ static int verify_perf_link_info(int fd, enum bpf_perf_event_type type, long add
 	case BPF_PERF_EVENT_URETPROBE:
 		ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_offset");
 
+		ASSERT_EQ(info.perf_event.uprobe.name_len, strlen(UPROBE_FILE) + 1,
+				  "name_len");
 		if (!info.perf_event.uprobe.file_name) {
-			ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "name_len");
 			info.perf_event.uprobe.file_name = ptr_to_u64(&buf);
 			info.perf_event.uprobe.name_len = sizeof(buf);
 			goto again;
-- 
2.43.0


