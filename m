Return-Path: <linux-kselftest+bounces-40425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F42B3DF54
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 12:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C338617DB10
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582130E0F2;
	Mon,  1 Sep 2025 10:00:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171D30E0CD;
	Mon,  1 Sep 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720817; cv=none; b=pYZAhRaAApMTnBsdoNIo8t6qH86oUTXapxiCWsP0WALX5jxvIzagx1+xtRKXDXJZNNJccTzMAFW7HeDHkLcYU9vq+vqbLzh62odxDVbHUohK/TwWDDh30A3fyf7Owd1/AjnsEBSBV6pBtAvEpukQqnMyR/7reZmMhe9X3Tyx7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720817; c=relaxed/simple;
	bh=P/JVwImAg3rknmA43fZKRJJzgeXKTjzaEOvBzX3L6b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ACOfI5PWdcxBGAeUi/ptFjSFM8LR227hHjpTFRP+1JvAYIr/SLkEE+gdxIo9mjVSne2lZhBzdYCBDkqiNLa38QVRbhGcO7TnGgyHEPwR1yuRLQooe+3oPWdzRynnfJB1aDCOdveJzr2ecui3A/rE9WpmVoVyq+7XHPUNbq5HbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b042cc3962aso95122666b.0;
        Mon, 01 Sep 2025 03:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720814; x=1757325614;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4jaRQ4J1GpqCMPkuC4jvgP35vlduV9nhY9opiQ++ec=;
        b=SbRC36BN4ANnkqDla5Y/T7RcM5A/0rFJ5YrcTriFduCTB4Jzctjnd5JMhIrZOZRZw/
         k6IJSNUIcXqLUWO2swc8YgB+TQIu96kerMXfKFE5RyKkudN2iMeWZ3DYdpzFhh6dlYJB
         8wMN0Sy2y/xpCZNUHRM11Yf6O+E5khDjuddyMqrtiBoy4pazrvLSVqLpNxSiz+iwQ82E
         JgBT2pTUeJM31+xvD4fPnIFqrG7HGenDzH7UvJ0O0VAoYi5tsdLfeFKIjnMCnQcev8Dq
         1uRVTHZeKJLqPXXb7qhw4VG+cRPhKbNBotPPu/cnQ8ljlWFZ8scjCj/qu9slE+J8nlsQ
         ByqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnX6rj9QCU+vcc/Y2VtVkvHTIGz7f/Xl7oigXcJiHXi6YicBY2b0YXbtVuRpZ87kWx+Ryro2h+gODKFNU=@vger.kernel.org, AJvYcCW+Qgl813wEPbsIPf6q7wOed12m+8TXHuW+Oqu9vR1T210UH8Us7OyuN2rZcH0vsAa0teshtAckGq5w6h4jQ1ZB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5douh7Ld0LZo/zx15phmKUZErFrzvY47BLNSJEva5gXyeVCb
	qR7eOcm8fvxX9oPUkoO6oDEJHjnFdL0bIr7RUH3omhNyvIe5i8B8Gxya
X-Gm-Gg: ASbGnctub0scHKHfWeLAF6ZoYpfNIeNKHGe0Y4Q96Z/yBOKPrvHVNF55M/hyuJ6jcgf
	gAHci4vH980sUMlljNFo3JT8jFTCkAYNLDLCaO30Fj/71RSTGpUwSBAZTRVa/+beHUfJdNkDUsv
	1aEm9K9bSuzkyByEzxxK91Df5veGFCoB8TYSUjk9ni84ILA8ry0IfqwCNS2WYfG5ILdTXbUGawy
	v51fUFi4rISyKrRbTtuaNc7J6rRUMldNGVk9R14YmKJrj52yezQ/bszhJKEpnkA7dFpkUMLAGu3
	MBGqEQU4dbop3VzZ/agB7qBEcvhR8MjKY9TfuzPHe4TbCFFMM4H6X/zmQQ8Pug3cVsyLguAYTsD
	lpdYOaAiXAy7Mj7yNSsPdK96I
X-Google-Smtp-Source: AGHT+IGzhXmOe0KW4Kr57L2wUjIiYHBEUhDgHv+B9T9LnXSnAHm89DlLi7K+6kTECQcJUDvxK9ddsQ==
X-Received: by 2002:a17:907:94cc:b0:af9:2e2a:64a8 with SMTP id a640c23a62f3a-b01d8c90436mr664548966b.25.1756720813295;
        Mon, 01 Sep 2025 03:00:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff032125e2sm784261766b.77.2025.09.01.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:00:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 01 Sep 2025 03:00:07 -0700
