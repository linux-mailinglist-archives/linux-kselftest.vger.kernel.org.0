Return-Path: <linux-kselftest+bounces-14563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF594356A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A771E1C2155E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712A288B5;
	Wed, 31 Jul 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHi8WS+7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CEE4776A;
	Wed, 31 Jul 2024 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449264; cv=none; b=IsvfPnhKxBK+I9RfLPpydmHDh+M3uilaM7wMEnDRI9j0XBecdXOKGCm57LyV11GgHGU6qeXEBt5KbbAx3VfHgrijYWJodNTgWA6LwKgPqsevklxEkT0AEtsH50tZZuMz8yZCqKIFe4Y6PTz38v1Goz4Vfqah4mWX8F6QF6o6AEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449264; c=relaxed/simple;
	bh=wlwyUDdk+glkVmWzVpN0PT2B/PBZ8qoo54dvMQfFCMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f70EmKBGFd7x8A2tUfS4kU5egZJ0DPwcZiHiMuN2raOVjUqOI5Wf2ON500ghwN/WCUkPDJbEkLeU+rCqeaisrGsf6Pa9daN1DA5/edeCJlR9U28aHcWs3y2fYWgEfLg/bC8tK+/qs6j4PRcxCAx1oT74sbPyJOF/EZ4En5UihPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHi8WS+7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7104f93a20eso813943b3a.1;
        Wed, 31 Jul 2024 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722449262; x=1723054062; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/z4Ls39b3YeZyEIMdUMB9gw4yNYyChcTS8DQMKP+kM=;
        b=OHi8WS+7rRMcPxa3A16wU8twb3GJIMT2N56VsxQp7yD4W6Ir16gBCBnRw3X3qfW5cZ
         /xBvPYr0XMxbJJ6PTN8Bim7PVebPSFilgzovCaFA60PJzl7jGT822XBXSn4Y6oXxz974
         aEQ+2RptNMTieZWPBdp+vOmx+3xYAM2cEjZtm7YgPJIHuGYxaREjyVlZwKnCHB9W/xSf
         egszlyIImuQxM4iooZmW548bsOZHcEl+Vr3KZXxkS7E3twv411Mzh21nC6fSiKhBF2AC
         0/JLpC3uExiMi+BI6ddqIVPcBfP+8SywWB0pP6/9fw/mdPw70O8kDLzG0n52TfnwICzf
         MB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449262; x=1723054062;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/z4Ls39b3YeZyEIMdUMB9gw4yNYyChcTS8DQMKP+kM=;
        b=uggxZQ6hzq4bAYvViNBZXgKpugvoYWXs62y8UMpG5aDTOrmuFnA1LVdRPY925cPv11
         PEWw4J6abzwsJlF4gtKXSUasTeG8Y8ggtyU4EJ2j+BUIMJ+5i7Gz33onrCZDEYg2ummM
         WEWHEeCCzOSFwd3KHe4ITPh08XZ66YcawBDb8kA3BhBUennE5ziX6T4NS5TGMnCIMjrt
         tb0TWiUk8vcpNzVuCKD+Kygagj1Bv2y7IyXzx6GQVF+yS1X+0uD71Zd3z6aEwvlP/f34
         T8p/CGjP47IIcc5x4C48xG05Lg0014TBC57z9GtXA01n+iQfKMg/5FHjPDbfBw6xEcsg
         oFrA==
X-Forwarded-Encrypted: i=1; AJvYcCUw58/jdjlsGtX85EL8qBDLbydQrwA8L9QIiHVusloblMXhTr2RBcmZ/0hb4e8dcRNKfzyyNCnlf7hw8Eg+2ABuSaT30YKNWJxttbGRkG4TXtagJ22e5X03bj0UC3S4+Qnw74e/DKduKuhti1qxfi3RAJAuC/NgNSqBSzEJK6sw38qSEI8y
X-Gm-Message-State: AOJu0Yzujy8f9vJ7byThERzjSfGHz8qA+XsD3YBJOgn9slNgs8tqPdB7
	1SIxygxwqg7M+yeCVENrxzrQiErV/OyV8+aH9zoP8vCrcuoJOwlT
X-Google-Smtp-Source: AGHT+IExHjnuHIHhiKnfD7PgAec7VBsRU/u68Qc66aDoay96q4LeW6baWuHjfXc3EkVbgRtFJxRB9w==
X-Received: by 2002:a05:6a20:7fa1:b0:1c4:17e1:14d0 with SMTP id adf61e73a8af0-1c68d10d77fmr273276637.47.1722449261896;
        Wed, 31 Jul 2024 11:07:41 -0700 (PDT)
Received: from Emma ([2401:4900:1c21:dad1:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead86ffabsm10585931b3a.143.2024.07.31.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:07:41 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:07:38 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	Karan Sanghavi <karansanghvi98@gmail.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH] selftests: tc-testing: Fixed Typo error
Message-ID: <Zqp9asVA-q_OzDP-@Emma>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Corrected the typographical of the word  "different"
in the "name" field of the JSON object with ID "4319".

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.43.0


