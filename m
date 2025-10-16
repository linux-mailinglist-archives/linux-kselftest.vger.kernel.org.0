Return-Path: <linux-kselftest+bounces-43275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB6BE1592
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D040544A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 03:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF39146593;
	Thu, 16 Oct 2025 03:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIT+NX43"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BA15D5B6
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760584771; cv=none; b=nxegEdVBBGyIHMKrTpgFOkN809vxxO7UzFGIC4Yg5G0T//f+2opO0ndqU2XzGOJZDQLEwEHAQvaJ+Qv35dxukcjmJqQy1g69eZRPeTvGH+4+/0PibaZTEtQ3HbX7WhhVXw7/QCXCDmq/2tcGj9iV0SpVv2K+sLfBkJQYQQL3ec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760584771; c=relaxed/simple;
	bh=g1nKlbTESNDH4VVUn9g+7CtmZGgAzIVfoPUIFApydxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7Pr66F0mUpLOK6gDIMzmo7GLkTkdyZS8ao39Qd0JHpvgWKxFv9cy3Joj9wUFiLIJdT7Fjk1D9UUETqxa67T0lVU3oDckeSaPvV1eH/ARor5eshXfAnWzjFnlP42fh/Wb7aS7Is9WSjtEIHMXla9tV2PnmwZ4il/VkK5RidfGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIT+NX43; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33b9df47d7dso416813a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760584769; x=1761189569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bx/iQgFty+Ih9RtA4OkcRz4bv15d/JUq+vGVdq+OfM=;
        b=MIT+NX43C7e3L6D9Ft0Qcs+BOjba5ZfDtz7p8eJA4LuJ2/drPEnyuGRhaVvIiaxzBd
         YdEVAcw5lY0BhHLl60q5v/qZahvJ9GTjhI4E81nLiZa0gT4lirxbSB7yxjAUOpFxAPdL
         BjvqjAfD/s6wmTsLISQpkHfampN9X5PfoexHa3KUnvr6KjZU0zS7XmanroiqmT49w/D1
         H6lh199BZd+ldP9wt9/vI/4lM6wgpO/nfSaMdF1ssbGjCnTsYkeQF/+Yml2rrDZ0Z8gl
         OAsvWn4mfGnK2+hbJYmCSEzdMCrf5aP+DPSQAH9CSERTncpxAuuufE2F1RlMISUau6ia
         fPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760584769; x=1761189569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bx/iQgFty+Ih9RtA4OkcRz4bv15d/JUq+vGVdq+OfM=;
        b=nlUO/YfwVnLz6F4NDVVrD5UhVLm2kZRWSgmxyjz3FAOoOzPUN8KiYALqRDiiFQbgfd
         dxLnXyjTOdnmrMJQSzDWeVGszOSxg3cGC92oEakW/faqK68eAM3r8q9lpfYQkpWrlOp6
         eW/CMvkabiSU5C2d+JHz/eXk6NrNHgdqmy2bHZBfC88VUcfcJ+y3UdX5sy5EBPoY/diM
         0MRcJTZmJK8FiRJ/Q+dF5NfggVyr/A+d+Hj3UFKMgftm6Ro5yUKbaXe/3XEUgmKR7VZ3
         KtsLP9fo24Zl76C3GNRDWNbPbju8iVm3vNd0M3VR3qMEuUmYEw5RyQ8J4q8bajdCAHW/
         hrbA==
X-Forwarded-Encrypted: i=1; AJvYcCVSg29jwJ/iTU7c7zoIe2unt5+fhjCJ0M9AM1XhdlQUHg16J3YVO8gjiRN8BDjEl+fD4/shH3WWnVhuhgCK0ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxohxzYAIJLTE4hlutFwTi/QnIqVZDjkZHXJZ1HPlsNtDq2JrHc
	HqeOaju/iwgmQj7XQCZDoKM+JAHishQCxP77QjwVv5V7QxTAsg08XO0T
X-Gm-Gg: ASbGncvP4rS41QcE6AujQdVpRIaIHraAh4Yv6sYI14Y0LsH9lL+ZSmrhciZVFjZzVuG
	h/RMtxOU9k8uhy2tj8Faz35ILIyfSio9wHruHrABXUAqBeX5C0g3BU5OY8lTEBvKb1OH5E+POCO
	MyFDOHsfgoyXMyYbhRcyrnulcmafFxkejleigWinkvlor7VISGsSelWd7M9vBAbY/YstlN4GRaf
	Nkk97BH5ZvytbfoaXZeezpIk5Z50UnJBSaYZAwfM4LxNYSDQY4rH/JcAxn5uM4vogS70MeU4kdp
	mjms1hS7lhIwH/f2lALoftUBFMuGSX3FJZUQwF0OoXiSM1Ityo1NOqSJ9Y+8BsVsaR5M/CGagVg
	oA7eouzdn0B6A8F7ZUUPnOVdsdwTDRJ99uQaro5DpUXQ3wYYi9QC7GZ4XCu9fEcVzD6jvdZKjUH
	WYuaoHZ3P6AvTaXDC9U5ce29q/VC3D2RqrREx6NSY=
X-Google-Smtp-Source: AGHT+IFGgrQQezuUmj3bgEqlrU/M5qvpgXc0yxELz/SA5/yvCJAwWZGvoq/U4EbOgHCFzOpjKLISKg==
X-Received: by 2002:a17:903:2c06:b0:24b:4a9a:703a with SMTP id d9443c01a7336-29027373d80mr426369245ad.17.1760584769404;
        Wed, 15 Oct 2025 20:19:29 -0700 (PDT)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7de45sm11916855ad.54.2025.10.15.20.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:19:28 -0700 (PDT)
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
Subject: [PATCH bpf v5] selftests: arg_parsing: Ensure data is flushed to disk before reading.
Date: Thu, 16 Oct 2025 11:19:23 +0800
Message-ID: <20251016031923.3169221-1-higuoxing@gmail.com>
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


