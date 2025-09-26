Return-Path: <linux-kselftest+bounces-42493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3CBA4947
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845AB3ACF37
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DEF23F27B;
	Fri, 26 Sep 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATR+jDnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341A23D7C7
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903345; cv=none; b=p7McbIWWcNBcSCW3tHswfdKA58/15dUumsfwJNyvi3QF1owWUHyYfchWqtK2nFtyZNhKfSYwo5r1zKg8u5Hhg/BLaOLQqJLby5nvwQws1mhDDCqfeOl/VrqPnKdcf0VZ2UoQnjdZDW3MgjCgKAA02kbFKhPmteObDzrP25A/b9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903345; c=relaxed/simple;
	bh=fCFtnpHpwYMofzs/A1ZBMsIX2GLcFi3vYB2j7+QN0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCjPQrM6ejt3P4xjLWZbLgeTCAK/mhWBrm/x2hoEJubkDzhpvoCQqez/KbqfwFAld9PypvYO8AJU9r/ydgYoqUzVEW562Tvu5pun4OP48Xzv+MEwpu5JqJYPr3F0obYppIs7acv9st5uP+Wm0ludumpJ8+eUuA/zoRylR7k+J7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATR+jDnu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so367907866b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903342; x=1759508142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTwebXNfRQKHZNFBatzbVF/Los3WPx3q3T72l22p6FM=;
        b=ATR+jDnuI2i/wG6nbwVYU1iGnWa58dGkPeQ0/yHU0HkVLwBsOBmKEuuszuB/9igH+b
         +ugeJSUfBAB3ewmywmnhnRQUcFXpdW1j/pbum7l2B8vEyVO6p6mpKnw/dAEPdiLTxp47
         sBrhvK/UZyKIiHRqzfMxHIf/XAM59AhzcYPJAM0KG363zh8hVF2gN8BZI47N8CbGjQxZ
         vagveqDPCuPgCHbVwwu6W8XoU8sihqHTprX8H38Vq1XYSIRk2jUNXJ4S/EteQ2CeXAH/
         8aXjMpugm7/oQks7MkYwwHyN9z3FftmU6DFsG94IizA1J16JLSgRo2pxtwakOvE+RL+Y
         Ding==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903342; x=1759508142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTwebXNfRQKHZNFBatzbVF/Los3WPx3q3T72l22p6FM=;
        b=kERYOiJqXPmFnMJiQVjX9+aso4QFB5HxHl16nc/S9khmdUpa/udPxRe9NMOaKIhY63
         hOwSJjeh+b4yKf/CVKjhVGmlK7/AH0EovcYcw8enlgZ+1vWWPWXbMuflx4GSCsuIoDrA
         WjlQFmlEEm7LRGwgGMNU/Yv3QYOJ0XG9Vd6YDt135qYcjgF9yw1i9q4sAWsbJY8vuJCW
         Qhxc+DgfejoUhPtNKoV3B/+bn7i9PL/Q0oiwz35qQJlswO6p4JZdv0s8pSeIZb+S1iOy
         KgMqaFzHmsUwWL1Zj14hb0RSeVLXFfQ9HF+8GPPETlshEcjjKzAPzD5Bf7OfMRExQXv8
         SaAg==
X-Forwarded-Encrypted: i=1; AJvYcCWwGZTDPDzGYssdY2hyXnj+z7KW8ybx1h3FbNlq3RjfN1G8z+lQOsAuquYO7zCMpuXdzBmKf/WIvoGofb978VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoxXnvgtmMUt8d6xmuk2Zlp/U92j4iLFod6B8R9mVcDm9AHil
	/CyGSwx+dI8M8FVuAOftfoiEgWA4mS3ZXftVD/+FI1qnLo/QLzU0Khuu
X-Gm-Gg: ASbGncsqnIlG8tIQl4gImyM5aE2vlfYRPKgbhuvrpj1GD/iOxyKDY6Z870L8kpcQ1pi
	d8yro6N4Dw/x4C5zBXAfOfM/9jDVq3jIgSQlEQ7+YgaFnpVCbyPPIXlfBmjoeq07j5kDtymI8pB
	CQjlqAkpS8td/uWqW8bfM+20JFCD9met4YsKXFJ1/8F//dwJyLL7gXOKJ8ijYyZfjgHQ4IpX1Sf
	jzzv+3nlW3Fxci/KQekkMqN2rtghlmCqI6JVnFZQjj8Nujbb68ZbzStcoulDCsxbXBNNqQp4gJt
	TL6z8E0Mdex+kU6i1XRlbBYiSB13xb2UzyXa6yPFxaJUbtwO1l40XzcvfQuq8MRqiajjRyUVb+u
	0WeOb5BrN1LRRSjCYNNATUZCzgraerX3UHi73LF5HIRekmjSJEA4S/1ZUohJA0xBgxqzgQ80EUs
	Z9KOZtENOAKlWRW3SR
X-Google-Smtp-Source: AGHT+IGSKS33vEp7IxROvUKAQKlFRVsjIANObx7t3xDIK+wvc7qqDK/f+4CjmaBx5z0SlWt790YXtQ==
X-Received: by 2002:a17:907:6ea3:b0:b07:c909:ceb0 with SMTP id a640c23a62f3a-b34bbbda586mr890952766b.32.1758903341471;
        Fri, 26 Sep 2025 09:15:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b36f410e129sm248308566b.89.2025.09.26.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:15:41 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: net: Check return value from read
Date: Fri, 26 Sep 2025 18:15:37 +0200
Message-ID: <20250926161538.57896-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to retrieve the return value from the read() function
and raise an error if negative.

When building the test with the command
`make -C tools/testing/selftests TARGETS=net` emits the
following warning:

tfo.c: In function ‘run_server’:
tfo.c:84:9: warning: ignoring return value of ‘read’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   84 |         read(connfd, buf, 64);

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/tfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo.c b/tools/testing/selftests/net/tfo.c
index eb3cac5e583c..8fce369e6c37 100644
--- a/tools/testing/selftests/net/tfo.c
+++ b/tools/testing/selftests/net/tfo.c
@@ -50,6 +50,7 @@ static void run_server(void)
 	socklen_t len;
 	char buf[64];
 	FILE *outfile;
+	int ret;
 
 	outfile = fopen(cfg_outfile, "w");
 	if (!outfile)
@@ -81,7 +82,9 @@ static void run_server(void)
 	if (getsockopt(connfd, SOL_SOCKET, SO_INCOMING_NAPI_ID, &opt, &len) < 0)
 		error(1, errno, "getsockopt(SO_INCOMING_NAPI_ID)");
 
-	read(connfd, buf, 64);
+	ret = read(connfd, buf, 64);
+	if (ret < 0)
+		error(1, errno, "read()");
 	fprintf(outfile, "%d\n", opt);
 
 	fclose(outfile);
-- 
2.43.0