Subject: [PATCH net-next] net: selftests: clean up
 tools/testing/selftests/net/lib/py/utils.py
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-fix-v1-1-df0abb67481e@debian.org>
X-B4-Tracking: v=1; b=H4sIAKZutWgC/x3MTQqAIBAG0KsM3zphlAryKtGin6lmY6ESQnj3o
 HeA9yJJVEnw9CLKo0mvAE+2IaznHA4xusETHLuOB7Zm12LYyeJ6a1tuGQ3hjrJr+ZcRQbIJUjK
 mWj9aspu0XwAAAA==
X-Change-ID: 20250901-fix-02eb26114040
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=leitao@debian.org;
 h=from:subject:message-id; bh=P/JVwImAg3rknmA43fZKRJJzgeXKTjzaEOvBzX3L6b0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotW6rdJP8XHejS+7EjXOH8OhS2VidXRXWoynGn
 cnfz7DYMNiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLVuqwAKCRA1o5Of/Hh3
 bZP+EACcjpSX6bt8xbBzRQxFzBAEcOVYP/HgFEgdBYfFFUZRYm0z20DEPsjH4EN751aJcR7mSVY
 iXAcvco8l62ZHLGQP4TYu7yBROp/fI6ddP2nxVVtko2WEty7V9xBWNhqEZLJ7X3nO/hWupQXsjt
 5UzIKF4o+4uZmlpl70NZWxjo+GjdJQ23ww12MVCLvsCwkyZr1jvlXUEl+YCUCf8N47hYnUtu+Hy
 I2kVXdRp+GJUsAyLI02D4saq95CufG6+H0qyJuvSFj1tHR/T5LC7u/jPHVhth3RcvGwJd8TMSfh
 KbY0e9NBVCGtF3BLI+WAuhJ1gUUUzRxvjb5AzwAF7syO75z4kamSWH3jnFZxsqJVKWXEUCtmb/t
 BAIsVhld3EkBLDWWrtwAGhDhG9Xn4ZjI+uwq4Qxc/WJgl3/MKEdM/iYu/vELtA7IkguPWWi4a5B
 IIlJoQhai1MFhKfn9N85hw9Kk9bbp/8SECKJHhqb5FAD95eZi9jOdU/jBV0qTQfzoXvNNV/ulXD
 srmLdquIouEH5b4blGNPr0UucGTJ1UiVN/zGSy8VFn654B12KMq2TCFXNMEowTYsSwWf8jz8W0g
 mfKoQBH96EzKI4G5kPMyr4tEht9PVTB2jvM8OLRKnZ8K1KZVaWteVxpo05i63Ba9rEr6GF0GX+o
 F9lJJMTrZeP5nfA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch improves the utils.py module by removing unused imports
(errno, random), simplifying the fd_read_timeout() function by
eliminating unnecessary else clause, and cleaning up code style in the
defer class constructor.

Additionally, it renames the parameter in rand_port() from 'type' to
'stype' to avoid shadowing the built-in Python name 'type', improving
code clarity and preventing potential issues.

These changes enhance code readability and maintainability without
affecting functionality.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index b188cac49738f..1cdc8e6d6b603 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -1,9 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
-import errno
 import json as _json
 import os
-import random
 import re
 import select
 import socket
@@ -21,8 +19,7 @@ def fd_read_timeout(fd, timeout):
     rlist, _, _ = select.select([fd], [], [], timeout)
     if rlist:
         return os.read(fd, 1024)
-    else:
-        raise TimeoutError("Timeout waiting for fd read")
+    raise TimeoutError("Timeout waiting for fd read")
 
 
 class cmd:
@@ -138,8 +135,6 @@ global_defer_queue = []
 
 class defer:
     def __init__(self, func, *args, **kwargs):
-        global global_defer_queue
-
         if not callable(func):
             raise Exception("defer created with un-callable object, did you call the function instead of passing its name?")
 
@@ -227,11 +222,11 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
     return cmd_obj
 
 
-def rand_port(type=socket.SOCK_STREAM):
+def rand_port(stype=socket.SOCK_STREAM):
     """
     Get a random unprivileged port.
     """
-    with socket.socket(socket.AF_INET6, type) as s:
+    with socket.socket(socket.AF_INET6, stype) as s:
         s.bind(("", 0))
         return s.getsockname()[1]
 

---
base-commit: 864ecc4a6dade82d3f70eab43dad0e277aa6fc78
change-id: 20250901-fix-02eb26114040

Best regards,
--  
Breno Leitao <leitao@debian.org>


