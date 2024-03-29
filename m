Return-Path: <linux-kselftest+bounces-6888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC90A892418
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A58A1C22457
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F279E13B292;
	Fri, 29 Mar 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdbcJ4bQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A213A263
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740006; cv=none; b=B6wVmGr6SYu1wJB5WvEFkWBGxWiViZDbCoZjm/e3ukVZWzpsToZP84EALHDLfSIPGnD/j7OGq7H39XU1fw+kFHlktTIgpSVhkDGeyQIx5nnjCMkWxEAGUHxgEg603NCB9sAeU8o93NSezy5qiARmXOD4BqVaMZm6MrJBRcRb8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740006; c=relaxed/simple;
	bh=FSP1oV2T/usULlM1VYDd08bWBIJsZLOi020rBF4z6Bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDCa4nBGRJJENVHImTPv+SX92Ac8sV/7ez/YCb4l+CkKcvlQMT8CPqWGr8CF/wgmHC5KBh5ufwnwUvkP8bE8yXOuCBnDzpVcrd9cR7WVIhZHSKRthldeBAjiBRgUrhlvzSZJyCWJFCIgXJnrpKsXafG0M14JGDU1IpBMEa+4NiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdbcJ4bQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso4024208276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740004; x=1712344804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcI6g4FflKBTSfJKFEIW1tJynz7mTB9AleLJZXHTyLA=;
        b=AdbcJ4bQH0gqZlhr0WmKydY/gGFJ5IJBwSncVy5cbhKignhCun7QzKW99CTVCNI+qg
         sTRd3wegMfdO3o1EGbSAcnX/D52gL9lBPcB8On5hwkfuvvXzeTVpTljG5BLvMeSImJHk
         qwfn03aZx2/S5OVRYvblMPx1JuKKgcw9A0ZGbUi0rLQEtg6n4gCTEdxEJPO6QUM97ATO
         +92G7aGo2SS5nWgweMQ5kbak4gEVxDK9KhrYDkZtEzjBAwGPYnc71YDQebYJ4jXVdg2Q
         oG2zXnftogW4eTNIrCxyE8+ozwFpyicYPMX5S9Fn6uNjyzHXDGnWcb/p39ZRcg5oxMFW
         88ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740004; x=1712344804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcI6g4FflKBTSfJKFEIW1tJynz7mTB9AleLJZXHTyLA=;
        b=DrTYgd3Q30yDaczNEZUn0hDeED0zY0lNFz0/fNJhYsbDk6s2bomegxzvIH2ryvHHA5
         qPN9ymW40F9DGaBTqX+J3iw+mlgClhk+nEg5NpAyRZ59fg4nhenUhV7ZyQMwKmEHCTOM
         AD2w9xcevdWFMwzpci43/WQdVsq7YiN7e2KEdQwAoPidUkJFvrcinBQyrk5vdE3gk8hN
         6AZm+j14sjWaN+3Gn6uweuFM9cXXVBw7gnwT+mCGZdrmD+yOk1Kx0ifEoHXLYmCCd7AA
         uU6GmXmh+G6A+rUQHx0IUxh6mqdVcL5sHErA1jWiWnUEOO3FycGyifXfM+kyg9Qu+oI2
         4hmA==
X-Forwarded-Encrypted: i=1; AJvYcCX1FwT3bPt9BUFOxv6/8Bf8U/oaRC/DPMiBIFuv18JY5FW2lAXsC5SDc6ez8rVtnByi9AQMCBjNJBNfAWsF3smvMpmpSzA0gh71P4+N8E1s
X-Gm-Message-State: AOJu0Yw0UmXSdPdaUSFSu150f8GGkMuLtX0sMq8g9GfNNrcGJJT817lS
	ZbJWj/0Ri5r3yyj+v2hkMsQ9WNEou00elxoI95lovS2H9Wsu/b/dGW2tuu2YBDo5qisWJRydTA=
	=
X-Google-Smtp-Source: AGHT+IGH0KK9182UUL1GAJNaUHzbTv3CkROT6oxKGok86GWqAdDqq2cDBN1yFx4i1s+2vMk+0slVLQNbbA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:2306:b0:dcc:50ca:e153 with SMTP id
 do6-20020a056902230600b00dcc50cae153mr932390ybb.7.1711740004528; Fri, 29 Mar
 2024 12:20:04 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:51 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-7-jrife@google.com>
Subject: [PATCH v1 bpf-next 6/8] selftests/bpf: Add setup/cleanup subcommands
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add optional setup/cleanup subcommands to test_sock_addr.sh to allow
those phases to be driven externally by the sock_addr_kern test program.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/test_sock_addr.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.sh b/tools/testing/selftests/bpf/test_sock_addr.sh
index 3b9fdb8094aa2..dc0dff612b0d2 100755
--- a/tools/testing/selftests/bpf/test_sock_addr.sh
+++ b/tools/testing/selftests/bpf/test_sock_addr.sh
@@ -55,4 +55,12 @@ TEST_IPv4="127.0.0.4/8"
 TEST_IPv6="::6/128"
 MAX_PING_TRIES=5
 
-main
+if [ $# = 0 ]; then
+	main
+elif [ $1 = "setup" ]; then
+	setup
+elif [ $1 = "cleanup" ]; then
+	cleanup
+else
+	echo "invalid option: $1"
+fi
-- 
2.44.0.478.gd926399ef9-goog


