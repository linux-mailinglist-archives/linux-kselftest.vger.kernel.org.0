Return-Path: <linux-kselftest+bounces-3408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2838E838E7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 13:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8BF1F25108
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2585DF34;
	Tue, 23 Jan 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kmNr51nV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191555DF2E
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012893; cv=none; b=PMNVODo4/2/4zNe134A+B3fAAd9e0ZVDAGEyf3z01l/vPqa3iCxoAWkzMGUB2jxQSIptyCCHTmyrxcAY58r5CTgVioLwYuA0tA8KpAAnSEGsC+UlfrvdQNvE/5I1zP29DQTH00ERgu3w5bPOtqgyBYXQlsn7WTIJk0PieIBuN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012893; c=relaxed/simple;
	bh=ewKXOUbu1Pyuh9x+cdnLLtObcxSdtkqTBHdNo9HRO8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UmSyNVQCCaGALxIhV9aQj9xZmw8izs8QcpOnJeP4ap9TzV3+EFBcFX+JTTrPblQ0wQz8anPYzdU8myrUPX7iGOl9MNyc1iUQkhP7RrYWSGv5tEL9+8OzQZbeKzugfJFplHS2IHaaU9MmYmRH7FRE1KxWCdGpOdRFWA7PHSLbXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=kmNr51nV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d720c7fc04so22316775ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 04:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706012891; x=1706617691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk3nWSvAIa1Zh4Z+2SFhPhPRTodwriGnEQi3EvZJ3+I=;
        b=kmNr51nVnyt3KTuxV/aCf52I+nBG0gUd1jpIMdDdiXJqdTNiZu/SPYErQMN0NmPvU6
         J5e5CqRwftdA+aqnFCIpsWNmdZR5L8APSu5HQHQ8Skj68BmoA99zxs3hgfdoc8N7CPys
         amHj5E2J9/SpP3ywPMmwfCY8yDgGjyJ4Qfu6nUsFdgFm09Wn6zb1PMwF4EGDh0JGYXt/
         nzFca9Ov1zypBFZofOokVHXxZKMB6Rdk/eg5QybNHDlAv+lCQtdCgm1rYRm85PUcjBDx
         0VbhOdxbnN4vLEbpG9XDhBuoJA/8q9pDZ+ApN20TWdzq6euitS8iAfZBOsjXMzgDFifJ
         X6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012891; x=1706617691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk3nWSvAIa1Zh4Z+2SFhPhPRTodwriGnEQi3EvZJ3+I=;
        b=fbxCWTTeRvS9qmzH2ZsbM9OeO6m2TWuq1viD60eVKfXDjZdRWWEa/9Cg2OlfM4Ym35
         SQkJNixrv8cvu1i/acP/zEgS8iv28IN5blvCJtmXaY7xU+7OPcCbmSkV2BGA1Eb/uJbx
         aEaZLjrDMLUT4r6brUcxapY6nISVgIe7DIVdDc/15+N8nsRElaulM9qXJQgEcdhgTyM1
         zzKp6IiR4bgPvUdnetZRzHF1wsFMF1sJd0nFsFpSmf1Q0AIqXwN1m/aYiVutZGGXDR/y
         R2HPMxeRxfB2EEDW1MZ1MOrg2Xr7RbVhvsUIt3FbtIJ3oyBXjhslKsz5Ui86SIVh2rWz
         xkFw==
X-Gm-Message-State: AOJu0YzPu6nzJMYq+eXGWSJYMV95DH2vWgYFwRi5cjq7hMq0Q/T7faZ3
	O/8Bne++JeKM9G5IarxB4XAzhKKRki7LQtT71xzWxsf6fptFsua53UF/Wlc2Tw==
X-Google-Smtp-Source: AGHT+IFQWONi4JPN7dRHb1W2osyizSbrUOCTFhj4HxwmfjMclQs2bHn9GEHTimAzwcAFrjBjgInkzw==
X-Received: by 2002:a17:902:bd86:b0:1d7:4d7:a64b with SMTP id q6-20020a170902bd8600b001d704d7a64bmr3082732pls.121.1706012891477;
        Tue, 23 Jan 2024 04:28:11 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm8867643plb.14.2024.01.23.04.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:28:11 -0800 (PST)
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
Subject: [PATCH net-next 3/4] selftests: tc-testing: adjust fq test to latest iproute2
Date: Tue, 23 Jan 2024 09:27:35 -0300
Message-Id: <20240123122736.9915-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123122736.9915-1-pctammela@mojatatu.com>
References: <20240123122736.9915-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust the fq verify regex to the latest iproute2

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
index be293e7c6d18..3a537b2ec4c9 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json
@@ -77,7 +77,7 @@
         "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root fq quantum 9000",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $DUMMY",
-        "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p buckets.*orphan_mask 1023 quantum 9000b",
+        "matchPattern": "qdisc fq 1: root refcnt [0-9]+ limit 10000p flow_limit 100p.*quantum 9000b",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
-- 
2.40.1


