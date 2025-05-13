Return-Path: <linux-kselftest+bounces-32917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C192AB5E98
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 23:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E42189C970
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7812144A2;
	Tue, 13 May 2025 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYSHZOyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840672153FB;
	Tue, 13 May 2025 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172805; cv=none; b=QRpw/a2g96SxMMVeQWOmS4jAstD3Xywnl1cCC9fac47KXwDiYNr44y/yMRxUCS65c8FL5he0Ipu4pqyfZE8vtN7NTBA/Sl4/gGJnpDFI1iWIvyBkj6QOrK2T82MIykykP87+HLtsgMjboVDX9WP75o55s74UWhZh8rmuCcw6gPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172805; c=relaxed/simple;
	bh=wG/Wp1GjJWoFt+2qnjj6hA+4W+5qF2qQBrY0vwHfkDk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqC3hEH8OpBvAYr/xR7mZHmaoEV5pTppOmSLJC8+sIrbgqPGlhiE3QJ2CLhjxi+hY4rj8WdxZMf7I9xxpehrymisSUns+LcUnlKwpKis64k8py9HU301hKGDtlmOTYhZRXdxG8dowfkDFsJtoVgRjgyWGlg+Aoeh84AKUSyiqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYSHZOyj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d72b749dcso7308225e9.1;
        Tue, 13 May 2025 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747172802; x=1747777602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stc73lGvEUEFWN8GCfFvarZDGFQnQhaMztIejiIT7GA=;
        b=BYSHZOyjG0dYKWQca/yBtfnotL7sKwisaNf6nUzKGjKEXv53syHB3WZgvc4iQ+M4kr
         B6tYiQ8vOwEz7KSmol5gNZ0REJVaOwGrsS4FjgEeyYwzgH36OnYSa7csz2t1/s/Acspv
         K01VlUy3bDU/E2bsLB/Prc3oO6Pq88PBfH9oD2J6oCNj5skRdJ9GFADdHXoPPDkY9Y0N
         ufgiOWSX19gFqzpm9CcF6IGibUbuh0TkrQNLq0vgKndVov2qtrrvlPLCbsXeOJHnGT+e
         /ZVSNdJV06K+HJkpEOV3dVigmArBpzX9mi4qL2z8d5lA+BHCjcqX/BmvLHEH5S5vrvDe
         KuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747172802; x=1747777602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stc73lGvEUEFWN8GCfFvarZDGFQnQhaMztIejiIT7GA=;
        b=NpCANIr3YUtleABa6NbDTg3dGA2bbaByfS6GpCTLfh+532omkCr2ZzaTJbg5maj680
         6v2EKbqmRyGdFdmFN+roKBfzWFl1qJibbuYiEe+nXeGISSiVKiEL608hot/TzPrDVuhd
         dx+ia2NckNEowub2vq74+KfsOKU457BWBwX465YUSLujgdjccAF7V57owq+aDpmjeoDc
         2t64tkHHngfqVqO74/k35CF6fpr4zjOovyIMxWlpG6LyQBROTBvRWJVD3dOHj5El05VM
         ERLnO+fBadeK0aTIwI4xVsPbnHRdo/tcIrKEP260VFangEnO0ocPLI7pEYeS2jrVKuPD
         sPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoMdDm7J02wtgS7i2XNQ63oPxkEHYvpJjZ/XTtU5WBl+KUEi7b4M3MPca+tbT9Soy0OcmKqo4QDX0wEK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznof1YBBYFxRXq+wgAh1ZMUL11QHMEBTyPnk+4d/RZh57XnJ3O
	h8Ry5j6Cj+Q74Png+nS9zUhqDBmcw+MA2Uqc+MAl1mdW4+TcSfsJ
X-Gm-Gg: ASbGncsKhsAaPU55eBRpY6TWQzFqfRO1y4irQj6IV6EC6f2YQ288uRWBRKapaev5BT/
	2a9Dx/8OLVvDUAepfaqTFvWtN4GBPerbinamt8yikaAvNdHMkmSsLhZxYZTBkZnRclWtazSjTR1
	iy5kHuCYIYhk9p6K8L3YX/KemV0qCYkXzeJo7I+FBVF4dL2qI3OPpG/41PRvx3QvHV13cpmXwz/
	52X6//QJpGahQbwMHf6ZCApyyzK8+bXI/fViwtbfun7FqPJx+foBdKMrZOMgbunv3MlOhZ9kRF8
	gqSLaSlpsyb3wPwaZ+OmaT3vPuzHQv7jU9UIjdbLR4uN2p8rudRI3gutyaR8PCrJDkn/shi13az
	ESEceKhOymOuPNhO/2Fb9+Sw=
X-Google-Smtp-Source: AGHT+IHiV8X+PIZMB34eU//Sz/WBPdRkfT4sZ6bPvbJjMB0TtkFVxh14WGHbwd+hbFf4okMBSwWR3Q==
X-Received: by 2002:a05:600c:4f0d:b0:439:9909:c785 with SMTP id 5b1f17b1804b1-442f217aba9mr2686485e9.7.1747172801282;
        Tue, 13 May 2025 14:46:41 -0700 (PDT)
Received: from localhost.localdomain ([102.44.114.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f337db8asm2601235e9.9.2025.05.13.14.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 14:46:40 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
X-Google-Original-From: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
To: shuah@Kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>,
	Abdelrahman Fekry <AbdelrahmanFekry375@gmail.com>
Subject: [PATCH] selftests: size: fix grammar and align output formatting
Date: Wed, 14 May 2025 00:46:37 +0300
Message-Id: <20250513214637.300563-1-Abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the grammar in the test name by changing "get runtime memory use"
to "get runtime memory usage". Also adjust spacing in output lines
("Total:", "Free:", etc.) to ensure consistent alignment and readability.

Signed-off-by: Abdelrahman Fekry <AbdelrahmanFekry375@gmail.com>
---
 tools/testing/selftests/size/get_size.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/size/get_size.c b/tools/testing/selftests/size/get_size.c
index 2980b1a63366..d5b67c073d8e 100644
--- a/tools/testing/selftests/size/get_size.c
+++ b/tools/testing/selftests/size/get_size.c
@@ -86,7 +86,7 @@ void _start(void)
 	int ccode;
 	struct sysinfo info;
 	unsigned long used;
-	static const char *test_name = " get runtime memory use\n";
+	static const char *test_name = " get runtime memory usage\n";
 
 	print("TAP version 13\n");
 	print("# Testing system size.\n");
@@ -105,8 +105,8 @@ void _start(void)
 	used = info.totalram - info.freeram - info.bufferram;
 	print("# System runtime memory report (units in Kilobytes):\n");
 	print(" ---\n");
-	print_k_value(" Total:  ", info.totalram, info.mem_unit);
-	print_k_value(" Free:   ", info.freeram, info.mem_unit);
+	print_k_value(" Total : ", info.totalram, info.mem_unit);
+	print_k_value(" Free  : ", info.freeram, info.mem_unit);
 	print_k_value(" Buffer: ", info.bufferram, info.mem_unit);
 	print_k_value(" In use: ", used, info.mem_unit);
 	print(" ...\n");
-- 
2.25.1


