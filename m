Return-Path: <linux-kselftest+bounces-14564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544C94356D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCB31F22219
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C8338FA3;
	Wed, 31 Jul 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtreXB/j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06E3770D;
	Wed, 31 Jul 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449376; cv=none; b=KQgSTLltMWoUNQAooOISpH6p4oEO923ibxr2jCkVsMT9puUc/9dNpdmUQ0awIbKSzjkk1h8fo29ctGEYn0wt8ivkst7yOmqv04NGFPiKx37ROBwRbEGCj5UIhe2wAjD8hqzXJEZVQhaa+OzWSffGZZ0silfTgcc67op1QAu/Z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449376; c=relaxed/simple;
	bh=+tO9g9L2kBx3wFBFTyrxQNSW3TCfdQXSAaaTBY7gbBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DEU3J8RUUJ6mqLPzlIdffivM61MEXy5IlzQKYZoiGamfzTqr6cCXNjh72wg4VL5blz3c1FB6YaJBAraGzGU1phb9unvuEzq3X/8jzDYcgzgY+jsTT208Q4CjfVAGHoUIyACZaay5jxylgZJw1HuJsUrFANRSm+g2rvfjze8Nez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtreXB/j; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-710439ad77dso1607945b3a.2;
        Wed, 31 Jul 2024 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722449374; x=1723054174; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9B7FTSogZvKG1GUiNOFIrybGpdZ1TpYoB5i1w0+9j4=;
        b=HtreXB/j9DSU7AeCN80HbbnxIqINYLvWZyoFa3hUE2nG2DqTl8bPwz0JC1gKIzUNsQ
         5tG9L8c12BwlKlmhhz0iDK1N5COYG9Mx1yjlTs8lvrjq/XlONVRN1nDlQrwcARRks7Ww
         ebpbayvt82UPvPPYuzEA3vN8vKL3alsz6mx7vG2E8Bz+xA5iLjkAGOmHEaSWtIA+Eilj
         s7By1Y5FaY2ldMHDfI4bROCOIsI2JMvJQBldHl87hQSD+1cfw+pXxvKnygxHyiSstAL6
         /dhCp08mKkWUDMr6N2ZkuwHQzmpu4dpieN4LZC2GBpQCFx1WTh4ynP5/09HJj0V8TBEI
         k+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449374; x=1723054174;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9B7FTSogZvKG1GUiNOFIrybGpdZ1TpYoB5i1w0+9j4=;
        b=NgyZrbrnenMKyTH/SrNax69dEzZjlKCbEQywRIQWyWDvole69TRwpHBeV5+MJS9It5
         9zJW8zD8gpBpT54QvNJlcm3s4hNif4Qkob8IVcJj8BrtNIfq/NrjCV3XP9g7n399rKni
         TuhJcKjiHvBhrYZp93nDPqMPL6Gm4GIsTx5eyuE5b8diLAAd4gYG+Q4ww0xiZwDPdaEY
         YCF5lSzVhfgmiMqFMzMAiTP+S0TgWm4HdNGh7BlN7iBFsGOywqcGbE606aHZ4eBPVK9J
         K3+s1AlF9EC6P0arlx5jgz32hKPicdJpIcFVOAY9dSiZ3G/wvWmS7xGomxebQ8pnFEXW
         /J4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk01mCbAh/F9m6MaWceJvHvU/pRh0ifs4fRti+NcukSxW1MWeS8iaoA8wDnnwZ+zAmKp4n1aTf+e+aLsI95+hqniX0Ni2Klp7BOJn2UYsDGG55dhvZXUecoD+C2LvJJFJqR0+VGtcjpvDPrAA2fBjkwCxf1xtO8Q++8p/JSZ8PqlHbtl/J
X-Gm-Message-State: AOJu0YxNPD2GX4/oHFGU28UiWgnRtcfFSj0HZlEOOSZp0eSccheuNmHx
	WUed8mO5Jb46eEDRu21WjmWznxb2o9p5LGz/5AY+6ncxnKLuEd3m
X-Google-Smtp-Source: AGHT+IGGQ7HyaEN3E+hgFI2gsXYBEGWSOzDhQEOOfuL3eIh8e5pDZgsp9pMRLOHO5/nKPGusRF2/vQ==
X-Received: by 2002:a05:6a20:d80c:b0:1c4:c879:b77f with SMTP id adf61e73a8af0-1c68cfa53femr296119637.27.1722449373967;
        Wed, 31 Jul 2024 11:09:33 -0700 (PDT)
Received: from Emma ([2401:4900:1c21:dad1:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8aa702sm10188333b3a.215.2024.07.31.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:09:33 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:09:30 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	Karan Sanghavi <karansanghvi98@gmail.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH] selftests: tc-testing: Fixed Typo error
Message-ID: <Zqp92oXa9joXk4T9@Emma>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Corrected the typographical of the word  "multiple"
in the "name" field of the JSON object with ID "4341".

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


