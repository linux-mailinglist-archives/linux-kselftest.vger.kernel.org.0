Return-Path: <linux-kselftest+bounces-3405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB745838E79
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 13:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9251C21527
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA95C8E2;
	Tue, 23 Jan 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Qz5rSUgS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF55DF11
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012883; cv=none; b=FaS2UF4SwgGiH8a3SrjaTh9q1cJWzn5SAQhVCKMLTgbaNvoiyOe3HTmUNygCmeOiQInyfEdBiXXZqF7XIPNj1k+PJXNIDq2+Q8DI6c/RzKED38UcV4f/T9pDj4Hfeu/xUz3jbDRhbx6Q7ahZXmgB9RP1FZhKTrKKifoFpOFehwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012883; c=relaxed/simple;
	bh=MjGJJ58fY48RLmG670Db8+WyDbzgw5a4WzmBK9YtRnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEehWItzZ3G0nX/A951s9WPaMw00AFe6oIawW9OcIEJzhsAHO39Oqsr5dcKyGlHEKxZr/X1mlz1D6f4pbSrEKLqZkzvALhq8IV6MeXwacvgNlwehSRRl/J2qSyuBnpP4QGowBjJfvALMlYF5I30QOEzlbY6AJ0aaTCFzDF2Gp4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Qz5rSUgS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71cb97937so24296755ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706012881; x=1706617681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iTXjkZB7fjt2k7xfvkK8ipfMoEf5Zm2H5xBPVYq42I=;
        b=Qz5rSUgS02iHJ8h5Q0GiDtT+Iv/MfWRUwQuY7OxE1wJg+pv8krIiXfUnHel+iP9oh3
         WWqqdYNnQWsFhBUQCGora0Mfx21Un0YkJbrlICldlCC5i7V+DcbKMkndbHwbmRTm00WQ
         GzjFsjW5OK1tHuswFwFiGVQu6w91inTdY1xXKkIrzmdgskAq1cbBhH8LApcRXzfiuw3j
         8+c1F4hMCnOFqevDcLaYeFil0dUOCPaPPl5JE1Xher695Fkm8QyC/MapBQIE1HatRUfG
         9yeCdoU6LafFMFo4ONj0pAixMWixggHB+8ljEwhnDBxqntOit5ykl4Z0y2xnlMgPZSJI
         b/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012881; x=1706617681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iTXjkZB7fjt2k7xfvkK8ipfMoEf5Zm2H5xBPVYq42I=;
        b=sXMyQM8Wo0gGzMc/9ebndfR4us5czaB9HwC2svhxGGnyo5HfE9GPI2xab87X1cnNYj
         sKDPvVaBnE5y8O8Ybr1OG2K362EcuzAybTxZMErLotBGLA7UZ9JPIHFPAKNe3DrA5OSD
         NzQMe9DcKYf/wsGWdOA/M+DXqnpmhqbKVLl67uXQ5LbRTKoFxgaAN809u2NB18y2doxk
         mwF+uiQlL4IwKeamNqei5MVvjJIx1KgVS/89OI/XxpXhQEshcuOZhaAy0JE3p3EEDnbS
         szxe5vv4iTK6+FldwfSAHZU2O/jDhFl7Wsne3McUee8TBrCRcFBIzDD5oZW0lwwb0Qlc
         M4oA==
X-Gm-Message-State: AOJu0YyhV0U0TrD6nN56gR/9vlWwqsHArvh7/AOt9MaESe+p6/8J7Hfo
	MVDzp/QoJhmQHh0W79vFs0UXd2C8MwPshFoKQ/syfe0vyxV7Prf5SEUt+tXN1rvBMcq+ezEotja
	cOA==
X-Google-Smtp-Source: AGHT+IHNluqhKQigzcgv5rFnxTVI2aZH8cX7eLAcIvqCCX+vJ7smcoSiC07KE5L2EaVvz00E7VVHuA==
X-Received: by 2002:a17:902:e74d:b0:1d3:4860:591b with SMTP id p13-20020a170902e74d00b001d34860591bmr3746141plf.0.1706012881133;
        Tue, 23 Jan 2024 04:28:01 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id ke5-20020a170903340500b001d33e6521b9sm8867643plb.14.2024.01.23.04.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 04:28:00 -0800 (PST)
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
Subject: [PATCH net-next 0/4] selftests: tc-testing: misc changes for tdc
Date: Tue, 23 Jan 2024 09:27:32 -0300
Message-Id: <20240123122736.9915-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 3 are fixes for tdc that were discovered when running it
using defconfig + tc-testing config and against the latest iproute2.

Patch 2 improves the taprio script that waits for scheduler changes.

Finally, Patch 4 enables all tdc tests.

Pedro Tammela (4):
  selftests: tc-testing: add missing netfilter config
  selftests: tc-testing: check if 'jq' is available in taprio script
  selftests: tc-testing: adjust fq test to latest iproute2
  selftests: tc-testing: enable all tdc tests

 tools/testing/selftests/tc-testing/config                    | 1 +
 .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json   | 2 +-
 tools/testing/selftests/tc-testing/tdc.sh                    | 3 +--
 4 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.40.1


