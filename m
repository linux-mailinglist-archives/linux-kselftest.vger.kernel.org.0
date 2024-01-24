Return-Path: <linux-kselftest+bounces-3473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF083B0E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4415E2848EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B4512AAC8;
	Wed, 24 Jan 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QYNmruvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E312AAC5
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120406; cv=none; b=nFTNLqQPEC/4S9uODDqQooWnXdHHUWl3ZTj4yIsEYD2tJNhDx+Y3KdY04qHWlv/K/DaHQBqzqcIFpatxjudxHUx5UmGRLBRvcApnPt0xKbd2nXfeIqEMme1mOeTyXHRnMvLmaiu7DUFHzYhR63XVkL9XuRxA3nbl5Rbz/WHXdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120406; c=relaxed/simple;
	bh=Ot+bTBOPefhnDDQDaFuxiuUfKC6AG33bf2g9LLIDp3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwvDAtRi+ilTSuOKNUT954EgCFyXz42No5yaQXVv4kjBQIm3mp72XV43LllV09/lnp4EXFY+BFd9tgH2mC8a8x5k8wDonKvZ48dT67bpzh8yvB3K9S3CwWRTeqUeuV9fMsZJRo0ifge6clMydsm3YGI80zvA/15jUGSwvEica54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QYNmruvL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d748d43186so25686585ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120404; x=1706725204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36MRRmXPqllz5KyDGXZTrimLPtySszyCB1oWLfkeCAE=;
        b=QYNmruvLsP2yi+DgkDU04HJOpUvmt6lL8jIsbEGItd3dcD1l00JO95hIHIhZPKeALv
         l/MqfZp06geMxaqoHMrf9PTM82mGixtuZBKJEFgc+7SvUX211ULWBDeKhcDGZvUG9xFl
         z5QLT0mR/Kt2ImmQQnRuvfRoVfMN1DdbmQn6EJ0HLX/l/cez2kB9lpfZVcopa45AEExV
         Si32EDSPrBtxPpGlQEfkDrCpJLx4ECK7F7HZCNtKJ+8D87AXdHyJiucO8bc09vUBImGp
         +NMijivk2yXaU1UfAPqzcNcQDSCJZHtjN0McAHR6T81ORkzYM6iZEdXBjZ9QZldcekm8
         hMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120404; x=1706725204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36MRRmXPqllz5KyDGXZTrimLPtySszyCB1oWLfkeCAE=;
        b=HNVHDrBl3StEzKd/iEzszvJ0BpW/558ItVka+KewSkAlHDmAzQY2IoxCfuRXpLjk/j
         ftc+McvhbkZfjkNiezuB0nIgH0dnpPf7k75zo5KfZA4CYxO6GYUJLfRlxKuxw5OWkxvE
         k/kKB+C74vWX2KfuAPFj9ta+TCDdW379G1D3Ag3Z+xNfYCntcOTIQ421w57LKSp8Kk1f
         gUafOSIATkixcYJHfH3DgGRlYJfAQTHKY+pmXl43VGoE1zN+PUZ4SmQCOHQ5T/eJ87LH
         pk4DkYIRb9W7pakQdAX1z7ViYbEJm7cUvjZiBWAMUsDiGdDg9VmL5rVE6SAzhLSb2HC0
         mR2g==
X-Gm-Message-State: AOJu0YxShtS8ejy3U6lxWghNV40LEp+O7/eWZD9meTdRVnqBQ8G4lBmp
	bUMnwDDTRKrYWBwBypKyXBNU3Cl5lTMEdvi2v2XMZ9BMxGBUoV8T2U9EpdhDNw==
X-Google-Smtp-Source: AGHT+IFA8ivqEWLLarRkLP2QjyukvEHdH98jwsVsvjw2/mXwmVUw2LIgunucCasiskGZeTNqgKRloA==
X-Received: by 2002:a17:902:82c6:b0:1d2:eb39:afa7 with SMTP id u6-20020a17090282c600b001d2eb39afa7mr1047236plz.138.1706120404413;
        Wed, 24 Jan 2024 10:20:04 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:20:04 -0800 (PST)
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
Subject: [PATCH net-next v2 4/5] selftests: tc-testing: enable all tdc tests
Date: Wed, 24 Jan 2024 15:19:32 -0300
Message-Id: <20240124181933.75724-5-pctammela@mojatatu.com>
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

For the longest time tdc ran only actions and qdiscs tests.
It's time to enable all the remaining tests so every user visible
piece of TC is tested by the downstream CIs.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index c53ede8b730d..cddff1772e10 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -63,5 +63,4 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
-./tdc.py -J`nproc` -c actions
-./tdc.py -J`nproc` -c qdisc
+./tdc.py -J`nproc`
-- 
2.40.1


