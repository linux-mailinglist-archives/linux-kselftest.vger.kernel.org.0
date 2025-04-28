Return-Path: <linux-kselftest+bounces-31829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88FA9FD94
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960AB3B9A2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4B2144BE;
	Mon, 28 Apr 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KkgYZ2sK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F9212FB8
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881845; cv=none; b=b+VkFRWckod+9jejb/hhL9YnSw8QjxLtcMP1d30R6NF3L+Di3PeZC8pwHVOJKONLbQ4KqX02jfPV4e5cQmEONmntmSubX5y6wEpUcofgqjlIm5J/fuTQaMu2r/+ocrjsjvq9QqBikLjAlp4u7ebIiVqAkJKZNHjZNOlCbJExrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881845; c=relaxed/simple;
	bh=V6z7U2aK13VlHSymACPvCl0r1Hj+jEq5qL59ctGJ8CE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rJnU+hkV3DR1dFN0TW70Mr09dsfNnPOR4SkerILdO17EpRhIIIsBtI3JJe7CfR43dIDxcK0zLTzm8GNK50Sk3byPoZzeueXuujLYLq7+7SCuHPBe7C9TW1Ewvfl4+V8Jw9hlWQ0NcdVu6BSkuz1OyT+eQdl7gHPfh6vvFstmLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KkgYZ2sK; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3d81768268dso49525455ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 16:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745881843; x=1746486643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoJLVk2Sn62iG3PhsVN8tZ93FRDpe04tgFauvMGG8/c=;
        b=KkgYZ2sK2Ukxo33EhXPUzCCASiABHFHNrttxWcm85bkJPll48PxGzr2RgE2DQudMWN
         TAn1o9037H9ULzRijwpOy53jN7zFdfb8Yhg4V1cuWWt7rWYHA9/0Z70AB9C9rQy88kYd
         cBSWO1KBS7X6dFik7uDd62LzmRk6IXFoDBLOLUCYT9TmaFsmfSOZzHxPa1Mt+uk9wBIU
         CtMwotGFnqG31iXyLzYj2fFCz3gxUwYqAXNIsn3cALOOvjzEgaAicbbxqG2rkdTpZ88p
         EIDyq3e3cGHv9UP1MWEytKLAscXNPI1Mitui1TE/IFToEPgvIj0huKrQRkgrCg0yjLox
         gISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881843; x=1746486643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoJLVk2Sn62iG3PhsVN8tZ93FRDpe04tgFauvMGG8/c=;
        b=X0xluYGvZpsOTGlUlZJ2DTb7Ar3qHK3mG0k3XHC/YnnW98NvKd5JSG7lHFU59+6MQ7
         1u3SgTvhs9ZyWqVlNEwfwxeF2Y5ySZ8UlalTDNwzNLJ5sG75g6KM+ZuSvRSyUxUJukPs
         p3+j30TfMgMq5cciEHZkPyApi2D+f4Aa7ekTfMtDrZWnz/2Cxgw+0uMFxFOEjafaK1PP
         w+7hleVQhwvP6W+ppuRR47JzzrBhx44zXAYiVfHRzEcJozNPvR2qWUu0GUb7ZUz1cZL2
         EXrUaeVly6INWuQtnaBDqXg2W5rCF1l/gdcAfzZLTkx5WFZrklxSU76dtSFrS+V7CJ++
         xYzA==
X-Forwarded-Encrypted: i=1; AJvYcCWl3ZIlQYQZJ1JvU08mSj47ehgDl1AoikDOHVUNGiq1U4KBZLZiZ6L8rUNmmilJ1EiHhsGG5u5VZR0UcGkysoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEIXFCn8xQd22BKXtKVlxxdyxP6b4TtTrov1PWysf74Q6tl8Y
	kdCQvA92bxbaBRjF88sD6BBV8R5k3iPffq34IEiNH+f+03G6svMCn5K1t837JQ797ihB22wlZT7
	5DHkjgPDI16+wGZ2er0dSSt0tGwbauGEf
X-Gm-Gg: ASbGncu6xcnjsC9Jahq+1Cz9hyxKEJxhvEjQu5+h2Z30uKYW/uT5D3QtHts5yZQ2sP0
	monzDdAURQV5lB7EXUNchdrdHTub4V7T1rSKXNaKatQOapDjGSTCwHF7uB/gXd2wG5YQWYWSHCc
	iB/X74HvaS0b8K5zepqqg6LQ/Hb/cgkvxj/fsacvt7SsbSdVfJoZtz84jRKHrNMyEPqtU8/K7wt
	eTZRI/72i/AbrIbzg6nTU++1eQgcZBjiPf8cU4lZmR/hiQL0aEs5NRpukIgNeIGrBXvTfHZAFru
	d3D54FvPSayWzbp/eVIMvagTUU3iX3BYCl3B8dR7ioypHg==
X-Google-Smtp-Source: AGHT+IGe5A9W9y3Mo5+kfpnNwmt5KhFphAnNJ2Rtm6xsdCtc5buF0dbnv7TNmO2d5giTwkyXslJWgll3DbLo
X-Received: by 2002:a05:6e02:2146:b0:3d6:d145:2ffb with SMTP id e9e14a558f8ab-3d942e42573mr129606055ab.21.1745881842428;
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d95f45294dsm80395ab.44.2025.04.28.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 41243340BC4;
	Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 30933E4191D; Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/3] selftests: ublk: more misc fixes
Date: Mon, 28 Apr 2025 17:10:19 -0600
Message-Id: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsKEGgC/x3M0QpAQBBA0V/RPNtas7bwK5Kwg4nQzpKSf7d5P
 A/3PiDkmQSq5AFPFwvvW0SWJjDM3TaRYhcNqNHqHAt19uvSCq1jIAmiysJgrp3pDFqI0eFp5Ps
 f1s37fvvmW3hgAAAA
X-Change-ID: 20250428-ublk_selftests-983240d3a325
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Fix some more minor issues in ublk selftests.

The first patch is from
https://lore.kernel.org/linux-block/20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com/
with a modification requested by Jens. The others are new.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (3):
      selftests: ublk: kublk: build with -Werror iff CONFIG_WERROR=y
      selftests: ublk: make test_generic_06 silent on success
      selftests: ublk: kublk: fix include path

 tools/testing/selftests/ublk/Makefile           | 4 +++-
 tools/testing/selftests/ublk/kublk.h            | 1 -
 tools/testing/selftests/ublk/test_generic_06.sh | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 53ec1abce79c986dc59e59d0c60d00088bcdf32a
change-id: 20250428-ublk_selftests-983240d3a325

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


