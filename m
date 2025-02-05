Return-Path: <linux-kselftest+bounces-25810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E685A2853F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 09:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35941888D9F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E1229B05;
	Wed,  5 Feb 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYiX6ShX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA014229B0A;
	Wed,  5 Feb 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742629; cv=none; b=U8Ajxx2+Mf4BxevFOeQlJV0vkboUSYGlf1ZWWyyKj5PmGDZYunkVDXr+cTja+wlv7xwnP58AYwnMslthhwbDNgZbNn5IVUNca/EAH9npCSwXGAiS+PkHXsRxyx0qKJkAsKt18wAy1mU4T/CWBdJ+Xoj98CpLbTbthD+tm0urKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742629; c=relaxed/simple;
	bh=yz7odsFnsguGVNN3G5O+Sw4mTR1RNdKwVDH6gjoYXdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJCkzH3csDYcnUHtPjDJdm92dy8VkKyw2BQtm4oqK6y6i6+gnAtPSDqmrQgqz+cuSa+TUI8xibTZAxL32fIE3C6uRJY75Eea3YXtfien+gh9eMc7ydR5AfT2d163bRXYux+PSVNip2cuPPa3fyMDMUudkHRPfsJOaNTcuSK0nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYiX6ShX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2165448243fso33197605ad.1;
        Wed, 05 Feb 2025 00:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738742627; x=1739347427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbxs9YmxoIn95oH9DLAYCIbGOus9KVINXI1mq4F3V+8=;
        b=ZYiX6ShXCi3Cueq5rCWSqRFSzHec9Hc6uCZ4lIUzepBJGK/dzq6Uls3yv8VF0tHzBN
         KYsGHHiVFO7K/FUNTz+Vf8RC+kzst0XiMBK9oXqA9G7iT8Rio6/0taRYKawDANX8O/ga
         o+2zIir+aQqGdQi7UaXKBQxMaiBsZVxFFAogChoSDUmpi2iFaWZWuw4dcldz8cYvsQdo
         SFa/XUQ7GJLYbyCTIQcGg7gw4NxGi3IFzCwSJYlrlfzWZrN7tKrtfMznP3osMxzzAwBE
         8O+uHaMhqi81EenIhw94kBIZ8Nq+S3ljQICs/obv8J8cr4spbgQ+QVc1km6/SDutlI0F
         XKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738742627; x=1739347427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbxs9YmxoIn95oH9DLAYCIbGOus9KVINXI1mq4F3V+8=;
        b=keIIrlexDbNuKMicWommBaaA6cYA+Pf82OM4XKKRn6nXgeX/bGcy+MeXuRSr1QCQgw
         g4Fjw0aoZf6zNmLAZFSpE/L/4BBXt+R6DSDKEnAiWhXteK6mrSYMknE1FCPtTsGs5oJi
         fooNwKtRqwnqBPxgUeRKNwgHaGNt/8x2+rlf1ba9IUzobd/Czj1mAtAMI9rLSWLZ4iaA
         1aB+yhvC24AaUrTv2E2jos0ube9oJLy55A68+B8/OT3uaXq33gqvmp3D/dWwnNEXIVyG
         ZpLKhNhKuFgFhnJrM58ivpMN4N81ouUcrG9auh4dapHcXo/gMd713E6KIwTHwcWMjM7T
         8kQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLnGijozU93wwQVta9qFzCzI5QMMHKfMlgtFeuh4brwTNU0fboaukFeMBPtJ5ov1bmsz48i9rkJzvLsXrYk9kX@vger.kernel.org, AJvYcCXU9+AP5tskbdtzRkAEnyl4/PHm7+ujZ/UpFGkmDkzGoKinlX8r+TRxBLf6ucy/xYzdk7LJaE6fuOutjbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkbyxh7Gmp+4AbZNgGv1mbaT/3ym9rP5xfJ238EOX4Ka10/6t3
	NcAcUHVFWHyHO6UD7pWaPT3SQiOIdY8j0IZiPer8t+a/1VyvYq85UxOa8OPgyVo=
X-Gm-Gg: ASbGncv56pnDiX9HlJt1IxNn836s3u5s3UbSwpxvsnUPt4jCvJgv7BizMO3Jvdc1LXT
	Uq2iKFqJewruZBG9QpuFDBTu5p/KSUDxob8K18hhgXRfBZFDil3HYzMSID19tkE1eGcj4tHdteN
	gPbiCU1nw0AaDRvxL8rnjAebjRGHI871bZ6iCYWiXn3vOW+7ebkCo4MGSI+O3IaCRIRGEDGOMop
	E4TE/5HxgyppMlt6RHAihjECMdENevYwFFfz/12SjF65MQiqaH2HqTlWnSv2IRTNn3AJb0ybWl2
	fkhTes2xsTOrmJXRo72ENCgrvo1lWkWSvkg=
X-Google-Smtp-Source: AGHT+IFIsfvqAytSXZuqYisL16QJIPp4q3yAjnnqkW/aMnwQ0E14n2yFNaIQTSwje6+mhaboPDnwOw==
X-Received: by 2002:a05:6a00:1306:b0:72f:f872:30a7 with SMTP id d2e1a72fcca58-73035127555mr2776924b3a.6.1738742626840;
        Wed, 05 Feb 2025 00:03:46 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a18ae1sm11807039b3a.163.2025.02.05.00.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 00:03:46 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 0/2] bonding: fix incorrect mac address setting
Date: Wed,  5 Feb 2025 08:03:34 +0000
Message-ID: <20250205080336.2197369-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mac address on backup slave should be convert from Solicited-Node
Multicast address, not from bonding unicast target address.

Hangbin Liu (2):
  bonding: fix incorrect MAC address setting to receive NA messages
  selftests: bonding: fix incorrect mac address

 drivers/net/bonding/bond_options.c                          | 4 +++-
 tools/testing/selftests/drivers/net/bonding/bond_options.sh | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.39.5 (Apple Git-154)


