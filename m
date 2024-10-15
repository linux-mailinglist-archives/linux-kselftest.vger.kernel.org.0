Return-Path: <linux-kselftest+bounces-19755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC8D99F397
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358E51F22252
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE71F76B6;
	Tue, 15 Oct 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD5/QZ85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CF1CBA07;
	Tue, 15 Oct 2024 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011613; cv=none; b=WHS3UwF8b5fKQXuPtQ4KafKv500BUwORhc2FzdXUIPenHpUe6qIMPtJrmDxJCv6oeC9iJC3XbDGtGMRD/x6FrZKVONdQeaPFWkQ32fE9GZhxjw/cAc6H2yU3W/OAYIN0L6WIQRQIX/k78NncA69fxvha8gDL3QrUHOw0D1X10tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011613; c=relaxed/simple;
	bh=jPUuNBI/whxJ55tSGXYnI3EkeTYkjHQ0LeZhZvBcLFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cOylJyGDpr/MIwltxERZAfHeGnYupSeBZS/dkZ7VbsG0qXY+iMdkgMRqxhEwUDQsUaZh62YYlcREZfnAoSZZ6wTckIh5MFYB/vjlgy+xBTZTybpOj1vcXaFld0tm0HJZtEWGFdCsF0sZ+tl8b9/lubWs4/gQKS0UxQ6x9VG/nY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD5/QZ85; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso4341159a91.3;
        Tue, 15 Oct 2024 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729011611; x=1729616411; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9lh7hyARAZP4q6qPs8P6NY/1Yn4WV95dZqTb86bOj8=;
        b=VD5/QZ8502eG5E/5yN4Zad0sT8RQG/laI8w11TDh9wvGZcUpAQF0BxyGhSX2cKVvdp
         jhryUYk79doqjVlcWOvHdNDWEQ8XvIkrNtLDWq/Jw9ydbRVBmF1PkXxq28KdLi7mVeVX
         WWyIi133Ggt1sXgM868X2QmRX2fmu10IJ+hbDfHRN0D/iDtw4t0FV0DPTiXzBjkeUjtY
         a0KtgzO0Ch6p2L+EuDGNZTnqLrUJdhIcdAFUEtMJn8sWrVSQ2Ix1gnv+PLWtdi4yAfkg
         I6zAwaqArOv2iqB34k8ycIzY3E67K7I3Qa7PJLUosr2/Jo6+7QuqdvtHJPHKk3NHB1nW
         mjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011611; x=1729616411;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9lh7hyARAZP4q6qPs8P6NY/1Yn4WV95dZqTb86bOj8=;
        b=q6NiDuS4phq9mWsPtsNFtJVjwyojSDXTERLSlw3gvhiLwf1SmdLe7xHAUr3YZ7zsvj
         mkDBpOaAp2RVRFOAgV/fqd40peYyYUILW4MpxqQAgMX/fRa/vQllb26C4vi52Rz7X4hz
         E0X7jAzhlIr9/YvxLOjP4qBBhbL8H730RaTtwqfeSJml9bfqQw2x4zY0EQuEOGaErKKs
         LB+8+ihjbgmmh8f61vibeF1nkaitEWssM9/1WogrhSZ3RVeG8op4VLmHiPipdZ7Vw2Xn
         apPAZbpXm7dzQVSigDU5neULHqwkV9QMFTkjJd7tePbtXsrkZLF4dmmXhbO5sgHL+PIp
         hJuA==
X-Forwarded-Encrypted: i=1; AJvYcCUUK1jQ3+zL4RNoe18nX88YXMe8JosQ4hqM5d/N8A1f5wwKL0t7Qg6vhF1hJDyH+hIcQ2vHGMV3jCYig6RJd043@vger.kernel.org, AJvYcCVHMjFn3PU4e1iYjQ0YtULH3oAplq2sFDsXvoaR0JiBE67TiVvEbN72690URpolXhL52WIaq/Gh@vger.kernel.org, AJvYcCWq21nckRKRMhFjCwCV8ZThE1GuX6oeWX6wcvM/KkYBza6ORIYsRm7xaODLK1LZgIlPlvoCA57y8hIMUfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5B6NX/P8CZDgxYTIDXpC09mBNRdwbe3NzRAKbRZdQpdyqqAB
	oTQrpin3teY0m6pfROJgM6gDY78Tdt4FA0uNYP4vs1QUhiiszQMj2Yf3OEVGUOU=
X-Google-Smtp-Source: AGHT+IFg7fvXeDxq5Co9V4uoATrN8h5A8c3gSeHjGA2GR7q2ZlFOSVf745htZwQE3G6NUcLjCQDmtA==
X-Received: by 2002:a05:6a20:cf8b:b0:1d3:e39:f69c with SMTP id adf61e73a8af0-1d8bcf0c279mr19846652637.15.1729011610550;
        Tue, 15 Oct 2024 10:00:10 -0700 (PDT)
Received: from Emma ([2401:4900:1c97:c88d:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f7489fsm2048527a91.52.2024.10.15.10.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:00:09 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:00:06 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH v3] selftests: tc-testing: Fix spelling errors in cgroup.json
 and flow.json
Message-ID: <Zw6flhHF50_4jT4b@Emma>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch corrects typographical errors in the "name" fields of
the JSON objects with IDs "4319" and "4341" in the tc-testing
selftests.

- "diffferent" is corrected to "different".
- "muliple" is corrected to "multiple".

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---

v3:
- Corrected the change logs to make it easy to understand. 

v2:
- Combine two earlier patches into one
- Links to v1 of each patch
  [1] https://lore.kernel.org/all/Zqp9asVA-q_OzDP-@Emma/
  [2] https://lore.kernel.org/all/Zqp92oXa9joXk4T9@Emma/

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


