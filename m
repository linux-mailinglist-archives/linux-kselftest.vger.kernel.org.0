Return-Path: <linux-kselftest+bounces-19486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B469997CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A52B1F2363B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25BC1EF0BA;
	Fri, 11 Oct 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df/iC3wa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486ABE5E;
	Fri, 11 Oct 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728605302; cv=none; b=rd1OBAWv/apBQr0egjDqB76HnSZIhqo2Bp2bCXnT79xuPncwR9/tncLSVcIuRUWnmsCijLBupZ3aRgmU/8pxwx92KHzEeoAOPt+kRMzH4JNlc59q/9RVZouzm37hH2MyPpTN2egN0oOL4qLbiF/GwrPTkeBtUSrzyrV0iXXVPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728605302; c=relaxed/simple;
	bh=ZVEfdiz6c4s0EMsLl5NC5d2FujU4f+4LZAUMJpXdVPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx0VNemZeBLUV/GBSb0eZhyagX+7bFUkw7cGIpucnfz9/m/qhhm7MzoWe6ApuLYofGfNXVbG1tigBiR4P84/w/bx8coZJokhefLFRFGIlAF/qF22S7P9XeyyWX4HHIyDjqZUwxwkZtnmuBdB3yyckSKmnVfSDgz8Gu2t5JWXMV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df/iC3wa; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so1398112276.2;
        Thu, 10 Oct 2024 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728605300; x=1729210100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JR01YXV1P2okZLmugRB7I4AbkNbyiLPSpahOb0ItU8=;
        b=df/iC3wafK1NVWea1Pf/ptA5MExN3qkbNIlLRzvUqbFx5DL8Y/MVaatyi8vvfSTZNF
         2bfT2XZ4s8v0DZh3bG25HvYBpWSyj4LvDHLxbZUqz9f3A4tOHQoGR0j+SjwSJVLMhhpZ
         T2vqC0L8LVGk4x4Swu9QVQ2D/eOjYXlendmCc9YYDY4yAf1OLHRtfEhBMeymYmqRN6Wi
         XssEdqWmFO8ZKyleEu2q3e2VlSjCeLFmQw7eIsfX9Jz/ARQtj+lrMYos3KDh37YtzBJC
         9r4s4xXNwZ8HU1B7kf6gF5+vDUNRNjETqyajd38lgJq+z6T7eH/9WU4X9q0SrdMEaa5X
         Z8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728605300; x=1729210100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JR01YXV1P2okZLmugRB7I4AbkNbyiLPSpahOb0ItU8=;
        b=a7aAm2lEWxNsCgvEAx50u3vNAd/53eIY4/6lRDTOnDAJS3RKok9kEiz9K1w3JohQTO
         uCWuoi/F9VJPp1P2SjbegHzrjg+zogdGZkovRg6Psoki7u0W+KpJIFjfQE6Iptia2wbX
         daJ1cIPhFOd/AhcG7Cp99tg6Uns8GHPAgx7Ucqf4g3Vu/sOwy88uO8g6fpjvoUlmU/WF
         cewg+TCk83fDrnbnZHgTYYb+Sel2CkAtNt82FPvtt1HzlUNy6UZCF9wrUMQn6RcOo2lT
         lSAozc52+iZlewnyeRO6PjvOBFleNSW/8/MHx8fHUn61r9SzEzF5CKYKslSSrfgS6336
         CF6A==
X-Forwarded-Encrypted: i=1; AJvYcCUJUBel8EepFbSnraSrWIOvjlJiX5iNCocXv5vrj8FhmFMWZ7vFCqu0te230tFrsbXDprwV6fwrO2upyXxf@vger.kernel.org, AJvYcCUq5XhGsJhPGqIowNZh59tfYcjR0tyoluKkjbAo35wVUgUiIUvBuyEKLFlUUA8p7UdDep4K5w6wXzCkJida3dmq2Lu1@vger.kernel.org, AJvYcCVuSFCHSQtnMUZvRe33D3cGrQje2sYoVXObp7u+Lp/AetsI6grUiyf2NNP9JJU21hb6UNE=@vger.kernel.org, AJvYcCXSxcTrHRtSeJ1U954r+y4Y1tXnRQUgqzJoho2PrHyGgkwaIzZsaHclOgE20ziy1GuqVK064aKQ3i49GrqnIFB5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76Vv2SKCHrlE9ofFbG37BDXxTg1J0RpkZ6sqg3NS90ETTOR7U
	gGICQmkPKfD9HeuzuFKpN9QrMFQsANYZWfiG9VdK7k0/BouV8/Ha
X-Google-Smtp-Source: AGHT+IFwDWFQTYbCMg/5uEcXYx9WIfItSgCBpQ+5PvxXxZHKQcRO3JRwS9Ecz4+YSnkK9upsXsacjw==
X-Received: by 2002:a05:6902:1021:b0:e28:f132:3fae with SMTP id 3f1490d57ef6-e2919ff3fd0mr778508276.48.1728605300083;
        Thu, 10 Oct 2024 17:08:20 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-e290edf37dcsm548028276.1.2024.10.10.17.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:08:19 -0700 (PDT)
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: assert link info uprobe_multi count & path_size if unset
Date: Fri, 11 Oct 2024 00:08:03 +0000
Message-ID: <20241011000803.681190-2-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011000803.681190-1-wudevelops@gmail.com>
References: <CAEf4BzYo12vao0GPYPC=3SMTzc5c8kZSFCE+D63ACgtjs7QhVw@mail.gmail.com>
 <20241011000803.681190-1-wudevelops@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add assertions in `bpf_link_info.uprobe_multi` test to verify that
`count` and `path_size` fields are correctly populated when the fields
are unset.

This tests a previous bug where the `path_size` field was not populated
when `path` and `path_size` were unset.

Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
---
V1 -> V2:
- Verify bpf_link_get_info_by_fd was successful before continuing with test

 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index 745c5ada4c4b..d50cbd8040d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -420,6 +420,15 @@ verify_umulti_link_info(int fd, bool retprobe, __u64 *offsets,
 	if (!ASSERT_NEQ(err, -1, "readlink"))
 		return -1;
 
+	memset(&info, 0, sizeof(info));
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
+		return -1;
+
+	ASSERT_EQ(info.uprobe_multi.count, 3, "info.uprobe_multi.count");
+	ASSERT_EQ(info.uprobe_multi.path_size, strlen(path) + 1,
+		  "info.uprobe_multi.path_size");
+
 	for (bit = 0; bit < 8; bit++) {
 		memset(&info, 0, sizeof(info));
 		info.uprobe_multi.path = ptr_to_u64(path_buf);
-- 
2.43.0


