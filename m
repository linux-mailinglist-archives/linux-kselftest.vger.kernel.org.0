Return-Path: <linux-kselftest+bounces-17446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D4970438
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 23:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8117AB21F23
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1C167DB8;
	Sat,  7 Sep 2024 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcGsGKpx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8521547E8;
	Sat,  7 Sep 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725745902; cv=none; b=JazgbxHuTqnOJEid3xHKXWfpHNsrjrNzWSIhs3qs0vZzfl53wH4mfc/2NVtg8V/iThhtVZJ41gWNWES0I1GVQLEzkdrzxdMKppA+/Jd66ek9uNI7t5Lvvickd517Ck7/RGMVQDFIVIiaMl+Z5vbgcnfdLFpy4kbfmFucUADmz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725745902; c=relaxed/simple;
	bh=/jTtqmIgtCI8j73E8E4tG0WB17dOg2PuIMXjYTdAPzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMdHR8WVNbEIXfCBcZ9d17UyazvnfugEyG1oHTm4+EmeP/yrStpWxClt9NPbSHWa+JGlvhaEn1hDRTLRNzlMBLy+5eWApHetTSnitmuPCLvIQegXzYlRYxu8s+VF6T9R/hOK49Lyv6ZaEGU8F4yJic7NzIXmOdayh85Iy55WUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcGsGKpx; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e03f0564c6so139354b6e.2;
        Sat, 07 Sep 2024 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725745900; x=1726350700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFNpcPMN6Rr/ohJnFWcKwtAD5AOsKybuMMXx3ZfZ94s=;
        b=dcGsGKpxpGnsBpCHVm44GH8QOgvDZ3qIkH6yk6JYIFenc90S2I+DPjFk9sBJ4STJFD
         hZXsE1/5lX+E4BJpC4dSnJrKySZ4TwDaVR84PDUl6nq4pEy7t2Imyrd2wpTCoz/l/dq9
         1APcrUxnIkpqhV3XHI60puXNaXB8MsZyFj2NmrccYOkYqENplV6rIpczizS/vbLoW6xf
         PGGfIcHTVHGu7Rp3KeJd8afz1STiaC6qPUnNlgyAUF+eqQwMqbAoNEFtry2PSdy5EjZN
         5oKQqrr3buknOXpH02QbcHYSpNBEGg8p2+454QSfmgR6f37QVfFN7DtUkcNd/sH00dhp
         +3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725745900; x=1726350700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFNpcPMN6Rr/ohJnFWcKwtAD5AOsKybuMMXx3ZfZ94s=;
        b=Tv5wcZRbkZvJ05Ps9RPn4Rc4wdfHLkh4RirCYjr3Hm8cZRixMmc0/P9E1xXEbNfuNn
         NwrcK18QRmUv0rMjLu1E4wZ+CATmMXHlCB6v7YDxgj6Mw0AwjlpLmZS6qMNqwtTZ7hXy
         y6gcjf7AzvbJGmmak5TEx2OQngcIYgxbh6Dp8x+VPZtoJnOUb+Q6KrKh9ulxjXznvK6P
         VbEzRajHlRwh9ick+v2QdxIQBWQvdxnj7geBI7bTwYNa3KnNnMNczxWOx8CDhFV3Wc7t
         MM3Q/+SgyoiLnMrLMGGd6OJmLxr2kMjqz7DyDgebn3r94HSRMCzzsvS6rcwB+yqZKsHt
         q2GA==
X-Forwarded-Encrypted: i=1; AJvYcCVkWGc3wZnJFmFyJ84l3n2Y9Qna1Vcsy81Zk5auo+QoHppfSxqKaz+n3fU5nkN9psmKFo9GvlLG@vger.kernel.org, AJvYcCXA7Ar/UNsVQ47hXI34XVWBd0NLQh4vyladFW4bdYla5XjvjBSoEbPc1XfkOHZq2dy9UosMoES+ZCKWhRPq@vger.kernel.org, AJvYcCXFibyU/8kSQPI9FCggEfzHzJeZR9000mFnPRLocv1J7vvVhE7d+m+kdC7t2ykcx+4Cb76LevUwJrjKYOUIOQ7L@vger.kernel.org
X-Gm-Message-State: AOJu0YyshAh2+B2K/QADRn2yEfEkehOidYz7mo6d/6xkurczKWHsso/P
	OAy8NGDkt+dmCSOmXgm3McfbhGHRAn2Yy0GM9IESHpMBpiD2gd4O
X-Google-Smtp-Source: AGHT+IF/VnbIjg7W8gxS+2I8gfDPYIT4yngOvvLIAxfRYUpUx556W3qejE6hNnrZ3iH2grG7g49j1Q==
X-Received: by 2002:a05:6808:ec7:b0:3e0:1299:4dc with SMTP id 5614622812f47-3e029cffd44mr7102574b6e.25.1725745900546;
        Sat, 07 Sep 2024 14:51:40 -0700 (PDT)
Received: from localhost.localdomain ([49.37.215.122])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e58c6a8asm1274724b3a.80.2024.09.07.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 14:51:40 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Cc: Mohammed Anees <pvmohammedanees2003@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kselftest/cgroup: Add missing newline in test_zswap.c
Date: Sat,  7 Sep 2024 17:50:48 -0400
Message-ID: <20240907215051.26029-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review, I have added the changelog as requested.

Changelog:
- Added missing newline to the `ksft_print_msg` in `test_zswap_writeback` function.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 190096017..7c849d836 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -351,7 +351,7 @@ static int test_zswap_writeback(const char *root, bool wb)
 		goto out;
 
 	if (wb != !!zswpwb_after) {
-		ksft_print_msg("zswpwb_after is %ld while wb is %s",
+		ksft_print_msg("zswpwb_after is %ld while wb is %s\n",
 				zswpwb_after, wb ? "enabled" : "disabled");
 		goto out;
 	}
-- 
2.43.0


