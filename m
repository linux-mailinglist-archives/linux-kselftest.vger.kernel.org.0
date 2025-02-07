Return-Path: <linux-kselftest+bounces-25980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF89AA2BF4B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96CE7A45A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575F1D9A48;
	Fri,  7 Feb 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSET2Yxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D612481B6;
	Fri,  7 Feb 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920571; cv=none; b=pa7Q28b0edbfp8fOnc5Pc3qh2ZHwAxWGzzvlGQvs541QttttzKxsh1DpkO//Q/BrM0rJ41Asb5JCqEguXA5FN2vTkLQa5651DRYK8K4QDe9ci/AHWhX5Fx5K6auXsXCbvymfv8OfXZGge4ZvFG3UH5Uzmy9KltF5B9Mx7d7hPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920571; c=relaxed/simple;
	bh=IYiaoxs2qX405DwEdIK1fruiV+WtOb/Zvj2bo3yxUZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPRDQMkzj2eMjQBcUgw7FkOKe/To0Z0/bwcLi2DYWXYxe2UqdZgycGTM1kifmRjmqEPICzhOyapdO2Czx6tun1Cs1WldQadFu5wNlVMJKbv8NYP8bkq0L6XnGkWBLtr+yv6mqJa2hrOv9ZTJnL7Oh2/fEfkLPp25UvXsPxfDd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSET2Yxt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f5268cf50so6736415ad.1;
        Fri, 07 Feb 2025 01:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738920569; x=1739525369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HtfAb+rS0GAdgCngxEid4x/Qai1tJ56U7SdmAfXpqj8=;
        b=eSET2Yxtxst9m8MlrjpS3KoGrXdSn9MGmITXCGLwyDbRWiDUH5RdycIUmmcn+Mi+9h
         +krRAS4ZSjGzEHDl/wV47tqOtRD0OAsnf4G3h+9oXHKrwtbWh/Nt1VQm67bRcw3d261q
         wu2KxHd3pvGsAk7uH08d2CFRtyrB9nBpCbyLCQcA2Jud6sR2CUhz2oocbCibiyM6M45t
         RJxZfVbZhpNmdFVO27KQGSsZj9TuIe6Y0vUnLWixA2rzpCEBi5XQW33wjalXWzeTlEP8
         V912MhEbnorFKUnkbd55xM2SKtmFAJcWPMyeYzHP5AbsSfAui5fspnXgacSZpowbT3vo
         caGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920569; x=1739525369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtfAb+rS0GAdgCngxEid4x/Qai1tJ56U7SdmAfXpqj8=;
        b=KoeF/nFTnGqj8amkd0ZMqtmNDBbVVNwXXoSKvmJgyhJurVcjM+LW8oEbAi6lT+bI9j
         ayA/Wftnn73iQrSe1awT3uF2GM6hVtheVPk4THU9FZ29hppZHYJ/x4B1yj4opccfFg9Q
         v00xJQKPKvxge716gllO1x92oentHF3hvqaq45nZMZwS/jpKqXC0CSL0obJuAGwGrQWR
         xhvqj3ytjOZgne/M6i0P9h2mXTyfRqlx/fgdSb8MFhEn0oB34r15rz1V6OwQ9hy66aiH
         avk4t/gteQm5miEChGu6Fdc8YG9QNl59STS/AZM1XBH94zLYfmDOzVaK0aWy9DdOGYlx
         7zpg==
X-Forwarded-Encrypted: i=1; AJvYcCUpzkTj/tpER56v8hXyO6uSLQnC+q6Ej/hdR0Kg4KVEu0Hs5k4IbaQUilKbkuT1prZEymcLPTEfoni03jw=@vger.kernel.org, AJvYcCWhp4Boz7XHPrdsKDATGmrHbuZqt51UnRe/cFSHf7iFSQbT6zwaSKNSqNcIEhFKtzF6fqxBec/QDnGYyC0vgPpH@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUvEVad+BedTgJA9601NwGut7UfFvPUNXpbOCKFhXVdbOM0tY
	CtrNeut3UNRjL+C92//g01qHMm1SY36vR+2Dsn73qrKTktoRcLWrC5K33+Y7e9o=
X-Gm-Gg: ASbGncusmCyPcAxBqCnKqvusWl/Nm7oRrGgQaDPceB+LDnM3aapJKZ4O7mbWYtiqQj1
	zGXowB03rCWZyJ2k9oZqz+mXyHrl+wUzVd70ERrc0fJTc+Yxl7oWjaDf5gugga3HH96Dw7bqu29
	1N2v2JEKUCYSyH0SgAgzSbhxfDrM+NZswp20rQKxEimT9I6FSbOWnj/ZNAUAyMZQ3iZ923pqN9B
	WK4G8MR9E2Hba6F80ShlMop+6HAtcFqR/6k8L0jkqat/Oz1avv9stpdTp8UsBfrwfESVOogYRDS
	4HUEhTqDY8+bip3ZbrOXjUz2ivhDW9RS0jE=
X-Google-Smtp-Source: AGHT+IHi3a0j+tMm6fRh+W+6twQQqlb4uCRebdXT42txjYpAY+R1tpaojvghV7BVeaWDYKlf51pqkQ==
X-Received: by 2002:a05:6a00:189f:b0:729:cc5:fa42 with SMTP id d2e1a72fcca58-7305d516f36mr5186020b3a.20.1738920569273;
        Fri, 07 Feb 2025 01:29:29 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f84sm2591586b3a.80.2025.02.07.01.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:29:28 -0800 (PST)
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
Subject: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
Date: Fri,  7 Feb 2025 09:29:18 +0000
Message-ID: <20250207092920.543458-1-liuhangbin@gmail.com>
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

v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
    Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
v2: fix patch 01's subject

Hangbin Liu (2):
  bonding: fix incorrect MAC address setting to receive NS messages
  selftests: bonding: fix incorrect mac address

 drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
 .../drivers/net/bonding/bond_options.sh       |  4 +-
 2 files changed, 49 insertions(+), 10 deletions(-)

-- 
2.46.0


