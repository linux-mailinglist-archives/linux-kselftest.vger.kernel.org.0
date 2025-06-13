Return-Path: <linux-kselftest+bounces-34892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D64AD8A7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DF51E1D2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD12D23A6;
	Fri, 13 Jun 2025 11:31:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386471E0DE8;
	Fri, 13 Jun 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814315; cv=none; b=Wr28NaChQLL4D65PxxX2Rc+AubQr0JRIGpoMTCOVZ4c/kCnWkp4woxiaBLHthiHw27aPcExZX64DrvABYwG5+GlBVNHgEbXFAr3zYwlbqmrAtsSms0abc9/y1iCY4Ek05RFH+8P+OA8yiHpxtdJxN2TMHvbgBRjDucsUatj5lHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814315; c=relaxed/simple;
	bh=lgPBblrgv0M68GwCNU3VbSXeCXjyQfs5ViIdZ9bx198=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Umr9MdAqd7tl6aY5XtZ5Pqk27hgZleZXC1XmvR6NvwGdj7xy+tR+0p4vX52sh6xARJPbID4YEK+yvYMbPpjp8Er3MmyF3wlJl548URlJVeC8lsHQrXW5paavRT8ZPby0lg1rHl9uE/68dGJEmS+MIJH60/+FHiQ2oJ/RCmyWclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-addda47ebeaso386219366b.1;
        Fri, 13 Jun 2025 04:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749814311; x=1750419111;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DsHNuCTPZ33OCzYQersZU3liyxjgfm4XynZIaM+fP4=;
        b=CdUKgk89z62UMuTSa2NYr+zCi3jc1Rs1jGRbLhc2DFGhKKUbdRNHEWqcLzp2FhMquK
         KM79yXawDk8MNXg3Ei8bCqFHPvhFvYmZreVwj1C4H3UKWGmNk21zPnpH6LATbYJdqoXs
         ptykjwDsoLr9QWUXficoF0jhPOirPFAR3paovKumu6KYt8c4ukVsYzEEy36stMjiFOXu
         9tvq6+jqwusaHBitdR6BWBhu69RqaGiyqV2W76PLpDrcATba5kweBgzm1ixDG4b7Vjaz
         yvREN2hHmMvAEvmuedZMUUATYWbul8bX1ZA4+/sEOHR6r//ICC/tKNl6t4t/v19FeXR/
         8BMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXlUUN3ABtkdLpG5ItXgkdFI16aquFGPWkjtASuFULd6SdueQDcm3XGqRNSEbGKEvWTHkJOqYuTYArSx4=@vger.kernel.org, AJvYcCVsD5l270/RB9GTyJqSa7KcUPNpof+qEYZ3bW5So/TfxYv1FfYpXOVf+GPjUT5gtvL1Texx/SJQaCqNDp8IR5bw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DLs2wI1PzhLPmdTf1b1xx2Vi42WgHBIQ+mNLDIU9+pFzLsIy
	5W0IkZM4QdNnV4ji+wc5KWpcnnZAOoBRZlMGzPfDdUaYuWi49tLrHgiD+QEXrA==
X-Gm-Gg: ASbGncsP8qpol6SFH1RD+4Sgvbj5VBdYbNdVkRwBP+3aXFIx7EThlPiTQhLqQDs+orR
	rDviu9UPH8DrUifEfOgxdXE1l4vRfZqX6bl5ek09g5X/KlyaJ4gMmKROY2om5ynkcCRyxyqy/4a
	RD7FwjGCMG7uh4P9fW6EeVlb61XdUoIP0YvZDmSbzRftTrlEbB5C09U0l7jIy/UcSSVJyoG1dtR
	Xx22AnzQqnGkn9tCWiV8PljGvGH7dPmCoXZL6sAxQg4gjAnMqPHCXMXQQYNUWs5h2fkKFEC0A1U
	hOjGwRE008b7PGpPAQwMHh+1GuVAqKk0jkX4sf9xAlTOjibKeWYH
X-Google-Smtp-Source: AGHT+IEbCs4FhoglbncFe9pZ+ja3OdFwimVMb1BhOCQsjRvvlZn6qGl3xavu+j1ctls1AsRlnwhjzg==
X-Received: by 2002:a17:907:e8a:b0:add:f4ac:171f with SMTP id a640c23a62f3a-adec55958e1mr262728666b.5.1749814310950;
        Fri, 13 Jun 2025 04:31:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c1f6asm115696666b.55.2025.06.13.04.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 04:31:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/8] netpoll: Untangle netconsole and netpoll
