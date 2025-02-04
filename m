Return-Path: <linux-kselftest+bounces-25639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4DA26A15
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 03:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5982A3A4883
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 02:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFCC13C82E;
	Tue,  4 Feb 2025 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMESZ9oc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80852200CB;
	Tue,  4 Feb 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636804; cv=none; b=YSkV53nPuwQycVheK6yXkvBKWbLsM+l3XevLiYHlx1iMx+/Bhf4r6iJuAJseDy4cNsAjMZ/Q9m91avh0lukQEW8OJ7d4A6+04FNTB7rdKZ75L93c2oaSMAOf5/GUh5jbbact3JPm+eu6ktKyaYM1TZlC3AUGkEPJxcZzBygMW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636804; c=relaxed/simple;
	bh=0RMKK50ZfAFQ/WWQaMSZcxrDWoAOCnDm86PI3OyC3oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoMnZQV9qPqwpkhE7WCb1y08Xrz/mQqZTYygHi2jkG5xNc3lPTM1b99ksKKv+OQVa3bDscyTsB3xloBi3ptJjyyVwiukSAuHRB4ti/ART5LHsuAlMLvIh0CjXvr8eUgptpkzuDsLciUotwZ8PUCKg4OCWxxCfAdg7d7h7d4RakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMESZ9oc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso6704766a91.1;
        Mon, 03 Feb 2025 18:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738636803; x=1739241603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp8KVioUFfBus+6v/iXWPU8Vu5yTjPj9uqEhgYHMSGw=;
        b=bMESZ9oc+A3BLURbOc7ElFwLcgJvTvEBm6JoD1kwZ/GqLZwghjBW43I/aVS8F0C54R
         +HS0XQStvl/JZ/DAIGbrgsUXlBSqNIqGxRNOSagCu2GIf6CA8MnBzIEG+vD4KweVS92a
         rTUNVwkWsvWG5LitBLZeeBSGVQ63Ps56hVylgecHPGFypdFg2AYeCY8vF4/kD+oXWOed
         YMJUDzRrLILeJjaUrDSYcbuGPWEmo4bNCIqO28Vnf4bvwraCSs5xV8LvQ8iCc739CJin
         I76AE7MaLBTBQVkolfxWaPz80AA98a0Gew+W5fB32YrEvuoUARAVTtxtRVhLJDN+WaqX
         wDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738636803; x=1739241603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp8KVioUFfBus+6v/iXWPU8Vu5yTjPj9uqEhgYHMSGw=;
        b=ul6gJYrWv/ZGwrVhaXcaiA9nv8QxcFCLmBjZypFkrWC29vneGTU/rUyku+kcrmsxyv
         l1qfoTpoVZK7J9G5IvCUuwfclfXr27FdVhV9/V+CgXreB97SvsebvPSpA64jZJhpsWvP
         K/yG4V1SEPZWW+oQMZpR1rTZFvGLZ+fRp46lbOvfSkVzpGnJN0n1wDI+H1nbbHJgXFLr
         oUVmxstbPn4v/62nlM1Clffnf6v7WcSjRDKKRH7pbC/LNNK9gx8Y82co73pvVtXatwtl
         TmM1qIKwRItWu+x3hNg1QtzdcDtka8Yv322IWsEOqNAUvQFuuKY/n4oq2gCj0AeBxGt7
         41Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXEjPPk+yDKNlyhSfYtQAhcXc5CAPUJKsmT8IOMir4EXUnpXLyETxvBDOAQuvnM4WvPT1BKBvjddMczlr3zjms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeI/8KF/RR/qi0cs8LKHim8ov+eQY5skYFQ2CyXtLU58Jn0SOe
	qNxUzwytTMmvLspNbn2nNfg5+yXTdzMWCXN5yZ3DcpVYmU4NgTaV
X-Gm-Gg: ASbGnctcemWiixRoVkxrFo24q98QytezGbZisTLjpdVbhRjpVopepBKW6taYfI9ZgmU
	hR/ZPkHQvSEUZO3lF8hmuFurmIPqWQWSdrRmfqODSLbdAsIIUNsa0b+5mE7LJFYLndCEuYxiyPs
	zVoiHGcTEbtp98s8t14rBATe3vCAw0o99FM8o7gYhhghkM+2AkFX5gGmqAfRAsImA+ivb4GH3W9
	f3xrygS5yTbx0zK8MIWDvKsPfNgESlBRr+iPXHvVZ44CwIU3W49ySO4e4/3WE4l+SuZX/fex8wg
	bQSOT4t5ZbjBAIm2Z7s492hAxFtfa3Y4y3ljS5piq4qogWBcIoiRDQ==
X-Google-Smtp-Source: AGHT+IFL3FpLvn4dIqVj7c7A8JrOFnw3sDyfgAzebPHiuA27JiS5ecKUMmpwZcR0etyCTsCiSe9NXA==
X-Received: by 2002:a05:6a00:4f8c:b0:728:927b:7de2 with SMTP id d2e1a72fcca58-72fd0be829amr39890183b3a.8.1738636802815;
        Mon, 03 Feb 2025 18:40:02 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba44fsm9660492b3a.100.2025.02.03.18.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 18:40:02 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v1 2/2] bpf: sockopt_sk: fix 'undeclared' definition error
Date: Tue,  4 Feb 2025 10:39:46 +0800
Message-Id: <20250204023946.16031-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204023946.16031-1-kerneljasonxing@gmail.com>
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Error messages:
selftests/bpf/prog_tests/sockopt_sk.c: In function ‘getsetsockopt’:
selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field ‘zc’ has incomplete type
   struct tcp_zerocopy_receive zc;
                               ^~
selftests/bpf/prog_tests/sockopt_sk.c:169:32: error: ‘TCP_ZEROCOPY_RECEIVE’ undeclared (first use in this function)
  err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
                                ^~~~~~~~~~~~~~~~~~~~

Fix it by introducing the right header.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index ba6b3ec1156a..e0a9785ffcdc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 
-#include <netinet/tcp.h>
+#include <uapi/linux/tcp.h>
 #include <linux/netlink.h>
 #include "sockopt_sk.skel.h"
 
-- 
2.43.5


