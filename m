Return-Path: <linux-kselftest+bounces-15071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222C94D047
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 14:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AA61F22379
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CD194A40;
	Fri,  9 Aug 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiRELPhf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E51922E2
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206760; cv=none; b=C+TK5fSaY6lvABKe+3Qsmcn0eOvzCtwtBfzR2qhvKd2JzO7bXi0GCV3W2qXfK7O8Y63h/TU3bjN8c8f8/+pPL2ZiW4O1HuQSSKAdczLkDBlL9hvPGBlYo7mkK4XoR/voC19gP36zytvEhECA+FfPK8JqOMXTI7sgh/DXw7iuF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206760; c=relaxed/simple;
	bh=QNcaoqLsaVCec6Cy7SIaExvsGVbtIi52cpW6p62gqfU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tltj3q7KidTZtt5Eobm+ZhfpWvgQTeA/R/MiLXqFkmw9BBxhHW+slcgeW36a0HRqb1aG4gJpiJYNaYIUBNN++yNB/rX7B+4dU/hZRzGB0ur2o+BGSeFnoxic6dQYuGfwLfOYsqAhWRN7eZP1LMBSMmSGagkJXpqcyevOmZxmPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IiRELPhf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ef95ec938so2116280e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723206755; x=1723811555; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XEvmrJApAdAdB8IUGlSUXCcZKgELg0TXzRkX9FYQA2E=;
        b=IiRELPhffhyMMLf9Mkhbx5pVy7wSrrlRl2m5A7RuUOv8hgePIATFegZEYow0ytnnl6
         3V4qbdwEmcwS76zXHfVbikZCgIMxwEm+v9T2g4hpTaZOOER71xh68PTrfVE2J6TQBcbu
         i4pPUAVNsPFyIIelLvbmmLcariEOS2P+f4JZaWh7JeiPu5Zl2Aha7HHQ2hSXq3GY5jSU
         EoJC8kysXtJEOVEFwu5iGGOLLklOEnMv7yKG4blbs0VpdNegiMrYJKKqlyQga/iEjQWh
         Nbh6gXXEnAdTR2q3eYMKj7DyBvYMKWh4ufZIRgCe9UcEaY3Oe5V8kd7WBaBp0JaEh+TO
         XOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723206755; x=1723811555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEvmrJApAdAdB8IUGlSUXCcZKgELg0TXzRkX9FYQA2E=;
        b=Ov8A9vphXvvnnoErVcrfq9bb8fqBmPqcAPK5Aq5cl0CgUByADTkqv4SIQVQpsruS6s
         v3WyymkgESw0lTXk4/KfQjM1Y3PpHZXBYcmiy2EgAtbCv4JO1csdCxfVFl0K6duYw6ta
         w4wx13NcNBwovkqCVQPrubCvmQwj6KvLo4qUaIXFly5oRz4rXrS6Y4cjzQ4q9P2l3LMA
         8GIv8i3zqyCQR7EPugtZ7joPgh/7mvHPrdn569a/y8ZCcABRsZNoJzymrlk87wLCToPO
         TIEo9csTzlgHD5x6WXQDaqmRoAvFR9Kf/ONy5gu1HL6kjfFMrqv/uOQR/7I+bnU5dRev
         t52g==
X-Forwarded-Encrypted: i=1; AJvYcCXtkVImVlE+kgSAMhKCdh2EV+kUo51jNkTAZyaMtPCZLsS+OHOOwLLCjoXVDmG6FIUDphDjdNGlCkL+eIgFar0jeH6e2SzSgAxRv6bQoeN2
X-Gm-Message-State: AOJu0YwZuHIxCnl23LLO3iui/7kLGlwPoSwk9jLlzo2TAbuNhgPk/onP
	I2XbHvzqO/3i9Giwuu8yj6YIlZZin5HG5FugGbUg0U9xOZY0LUNBBAeXvw5k+pQ=
X-Google-Smtp-Source: AGHT+IGzPu2doVLDNZ6syQ8+456inTtlzazWj4IP4I0oNXM1Sz9cwjKQLoWzh+mGsvT5bHuN4rBo4A==
X-Received: by 2002:a05:6512:3b0b:b0:52c:6461:e913 with SMTP id 2adb3069b0e04-530ee97436fmr1248689e87.16.1723206754996;
        Fri, 09 Aug 2024 05:32:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf8666sm1495151a12.9.2024.08.09.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 05:32:34 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:32:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] selftests/mm: compaction_test: Fix off by one in
 check_compaction()
Message-ID: <87470c06-b45a-4e83-92ff-aac2e7b9c6ba@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "initial_nr_hugepages" variable is unsigned long so it takes up to
20 characters to print, plus 1 more character for the NUL terminator.
Unfortunately, this buffer is not quite large enough for the terminator
to fit.  Also use snprintf() for a belt and suspenders approach.

Fixes: fb9293b6b015 ("selftests/mm: compaction_test: fix bogus test success and reduce probability of OOM-killer invocation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 tools/testing/selftests/mm/compaction_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index e140558e6f53..2c3a0eb6b22d 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -89,9 +89,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	int fd, ret = -1;
 	int compaction_index = 0;
 	char nr_hugepages[20] = {0};
-	char init_nr_hugepages[20] = {0};
+	char init_nr_hugepages[24] = {0};
 
-	sprintf(init_nr_hugepages, "%lu", initial_nr_hugepages);
+	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
+		 "%lu", initial_nr_hugepages);
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
-- 
2.43.0


