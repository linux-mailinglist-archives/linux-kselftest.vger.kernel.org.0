Return-Path: <linux-kselftest+bounces-3409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93402838E81
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 13:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A37B2888E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BDA5EE60;
	Tue, 23 Jan 2024 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tQ7tJGtU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25E5DF30
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012896; cv=none; b=s+jxJqDVut4NH257QqayFXwSNXvG2JfAz6KKPg5rlUit+N6exrWptVwOURzOC4OBqYq5jxUsaInBBqzFRad4QSp780E2ahS0jefEzAa1ktGw8NDpZT5bU5nd+j/Uj4S6dkNtcutWtin3uScVt7tc60e0EYDxbMIYf0biHAD0L/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012896; c=relaxed/simple;
	bh=Ot+bTBOPefhnDDQDaFuxiuUfKC6AG33bf2g9LLIDp3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZSRdj5N85zQ4EVs9EeQemFt1SXS4CBl5gQvB02LgnTMM57SS3oX5t8MdelLuLsLipoXke+GrAJasxxsGSi+QJeIvMV3spwweQhZCeGVfkMzpij5wbByMMmqYeRbwc9zycvR+Klu2AK/cPsTg2VfFBL0tBRCO1PwqR4wkz8pVd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tQ7tJGtU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7232dcb3eso17243385ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 04:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706012895; x=1706617695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36MRRmXPqllz5KyDGXZTrimLPtySszyCB1oWLfkeCAE=;
        b=tQ7tJGtUx5zaEJjNxaVyvpH6BVhyDlF37uv/kfxSUGee7v8BRTSZgLX2G7725D+CbC
         mkd721JiCz2mQBGoRBJbFe5e7HVfQPrQXowz6yTu9QGuuePv0V2H0IFF/2k/I4aD5OuR
         7en0I0MgVnTDyrfrdJSr7uLTLeMM1vw5dCdimzbhasXH9hDD3E/GKYsqlKR86M5mTfmd
         x4fi+J/RKaWoehGcJWpZJGeYN9zWRA0+/NOEqBlbSBKaM1TYT8Xp7SWpddXCyBdhN0H7
         2fOq/xVCFKgwjwR8BzLW/aWKBXlqzTgo3HoKAY+v2QOaZZwVgfZyRDgcbnvDjh3ti7qF
         zc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012895; x=1706617695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36MRRmXPqllz5KyDGXZTrimLPtySszyCB1oWLfkeCAE=;
        b=XYwljHKmWwmr9EbCKVk/Mq8U+vZuu/eKsP3JhZuTA/p5IaZJgPWul+RedDZ4fXzGYs
         ANRVguU/gapHwsqSSj7AAC5RnwTDQpb8G9b8YEzk+FHM66DrmQ6VYB9woZx0Y9CXjXvW
         ufYcu9ugZVGR9L+/4OtaeIXSkQFI9N0KuakVwGRtUiPDRPtpXa3xOFDjGmsRj6062WE9
         9nw1xJgezogVdONfkoeRH9+FXAlrCazUeSl40msyEDqqhEPTTBG111I4BckKj+SPKMxS
         N5jYAf0xShuEqG+LzPSsO8LYlaA/Hi4Xjux95GW0sQKKLWF2E0qZtnAvLghZt7BTp9jj
         vhBA==
X-Gm-Message-State: AOJu0YxwIRd3knGcn943YA/u8S0C8/KQPpBjfRXkDnwEdv9d42lU6YQ5
	2CH0UQYk7QK9w8s06YU9a40ZjpfADMyhNN8qMDuy/hqNJWQKIxlLknX4EKyvOg==
X-Google-Smtp-Source: AGHT+IF0D0kljlbjAfG9BQ5CCjJ6VWS3TBt2KIYftFW1fryDQUEvqOl4G6JTG7qZT5ezdUMQ1tcUrw==
X-Received: by 2002:a17:902:70cc:b0:1d5:5984:df52 with SMTP id l12-20020a17090270cc00b001d55984df52mr3091162plt.60.1706012894834;
        Tue, 23 Jan 2024 04:28:14 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm8867643plb.14.2024.01.23.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:28:14 -0800 (PST)
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
Subject: [PATCH net-next 4/4] selftests: tc-testing: enable all tdc tests
Date: Tue, 23 Jan 2024 09:27:36 -0300
Message-Id: <20240123122736.9915-5-pctammela@mojatatu.com>
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


