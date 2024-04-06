Return-Path: <linux-kselftest+bounces-7326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993989AA2A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 11:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877F01F234D8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029783FBB0;
	Sat,  6 Apr 2024 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="shS/SCUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF53B18D
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395237; cv=none; b=Zl6USIEWIBrPEqNJ/qZ+d7rUKu8rWt8/m7/ewc6Cemioj8USEI7GVBNVRJvYo8H5u4byMc/Yns5okRbeYIgpYbCTplr9w2o5DvTUhTgYU3rRtobx84tv2N8p9RMoekXqBhpWErrPTqv+2lW/TwWzuTpjJ2h80YScokDnWmdSoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395237; c=relaxed/simple;
	bh=a78vMWglkqZNxVpizm3bz2mABJk4IrXHntVwOv9hkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROhy7MHCmvPep0PFJp2PFglzyCo3nESy0071/ZJFjNij1KovHXfSLl/RSD63TnjA0seyRE1wXfcG+QwGwKkt9170atqj/7SPghEdJurSoJVkoLRerSpBQVID4rkg1D7EI7HBZzTsK9ZfaOdPLFqYNqTkzuaZ/q4lURCcSgmusxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=shS/SCUd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C8E073FE63
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395223;
	bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=shS/SCUdkOrlvaMo6v2dMqgIk7vxRz2ZdoXHfzCVrKyAtO2LloW8GQbgK8rXmL912
	 9Nsgifl3m5sfHdIC3ogxFRoQDyaQ+CLRYLp2M9XQH5vryPG3hEuwzxCYaJmTFEwRDU
	 amRl17WxWsSy2fp7shGUtZE03ENcj2Ec4AWzpiRd+b0Wf4QamaJ4JDHHkxgsy08jTS
	 b2hHb7KZyFagkFEl0quUamCuCbba1gmRMsn8a9CiqJnKvNZLpBbiRPLtm5Eau9JUh8
	 /cTWNghhiQjlAUtHxCp/kJSZ4pXZJArdErAjGt5jsqMgNy6pzPOt0ySP25IXbGN7kq
	 SD6c0HNO7zX0Q==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516d2c322d5so1608636e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Apr 2024 02:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395216; x=1713000016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
        b=LKcdiIMIyotqYom/Wkz1ZRQZQJCBlZgIpGWpBq30oDhXKrJmyR9dcWERR3BxXzZVX/
         5DLhxRPH+knXvYuUPJvLM2aYLwsSzZDByYMZONyCcpsPihfNpjC8SxDjDNDgD2UiyAXT
         ro7mcYMBUJFFKujgrpruKJE4mGlYpVLLpLQkX+egZhio2wKjZwsSQPQSGG9pywMZy+o5
         USy5idfg18uo9hnX6jJb1AdyqZEHrH33H8uaAjXhRMYdJA1VuIHplC7xRTaDSTxvNr9x
         tLubbU0Mo1eLR+GV31M8MQerqZA2zHcAEXSlg35F4Vw2BuLaa/l1jpBxIwcpHA7YND9G
         C0rg==
X-Forwarded-Encrypted: i=1; AJvYcCUUvrTpOdXJFL+0KjvdJdoYem8mWDY9qjWaQ6vDv3OXYqNEKsOu5Liom+CbaE9CqdoSV8po0qcRwQ0RfKld4y5KnDM3VOpMdaVLck0ptrsw
X-Gm-Message-State: AOJu0YwMin0UQU3CRPjYhC5grB1Jzgy6sGGbqoqqrHtzJy3KGEkkl9p5
	syOlROqNv4AnIqx3PvX3C8LRmMvlMh8OWdrmnjwUr608eSKjXkeyPKTOJ3N2VQ5iSvPCbQR/IY0
	NLaLxo3dcZ6guU53VB9/2zceGQtHX34qejBoia+L8HTwSqucr2QChO6oKxNLK76Bcrznu/BovzO
	pjOPTaYQ==
X-Received: by 2002:ac2:5df9:0:b0:515:d50f:c6cc with SMTP id z25-20020ac25df9000000b00515d50fc6ccmr2674257lfq.63.1712395215923;
        Sat, 06 Apr 2024 02:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS/Wj4fTtj4EhH4SwuK4rc7frejoX2SMVVjV8lwzSRp5JOOCrfUKz3Ui9mytME96ZdhQmWHg==
X-Received: by 2002:ac2:5df9:0:b0:515:d50f:c6cc with SMTP id z25-20020ac25df9000000b00515d50fc6ccmr2674231lfq.63.1712395215460;
        Sat, 06 Apr 2024 02:20:15 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:14 -0700 (PDT)
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
Subject: [PATCH v4 2/4] libbpf: ringbuf: allow to consume up to a certain amount of items
Date: Sat,  6 Apr 2024 11:15:42 +0200
Message-ID: <20240406092005.92399-3-andrea.righi@canonical.com>
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

In some cases, instead of always consuming all items from ring buffers
in a greedy way, we may want to consume up to a certain amount of items,
for example when we need to copy items from the BPF ring buffer to a
limited user buffer.

This change allows to set an upper limit to the amount of items consumed
from one or more ring buffers.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/ringbuf.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index aacb64278a01..2c4031168413 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r)
+static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
@@ -268,6 +268,9 @@ static int64_t ringbuf_process_ring(struct ring *r)
 			}
 
 			smp_store_release(r->consumer_pos, cons_pos);
+
+			if (cnt >= n)
+				goto done;
 		}
 	} while (got_new_data);
 done:
@@ -287,13 +290,15 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, INT_MAX);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		if (res > INT_MAX) {
+			res = INT_MAX;
+			break;
+		}
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -314,13 +319,15 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 		__u32 ring_id = rb->events[i].data.fd;
 		struct ring *ring = rb->rings[ring_id];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, INT_MAX);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		if (res > INT_MAX) {
+			res = INT_MAX;
+			break;
+		}
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -375,7 +382,7 @@ int ring__consume(struct ring *r)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r);
+	res = ringbuf_process_ring(r, INT_MAX);
 	if (res < 0)
 		return libbpf_err(res);
 
-- 
2.43.0


