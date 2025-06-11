Return-Path: <linux-kselftest+bounces-34716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB77AD586E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EFC1882603
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CDF283146;
	Wed, 11 Jun 2025 14:19:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65082E6108;
	Wed, 11 Jun 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651550; cv=none; b=Sgg34T0fl5v72UFfOG9SWapEQqPt1CDpNsfBjc3bj5ba8xgDBFjz7hvrxq93AHF/zQjn+kbBPW2stWjxPt6POPx9r9QPJ6Bj3O3l4ccoOkB104wiAaxF9I+cH4pUudSaD/nUE37MYjITgbMDFF7urMXr0lJZHDUEitNWyzlA1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651550; c=relaxed/simple;
	bh=X4yR9SQrkQy8lHFnfWIIxbFQEOqZ/7ogBROBwNzUJOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z1BWKrAUymMqmV8tcZ5Y5EhDF7zubaX/2xgb8UeeUAq6AraUGdpdzNeGv+yHBqbuOL4g6X8030XG/RblHzsnVlQarig1Md0+tUOgQCBNibCCmCdiXwqpL9Cz928+N1EBrAEEsdtKYZd4tz4rtSEIhPjysw8ryI/Ohf9rC0RETco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so8292459a12.2;
        Wed, 11 Jun 2025 07:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651547; x=1750256347;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIinT2SIgTziz1viNL6oRRdjX3djEg9Ov01XppuG91E=;
        b=hVNvPBBOT5PeA58R4ZoXUBVCf9NzBtAL+5djyZFdOHQzzDs5/xZgVsj3Xc60azKDqv
         d8qWyfy0QMekggY00RQi/QA8of1rzcyZA12hEpnMa4sGaprV3+Zgu4tg6R/1yxlwpiYW
         SYb6F++ggihRGGSF4H4FtxylrbraFxABDmqPKuwi/ZZRbdLn2pqQ6/s+h9yvrBd3QOCX
         diWVUhWgEjxvRkCDNf35AeM21YAQik7cjFR/eQe4L1c07xgs89m/pGvhutJoLF4Aoyn/
         TxPTx9ud+3Islza0o8PKMO6JX7XEOEE+N2k5i1dhJezYY/uTRZQYw5cf5qPtIz22slHe
         4n2A==
X-Forwarded-Encrypted: i=1; AJvYcCUbyk1vcTM5G9uDXQfDmvBQ1b0RLVXcDyA4U4JCftu/tucsXMHBqN6z+ovJrhzduSEQC6RIoE6tpomYBtSRBH21@vger.kernel.org, AJvYcCV5p1K2eztAAgDVTYx+sAGUavrDVKmUTwvyk1ekXVQy7M1Q1yo4HzognW+W39326mlgiDQKB3uWNgp9oYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBW62TX2ySGNeEaB2cFhEjhaL2Hb4Ouc8z72SrjxxZBqOIFZu
	N8RK6vFPHtzLSoT2AOHcNaqZSsrvSTKJbGlHnVum52L9KdoVSsz0O6s4
X-Gm-Gg: ASbGnctux8CHzfedkjDY5IrnEmtmBhzMsW2Vn0tKGw0elXRjrExck67wlHatGGrKRcY
	KH2S8tURnCKMqAEFWRuGcPPchJh/uZVbU2wZpd3TQyiAMAPSnbNFL4oVIcJy+P5lIudlLuGLlCU
	Vc3WE+uursXIhPu2WEBStkh/nUmcd1l/SiEXvrhmnF4SC3bxK1Dvc+mHA7YaU7YYEKj55QVHM75
	Mswa0aUo1Bu+ZKtNIzv440fqh2O9rKwEDX2RPFI3cTC6actGhZwr0BBPkmqMqLQoiu0c3V0WC6D
	E2cqW1bnlWjtbDLvdwDlO22rGytGUGBbHlzTYJmyEVucHnA3Z+sfCg==
X-Google-Smtp-Source: AGHT+IFzUJoywpTHPudWC/GZ6du/khG/9ZL7dbUEeZ45ypUoENUVoIAFYM9Vb6fU0/XrcyoSS/npLA==
X-Received: by 2002:a05:6402:27c6:b0:607:f61f:cc1c with SMTP id 4fb4d7f45d1cf-60845c8bd53mr3130429a12.0.1749651547108;
        Wed, 11 Jun 2025 07:19:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c0549sm7738559a12.47.2025.06.11.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:19:06 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] netpoll: Untangle netconsole and netpoll
