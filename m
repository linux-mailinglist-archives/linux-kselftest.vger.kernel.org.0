Return-Path: <linux-kselftest+bounces-31453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAC0A99ABD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B481B67F5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 21:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D18171A1;
	Wed, 23 Apr 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fR++VZPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFB242D75
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443747; cv=none; b=LOK+npnNH8uuCd8uWVjECPAlT6+PzK8XUUqFsos4BI+B4jaFsBUnCNPuVo1Q7YsvQpVBdFtvJJj75BGfZCK83Wk8gL2kewU16RhVgruIjnXXDTpTlDWrphBuYF/LOHRT3gn1kagS6p4ug4k1Uq4iH41w48y/7IfNDTAhEfBzopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443747; c=relaxed/simple;
	bh=D9ftuTBIipMMMb+INoV/N9oBXuVjGGG57prHPs3PuGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IlQtpkP+PUdQaSa8ufPWw9xAtE1561xzRW1bQPnrW0/S9iJimto0Cji/rsrNGc7DXoVw+n3NhSDd2CKPJWDF+UKTvYaLXrLJQMtlrd2U6uXbnoglgrcVuKw8sNUe1T2nefV86zWhN8Jvh/v/2ak9FnyzOHot/B9WqQCcEiNO+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fR++VZPQ; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-224171d6826so4243175ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745443745; x=1746048545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FfkdId7QoskoICSJ3Xv6KLiuYz8Ht/aFE5W2Si3esE=;
        b=fR++VZPQK2WtODPxiZttcKwzUqpd92FEr/+qEtOTiKZkS6E37yiQMW0q7glp+0nHAF
         NcwA8GlP9r6Zr9YY2yDqRLGHV2TownrkvlRVn1+vGqeteT73s+V0jWZPCz0/tSz9O4wv
         myMYUSkMuE0jnH66Fzn/KVYEa6u5+e0a44rOAiB1P+0ZF02al48O6fv9+FDTHV9qaEMe
         Gi5rQars3hPUd54q/massO9V78dN+26ZRYcwb49p3scAacK8FFcAhHHahhdbi3MrRcZM
         J8ldIFvyxvR9K8G0bd80SqXzXdf6udzKgMUcdtjvxLsjxSpLC916njdiEdS5BX8MIsdW
         JDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443745; x=1746048545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FfkdId7QoskoICSJ3Xv6KLiuYz8Ht/aFE5W2Si3esE=;
        b=e8VmDIQCtjllPIQsx9Z0fuLP+XzUNmtgCCI5L0HcoONpBlaAI5odLzZw8Mb46Zab5n
         9kX00hDIziCs9MXVbLmrtdxdpGETyIfwqT2HKkPNq8baoZM1anO74GiacW6KjaJ/E2T2
         SCpcDWx0insFiHXMwyNvWTYTnlY6/uRdVb6kWP4YcL4G9c/sv9PNiY4zhTce/HVHnX5a
         D1SPGSK6qdu489F37AhIPEpLqjPHUy3XqpBPyABY4jP+1RHUKGjda8kJ8SAF4gf7btDo
         peJBQYpFtSyVcTcCdENl5WBYbT4yDuWrfhtnXGyfaaN2xVhRjm8jQSDhl0GTibsmDXb1
         Wwiw==
X-Forwarded-Encrypted: i=1; AJvYcCXMHxSfxUAp4FIA3KY2YuOyZbpJRWG7R7wruCzQj3dev1w22+4tWOluNXLXaawjn8sFQW7cRUkZd5w/FUskPLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEo00WByPDWYrW2MhCIk3k1g+tmmY9tGVTr/60p5oMbIkRFxw
	dgWZl+PId0D1/7vVOr+jRvwtjdRAUytA2dS8eSoC2aCIEX+m4O5jEG+/GIZssNCKPV05jIgo/Tl
	IzlGoHvsnBmYHF7oUWTEKtzd+TjeAdQATyvKCh3gsur3sri5e
X-Gm-Gg: ASbGncsO5iM6STY/YeySgO9L+V3qBcykC8whth3XzYYp5ie1IT+wkm3VHS4RYDS5mDU
	nDVMPf/MZDgSJLOpgmrmtlFAXdvTP7ph5bWU3je50SHi45En4V8YsbPqiyxZM95jne0DRY3mFy/
	A6oRa+Wufu28qS+T1+pKsU0ZC+VIrFikYbgd34nJK8/uFLc/w1Q0P3bT0ZhFAHc0ea+FJqftfCU
	3QVw6L0QN101w2vMISgiGLBmPUmqts/yewpTz5bzQoCDA5u5/FUlTz2/PzBj6eLWlnLd08HoCCG
	4FyBe4Idr8oQSfapr+YkaS/TXLBwEnQ=
X-Google-Smtp-Source: AGHT+IGAMoZZFngPD9ZZ3v3uIDuQwCl93Fgjflm9tE0fW/Q3qQPIK/rfA5ej5yiEulIgWPS4pv9hVx43DNB+
X-Received: by 2002:a17:902:da8a:b0:224:191d:8a79 with SMTP id d9443c01a7336-22db3c0bf2amr834295ad.27.1745443744799;
        Wed, 23 Apr 2025 14:29:04 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c50d88a78sm6232705ad.100.2025.04.23.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 14:29:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F22C134058D;
	Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E5B66E4031E; Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 23 Apr 2025 15:29:02 -0600
Subject: [PATCH 1/2] selftests: ublk: kublk: build with -Werror
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
In-Reply-To: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Heeding compiler warnings is generally a good idea, and is easy to do
for kublk since there is not much source code. Turn warnings into errors
so that anyone making changes is forced to heed them.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec4624a283bce2ebeed80509be6573c1b7a3623d..57e580253a68bc497b4292d07ab94d21f4feafdd 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -Werror -I $(top_srcdir)
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh

-- 
2.34.1


