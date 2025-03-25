Return-Path: <linux-kselftest+bounces-29793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD83A70CC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC26B189B7EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB6D26A0E4;
	Tue, 25 Mar 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GO+KRb7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC58269D19
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941212; cv=none; b=CkMdM1VIO3EogCi9EbI6jNNAt5j1PfX/Rk4K/H6mmmKYyKGq2+6i/iS93MJE3eYNA554RDywsJXTYEiTKjozRn3j4CwCxi/MUrHAl2aroMtDCostVgyk/jRPt7gBgjjsxy6rTYtjjkCcAAO09a98t1doRBi7wX/eJAWRJZLpzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941212; c=relaxed/simple;
	bh=nAQdS0kYPrlB0PxMAzJ/qiXcso8pLJA0WH4ER3qHVdM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MIsy03POsvRhLl8y5V6GqgoowU42Klj09Hacj/IrApsUt52T7ObVQYfMv39c/xC3K8Gm0NHCKWL75HndNEgkZNhFfs1Ya5g1lQKlIsnLlY45PNRy7dy3nX/F1tzlNTDfYEHBOn1Au/9Kbm0iPw6TDeQlc2j8zKR/MuDI7cRJx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GO+KRb7o; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3d589ed2b63so52720275ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941208; x=1743546008; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiF0TiGkTFNi7Db5MBCoZMxJpvKlB7Oq6RSbWRlclPc=;
        b=GO+KRb7o9uvfGlkG0dJl8zfE7T5grSS261BWMyG9+29f96VK9Gp7VmjB9oPXGyg/mj
         98Xm2OIO/Sy22aEM7s5Cpo6ZcOv4JSuLO6lLzwnKQGaq4Q+wnlHAuTnLAigbcCTFogRp
         7bHeEBu7qQg49IniTxR43ipzXRrj7Gnfgb++wgREWO6DJHLbdCp019hlxzsengwGCRSx
         JmU5dZTuKoyTqidUxnYX4RZ/j4f+xJ8ATV+Sw0yEYYOs11Nv+DvO9Nfn8Rd4unDhtWiW
         E7AjcYyWKBXNeiodWcNJ0iGczggaIZ1cC+AWrztKf9l77uSszVjjqMvLtR1irvH/GEOE
         v0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941208; x=1743546008;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiF0TiGkTFNi7Db5MBCoZMxJpvKlB7Oq6RSbWRlclPc=;
        b=JJjI5U3V5K0GZ0Wt8Z5g9jvpLMh1Iv1AllHRmCvHQMXbhVZKAe5qlXlcvsC6pnL57F
         rQedh85fjTzLqTrmXgrYVXF8fWF4g93oUsI+yNAp1EmVD+nBKrIgAcTYeMIeAi4HLFuU
         w4LdcJUY4xS4T8yDWLOy2lYZt/+75pJ3A617eE8IEQzAdelZ4KJe392mdo6G7SbSFqp6
         vIC7HHR5M5sinkaWKMNL59J/geikBr/NHDCf/T5KDn96rYX1ao+zCcTjWL4eAi4ySJdV
         qGfCFSCxbyMwB5lRkmEJl7Z2GFVQBjJlcpG7RWZT8B0C6Ie5oglCOS2wq5r2Rx7GG4ae
         /Bvg==
X-Forwarded-Encrypted: i=1; AJvYcCVV4VFxTwupy0LzoEiku/U+MTrgP2ME4P8cpBZKVqzSkrsY71d0+SnWmUSOIjhonaR5JpyLnhMoqH28WjfTak0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9e54yGJMNwKDy6BJNs5WJdMtdEtsk8Cvr4lmtRGcLwgDP6J14
	aIm9FG/vZz8bGbwkpT+Wsvwmp9dq7clspHykYudy5ysRAC135Bkq+a/YPi5hJaJO8wrxinL8FAn
	JSZ6/NOHgaBEGM9/5z1yE2zZTUiTxwrDK
X-Gm-Gg: ASbGnctT8cFEVdyg5VxEeLVwFO9TSDvDwUttUvqV2ZK6m1FNog8iUjxnhwKusMNTkvM
	aPyD3gL04BqzTBRNWPZggEuCWgldcPyI0edzRUFfMDUZ2I2Gu6BUb0UUJKPZYmERLybzXWBnJxq
	aOmjvCGQkg3YhxXjhMdpMsuCxIbV8ZiV+cXeC74zBiRc4eUa0RN2YDaYOmmnOOsk03dxvCABDMU
	KKkSe5dX5C6jTsuW2fNL79pVQSF2souhdVSWiF/boypPklc8GoMPN8aOE0Z0rppCEvNNmBkL7aH
	f1qUEafwx3LFFU0fI9cJDVtY0S7MS5pVkMI6SFFGv6GHUUyiZA==
X-Google-Smtp-Source: AGHT+IECGuSjUNmFI1yEx79hdLBJWrV2d4PdV+RHCZjyZnEqNWuhCc1Y70X4uB74VGhHc6q3AvLuDGD9FuBX
X-Received: by 2002:a05:6e02:3303:b0:3d2:b72d:a507 with SMTP id e9e14a558f8ab-3d596192691mr215382215ab.19.1742941208306;
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d59606ff78sm5505215ab.9.2025.03.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 51D5634041F;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3CCBCE415C8; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/4] ublk: improve handling of saturated queues when ublk
 server exits
Date: Tue, 25 Mar 2025 16:19:30 -0600
Message-Id: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIr42cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyNT3dKknOz4kszc1PzSEt0kA7MkyyRTw2RTS0MloJaCotS0zAqwcdG
 xtbUAk2Sfs14AAAA=
X-Change-ID: 20250325-ublk_timeout-b06b9b51c591
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This set aims to reduce the long delay in applications reacting to ublk
server exit in the case of a "fully saturated" queue, i.e. one for which
all I/Os are outstanding to the ublk server. The first few patches fix
some minor issues in the ublk selftests, and the last patch contains the
main work and a test to validate it.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (4):
      selftests: ublk: kublk: use ioctl-encoded opcodes
      selftests: ublk: kublk: fix an error log line
      selftests: ublk: kublk: ignore SIGCHLD
      ublk: improve handling of saturated queues when ublk server exits

 drivers/block/ublk_drv.c                        | 40 +++++++++++------------
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            | 10 ++++--
 tools/testing/selftests/ublk/kublk.h            |  3 ++
 tools/testing/selftests/ublk/null.c             |  4 +++
 tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 25 deletions(-)
---
base-commit: 648154b1c78c9e00b6934082cae48bb38714de20
change-id: 20250325-ublk_timeout-b06b9b51c591

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


