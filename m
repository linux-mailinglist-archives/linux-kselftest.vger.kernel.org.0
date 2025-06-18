Return-Path: <linux-kselftest+bounces-35256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C0BADE592
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AA93B9317
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D727EFF9;
	Wed, 18 Jun 2025 08:32:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683225B1DA;
	Wed, 18 Jun 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235579; cv=none; b=p1LHfoMtcprZI40JTlXKdmR7Qg+ClUUF1HjJ6dQRwRRqg30yvD9Awvy+93dM+f3oMIaCyZUlHL47BCIZcLkCKq9Bi0VqVbqdc36H3JhDayjhTHjgG4EB/cijzKldDpEZNKrQ5O5Q9RINHTjLzi2v97TAcDEB6PBtjqDHTA4EQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235579; c=relaxed/simple;
	bh=YZ2owkYi3X0AEVs+LYgxowjgbXXIYv8otbPc+FFdDh0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P9H/r4EneNDzj3e2AiciBmYoKzdDP1GLRUezOWPIT/TdRE7tVNScT686ixjeDxbNfqLVsKlyoyVaFm8kJvZGU6xSL+Z9u0ukd9RVEurMfUBfRpoBmj3jn1PoCmRbaKL1ZCVl6K168qgGcDIzD/RziH9PXUEPiqIsEaasF8Jb6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60780d74bbaso871409a12.0;
        Wed, 18 Jun 2025 01:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750235576; x=1750840376;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QidkYVW37CmwUswBeJDb096IVxANRzd4ryyxmJfoTyo=;
        b=D27H/1feTYIRVKTLQRM0PZKfnGVxfwhBwHnjtTiAMkTpmRXTeEAjcJtvCbgCviuGEf
         jnSxFbeM72RjrJmqUWCX0X4tL9wvrO2o5+4SFVwvNuBrpxHKg0NgBp96zI/AblAgaS1c
         TWU894hU7mPMTgyXhBQNgxdE2w5zOQ8yzYFPdERDXdoJam1sqFl8289OtTNzGakLx3wu
         NGilTfmd+tvhddtafJ2o/cO4Sc76wMnSjzVAF6vXzkm7d4VvZBZd2F/MFJDJwEFu1t25
         uzjDxsbc5nGmQV6qLwA2B/d7bHdXgY8p9DTCkwqrNEp8XOTGXINjaBgO25XbTV8R2bh8
         Nexg==
X-Forwarded-Encrypted: i=1; AJvYcCV6YGVdB7kX6mqVv3Y39lfi/hLgtea5bslYANOjObc/4nf2qzjRlnfsM1CPaolaG1Cim/t1bJAJdQrMcgM=@vger.kernel.org, AJvYcCXJglWyQXUpNTQrx4lANE61wD3zxjECNR5UWn9Ea37T/1C2cW1iZy5bptLdDZK4ZEuyNCErJFMQqhnvGtAyw3Pv@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOTlqCGCAG4LAl0cZ+KjXzzQTIpB0xwYV4NEMWZrrbQYBsiL2
	nr5qt6CpT6PHq2/BtfMWfoyyPXw6JLLSY6vQTuX92CPeoeQjbBwjCQvP
X-Gm-Gg: ASbGncukliT9gISE+29efMkQvQDeNzv2MzhssbkGOXtshGQA2JikiHoaJxgyg58wKHz
	qFW1o5juiCQULcHyXzUaThH1iKDJrzVRhWnKlwyKSFUMnrTIAI8/98nhJ7eOlfKsgqlXaLBFoS3
	cInOpaiRMMSqqtJMKvg6bVxZanuwKNgAV2b2jO/ZeW2hnXm+0ohsJIl46RA8EYFEJxqs9YcaV06
	o8bE/fJo9Gbu5iEQDx3zDniN6xKhfoBGLhMheqFSNeFTodpYD3cUoNCArblCrB1C+6wz8NEyBim
	oPQC8nXP5rdMMmlGLcxlEo7mqWi4MuMn9P2TW4t+MPA/Yfw2O10y
X-Google-Smtp-Source: AGHT+IESnlhzm6JY29BbKFKb++BCw4CagU+L4+qKbE73XqGEAhecsxPXDKaJUwi1i/vSUvnQf0x7Qw==
X-Received: by 2002:a05:6402:5187:b0:604:b87f:88b4 with SMTP id 4fb4d7f45d1cf-609c1873e6cmr1420416a12.2.1750235575356;
        Wed, 18 Jun 2025 01:32:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608cfadeb92sm7855479a12.13.2025.06.18.01.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 01:32:54 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/4] netdevsim: implement RX statistics using
 NETDEV_PCPU_STAT_DSTATS
