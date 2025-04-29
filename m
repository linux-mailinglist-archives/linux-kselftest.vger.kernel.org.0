Return-Path: <linux-kselftest+bounces-31956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3BFAA3BA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE6C1B67BD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FC8277818;
	Tue, 29 Apr 2025 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PzLQSNvr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029527602B
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966472; cv=none; b=jIlO2oNWhf+vjMRbjNjtjRdFNAqW82I33Q1dTPFWCAb4C/n9GtbIwlV+gy0b4zq2Uprbwjrnf05POsJx6YoZnLl9FMIPCJhSgf0oFYo/Ks/a0cKaALuKHoIwyTM8+aGJfvjgXtWU4quVa3lD2EoZinaNWUxU48uzx4m8BIMGlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966472; c=relaxed/simple;
	bh=EVZKMNvHicJPbJJ+yeVyQMnNcU1DnEd0UGXD+q/p5UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pl5HqQXJFk9/tsHZawh7te9WqwC+MHlqRsAJ57J02j+1nIflZmteCkWnZfE31g4/37a6dsNoODsqhp9Q2TD61xE/WRJDSP0KCDRkMauza6ukGDGdC3MYYzK7iPRqzvdU5mTL6U/+NvrmP3L3yRVagrUSOugB1g1OQl/nkplZ+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PzLQSNvr; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6f0ad74483fso74523806d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745966470; x=1746571270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJN4BA+fMMi5a/WeaDyJHm35TLpFGbEwKhPCZI9p8q0=;
        b=PzLQSNvrms3oriDMKBvT8UI5L6FTGu4HZox3IJEvB0VnL/ZelQ9UgkJToKvSu8EDLM
         K9x/LxmK7GQCyUa4OU60wejXudtb37yV5YOwRUkggvzrviDF9u06g961+RzoeYzvfY4M
         uo+dLRT2ZUOGA+lvVCahPXWhb2uOc94s0UL1sFY29JL8VS1pcE0LkkHDXMcf5PdJuxK1
         ZYfrQKvQTYhn0wQBCXVbYiBJWomn1nYnvaEksxqESTtH5jgFqQeCKb1nVjwTCNPe5T7U
         gEQmdruv8y2ZFAi/7D81p6zlp1qwQU7YJQxs2abHZSwV/bdwTDVZTd9HlbVP238cMzEU
         4kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745966470; x=1746571270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJN4BA+fMMi5a/WeaDyJHm35TLpFGbEwKhPCZI9p8q0=;
        b=VQOd9BULWBukLPZOpB8xyZkCFX0sUaICxFrCla7vCauOedrc3p3GaFKu5WbQtfhv0Y
         j9CMHW8IY4GsKhX98koZxE2HNopkjiEfsVkKEyWFJKhW3O90Iuulpo8dGHdK6zGkDb0R
         LXn8K8AKIaQGUYokWi2KFxO0k1fgGwt4cFKsnEC/WuS1dkOE5cLZMJwC5GknhCd4Y9he
         /9nrLuUwWlXIa7gEBr9toP6Z1ehLkhE2BvEGNOUjb75ZctM/bhuuDyYdMrUxecU+kl4/
         0RKkVXK7zK1CJN2IdBmpVlfZEyEDcM77hH8IvSPTCPbH1pQi/CrW3z9lwZVgwg2fDcPz
         WTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqtlpoUbyz/Y6OZA0/O5fQkhuBU3AVuQx3DENSw6ZUm6W+knH9t073L5HB1awBMf6tKbCIQGEeNMt4i8e6Dhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1A+KWBju7BF5Shj5MrfFo6RDA1j77jj8YO7ywwxbbptBMajvk
	XfiGSNPIYNIWdMWXh2svUBxGUSg9cX0wVbqXtjQYZbkmstsz9weIQDw3jpC6RtwsRTFXWn/QJdP
	uo49o3zcPfH+iUBJtFSvBqhMx3jSn2Qf7jBf4bFNDD8laltpX
X-Gm-Gg: ASbGncu48WU4fsMGiEuGkLTZDUTGESTfeBt8kCNPtvGxCW/2B32NmcCmk5X8sC1xUi7
	+/nRTHiE1XYoZp5TJV+rvyULhmo69Dh5x9NpZ8Ytg555oRxkzCa4ycoQdABprs0svRYCLBuKiU9
	Zem4ObXnhM1WPrtQCWfQalsRUFhmmX+QTJcmYHXnm5uZFSwTuOHGR+Ql2CBbsauxcsb6hk9jebA
	mTO3Ixk4BZNro0L0kZoI8wvbpN7IyU03DNj9YULxNDuCwSCQT64ONwi+BjwPsBM7lhc9PxyrQJ8
	J9D+iZm/WkBg/mwQ8XGPH6nlE714Icg=
X-Google-Smtp-Source: AGHT+IHx5pKBNfEP8GO2QbCkLxtckJoqsomQ7OcV39RPZuItnaXv8KVoALbXjsU0BbOjgfoJVSlyWwOn84oC
X-Received: by 2002:a05:6214:488:b0:6f4:cbcf:5cea with SMTP id 6a1803df08f44-6f4fcf6e44fmr18344266d6.44.1745966469654;
        Tue, 29 Apr 2025 15:41:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f4fe6a84fesm96856d6.4.2025.04.29.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:41:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F374A340304;
	Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E3E55E404E6; Tue, 29 Apr 2025 16:41:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 29 Apr 2025 16:41:03 -0600
Subject: [PATCH v2 1/3] selftests: ublk: kublk: build with -Werror iff
 WERROR!=0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-ublk_selftests-v2-1-e970b6d9e4f4@purestorage.com>
References: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
In-Reply-To: <20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Compiler warnings can catch bugs at compile time; thus, heeding them is
usually a good idea. Turn warnings into errors by default for the kublk
build so that anyone making changes is forced to heed them. Compiler
warnings can also sometimes produce annoying false positives, so provide
a flag WERROR that the developer can use as follows to have the build
and selftests run go through even if there are warnings:

make WERROR=0 TARGETS=ublk kselftest

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec4624a283bce2ebeed80509be6573c1b7a3623d..529ab98a2633a2278bc0df8b26500905d60d2bec 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
+ifneq ($(WERROR),0)
+	CFLAGS += -Werror
+endif
+
 LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh

-- 
2.34.1


