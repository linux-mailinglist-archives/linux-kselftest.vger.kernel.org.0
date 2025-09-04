Return-Path: <linux-kselftest+bounces-40804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA5B44555
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 20:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CDCA4455F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B53431FC;
	Thu,  4 Sep 2025 18:27:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B8342C99;
	Thu,  4 Sep 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010434; cv=none; b=u+Nm85XKmaSW8tM4RWH5Rjal7JkDQnbJWvJqub9itP5ow1GIGnjOIH90GTbDIJ2ljixKa92xHqNn/+hxqjEQYu10kjnwM5tzEXSEs+kSoH9efpsjfsj53TGMEbUJucEvklq90ZysbWTVmJR38hnt62/ZNsT1Ki8XURzmFrFdy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010434; c=relaxed/simple;
	bh=vc9x2Q4qLLBP5fHLrPedYUmI1g0jkWNZQuyMdT6ZVqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKVoZaDWXnf31XdRfKxQibUEOh+XCfD8fU1JX+HtBGe3p94pscd7mWp0JDERmS3fMA2ZqxNcx0cWVSepG/CwjvpTcrpg5crHbs7hRI1Dng6IiDsR0tzSpIwMjzOgO7WRyhSRFkDFk4nh1n5H8bg7nN/YSoOj3ag0J34W4m6OuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77256e75eacso1288829b3a.0;
        Thu, 04 Sep 2025 11:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757010431; x=1757615231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJuPNhEsdoD5NbDeuO4x9+SJND26W/FZgxfzFp926YQ=;
        b=EsSw3jukmnHA4v3dlrCknlhEuioIE0YCm/KgDcYdBPCe+KmeHl1AmOucmjBrFjnkRx
         nlFL1gYzoJICmO5nDdALo/PGXyJsAKApTg7oAf6Ij4iuggKnOXotcoLEm1rz+PYnuQ9+
         mzVgC78z524EvNHYpC1sKNG+P4V3tc3du03NlMUie1zBq7KBwSiSE4Nfzzoop0O19Dul
         GJ/M3DrhJGlxX/XdBsGOsOK3GriDykaWbL7ysY9+4NEFhlGYAApOU+i8ntDGGRjSejDz
         S3NND+H4zg9ngQd+mKeATx7f6EPyfn04/F3sspMPVka0CyhpOpZOzVbhLlIhqwtuShOP
         ZlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe28zwfzlxZ7UXvN4M2F/wM4FI0cIy9xIK2aUi9k/qe6gtxODw0gTkTDjhYiVZQxG6CKJLoKVhMZqSlYxp+kVo@vger.kernel.org, AJvYcCWHJPRCqw7YXX/B420yY0piMY7J0WRMxhJpE94KEt4vdAEgr8d0P5WQCkLnrIzYYjhyF38wYgvpNqGctck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrTJMJaYQV+DOoOi8BsyP4CUBilcv+JwoiDXcf6Ty+iR0Beu6
	AqAOpJJIlr0HZ9vwo128Wd/Zin2W0n5l7/RLSx2Fn+VN7sxyNYInHXO3kklf
X-Gm-Gg: ASbGncsYromtoogRSIuKWngEcWGuLN3kllAMZfDceBTFfNgLmHebEPQsNtGnBX0xk1X
	F0AmYL6RjyCNYeyKrSio8p5SXMt4qhH14cN8qcXL3ckf294VUZiRyoSRau/2i2RuUUHAFH314e0
	hBQN1z2JbocXgmhUBbQkzw+U5tX17dguk3n18D7mRu5Qg7UgbbVnjP+/tNxFCuPbxPVg4JPHN+W
	fN9vzueLxzJCMFmUw7ImGVTCKzjAOzjNRysaaMOZ4J71eXwNrypdyHc0spcpk/Xpf4KydikAgKF
	tGLsVIl9bjPQlAKIQYsg5m61/XAdIlAcXuMwTOmVVmqoLBULFU3Dy+O2Rbd1e0OAFgmh1dS7691
	xqWtg7Vg/jElK126eBaBw1ZCjaBxLLcz7heyHv7f0LZjEGzSTNFlOBgYy5iXFR3+Crb8VNK7H2I
	SQSY8YFXX7zH4fgVJYjDEUDRKA6tqjGhIjUdueHuHD9NdOqTXD0/0CZzL81w7tSn6n9VQDnBs/V
	I3oOKfKa7YC1t1ygXiifHaKdA==
X-Google-Smtp-Source: AGHT+IHO5ogJQOdafz1JT2n3O55yuTYySPlVixJPjJWhlfYVDjBtFAGjMUuP4IuNQGhWhIYGYvSrww==
X-Received: by 2002:a05:6a00:398c:b0:772:3714:60c0 with SMTP id d2e1a72fcca58-7723e309147mr28599329b3a.18.1757010430978;
        Thu, 04 Sep 2025 11:27:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a26a34fsm19447883b3a.6.2025.09.04.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:27:10 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
Date: Thu,  4 Sep 2025 11:27:10 -0700
Message-ID: <20250904182710.1586473-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devmem test fails on NIPA. Most likely we get skb(s) with readable
frags (why?) but the failure manifests as an OOM. The OOM happens
because ncdevmem spams the following message:

  recvmsg ret=-1
  recvmsg: Bad address

As of today, ncdevmem can't deal with various reasons of EFAULT:
- falling back to regular recvmsg for non-devmem skbs
- increasing ctrl_data size (can't happen with ncdevmem's large buffer)

Exit (cleanly) with error when recvmsg returns EFAULT. This should at
least cause the test to cleanup its state.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 8dc9511d046f..c0a22938bed2 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -945,6 +945,10 @@ static int do_server(struct memory_buffer *mem)
 			continue;
 		if (ret < 0) {
 			perror("recvmsg");
+			if (errno == EFAULT) {
+				pr_err("received EFAULT, won't recover");
+				goto err_close_client;
+			}
 			continue;
 		}
 		if (ret == 0) {
-- 
2.51.0