Date: Wed, 18 Jun 2025 01:32:41 -0700
Message-Id: <20250618-netdevsim_stat-v4-0-19fe0d35e28e@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKl5UmgC/2XNy2rDMBCF4VcRs/YUXXyTV32PEIJkjRItKhdJi
 ATjdw+YLNx6ffj+s0KmFCjDxFZIVEMOS4SJtQ2D+WHinTA4mBhILjveC46RiqOaw88tF1NQd1p
 3WgriiqBh8JvIh+cevECkgpGeBa4Ng0fIZUmv/amKff9Exf9oFchxFsL23eB0b/23IxtM/FrSf
 W9VefTq5CVy1KM3ahxVP7fjyaujH05eIUfjqbVutl6q4Y/ftu0NwyG/2jcBAAA=
X-Change-ID: 20250610-netdevsim_stat-95995921e03e
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com, Joe Damato <joe@dama.to>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=leitao@debian.org;
 h=from:subject:message-id; bh=YZ2owkYi3X0AEVs+LYgxowjgbXXIYv8otbPc+FFdDh0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUnm10E7EUYsctvXTS2FPSCQTDuhoSvHsC2dps
 aVTjGWR8NWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFJ5tQAKCRA1o5Of/Hh3
 bVoqD/9vZcfM9dVn9HZvGuvP/wNGVEqBTTG0cOA56gJginOOtdgS9KWgya72Svaro3jAfZyMLRC
 AkhXS1LaAOhOHCmhDSJZDS5SFZnbKX0DoOZAYPtE3Gks98w4Ro7FN9cZxioCh3NWoMjztXeNXCn
 ovnmvz8pnmwCYj4GxY4wyTyiwZiV0Zb7VP9uDhjVqpcsFy1Vk5zxDegn/7HB01+T5TPxSesGsWY
 fGdWdi0uyKT8aaP+yB3BhX4X4eq5xBgzJAYyI7phKLye/ZENLM678yknZQ0FRU8JXWitvWTZR0e
 YIp5zXfbfqPZceNG6B2jArfCp11O1rND/5IDjaYmlh34OCk9CoJ17wJcOq/86Il+eYrdS6DIUxG
 7+ovCftIAistr0zg6/VNj+dwwM3OHNe/zP5R2rdMGrtssnWYhb9cTmEU8eWYSA7mQXasHCCQict
 +1bA6r4CdczAeOix0mpPBi4+spKrP52LOJHBa8eyO8/hHXPv8ZByrVnGzJgDlBzrCvhiZPTi5yy
 Jryf4ZYOrvGKLxyIlfmjLV7/+mCXUEV6ldQwG/Abr6GzDuLiAGUP0OUMmAqWOUXoehQ/+5o93Zv
 tJmIKk1L59ipBqjVdRpHY/2rcbvFlW0XkE45zaseJ0AE7Eej39hVCurE9k7OSJ/npWb+sgSdQ2l
 Dq14Z3/Z9qt41Zg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netdevsim driver previously lacked RX statistics support, which
prevented its use with the GenerateTraffic() test framework, as this
framework verifies traffic flow by checking RX byte counts.

This patch migrates netdevsim from its custom statistics collection to
the NETDEV_PCPU_STAT_DSTATS framework, as suggested by Jakub. This
change not only standardizes the statistics handling but also adds the
necessary RX statistics support required by the test framework.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Protect dev_dstats_rx_dropped_add() by disabling BH (Jakub)
- Link to v3: https://lore.kernel.org/r/20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org

Changes in v3:
- Rely on netdev from caller instead of napi->dev in nsim_queue_free().
- Link to v2: https://lore.kernel.org/r/20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org

Changes in v2:
- Changed the RX collection place from nsim_napi_rx() to nsim_rcv (Joe Damato)
- Collect RX dropped packets statistic in nsim_queue_free() (Jakub)
- Added a helper in dstat to add values to RX dropped packets
- Link to v1: https://lore.kernel.org/r/20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org

---
Breno Leitao (4):
      netdevsim: migrate to dstats stats collection
      netdevsim: collect statistics at RX side
      net: add dev_dstats_rx_dropped_add() helper
      netdevsim: account dropped packet length in stats on queue free

 drivers/net/netdevsim/netdev.c    | 56 ++++++++++++++++-----------------------
 drivers/net/netdevsim/netdevsim.h |  5 ----
 include/linux/netdevice.h         | 10 +++++++
 3 files changed, 33 insertions(+), 38 deletions(-)
---
base-commit: 3b5b1c428260152e47c9584bc176f358b87ca82d
change-id: 20250610-netdevsim_stat-95995921e03e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


