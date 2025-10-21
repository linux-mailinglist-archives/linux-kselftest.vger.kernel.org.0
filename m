Return-Path: <linux-kselftest+bounces-43713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE55FBF95A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 01:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA131895004
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 23:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B22F6181;
	Tue, 21 Oct 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acBU5El1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB825B30E
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090444; cv=none; b=In2hMNzAn/qV6P1nmmY1Zg3JJNEaUyODHghohv26fkNWIDvtc3meYrz/9Cd6xgwh/yGBGgg7yG7D6FjUZlJFA1dx15OhBuChY/Cz7Q5PpHVIIG6hWms8UKHprwRwIKP4ksGM9Uj+lR2qonxyLgpkbwcTGo5dJ6V2aJIw5s0ZhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090444; c=relaxed/simple;
	bh=Vq3JxLDexMAZpBZBOMz7RcnedkE0owAELSAnlUsmBpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6aIIeGzsK7O7N8WXLWhTmJOFeQXeq8MtWmJ/d0XTp2Bj7l2YyRnpxFXM/kyDvspSNzpQQiRSpAlpjDzY4TZaaz0ODZhDjEHaowbPmR2NE7yWdU0UFUnpWe2A052qJvq5Px1hG7gXsImvsqxhGzgzmyLe8EthgeE1bAtF7wCeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acBU5El1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290d14e5c9aso58558585ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090437; x=1761695237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=acBU5El1XUnF5ahrQ6RY667sgPxLgA4ZdJwjIRnfSKapdKibrM29eTmpmAJGeNqGam
         Vcpo5EVSM/PpE88hHnTPEhkCDnqRwI4cGqC5L+itv6PdAMBrIWmxYm6c3+oEBeygAmy6
         fu5bI3vqAMWu3xJuEIO0Rhb3GHPzv9pf+BzPM1LR40a9FHLJsf75hxbid5OouU2WBszC
         1uLIzC2hXnfIslq5jjHwcFSVb2CGnHOC6lJ6DmmhpmukPvJhLqyOQ/Ki5YffYmkwXBwl
         IVfJNKxJtnLyzFbeScTbyoOKiaWotKOmkrnlWFw7QJU8JyZV0addM1hna8phjUUpizMN
         04Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090437; x=1761695237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=ugoWq8yIkZesZFXk/l8B4itUAhBGinx+FADy36gtpcVKeL5GJ4FfCLwXKs0504343c
         kS5UgNPU3pkt3b6ZYi+Ga4dhEyR2U47sV95vJsXhWKdlP9lp24jJTbthAoz4UZXoDLHU
         9AG4NEg6+nFkXp0SLSUpZse1stACnhydcQ5g4LW5CcvTsb7bkhZziiO7qqG0Smz9+Hy7
         No1SmbXtUIY6M6DUNuKSniKa63Ez+bB5Vb9aBU6+ZgY9U0ZfINSVQZ/2HFUT4JsDFM1E
         mHAcG2soAZN90lqJvgv/yOa9PbCZsxlbn+7Xcngs8/CvVDQKqt9sgFRZH6SyAzQ1XKsI
         Obtw==
X-Forwarded-Encrypted: i=1; AJvYcCVsrV78/yaTN2fANl1FYKQ4vQDJHXFnFiL1/emFfqqjEG+6lyoJexIo2tdii+RnePlcQ+rrsf3zUNc208x9xZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdakbw46H61uFIsA746tzQ8uG5fL1Q2X2ECP0mFdBqLd81TGmj
	xNJpU3ItLbRGvnELxJM/IF9kSPSmJlRTS49Twh2dJTmQOKUHH9scvHfH
X-Gm-Gg: ASbGncutBBOWwYaqsad7U/QxexgQW3QOITtnHWu/Lc7XydymP/TRVXS/X1CQ/y/M+4h
	hBurJAnGbTIm2TVyHoBCa0S9P4R4R/HZgU/EHNDdgS7ffdPDj8GzaxFZzV5nbm1Y4vtkbPvKPrR
	+Re+x4bM+2Lux4EyVoMNV7NcgyEGcZ5HPuDA8PATZIgeTW37lDUyUV5vFLpCE5sYknVFsyqzfM4
	nwgZEa56Buh7JOj+E+9TsP2M+gtVwKUd0Ydv5oF+TZ02ZXcp9DuANmCETodq/5/x4wH+YEBZThA
	D314EamxiKuydtY1c2Fa+sDD7uJhE649BxjSDZKq/6f+199YvOkag/sTVRkrPKIBC1AbA3vZtAF
	Tuc8ulFQ1BoEvXD4GLqBa6r1EVMmJhysXEZJbUl6BrBJmj54a3A9dTWoq0OlP+C4H7Km6QUrORN
	VznS2Pr0dx
X-Google-Smtp-Source: AGHT+IG5dGgoFfjLOrDybopHtR5kmquL2RmRYL/ZwgLqL0f5q8OPShyxosfyQ4g18ky0R7BE1MkTfw==
X-Received: by 2002:a17:902:e84b:b0:290:c0ed:de42 with SMTP id d9443c01a7336-290caf8582emr300060005ad.36.1761090436967;
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm120304085ad.83.2025.10.21.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:02 -0700
Subject: [PATCH net-next v7 19/26] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-19-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e8f938419e8e..9afe8177167e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -626,6 +626,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


