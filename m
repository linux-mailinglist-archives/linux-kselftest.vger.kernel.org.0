Return-Path: <linux-kselftest+bounces-31830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC7A9FD95
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FA51708BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8852144C1;
	Mon, 28 Apr 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AD1oepuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D4212FA2
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881845; cv=none; b=XdD4KduYe12D142q8bhq9rKgK6xmx1TExgryn704cAQyU9l3aEBqn6rt/ad+ysgM0rhaGQWRhWEbsfCnfNICXm2vvTueS/02gti0bPN0+NYfT+9Tnd4bClu6anQeVQaBskjHkbt+FgqBM5nAtIRyvQ370yIAqOiv/CUrwZtM5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881845; c=relaxed/simple;
	bh=5R1ihXWNblpTcigqrOrVvxreW0nOHeJ3fH4HtMTNR2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFa2YS25SnJoDxn3H8ivIAi6uGc3f+ohKXbuEFFhrSrkrM3WCizV+P6Nac4AYUXLih4gWSbAaKy/Gb+Jq1LrIu2UN8vbBpYTTnzRsjE8SPfUegrQJ91hBX54N7cIL91XI5OyOT+km8m1MBcL9ubGAIlUKPvKUJw6RbQK53aeocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AD1oepuu; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-227a8cdd241so74113345ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745881842; x=1746486642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yN6X8qy6iIXBeRkDCjdD0w88qJ6dcCiPtrqiszUMgAY=;
        b=AD1oepuu0paRzg6wueEwG+FWx0b0H/PPA7MRK5MOvWF+apvUqAxkD0pj40F5oWvqIk
         FgPL4hxJI5cOMfO4a4wcEga+8JC7uWbCksIknxRel7aTj39VA4A+xk5pQGFMHjp52aD2
         4DoMArpUz1+OtD7HEwvHqShjvo5B4T2u/q5FBthbQsrwDVALlzWiHLQ3VFGxe5DbHSFQ
         Bo01dyN/fQViqn34hPG2T/wLsO2BgRJIynTwO84LAIzFyvrLKVjXSimdKgypGsJvCQKN
         gtK8sA1QB2Sw7n2HmIJtO/FphR3xVNrbdT2TuuJFUQbgabzPr6LkCpXVaCnsH5uz+Nsy
         8DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881842; x=1746486642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN6X8qy6iIXBeRkDCjdD0w88qJ6dcCiPtrqiszUMgAY=;
        b=O/DmtzR9/MOlcrAqju5rmMcAGbCGk7toFGttVrx4hK9dA6RAYZisgBME8jNfran+yI
         UjGwCxSWsAvKd/cA/XGPjpymQnf8roHXLTTKs64kMl6XnKm468gRkDkhPsaLkNu1VE2/
         KI1fyMVXzTQrlmcw/twDbWE5W+O/4jwTbXKuj0g2brCJZMY6LJ34hg8mOyPWzjLccrc9
         WM4wiUObmoIND0E6EA1l9X7sX4c+QcmstRvUZJNDRQTytBBL1Mm597wVOlMrw3BFt9zc
         BSwpvyvlE2gcIwc+zfZkxzNiuPKsZcG5q4sVbschmHgAf9LKBdA+1xqHqPdSpz5n2g/M
         mTyg==
X-Forwarded-Encrypted: i=1; AJvYcCX7AiVVlDEvxCI+17jDvqyihyz8x2j4lKgY3h7SMtHKlYsdRkyVAOkIv/CBcxFg4vDG8uUmy55liQEAVc5UqsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEdn3MieOf5HT6gLATOE43QCMtV29Ks6h0CZLv5EaWSebwukOV
	jKY97wwV1/rgIsRkEE7YwdZ7IXIcUNuTLc9qSEaZVtbdipQGctNxzMkHH+JouasQ5e0P21vwMOF
	VZ/9CbCwjuUOMLsWAfu7j7atxREufQk8ec1u8QPk+lY6eaWOB
X-Gm-Gg: ASbGnctbFvqJP17H68Ivs1CvOm3QhW7tu9yz1XUUgxLOTiGt0W0WtpE/GQGIkhfK8Xp
	r8KnzeZ1P0HiwkMhGtkHx08N4NQXdMf4vy2HP/KcfjjzrIdIruq4xVa+b088xyzwuq5yI3EWKYk
	nRD196RUDfm4TRaDMN5YgRbzSoVeqnxghU37U7ua2CacnEFDHYj+xLPkp5tmFOBx3M5jSxqlPeh
	IZ5LPX3ymfoSlmDmp63iOfQAF0pyb/C5Tf1+yp6AGgsYhWHpicx4LUKNIgBaIVudFqL6r+QvV3q
	U8IVavA0wcDFnZn2CkddYc0QQ9y2rVs=
X-Google-Smtp-Source: AGHT+IGLl7TOqKFNXF5fmwjy9nOE7m0hNA10OLnBEeDkYFZQHcoN4UwcAMLHuXqjIk6lJT7AmRIwF17PnTRk
X-Received: by 2002:a17:903:2284:b0:216:3d72:1712 with SMTP id d9443c01a7336-22de7024ab6mr13691355ad.48.1745881842017;
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22db4de9303sm12508135ad.45.2025.04.28.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4008734065D;
	Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 35C66E40B9B; Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 28 Apr 2025 17:10:20 -0600
Subject: [PATCH 1/3] selftests: ublk: kublk: build with -Werror iff
 CONFIG_WERROR=y
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-ublk_selftests-v1-1-5795f7b00cda@purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
In-Reply-To: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Compiler warnings can catch bugs at compile time. They can also produce
annoying false positives. Due to this duality, the kernel provides
CONFIG_WERROR so that the developer can choose whether or not they want
compiler warnings to fail the build. Use this same config options to
control whether or not warnings in building kublk fail its build.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec4624a283bce2ebeed80509be6573c1b7a3623d..86474cfe8d03b2df3f8c9bc1a5902701a0f72f58 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
+CONFIG = $(top_srcdir)/include/config/auto.conf
+WERROR = $(if $(shell grep CONFIG_WERROR=y ${CONFIG}),-Werror,)
+CFLAGS += -O3 -Wl,-no-as-needed -Wall ${WERROR} -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh

-- 
2.34.1


