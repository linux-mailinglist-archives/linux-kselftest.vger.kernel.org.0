Return-Path: <linux-kselftest+bounces-35773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CC0AE81A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CCE16D60D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0925DAE7;
	Wed, 25 Jun 2025 11:40:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A0282E1;
	Wed, 25 Jun 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851601; cv=none; b=pxsrnPVhNX0SNtJ3NJNAA8CsxV/tw4mp5vwl/5VU+Yck2NfsQ9qUJTdtbFOeHlFx8TpK1MFOahATVVn0Sg03DewDTrOBeHAPkuD1Pvf6P4hL7s9YIsNBq13TUHymwGn7+e6Cy6f9ji9I1jvxebt+6WOtlVdK7aJt9LbaioNPOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851601; c=relaxed/simple;
	bh=W1EexkswfPcZNr3iUS31AuS5Kgo2ZSIFjOO3bhsqMzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7lKYP/aZTAnaTbXLJLoS2ws6Pkg6SGkeiR4DBPxdFn4fIDX9ie90hDAGhR86JPyGRVbE6JUffxfpPkYzYu7vIKIjwlexUrbwktgMVyLnUqNJuzn3/9xD9wElsRuW2c5VfAnIhCgze0G+TJEgu2RdQfxHnlxQ62gbTUIYO0nxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso10896571a12.3;
        Wed, 25 Jun 2025 04:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750851598; x=1751456398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePm0T0zc663ZbGV340DcndG+7KFVs4xq2cA81VLyDoA=;
        b=W1M0Ll05G65NQRnPtpyVYG7bvne+Nb8qcaBY5xwRzJuXBn9JYspEdTADYdz9otNB98
         /tK6sqWt6cjQjtamRuITs5XEKwnC3V2DuzDkRtW5fRFJ/Wyk6FrGwTqWLXx7OULB34c8
         IBg3C+k9V0SHpnGrEXZCn8rqxC/Zez0LtO1GUs3vYraf1ar5ocTrja25Z8nNnMTONgZA
         cQekGoCufmLaH9HV7DyB9oGJ7sv4ZVwL8xWFAHtf7k6URRBgXgMGWmptgpIm4Ig2aEhm
         lFbZ6Rm0jBf+7c2Hn5m/aYh/sS7o0umLIlcq9i4JJC+w+UjGkLMO2/pC70G8/t9JOC8/
         T1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNhhw0xcQY4tiiXJplnJu5e5FIMHpz2R7ZgoBO1Aym9ZFRRF75yrMtMgjCMY6jOusCrTRmIJ5qMuC5O5txy9Ie@vger.kernel.org, AJvYcCWG8a75F76W34W1f2kTlcQaiMHJJbwMI5hDZCeX6i5fpjhIi8ORP3m+JNNwMg/oLYtR7NP5+liU@vger.kernel.org, AJvYcCX44QYxPT0NzFtvz45lP2fVEEuZWcyues70sQnON0uFiFwt40VxMN+hjJXDhJ5o7uqjwNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TkMub5JtliSjoC3ByB37UqhMhiaaGKFwh8b35Byn7osER/zZ
	kPGsX8s+p0O5mzT/HKi591bW9TzaJ/4PuyMgVxWWkKYJOm5hrIRoWFVI3wYXoGIc
X-Gm-Gg: ASbGncuhfCfpCkbhzOS440KSByiQSfDqI16ciaHybKR3qiun5fHRenfbQp3Yr3dgtTi
	xAbJRz0CpJqrLE4S166OrQjhWyt8548Q8vuZ9HOHnCWs1u4yUrGzRRX22mdgH03lFnIbJPaMxYP
	4LBBAgNf2cyFs2spY6gLgBN5yzP9HqNxm5S6lY5moncIuDdCsXId5t1dkrhNIJdj2kjadPDCsU3
	oZoGotwcQO2KAWHc5CkJeM9HL2wEMWJynKha4M4//DAWYUz0KUxrNe2AbaDhTU2ZBz5z3YEibzA
	QX/KsfcE8ywaxWqlF3BejXy+v1+L9Fu1z0+Csrx+9GPAhHEN9MKs
