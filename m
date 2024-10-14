Return-Path: <linux-kselftest+bounces-19665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A799D4F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 18:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAB0283BBE
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFBC1AAE02;
	Mon, 14 Oct 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORuyyX+W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57314AA9;
	Mon, 14 Oct 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924611; cv=none; b=KDOeBWnEbaOpxxiFHXyvQ7Gid0sCcuIj4vAfVlzlPYWRfWrhAwyh6Ke6Ddz+3A5eN7xHzWxts3/k11BeFF1PgiznXvnMjAMsMhv3RieM5Ld4sOCDdTqQElgssueXMs5UVTu6YrfN6DgxLGLX3HRx5R5+acRlcJvhN7y3zaUKPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924611; c=relaxed/simple;
	bh=PHv4z0xumvLIMKuvR0UiwaSEIlHhagU1gIkwblkg77I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OcTNX2e26x6zqIR5IbRGuvZ/hSZ0FROywYp4NSGUUy1GkkgRI9Ssmu1jA9fakM+AnxpG1LekHfgATwDyqOkF/mPwSy2JeFligzn6dmj/06ub7ZLMg6nMKYvh0Fucc4pcL9VhyNt8PGXVxb9BdAMlRgsc/TK4+zS+kI1LN0/0k0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORuyyX+W; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e6f1a5a19so480105b3a.3;
        Mon, 14 Oct 2024 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728924610; x=1729529410; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hF8DDbV51nUKC7lXOLJQ/Phz5F2FSROyTD24YcvrCo=;
        b=ORuyyX+Wq+eimFHUUOVoJdQs4HVX6Md2/vhRS8GcIGMG5nEMVM/L239AYRFDCSIHqC
         v1tuZsch09vx5rETFDCuj626P9LqGVhtTjk7r5+KEEexZPuMOXaotNFPc2P+GOw5/GgS
         IpFN9GPNQrQ8m+VJ/Ai2Ak5HMKE3wkccr9UTX3FuVNRG5ChF130hs7m7Bn9kfTt15tvo
         37p86l9iKFEHRF+NG80Q94pMPRqjiKqPOxTndIqiRTzOaR8iRqg+czXU8iSpzcptpcYK
         JDpd+uLsH5t/FHUUxH+K1OxVvS/Mrz4p4VCx4EP4/YJECVCHBVodZNH3v9Z7BzJbu0ik
         /xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728924610; x=1729529410;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hF8DDbV51nUKC7lXOLJQ/Phz5F2FSROyTD24YcvrCo=;
        b=WH6wPez15CSfZd1idHlPV6tFQQIb4wOIn8G6mpfYCIUmYMZrP1rxDG7FG6BrDk2hrV
         NJoaaqvwDNAwK9besQMbNVy7q7R2eYE7IWtBX/drSSb1WUfyqB4hNXzfmr95MtgZ7D5Z
         v6qSZaYAusLJpY+KRle+lJ0of6IHn+y1giCo6m5aS8umV+TFtzajCmjxnWiQjFNHvmC0
         /WOEZ0O8vNMCK5XYG6z+Sujtz65fD3R+UaLPQCmM1sGxupNdwoE04B6+VSDCc1uwvq5C
         nI+bkVM2J7xkdx7l47zD6JP6YbM4yuU18XR9RGhSKZZ7+KUWBLSzDXrLBfKxUMcUdKha
         BLyw==
X-Forwarded-Encrypted: i=1; AJvYcCUDqXwpxgm9nevuqr2RGsITVD1BpM0PE/xzltMogeakmYsaHGOteMKh5KMbM3OXSa1uF5APfquD@vger.kernel.org, AJvYcCUOSP4wESwkBIrcCmlFZHxf8w5nhZHPFESTenAeGdxxbkAuNedvGku2Os7f+TFW+23XEIGWA0a0CG3lLy2zUAN2@vger.kernel.org, AJvYcCWm3TL5t1CxROTBLzOZnyZqJ9+yM8X6MWwJ5C6QW7kNZzEaYK+8qmm7eCtfrhYF0fWEk13t4/us4+gi1yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgYh784gso/507g9C3iDXBvur7KHY64pQJ+FOY1pcPaE9s8Uv
	/XMGwztv5ijcy5pN5XjB0bKxw+JoXrA1BDXsp+SGuOd73yHcddVB
X-Google-Smtp-Source: AGHT+IFAdAbQDL99HEFQiwO6fQqydkuUmIyEFAHSNXx9Nx/vW+qmdXM3Lf30N5cERh19QJ2e+y1RTQ==
X-Received: by 2002:a05:6a00:1829:b0:71e:722b:ae1d with SMTP id d2e1a72fcca58-71e722bc2dcmr1622921b3a.25.1728924609588;
        Mon, 14 Oct 2024 09:50:09 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:4540:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e584b31fdsm3940212b3a.178.2024.10.14.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:50:09 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:50:06 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Karan Sanghavi <karansanghvi98@gamil.com>
Subject: [PATCH v2 net-next] selftests: tc-testing: Fixed Typo error
Message-ID: <Zw1LvrSdnl5bS-uS@Emma>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This commit combines two fixes for typographical errors
in the "name" fields of the JSON objects with IDs 
"4319" and "4341" in the tc-testing selftests.
For the files tc-tests/filters/cgroup.json and
/tc-tests/filters/flow.json.

v2:
- Combine two earlier patches into one
- Links to v1 of each patch
  [1] https://lore.kernel.org/all/Zqp9asVA-q_OzDP-@Emma/
  [2] https://lore.kernel.org/all/Zqp92oXa9joXk4T9@Emma/


Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json | 2 +-
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
index 03723cf84..6897ff5ad 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
@@ -1189,7 +1189,7 @@
     },
     {
         "id": "4319",
-        "name": "Replace cgroup filter with diffferent match",
+        "name": "Replace cgroup filter with different match",
         "category": [
             "filter",
             "cgroup"
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 58189327f..996448afe 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
@@ -507,7 +507,7 @@
     },
     {
         "id": "4341",
-        "name": "Add flow filter with muliple ops",
+        "name": "Add flow filter with multiple ops",
         "category": [
             "filter",
             "flow"
-- 
2.43.0


