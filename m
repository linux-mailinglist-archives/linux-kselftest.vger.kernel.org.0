Return-Path: <linux-kselftest+bounces-47603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95482CC384E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C70B53006D9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6A341AD0;
	Tue, 16 Dec 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/gSau6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AF341043
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894900; cv=none; b=FNtPZrfGnzywHhDqjEz4K0wVtdjeZDRG+qiLpGHB4aQ0abW3mgT8MYKTJjALwv/TcCwXbe6AFOfJBHs5xuFgKe6elloDSTVgf5ziYycZqI7gAg4ptYbkYjk1Z0otwcT4MBOgjliYiRpGZRH6t/rn2dLpv5moc3eB0lBiXHwS4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894900; c=relaxed/simple;
	bh=rRg1rU7RdBd7Gq/Vczw/5nedpV2H6E5sTzFYSK2TRDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XthVsP02OeA2pzMNPJU6GqBwT1jY78xChMOX2yCGSMFCGKfpCi0ZMzB/1hQH2jT/VXpja5i1cDmWHczFOFTDHX6+M25x91oj4+eXYm27MoOF2okAQYGa+nC4RAyCN9Z9qnEpeZYWvO40X6qxxrZWgDHbGopSIQCVW3amokvZhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/gSau6p; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c5b5c1eccso62486077b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 06:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894898; x=1766499698; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0mup+HLlOmrVWqFXbyf+MzotU/km+jMX39WXot6KIA=;
        b=a/gSau6pK/u1fIeU4zuETqT0VmX0W0tfKs7peZ9Fauug8kh0UZGSyaxxrvyeFJst21
         4gy1SWA3wp9Zx7sHocCCp2Z3af95NwabA02wFYIStJkCoI8p57dTfyb9vqwSIKQN8So7
         6KWpnx03+pQ4K9l1NK95ILFRge3F7ntylo5SGzfLbTyDrOfu5swJ4A1GMeFg/tVA4BDA
         1Ta/VUIHtKBg/aonSOOa9GOyZmitqo1baKkHEiHm0m3kVKC21snSh5pRA8NkL8AZLCH3
         tkpevNRRh8bHcHNpU+N9uyBiIa4n6vYbA+zOXY8spnqs8ug20uX7MU4npDjTGPUMaV+o
         o/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894898; x=1766499698;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0mup+HLlOmrVWqFXbyf+MzotU/km+jMX39WXot6KIA=;
        b=CX+BLocUc96TL905HJkUW6SbsSIzULZRjjA2eiWd7v77aljqGiF2EkbxQOpLarQ3sh
         k2H+03RAmbwRTSNedW5ROipIbQ+X/+yjKtzS0b13H4H5VcauhSMaB7EQyVAhF/npUq84
         v8xCixBFmY02o3LdrwOt7h2XeLCwfewEVvtLKkOgqzfzv4BfG5NsmI0H8Iq5ket1AKwj
         +r0c7sftzA96MW8lTy9MAxghaZMrQOiK0kUdf3/BrUwyxiBaGdTtVOZYnALU/tOCbwqW
         6ySKpufvWztDoyweE+LLjOAXtvzpTZji+1yWjE20bz+f6FqOKezVg0HNny2bugUkk1PY
         TGng==
X-Forwarded-Encrypted: i=1; AJvYcCUVjyEW/sWqQUL3pEzawaAUPAiXgxYqenpSycaYfKl7IscBK/ItxfGDX1gRzuuLNaZfVrF2kpadg6HwSTOEXI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5O9/NV5kyVNEgKHPQ9Gpss07jCK+zOYmENWfNUqraBr7sB1y
	gnJUkPE6SRzZt/vef0JRDqNtwM8tPStXXmhYWVM3qze3poJ1z5fjB+vE5WoAUw==
