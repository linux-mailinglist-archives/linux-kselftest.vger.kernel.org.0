Return-Path: <linux-kselftest+bounces-25801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDAA28446
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 07:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC251884DD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E309228393;
	Wed,  5 Feb 2025 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="oqSg86sI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D3228372
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736556; cv=none; b=CKvka0OyeWYFt3tzILkwrADGDQEMXkO7p6IChor49r1Ak8F4bQecB4S61SDFb1l8epH9K5KI4zNBb9gELWBfCRJo9eMoQr0Nd4aVro3Hgr+t1fcuStmp1pOozWqnT/CiQutySdMXinAIrQm9Ajg4UGrIh794ZaDuI2+5MrWAFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736556; c=relaxed/simple;
	bh=8WDHU2a8o+TvYU7S89Oev00JE4W0USl7Pr/i42Ilkw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t3CUUBi4WZkiOXM6VpaVz0C2ucH5d9cU9FbUSPnPQ2tc26WhkW83bQa0+VDAl/A4+qClxZhJY0fPkzuxDUJmODME1tIhRtoQfMu3PZaxq6UNwJm/APXX3x1HSae6hIqAjr94kAGrNW+FZl6xvvOHP0G3z0lR2ZDdHBzngRm1acM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=oqSg86sI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2167141dfa1so9514565ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 22:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736553; x=1739341353; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wOXEQBExe63vCNTctnNxequJPweHzEdNjWgMgaz30k=;
        b=oqSg86sI56IwwQf8fB3KoHj91QD7itz8Ylo8pI6a/1LWeRg6lrIQPWfOZOpde1Nmza
         iFdGUI+jF96Nn/vCIlhJJ9Irzndw24Omv9yZ29ASz0b6aN7EYoiitmlyrmN4KXn38zUm
         U4RCgc5Neg/taS49IEed7KoD3XWf+q5ETtGaHHtcluPOGyB9uq7prw44pR6NySC+hj46
         q7xrWHlQbAW6yU4HgAtxaAx3GjQRSKsSfiJSIDqzDjstA6NtomvLoIh4yxWhW617aTrd
         BQe9LuXL+ytgrFdF2u7lBowBecziE9BKNcL8eRcYl4deY12Hvyl22WZvINlEPAPVJ+Nf
         jLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736553; x=1739341353;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wOXEQBExe63vCNTctnNxequJPweHzEdNjWgMgaz30k=;
        b=UXGk1rl1/6zkSq5s18iSXTIgSF2cyW0AS5AK42p4OfCDeI8U6puwEAuj6+vU+Qf8oA
         PcghmPMBlSgsQ5X8aokJWTWZPFZr27CmRMJ9A0Cvwvgh0gTmvT42Nt6u7eQZJvlNAJeL
         hCo6XGXKgAp/hgvRput93RWkFWyyJw/M2A+WDdunwSk+Xcu85POVTt4RoSgNoS1/clZ1
         eoxiSCX3d/pBDxLp6VYnwpIyIlmB5wBK74gbcQngI1i2ZFONfldjHKBoKPtiqwzl4UHw
         Fn/7Uq8ynTR1N91rerUvtM1AcHq4aKg1dQyGy0IsTy2COkV+DuJ6uoUVLhCBmXG9n+lp
         i2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW09vMPLiuIpWlM4nwZWmmlFGElLu0sutZ2eM/oYiQ+QMw4zdg70dJXN8ex9JxE89uSWUnGMwSCR92B5fwsY6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRftNvLuqQ4o1hkrauuqC58cEtTjmrGd+HgnnoydPDrD2LNOSp
	2pX85OIyt44oF5AMHqYbXNvi4rqJ0DeTQo3FrqVcUMl7oj0DbRKQGSTIFG4/50s=
X-Gm-Gg: ASbGncvw7DCxa7sYjfHpVjgFAIP2vqTYZ7oYhT81HtOkBRtLQ1RvYMIQeyETLfFHTfO
	sl18FxDvMIU7MYu2LNCPLT5E8yh3FmaPIpoAzs++ITIT492SwwO7Br125bQtOEtQWiIj8uhc7aL
	juYIEhxvbiru5eDQSQmQ/bqk2QpBlP/IhM79KJgfqoutme4ZP34nRZpGsnN3CUtrh2FAi4zhDHS
	LH/pYuP+MuHyTf7VYnOaUzBMmVuxy3dbErDtGFOUWY+h7D/gNKfVFzWuLib3T2uaSu1p6wxzehB
	AXd3QIpk2/mx2pfmAXM=
X-Google-Smtp-Source: AGHT+IG21WhSzoCJIvm+AnHNi/NgJ8H7PS8WPvT9Thipit8jAsTx6btg48nfdeJxttEXxjhIUHpDhw==
X-Received: by 2002:a17:902:da8a:b0:21d:90d0:6c10 with SMTP id d9443c01a7336-21f17adb5c1mr29744745ad.23.1738736551500;
        Tue, 04 Feb 2025 22:22:31 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21efe2eb4dfsm28940985ad.124.2025.02.04.22.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v5 0/7] tun: Unify vnet implementation
Date: Wed, 05 Feb 2025 15:22:22 +0900
Message-Id: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4Do2cC/2XQza7CIBAF4FcxrMXwV6Cu7nvcuKBlemUhVYqkx
 vTdncCmNy4nM99JzrzJAinAQs6HN0lQwhLmiEN3PJDx6uIf0OBxJoIJxYVkND8j1Ro4c6of2Gg
 IXt4TTGGtKb8kQqYR1kwuuLmGJc/pVeMLr3tM6hhntiYVThnVxhurBqmkUT/evWJYT+N8qwFF7
 FHfkEAkrfXGd05Y476Q3CGuG5KIRj3gPYfeTOYLqR0SrWhRiAAs994x6c30D22teoLHE/+WW//
 Ltn0AgPpSa1UBAAA=
X-Change-ID: 20241230-tun-66e10a49b0c7
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
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

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
Changes in v5:
- s/vnet_hdr_len_sz/vnet_hdr_sz/ for patch "tun: Decouple vnet handling"
  (Willem de Bruijn)
- Changed to inline vnet implementations to TUN and TAP.
- Dropped patch "tun: Avoid double-tracking iov_iter length changes" and
  "tap: Avoid double-tracking iov_iter length changes".
- Link to v4: https://lore.kernel.org/r/20250120-tun-v4-0-ee81dda03d7f@daynix.com

Changes in v4:
- s/sz/vnet_hdr_len_sz/ for patch "tun: Decouple vnet handling"
  (Willem de Bruijn)
- Reverted to add CONFIG_TUN_VNET.
- Link to v3: https://lore.kernel.org/r/20250116-tun-v3-0-c6b2871e97f7@daynix.com

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
Akihiko Odaki (7):
      tun: Refactor CONFIG_TUN_VNET_CROSS_LE
      tun: Keep hdr_len in tun_get_user()
      tun: Decouple vnet from tun_struct
      tun: Decouple vnet handling
      tun: Extract the vnet handling code
      tap: Keep hdr_len in tap_get_user()
      tap: Use tun's vnet-related code

 MAINTAINERS            |   2 +-
 drivers/net/tap.c      | 168 ++++++------------------------------------
 drivers/net/tun.c      | 193 ++++++-------------------------------------------
 drivers/net/tun_vnet.h | 184 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+), 316 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


