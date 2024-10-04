Return-Path: <linux-kselftest+bounces-19041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855599907F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 17:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EA92847D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738341DD871;
	Fri,  4 Oct 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMlonaRN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3B1D9A6F;
	Fri,  4 Oct 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056421; cv=none; b=Sv2FgCEHrEXEgdXrUBUv2HdgmVRMlhyL7Zs/dSABBIuumtZwN2kmoF523uwsg/RoRh4lo/1y3wUxnab2h9W2tMYcMlu8LSKnzp5zRJ21JoEb3r1/n/DIAD/GcuujZErAg2RfgjPNBFiwhzcwixT1j6DYBfs7OuMp3zB9Xsu/ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056421; c=relaxed/simple;
	bh=OySBO2fdgm9NInb3HLtlVZ9DT5rqfr4CjyzaYKoX3HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7H6MWWYib8bN1nE/TBfTWRhyCIskcZ+brgb2x7a51E6B6FdetIvu1+lPHCOnUsDAqLr+aaQm4cz1zZcsrw2231V2RmSf5pILnOALqvpwUkn1tRhuMdUEQeAWQL/8K7b0i/j/RBjAoEp9+GNadNEki3L6iyqDObigJh8l3h1hWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMlonaRN; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25e4023cafso1755555276.2;
        Fri, 04 Oct 2024 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728056419; x=1728661219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNfDutvQ2rKfjQOG2zcCXcBclmjuCvlaQWSIPQ4D/Ng=;
        b=RMlonaRNP8WXJUE+TCATelDCiPgTheKgi+OtnYaeJUPK8MBnW0c2VENxLVkLN1hsF0
         mpMZ2Hwg/CGaScx62CerFpZM8YupAW0MQ5aUITB6fS9LbUWT2m8AQEDtiFHR51JIhxfk
         Bu2Q58fkon/qHh9RUGFja9DbmvNqc3as2P6z/CfhfMaTRRiu418Of3QXITuSZJvq0Dq1
         +YrEfegoq0exObqK4/RTaXCeKBBdF7FJYmZe8TIqvEv/6l4rUzo8vX6CZ7x3TOBRdW2L
         0io3BDVDy7hLjeOA4SqiO9L10llhXpDznXjNcF1SA8+W9IRVPkb/dHCqv8zI9sCeS8eH
         bkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056419; x=1728661219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNfDutvQ2rKfjQOG2zcCXcBclmjuCvlaQWSIPQ4D/Ng=;
        b=oP99qZci4zpGOhnxUzO5vjfDiyxEmix42FGZS0rqJfoLbFIgtNWAluGQecybxYJPC4
         EFVzSRTqlOEvdcfB0LYBx7YgjaEwgLoBv04w4RhTLoDBb+s+8vt5WUe7WwPw815fp2r1
         VtcCMuDqvHUOH5GJXlpt2JjnbWe7BjLk+GUDoDn6zH0LhIFtgInhAU+VeDYYfs4Wb9GA
         VgVDx9DZnUMfFsDZOEMOb3svrQQflPJ60CjsGu4B8OZeygW0pkiAPJHJaOZ6nkza2Tfh
         Q+e70wF479mS0qKUfabAcX9zdA7XnGSuPMGPWl6jObVZOoCWGDnC3Cqfwxm4ZuVrB9Mh
         v6VA==
X-Forwarded-Encrypted: i=1; AJvYcCUWz8PuBJj6TImnMTyYnhJTxbCYgFfgaan+DoxzRK7fIEmKZZC2H4tKDra+FIpXPlvCgVQaGDR0Ii+A6+xt/f/T@vger.kernel.org, AJvYcCWFTh9iZxYGvtaL00SORbpkWzYKQiPVuocbbTJ77zC+A425znpvNBt4P6IiEakyFUdO/9aAOZvBl8K2kVhH@vger.kernel.org, AJvYcCXXu8WRJkS6lc2QI4gLHfORlLkUlWFJX0kfLvRcgQQz/t5KLBv6pgC//HwiPsN66A/EOZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7esL2K/bjfnQabDEW5BZfv59ewRFn0lopvOS7LZboMBvUL3qK
	zF9T8S65Nd/9NW09XN5QYasMlUDRgBESoK8sIhzU7YM9j3al/+4I
X-Google-Smtp-Source: AGHT+IFXt8KkAyFmo7MmvW7gQumVXcw0rlAOCqK+TX6tSIAyGU+AnrIQn/iu8EPyg9c/UT8GbyN6FQ==
X-Received: by 2002:a05:6902:200b:b0:e25:ce91:52da with SMTP id 3f1490d57ef6-e2893922427mr2093664276.39.1728056418745;
        Fri, 04 Oct 2024 08:40:18 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e2885d2ae37sm628475276.20.2024.10.04.08.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:40:18 -0700 (PDT)
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
Subject: [PATCH bpf v4 2/2] selftests/bpf: fix perf_event link info name_len assertion
Date: Fri,  4 Oct 2024 15:40:02 +0000
Message-ID: <20241004154002.10979-2-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004154002.10979-1-wudevelops@gmail.com>
References: <Zv_PP6Gs5cq3W2Ey@krava>
 <20241004154002.10979-1-wudevelops@gmail.com>
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