Date: Wed, 11 Jun 2025 07:18:49 -0700
Message-Id: <20250611-rework-v2-0-ab1d92b458ca@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqQSWgC/zXNTQqDMBBA4auEWZuSjPUHV71HcWGTUYdCUibBW
 sS7F1K6fvC9AxIJU4JBHSC0ceIYYFBYKXDrFBbS7GFQgAYb05paC72jPLWzXeMm33tEgkrBS2j
 mvUB3CJR1oD3DWClYOeUon3LYbOk/zJo/tlltdOdmT9jXM17bm6cHT+ESZYHxPM8vDgSFnacAA
 AA=
X-Change-ID: 20250603-rework-c175cad8d22e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=leitao@debian.org;
 h=from:subject:message-id; bh=X4yR9SQrkQy8lHFnfWIIxbFQEOqZ/7ogBROBwNzUJOs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZBZbrxdRAfgKoGRA36Q/dLDzoe2v7zwF/+6K
 wngzZLd9LmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmQWQAKCRA1o5Of/Hh3
 bW9oEACC9JH7SImQs/lVPOBGPO0W2aaajB3MQ8ghNDyAABXg7hjW+d6TRF9p+aZlqIsJ7h8aanS
 mdEMpSQCl/jcB0Rm4yU8i85K9m4LE/WoEhMDNk0UOWlutcZlPxBBmVPYIWY00EbAf3908MrakX3
 nAun7mQmVlv1NkeHai6DwVLVEcSdgY0e2Xw6ftFcrIJu0mrXeAfB/chBh5QSpAL6FXid+WjPEzb
 uH/+ynJxsoaGzeHHqgqppgk3tQHLuBL6F4Bxy2Dk37FvfrWvUMENOuPJUdXoqnX2iiq6pmwGvkQ
 7KHw7ioAwVzPTcq+RN1RqKGYaq8bJfC5YZE01Iqi+lXrd9ZwGzz+nVhVM98Tqn/FFOq+P41gP1R
 xd0VdJeANgngHWEpnyXGQTxJVkHn09mk/B4pnurHzjQIK1DfmGWsimIqJkiMDzz/K5mz52ZdrVg
 h0zY88ztYXjtRXIjnD3e2aN6yXzgg78SRFxXHMixH6+BcesYMNoeGbF3OG3lElSuNs86rc+OLvn
 bOlkBvpC3yx19A8M5ta4h9/KY7s19H4IIRfw5wZ7iRrJ3dh/VXcRmRxgyQeuNflO9kEr29nHKol
 lxvxUC5td+uoHQ3CrzXao2h75xRlmzncv4l4/LIplFfHW8+ULEOdzs5Xn3yLV1YuZrr3fWpPzSL
 8gzHV6XUUkDT0Zw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Initially netpoll and netconsole were created together, and some
functions are in the wrong file. Seperate netconsole-only functions
in netconsole, avoiding exports.

1. Expose netpoll logging macros in the public header to enable consistent
   log formatting across netpoll consumers.

2. Relocate netconsole-specific functions from netpoll to the netconsole
   module where they are actually used, reducing unnecessary coupling.

3. Remove unnecessary function exports

4. Rename netpoll parsing functions in netconsole to better reflect their
   specific usage.

5. Create a test to check that cmdline works fine. This was in my todo
   list since [1], this was a good time to add it here to make sure this
   patchset doesn't regress.

PS: The code was split in a way that it is easy to review. When copying
the functions from netpoll to netconsole, I do not change than other
than adding `static`. This will make checkpatch unhappy, but, further
patches will address the issues. It is done this way to make it easy for
reviewers.

Link: https://lore.kernel.org/netdev/Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- No change in the code. Just rebased the patches onto netnext/main
- Link to v1: https://lore.kernel.org/r/20250610-rework-v1-0-7cfde283f246@debian.org

---
Breno Leitao (7):
      netpoll: remove __netpoll_cleanup from exported API
      netpoll: expose netpoll logging macros in public header
      netpoll: relocate netconsole-specific functions to netconsole module
      netpoll: move netpoll_print_options to netconsole
      netconsole: rename functions to better reflect their purpose
      netconsole: improve code style in parser function
      selftest: netconsole: add test for cmdline configuration

 drivers/net/netconsole.c                           | 137 ++++++++++++++++++++-
 include/linux/netpoll.h                            |  10 +-
 net/core/netpoll.c                                 | 136 +-------------------
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  39 +++++-
 .../selftests/drivers/net/netcons_cmdline.sh       |  52 ++++++++
 6 files changed, 228 insertions(+), 147 deletions(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250603-rework-c175cad8d22e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