X-Gm-Gg: AY/fxX7IoWOFlZrqYWu69mcM5XSpIjpfT+vguZlFlpOEQnnAxEPa13LWfdTAM6quDY5
	3/BFZPvUAbwRvChF8G6UtwN94QVj9MSP5E+Az+i0fG14xAXyG1zBkZu8bP/7h6eOMbxxoxR5XNw
	xPaEk0u21Tv1N1O1YQ6HqvjmOG5Ouost1LE7bE6NxgaqlsuMceaJM3s+t8//FuP1da0g3/0JGkW
	S0bHZv7qBduB2audl+l1bd40U/2oWm/32DHTJr5LAR8J9mq6pA+hZNmDP3JmSQTHTzzBTjPokdr
	o6lI+8pZ7/Qb70ighG3NZPslcVGoqQe4S+zD9A3jrraJlRO8R5bKsCpnGVnCazQbfgPz0CKG6O7
	IZDTMjfgNzDg4NvhCndKcRoZ/QqZRq6R0dZmxaHramn+x0ZtQPv0PYf4ZdANbHd3bdddN/q3PfC
	PfL7E2oRXoKIT6KM//32hP/F3J1xfuZBg=
X-Google-Smtp-Source: AGHT+IGejGVDSZX+7LKGxziOgzMccisD2YOnvJr92J3v9iAv92NOwjPH5YZx0F1XbU1v7gDjsWQY9A==
X-Received: by 2002:a05:690c:4c0a:b0:786:8410:31f6 with SMTP id 00721157ae682-78e67155d6amr106126917b3.22.1765894897917;
        Tue, 16 Dec 2025 06:21:37 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e749e5bccsm39322147b3.26.2025.12.16.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:21:37 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net 0/2] selftests: drv-net: psp: fix templated test names
 in psp.py
Date: Tue, 16 Dec 2025 06:21:34 -0800
Message-Id: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9qQWkC/x2MQQqAMAzAviI9W1iLivgV8SCz017mWIcI4t8dH
 hNIHjDJKgZT80CWS03PWIHaBvyxxl1Qt8rAjntiYkyWsIgVDHpjcCMNvnMre4KapCxV/7sZohR
 Y3vcDi6GTbWMAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

The templated test names in psp.py had a bug that was not exposed
until 80970e0fc07e ("selftests: net: py: extract the case generation
logic") changed the order of test case evaluation and test case name
extraction.

The test cases created in psp_ip_ver_test_builder() and
ipver_test_builder() were only assigning formatted names to the test
cases they returned, when the test itself was run. This series moves
the test case naming to the point where the test function is created.

Using netdevsim psp:
Before:
./tools/testing/selftests/drivers/net/psp.py
  TAP version 13
  1..28
  ok 1 psp.test_case
  ok 2 psp.test_case
  ok 3 psp.test_case
  ok 4 psp.test_case
  ok 5 psp.test_case
  ok 6 psp.test_case
  ok 7 psp.test_case
  ok 8 psp.test_case
  ok 9 psp.test_case
  ok 10 psp.test_case
  ok 11 psp.dev_list_devices
  ...
  ok 28 psp.removal_device_bi
  # Totals: pass:28 fail:0 xfail:0 xpass:0 skip:0 error:0
  # 
  # Responder logs (0):
  # STDERR:
  #  Set PSP enable on device 3 to 0xf
  #  Set PSP enable on device 3 to 0x0

After:
./tools/testing/selftests/drivers/net/psp.py
  TAP version 13
  1..28
  ok 1 psp.data_basic_send_v0_ip4
  ok 2 psp.data_basic_send_v0_ip6
  ok 3 psp.data_basic_send_v1_ip4
  ok 4 psp.data_basic_send_v1_ip6
  ok 5 psp.data_basic_send_v2_ip4
  ok 6 psp.data_basic_send_v2_ip6
  ok 7 psp.data_basic_send_v3_ip4
  ok 8 psp.data_basic_send_v3_ip6
  ok 9 psp.data_mss_adjust_ip4
  ok 10 psp.data_mss_adjust_ip6
  ok 11 psp.dev_list_devices
  ...
  ok 28 psp.removal_device_bi
  # Totals: pass:28 fail:0 xfail:0 xpass:0 skip:0 error:0
  # 
  # Responder logs (0):
  # STDERR:
  #  Set PSP enable on device 3 to 0xf
  #  Set PSP enable on device 3 to 0x0

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (2):
      selftests: drv-net: psp: fix templated test names in psp_ip_ver_test_builder()
      selftests: drv-net: psp: fix test names in ipver_test_builder()

 tools/testing/selftests/drivers/net/psp.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7
change-id: 20251212-psp-test-fix-f0816c40a2c1

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


