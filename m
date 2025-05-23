Return-Path: <linux-kselftest+bounces-33556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BBCAC19E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C41C032B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0BF15A856;
	Fri, 23 May 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYqkdWZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50452DCBE6;
	Fri, 23 May 2025 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965920; cv=none; b=shs/CQfpD5vBpmvBF70hsuwPwbkRbTBIQpaR4xTQX//HdrY8wA+GDXj0DjIFboZK2hTwjgKJ1ZS+Hg8ixVdIDpeNSnPfb2owlXpvn6nEK5rwR30MgHqkuC8rXh6pNpGs++4uFGINqJe2hd3Q32d/ToTHUNc/L5HBJRjAWKS+efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965920; c=relaxed/simple;
	bh=t6vkiS2YUjIOsD7RstZJwo0bDC+lblm3s/+4t7X26eM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qwLN5tF+r7dFHNei4yaik662QAKFN+3B5ilJGJJu21+GkbpXtoHYa8EtI7n6twO37RoA4cGa5qSFsZf86nZ8iCo3JN4dAyRqBtWtdYmYOYh0wLFb35P7Fj8Rezbv7WEZyMk9iC4OoUV0b+DTLqOoaNxWVdO9I2wcyT0BzK15SPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYqkdWZd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a362e099cfso1038980f8f.2;
        Thu, 22 May 2025 19:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747965915; x=1748570715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ab4TBY8+6wZEJCd9/Shv1fgIXmlDtuiVTX73n4iUE6I=;
        b=HYqkdWZdJLbf2fixlOrKXpq1DAsyrnOStjtqzvpnJm2vA50D1JCg5t8wE+a+jzcdPD
         kMwpcZbLKfdOtkLENwr4ddINDPlPfv14/LmVoxOgi93sUAlFGEWnAyiczdz2XdfxyoKZ
         MEsGr0gqrhk2TgWkbZoIh3SPd42ksi935r2fnY6QmSlcAZmmhdqnGW5VKUI0TbkSn/Om
         TGh70EyCxA2ekzoEoBydyxzR1rC05DCmIs0N8hDg1zwCuieMrGwW+/GX2bgsS01iSVMK
         xqS/aiQqmxMYJhGcHQZflvZ1iKkTTZcirawo9eCWaz1fWoapvf046hjFhIix3VaSLOmr
         k+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747965915; x=1748570715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ab4TBY8+6wZEJCd9/Shv1fgIXmlDtuiVTX73n4iUE6I=;
        b=KY2i6Xws1wSMi5x8yefoKjp0N2kFjaJaEBNfvzI4XeaMq+GScVxzR7H170vqL6h5/4
         oe0QQeuTD579MW0/bRAxTf6fiJShFFADzGDQjOBVwCVH8JaZ/hYA3w4g+6LG4V5qeYtg
         mZHnOrimr+TQWh2i08hwJY6TLI2kApS/8hBiKiwNJpntFe5N3go0yfT+mlKd1TRcUfN3
         +PxlceWV0P/rcl0MTOvjVl8XWb/ijXq4xzcJKRFvLaW/xXde3YhnIBQDOmwyUasyr0WH
         ZWVrZgucMGGXzCAeEqVrpU2c8/HTtTywW934bdbDLZuy+1u1z7xCWtzBR5eEAJWx6mhR
         nptQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwucWYsTE31lLNNwYe3Nf5AMLbi10BwNST3x4zrQ01RoJLeW8nmvICV9bp3WXKhtoJpKV4+/WJEjgh6js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HBNs9bKlAvSvZaJuFoXJWGvbVncEL9wwI4/apbC9NfKeat8q
	VtiIeN2GOz1DRFfN1hamWqkY3dVgci/sJcd+Dwsh1CzqcmOmOYAgGkGq
X-Gm-Gg: ASbGnctR8iJY9u+O56A1vwWyhlBtB1yQ2feinGYGsaa8SgX2I14HhNO4x9U64SxwJGD
	7RDRFbZx5rO9Z/H8Es8xnQ5u+vglx/9CvuPwjxAtS/a8mzi8N87kZOSu6TFrwue8XYKlnPtZfNG
	NMOdlOnZfh/Ozn+obm7qtDjqRNmDlfiCwWFCiYqB9vSp22+tSyGrrAl+snToXS7fH254DiWpe5B
	L8yTNZ2NpYq9f7RutnLnB7k35hgZOOjw9vP7z/bnQwHWAusmRLqbjlt9+e6ej3q5us1DcZnk0yu
	p5UCI73/QZEYbW4+kqYzaMj/iH7OcnT0yGFE/GeLUv9te2Plsm27zy6OdPvJcdmeN21J6alGWn0
	rxkbfprVSOw==
X-Google-Smtp-Source: AGHT+IHAFXL5jLJGKCr103UUn0BkLeRHNRUbWGrRTGlyoRnpv5jHh/LALzOyA2CTUOXO1w+tqRiLDw==
X-Received: by 2002:a05:6000:40db:b0:3a3:591c:40f1 with SMTP id ffacd0b85a97d-3a4c2e5f6c4mr163203f8f.16.1747965914704;
        Thu, 22 May 2025 19:05:14 -0700 (PDT)
Received: from localhost.localdomain ([156.208.37.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0556bsm122486855e9.12.2025.05.22.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 19:05:14 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2] selftests: size: fix grammar and align output formatting
Date: Fri, 23 May 2025 05:05:11 +0300
Message-Id: <20250523020511.10306-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the patch. 
The Signed-off-by line mismatch reported by checkpatch
has been fixed.

Improve the grammar in the test name by changing "get runtime memory use"
to "get runtime memory usage". Also adjust spacing in output lines
("Total:", "Free:", etc.) to ensure consistent alignment and readability.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
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


