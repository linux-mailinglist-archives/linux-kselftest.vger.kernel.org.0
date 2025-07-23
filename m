Return-Path: <linux-kselftest+bounces-37893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A715B0FA73
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 20:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFF61CC332D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060E1F560B;
	Wed, 23 Jul 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsOWDbxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2821E9B2A;
	Wed, 23 Jul 2025 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296464; cv=none; b=aWKZ191gWlv8awX4pFSNeZ3cvlBkaX87SdedufYW9k6D86lsAPTuOTKplXGBAZRwHXcK0wTH2Mpq74LodDLi3N16P9HwxUr4DfrjWyqy49iSV0VL9eqNsJf6qhvqqJkXQjCwS17KPJgqMEh3GSgD3z/rnDNGMDENUVdL1ovUl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296464; c=relaxed/simple;
	bh=DdYVadvsY35Ud71INeD3ebjZEFHB3mg7oGNs/y6zwDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Dk+5Hr+/5rIOacqPVr0QoEspOYaDQh/we17lVJMQgPT/giNUoU3ggpR2XTcPzkYoISvKQAy1fh1Uh+bq27APrVXRGkKfAlBW+Yn7SHmvbjHw8GATpPEPPr6wcUnooknvOYhHP60jUipequluTU5DeIWnV0/9WsI1O5FlVMFIP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsOWDbxt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7183dae670dso2155747b3.2;
        Wed, 23 Jul 2025 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753296461; x=1753901261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PqFohHRiXqGvBYv49UrafWYnwFNT1c2OPFaOkxIbOwk=;
        b=KsOWDbxttAqBRQyH9cryTDp7mYUOA7v1qBKwG/42PQVWCTJ49KwwgA1g2SAJeZGwtO
         PHelTe59VvmOkSJP8Xn3yGGKioaHn6ztr/ky2uE1tgFFyjk+QbagmY8W+BF32IxSOSZm
         AkZzMeY+LLA8Lsepvxvnl3FkgADErxaHb5jBrAgTmU9JFgzH8GG5osOFMbKRgp0/HS7f
         4Rmt06N//pyFSUE129RiiAM1zDt1J62OdlOBwl6q61PO6WPEwI8FDVosCsT+8wD/EW7L
         J+/yaGYq0KZPMuzFBxRFSfKqMq1jcN58s1MIpFISNVh7AgUVG/mgWr5TxbKOTsg5Ow3i
         wwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296461; x=1753901261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqFohHRiXqGvBYv49UrafWYnwFNT1c2OPFaOkxIbOwk=;
        b=f6Tx7QA8SFWzjjalZiqe4bEnnD9OGShWzzJiTVP8EY/pDrmEG7m9O/y5PD95AiGanM
         +haRe7S+sKFcU5ZqlOxbcsI4A8lStpUDlStPfYYCQjMdwaA5+zz7LQoqlFmq2ku9IBrV
         5e3G7ERdKPNN/O2aQZQRqh9w5JdI7tuM2c8Zbr0diGpDjs9rq/uPzr/dtftKkCb3LViy
         Dl44sAGIMLOUfUrlJwQQD2D1ZC0KAMZ80XYcBt30DHzZ3d1etCua5iyAN0FRcTKEBdny
         xO6htbSE3yZQvUgqjp9EFjdOKVPw2kK7AkLTEzdh2n3j7PoejjuqrQDK/XqFinHtavQe
         Ru6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAlb4XQhQt0fA4BAZIPbmi9iTR2Vv8yIFwACE8ltZk9fPj+RcN7+vhaqtRhwnYOv3zbv2pJX1v@vger.kernel.org, AJvYcCX0MFy+7AGgWprTnINr6zzyuKLVvOa+rCT+Gwe/kcvdDTHRNKB5LSA7UJsneJz2tOa5bA+yNy6L9X6bmf+7XdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYbq5QROrWszOEaMklrmgQAO5V3PxAmwjKJWSeoLDhk0ZL1aE
	l6H404FVWZK0b5IdIfBaaEHPt0gMMjgpcNJJtFCuUWr8u+pO+Rp5JbDE
X-Gm-Gg: ASbGnctfixnLrggRtraJ8JBISBcjgnyckouAG5qTK7L0uMDexSCfRmwI2etA6ZgkGJD
	Cs5qMK1h2qauXbDh9d+azZopKd+bXj+Ba1qCGfe6gIokcA8q/z3yKpQughZyZQqnZJA9TT0DHhy
	F/mQKidLP1jrrn7taqS5d0/pPECFxl1z3QUiXui+nLja/7fddhS7wYepiS6VweKZEeV0OQshy6h
	BdHDV0W7dnxsN+YHoYPOeIO3LzccE5xSLWpk3MQ5RPEyTBAoYkjN3R5MpguQnFCsjqgyl2Gjz9x
	87zey8tv4MOy08uVzzKJVdzfBDLQwKB8XkF8jh3G41WzYn8FUyZd1cuQVlmtq5W+wAmZ5iYHwy8
	71a1hN00uUa1ibjTXisXQ
X-Google-Smtp-Source: AGHT+IEWVbfI5ewEiUI/MiTgNpOPn0UA3J6ZxMvww9eTXYPsFxlerapqPXWcNk6Ew81/bMPZ36w3OQ==
X-Received: by 2002:a05:690c:3812:b0:717:af29:865f with SMTP id 00721157ae682-719b4256a45mr64002407b3.28.1753296461385;
        Wed, 23 Jul 2025 11:47:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195335e895sm30514167b3.105.2025.07.23.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:47:40 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3] selftests: drv-net: tso: fix issues with tso selftest
Date: Wed, 23 Jul 2025 11:47:35 -0700
Message-ID: <20250723184740.4075410-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a couple issues with the tso selftest.

 - Features required for test cases are detected by searching the set
   of active features at test start, so if a feature is supported by
   hw, but disabled, the test will report that the feature under test
   is not available and fail.
 - The vxlan test cases do not use the correct ip link flags based on
   the gso feature under test
 - The non-tunneled tso6 test case is showing up with the wrong name.

With all patches applied test output is:

  # Detected qstat for LSO wire-packets
  TAP version 13
  1..14
  ok 1 tso.ipv4
  # Testing with mangleid enabled
  ok 2 tso.vxlan4_ipv4
  ok 3 tso.vxlan4_ipv6
  # Testing with mangleid enabled
  ok 4 tso.vxlan_csum4_ipv4
  ok 5 tso.vxlan_csum4_ipv6
  # Testing with mangleid enabled
  ok 6 tso.gre4_ipv4
  ok 7 tso.gre4_ipv6
  ok 8 tso.ipv6
  # Testing with mangleid enabled
  ok 9 tso.vxlan6_ipv4
  ok 10 tso.vxlan6_ipv6
  # Testing with mangleid enabled
  ok 11 tso.vxlan_csum6_ipv4
  ok 12 tso.vxlan_csum6_ipv6
  # Testing with mangleid enabled
  ok 13 tso.gre6_ipv4
  ok 14 tso.gre6_ipv6
  # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0

Daniel Zahka (3):
  selftests: drv-net: tso: enable test cases based on hw_features
  selftests: drv-net: tso: fix vxlan tunnel flags to get correct
    gso_type
  selftests: drv-net: tso: fix non-tunneled tso6 test case name

 tools/testing/selftests/drivers/net/hw/tso.py | 99 +++++++++++--------
 1 file changed, 59 insertions(+), 40 deletions(-)

-- 
2.47.1


