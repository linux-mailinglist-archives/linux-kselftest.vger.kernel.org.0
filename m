Return-Path: <linux-kselftest+bounces-20833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313349B3A26
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF131F21DD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4301E1048;
	Mon, 28 Oct 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqwZKuE2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE51DFE2B;
	Mon, 28 Oct 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142545; cv=none; b=RkeJPEn2yf6vjxEv3q17My7d7zasRY3Mbi7VneAPaP9GUGoI3wOp0xZZ/h0+kZkgS+kXIGuAQE/jVQjhOKyAWxMW28JxY6CwRmxLV4E0damJ09ECXG2ca3qLNIM1Czay5bG8FIMstzj0VZG3Uz6GF5XCx5lSGN9YADbxGDNUiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142545; c=relaxed/simple;
	bh=SmucZv0i06ofqUu6KmciBZuDotG1iUSOBkV7xS0qhBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrhyCkEj9BImpyRBsu2YfdzzvonZz8N/eVbsJWggMacuQFeTlG716PwjfDsVbT3JU6V348dNk3aY8BEWWqBvJnqZOSQM7dYuJS1X1ngsA6k0GREAqbv6CleOlEZFJ1ysmvUNW85ca5En1RlCBEaBTOF2dX6WGZFo2Y4xq7lntek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqwZKuE2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so3402816f8f.0;
        Mon, 28 Oct 2024 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730142541; x=1730747341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUEiGmW5jv4Jx5aew3GYGfkOzmJF3vI4hiCokbM6c4k=;
        b=IqwZKuE2MmecmYLLz2AWAXia7wKXzv34pOiFzUO5ch9Zm65xmNjXl24oAZKXTEhsdL
         943e8qf9xWAr00dPyTIyGcQ42cm/wa6rzbh5Bn0j2gU5Y2f/yTs0wFfZjS3l9WzC7GOy
         y1lxBpU3/x3v769nDolzljwO26oP/qz2iIU+SXwwVL/DPxN2GxeCXjhNe4iW2uLCMJYq
         3ba+1IAJd42PwU8jnVhOrZvryfnswE7y9wV/jWVf4xTyB8gj/4R8VuJlCp/v3OJm2iM2
         VkEfmuzM0pjqT7eB1tKb3QsNHWy2ZSE9pcnOHFsA7zZS/kcj/LTgR4GgnrEPjRAUF2O6
         DkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730142541; x=1730747341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUEiGmW5jv4Jx5aew3GYGfkOzmJF3vI4hiCokbM6c4k=;
        b=PW8ctPS5PRqqPzdXsVBW+hWjDhDuIHGe8jnUY2NAOl1bf2MBSaBnuE8Segc0rr6pPJ
         ow2vFg6YWyDzR4Il6gZqqWsB4U3aLqTjjAhvQl0yn94Kmc6LboE484GzWci9pd8ysypY
         gfg7KsvnsRRqpPS0QOwuQbZoyUiEhbeY5qZJ4VRCn6ttmEFQpRnShtz5pl5VUeoPIE0r
         HxJ57v8AIew1e5lgxjCpy+Fr++zvgdIrrF04iMUPfMCvPE+P4OEfySauOzdAz1nGT0yW
         dZaDxMvtVnUBoBd91LK+7QO/vtnNtpe2lb9OCTtY3NwRxUSF+7C3fqJKPgPuIPZx9Sxr
         6iKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa1EpxIqw+NhjKa9ZQCVq8MbjlH5+7RGjr8qVYZYgYQkcZz2rwtmwxgJyjcNcSWBfIYKTN2TVco8xFjxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2bWFvlc/XF8MTz9zS3ycZpzGJwxlBEqJNY/2lUMJ4XQIPUlh
	aUzescY4JQeHCS9oVvpFggoNN8rr0CcLvjCpBmseU/iE+/uHJcGszAnZdSGP
X-Google-Smtp-Source: AGHT+IFowO/Y0UhQfMoOIpZwBhDDyIk9NSuWtDkqdrJ0UqjSry+HLN+SWl9bhFD0IPcxVO9bDJ72ow==
X-Received: by 2002:adf:fd0a:0:b0:37d:2ceb:ef92 with SMTP id ffacd0b85a97d-38061162d5amr6706803f8f.27.1730142541216;
        Mon, 28 Oct 2024 12:09:01 -0700 (PDT)
Received: from localhost.localdomain ([78.210.79.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1c69esm10314398f8f.13.2024.10.28.12.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:09:00 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Alessandro Zanni <alessandro.zanni87@gmail.com>
Subject: [PATCH 1/2] selftests/intel_pstate: fix operand expected
Date: Mon, 28 Oct 2024 20:08:43 +0100
Message-ID: <f37df23888cd5ea6b3976f19d3e25796129dd090.1730141362.git.alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730141362.git.alessandro.zanni87@gmail.com>
References: <cover.1730141362.git.alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make kselftest TARGETS=intel_pstate" results in
the following errors:
- ./run.sh: line 90: / 1000: syntax error: operand expected
(error token is "/ 1000")
- ./run.sh: line 92: / 1000: syntax error: operand expected
(error token is "/ 1000")

This fix allows to have cross-platform compatibility when
using arithmetic expression with command substitutions.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/intel_pstate/run.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index e7008f614ad7..0c1b6c1308a4 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
 
 # Get the ranges from cpupower
 _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
-min_freq=$(($_min_freq / 1000))
+min_freq=$((_min_freq / 1000))
 _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
-max_freq=$(($_max_freq / 1000))
+max_freq=$((_max_freq / 1000))
 
 
 [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`
-- 
2.43.0