X-Google-Smtp-Source: AGHT+IG2xM6ZRiOvuC+JX5cT+LVYS5zYJbG8CqIQXBQAYe1GC+M1/IFtpm8JgzlLbYyeTrhFQyM/KA==
X-Received: by 2002:a05:6402:26d1:b0:60b:fb2c:b7b3 with SMTP id 4fb4d7f45d1cf-60c4d21597cmr1904705a12.0.1750851597930;
        Wed, 25 Jun 2025 04:39:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4683cesm2413673a12.37.2025.06.25.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:39:57 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 25 Jun 2025 04:39:46 -0700
Subject: [PATCH net-next v2 1/4] selftests: drv-net: add helper/wrapper for
 bpftrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-netpoll_test-v2-1-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
In-Reply-To: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 gustavold@gmail.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232; i=leitao@debian.org;
 h=from:subject:message-id; bh=I+lAo+Qac5MqwIlBjg9aGwL745T5u3BmIKWuOzlXpBI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoW+AKljp+1xHgL9H3RniDgez8LxrtISQB1ECzf
 Zd3UTWObvaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFvgCgAKCRA1o5Of/Hh3
 belmD/4o2CfKPSLtgU1BvN0QtjpwO+kigo2dbR5hS60Bz5AI1LTwuIQs4lIBL2s5EZJpAiln6vL
 2J5kZFFs2UxgdZ8UtUYdN5ftR1e0AFDc87QthmyHMgE0JiGWH+fUJqIxoVFuyK1qswfeXI4mtq1
 AXg9H4jS3FsTOZJ3NG+QKFiBXgDVm8AhlCVn5iUjBDvK7bypaTUONOAgDh1ECnN555EInVZWirC
 9HN5PTjG2GQMteA+0RgeMSyhWKo/AwA7Pymc9TfFOOKfKaChs/hhlETm/ORJRzA3GKNss0Hi3Ax
 xyxUVyvPtJvGy6jA38rd2/VK3RGZ2oKAzqOs/cIcOlp26xlVmxomKfAh6daBI5NZ14hwuYD4Gm1
 h8SWVWWZ18BVPLv260BKi2BrquTT0X2CKH53GDjhwNlgn6+cpKN25zHCFATdGEu+VkOLbcsL/Oo
 krZdgzfrRhheXh2OFxS4OegXlCL0SEHXNOlhOYfuMF8+f/5r/EnbMs75pH4c0ilZOkqpdIpoR8X
 4JScaEgvSkzeLhiEdt4PXfD5HJ0vquQ8r+XPTiNiWokyI9xBKgAqY5F5Q+5HQgyIhvq+FXbv2N2
 g+xAN4xLjjDfrR9X2C4lFTmzEawkl4/LQN8DJIepSMKQWO0zz8353hczMo62GkxeExgVXqHz5IZ
 eqdPl4mYoM+Pu0Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

From: Jakub Kicinski <kuba@kernel.org>

bpftrace is very useful for low level driver testing. perf or trace-cmd
would also do for collecting data from tracepoints, but they require
much more post-processing.

Add a wrapper for running bpftrace and sanitizing its output.
bpftrace has JSON output, which is great, but it prints loose objects
and in a slightly inconvenient format. We have to read the objects
line by line, and while at it return them indexed by the map name.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 34470d65d871a..760ccf6fccccc 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -185,6 +185,39 @@ def ethtool(args, json=None, ns=None, host=None):
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
 
+def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
+    """
+    Run bpftrace and return map data (if json=True).
+    The output of bpftrace is inconvenient, so the helper converts
+    to a dict indexed by map name, e.g.:
+     {
+       "@":     { ... },
+       "@map2": { ... },
+     }
+    """
+    cmd_arr = ['bpftrace']
+    # Throw in --quiet if json, otherwise the output has two objects
+    if json:
+        cmd_arr += ['-f', 'json', '-q']
+    if timeout:
+        expr += ' interval:s:' + str(timeout) + ' { exit(); }'
+    cmd_arr += ['-e', expr]
+    cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
+    if json:
+        # bpftrace prints objects as lines
+        ret = {}
+        for l in cmd_obj.stdout.split('\n'):
+            if not l.strip():
+                continue
+            one = _json.loads(l)
+            if one.get('type') != 'map':
+                continue
+            for k, v in one["data"].items():
+                ret[k] = v
+        return ret
+    return cmd_obj
+
+
 def rand_port(type=socket.SOCK_STREAM):
     """
     Get a random unprivileged port.

-- 
2.47.1


