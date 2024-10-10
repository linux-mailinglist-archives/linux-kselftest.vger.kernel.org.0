Return-Path: <linux-kselftest+bounces-19471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA550999182
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 21:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C1B2BACB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7CD19DFAB;
	Thu, 10 Oct 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOCzRF00"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B71925B6;
	Thu, 10 Oct 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585048; cv=none; b=YmLs1TnGBi4JF1wwWTRxmdPcIk4Xv90FxUDp8gr2EpFfQRHywIBz/LIt3uW0/Pc4cKBeKVQnIiRWwZmFkI7PBSgF82enYhu4jzbM9su+1LR42aLP2HjvDycWVng/s8HJ4tpkfKABjcIU0MdXenTo7AlyfqyWPeCnCK8p7t9DepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585048; c=relaxed/simple;
	bh=U35Ed39uySs5Ay/D+ry/OiGt9L11pyTTQg/W7ZJ915Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6YjnDWnwSH4ejWrNm/5oWzuew/X/8fJ2SmkrdJ6IcYvid5hk481oaQuYLUz5qL5IKGuH9NT4Wu2qLJuXRxLIT7TTYsWM42XBKfnMX4571oMu+ecmKoahE4S9FstNQPb2SPdFrVq9LL6x7dmKB6TnixxmMJxKQMtvcvo0ZKVJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOCzRF00; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c924667851so1482023a12.3;
        Thu, 10 Oct 2024 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728585045; x=1729189845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4OWZNZ6ezca0xZ8RzRw1VcCa//Gr4m7GybML0zzMoM=;
        b=hOCzRF00Mu/8vB93UzwMq5iY+4XTGjzuAjP3eNDJ3vHDs9pJcJ0oiDEwAUoiXLIcR4
         qua2vofbc0Ofx7OTIphZYXv6P8VS/Ct9UYpYFN7JLRXt6hx7ruhRHZkU0VR0BQvOt//M
         qyg5etraWHOCHaejT79i3MpdjpV46zimrfC1abkN0wQmIGe2hGJJ5mA+c9a9krfv78zR
         LrMv/4DNJiWk2Nnsl8llrmQ7x9IF/WudfOmNp3MEkKZpQQ3g6sVkD3FtwVvJdvYYyO7J
         TNXP06CadfBiyhjeMY5uOj8y51XxJxZ57agmu9eGByVv3dT+gUXQyiQ3zmEVRDOlYelm
         glBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728585045; x=1729189845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4OWZNZ6ezca0xZ8RzRw1VcCa//Gr4m7GybML0zzMoM=;
        b=Ki5i9bh6HmLFbxgs7Ys2gAXlOLbKgRGTpA9pbKceNCUi+tK1MP5s46uN2R+ptlCeGo
         dutGOxsTPhj0ynQmvyCsnG7lAR5hApjBXFpjmPGhKsrr1oVQ1K07klbOG0RzOgq97b9t
         V9kZcfHdMebArdg2mHiJCZCNUGccwghooErdDiL5WHglZtfxfO8Ln6a2mCpt6v17y9Al
         wxgQOZ00/Aj7uf/0ANX8BlbYm347NsNjdlvvjjGgu/ty8ckjOTHw36oVTYl/ZANvHPiv
         0UaVWa09n/NZ+PJZbq4Vn07PlMq2K0P9TyJUFrF2/d8J6DyZFDY6Am2GlQIMTmPGG9GR
         jogQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEUyITN6g88Q+XIDBmBg6mfDoOSLl7VQDNLtnk+g1ftOSfvo2F1vaI4pEXkw+zgVsCkMxNNOAe@vger.kernel.org, AJvYcCUxDZaf0dR+2byrPCxXopPpus6/0Pz6iNMsZJ8jiYku8BeXQMMe7wraSNqb8pbWLVkflyN4NHHUp8SR/aQbIE6s@vger.kernel.org, AJvYcCWHmGxCn0C/C9yg1FiWs7sqtR5XEX1hmlZH7hdsv2ADqiUQyzOvcE/6gA+1c/RLtmLqnkaBENWwEr05yWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvTyTJ96uQl++pBzDGlHZBnPnkwh34w5W6WAo0sWojJGbyLuu
	PoT4cmk4EydJcusCLTaSEi1OAtHQn7zTkCTfsSyq2CmH75DJfCM5
X-Google-Smtp-Source: AGHT+IFlSj6BcSmvy6Hw8SYlc0BkX7Rm6wrwcfr5jDlDOSvnT6ub96GIUebbkdBEKvuXODPwBUy2Rw==
X-Received: by 2002:a17:906:d555:b0:a99:5234:c56c with SMTP id a640c23a62f3a-a999e6e5d73mr471305366b.33.1728585044545;
        Thu, 10 Oct 2024 11:30:44 -0700 (PDT)
Received: from alessandro-pc.station (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80efe57sm123871066b.188.2024.10.10.11.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:30:44 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	sdf@fomichev.me,
	martin.lau@kernel.org,
	dw@davidwei.uk
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH v2] selftests: drivers: net: fix name not defined
Date: Thu, 10 Oct 2024 20:30:30 +0200
Message-ID: <20241010183034.24739-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves this error, when calling kselftest with targets
"drivers/net":

File "tools/testing/selftests/net/lib/py/nsim.py", line 64, in __init__
  if e.errno == errno.ENOSPC:
NameError: name 'errno' is not defined

The error was found by running tests manually with the command:
make kselftest TARGETS="drivers/net"

The module errno makes available standard error system symbols.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: added how to run the test

 tools/testing/selftests/net/lib/py/nsim.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
index f571a8b3139b..1a8cbe9acc48 100644
--- a/tools/testing/selftests/net/lib/py/nsim.py
+++ b/tools/testing/selftests/net/lib/py/nsim.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import errno
 import json
 import os
 import random
-- 
2.43.0


