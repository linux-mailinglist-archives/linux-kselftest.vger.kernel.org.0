Return-Path: <linux-kselftest+bounces-19476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A129992F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 21:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F073C1F29AD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 19:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC81CF7D6;
	Thu, 10 Oct 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0YIk2pu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264B1A01B9;
	Thu, 10 Oct 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589472; cv=none; b=FKEiHr0xWctS73Ind9cGWnsDA6QNnt7oqScpij0jiVEvwx6dc2jVhLN1NK/8SScY52ddS0qnFMQCslI67YgfGDo/KldwM7B2g1HSxineyhSujnXnkWGRamv+qesI9pYzthOcpilwF2tvRphdT3HmXiHPjK9SFt2KIuAoI8T2FnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589472; c=relaxed/simple;
	bh=NdGNkIoSStkgmXNBmjjjU1d+RDwgTpul9rpG9JKnhFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbc9UgFcvMxDo8Zzr8Q7TC3tF8/9x5sqR7rUFFjN3VcsDKzyLhAViuKx9DUO4NcdWBFMnM0vneSTa7hYDrhhq1blnvJUY1qAwYuUHURvKaXg6/4CXdCIxLHAqAy4GS9dSeb2U85DRV0OKdSBZEbbha13y0o3CB5oxXDWWWb1xW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0YIk2pu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a995f56ea2dso207904366b.1;
        Thu, 10 Oct 2024 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728589470; x=1729194270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubquMLAJt+nLGUbrU981XCa16YybjzKFmmAmbJx/lHU=;
        b=j0YIk2punNW7XkddxHS2EkwGYa0XtLj26zTW2ewLcJSdZ8wR7YOW7qq6VxvL+7kEjL
         Upp0YokRiJQSKfTslb/dtirGICo4APGEUsmP6oBEPdf5FTv9vzPajU0H9qSY47GDOeZE
         nB2SZ+QrJGJiiNfD2fMGATjDROtQ7GlTaYWpUyPiUOYN0BQULXR6yrjiD3LQKyz/er5t
         s9hhGYPAPNWt8zggLWjJz4H8irsG89o3RzXOt3FKdwtGDUMBvL+TNgXrkIvndaPgl30Q
         ykC4RfGbe7W8EZZD9OOhkgkdqc/5bcaYtd1fBBUiEhSM4vNXeZ/yPC/biQuQls/49WZf
         u57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589470; x=1729194270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubquMLAJt+nLGUbrU981XCa16YybjzKFmmAmbJx/lHU=;
        b=ixbHRgpYt92x4pBBhazAyRxr38ixYLdFnixm2RVNbTLF35zqUAc/uT3grj2c4H6LL2
         6CPsQ5q0cj+YnGgwcJz5rfuGCftGgQmINChosAKnmufEraNWYpEQp7aK+dk3pfqkby9Q
         i7UC3UKagUnJujGnPuKL80+eZ2pujA84rLtBrKSy9QrhWoxdF9hii7p/sVoEa2un8prE
         tAK/rMP7OH4sv0ftAhqTvYtYrWSpZ8mNxHdc36BDTpAu/g4JrIEEX5kuDJvza6PAOqJe
         FDWhuU+mGMxHOUt3RD8G8Ye+hD6iBUxs8WD6GA7HrVp5iuhW+G0hzx+5kYh27o51lb9g
         o0NA==
X-Forwarded-Encrypted: i=1; AJvYcCUOjWglFFNzosrVMQKXZwQusVnC2jmmQMX+iSzDKVOQqfVCSov+zUQ83KCGD35t8vd81X8PKfnb@vger.kernel.org, AJvYcCUZ5UC5aPtNXSDGOPg0REIH5l9gktLC1qRGYiW3nwlb8dyeULzgrZEUUb/IcYKLsTlX0ohqWRU68sraFA==@vger.kernel.org, AJvYcCWfANvHqMz468p1FQ/6H4uQY4DoIww0lvyZinCBmVyimXrkTjmwpTAvggiIWLtmJ9t45QpUUqYOO91ULIPqDwY1@vger.kernel.org, AJvYcCXLCHsjBLi/7w7jYa+ojXE1Rw+TtIOgTwfhWlrQbMML/xmp1QTv6af0ofQqif4Mj3RUfo7z8VDlg5dgXrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+fAfhzh2X6Xy50i74WTVY1A6H/w2uHuofL6ZY1Tz0QsmMow7
	ug54WWlXgUU0uySR8gm01vkwksuNjxVdWlM6xeBA+E1Xhw3YSSWM
X-Google-Smtp-Source: AGHT+IFYT7OWZQwU8wuEgJYG4ePF/G1FfA7jL5EwvVJTeV1IEWCh4xp//kNWotpik91Hw8i548ITfg==
X-Received: by 2002:a17:907:f79b:b0:a7d:c148:ec85 with SMTP id a640c23a62f3a-a99b95a7dacmr10496466b.62.1728589469405;
        Thu, 10 Oct 2024 12:44:29 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25ddbsm129641566b.59.2024.10.10.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:44:28 -0700 (PDT)
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
Subject: [PATCH v2] selftests: net/rds: add module not found
Date: Thu, 10 Oct 2024 21:44:17 +0200
Message-ID: <20241010194421.48198-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves this error, when calling kselftest with targets "net/rds":

The error was found by running tests manually with the command:
make kselftest TARGETS="net/rds"

The patch also specifies to import ip() function from the utils module.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2:
      modified the way the parent path is added
      added test to reproduce the error

 tools/testing/selftests/net/rds/test.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index e6bb109bcead..4a7178d11193 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -14,8 +14,11 @@ import sys
 import atexit
 from pwd import getpwuid
 from os import stat
-from lib.py import ip
 
+# Allow utils module to be imported from different directory
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.append(os.path.join(this_dir, "../"))
+from lib.py.utils import ip
 
 libc = ctypes.cdll.LoadLibrary('libc.so.6')
 setns = libc.setns
-- 
2.43.0


