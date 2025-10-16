Return-Path: <linux-kselftest+bounces-43276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF543BE1643
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5854A486DE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A92205E3B;
	Thu, 16 Oct 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caIVXEoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71BE156F20
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760586819; cv=none; b=dOeoMGQRdTTtaHX1ixscVuiv9wAV0DdRz2wR2tCy4lva/R9Ht6rQ7EvbqGe0UliDPY6YBmseID5RqS9rEn95RDtz1eB9YDa5BhnmJs32GgE6GAJRfLzR1QjCCqlkJX7tPl/oqeDDoF0tMu0fIvEsUTK1cvJo+GQX3VFU2rT4DdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760586819; c=relaxed/simple;
	bh=+Bi0k7yeEVhElVYsr9bEFjVbio42J+whEdTcbqgJylY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfIanjOqtD4/gyfoRNmjcxAfpT8KEQ24gip+i2Vew7pCIU3kESWhJkrNvElRWNBz6KEWkKQQ5Lqt+Xw4JqORXGgGJYWZ5UbzhaQxlVCi4wFm6uUfESM5OCRqThMh+/1zMQ0f3kW9bzmDH5ftdIIPy7hCz/Dbg4dfeuyIzru9BrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caIVXEoP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-794e300e20dso1325950b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760586817; x=1761191617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjH/Xk+Vw9IhbcZ1lknKGKFAYoqovFnR+/YWG7tmcfk=;
        b=caIVXEoP5MWayTqnL+Mr1J4qxOaPiRdidDy2At10CWfnKdI9njcVZVtLN7Hk20A9m9
         VQNCR+pw5aM14/Ty6UpG42LoAyBSU3DPhAMu4uWRF3yvfqDaU5Fv5rXCvGaH/orznudO
         7PoeM7Lm6wRY8NdEF9xioiXQsyb1xOCRg4hxttcNFCIjRb9RJfqHIom8nkJZB0bEsoA/
         meTdJIbNgcwOGVh3iOyCC/I0o0OPMyZOr9zJggPeZrepn/3+NHC1t/PuC8w35qt2Skq0
         fMHHreFkw8rvVbOjnjCLjY3S4p02REXTsKiLwhQiq9RPW+AJ9KKX/i1t/A8EKVGJ62RP
         ri/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760586817; x=1761191617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjH/Xk+Vw9IhbcZ1lknKGKFAYoqovFnR+/YWG7tmcfk=;
        b=jMrgtAafwajbv3ncUvh5symu58VhKGYbBmefBl6GRWP+CCQutSy3U8+h5qarewvsaE
         ocCTpZvbqe9/ReSMAPTwRJ2WxJr9uwA8V3T5wPif6orkUlbzTUt+RR5fx3dTcmc8iWxA
         kzfiWpn3iC5iukZ8z/GhD1C3V0ipjD6mYCN30WcFDBeZaqU/QM2Qe/h6XOVkVjJDfnjw
         SvLTvcXJ4jSklb3j/ZT2cEc9gFy9kl3esUaPXcitg4/goqRnTA7nd7sgELYsK6r0acU1
         v7T90NGQltw34Zd0cWweRVx/EumSz7t9PoHfftlvSBgIXuHXg/rbWZSNU+8UlUOItg2x
         Gsfg==
X-Forwarded-Encrypted: i=1; AJvYcCWq5+VlhYBxcxeED9tMdsiA8dSv0EnGXp95N8KRo9sVPkCndUJ7o48VP267tF7ul6fjt+0hK+wE3LK9ucA696o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+YpVRAcu5MeeqApUl1u8Aj7YbMtGvj0vb89TNhtzN+5MLNe8
	Cu+o7TQw9fFR/Qt3fgjWuJACJc16H2kNgTjsQvEASKQ7yEQlFXUQ2OEiFKCB7UifBZYggA==
X-Gm-Gg: ASbGncsbPfmxEgnm2y4R9iV/IYkuWCoLjLrUvkAQMeD1egeRBEY8XWxvKExxHC4/Os+
	lsmtXPUl6KM5fxedQyoNf2Gey8Ef1gOEVXBrCbzR8jHMwfV/EnQt698K9PVQmeZMtOQi+rOUDRe
	sL9Zq79aEcHCpr/35VJ98hy6RJWuabLNk6JG8C87Q2T9UWmudRAnibJAGvBYc26uinGq/7I6XPK
	l3rDFZ4tsy4xUzj0FThEtjdWRluMK78B0qCe4zVLhclOMxAk6oTK23MRfcNyzAbGuPBu4MfXDG+
	mvfKq1v6euzwlKlVUJdaGaHtE9opA/aXyzPNDvTINBYKAjA7hu2RLPNBbklLaaKEvViqPEcvMTi
	Q3J+MGxAJ04auX+WpLxPj1qXfY5VDIaSPmp6VOlpfDdTob/xRszMwp+CvSqNwD2rDRCaI9vg9Fj
	bESpjUSDUyHfi9A2WG5q3R0Uw9AgTET1fCAHtqQ7dGW0GcskzjhA==
X-Google-Smtp-Source: AGHT+IF5L3KREyHjFSPQncpJROTSoshms/ZTe2ibdM8WJ0gkfy/b4DYL+CIu7RSZ9C1y3z7bKhMfXA==
X-Received: by 2002:a05:6a20:938c:b0:2b9:6b0b:66be with SMTP id adf61e73a8af0-33495d82c1dmr3487745637.14.1760586816941;
        Wed, 15 Oct 2025 20:53:36 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6632e72sm16065a91.19.2025.10.15.20.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:53:36 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	higuoxing@gmail.com,
	linux-kselftest@vger.kernel.org,
	olsajiri@gmail.com,
	sveiss@meta.com
Subject: [PATCH bpf v6] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Thu, 16 Oct 2025 11:53:30 +0800
Message-ID: <20251016035330.3217145-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
References: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_parse_test_list_file writes some data to
/tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
the data back.  However, after writing data to that file, we forget to
call fsync() and it's causing testing failure in my laptop.  This patch
helps fix it by adding the missing fsync() call.

Fixes: 64276f01dce8 ("selftests/bpf: Test_progs can read test lists from file")
Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index fbf0d9c2f58b..e27d66b75fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -144,6 +144,9 @@ static void test_parse_test_list_file(void)
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
 		goto out_fclose;
 
+	if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
+		goto out_fclose;
+
 	init_test_filter_set(&set);
 
 	if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file"))
-- 
2.51.0


