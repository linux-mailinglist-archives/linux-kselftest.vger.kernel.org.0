Return-Path: <linux-kselftest+bounces-3474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCC83B0E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708CB1C22834
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206BD12AAD0;
	Wed, 24 Jan 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ceXq5Jv5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3220129A83
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120410; cv=none; b=rhfFCxQ9BfvsZJmZv/aiyCuDWlqg2SCBfrHrVhVZ2cUDjwUHihDpnyoTdOmHVh4CO8ymmpOgnjRELWST73XjU8eXZf9WhJT4n2SgXkxoqZEUm3Aje7GkoYQdJjMH4qktw1y4QJQv2v0IbgrjoIUbCiRHBJsdS1SLgfVSNrFSHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120410; c=relaxed/simple;
	bh=RYKAneGKj5rW3ZSaKMHN+jkOKYrCveP/BkhXpCVNQZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uIrsCvLhaleRtHw28kxxRrVCjZVfv/D6hakfic0o8TTYieU5oOBiSi4Pkg0FKfACE6wemnDV34EU4pc+RyL8i/qYSEDNM6uQXvSqIFlKLTjnuJqN22YW4Cmb6zd796UTTJh5b/QeP5B0gwfpLm/43DTqd5oDcuVXLIklgfqO2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ceXq5Jv5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so28073605ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120408; x=1706725208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcgbFDhBYDnDG7e+EicrCnnoYD+QkO9W9lsCV1iSmek=;
        b=ceXq5Jv5MzRHqE1C3NvD/5RICRqGnmdGvMduYyW11TMBUtZQa0G7Jqc2G1t4n+f5Kb
         toR7hETMB65j60p0lQFaAGHqM4w7Wypicd1Qaf6FWGnTXgoJIYt0ddbpMUd54CVeiq+0
         FcXGsCoVtg2OUcQivrzrkwuD0f701x3zW/aGpoQgDGOwxcc11zI1tC9n2FrszVTkyah1
         g6N+R1rlBVNGpli3EIrzPBFhRXckScRWP9Bd22P44i1nCV6etkCs9+hDLlCZeXAFfQrh
         gv/YnOCLSNmuO0QSdwj5BMiJtFFEBxPSJk1I1JpNOnk9YBGj+s+8dkmCPzqWk+BKwvt7
         8XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120408; x=1706725208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcgbFDhBYDnDG7e+EicrCnnoYD+QkO9W9lsCV1iSmek=;
        b=pRsTdFH/SwJwOI/pMRnEySeHJYUtbSynJzruBqA7OVhHu23LbszEjR067oVWxaNcLY
         eTsfJH09+xZ9R2iOjNiPolwrIZDkcoB31Zbkhir6OHUKhQS+z6RKgV0J/NqHgn4ggpJm
         C1JcEr+1273v5TX1bYZ/Ua/VVgleJNbUjqy7zil6cYILufj3PXwETa2DxqZe7fK7cuXf
         22h1uBx+qUYOJI3kZynBB1t0w9jUvtawzXvO4qlrj+GJ1lMw8uRbCzqIoCiz69ntVhQT
         uRYvKBqeKI8ERf9N8wC9QY7vQQXu5qEasqNh60gxc7kI/8DzA/Tpk3mW0cG8VvksY751
         7X8A==
X-Gm-Message-State: AOJu0Yx2iuuc9BIiVGj9sR/my9zc3kIfq6ToiWLkDtKIKiOz70RM5F03
	DuGiz29AlGzcA4qA9F66MnZGjHpoFAxXR4R19hwFhJcOM34V+TzSXbPmb+zS6w==
X-Google-Smtp-Source: AGHT+IE8CTP0k1buCWYsLl3oLDOecT3xHXO3leWrGiFV8Ppz71BOfI+ZUTkdNi12sgo3JEFHFPL0eA==
X-Received: by 2002:a17:902:700a:b0:1d4:cd41:e44b with SMTP id y10-20020a170902700a00b001d4cd41e44bmr1187925plk.124.1706120408032;
        Wed, 24 Jan 2024 10:20:08 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:20:07 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 5/5] selftests: tc-testing: return fail if a test fails in setup/teardown
Date: Wed, 24 Jan 2024 15:19:33 -0300
Message-Id: <20240124181933.75724-6-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
References: <20240124181933.75724-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today tests throwing exceptions in setup/teardown phase are
treated as skipped but they should really be failures.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index caeacc691587..ee349187636f 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -541,7 +541,7 @@ def test_runner(pm, args, filtered_tests):
             message = pmtf.message
             output = pmtf.output
             res = TestResult(tidx['id'], tidx['name'])
-            res.set_result(ResultState.skip)
+            res.set_result(ResultState.fail)
             res.set_errormsg(pmtf.message)
             res.set_failmsg(pmtf.output)
             tsr.add_resultdata(res)
-- 
2.40.1


