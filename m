Return-Path: <linux-kselftest+bounces-26211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9BA2F913
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130511678F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA1F253339;
	Mon, 10 Feb 2025 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WAJCuwq2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86A259489
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216361; cv=none; b=QOEh9h/QIscwOiWzF6jBTgiM2hnPbkUmNlOq5Rah8RDysFMNDc4+/44X7J6N55F+JkZ8EV35KRsN9XkbUgRyK2EYNG59bD42AftWtRMmlcAazDwx2uTV1NXCPIYCozq1V/XuOYOWG6Cccuaztx5gpj76Hkw9lNV/jEFsQOAcX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216361; c=relaxed/simple;
	bh=SMwyS9nPdl4PzF9T3RRqplLovaUBZmppKJYwauNMyH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Htb3VGOTa+kitMrwRun/biz+sS2YdE5FAVwlPQCHpLdid3V4p78pLc8WIV+SGygsE73lpXSaSCc88gh/yWtcMuP7lUGScGBV2h1uY5gwsoJB9TjrGFcHPcdbWJMp5cQuh+mbxMjKnKfFxjjQPh+4740Iro9OfKA1A4RWyX6lAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WAJCuwq2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa19e1d027so5967875a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739216357; x=1739821157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKy7YiG1YFhKf//Vgk1qUpKZfU1FuTHylGStbHj3LEQ=;
        b=WAJCuwq27Uv1b5+61gjc+bLM7bJ3UnUqDrZRCNiP707kRmAC8N/b+VcLFiYKjN+oqQ
         2tdLKtMeRdi2LdsZqgUpLIMc10Jtm589ntZz+x/9/9tPedhSS47yDYw5mL4loptD2m2k
         rNN8HlypA2JdZcC5K4lJlj4E3iSF1Uonf/mY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216357; x=1739821157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKy7YiG1YFhKf//Vgk1qUpKZfU1FuTHylGStbHj3LEQ=;
        b=Zw95T6kdboiDvlGVxnnjvsq6ASd6kEQ1dH5KRhkpbh3dQD4hLz/N/F22VYUlXY9pyp
         iQSUN/orLcIgxeiu68vBkKKp/doKMpcX/FqpeXneVLfKitr5NbWRiLf6mViLUR9aVQnf
         uo4lRwTAs+m1eD+/iwStdMMH/A+19Now/35T9YYkN7FfOKsFGnKBk++BzirvsKsICvwq
         NMG5je83TV9akywsYb1UJlLHYlne//X1vtNc/Mrba8LY6o0TqUIAZE15a2Y+jb8tUSCD
         upl9FnO6oYHRlMIY8P0zTT5Raceve9lr6OaAtsb11SOO962CFeB+tK1CDVXlmDP4xDE7
         yl+w==
X-Forwarded-Encrypted: i=1; AJvYcCX0KhV7lktr+lrSQsjz6I61ovaUPy0ISm8TnL2N8sZnz2+wdU8sgV48cBBcBYw9Q/XaaDTnO0jDX1N9A8J9K00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItJwxE9nZW4dZBJyPDE3rQ3KOd2ibSBUAbgCbjaxUB/m16NfL
	fnQTSSPEtyjMwkwnPSS+u1+TeZvVE3rGupaPodZIQRdIVpGZrnlWw0nyOPf4iaU=
X-Gm-Gg: ASbGncte6dYVmXxZ2xGSMzCDhHxS8I3GXM+F34hsOvv8pxIY1P38nb/cLfdlnLNf5/i
	x3XTibe37iRaRF0+WdL9bE+T+xFu28Q6HilezaOc6vkV5w17ZCnnmqmUfy/6yZQ+yA8PDoPHqeB
	8jztaws8/lEYnlG0fO1wb/rqGf6TkmhJv6eea99SqeR9Qqkxq/Paqz6A/cH2cKXr9wy3IOcW0ia
	zpDKb3dM3SGP2SLnfjp/9hIhkJ66MkV34a+57fERfiNPsnWPQozL//wUp47NDp3CBlM9YKJ9g99
	E3tCpUA/Lf0Tsi5c4dyCM90=
X-Google-Smtp-Source: AGHT+IHM5FFPt6Jm2yk0AieuE+gekb4VNczSj8ocv/njhtyRurgNpUYCU87vT18p6yecCAAHWKrQ0Q==
X-Received: by 2002:a17:90b:3c0e:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2fa243ee52dmr25665057a91.33.1739216357573;
        Mon, 10 Feb 2025 11:39:17 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2ecbca6dsm4226510a91.0.2025.02.10.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:39:17 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: stfomichev@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Wei <dw@davidwei.uk>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v6 0/3] netdev-genl: Add an xsk attribute to queues
Date: Mon, 10 Feb 2025 19:38:38 +0000
Message-ID: <20250210193903.16235-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings

Welcome to v6. Added ifdefs to patch 2 and built with CONFIG_XDP_SOCKETS
both enabled and disabled to confirm it builds cleanly. No other
changes.

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v6:
  - Added ifdefs for CONFIG_XDP_SOCKETS in patch 2 as Stanislav
    suggested.

v5: https://lore.kernel.org/bpf/20250208041248.111118-1-jdamato@fastly.com/
  - Removed unused ret variable from patch 2 as Simon suggested.

v4: https://lore.kernel.org/lkml/20250207030916.32751-1-jdamato@fastly.com/
  - Add patch 1, as suggested by Jakub, which adds an empty nest helper.
  - Use the helper in patch 2, which makes the code cleaner and prevents
    a possible bug.

v3: https://lore.kernel.org/netdev/20250204191108.161046-1-jdamato@fastly.com/
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

Joe Damato (3):
  netlink: Add nla_put_empty_nest helper
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/net/netlink.h                         | 15 ++++
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 12 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 89 +++++++++++++++++++
 9 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: 39f54262ba499d862420a97719d2f0eea0cbd394
-- 
2.43.0