Date: Fri, 13 Jun 2025 04:31:29 -0700
Message-Id: <20250613-rework-v3-0-0752bf2e6912@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABEMTGgC/1XNywrCMBCF4VcJs+5IMr1Yu/I9xEWaTNsgpJKUW
 Cl9dyGi6Prwf2eDyMFxhE5sEDi56GYPnSgLAWbSfmR0FjoBJKmWjSwx8GMONzTqWBttW0vEUAi
 4Bx7cmqELeF7Q87rAtRAwubjM4Zkfksr7G1PygyWFEo9msExtOVDVnC33TvvDHMZsJPrt1Lcjl
 Kh7ZU/UV3Vr9F+37/sLzxLxAt8AAAA=
X-Change-ID: 20250603-rework-c175cad8d22e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=leitao@debian.org;
 h=from:subject:message-id; bh=lgPBblrgv0M68GwCNU3VbSXeCXjyQfs5ViIdZ9bx198=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAwlnyaH8jaRLCKHTntak/Jqr2iUAAuXZ5f7A
 aujtNNz1+KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwMJQAKCRA1o5Of/Hh3
 baaPEACHQiX7kPFbVJLLzRVfQgjQ1p9ZsmEiSSXaj8TEKD5Ocph/L4h9C2Fzem5IBEs+R6bR0Oz
 rMMuLmV847Hxj5HbpydiMzmggeLUkQGiToZL2O612l4HtmEAi1ukB+WSaHqwc4f7bedmxZk207q
 avG4HcbC9djx1CjRl/ByIDBdomf0PEIrUwIZDWzh5usqFaDAIdhc/Lbj6z3ntCj3ldq5eTVtAss
 WFgK5vvZk//9o9SaUp1Csl5iNYWbbuj2fUtyqh+pr+SjX/B5k1w9bKyWM+3MDT9ixFE1QzGYFM6
 WRAkZDUJDcHAMjcMpmNAqIRwjwI1X7Vg7vMo5PRzO0kk6xR3DFnhU1zhkcciCi9uHpfH2hsd/hZ
 37UBUCYzYgeHo3yjpI+l5GCyJngavR5f+VhWDqdXyR5/WU6EblYXPhVdvIbp72+WmahXOkidkWr
 jsslpJBOQ7DLM5SqnFajgxn9EarHYEYfOyyjwL4NQ8XEVumVFWh3gBI9W2WzKb9EXGHrh4ACPGi
 ymd5+HcixxgxbukXkDdHBEpLiJ6WIpxE+CtpMfNySHTZJFkchj1/GkUmT/1lCinEV0x6f+ZXuHd
 nBbPBcUk27vKJyJjzSSr4Vsm0aI1oUXmTnTr7F8VmuOTVC4JoXKpFFyTZ6qqJRTIRWxB7GvC7s1
 LVC3BUeBOqIghjg==
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
Changes in v3:
- The cleanup on the netcons_cmdline.sh test was not cleaning the
  netdevsim. Clean it at the end of the test. (Jakub)
- Link to v2: https://lore.kernel.org/r/20250611-rework-v2-0-ab1d92b458ca@debian.org

Changes in v2:
- No change in the code. Just rebased the patches onto netnext/main
- Link to v1: https://lore.kernel.org/r/20250610-rework-v1-0-7cfde283f246@debian.org

---
Breno Leitao (8):
      netpoll: remove __netpoll_cleanup from exported API
      netpoll: expose netpoll logging macros in public header
      netpoll: relocate netconsole-specific functions to netconsole module
      netpoll: move netpoll_print_options to netconsole
      netconsole: rename functions to better reflect their purpose
      netconsole: improve code style in parser function
      selftests: net: Refactor cleanup logic in lib_netcons.sh
      selftests: net: add netconsole test for cmdline configuration

 drivers/net/netconsole.c                           | 137 ++++++++++++++++++++-
 include/linux/netpoll.h                            |  10 +-
 net/core/netpoll.c                                 | 136 +-------------------
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  59 ++++++---
 .../selftests/drivers/net/netcons_cmdline.sh       |  52 ++++++++
 6 files changed, 240 insertions(+), 155 deletions(-)
---
base-commit: 6d4e01d29d87356924f1521ca6df7a364e948f13
change-id: 20250603-rework-c175cad8d22e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


