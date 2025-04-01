Return-Path: <linux-kselftest+bounces-30003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DBDA78390
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 22:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C70C168BA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7621770C;
	Tue,  1 Apr 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hi0rfQ4N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5321507F
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540560; cv=none; b=cofSRC+vnZKSWN9K8JDHKuVC6FoiFmOQ6Wxdsc0I9LCM2CQ5RpmLFc4IM49P32HP9feQ45W9eNPnTuTHlyGXe4b6mFgt9UgKBJ9uAH9PYgw4LBnFgquiHUcLTYf2OGNIlTSk6uT4wRupcBHegdC4LfxH9V/wfITjj97Lw3rjJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540560; c=relaxed/simple;
	bh=d8GQDf9aNn3XCHYo/doXpPecRNU7F0oZKd4mY5qwFlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GACXPXI0IrO27or39gb5RSPhKG7t7B4h+qCh6/7XLhnlgVYuaosUshuxfBtE8cEZOnD7kepgd7mSNqjwpz6dPLdtjF/amvLAXPaBTUyLFTY1SuAzvEi5DrVPJc7YN/wn5OoP4TsLZK+BUYQSggS1hiDY4ETrpDBJgMEX9vWfmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hi0rfQ4N; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso9623134a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Apr 2025 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743540557; x=1744145357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CszSfhaBSgL0ceu8EPCDZblcpCoeT9mB1rw339afGoA=;
        b=Hi0rfQ4NpLhAQMZyLruAKoM5D7iOc88WxnhDiZ2lB3oCSvBj1A3xOxORz70D6n6dfV
         olUOkbF63/5Wjr5vvW3BG07sh+HcXS0ZG88St+DI2UvKv9jMlrgaThCF5E97HWAW2zVC
         teIQA9jKrmPQs8ynkjC9aFV78FeaMiPmjI6Xwr/xIIiD7W8sICuey0csyzckvsKVXv8L
         XvtS/b26MTDgMMMlULgO/SPGEmX7QNVjfXGW66D/fUZXYwIkOaQQNP9MiTVn34QPjykx
         QizgrZ5+Y7ImoasJdGS5bmQl4fw9sHLFOWrZtPxpu+YXypziDis8PJb3mR8b02jGbXYv
         NJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540557; x=1744145357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CszSfhaBSgL0ceu8EPCDZblcpCoeT9mB1rw339afGoA=;
        b=AQN9NPihsKbut51o2c9belxt7GX0JpvA46WiZ2fdyWGgja/huwOFbD951QKo2U0Hvc
         i6uo1/FjMzOJVW8yJZp1Il6FeTfdgHxAqkujpm2Ja7X/nASSJUoB2MblxaCZnwClrEID
         UGFxgAmlayb0ujGK6By7adJ95W4/UqUjr7C1ToBaMkKPWnHU0KlLRDxYxWjAZ5m8MGl+
         GC09NO7K0wYPi5haH8pXQm1sD5J4fPKX7hkPRIrItsh3e6ps4TYce0DPBnhtiOVgZjU4
         ChR+zt0+n/OHy9DRIdam+Yg0NMlxUkce95wP4oiyVIrif+/XE5bxocByvjHvW4rd+k7S
         4wjA==
X-Forwarded-Encrypted: i=1; AJvYcCVL3B/jc0dS8W0KO4ylw6hJw1+bYCEPowleRr0Q6YBt4vcOKEkJeNLZeySCmPBuk5IF6FdcrxsElO6E2ouPvsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOo94F9/G8V5xB2BXvA4XsXTquVV/HDhXycZ6xG4LHd48n4Ftc
	AIU86AKpiA1LHd3zRUnv8/gpOD8YcBTD4VmmLJB6S3bG/osspQnKAxrGuDxQwy05DfWIf6vCbQK
	bu0QZVdAhVs3VtSiL6FVPIFQMcYibXSICUo1V9IdqLo567a2H
X-Gm-Gg: ASbGncvsOX6FVDLAENi7Fnl5VUt/O9tLb0dg+uPdHp3pD/aqh/15g0NYjUgek0nm63d
	UBHYWFx3yK6fRjO9fEkqT3ZNVDSYInV0KO+BALuYwl8CBl1+ndr24ziTrdYymVKSAYow+Ru0e+b
	nPTVU0Lk4Do7kcIleIXCpnTyk6+laUJJql+HWje7h7/ITYEliysirfACWI5+rJ8Gv1MnD5wEdIi
	FMWH132wkyseD+QveWX+LMJpg9aIGWlMST76+KRshFnTaZJmYLb8w9jNoe252qYnRQ/ZNulNK8H
	ivFas0ccEnF4e9dk4JdMjEllTIX7TaKowf0=
X-Google-Smtp-Source: AGHT+IFiTOrrefXmiLyHfCuPwBgnL0O06M+OBFhNttC3/hRF0LLMybJ75J009EG+gSxDw4ZMGHDUitYCjo9x
X-Received: by 2002:a17:90b:5410:b0:2ff:6ac2:c5a5 with SMTP id 98e67ed59e1d1-3056ef0e8f6mr143301a91.26.1743540556965;
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-305175cae25sm860359a91.14.2025.04.01.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 17F8334024A;
	Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 08CE2E402D8; Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 01 Apr 2025 14:49:08 -0600
Subject: [PATCH 1/2] selftests: ublk: kublk: use ioctl-encoded opcodes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-ublk_selftests-v1-1-98129c9bc8bb@purestorage.com>
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
In-Reply-To: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

There are a couple of places in the kublk selftests ublk server which
use the legacy ublk opcodes. These operations fail (with -EOPNOTSUPP) on
a kernel compiled without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES set. We
could easily require it to be set as a prerequisite for these selftests,
but since new applications should not be using the legacy opcodes, use
the ioctl-encoded opcodes everywhere in kublk.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 83756f97c26eecc984da55b8717e99b89470b904..d39f166c9dc31721381184fb27d68347ecab81b6 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -99,7 +99,7 @@ static int __ublk_ctrl_cmd(struct ublk_dev *dev,
 static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_STOP_DEV,
+		.cmd_op	= UBLK_U_CMD_STOP_DEV,
 	};
 
 	return __ublk_ctrl_cmd(dev, &data);
@@ -169,7 +169,7 @@ static int ublk_ctrl_get_params(struct ublk_dev *dev,
 		struct ublk_params *params)
 {
 	struct ublk_ctrl_cmd_data data = {
-		.cmd_op	= UBLK_CMD_GET_PARAMS,
+		.cmd_op	= UBLK_U_CMD_GET_PARAMS,
 		.flags	= CTRL_CMD_HAS_BUF,
 		.addr = (__u64)params,
 		.len = sizeof(*params),

-- 
2.34.1


