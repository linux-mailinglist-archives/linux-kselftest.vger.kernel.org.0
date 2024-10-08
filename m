Return-Path: <linux-kselftest+bounces-19249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7707E9954B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA477B23787
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFBC1E0E1A;
	Tue,  8 Oct 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nicZpQNk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE41E0DF9;
	Tue,  8 Oct 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405820; cv=none; b=SAmJIEvxxnCSY8jmxKobuk6/WhJ1HaM8G06dist5EfxfDNo72uEagIB7pWZryX2FN8eFmFuUIB/9ib5xjBAqf4Bx3FHPPGujOmAbGODpxsFXR7I/VWuKYIIvW6iZqC+v6kC4afWPI0mYaeRO7dziiI4zyvDsvdWYgc1alcm9aPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405820; c=relaxed/simple;
	bh=ip2HXa9xmCCN3B21j3niNv4LwxWSMzYDPlbv1RYVhlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO+DUJdkXdKGnuuE5pW1GoB4GTSt3meM4Ti47uJNryhF3oJYKb88LRjawjQ9R4IgZcwCYA9X0Dx/3WdUCxxuR9Ib8jORK/L46X7gfUgwTjmCAv6r4r3KsvjuhE/lkOL5okPp7psmj9Uvt35O/Le5+X5VFgFDeWgRWoLNYCOD5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nicZpQNk; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e288efeb4feso5221742276.3;
        Tue, 08 Oct 2024 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728405818; x=1729010618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cqyiwrI4E5ZA+HXk656WDotKvEB6Nbc2P6Ubok16yo=;
        b=nicZpQNkj8snNsgFB7ERkuAgC5KbY6BF5spy3/d0Xpbjsstwhb7At3yqzM169IHxDa
         j88EQXIXmw7Hasa8Nr9hdw4EuSX2ygMJOrfFwm9x/e9WTF4lbMfFNvEV0Hw56wJ1CqSF
         dXLfbQ9HmA9pOCoKah/ZtSdb94oIKaB12Vu4utzqq0LHWfLQyRU146OZCNR5bvaRto9n
         NcvB3QNu+IPk8aFUF5BoOQTg3pvvk4o4UBmSi2qrh1ZaPQuo/PwGnqggWNoAwNTHDtm0
         yqdADTCQNHB6ofH9hVzfi86imGQLvILgxnhLQQ0ZzKu1BY4z2uTiOS8J8g7eRgu7pIbO
         Kl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405818; x=1729010618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cqyiwrI4E5ZA+HXk656WDotKvEB6Nbc2P6Ubok16yo=;
        b=R0faCVRlTvjdGJEqSc3+J1KKsGiot8fg4UY9jB8bB28y/pADDf+v0h7tkFgaW9zotX
         wKFbxJHwMvRkDpwbMw2LhIW9BI1qKXuFuv2pLClqrSWHiDFcQAkwMUEhI5ZCYEPbCBye
         6DS2FKdGavlfctmC2FJTRhTQsde4XRMP0CwKPlH9D5WX2GIurAU/cSeziIfA/volKUqb
         x1vXoKGC6I+JeQorHuysNt5EVPU8Xq6Z7Y3XHkp8RTpb81e6V1XjoNBKFDXmXdMRcwgM
         R+OZX1TW19ZTdJ2Y0hx4ZyQICYdHI6aXZxaQhlQh+0PYVP1/Pl5IvnEIhVD+v/Kk76Pi
         QvDg==
X-Forwarded-Encrypted: i=1; AJvYcCVrtt+Xh8joLLPUrstgJnV24Njlb2FpQh5rxsRe0LprrL0pOCf0Mm6o1WHqzCqEeijqbnn2wfWHfyTsLmKu@vger.kernel.org, AJvYcCWXS/WB9Yw6PVYt8iDGAmUuTijcKTcDWm1wc/TEYM0o02+8fo7EYXwxOyFTjPpGDj5EiCA=@vger.kernel.org, AJvYcCXIdort2IpRWN5kYhFrFnurbz/wfSVx5kB2gq0yme2n7YlS/ZHT9o9x0aJMdTYjshIXOCfrwY7dhkYz5SxFf3fu@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwa6Va5EPizDFFnuRoyzm8l1I3Q+U4A+bxdbamkAx8m8cCn/F
	lF2sDvmfCSBBlo0+/AXDgtLqoDTHVcoVWe/dE4zHXq+WjnJVcMdd
X-Google-Smtp-Source: AGHT+IG7/aWAllG4hiLA9U74WYEjaDpy5xc9JrFFpgBfDsdqoUd6RP7Bi+Makr0dbaZHf+gqnd4dsQ==
X-Received: by 2002:a05:6902:2807:b0:e28:6758:fb0e with SMTP id 3f1490d57ef6-e28936dc1d1mr14284674276.16.1728405817695;
        Tue, 08 Oct 2024 09:43:37 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e28e500b5afsm498103276.44.2024.10.08.09.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:43:37 -0700 (PDT)
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
Subject: [PATCH bpf v7 2/2] selftests/bpf: fix perf_event link info name_len assertion
Date: Tue,  8 Oct 2024 16:43:12 +0000
Message-ID: <20241008164312.46269-2-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008164312.46269-1-wudevelops@gmail.com>
References: <CAEf4Bzb1JzE7OPieODoq7H5hg_z2WwkBZo91dyGuRQ56cJ03jg@mail.gmail.com>
 <20241008164312.46269-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix `name_len` field assertions in `bpf_link_info.perf_event` for
kprobe/uprobe/tracepoint to validate correct name size instead of 0.

Fixes: 23cf7aa539dc ("selftests/bpf: Add selftest for fill_link_info")
Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
---
V6 -> V7: no change

V5 -> V6:
- Fix netdev/checkpatch warning for 80 cols exceeded
- Fix Signed-off-by to use real name instead of git username

V4 -> V5: no change

V3 -> V4:
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


