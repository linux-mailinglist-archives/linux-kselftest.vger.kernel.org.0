Return-Path: <linux-kselftest+bounces-46418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6570C83611
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 06:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ABD64E50D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 05:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC1283FDD;
	Tue, 25 Nov 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff3o7Fdh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CEC226D18
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764047634; cv=none; b=fdoK85Qx7P6wXFS34x5RLGyD0SoSweQ353kOxrrgPo8/f+/IYQhidjzMg5WHyAWAcxNO1moWUpMGI1u3Leed4m3wlin3eVcOpR0IgCLvS1++WDs3RemePcg0MBXugR5M1cu9yahe1twXeM926HlnQr1DnAIkmC94RbjbjOzqqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764047634; c=relaxed/simple;
	bh=bZCH7yqzUxRb8N+fb0N0tZDwqqhKG+widKps1KrkSjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1yz5ZFYAWZ8JbZFeitaWZxrXdSgNBKiYG5rhgFjxqtyNMfZRpXaGX9IHMa5iuVsXpq66sBlKLrRbB3H7hFZv/9eKrWBhkaySe9coVqZbKNFIqO1Zh+Ga/KU1BDvauJ06mHn3YomEpogjOLA45yCkqqtnOwKeIe4u1P3CqF4VmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff3o7Fdh; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so5759204b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 21:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764047631; x=1764652431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWcTQTFJDmjwTmMI6RHt8vv+BjL4lU6e7yLMo4+/Cxk=;
        b=ff3o7FdhABPhk7N75oh4En2PtAAvPhuO/bo7nsmhk7ECE5Kr254aVTMXLaJ+ZTV+To
         LlV+NEMM26gLoS1X5ekiqF2+nZuavESP6iJA1Lx6AfZCjz7Vtgqx5Xxxm+iSqLI14nxu
         TZJ0XzTfJpi5S50o7BbUmnEQu2S3sMwFCjK0tbdx07uuIx1Q6b5WFRNGO1HbKD7tXo3p
         2cJ6xM4j4IO5MHynkqN8bee76j4CsHf9vyodMecqifEvBpDjNUk6SXJpgNJheUrtf/Hj
         9wr3f9+5RpupgYtKeEPIOgE1G7+QMRHO00T98PgenFyl5s9HSH9ofyOXCiErDgQF524j
         jOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764047631; x=1764652431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWcTQTFJDmjwTmMI6RHt8vv+BjL4lU6e7yLMo4+/Cxk=;
        b=APUOItfz/x5KLw9yK62IFMZhdkBILN6bSPFj8hNKKvS+od+YinSbVOf7DQJMmfMAWe
         Rc56DWVaC0GwRvAqJyzuA49Q2dIb+dSY9QBIREkjkUnU36nCDrbhh8T2UzxPRafrzLjN
         q0Azs0jN+wgONUcK9TlsWyxvTYlpLjZP4lJONh/wsc6MwvfAMccvLVBRKgZ/Jirujie7
         4A9WOE02ccGStvI4AVL3A4pl3BhuFtm3VMOICs42U/oxEziW0PliqJCSXLVrxLZLOKVm
         UOpuQkwOgBApzPdQzhEtN/dGetUfoFTfH6quLUub1JQfXNGr9RTWa1hyI73liYiOyXXY
         AwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIEb/i8YrxWNbuKbrdhH0C8XxmjQRRKN11oKVP7niFzC4Q8KFAgMEvHwb2X6C+5z7RjMemj71+Ds8RzcWyXhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHA9oXMM1vLfBDXO+9YoROkLl6GDdpDlPY/Xc1M/Hbfrz0XqYR
	4hysmSzVSQbs/RCp8MactewBj42GMwFR+5RS5yoifkC4zWQMQ6K6hA0A
X-Gm-Gg: ASbGncuh7XUIsv76ubinnw4JgvTQW2aE8Y1IkAtYpM23TY5sVDBSFjm5tlbLAQq90a+
	v0LsY2xgiz5X9mvGlagoxvSzFrEPjCN7KcWDypMlDH+smBBh4ljQNBK10A6mpKFQrVzKrXbUP0l
	JpAKR7g0eLGbTvb9W5erslpcPZDTeDQ8fEyTN84qhzB0/OapetyEIbRy6gN4Wiz4Sv1e30k9dyL
	YN5sFBBlaIpHqMCk3hgKE9f6kPYr8XIjqr5dJvCzNYvfQPYUxIovBmWOEAjmOxOgly88BoecITg
	shwn/MZRPZ5yK0rEcv4i7LrZDPbVH/C+g8D/jcYGHaLwaFNR3bXSDNSqtnUhJosKz3lK17M3rvF
	WVRymjob2IGLhtVwaN2p0SH1dMM70Pl7b5AuzKPdTBSucc4eEbsr9TOM2tEfkdECPT1xtKu/CXD
	exwoIBbO6NMqPmrYEVNC5whkqymLRjNZnOnX9rzV1H
X-Google-Smtp-Source: AGHT+IH/gIpciE5ACSuE2SGrQ53ZE8y7s//19BPgNKgoXxOc+Jz5/qMMSMwR9ixs4i8E4Y/VwD7sIw==
X-Received: by 2002:a05:6a20:729e:b0:35d:5d40:6d65 with SMTP id adf61e73a8af0-3614eaf5281mr15973427637.5.1764047631213;
        Mon, 24 Nov 2025 21:13:51 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fae9e2sm14873726a12.31.2025.11.24.21.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 21:13:50 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	andrealmeid@igalia.com,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v3] selftests/futex: Remove static keyword from 'head'
Date: Tue, 25 Nov 2025 10:43:26 +0530
Message-ID: <20251125051333.17934-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

'head' is defined as 'static struct robust_list_head' that stores the
local variable of 'struct lock_struct a' raising the Wdangling-pointer
warning.

robust_list.c: In function ‘child_circular_list’:
robust_list.c:522:24: warning: storing the address of local variable
‘a’ in ‘head.list.next’ [-Wdangling-pointer=]

  522 |         head.list.next = &a.list;
      |         ~~~~~~~~~~~~~~~^~~~~~~~~
robust_list.c:513:28: note: ‘a’ declared here
  513 |         struct lock_struct a, b, c;
      |                            ^
robust_list.c:512:40: note: ‘head’ declared here
  512 |         static struct robust_list_head head;
      |                                        ^~~~

Since 'head' doesn't need static storge duration, removing the static
keyword of it to fix this.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
v3:
Updated the patch name and msg as suggested by André.

v2: https://lore.kernel.org/all/20251118170907.108832-1-ankitkhushwaha.linux@gmail.com/
Added changes suggested by André.

v1: https://lore.kernel.org/all/20251118162619.50586-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/futex/functional/robust_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
index e7d1254e18ca..ef21a7ec9def 100644
--- a/tools/testing/selftests/futex/functional/robust_list.c
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -509,7 +509,7 @@ TEST(test_robust_list_multiple_elements)

 static int child_circular_list(void *arg)
 {
-	static struct robust_list_head head;
+	struct robust_list_head head;
 	struct lock_struct a, b, c;
 	int ret;

--
2.52.0


