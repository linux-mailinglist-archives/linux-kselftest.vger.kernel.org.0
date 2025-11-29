Return-Path: <linux-kselftest+bounces-46719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80623C938B4
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 07:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41749348B77
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505B526738B;
	Sat, 29 Nov 2025 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2rhf68M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EB1F583D
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764398264; cv=none; b=Dlo7Klo6XsVBYG5xSoCBTCdUD4gHMU8eSOYlPxvFJ/Alv53fJcG6bQ2/IE1hKgWSQi84T37g08gy2SCc6nwWaM9S51GIQFe9D27Famw/7iuJJQkJrEcPOnhoSxToXmuEadxszY6A/ZTelEzZoekyYzWQySKEzN7U7pFpDTBiTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764398264; c=relaxed/simple;
	bh=6/EuxpMvYyBJYYef7g8AlAQiEmb0sStBq/SkcQ2Uci0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aqm+NQ9ZKxWLGj6azP9+1002qcDo6p4f8iPWr12MDBkoETWrRHczvBwS7fYEe9K8sikGTaoD9QbT9Lfs2HBM3lbppirviwMDXf/7eFgGAA9LNyr3GSqcDh8LjVyNeIfpart1G9GyDlYxAjNVLJ6GdPzKJ30DuOqxASVoGnN76Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2rhf68M; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-298456bb53aso33014375ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 22:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764398261; x=1765003061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9JIRExjGfyiG438dj4Np3p8Uoc3QzZ6U/1+WKHx1+0=;
        b=S2rhf68MuFtqmIm59Unxu+iRa3iZQWP7Y5l1+y5tcK/JncLZ9NP20Svka0YvzSTSOh
         GcCgUmmJXx5/ls7UWlsTiD9KhV4F3ZtsaC7mQIfyuPHtcFQOGrr0yg8do4QGH93CmEtc
         1hNv5sVzSbX5epxW3NN8Iqbp4LfdQxjihngW5ncSdUrkQ/D+ZnCC+HikoDJtFTGQPSuD
         oM8Cx7p5Tgpb+XsqU/Lj4CyKdeIFw7eYo4MuyBmW44Tv+e1mgVQ4lnKe7/NpyoFAg5qg
         9oy2sccJVclokK3BZFF3VyFi5ecIt/7UJFIy5uN33+2sgWoX9mE9pKd5LLHbmjWZVUE0
         4FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764398261; x=1765003061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9JIRExjGfyiG438dj4Np3p8Uoc3QzZ6U/1+WKHx1+0=;
        b=sOqjDrK4blcN/eRck6zLnmyo5e7emIks99qcSH0YhXCxJ6R77zUiLzbVpbk4sqV3su
         Tcs9hDyvlDpbpa9XHcjZ5Na81qULpg0gMQgEFWQkD71ihHVe9WWjMWVppHbf2q3k8Ua4
         iudmCQWSK22kqSJmU+bmBjqcazduNp2jyp2YQFpx4nkGJQSAU75Nsd6y4FkmDha5JJIc
         ceWIwJ+lZVQiHNuRIh6oar8e3EF7wd+BaTkhuMrzQgkgoeuES/jKV5/La8xtpxS1Wx3V
         hZt09kJ/lP8w0NW/l7EWK+xw2KLj+PLr7+pxPeATkV67WDkAmBCASbkHDA6OYYedSUyV
         VvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYI+97iAexNUVLpL4is9nyCxn74GjXDvkexYX7LiryYVSAvddMRfYBoLpCGk8ViSwBUwCOQEqbUsx+z5BDa5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4dQAZwjTljmVTJ0PILqSOYk5NAEKbP+VhxkyCeryCCi/6B2U
	8POkUwtbMLyX88M2SendxV/e5coB1YxYnbvP5gQjAw/+N6yFzKKi5quL
X-Gm-Gg: ASbGncu30pJ7FlEy7YU1B/o1YWAE+qrE3vRJp1SPHCXdKcZukNrp3zQ2gzNIk36zVux
	K/VpzhmzveEi+v+vPoc7NojGZWF2+Hy/RsuZXvQYci458zMWC5z/6Bu8OGEzlP1cJiTMggvvsGm
	eSC+pPFGTWLrpP8zHPYddMveG4YkyXrb8Z9PKZAYRvcfpqDaIMdluutvqzZ9ce20FkNlevziyvb
	/FokyiQFvz5cuaGmRZG0NPQRm5TszujgPGu9y2cr43LQ4NW6FTYL58aDifsV+lrld3SclxoR1Bd
	c8wLMfXuIKXszvQcDSwzbtCz2Swhjoh/NJbY7gJYJ6qbd5xH/DwLk6FO3tCw/PEQVJHVnn+zOmb
	VveYdJPj1AiMZWJLJWfZmtK0C9PkfdOB/kl+/JbMMst7RlM7LNoi0Ss/3jqhItX3w7vODbORgt9
	cvOFIBrOFt9tASldtMUYXnRJw2HSujGg==
X-Google-Smtp-Source: AGHT+IE+aUtzrPI3FDbOHHRFu36ei5nU763U+WhkfUbFs5Z/CcLc3K+MGQu87yTW0Esg48CsLOc47w==
X-Received: by 2002:a17:903:458d:b0:298:616a:ba93 with SMTP id d9443c01a7336-29b6c3db802mr260455355ad.9.1764398260748;
        Fri, 28 Nov 2025 22:37:40 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce46e001sm64784635ad.39.2025.11.28.22.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 22:37:40 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests: tls: fix read/write of garbage value
Date: Sat, 29 Nov 2025 12:07:26 +0530
Message-ID: <20251129063726.31210-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'poll_partial_rec_async' a uninitialized char variable 'token' with
*garbage* value is used for write/read instruction to synchronize
between threads via a pipe.

tls.c:2833:26: warning: variable 'token' is uninitialized
      when passed as a const pointer argument here
      [-Wuninitialized-const-pointer]
 2833 |            EXPECT_EQ(write(p[1], &token, 1), 1); /* Barrier #1 */

Initialize 'token' to '\0' to prevent write/read of garbage value.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
compiler used: clang version 21.1.5 (Fedora 21.1.5-1.fc43).
---
 tools/testing/selftests/net/tls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index a3ef4b57eb5f..a4d16a460fbe 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2786,10 +2786,10 @@ TEST_F(tls_err, epoll_partial_rec)
 TEST_F(tls_err, poll_partial_rec_async)
 {
 	struct pollfd pfd = { };
+	char token = '\0';
 	ssize_t rec_len;
 	char rec[256];
 	char buf[128];
-	char token;
 	int p[2];
 	int ret;

--
2.52.0


