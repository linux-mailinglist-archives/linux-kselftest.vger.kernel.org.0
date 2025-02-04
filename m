Return-Path: <linux-kselftest+bounces-25643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88619A26B37
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 06:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13483166F07
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 05:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38919B5A9;
	Tue,  4 Feb 2025 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9O/D8k2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659612D758;
	Tue,  4 Feb 2025 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738645924; cv=none; b=FpK7+GVNyVXSoeqQ/NeouchA7GFGq4oYerMpVbx0lvonK371zlmVSRgrTvVsH8G9dzlWwKSZkUde1UIraw+r9LkgsHHcnQ4uhk6G96RnFsGOSo8h0EdeRQO0RFTehw9QlykTchIifSjDwVaeUobAucGEevfF95H2gwtiVvopKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738645924; c=relaxed/simple;
	bh=P+HS3tvXUuCkl9UvkJQcQm/GX5GPVo3SVQA44Lwebj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WhkMaA18vdzD+cCCMDz09MB8fgyxA2fg6a4PYjydylX0J+YWDmH1zOSfNlpCDSjimMYIn9v9qTKlnWAUsi0q1cyQtawY9LQ5ctcgc+Li5/8FFnn2VQyhbyXj96WPqvZ9cXb5Gh71cJpBBMKM/pi6qLp61PaL2s9oxZf6apZbnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9O/D8k2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so8667799a91.0;
        Mon, 03 Feb 2025 21:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738645922; x=1739250722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjCdLTZsYDp3yhLzAisxUBlpFhW4ps3XC5YtBMFmxaY=;
        b=C9O/D8k2pVJZS350A22Rd4A6reSujaO5KAEJQSn86V326HWHPeZreA2NXjE+/0G+ib
         oM/z5EXE7vD+Pd8LSpUZXxPkp33T+S9yAgGie8woGmMArAYb4Vsd6DP95JPcHVEG3klV
         L9L15/U8XXIJCOr61DFa6p//XWsMn0Sm6QsR/ViSVe+3dQpY7MpX+pyK4QgmjgBQbSW6
         cNgAUEcWmSR9IfzF5MS7G7vOTMyvn3KY2pvK7qVmyQIX1fiBnSqoCXFTKRX894v5yPDK
         XdYKRLcL4BeTh/agIjxWIihYOzr+lHv9Jxpu+074vAQUb8fTLgxHk6HUB14yHbMBI0Ak
         va+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738645922; x=1739250722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjCdLTZsYDp3yhLzAisxUBlpFhW4ps3XC5YtBMFmxaY=;
        b=H/LDjusbfL2tSvJAyVmfrQTjc1Z1d4yUr6MG9aDohBrK2/XUxCzm0pxZ4hGz8MndW5
         Qrzfv095msJ0P6vqdPbETbhDVZCQGVk5coWb3rZbkWZ/Gwp36zfi8iELEt43Y+SJ7VBK
         k1tg/ZSCpr9Z2lJw1+Ym2CCE662vrRC1JWOZDNygH2fqg8Xe04o7fwhx7kS7XvHLIepK
         A0M0Bsu6ZEyChHivV/FOAOhxOnGSus4Qng3Ku2SRwYhx24czNtZKvcgg3/ZEhFk4UuSK
         ctM2v9bwqouT7vWOpVO/M+MAgOEqdS6Xvo7YAZu75DzBUjkTOYRwtV/6WBJyOerK+r1y
         EPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJh2X81i1Xkwzl1JG08UlX6J2OyaaaNcuPq12qiuJ5OXy4WY+p6tLMhF+GVGGSb6YHNi6WIAHKDre/ZLkvquQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5u0qsnv35LQZeOrXifWxjVt3Bz7A/nbFcDwSj0yvcJf2gSBie
	8p8HFZTyGH+DIkt4nMcopen3dBh5sTIGO5RK6UJeJNUJ/je+mnga
X-Gm-Gg: ASbGncvQuWVTUCXDl50/AQkcAFlQSKbuZuwVH8u6ee9OwFPBOT0/leBJOcHUD7FdhwN
	udH39PCeZeWIPkVAWtgzLEnICbfNS/tig5hyCg3joarHpCPq7NB0Xdc0w/HabgbaTmYYCNKRNIs
	vJ1IOmIgnIc4kkPte7kEZUr8JnV46rjWMsC5rE0LQbNRxLkzIJcXxsXEjizQ2TNea6wzCwwDSf0
	jl0qDDTPXqItGAZneNHqfL/LTVkUfqYpQaNq6hrtGt2CNsr2Mmn0dSWEb64fPEOZbh76CKlP+BV
	qRlLVobW8XjTUIsy3NiflvwOKdZ1An+xLnU7h0cDTqJAaELryoepmg==
X-Google-Smtp-Source: AGHT+IEi/Ok3XzcF7tVGzJAd7WOeL7g0wyeB+u0+SeOMEO1ApMyV2zKtr0T87RInFhnwZD5m9BPqGQ==
X-Received: by 2002:a05:6a00:391e:b0:725:cfd0:dffa with SMTP id d2e1a72fcca58-72fd0bced35mr36478637b3a.5.1738645922179;
        Mon, 03 Feb 2025 21:12:02 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe653bbe7sm9259240b3a.74.2025.02.03.21.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:12:01 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v1] selftests/bpf: correct the check of join cgroup
Date: Tue,  4 Feb 2025 13:11:54 +0800
Message-Id: <20250204051154.57655-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ASSERT_OK_FD to check the return value of join cgroup,
or else this test will pass even if the fd < 0. ASSERT_OK_FD
can print the error message to the console.

Link: https://lore.kernel.org/all/6d62bd77-6733-40c7-b240-a1aeff55566c@linux.dev/
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/setget_sockopt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
index e12255121c15..e4dac529d424 100644
--- a/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt.c
@@ -202,7 +202,7 @@ static void test_nonstandard_opt(int family)
 void test_setget_sockopt(void)
 {
 	cg_fd = test__join_cgroup(CG_NAME);
-	if (cg_fd < 0)
+	if (!ASSERT_OK_FD(cg_fd, "join cgroup"))
 		return;
 
 	if (create_netns())
-- 
2.43.5


