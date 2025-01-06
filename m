Return-Path: <linux-kselftest+bounces-23938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA84A0206A
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 09:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2F418852FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A21D6DC9;
	Mon,  6 Jan 2025 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lezsdofa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0638B1A2631;
	Mon,  6 Jan 2025 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151060; cv=none; b=eqgXtWz8wZ9Fge5cuTdECadZ3jMXIFW9kgUZ+RZ9yV82VIPfcp9JSTe1L3LD1QDNp8pJrxd1Cefj/aK0+HnL6Op1UPafRJG9YZa7BBD7ajvsxXOyipHzCyye86XesgjLXKDqKT7uzRuI1MYy/CVpWcPOgCbU+SSQasmsYEiYBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151060; c=relaxed/simple;
	bh=z6rapFQsJJuLWWLJVSfKW1IPI0ctzTNB5tuk0C7Ws2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEFVnsXdym6u+BNk26+WCsdacM99qdvEOW8neKdgq25vvyNihPDFacHvJCQDQ6jnLety6MmrJsA6zEsW5XdxjJx2IsRlR9zGLdMS2ObhkFZd92zbkffZB08wzJOH4biRFJp2piuzn53ZndSjzUtwXBt5RK7qGBFbpOphXSWBF5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lezsdofa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21628b3fe7dso194787895ad.3;
        Mon, 06 Jan 2025 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736151058; x=1736755858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNj5EB3CBzzHNe2564u4Vg3r3GIGTo09F7r1zlnGu1M=;
        b=lezsdofasqPgOyVLFOjFD/yX8VTozt/G13Q7oTlHdreAa3ZIJm5G+/eBdyxVNtvwt3
         MlskO3fGfylxHI/AN7AomyB6Le4OXWeWeyc3VhE1JSLx640Bm5YiU8Dd1h80StbrlWC6
         LlGpHIGsFd1SJ3r2lAvj9ZOU2l5DPTHUfIqOSmfzllgi5JUJ2yhlHgD7D5km+qaFYnXF
         SP0Cu3IPHVIdDM/XlvrHXG54abKXb5ZynSuWla07IPwsfV5Fd/keVmWjvnEovGJDbeQ3
         NfoQ1XDJYTbpUIqOKCNi1YPHGl0FAi96dWn1esaCL4qL2F6Ixice8WrHsIZ9Tg1nbh6m
         nCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736151058; x=1736755858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNj5EB3CBzzHNe2564u4Vg3r3GIGTo09F7r1zlnGu1M=;
        b=QdhE9o12A4GOwqpQAHNQwlY/jwgtrJIK9aRifipAv0zCKtFPa6QeOODIhBlBsPgF6j
         ZApnHNV+AivaUAVZU8PhaEZDjSZR0mYh9XQSeKl2k7x8Huyh7VRVkFMA/VW2p4czaEeb
         VL2dO9PrhdA0HtBb1toLuSTDufi3dumiyiAjrrV1xSHapB3OOYGTpoIPi6XthjsZ3lJ7
         +R1/n2Oy5kai6RlbtE6FGNDnbzbLd1BOJ6PkIhKAEsnIiAbUNh5ChpVH7mp7N2rKLYY5
         Sh/g6yO3sr+jc7D1TA8dFIKiBlej61vh1jJxIhopeMC+TTcwhs34wZeCzXFGb7obSlyz
         EgMA==
X-Forwarded-Encrypted: i=1; AJvYcCU/h4OdRhQyLSFtMldvsEwu2F0smIEQEUdtf5R+aczoqnW/ASsN1zEeTBXOcpyYToO7uMujaBwmTK4uR1KOKeTH@vger.kernel.org, AJvYcCUrgcMxLhx7gM8j3WeRcTUyTUw8w9POh8ssiSaoxtbGePQbH39KOJYTxJJRGSEukSQy47E=@vger.kernel.org, AJvYcCX/VoWVMe/m5vG5vmh6fKrNzUutLavGfz7ZaYFqJptJmKQCpRUvbBpBs/o/xpGuKObyiHud7xe36/zeIaXP@vger.kernel.org
X-Gm-Message-State: AOJu0YxGa5MgE9oW9CjLDni6hYXch2n/BPiy5ZKY5P28K6fNIikeukXD
	PX3qr0znQwcjF96zmRtQthrluMtCNNtbW5aFz8ijCDEPNOChUdgRnvUjuA==
X-Gm-Gg: ASbGncs2CcSWo6dRMxGhZ41H79Nod0X1vfxp2erxkYyt0VQl03vGHuFhzUGbt/GItki
	Bm1tljzpKNBq7DRi13tOwKz+kF49Yx9GlwuJGczPEcJU4I1V0uh/oAuA34VWHitsnilDT6cgq2P
	VzUBeZxFLH5GVAoWyN2F9deHO56Lit5VNEZXHYyghP6bnbcCKy+wKRsxZRLfxid5Afxpsg3n1Ei
	dwGpVc04zXpJ+OQjdbCFRUWPzfiqIjpfEntxemVE8C2ixfZIYQLve8/THznMUtGeRLH/vvrIlip
X-Google-Smtp-Source: AGHT+IHjMYJ+kYgL9lIpddes5A+CsRLnuYBEZZhoqovTAHBKAqmupPfBM7y9cycXTJ4TnPKyShex5Q==
X-Received: by 2002:a05:6a21:3189:b0:1e1:ab8b:dda1 with SMTP id adf61e73a8af0-1e5e080c4a3mr6061674637.35.1736151057881;
        Mon, 06 Jan 2025 00:10:57 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad835469sm31910429b3a.60.2025.01.06.00.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 00:10:57 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>,
	wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 RESEND net-next 0/2] selftests: wireguards: use nftables for testing
Date: Mon,  6 Jan 2025 08:10:41 +0000
Message-ID: <20250106081043.2073169-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set convert iptables to nftables for wireguard testing, as
iptables is deparated and nftables is the default framework of most releases.

v3: drop iptables directly (Jason A. Donenfeld)
    Also convert to using nft for qemu testing (Jason A. Donenfeld)
v2: use one nft table for testing (Phil Sutter)

Hangbin Liu (2):
  selftests: wireguards: convert iptables to nft
  selftests: wireguard: update to using nft for qemu test

 tools/testing/selftests/wireguard/netns.sh    | 29 +++++++++-----
 .../testing/selftests/wireguard/qemu/Makefile | 40 ++++++++++++++-----
 .../selftests/wireguard/qemu/kernel.config    |  7 ++--
 3 files changed, 53 insertions(+), 23 deletions(-)

-- 
2.46.0


