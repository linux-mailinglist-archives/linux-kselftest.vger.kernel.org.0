Return-Path: <linux-kselftest+bounces-19407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A993997834
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 00:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC518283D77
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637F1E3769;
	Wed,  9 Oct 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajlEsEXv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA81E32C2;
	Wed,  9 Oct 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511624; cv=none; b=Z7swuTHjq55r9KEXNFwT6+Zfd30X4I/1aFYAHQ9b7UFZZMBTpmfRb98ZRLPJ7Auaid+b6lzDnIOx2wgGSzJdy4TVL256D6y9yZOSbwrn0EN0wq3b2sEIUKnN0zcql73mi6ZnZBhgKskTh9HeE5vYFfzQUVUMdPu3Dm5LL3VOORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511624; c=relaxed/simple;
	bh=vamGcFrPRyfG19X12b4a/YEYp7dSMGPkZd9DEbWGDM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT4lIL93yA2zAVn7J/4NSOspyNFbP/C0WxMKy4YdFyVpPX1r+G2sr70ZIIob9yXeezas1zbF2KYdQqcZAxh/QbNjH2kQMXfqbkDsAecavQLgMCHVQ46enho42ieNLWt3PdqpX8tCbM3qA8FSemFHAW9Guzxnaf7KKlIK37drNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajlEsEXv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e330a7b120so1330677b3.2;
        Wed, 09 Oct 2024 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728511622; x=1729116422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZGOsm3YR+E73cJ0SGQHJhXA862v5jLb24Y7Aj3c+FE=;
        b=ajlEsEXv09GzmaWk7BNIG7MOsyUtIRZhxCmwbBmLHgxzH7gXRbMrPYD09E2cml2/2C
         rppHWyTMrib4L5omndUWBS3ltg38VLVjVnH+3KTIJT9nbsKbv/spAEF5kOn0rNVBbVdg
         6hru/P9KlKBp8T+DP7roHnxMWtOVWuMrP19siLbIKe55SdwFmagMt5qfIzIT5EyEBQoC
         FzUCJU+OzpB2Z8/kckZ3FamC35mPUszZwwB4A+AOcLBHCQk5TPR7pYjdTrfAYvSIC99c
         rSwcTqDSSDGMw3o2l6phqZj/0uaWZbBqm6OtI17z60iTgSZ21ezOWdHlxUdEWUN5PxK2
         jEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728511622; x=1729116422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZGOsm3YR+E73cJ0SGQHJhXA862v5jLb24Y7Aj3c+FE=;
        b=M0+Jvd4CDBoDcyV+K4YmxWIVwRFhUO+aooaYg7r0NwsCpkf+9EKZeiRCvqyNm4qyVM
         ub0GMvfNGDnGhC9646wtwAFpbZZEhXrgtJGcFRfaMx3upgzNn01kwwZmJTPxC7DhmOxW
         Zr8M7n6Cnb52OdTzUCAfGqjgoQBOQE20SxG/OkzddtcohTF5EAa5CL4A+aw70yh3fvwr
         FkZ5WpTLv/7mk+zWuKXyfpfqDZUPhzEO+LHYaq8143H93LSGtG0IG3x/14QlgFMpsiD1
         OZx736HyOd9wjMBPZgcml81OAF8Aih9TGFFGKQAPNuHvkSONgoFOl8c0zDB63P8omDAQ
         rfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVffa/kvHoihrrMi0R6PehurCp7U1nvz28OBeikQ/sWOgALUvTdlV97RCXntxJjy7uh4RUG2rZlJdJjaBRY02Lv@vger.kernel.org, AJvYcCWaSU2XtXLrKFpfEIItrLUFqfV+7VOo1L/EUjE81c55sYxcMUpv5SZwDm9abkDIPFa1YTM9Kuyw+hDYvO4=@vger.kernel.org, AJvYcCXSRIPxkHQt7BLPn2LP3UbiCqjmfrDHmfHhR+6r7Ym3vO6jdv4WAyZiRab4k+3KZm21PeoJFr8VEHoNvxzF1IgLXTIO@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/rYjuNqUc1/X7D4RT6sw1DYGFjr0WKrHR5XDjTU3Pz5rqC+j
	OYKxGUUowJ96JtsF4uWI7a92mRsY0EXV7NtAJn4TUlNSL55xskZheU9t06FB
X-Google-Smtp-Source: AGHT+IF1uyZrUK2/Sy4TPteRgeer5kAxQj+FQiPxRggZ89itv4Zhagt8kBp2ymbhkdbDtg6qJgOcpw==
X-Received: by 2002:a05:690c:113:b0:6e3:ceb:ce2b with SMTP id 00721157ae682-6e32250ade9mr39798427b3.44.1728511622150;
        Wed, 09 Oct 2024 15:07:02 -0700 (PDT)
Received: from dev-ubuntu-0.. (104-15-236-76.lightspeed.rlghnc.sbcglobal.net. [104.15.236.76])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-6e2d926b44esm20294217b3.16.2024.10.09.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:07:01 -0700 (PDT)
From: Tyrone Wu <wudevelops@gmail.com>
To: bpf@vger.kernel.org,
	wudevelops@gmail.com
Cc: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mykolal@fb.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v1 2/2] selftests/bpf: assert link info uprobe_multi count & path_size if unset
Date: Wed,  9 Oct 2024 22:06:38 +0000
Message-ID: <20241009220638.333429-2-wudevelops@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009220638.333429-1-wudevelops@gmail.com>
References: <20241009220638.333429-1-wudevelops@gmail.com>
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
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index f3932941bbaa..a38cf2a999fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -417,6 +417,13 @@ verify_umulti_link_info(int fd, bool retprobe, __u64 *offsets,
 	if (!ASSERT_NEQ(err, -1, "readlink"))
 		return -1;
 
+	memset(&info, 0, sizeof(info));
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
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


