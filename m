Return-Path: <linux-kselftest+bounces-24624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233AFA134B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8043A0479
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F151A8F89;
	Thu, 16 Jan 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="wEQMDi9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8121990B7
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014914; cv=none; b=ODFCt82cIDObNE56DB2wm4tBCt58pf1jyzLaqzZCLfa8up0k+/FMcjC6dPckxFzXKtDv5qvNGqNFvr/T8RRIJvebZ0CQ5xcUu6F7VGd5ufuGlCSAx1EQ+kOn1ZaOqSAZ02jghROzGAm+ptwhtVyJT7s/rYYvPHalfQLFjnyVq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014914; c=relaxed/simple;
	bh=+CC2205P/4QjZOTULtxLx/pTHHo7ousX5VpLNpbUGG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=buiU7efyt5HixA1naVmgMGAyZPpzMExdQNuZE6XvHPtJfgcP+3+M+9RYhpaTysmnwRnG815azGUHqFc4Cfl0pEV+ptGyXhEIOQgbNtF3/Q2qPQBYoM/iHZyUeLcQrE8cLtTgbqmj0VtKOGMBlk34ujp1twmbNH0Ue3alknT+8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=wEQMDi9f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21619108a6bso8844165ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014912; x=1737619712; darn=vger.kernel.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvSgzzLjp0cbfCfki4o3Cp/OkRE34mhTHVsplAbYOvE=;
        b=wEQMDi9f+r7KOE71G/1n85bG0I1SDHTu9ohOFbAaWXjjUCT8McDYr1vYixO3ljyjFf
         dLWJiZ7Vtpacy6Vn29a9WFziqFrdOFj29o7WTgumhspHCN6IyCd2xFQX5KGcvnNNZ+D5
         gZNAC/cTSrBgmCwJccuBdwaPrVF9aZsdThfzcoUSHZM+qx4H7pCVcClf1s3FESbpc+8/
         kOaeu42Y475EYYPB2oZNK3oFURjXaBAwqs7pWqhoquDHMmTgqJZLYtjYJ1ImhC/S7zVf
         3zWsBP2ETFdhSW7zdrzmNQAgX0tEO5Zx5EH1kIvjEIm56kSfg1LVr51oDYQnRRTKl7XS
         pAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014912; x=1737619712;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvSgzzLjp0cbfCfki4o3Cp/OkRE34mhTHVsplAbYOvE=;
        b=Tw2srbJRsOE6u5p1N/nMqgDDBMXxhwVR+6su+0Jt2erq/lpxaIx4nznljZGgHVC0c5
         XUH49mmZFeK8UfoEaVui3y5rApoFcEN5kWKRwrklZO3VcqwGznRJxQHOQb5ghljpkcK1
         YdkfooMtfMU5kpUwO/VcHF8piuEeVFMqwhoyw9Zs0p3Gg1eQS6ggVUufHmKC88FB4Yf2
         RHqhBx52urUFqeYU21L0xPDAphNwm54NnSxLHHvGqVO71+s8M1wakpaw/cdewjaKhPOU
         5rZeX2WwQ85TH+kSKfueEwlg5WjwEpEM0/cy42l1Tm2KOaCMHJ226lWov2AwVJnfmQH+
         NiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSCqRpn2ZbDzK8vVtozuYgNgqCGHoORQ4wXfy8tWjAApiblhSlpgcC0RGNt6tjJrjD9w9C9nyvg+E7AN0nqgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwwCUennyFlgdNzwyG27XOUSTArFzu8QlOS1sUaPXh30dzP2J
	5gsYD/o/nI8y9Wg3/wRat+Kx+xKJRjnd+73gXm15E5L3Ti/43LWgMNCJ9I+Ntzs=
X-Gm-Gg: ASbGnctSvzGA4GZhNecUF8V/uYufzQ+48rr7ChkHZbQRBe4ACeIGJoHnR0NNjKAXOcw
	qWW+guPH7FN+FblYxlVEnLM8i2PRSW/0q1knp7V8CvjogWCHsqvBwhVoZ/4YkV76Asdf9ptlagj
	TJxW4feNSSWFCmFdTgpG0n6p/pC1iRx97j2OnIk70wpvkCoNNZUDvCP4uDMOJHW/NNpsO/1zfmr
	qO1qDQzzGaRxaGqzcHP9y2dZtnBvgvaeqpC34muiwt6Fl3d3KNIR7AWC/c=
X-Google-Smtp-Source: AGHT+IFRLQCwktjyooiJq73WQ5ddpyLIN010dTt0KbqmXVNLbU3CCPmJHJQ7IqxozW/WCRUUVDqOaQ==
X-Received: by 2002:a05:6a20:6a25:b0:1e7:6f82:321f with SMTP id adf61e73a8af0-1e88d10749amr45114735637.17.1737014912054;
        Thu, 16 Jan 2025 00:08:32 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a31de807786sm10985666a12.76.2025.01.16.00.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net v3 0/9] tun: Unify vnet implementation
Date: Thu, 16 Jan 2025 17:08:03 +0900
Message-Id: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGS+iGcC/1WPyw6CMBBFf8XM2pq+oMWV/2FYFDpKFxZtC4EQ/
 t2mbHR5Z+ac3NkgYnAY4XraIODsoht9DuJ8gn4w/onE2ZyBUy4ZF5SkyZO6RkaNbDraK8iX74A
 PtxTLHTwmaPNwcDGNYS3mmZVVllSUUV0kMyOU1MoqLTshhZI3a1bvlks/vopg5r9Qc0A8Q0Jrq
 2xluFbmD9qPLgE/U34kHYXaff8CSWeB7uYAAAA=
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

When I implemented virtio's hash-related features to tun/tap [1],
I found tun/tap does not fill the entire region reserved for the virtio
header, leaving some uninitialized hole in the middle of the buffer
after read()/recvmesg().

This series fills the uninitialized hole. More concretely, the
num_buffers field will be initialized with 1, and the other fields will
be inialized with 0. Setting the num_buffers field to 1 is mandated by
virtio 1.0 [2].

The change to virtio header is preceded by another change that refactors
tun and tap to unify their virtio-related code.

[1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
[2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Dropped changes to fill the vnet header.
- Splitted patch "tun: Unify vnet implementation".
- Reverted spurious changes in patch "tun: Unify vnet implementation".
- Merged tun_vnet.c into TAP.
- Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com

Changes in v2:
- Fixed num_buffers endian.
- Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com

---
Akihiko Odaki (9):
      tun: Refactor CONFIG_TUN_VNET_CROSS_LE
      tun: Avoid double-tracking iov_iter length changes
      tun: Keep hdr_len in tun_get_user()
      tun: Decouple vnet from tun_struct
      tun: Decouple vnet handling
      tun: Extract the vnet handling code
      tap: Avoid double-tracking iov_iter length changes
      tap: Keep hdr_len in tap_get_user()
      tap: Use tun's vnet-related code

 MAINTAINERS            |   2 +-
 drivers/net/Kconfig    |   1 +
 drivers/net/Makefile   |   3 +-
 drivers/net/tap.c      | 172 ++++++------------------------------------
 drivers/net/tun.c      | 200 +++++++------------------------------------------
 drivers/net/tun_vnet.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  25 +++++++
 7 files changed, 260 insertions(+), 323 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


