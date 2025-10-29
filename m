Return-Path: <linux-kselftest+bounces-44339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFEC1C8F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654E0564680
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AB35029D;
	Wed, 29 Oct 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHLs89xZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D12C029E
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759765; cv=none; b=PCjEiMELxBLawcxH3l1L611DRja8/3tynLBdvvjxmt2WA5N2xywIrmz5SmYQi+YdDRUHhOHj0aIJvWsX5HkVS4joPXGfd45eBQcm8XmQw/py62Mz/eXG2mpZ0awMwIEVSPlxA3jTksmVX8J5cK9n25b45Gjz5eopVmh/umB0XSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759765; c=relaxed/simple;
	bh=V7kuPF9joUeQ8XWRW+rj/yqrz4T8Boo0UelHGgj9rx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JnHe1WdPYn5sxfCiDsXZbJx7H5zCN1nj8aCYxN4HS2FTYzeOtGNDgtKXrgui9HBn/0bWBTdVhRvXUSwmEqcphlW71Lh2f97KYCYajNATAdphfUx5w6w0NU4nQ8gySXL8f4Nn0969QN+ZE48PycTKJNPee2lflKjOEMju1ihWvgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHLs89xZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475e01db75aso637185e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759762; x=1762364562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjzln4J5kcPTTRJhF2qiwK6MZG3KsRu1XVAD2+PA+Qw=;
        b=AHLs89xZXh9GvdjfSwgDwCjOfFNTh8L3Oxwrvf7MBjw2H4nv7YKdfBVMxW/sC++LUW
         rbyUzIRdCHdnEXET53XzMtQc9rkn8TJWI4KtZY1ftp/LHcWe7u0sfVluuS3K7ro2h7ri
         iuUtl4+wdEk/nlYxPyAKfLAN4sh4TVPEcJhWVJTnQnOkgxeRs9LXNSFMa4J77C0b4EJK
         5Nygh/CAQ7AJ4OrI4TY6X7w6hdVZwpDB+hdY5RMOBooJz0leAwW1WUZa0UhnU+wyT0y1
         2S3vXlHNjD2fErz6x1rsR22Vd+0JV3RsxneYRhpL7hEmuRh5fwP+2hSJOu4xbLoW7BJS
         f/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759762; x=1762364562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjzln4J5kcPTTRJhF2qiwK6MZG3KsRu1XVAD2+PA+Qw=;
        b=kk3RZwBIudClc8lKp7PKvRZlxKDUFxzwRZmBShq+eAHn+seJk+NTX4YqiU6uDXgrNv
         Ckqp8RW76lv5rhS9NXyA/q/6ZAkcZ0cLX3px4IRL6mbN4Lqb7I5HWdDgM+qllVVnn5vN
         kLya2RiNisb9kFhq48JV8/0IqpQWo4yvREUAkrjrFjx5W32YFJd/H4G+o8mcKx+vABWq
         t9rc4Pv2Xk7TuXEWYOvpDqDzlX+vxWYyYb+Tm+dXP3YywAOBVkoxNllVX4bDxfOl8AuQ
         7Ioxs5vVrT3uDt6AGWcOj/Ska95qVsAAY8Lut9qPynYkJ79a9LRkbtz3KwxGLI/eHPV1
         LNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6zzKhsNceJTxNugq/x6IeGuCnCxmiYoCVmCLOFUi3vGeamzSGpEBf1hQm2qQtjC2HIuZET8LWVr+MWQNnI7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxVB8lPNSXJzMG47wDqMk+ZffKxzRe7XHxdZQ+t4PgyXlRStPb
	FlmNSqJhtlUoKEO2V4HZ+yjknlatYg7F4u00YhytZg1xexcZ/aRAJTbO
X-Gm-Gg: ASbGnct1IvtNmmvX1IFDps2rtYVYItX9pTczlsLK86BL34tVO9UQK0w026s3sYPunQ1
	FmmY5QQWzItzAvW72bPg99et/AxKBHkqmOfmaWx4hgzZWO2GHkYyGZRJQvgoMdJ3rlIviZuBykZ
	WrBMHz9jLUodoU9hrvM1VVLhGPC9WQs1pBZ3DiF89gMpSEOk+xWk7M60oU/VpfFrlEcksM2b1qr
	7CG2YsBZKFq0AOLepioBvAh9SCE28s/UVTqcgt69aYAqEE/V/9TKAPS1F1y+1aMHdJGFaa5Bl3J
	Ujsc9dSyzQiSLhPLq9WYLWsOiQ6QSxQy4OBSIevIyz5fAGr6BlpSYyYUiPBCZCzX5BnvS5z17LL
	0It1PqarLFNmykdctAmZlcxUqbHC5IW2z0+H6LyvmoWh9b8LmW/s5T8JiNUIsl3tCwIxZeaDwO/
	RUYDoXppqLWOFtvnWRGB/CMegQ11SMYNu4ooOarMd6erd1JmNkDWfK0LOvNLzoxQ==
X-Google-Smtp-Source: AGHT+IEN4QldBt4aEvjzF7PzzgMoUyn1ozN70jZtp4P8Jv6caxFHxkysIIvS/M+Oc3h94u8FRn/bVg==
X-Received: by 2002:a05:600c:6207:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-477208d1be0mr30581435e9.7.1761759761781;
        Wed, 29 Oct 2025 10:42:41 -0700 (PDT)
Received: from alessandro-pc.station (net-93-70-84-238.cust.vodafonedsl.it. [93.70.84.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e387aa9sm56953225e9.4.2025.10.29.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:42:41 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Fixed type mismatch warning
Date: Wed, 29 Oct 2025 18:42:28 +0100
Message-ID: <20251029174230.17184-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Forced cast of the variable passed to the get_uprobe_offset()
function either probed_uretprobe or probed_uprobe.

The solved warning is as follows:
  CC       seccomp_bpf
seccomp_bpf.c: In function ‘UPROBE_setup’:
seccomp_bpf.c:5175:74: warning: pointer type mismatch in conditional expression
 5175 |         offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
      |

Command to test it:
make -C tools/testing/selftests TARGETS=seccomp

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..cd745a8a5b7e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe
+		? (void *)probed_uretprobe : (void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.43.0


