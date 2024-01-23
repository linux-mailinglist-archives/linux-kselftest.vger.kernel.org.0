Return-Path: <linux-kselftest+bounces-3407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46D838E7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D803B22CFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36F5DF1D;
	Tue, 23 Jan 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HZ1upIbq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA25DF36
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012889; cv=none; b=gX7D7yJVpdtdTk0m4QQmxtIIHpPOpUr4S9o6d2RBr1xrrojZbr/uET/BrrayntkjetdqsmSCsCbrNRUhzcoNq9/qk/1P4VV5wHfjHLffRsd3dIACQUjVV6epl9GC35zGjv8NamLHaw+WR83iuCn1aVeMeuaggjPZnsgKMXC/dYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012889; c=relaxed/simple;
	bh=mNJfhFrzCnirpLXJ5iI3TEJymxjQIJ/DWffLWkrOsl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APISMWyEPI1s1TEObNzMvFu4DEzgwuLIn1msCz8IwOQIoj0WLKyFqCmDXn65A+X2W72u4WWR14TZaXTJlCIY8YSVPV5U+FcopQSH4DgGIAmOSbmNknSRqgr075IUJuRQl/915QFJU0mLqX7E/D+roP8DQIKyVTMYqZyB4OjiE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HZ1upIbq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d72f71f222so12881655ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 04:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706012888; x=1706617688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWNyc2ZrRFbLhMvmi6sT5LZ78Db+KMqOAgITyuzVG8A=;
        b=HZ1upIbqWEtD+rYAI6hR9EAj3nnLU3l/TVmFESEpfSubrSkuPVP5d45q8HjJW3sOS3
         E1VUuo8lA6r3qIQi5vMYYfJvvdHq/oMNH2fDk2TaTlNdmeUfApuZVJn2icx1QEkX5ePL
         9KU7jN5oshZKVPsBfuXIZSWHJfMBoBDtS2qu0EDPC4BOCRMLjoUcNGWsw/UTUjqsvg3k
         Gwqtw4au+kvhZvqAd0opTwn8TKMR/+A4li+zfPDBAm2YeeiBBUGNXlCTOtOJSR8nYQBE
         ddpG1U8h0BEf1iIyJTp2U0hZilEdNqytJlE7NPXRch16NXtnE5lbm+iDwRtZuIrouDi+
         MsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012888; x=1706617688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWNyc2ZrRFbLhMvmi6sT5LZ78Db+KMqOAgITyuzVG8A=;
        b=Nka5AYxd+oVadXxluFno2X7I2fYx4ojoAhQJaCGumJabxS9OYN8N7SgKj/0hEoMjkq
         djC8N8HeOwQpQlNX2io4+Itol2Bd2/0pKqPv3rknFGVaE45uGZaAB1nCV05wZUekInCk
         21e8IFh+shR2fZWkBeII/P1L0RngwH9IVivLXrLXOQbLtmbpM0SiXPo41a5c/Wi2glwm
         STrPtwUs76JGHlAKVet/nMca394NbJJ+kdfI842pLjaGy2Ms5jgtXcKh7erHbU4Q7aX8
         +JIe49U3D98C+PxfRnnt07rMxe8D2VjmczjMOxfnZ+yBH6woQYBEzvkNHoSUd1CCbrCv
         yOtA==
X-Gm-Message-State: AOJu0YwLQipitlzZZ72DvgBwm68sIn2FNWRZ/yfPo0bAs17JPDUdqwsd
	POnqCHG1ObTt0oAm/ruJVEM/wJ3ySjke70QMQSdx/qMr+EBjf+yFQNukfjWACQ==
X-Google-Smtp-Source: AGHT+IFIVaZpG5Qjwmncagn0GBVeBnT+Shg5p9hRljc/0rIrzuxqOGd3+wHj/nc+1CJfJj6KfyKaDg==
X-Received: by 2002:a17:903:2689:b0:1d4:94f6:56cb with SMTP id jf9-20020a170903268900b001d494f656cbmr3016815plb.117.1706012887977;
        Tue, 23 Jan 2024 04:28:07 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm8867643plb.14.2024.01.23.04.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:28:07 -0800 (PST)
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
Subject: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is available in taprio script
Date: Tue, 23 Jan 2024 09:27:34 -0300
Message-Id: <20240123122736.9915-3-pctammela@mojatatu.com>
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

If 'jq' is not available the taprio tests that use this script will
run forever. Check if it exists before entering the while loop.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
index f5335e8ad6b4..68f2c6eaa802 100755
--- a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
+++ b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
@@ -3,6 +3,11 @@
 TC="$1"; shift
 ETH="$1"; shift
 
+if ! command -v jq &> /dev/null; then
+    echo "Please install jq"
+    exit 1
+fi
+
 # The taprio architecture changes the admin schedule from a hrtimer and not
 # from process context, so we need to wait in order to make sure that any
 # schedule change actually took place.
-- 
2.40.1


