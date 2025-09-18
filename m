Return-Path: <linux-kselftest+bounces-41889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B1AB86B35
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 21:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6102B60B76
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE62D9EED;
	Thu, 18 Sep 2025 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UKq2ug09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5D2D978C
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224056; cv=none; b=PZ3utUdq/9ai4k7LUQLwfSZVjocN76th2CReAneZKFZxi3fj2jI8gX7TgpYFYqF8ycC4Dj8rxo4qirXcYfTZ2NMpsnaaxRN5tIc1cduhXaFBt2vuaEiyL/S6LZRZ98PmL+MpIBLh7jHNhNson5UXrbYp+tGaeKSjDRGdqeK+MNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224056; c=relaxed/simple;
	bh=Y9/Ne8zaqdwA/LXEG0LconEi+zVGsXicyRVHEDgancw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAOyjWenKMrd/qloacOrLLXFEnOzbJStIIoINoutZ2Snf9N5zJUSBai2UwGw7H0fFkd/tdJ4IrqZd76rZwMgeEeGUe2y/6WU8iipPMsrwcoYsyEF4r2c/iYNvVOv6iv18wpkx8JWtoA3iOwa5jKA/rrYuKeHyBWBuiLFsW6ZMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UKq2ug09; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-ea3c51e4cffso1231915276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758224053; x=1758828853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUwZ0WSYzRWLsV37Zv2zW5RoOF8gsqcC5qtG3FfYLLc=;
        b=UKq2ug09nECDKJ8qP52M5tEonD4ouB9EMtR+X7SlGgf8Q5ifu431/jNdxo/guiTZiL
         e6rcrF9vVt36B1VXSVd99J27eJpitA2CIRozfsKJfFd4dxujbtidpWvFNa27ls1jA+Rs
         63fZcd0W9kBh0DeAnKh7bvJ0i+PnBaid3V4aE2cotImXwL7AcsTG4PmF6pVBwa/tUNDy
         pAiduAQec/w+HLMGpfIj6Fyiqbjq6FuJMmHmhm1moADeopI51gClaamKT6dlwg62Bxn0
         3CwM3JLsWKmakrQn8vhJ3xRelgw+5vBpTrJl5cGOX9e1O9ZI5tGecMLTW89dS2ipHn+6
         /y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224053; x=1758828853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUwZ0WSYzRWLsV37Zv2zW5RoOF8gsqcC5qtG3FfYLLc=;
        b=bl9gFcoN7+JQzksZz7PG7rCabsWbCF5rEPtjql8EoCwhHrpQ71Il/6ylaXK9dWWjEI
         IKm6yHL6vkm0tWR15pjT3KM0uyOI/g1ZjccBflUyKyHC+zkcbsP5N9BR2VktUwnvTW6z
         sO2wVNJoS0Un21SoveEoE0+XLOkNX/yqJNIZrG72SI+3y+9g75oQ1qcFSLl0znXS723A
         l0oA8Reseak80BnvONnjCmkE3c+hchGMne6c/1yYIo/cXsRBvZh/HpC88w9TCOYnzzpm
         YHh6sPgJf6j/LxRmtAASyniH2E8OEuvz9DcsytiG8hOwHlrIuCjcUHpA0X332iBfUriF
         3hEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuNEHBjnNfjVD2JY+xstrfTmRhVEjGvVviT89b0a61rAb1iuXZjQmHBtx6itRQFAvd59z3u+ImKj9WT0dvgZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcLeluolEJ7v+3vYZZR2TWcnqF0tLFBJzOcPgGn6k0D+gdrDH
	/TDy9KpyXyHvEoznmRk72CiH/fjeMBgaCKUP9LRvSW9Dc70R7XjTN0TG9zaaHBNfqnb0N80V+RA
	UfTgN/TBtKmCNujyDbZq3OL6vMCKln6emVjH/
X-Gm-Gg: ASbGncsbDhEA5GYbswF0Y4m2mW21H/qWqOIEmLXBozc/OAPX5RWIKvi/Gv5dHk0JImo
	LfuR78l7d6Key9NF2QFS9jy7OS+WZaqjmE9fCOpZSEaEtXt6ou4A6i51w8Rj6Lb+9dtdvX3Y6EN
	YhfW/zMb/O2tuPT4Gu3B1S3NIF4caKAvdnpdChFhoWgljiZWkIM+ouNtl771/nmh7B5FADxGmV3
	LhsNHUq/aJItMZO4ezydo+kKol2pCFkSWmEFPJ5JkQw/3samYiPLHtE7xBArGoF9epsOAe8eGpP
	hFPBi0YSDBL1fYU8gi6Bur3eoe2DFCVYLSStSmgaHTqWE8beoeWBkf0FQDllsvG0hslCHmsZVw=
	=
X-Google-Smtp-Source: AGHT+IFECpZeDDEGAhBtzHw6/PxcEE3TRQwhyGlv3EpuDKpWXDFvddkM3Bj/6+YKpS1VWGtiLzjjfhO9SUic
X-Received: by 2002:a05:6902:150b:b0:ea4:d1:e832 with SMTP id 3f1490d57ef6-ea8a867ea09mr636869276.42.1758224052816;
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-ea5ce832831sm198429276.16.2025.09.18.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3432334049A;
	Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0452BE541CA; Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 18 Sep 2025 13:34:08 -0600
Subject: [PATCH v2 2/3] selftests: ublk: kublk: add
 UBLK_F_BUF_REG_OFF_DAEMON to feat_map
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ublk_features-v2-2-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When UBLK_F_BUF_REG_OFF_DAEMON was added, we missed updating kublk's
feat_map, which results in the feature being reported as "unknown." Add
UBLK_F_BUF_REG_OFF_DAEMON to feat_map to fix this.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 4e5d82f2a14a01d9e56d31126eae2e26ec718b6c..b636d40b4889d88f7d64d0e71c6f09eca17e3989 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1379,6 +1379,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
+		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;

-- 
2.34.1


