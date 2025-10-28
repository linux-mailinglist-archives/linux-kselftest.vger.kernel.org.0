Return-Path: <linux-kselftest+bounces-44201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33EC162A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB6F3BAC42
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6B34F261;
	Tue, 28 Oct 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTTSJAPJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD534D4ED
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672606; cv=none; b=Bqt1M9OijbkgbhTxgwbMtA1vWSfWXZrC+LKnpo3eGPSyWGjqt7NibwARv8DdzN5NczXTZRlIoOihkTrrearBPpxQjFQggvuDYduNtLXJ9uptLTkcM5ims3531jv5lpRO+Cmdalje1nvGRVKwEnB3pmql5FXEsUMA3UYFsWfXQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672606; c=relaxed/simple;
	bh=SuJH3HWPiM306OrhrNAnCKKfLjQue1QzIizP6/wUym4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/BK+f66I5MDvvE31A+fb5U8q8pdxuPylDcg6yLndnR6L+bqINCKTJZNktNBS853eQGP5RpPxXpeDiX/wqm3dhXJpEirt4VMPmJTuCKiZ9n07Pf5UXRztKIgslqqEVN4a8Msg1cQiyCYzMPXuWeMq8kTmwX9m4QwkLnbXFfLzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTTSJAPJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29470bc80ceso1629215ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672604; x=1762277404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLUXKj3JdQcNGrW23cOuQo3J+oSHDUHH9EfbwIbJJXk=;
        b=aTTSJAPJynIoQg0lb3IO/0eK8p4kLxzuQSHUauj5fzlwjsenWnT4fOcGy79r33bDgp
         pDRw9SEg36LGsa3gTvPBlJvB6vf6TZO5UCOL6nZ3qx7S6JGLCJ5GBydj8mPsmu7ahb9m
         QZPBcFeNEz36G8ZMohy7YJXKqbj5X6zdyveGzB2RgqHjUoLbohV/aSuV/LLsEpWBBEMv
         d3N8Kf463x1V9hOikdJN/ZFac8CWeWQ7xc5K/8SQHVLhy+XN9/c+cHw7gDMDiE/x8Ppi
         8StagREI89fnRQklOKRCc2a2FYU+Jm0vxFAXAtIsXbwsDex5Bx1zNCCuRqqb/0awlqrl
         eKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672604; x=1762277404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLUXKj3JdQcNGrW23cOuQo3J+oSHDUHH9EfbwIbJJXk=;
        b=tTfUvhISp5tYpjC76Ll6uTwpalCU7MQ8Zw9mCErUgxnjy1qoZM+RLfL07TUDpPffTz
         KfRj1cFCNcWajXTVvarPRmWZq/783Tr0uQKyJJsKXYBEwVaHCXs234+N5HvOYQfoF088
         c9BNfH7l3jAVQ/mcS1rs4+uQNQcsuLXpbURvpUL647Rv/8sVGRptIr9pBMgd381R9rOL
         NSEucoxWq0SXuTTQkkgrtMZ1BTD0gVdXwJ6w030kRTkOKFE1O4Igyoh28D9NvZXHbx4r
         dncvaKyhM2ZQyeaZMGyQSQAhxXWJZkMUbdYtc0ASQ4AtHPu1k0LOckaeC7Uh6ifYPeE8
         KlMg==
X-Forwarded-Encrypted: i=1; AJvYcCW7sEb6ibhBFo8+IdSfPchOv3auO6galcEgdC4awi4DIgPS1TjT6tKaIcYNFoggdkV2j2+/cW21NMHqkwCJM5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86/njJAujyrNC394lTI04Vn4sT9Y1borLhAXYU7YGggT37S8V
	rCl1A5577shz89tYhrpOalEcD1/xExDJEg4mJJF9CM75CmJKvKEH2v11
X-Gm-Gg: ASbGnctZqkLHZCWKCLLmeoz0ME40/8GA7e8CTYWeXalX4r7Sc5g03SObOShDi0JfGtQ
	gm0ehFlDVjaYY+uIjB/fEZUSn4lppqh2m8Tfah8e6vW2jZDtPpsPxUoggyj6CSWzNe7xgW/1A7Q
	uZMKTYhHLD9ya1XowIVfE3CC4fJDEd3h0V6JmtwlxesTAeu29Vn5nUmFZp1qcRmCxdLN82ZhpQO
	QGW8AGn5QeSOWtN/TrwDN2N10gOBY01l3//PWAWR/AKuFpnQ2oT+SHfxzbhMi1UdoSnxJ0tOLuh
	5wPB/PNO4Lk71oibq2p01TOy7u3J6sc19+2l1ZcI98AxvzRmsYdHcYg/Xa+1CV+GQKePT1jqfY7
	AXgY3esA7JrKeVIvyQYpRlWNT5A6dD0sWQ0MoWa0M5Z1XqFycXWPyy/GScUq9Bw1PI2gqdpC/Gw
	z2IQCyZs/l9FLtnNnSijDB5XErD+1Fzw==
X-Google-Smtp-Source: AGHT+IFtX2DEf86QAUTfh07/RypVq+7k1EhRmR6o/ag686o7shl3n/6W/Quvmd/xiNh5jfkuDo/tDA==
X-Received: by 2002:a17:903:2f83:b0:294:8c99:f318 with SMTP id d9443c01a7336-294de7f3f19mr861325ad.3.1761672603628;
        Tue, 28 Oct 2025 10:30:03 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d41c4esm124942545ad.81.2025.10.28.10.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:30:03 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2] selftest: net: fix socklen_t type mismatch in sctp_collision test
Date: Tue, 28 Oct 2025 22:59:47 +0530
Message-ID: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
arg, but tests were using int variables. This causes -Wpointer-sign 
warnings on platforms where socklen_t is unsigned.

Change the variable type from int to socklen_t to resolve the warning and
ensure type safety across platforms.

warning fixed:

sctp_collision.c:62:70: warning: passing 'int *' to parameter of 
type 'socklen_t *' (aka 'unsigned int *') converts between pointers to 
integer types with different sign [-Wpointer-sign]
   62 |                 ret = recvfrom(sd, buf, sizeof(buf), 
									0, (struct sockaddr *)&daddr, &len);
      |                                                           ^~~~
/usr/include/sys/socket.h:165:27: note: passing argument to 
parameter '__addr_len' here
  165 |                          socklen_t *__restrict __addr_len);
      |                                                ^

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/netfilter/sctp_collision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
index 21bb1cfd8a85..91df996367e9 100644
--- a/tools/testing/selftests/net/netfilter/sctp_collision.c
+++ b/tools/testing/selftests/net/netfilter/sctp_collision.c
@@ -9,7 +9,8 @@
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in saddr = {}, daddr = {};
-	int sd, ret, len = sizeof(daddr);
+	socklen_t len = sizeof(daddr);
 	struct timeval tv = {25, 0};
 	char buf[] = "hello";
+	int sd, ret;
 
-- 
2.51.0


