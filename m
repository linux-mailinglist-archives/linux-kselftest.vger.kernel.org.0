Return-Path: <linux-kselftest+bounces-17279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8639796DF07
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68561C225FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CF19DFB4;
	Thu,  5 Sep 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hri7NS4y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912317C9B;
	Thu,  5 Sep 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552044; cv=none; b=q+mLHq+6U/FkmZu9x7NR0mPBA8VbivHG6RzvU0b3COm6gvutk99e86hFIZLDqT33Fxq5ZmAgU8o9ib+y59XLEuKlfHI6ydLf4GHCjcnFCgQUJwWqf5eEHI022yu8xSdOtHyjUuHEwifZYoHHMp4V5spnT9hI9ZpV+u1ts00bhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552044; c=relaxed/simple;
	bh=v8YPTsOBBGnFSuSBn5etaBfl3hjtF6fupdDxTqbWZzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XaMbyj/Nyh50dxOyb7LgDhhizTFmhjI/q+mlW7Y20+W1LGbK1icUiVDv9voNDcIb5nO0zL6pXQGkJN4BrRtEBCum7zsV5OSN3Sb2vv6bDA9ajCukF5KljFd7coRjhFbDTBBDPPyLv95PL10QDsJ4+2wzYBw7LC82KnSM9lOyGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hri7NS4y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717594b4ce7so824223b3a.0;
        Thu, 05 Sep 2024 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725552041; x=1726156841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vY/7oX7G2QiiXFERpXBLGYNJgBqkc4LH8uPCkR3XQE=;
        b=hri7NS4yh+6W4lnjjPVGdHqLAEuv/uE7IW0f9c2EDo7n3L3mO+PJZBZskx/j6VjK2J
         duuogb97yT7WUluRYgbmnUwXMHWD09EL2Nc7NU177a5U9DemaJDvB0osPxfDgFeFYTbt
         Tyu9fr36b1k1uyVAp054qjGWs7eRDCOk78/tDjFzYuLtolnnUsNc7HE0QvSENOmTfFVK
         EibCSYbM2iIdIA5wd/VXieorsz8YBj33D4543dOTFLGC0pRj29jAc+x1FTcwUkvPNXFI
         h0d3AesyB+dRdmOvxKKxC7WF3c374M0/JutImL9qd6EodoDZwFc4C8PkyGtFef6mOMwd
         AuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552041; x=1726156841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vY/7oX7G2QiiXFERpXBLGYNJgBqkc4LH8uPCkR3XQE=;
        b=CE8h5cWLquEe50CRRAUtsd+dQKOJf7QB5lKhjqiiKqsBAHAeAFjfs+giDtiQ2sTZ3O
         qJtUwzYpPFxCGHyb7e83Au9vdEOj3sM7hMbhYi37lBIDOETASi0+ijZICR59zVahKQ0E
         U1RfOe2WQ0xX52wxPvKh4ZHtdqwIUZ9pANEDuWeyjdHrrtb+GPzlgmkim3sDdiM7y62y
         vo88eHgbiVghW7PGmPHh7J8cBFGUzOj7H+0BVIlwCCLxUzsF6uO9yleCiZtc1+nv0xWJ
         K5X2nVbJ9sgTt1pZ2PQLu8RRzGXhqytSv7YIQ2QhDw6kJSYtnyZM3Yg3tQBX7mT9YYpc
         bvdw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ubzGIGb/Wt8R832NyMbr2p+NckejMPHFUJf3e6rDuEGKaavdLw8ASQREPZrRMdIKoebTzuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8+PsQW6ctf5XFRrcQGr61EqjHG/tDSxNU3lntEsLZuUerIhr
	HY6mwhdoyjrrVyowoaNrWic8NSu/wU1gSujvnyPphldqFY6idTgo
X-Google-Smtp-Source: AGHT+IEuoMyK2/xj0UlSDgmuFlLtvlAOdsD7DmKCM6/IjvYDVcZ2HL5YwfOPXxovAuZLjZFoGsEfGw==
X-Received: by 2002:a05:6a20:cf8e:b0:1c4:8650:d6db with SMTP id adf61e73a8af0-1cce10aa93emr26535428637.40.1725552040919;
        Thu, 05 Sep 2024 09:00:40 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177859a369sm3490521b3a.148.2024.09.05.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:00:40 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] selftests: return failure when timestamps can't be reported
Date: Fri,  6 Sep 2024 00:00:35 +0800
Message-Id: <20240905160035.62407-1-kerneljasonxing@gmail.com>
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
running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the error:
I succeeded to generate timestamp stored in the skb but later failed
to report it to the userspace (which means failed to put css into cmsg).
It can happen when someone writes buggy codes in __sock_recv_timestamp(),
for example.

After adding the check so that running ./txtimestamp will reflect the
result correctly like this if there is a bug in the reporting phase:
protocol:     TCP
payload:      10
server port:  9000

family:       INET
test SND
    USR: 1725458477 s 667997 us (seq=0, len=0)
Failed to report timestamps
    USR: 1725458477 s 718128 us (seq=0, len=0)
Failed to report timestamps
    USR: 1725458477 s 768273 us (seq=0, len=0)
Failed to report timestamps
    USR: 1725458477 s 818416 us (seq=0, len=0)
Failed to report timestamps
...

In the future, it will help us detect whether the new coming patch has
bugs or not.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20240904144446.41274-1-kerneljasonxing@gmail.com/
1. mainly change from "parse" to "report", update the commit message.
---
 tools/testing/selftests/net/txtimestamp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index ec60a16c9307..d626f22f9550 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -356,8 +356,12 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, int payload_len)
 		}
 	}
 
-	if (batch > 1)
+	if (batch > 1) {
 		fprintf(stderr, "batched %d timestamps\n", batch);
+	} else if (!batch) {
+		fprintf(stderr, "Failed to report timestamps\n");
+		test_failed = true;
+	}
 }
 
 static int recv_errmsg(int fd)
-- 
2.37.3


