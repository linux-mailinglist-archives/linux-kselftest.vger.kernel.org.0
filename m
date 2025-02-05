Return-Path: <linux-kselftest+bounces-25800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21750A283E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BC77A3179
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C321E0A6;
	Wed,  5 Feb 2025 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp3x+ax6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB621D5A8;
	Wed,  5 Feb 2025 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738734639; cv=none; b=mXaMYHKfHjU3aDe0U3EZuwG8OHKpmhG+/zEnKKfJUyQGKJfhVaFa81O/l4PjCHmewaJn3y/f91Cw3l5kndoltIzm9imPsfC8uENbfJa+ucl5He2H7GqmoZxRRrms9y/9WxSMI/U9+5FqaNG1fhvtCG2Kds6/LvO6cAQ9V4p1a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738734639; c=relaxed/simple;
	bh=hoKTiFNJga4k6kDkzlWvbfX/wG4hbP8zEshGLRIq03I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hT/SHylDaRSeyTi/1xzNBk5/H3AqOVwQ4Lk8gyxZekoE1jM1uAHxyRG4OqQJpQzTo3Xi6TsshV4Wz0Av34hNQAhayh78lVptpJkpOgwJEHIOCo41hfZDXV0CHoiDUzJgwQvFqG6W5gNEvSgSci/r3o8tCDukvrfjEWpqQ7OefBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp3x+ax6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f200014f1so543535ad.2;
        Tue, 04 Feb 2025 21:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738734637; x=1739339437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/8WaG5xcausJczSDu1PtwlsotHm7UZnGjCaIMeLMRQ=;
        b=cp3x+ax6nGeO1LopJTK1YUvvPCb/29UTWj/3oKKyUZt/PIOD3QwMb34QIgpTBBvaSX
         iVdEhD4zL8UaZ+gTL2CDtea/9v4RKzDaHmTNshkmSou7CQUP5NUfYXsR7zXNizw7c77A
         3KL0ks/dFe0FV8BcazDERBZibQBzmii4xEsRlQMTKyhNZY1rmesQc77McANhrLCF4gkv
         ersb7IB8NmMY+bhqvsgaGo2Mkk1PXHPa4IN/0/VGyHP6KWtjPMSrP43esZ4lW8fIB6j0
         cwv9vO7na+cnP3mfs15kY2pr2LUfkAqYehT/YLwPKOc3lmJqIy7SNmuWJMcwnKyA2XEv
         3JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738734637; x=1739339437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/8WaG5xcausJczSDu1PtwlsotHm7UZnGjCaIMeLMRQ=;
        b=HkgGdLE4Dyw/SZQhYslFfgdxb3IIZSFGmM11mmGuZg14zbpuVldQMdcwEAESjypNkS
         Pc2lDT0KKj1Blg6Pl9mJ4pVr6bbm0au5zoCnZFSfeWt+NSP2BOcHQ/B0QY6d3j1SX91y
         IXAE0N/5FLTZia3Zj5cKZrG6fGSniLYfRf4FSruzjIqoTXaDNmYtT8qdMeSJd5IOGVDl
         /AHNVSaFBM/6+749mSnWqNzf6Xt8diqrhp3cg+N69RBskYbVD4QG9h3L1Jnuek8bLXF8
         BYBHuoX3Aajd7t7y+y1yTt5xMA+ufzYlxq4V0XNPZ8OX5Aem7zhuv6suwjGxSE1gmiEY
         05Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV+pOcfF7XRRA2m/V14chW6CMdXORPKS12TO3trjH44PhXFSnxPxQ7CE/zByeR9Wf62YvRKIDRw1pQkb2A=@vger.kernel.org, AJvYcCWjSij2PPT0m2lY0/aFSbmR+CPZZ5Jgy9vDRedYrUgZqXy14/KVruECwRzjRDpXzfxERGNqpUziy3p2u3gc8VRq@vger.kernel.org
X-Gm-Message-State: AOJu0YxVflKH680ELZUfcVktWFwda+YCnUfZUdf5MHElb4sj7YjtyG30
	b1aw/uUUsobc+Zi7GqFke2gWftxLCtYk+OrZhWg8sfI2rkq+Goje
X-Gm-Gg: ASbGncvIyCB1fEDlTNsvWe2jvmkK39ai+N/XQli161IYAqIjsCZBDDrebgupx94QhKz
	ntbxJJ7PNtwwwzEKAve5Ue+AhWvtQbjRaPSS16MduHZ5UC0w2M3Gmf2TcNze7A8Z62qaM9R4EY1
	UqJdH/PNbacTl9KFZBLRVlJl9+iIofiudakR0JrtzwsaiAnX+eSqsPxeHCMCA6+IzIjsTo/ma6k
	tO4Qq6WEKlscgyvc6XyOrbPR8T+VbIR1wLmEHDI7Yika3nImu2MphJ6hKHmtI5OlVimzLlLjhPh
	oK3oDRxSocak1jp8sMh8Dyt9uLomGoZm/h8=
X-Google-Smtp-Source: AGHT+IHUdRKgQ964UqJ7mPGegV4qUHNbriO8kSyM/D21jqtW+YJdW+LM/Z0c8Ulzu+ph57ZFYLEkHw==
X-Received: by 2002:a17:902:f64f:b0:215:4a4e:9262 with SMTP id d9443c01a7336-21f17dd6b37mr24252835ad.8.1738734636869;
        Tue, 04 Feb 2025 21:50:36 -0800 (PST)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:dc5d:87af:eca4:905a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f06e7d4f6sm23298345ad.112.2025.02.04.21.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 21:50:36 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: shuah@kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] selftests: pidfd: Fix compiling warning of pidfs_setns
Date: Wed,  5 Feb 2025 13:50:31 +0800
Message-ID: <20250205055031.259710-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the compilation of pidfs_setns_test.c , a warning as the following
will pop out.

pidfd_setns_test.c: In function ‘current_nsset_setup’:
pidfd_setns_test.c:173:54: warning: implicit declaration of function \
‘ioctl’ [-Wimplicit-function-declaration]
  173 |                 self->child_pidfd_derived_nsfds[i] = \
ioctl(self->pidfd, info->pidfd_ioctl, 0);

It's caused by wrong import of header file <linux/ioctl.h>, fix it to
<sys/ioctl.h>.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a43491..3ed42f1eb 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,7 +16,7 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <linux/ioctl.h>
+#include <sys/ioctl.h>
 
 #include "pidfd.h"
 #include "../clone3/clone3_selftests.h"
-- 
2.43.0


