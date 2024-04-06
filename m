Return-Path: <linux-kselftest+bounces-7328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE05989AA2F
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FB51F237A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CC4D9E5;
	Sat,  6 Apr 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mM545qlW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40943FBAB
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395239; cv=none; b=cwr2ICVblGtIe1M/w/bXpdixdmWMhyXudiL1aPMKC9SroNEL7DhjHEU0Yg6UhUsjRYDVN+MX+yUx8hYqOPVzgjvw23ASLUqsHc9shX7wECPp5YzFVUZkpAYv8ibXkqaMzbs9d4X5kafvCVtyVsh899gaTR4XNchxI0NxFhCs58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395239; c=relaxed/simple;
	bh=V866d7v0EUjhFe+hV0qrTNaTJ3Gb92BOJZHI+Gz3L24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbHvuxh3zV8VQiqTNS3oseXcl2ulAHDncaDX8/VfjV2L4bCLMBkURbu2MPolkeRTA/TpZJf6eyKQJy42RdhihCRohX9abMF38brW2QUX5NhbSCPcEJgTIbHUILDgtMK6WFdRk4oVXt7vlmkaXJbmZ/0iiPuG0iGoWsl52OGF2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mM545qlW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE38C3FE6E
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395227;
	bh=qzaONF2ufkMLEwxVO924M3LwWzApnPaibbBgBkLZGxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=mM545qlW3sBhsM6ijJRuTctVG+fj8CpnjEi8FIU9SrXVgargOI9GX4Q8CyvLf3xJ0
	 1Ji/SAhIKn7TAWTqMDBlBRWWA7KnBn5/wfDzkNS44/5euaHQMil3PmgD/ilEppj/8/
	 rZMwKyKggcg1Op7XBK66RB0w3hEwR/XCs2F1BEsSpgXnM/oZu6g4qFQA3OFjV/iCpz
	 YI4TsL7q0Ky/hAwYTw/dSNgTkCRaI3PeH2t2y0bYlZgyOVDNsfhhjr48hoPYLfvqmn
	 rfn2rsLP3mvwUq9Oe+tvM4v4bsP5aRePpejviUqys3C8rTn1EIu+DDI+yS0NEdMtCa
	 vWj057L+JNolQ==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516ce32c90aso1968878e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Apr 2024 02:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395219; x=1713000019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzaONF2ufkMLEwxVO924M3LwWzApnPaibbBgBkLZGxs=;
        b=ElAL7V+K5ZH/vWhY+Kpxtawi8TtIUEc2n6rAQ+GslmSIEttzlUSBDOQ7paFL6q7Cer
         0jNkVXoeJr9no52ALFmay2m1Q92quoUyQPCEpRJRhB22fqfNwHSVwrjOQ611zFn3vc2I
         dLfUYDoMmSsYasF4qQ8ak3WWGb19zLz8AVI8ZYt7wWAIGhTOMuJSMxokyYvOpaIPXiKS
         Szmf0p6vkc5ptqO9MK1H1HuOX2TAryyzTUZ6I2KKMwwT3/+UW6r3Espy5c0Y/Qz4wlIH
         fkqzgBFGu2X/XDggtXX4w899xaseux6snnHWU+IdU91sUHOnJoLgWuukgr40OsvysP1a
         IbGw==
X-Forwarded-Encrypted: i=1; AJvYcCU8j6f4iY2h1Y2mciM1Ksv/ldY8K8dYzxEDtizf1LBBbMOuERDkFJ53+n00Sj66JOTcPdX1ULEHGFtqXeKqaDfUOb5R3FeJYE9/NMwrGa5P
X-Gm-Message-State: AOJu0Yxhsi/zv3miYVVDm5X+9xVCV6eVrTOYJ6Qs7nTQfy5jmiucIr+T
	8Zw6R3OgPd17flMowgqEF9WPb2lITXOhV7eAj0OZ8SWejLSY06kjJdqU8tWGvfB6MHN5UOqBMOX
	nS2TA74FomFrcB2nuhSmCBW72TPA8u9XavfJbiPHAXptj7/bTczCJBtgTIqvE/jHXelyenJ+ZMd
	2Ffxu1ww==
X-Received: by 2002:ac2:528f:0:b0:516:ace0:9a75 with SMTP id q15-20020ac2528f000000b00516ace09a75mr2341487lfm.23.1712395219276;
        Sat, 06 Apr 2024 02:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZAyOXnlJzHnF6UAxzVX17DxYL4mhxCDf8C91bLhJCKP1I0WnSc9EcZ/D+EvzXCHwk6NrkuA==
X-Received: by 2002:ac2:528f:0:b0:516:ace0:9a75 with SMTP id q15-20020ac2528f000000b00516ace09a75mr2341471lfm.23.1712395218819;
        Sat, 06 Apr 2024 02:20:18 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:18 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n
Date: Sat,  6 Apr 2024 11:15:44 +0200
Message-ID: <20240406092005.92399-5-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for new API ring__consume_n() and ring_buffer__consume_n().

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 48c5695b7abf..33aba7684ab9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
 	err = ring_buffer__consume(ringbuf);
 	CHECK(err < 0, "rb_consume", "failed: %d\b", err);
 
+	/* try to consume up to one item */
+	err = ring_buffer__consume_n(ringbuf, 1);
+	CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
+
 	/* also consume using ring__consume to make sure it works the same */
 	err = ring__consume(ring);
 	ASSERT_GE(err, 0, "ring_consume");
 
+	/* try to consume up to one item */
+	err = ring__consume_n(ring, 1);
+	CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err);
+
 	/* 3 rounds, 2 samples each */
 	cnt = atomic_xchg(&sample_cnt, 0);
 	CHECK(cnt != 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
-- 
2.43.0


