Return-Path: <linux-kselftest+bounces-26700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57EDA369F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 01:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BC81886E9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 00:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA198539A;
	Sat, 15 Feb 2025 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilNh8uSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EFF4ED
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739579062; cv=none; b=mVYBwl0faHLIvg7hfucnpl9Gj5rFfgRUNFM4sIfIfx2DDDmSA9uE+FHLrpM6NeXJlqUEh+T7PlVhNPnvyjJyFLfpWowrv0xG/us9ykxfCrSZYxT5nTghmSTnZrUu/dZ7B3JtqVbDVd3sVZ9YJJFlOKPUFKcXIb7QaLa4dj3P/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739579062; c=relaxed/simple;
	bh=AjyglJCWXCq6goJBQvJcmRlUYSdjpyO+9rjPr34OO0M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J9MTamUJ2B1cK5ay5fy1TL1RE1W8+tQnLu+f70cYzwK4loG0mX9YVfatgT7Yy4PrFoycsgZVBlaHc552rwcAkqxMEC1+DQPNO4klEQhaLp6JuoSq3T2E/XlsxQdZuFOu/iuPbojluFlDX4cdw1HuzlZwx67+ERYd5/oeGlTngyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilNh8uSl; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bc607b33d5so1198084fac.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 16:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739579060; x=1740183860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFHjecYD0TumMHxPOXYPdCr2G4EtJJFdINrgiBMiOA8=;
        b=ilNh8uSlV4KdkwUQ9sqgpTH5AkQIm6gPZd7OmNS+YcEbcfVV9fKFAot8w+fmer2xaa
         ws86QzKq55qU3qsWG+KHwbF00YU4ugks2Kgx60nB/FlxQgjfJIuz6ItIgpVw1q2SB2Lr
         Vau/CRnrPbEiu8/a0elrtE6hbS0Z6dGjPcsVr2fOMyT5qYzp5p4GJtfMl3fY5nWYuh4R
         +EhQbbvtP7EzKtr0DFkUnJPEcze2NLwJlnWrJnRGnLgJoGWDb4dOTejl4h0CLvu5pnOU
         wE0JHpB4iomQC2Xxt9iLvghJkL5iReebLb1xLGQrHFYH4HvxeNI6rMDxPz/zy1p8ztJV
         1APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739579060; x=1740183860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFHjecYD0TumMHxPOXYPdCr2G4EtJJFdINrgiBMiOA8=;
        b=U4jEeqMRPDQWRyXHXTh1bXfXcuBCIoLYZJHeoQI3hFIVJYVEkEshw0Ft7GjyHfnix1
         4LWt1VjVmezkjsXQio3db+MF0e6iE9835IVwZzQd3xI7EEOOzyZFUEhZEV1wRiBav6AL
         ati43R3h5PzR+8YNj7C8dwqaPSOdE6QAH9JI16fQ2jN4b/494aRbGvSl38r3YmoNEL9S
         PLyYHQJkSCSZ53PwPKkksiW8USRzm3ncUJlJ3e7mBYjE8BIkenl5KSTa2vAIn4DedTNx
         h/uoSGGn6IyMX1g8snvWJKo0Qg4fyrLGDCOIhNzV8PcK0DvVRVR0IquYxLV+G9l50ZD9
         asvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgfvZs2caDFfF/x+ZbHE5cbKevmrvixEa96nx2xrB3Jlmg4VXhZfmnSKLXjJ4gIFSXF5p7F6w77LLjJKYCEGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmmldc2smtTFoYsoIV3fcDMWKr9STF3SznyhM8WFzike0tqDl
	05nJeT87AZB2We3FbEwTaed5a5gU88WLo0PGjK8HHI5qhJqXu8EO
X-Gm-Gg: ASbGncsu+szVgTm4PgTDYGodW8d9VcziF+e1vH0fwV9OgR+g9hoQHcYgCw4Hb/kDYLj
	ogEa4id6o1PnCROsaudxXUz6H7F/9mWYdioT9NvrlMVItPvsFhlsiBheaaLtdOyluj6Z6oFhvro
	d/0SHiFO3g4j96jhAFv4HrD8rPeBlGuFPNNjwhTjclVcYCWQ0jIlAdunt/JkdAcF0jhtfCKUIWJ
	D8Q0HFbYHZb2SkIEPq6YjjYcjwwZODu+qw2iKP2nu5C0454CPzKnfDy5KIn3tB+nr9SpYoe0esp
	AQpK
X-Google-Smtp-Source: AGHT+IH89pZHBlD3ryiV+QjKjWQhmf7QDm1o2329s9oeb0v5UWJQlau6GOPaW3E5sQMrsiAwntAaSg==
X-Received: by 2002:a05:6870:9b0c:b0:2bc:7797:aa95 with SMTP id 586e51a60fabf-2bc99b46631mr624011fac.20.1739579060048;
        Fri, 14 Feb 2025 16:24:20 -0800 (PST)
Received: from fedora.. ([2804:14c:64:af90::1001])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95a7b5495sm2140018fac.36.2025.02.14.16.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:24:19 -0800 (PST)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	martineau@kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] selftests: mptcp: connect: Use more formal wording in error message
Date: Fri, 14 Feb 2025 21:23:30 -0300
Message-ID: <20250215002415.1465504-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update error message in mptcp_connect.sh to use a more formal and
consistent wording. The phrase "not able to" was replaced with "Unable to"
for better clarity.

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e3c56253274..bdc9c22af6be 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -261,8 +261,8 @@ check_mptcp_disabled()
 
 	# mainly to cover more code
 	if ! ip netns exec ${disabled_ns} sysctl net.mptcp >/dev/null; then
-		mptcp_lib_pr_fail "not able to list net.mptcp sysctl knobs"
-		mptcp_lib_result_fail "not able to list net.mptcp sysctl knobs"
+		mptcp_lib_pr_fail "Unable to list net.mptcp sysctl knobs"
+		mptcp_lib_result_fail "Unable to list net.mptcp sysctl knobs"
 		ret=${KSFT_FAIL}
 		return 1
 	fi
-- 
2.48.1


