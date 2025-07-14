Return-Path: <linux-kselftest+bounces-37283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA795B04901
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 23:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C974A261F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 21:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A9B23AB8B;
	Mon, 14 Jul 2025 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCNb9MQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9839815C158;
	Mon, 14 Jul 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527057; cv=none; b=bEkEnY7/AeAVgJ1f4fQwLqB3jFObCiTO/2rasDTORtSp3pOQWPATDeQQYir3REaykhQ9/DwelLAP+PcaY7Fu4UIORBYwmbN8m2sFK28OmtcRQGe75xs6JqWoTuAE6LPcVSHQTxQ2lj054cvJQBWOyyJ2dEPFZow+6aXvTEEjgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527057; c=relaxed/simple;
	bh=XWC0zxNYZfIjRWOG7IoJiPS5eyTrWieCg+q04+Ow2d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMs0DA49FLo8ityGySoEnbmr9RCe5xdqJouMIrBmpVJwg7O5pI3rRFDilEMjLKA/Ucvu5XnMdXy1IexNFlN46VgBTUcoqMZU5tYGL/YosIPi/JTGg4RmQZhQFcPorVp0m9D+Gq7ruwLh+NqglFOBlHaJnUpUCnsAi8RCbJC1t38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCNb9MQ/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so33447735e9.1;
        Mon, 14 Jul 2025 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527052; x=1753131852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mouR0tzYVYgaU9BwCE8alLNv2Rg+cKwIajr55xzq3Io=;
        b=NCNb9MQ/QzEiPl+AjCNda7ZSJDFm5STuDzcV4G3z+LE6z52/58mquzKJm3qoPCClsy
         YVXXMwTZ/N0y9LbLIvvqx6WUG8ldgnLydZBQA1n95HJqVkMF1SDNFbI8WMllcwiCNT90
         lpe7ixfqmPiGtv9NILtIb6biZ2N3cj8uBFgllxTkpHMJq36VQjW6ECscG3yoApqfRVzZ
         QWzoN2RJ+T+Tu6JYewKSIdg+lVM3xGPwyFyu3rsIoSFeEL8Uh+3+7ECZhsU6MEgzBQx6
         Ql6D0CJQRqKX/9xBUgcBegxF/oCgN4QMQPnAxlX+H5azv1ywM7EdhEJgA60vXNKBE6AO
         XkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527052; x=1753131852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mouR0tzYVYgaU9BwCE8alLNv2Rg+cKwIajr55xzq3Io=;
        b=Jw4Jcsl4oFJp1SqvIWzOR9Dwy/NXvjdtgnygOVhYDkoM4iPeuJ1MuS/jN0Etc4c67Y
         mjvf62K5tnRtqo9lQDCfm7z52wG+MCdvpRzWvInaqEVaWjuLEjaBRuAd76TTYe4I/vg3
         wKFnCis8rgBab0NbKc3xHbAwLrHtcyb+tjZJKHvE0Mlk1neGkssClKhO+shthtDKHaKc
         rlArdYdKqQtbp+58Do2gmsMrlgZyh5DyqHaYUzNjBhVzX0iSOJC0aYsfILC4XklKa7Tu
         j3NPYuLdxOTXBoPvt/dJEQn73XwyVW7SB14P7uNleagPpBNEid9yXcbIxctLCncZcyF5
         elGA==
X-Forwarded-Encrypted: i=1; AJvYcCVV230zqE6CeR4lRbPhVAJClfMyyxqBub4ompt508UvmKJjZ/MMOqgsg/PKbWRdjP+Ho47rOXsnNc89nOcjSWyd@vger.kernel.org, AJvYcCW9DB0xwrTYiv+nm+Kf5HvRBOuPV5swvuSA1DF51lOFo9nwG6Wq0EnJPXZy5r/+NMV4xOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9r2hEAKOJz/vSbgNk+oEB0WKo+yj1/Ob8qSY4g1/irnS910Bg
	eJz8Tv1TqDpEKk11KPwCmZ8WuvvdVFZsTqQ1Ret5QLAzR9Pw8T0mnVa725J0c6GL
X-Gm-Gg: ASbGnctpOwcQ99xJ3HgP5OZV96Ek4C5N7KjWbZfcM5zDWqzaM7ZDsSd9UJcUzCWB7BR
	RM826EoRZseorr86Ql6TFbzLaDzgrCCd4ufFLDAHiFwQlPPRjujecpOhJU9vT9XVJutZux4r+SE
	XrtnSzUM47kta5kxqRII6VFwY5Ml+FzYCIWT1OQy9PynC0wDRfJM79eQL3UFUOhg/ncxWgv4WFE
	fSfiy9UEeS4zmKJxY1rcUG5wOkOlcEbJIoTpaIkBV31ocYxu9HJ4jPlm5ramnyxzji2t7KX9V9H
	mZGmKdeAtKigWmEH1w1wMkdvV/vIPJ0rUsKPo7I10jashNl0steb58gXoKOmiqWvVtLdnqveSbi
	Q8+HNY2YCBJCTTC5fvpY=
X-Google-Smtp-Source: AGHT+IH6zXTxX+LNCWcxRTcfW/J/nHlhc1PThiqfATIeWBU6atdA9tOZZyTYRLPbCj8P4NRFR2HI9w==
X-Received: by 2002:a05:600c:8505:b0:442:e0f9:394d with SMTP id 5b1f17b1804b1-45565edc90dmr113035265e9.24.1752527052297;
        Mon, 14 Jul 2025 14:04:12 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b176f87sm40748325e9.35.2025.07.14.14.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 14:04:11 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next V4 0/5] selftests: drv-net: Test XDP native support
Date: Mon, 14 Jul 2025 14:03:47 -0700
Message-ID: <20250714210352.1115230-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add tests to validate XDP native support for PASS,
DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
For adjustment tests, validate support for both the extension and
shrinking cases across various packet sizes and offset values.

The pass criteria for head/tail adjustment tests require that at-least
one adjustment value works for at-least one packet size. This ensure
that the variability in maximum supported head/tail adjustment offset
across different drivers is being incorporated.

The results reported in this series are based on fbnic. However, the
series is tested against multiple other drivers including netdevism.

Note: The XDP support for fbnic will be added later.
---
Change-log:
V4:
  - Support XDP handling for netdevsim
  - Fix pylint warning with P4
  - Update commit message for P2,P3 to show pass/fail summary
V3: https://lore.kernel.org/netdev/20250712002648.2385849-1-mohsin.bashr@gmail.com
V2: https://lore.kernel.org/netdev/20250710184351.63797-1-mohsin.bashr@gmail.com
V1: https://lore.kernel.org/netdev/20250709173707.3177206-1-mohsin.bashr@gmail.com


Jakub Kicinski (1):
  net: netdevsim: hook in XDP handling

Mohsin Bashir (4):
  selftests: drv-net: Test XDP_PASS/DROP support
  selftests: drv-net: Test XDP_TX support
  selftests: drv-net: Test tail-adjustment support
  selftests: drv-net: Test head-adjustment support

 drivers/net/netdevsim/netdev.c                |  19 +-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 tools/testing/selftests/drivers/net/xdp.py    | 656 ++++++++++++++++++
 .../selftests/net/lib/xdp_native.bpf.c        | 538 ++++++++++++++
 4 files changed, 1213 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/xdp.py
 create mode 100644 tools/testing/selftests/net/lib/xdp_native.bpf.c

-- 
2.47.1


