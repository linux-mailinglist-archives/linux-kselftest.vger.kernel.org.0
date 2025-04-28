Return-Path: <linux-kselftest+bounces-31827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE07DA9FD8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A05B480058
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29709213E74;
	Mon, 28 Apr 2025 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Qwg3d+sz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8B21325F
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881845; cv=none; b=lc9cZ4CY2PEysqBDwVnY3A6vehYhTRofXI86a5qUIGaun0m+OG58/h5oNEUrgYsHkVHQzD2SLO8aaNlgIxRYm/QOLzd1EPFir/+HfucVEMUc+xGKuwu2mixcJPTV4RucE57l4Upun6D6BcjZDT1IWkDujsAHcx0J+c7gM1LolmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881845; c=relaxed/simple;
	bh=7qGhW0lObjamK2vkejF8Y9mV1B303QKOHDtBCxKSc/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzEqQZwLlZpfr9iQeBtQaGDBLWCwjrecY3ITK0K+9wP78rLi+0kuDpSxcSPR/akF6MkVy1oERosYrfJz5hCZp+mtZWDRj6nvCJ3ij+Ihb0a3hUAZkYLCTyPBpRjiZSyL+jBW2aizl9XaYAs7cVjCzIsllBIEL5DoZTX3SvZbcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Qwg3d+sz; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5259327a93bso2013260e0c.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745881842; x=1746486642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmz20arlb8RcX2p20KSIo8CkAzDOxhHq99zIjNZrVW8=;
        b=Qwg3d+szDdvNKGHasY0mJtoELugv8k19HwrB4bG+7fHmF6w/ZdO3bEr2mePCzJtFld
         1ZmMqiHlU4FgFJXt0j438mbMt/ujwSl6zN5Barz8N2dCmbe6lCAQjo7JCF0CU5AuNrFg
         qsyJJdjUCc6JW+5529Q3piA1teaADBVRoIsMe45tCPzTzpW6pmeaMAHlv4b1sLBSWxh9
         8Ivybg2vQw6TXY4HifMoefoZrVcf1/nMwjuYjO6i3HyVPow4WW5OBYDhlt5VM2r7ybOn
         keEZYpueQUFdr4VfY8GB4btyHA9VCwFUZgD10GHBTXWVf6fOsj8mCIdTmZIwk9ziLhIs
         p1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881842; x=1746486642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bmz20arlb8RcX2p20KSIo8CkAzDOxhHq99zIjNZrVW8=;
        b=BpJnbrRsBagg3m/LP/dMKI2yKc1hj1zr4ndOqn140ueRYIOqlqDXyfjIcUahZMNSgB
         8zDy/x4oI6fmnpnX8tS5vvfzhSu3upi7Fj+AZWD7G+0jg7+rNUe690ePD65aT285SQxi
         35GydjPe1PU9M4k+GavIGFq4f/YFbl+9wi/5DDi48xKJuO1N+GiP1cFAntL/rTiGI6Iv
         XXxM28a/2T87i1cP6t1bmbJJShxqmv96KvztCR9c8mB8P+5AsqlHQfXLmR7CnMOgBIrE
         HEvtQunJqO1FPzdq4wIftMyj59asFLI3ViEM4Hg2vEAHM/d2HULoHEIZlTvsSrY0G2KX
         DLxA==
X-Forwarded-Encrypted: i=1; AJvYcCVkYJ0adOTKtDmkDxMkFO0aCEYAxHcdYTrGCwRteX2E2+yOIoH0j3BI7UYz34IJQxRvJplGTQMcS4I6mdFHCMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hRHy0bFuqyG3qssXlmVTW4zHn1jzv3FcAtW1l3VQWcblbMLy
	D3snsxdpDZWZW80JpYpO4rytWq89g2ZkIX5nGpn0C5N4a8ApFqyjms2AsGDEioplck3c71v9285
	+qT7YZ0P4+is0G1fQ4JZ9tRj/Lu49DxAH
X-Gm-Gg: ASbGncsu6pL30kTGfes+I1Y5SFRRFNSneIzVyG16/SSiuLMeRYfZq8IXHCfqGQSbk62
	/tWgaVNXGOqyMfuaKPCcH/QMrFzTxUkDoCdDv8jUURGhMMuskIqdqaF8XebvkPFtIIivSwV7QKJ
	A4i/kX8m0g50yNdCVpxorzxnoEE44QWfMhd2UihMOLlG3avAHZRTfxIf/zPAibHTu5jqmpW3A1m
	2TY/u88R5wb/MZGz8h8BIl6A48oiQHZzzLv8CKTlE06PotkhNxviKVdjtFFdmRakok5vDYt9Bjj
	OXNG0X1F2Basmpp7UnFjie0C+eMk2+8FKRlt1HV2vrpiDg==
X-Google-Smtp-Source: AGHT+IGM4smmOhtgP/4+Uo/a8IWC8EW5NjjaSX4wyDUOukBYYBtb2f/7+HWxfvUz6i44U/GswKTrYMpTZVq1
X-Received: by 2002:a05:6122:d04:b0:529:b2:ea5e with SMTP id 71dfb90a1353d-52abf0421e8mr1039622e0c.2.1745881842049;
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-52a993a2955sm790539e0c.10.2025.04.28.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:10:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 49A673418B8;
	Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3B199E4191F; Mon, 28 Apr 2025 17:10:41 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Mon, 28 Apr 2025 17:10:21 -0600
Subject: [PATCH 2/3] selftests: ublk: make test_generic_06 silent on
 success
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-ublk_selftests-v1-2-5795f7b00cda@purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
In-Reply-To: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Convention dictates that tests should not log anything on success. Make
test_generic_06 follow this convention.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/test_generic_06.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
index b67230c42c847c71b0bbe82ad9de1a737ea3cb75..fd42062b7b76b0b3dfae95a39aba6ae28facc185 100755
--- a/tools/testing/selftests/ublk/test_generic_06.sh
+++ b/tools/testing/selftests/ublk/test_generic_06.sh
@@ -17,7 +17,7 @@ STARTTIME=${SECONDS}
 dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 status=none > /dev/null 2>&1 &
 dd_pid=$!
 
-__ublk_kill_daemon ${dev_id} "DEAD"
+__ublk_kill_daemon ${dev_id} "DEAD" >/dev/null
 
 wait $dd_pid
 dd_exitcode=$?

-- 
2.34.1


