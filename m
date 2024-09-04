Return-Path: <linux-kselftest+bounces-17137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F896C108
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761461C22957
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229E1DB53C;
	Wed,  4 Sep 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/75FYwt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E863D;
	Wed,  4 Sep 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461096; cv=none; b=RkJSLyE/8M0xwTB0KOZpunDQl44d1qW6HkHn7AaTFSIV2GxVPxnNiHZIEkMLkRRog+zNvvyhnxruDxq146Ptf2DQYRA3/vu54KaslYHzRWxIC/JUJG399IyGK9QDeuL8CKZa65yCDf7So9uxXkrTJDWk7LlYkpXg8EVKkpvIc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461096; c=relaxed/simple;
	bh=z7WVz7mlT0hUsjOTSHJBLEGayXMGoulzkKewQZM00bI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T22UokK0vgC+6HVkb8aqKub5b+cLAqL5n2WzCfxAEsgkbA2YpSdHqZ/RbRJEgXABslY4TbdFAsX81SpyIBFV7W4/3joCqj1Wiy2BHUCTgJz4TiJ8ba1UEm1y+llSvGQLLQLN2TvB9OewAkic1Ro2GoKrx7IDrX3VM+Z4/Hps2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/75FYwt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4f6d8c1eeso1250605a12.1;
        Wed, 04 Sep 2024 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725461094; x=1726065894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLWTzbqYMWGYSYnB2rX4ScY+RLCUbwYthWBJh0p++u8=;
        b=H/75FYwtf8B/B18Cdl5VldmZXu4GT2irvXmXv0+84fo9u95AuEYF1VpAcTxLS2YPm8
         XdYp3Nvg3CSMqVqL1nOnXJw45JhjG+Y3il9FpEp6JSVfTBuziXgWzlGPsGXS5LSKvI5B
         onVazH8Sfb1hSc84Z8t3VlFyl6JWjjcC5zOO4Xk9nW4UWBg8VSve+9fgw/Bt+x6mhfhr
         jM14omkr+ScG/wuUAi2OdnX1XvHtMEZaHwFFGTd91yWufMQtKuPsjKK0VzLY6IqO4W0X
         bRWnS1HeYWTTPdg72QhL2aN409PUOd+LjIwPZZAMFzsIGMD/gmdbV/ufhjN+0O5Cp8dK
         1Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461094; x=1726065894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLWTzbqYMWGYSYnB2rX4ScY+RLCUbwYthWBJh0p++u8=;
        b=UFc+aawM8P2zadGAZPOlCl6f8ycxcGgm86KbcfQvqJLVRWB9b6PWnhNmQic5q7fCUQ
         imr864M12085vukMgQ1j1J1JPsjbK8CbIJCFFJuIvMLF0adgkcb2ntRWMzhNlvHS1Zxg
         1AY2rJGxdkGwUFNRtCrvKwDnd9dXI+jhu1uIpct+HnMlrqtafDMyJslpxX0VNA135iJN
         M8nZ2qd4mY2qa8okgSJuTmYi8pbLTbNSF/UD3P+aQOnrQzCc3zovK3DcPmpkRxmP3ZF6
         Ail3w0KHpFLchCYZtqFgbLxIbkcUUEYrmpnI/vUDHWYSnfsNHvrojEDxlTIwPJZt2KzD
         Aonw==
X-Forwarded-Encrypted: i=1; AJvYcCV7T87op5DBfKNo60rgWLBByypGjFVX4L4LnmzJ9N4jm4eXGDMgIHrH1NkJjtES7asnqG1yKSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwQ/g78oi5VEt/NSGa5VgImB8hHI3yTZUTzzvd1pW4WV9HzKq
	Bq9/S4ZAK6poJUpK3+WHSzZlIhw18x8bxYfZX6seyUiGu3VdA/T5
X-Google-Smtp-Source: AGHT+IEO3v2XygobALq56TxMHS1kFQHDwrZB+k0atHFByd/N0f9Napb9NmLKrTI/GFAGUzkqeqGk5Q==
X-Received: by 2002:a17:90a:dc13:b0:2da:936c:e5ad with SMTP id 98e67ed59e1d1-2da936cef76mr2012543a91.33.1725461093825;
        Wed, 04 Sep 2024 07:44:53 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8b69a61casm7745950a91.44.2024.09.04.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:44:53 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] selftests: return failure when timestamps can't be parsed
Date: Wed,  4 Sep 2024 22:44:46 +0800
Message-Id: <20240904144446.41274-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was trying to modify the tx timestamping feature, I found that
running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the fact
properly.

In this selftest file, we respectively test three tx generation flags.
With the generation and report flag enabled, we expect that the timestamp
must be returned to the userspace unless 1) generating the timestamp
fails, 2) reporting the timestamp fails. So we should test if the
timestamps can be read and parsed succuessfuly in txtimestamp.c, or
else there is a bug in the kernel.

After adding the check so that running ./txtimestamp will reflect the
result correctly like this if there is an error in kernel:
protocol:     TCP
payload:      10
server port:  9000

family:       INET
test SND
    USR: 1725458477 s 667997 us (seq=0, len=0)
Failed to parse timestamps
    USR: 1725458477 s 718128 us (seq=0, len=0)
Failed to parse timestamps
    USR: 1725458477 s 768273 us (seq=0, len=0)
Failed to parse timestamps
    USR: 1725458477 s 818416 us (seq=0, len=0)
Failed to parse timestamps
...

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
I'm not sure if I should also check if the cur->tv_sec or cur->tv_nsec
is zero in __print_timestamp(). Could it be valid when either of
them is zero?
---
 tools/testing/selftests/net/txtimestamp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index ec60a16c9307..b69aae840a67 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -358,6 +358,10 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, int payload_len)
 
 	if (batch > 1)
 		fprintf(stderr, "batched %d timestamps\n", batch);
+	else if (!batch) {
+		fprintf(stderr, "Failed to parse timestamps\n");
+		test_failed = true;
+	}
 }
 
 static int recv_errmsg(int fd)
-- 
2.37.3


