Return-Path: <linux-kselftest+bounces-34146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8426ACBA6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 19:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7973BB040
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3966B225A3B;
	Mon,  2 Jun 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc2ace2q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E91925AB;
	Mon,  2 Jun 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886205; cv=none; b=k9Kd1WBuwiWO0QdhSYbQuttljLQbO8yvNsqoXvxpFUZNe8weUGzxauyp6vliViXsr3zroLg+e0/bHBDcs+uD8RlPCyGv+Td9abhi5Pz402ojtIzQGhI+OClbr0VLIlQprNEyzOCW8lVpkEKPNxJSjnhmDQ+NBu7FO0ZHitZ6NdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886205; c=relaxed/simple;
	bh=fXrgd83elDEuepOQPG4IhT9vtapfZgCMADiLVFA5TL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AodXIoT9DUCa54IEk0tbuYU/alSaj3rKQJlvzvrzBZZwv/LJfzxfOZHcNKGpeSnxyDaPnVjlK2V8qJiT5GeBKwS5UE5PmLFXnCUDkITjN38/eJlH0iOt8C7HdWrwrE9mJ0Ekrzl3sIo385UXc5NwJoNFvxyBs/wFrGneVIura2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc2ace2q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23035b3edf1so42364035ad.3;
        Mon, 02 Jun 2025 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748886203; x=1749491003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IodS3ygWGQlGtxvOhMysa+jDntNIq1MDmyqZVf6SuZo=;
        b=Rc2ace2qigXqPoJW19+Tu48x/Aqo24B8IbRmemefdh9qbJPuG6OLtZ32l2uaTW/D+p
         qAjVHa5gaa0vjoc59JS5c8Oiz3bZExW6FSac+Zfi6JovLREFsdHwDqTCx4WQNWcrcuq0
         fEAXvn7OQEEBfjSr0vqqVb6C08kkcmvg3Pgiv1E/IsONvIRlHhodwjTKp7NGr1icTcDG
         hROtUAO6wPRgsJVTYhDIvn8nyq9Ybw75g2ORE9hCevMXmWhDuGKaGj7HtwmTGYWIvVUx
         zeXeFGCdhf9z4cKAVWWmCzTspmUVLf4S6h68suLjKVE007fNHPnmfEjLMFiAeWs07n61
         LJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748886203; x=1749491003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IodS3ygWGQlGtxvOhMysa+jDntNIq1MDmyqZVf6SuZo=;
        b=B0PWcD3nZPsukhqjjXm0XaTjpNaxoXecq1cPFYtg3H+DwnadpIWlZvDs2Ho7O3ouUx
         W9nGVpaRuU8Ek1Aeqt6Gty7+wlWGKghEEeL0N6tALmB93ZPaw6scVN1Ujg8vnI+yb3Dy
         iY0fPb3QNBy0EyTX/19eN+FtU6DEYRN4YfnbOznne1JmRpwTEmTEcbj/ItZNQs3heWh+
         OUiFMKW3kQPe6tqJOhODUwpvt0jU34cQyU97So+gYRuJjpesuT05lprKErpoSkZRhkyY
         WIKTP1k1ZySE41gZXV869q8sHVm/UPQHW8ppQ34uJJNZDWhaqU/yXu2ufy1PDeczKi4w
         Mw8w==
X-Forwarded-Encrypted: i=1; AJvYcCUgO+3Uzs6y18P/1cYMedfNRictIsIo91QEMw5NS55VdXMirVXf72qCNousnFp4wOjhCVw0RX81cvRjQiG6RKwP@vger.kernel.org, AJvYcCW4rte6xk1LslMXcn+bSeciR8ou55Zfw3rpbgVh3ZMd5tn3bNIUba5/t0OIy36K0Rx1GG8=@vger.kernel.org, AJvYcCWxn+BH+dlxMEz6UGb43emH6TZ0LWkDkLvn3io0NI8WZh19hhvf88er/C28chQXcnUk4rgNad4JQMrI4Gpx@vger.kernel.org
X-Gm-Message-State: AOJu0YzRttomRmQv0Vq8ycnUpuxwDKWwEBpATS2DGKyL8Lm0ZEc7NDej
	t6Id4318O1B57QI7cJYQfPtxCOg6xrjwnqDyRsZAUU98GLqafIXZAhTS
X-Gm-Gg: ASbGncuA9LiCvpz2di7Tx0G/0ZU4eKX0yqKyPpXLulzqGZeLVdYEDCKIQMqvBriQKoI
	i0Y7USYlXC6cfacTZ+918TQGM/89Ejo8MvY4dsKXAMDF8scOORpZUcWbfLjDxOTJK0oxe9upNl+
	1ea70VtLQ1iHyRibtlFKoWnqrKHZRMvpSXbsfdObDgOdWP1pfkXM5R7WD+qx5uBTPVKHCAiZ+1m
	i5dudpd8ssV3iVyn3+R6/74Bqgwvfv8V4f5jLrT1KA1DLShYJ/a9hv1YU7H30jKtn9zEjgPVOgh
	VLzcERSlfNYl08fXnpjadVlRhF7ODvKXfATQUhH+lsmxQ/QYBokZ8wl41V4ZqClCGH1LroQizEp
	COk9hASgw
X-Google-Smtp-Source: AGHT+IHTd3m02WIDm2HVjeZnxZ0rKLBE61LTISQj2SyrFKIfYac3HYIPLqtf4MlXZwHol0UGij+kxw==
X-Received: by 2002:a17:902:cf0a:b0:224:26fd:82e5 with SMTP id d9443c01a7336-23529b4637emr235241435ad.48.1748886202697;
        Mon, 02 Jun 2025 10:43:22 -0700 (PDT)
Received: from localhost.localdomain ([205.254.163.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdd034sm73590405ad.92.2025.06.02.10.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 10:43:22 -0700 (PDT)
From: Suchit <suchitkarunakaran@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Suchit <suchitkarunakaran@gmail.com>
Subject: [PATCH] selftests/bpf: Validate UDP length in cls_redirect test
Date: Mon,  2 Jun 2025 23:13:09 +0530
Message-ID: <20250602174309.31315-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation step to ensure that the UDP payload is
long enough to contain the expected GUE and UNIGUE encapsulation
headers

Signed-off-by: Suchit <suchitkarunakaran@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_cls_redirect.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
index f344c6835e84..c1d2eaee2e77 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
@@ -978,7 +978,14 @@ int cls_redirect(struct __sk_buff *skb)
 		return TC_ACT_OK;
 	}
 
-	/* TODO Check UDP length? */
+	uint16_t udp_len = bpf_ntohs(encap->udp.len);
+	uint16_t min_encap_len = sizeof(encap->udp) + sizeof(encap->gue) + sizeof(encap->unigue);
+
+	if (udp_len < min_encap_len) {
+		metrics->errors_total_malformed_encapsulation++;
+		return TC_ACT_SHOT;
+	}

 	if (encap->udp.dest != ENCAPSULATION_PORT) {
 		return TC_ACT_OK;
 	}
-- 
2.49.0


