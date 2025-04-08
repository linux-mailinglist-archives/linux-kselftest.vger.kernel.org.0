Return-Path: <linux-kselftest+bounces-30338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C97A7F78F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A02179D24
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1B263F47;
	Tue,  8 Apr 2025 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImvzWnUB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C2263F3D;
	Tue,  8 Apr 2025 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100231; cv=none; b=kfidjKClmjf/soFVgkaaqKDvzHEDT0BYYL0u4KjKGUQcNDZ3NvMFtiIqFwlkIqqOEvfGYNVdfAkXjqynhoZzEzKpEd4W4yK+l1kGoIUpjSFhPk9WFYFe+L9AJ7chOI6ho2ZN7NqZRpSdjq6A+veEU9IiFcPnKsneQ1JEggK0bE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100231; c=relaxed/simple;
	bh=JgO+hdA1GrGHKIDKAAW3feS3nYjo8Wjp/HZ6RcxjzVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lomYZ7MnuLB5/42Fvi2L7LmPIVW8EGt0IIM4fIm8LJholE0mXcJzVEfkS5ezIAWNDeWPJykLZz+amxEGjNdiXlqzCQSLSJe9ARZEn0s7HeOI1dYo9igqbOcX8INmXFT1TcfQeRNZymTBPIA6U1jvlI1CfJdfzqpHChpQxvjmSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImvzWnUB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2295d78b45cso67837275ad.0;
        Tue, 08 Apr 2025 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744100229; x=1744705029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fdElPioRI0btoB9YLHJoXBq7OTonUhGxAaIJ5PdYa8=;
        b=ImvzWnUBHuI5M1leANHgvRUynZGTMzUmeT55+o3jXbh/KQXBLSv8pkgE2zzfso4kM4
         qbhjAxi9ZACxKTTS9UPJFHHTzZWQo6agttQDi4IA0r8tVhgNGehTRfzSumnOOCTskIu7
         2Mg9lrkYYsbMtOsabyjcKDCE/If38ud4xn0xDdw2lzVqi8q7aGdWNexFI9qr0l0gnTcO
         hrecwGl9BrNYR3pWfoGjNTjdYwSBMNsfsQ3xk4tOFwofsS1eUeJcLSCu6973HVqRr21a
         8e/DQ9nf6akxLec67B8Nq0YnAl7ZK3t8TMxe+aze1U0GzL+iP0kJ87zqRiRlAt0D9VQc
         Ki0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744100229; x=1744705029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fdElPioRI0btoB9YLHJoXBq7OTonUhGxAaIJ5PdYa8=;
        b=fBDujllPxnKW2NaWtk14I7TfUujS4oNi9yZ8zraCOr+oK9A3okwXI/SycIxNNZhrKx
         V9gaycKFxzaLgYlAACIGR+9K6uwh12uyyeULywORR1bjR5udmGNaJUaEwf5K6NyF2AOS
         tdG7Uqi0BYa4bCklSGizgbdyzIJR1+cGEfYLpLpRhRnIomnV4IKg1WpzFw9XaIZKHeBX
         zBOyF0FhosfwoyzvEzYRhBhIN5JWVQD7gup0hT+PNB+Y3LhQNLyD2WID2TLFvOhRqT8u
         vew9NEgMpjY7lePlBNRi2nhbwxozjSrn4wob/NLWjNHscdGGNjp5KhcQTPQBGMkOtkNs
         cxJA==
X-Forwarded-Encrypted: i=1; AJvYcCVIYa+1O3QddGcG5E5Kagix9nr1SZH2PCBBdolADHBOkpKE2FuzQGKmIIVeqcDwQzvkK5L/sCMqhn9AoAU=@vger.kernel.org, AJvYcCXhl/SHJ1Z+AurtuzoPFM28zLQW2dAr6MUle5ws6YkfOQ7bKbf5hDUKMohBpXlCiQr9w96ePMIihikSFOolNFvY@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+LtQ3+HbagA5g9lGkGIteHo4sskZcz3VMEHtdSDj0X+FX0z2
	+I1lD3o42dTeRIs+GM+qDmY96jIeQiPFu6y/1Qv7RWbm5eAdBc5dwHIdQTmsAOw=
X-Gm-Gg: ASbGncudRTNzs+B5LyL2L23m53UXLhT3x0O3g3bpsv5zJ8bibX35+HJbEy3uEVfsPBG
	CdfCLR8thOUO5R3mY4AKtTD+QPQoaL1+t7LOM/d7p5kOOsRXcOGBaGD8ypkydDbGV3k0WJdhG/H
	9EaCGjnSZKHGXG/Kmb4iZoRwilY/iniOwfZ01QNBT0gWJUs2m/5UYrWJbMMguafxWwXvHygSnru
	0buxQyAO+FcfI5OocB0BfoQ47zKoUQTLZngjeJqhRslwo123mHLHIKh9rgyQFeiVW0WGQBVY1o/
	9a9yZuaNUVeoTXfdJU4DIL+j4whX0hBkL8SgUrEiE5D3IE5Z0CtMh25nF63PidwcFXTt6g==
X-Google-Smtp-Source: AGHT+IFe2CIssHzOnft5L6j+qBASQd7ICbxBKBKnPXX2l9y7vhFe+KHnO6lG9nf9EBuFFYKULvvZfQ==
X-Received: by 2002:a17:903:1b25:b0:220:e1e6:4472 with SMTP id d9443c01a7336-22a8a0545f9mr208034285ad.13.1744100228937;
        Tue, 08 Apr 2025 01:17:08 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ada20sm94319535ad.46.2025.04.08.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:17:08 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 0/2] wireguard: selftests: use nftables for testing
Date: Tue,  8 Apr 2025 08:16:50 +0000
Message-ID: <20250408081652.1330-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set convert the wireguard selftest to nftables, as iptables is
deparated and nftables is the default framework of most releases.

v6: fix typo in patch 1/2. Update the description (Phil Sutter)
v5: remove the counter in nft rules and link nft statically (Jason A. Donenfeld)
v4: no update, just re-send
v3: drop iptables directly (Jason A. Donenfeld)
    Also convert to using nft for qemu testing (Jason A. Donenfeld)
v2: use one nft table for testing (Phil Sutter)

Hangbin Liu (2):
  wireguard: selftests: convert iptables to nft
  wireguard: selftests: update to using nft for qemu test

 tools/testing/selftests/wireguard/netns.sh    | 29 +++++++++------
 .../testing/selftests/wireguard/qemu/Makefile | 36 ++++++++++++++-----
 .../selftests/wireguard/qemu/kernel.config    |  7 ++--
 3 files changed, 49 insertions(+), 23 deletions(-)

-- 
2.46.0


