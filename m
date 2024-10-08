Return-Path: <linux-kselftest+bounces-19222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7F9942A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5F01C2429D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895201DF96C;
	Tue,  8 Oct 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8movRQh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D31DF963;
	Tue,  8 Oct 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375800; cv=none; b=BQds/4d4jKXaS2vaYUumMm5gBHksk7fbtPH5A+jFAbKdoSZFcIB3zJr/rDtos9dknfCbD0BatkSBY7RJSX72Squ+jPaELF7ER3lBj2W4VSLmcfaMuWLUwmG6Qulob1SAW1cYxsXg6j9Cv8YRIeDHF58W2ZeSlLKWxHKwBFoSVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375800; c=relaxed/simple;
	bh=RWOAE4MweFGFHqk44mg0r5fF0fKHiALbSiPG95q8K8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3aGg9aC5Pkfu6pRv8ioEd+p6Y6cIs3AtBTr8pAVJYujfd9vb547Fx6pjRk/cKWXdBxB5mdPSvCXBy/qqCBmzcam2NYbk3rfFIiqua/0z8glmaYANTzFJrm5IVVlpCDVkoERV6ZxjyZ/4HLBjOEor8pviD2uLug25Y8aImKowf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8movRQh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so609493866b.0;
        Tue, 08 Oct 2024 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728375796; x=1728980596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djJAyVG7J3OsehU/h2QIGR2xQex/DGz8ceOHDlVaN1E=;
        b=S8movRQhPbG75LRnfeTH+7V5eu+iDv6BIV2gdQ4AxkvEs3voquTtigeBsqvZiOvwza
         hMWYGMGpHUprQlCNLewMUXJLN0iMfOBndi8Nq2Ej/AP18wAQuaqqYyIvtZjBj8vMMYlq
         DjloSpc0tBz3zqdQxmSWgJJgg17KseIjR9COAOBh3BWXl1btz0x7kvBmd6RAssfBISpa
         k6t+gcJzr0Ld/fBezkFnxH80wXSLX6+4Yf+edF6+bH7RvLfMta/5hWLANPPNGTJXhy2V
         uDa5qpDkQHbT1cecmg806Y/5yuolY3nFdDxrqjLxl9SyXh/wbzwC00vDlxDIz5hBmGKD
         e14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375796; x=1728980596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djJAyVG7J3OsehU/h2QIGR2xQex/DGz8ceOHDlVaN1E=;
        b=YMjWVdew31pmSuO7Q7TgMHE4z7/JQ2QL9pBsTxQE+qEN1fZdK2tm2L3tQuPavs/j1h
         l2xnFNtJ86DbPFLdPCSGL9zXEE/s3nPZrP9DtSqe2Io7HoR0NywIvqWv0sYwt1DaVSUW
         usEmSzqmseq4LHWJX6yevocg5eRXQVKOChr97Xm7he2yWxShEE8XZXxU5pUzD/aFxAmM
         LI2djhBRiDCY+PhKpUzXkF14/CPnrpKCXsaLO6C7scZ5sFzp6e0D5x5LvZUZDKSOwj1q
         dzn+spQZ+Rwevjpk9glkTGQvn7AEwI+AOLGhk09t2z/S52VeIP4fHXexmClPULcjm3jP
         ygjw==
X-Forwarded-Encrypted: i=1; AJvYcCU2M0RvqwQHlJX8ZH4bwDiojHXqMb1Ysy2GBqWhFQ5DykpBi4sH1OAMmIs107IpMHUkm5eeE8Ps8sJfHg==@vger.kernel.org, AJvYcCUF7PzoO2N0YlOtaRBZAk8xDUu0Stg1klxRy0FvHzsZzsMEwTYnKY3QnCVUbxl2PtvnRvE5sWcDqc/tPakhIJnR@vger.kernel.org, AJvYcCV3crgU3wlAteP0ZHSU/qAorBqk+8tBCmg1Sbkdf5i6gf5uU54LB/PXIce0ECKjN7D+tCOvj6UL@vger.kernel.org, AJvYcCXHIT9jRgGaBNLVIaiEAWiTs3pBNkV9zw+swFitH2ZVbEpnFJUPc6jVCdcy96G7yQ2En27rUNekDMdcFfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1kjN1L9UQohaWoTjYKylfJmyGUoqQ5RLMozijcz6ymQgs+xB
	YDtX0XZqlXaqCxtKf2lPnRfB0qgIhFu5tmMu88s+1z+RvJ52t5C/HNDURZqS
X-Google-Smtp-Source: AGHT+IHyysSybHkcoMkwVz5HgbvluJ6B2uGZuT/0p0yQrNdJoaDvn4mWo1AH/YsKGHuikilHJdImCw==
X-Received: by 2002:a17:907:961e:b0:a99:61cd:3160 with SMTP id a640c23a62f3a-a9961cd3177mr403636566b.14.1728375795790;
        Tue, 08 Oct 2024 01:23:15 -0700 (PDT)
Received: from alessandro-pc.station (net-93-66-197-114.cust.vodafonedsl.it. [93.66.197.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9936bc91f4sm445602366b.56.2024.10.08.01.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:23:15 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] selftests: net: rds: fix module not found
Date: Tue,  8 Oct 2024 10:22:53 +0200
Message-ID: <20241008082259.243476-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves this error, when calling kselftest with targets "net/rds":

selftests: net/rds: test.py
Traceback (most recent call last):
  File "tools/testing/selftests/net/rds/./test.py", line 17, in <module>
    from lib.py import ip
ModuleNotFoundError: No module named 'lib'

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/rds/test.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index e6bb109bcead..112a8059c030 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -14,8 +14,9 @@ import sys
 import atexit
 from pwd import getpwuid
 from os import stat
-from lib.py import ip
 
+sys.path.append("..")
+from lib.py.utils import ip
 
 libc = ctypes.cdll.LoadLibrary('libc.so.6')
 setns = libc.setns
-- 
2.43.0


