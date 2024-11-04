Return-Path: <linux-kselftest+bounces-21390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FE9BBB47
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F471F2061F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007951C82FB;
	Mon,  4 Nov 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXQVaENg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB621C07EA
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740598; cv=none; b=F3VEc9LdRcxVPOfNW3V6VATGBgJmTphRoLOjXN7gjKsoRjHAtAWZ8kEZEtzI47ExZPoLRaEHFTS2az6gyhAQNoPkbCSzF/EVz7bjYZUvCrp7dSmOjw3ti4VdRDcZ9Seimc0tcnOGI6l5IhVsfOo5Mfg6+YCkd5pdlQzTUxRDsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740598; c=relaxed/simple;
	bh=Xirldkcby312bseXyHXIkJ6yKbI0ywDaWby/Unv81r0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V/l7it0o94rgfokIyMUWN3hrqPuou/7lh3eVebNVpwV5/rz3S2Hi4Jq7DjjZLnJFS2nUWHNOI8M+ozNrD27Hgza7++oAUmpycJJJkwIiSXq2tqML/H+OQe3ZwO6w8EnWuLJQlFgLtbs6k0A5h+jwJBguiYnv/3SjYu1kC422t20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXQVaENg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so2913642f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730740594; x=1731345394; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mz7FQ3FxnnjD3yMz5V8+bY6+RD8conEDHBBPgd6Mgy8=;
        b=HXQVaENgAVzvQgWpn7ZcVjuMSOXxRnEMlJILh6y0RHh/yLbezKeIjanQebI7+8j3V/
         NtmPDK9WpBysKGJo58jxb9VTvKhECTxYRlVKRGH/JMym6guJZFbdx8cCEQp5hhIvN1Hx
         YfcsVn5422EvdNvRDxopAZnbPdB9iTt4lH6FTq1PF0tWY62gTKVGoQ88wnDhYQLuVN0O
         pJA5cquKjMDsC61oo5vfbpllS6JXNAextNcBwrIFoS+5Km1bzvoiTd1AozlGmKuf9J8d
         GF91j7kSJOruSqhsX5xm8v+PR8uWiVXtRk3o7g1zhqVv6/Vmr1nSKjWw9TMBqr7cZzUj
         9eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740594; x=1731345394;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mz7FQ3FxnnjD3yMz5V8+bY6+RD8conEDHBBPgd6Mgy8=;
        b=I2WUJSCNcRpdZqEgVfxsmVwH6TdqBxlznHN8+U2Yyh2rSl2gZtUKvkXt4GrieXUUFH
         ObI7RTpRN/durRKYU6MsQjo1nqI+uZE8T4ExkWH/jzEXUpnHtKAqvyThxZWHnr7XuZcA
         AVQNDvNhT3SfG6ii31CQu/zFOKqXMEUvZ6RoYAw51gKHyVzXz+sF51rwOB4qGymhqRp2
         43LpTqtCL3LsPUemDOHw2DJLa6H9jzCWsks8vGsh2mXxV9+lUt/kEQM886xjYLEL08ul
         Nc5uYFjq3JbC7wUo+OQ31aXSECYlYkMWOZ+DPzEVFbVkptIS07wgGIaaynnQIEs+A6xC
         /AWg==
X-Forwarded-Encrypted: i=1; AJvYcCU49OhIEMUls+UDxSAV3ed9R1iob88RzJlZTmsVQEPZ6ql/qJkbaKwj8aLBD+PGNY0ne2kJ+nvkqmPgJbAJqXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xzb0axXiUzluJnQsWhJkFJ23nTmSVx6vP8GPEFYnqfQQGKko
	dCsG4fY5PdLyrkPMIwjdxwsDkgp6XdkIRo0yhLhQdqKnXZs9q9qQenmjcDDvxbk=
X-Google-Smtp-Source: AGHT+IFSQQnkPJQJ9lUk8DLV1jIcd9nJjuwaEO70oN3T+acz9855Sjh80aCcaD5StAd7TvhDFC8jcQ==
X-Received: by 2002:adf:edc2:0:b0:37d:4ebe:164b with SMTP id ffacd0b85a97d-380611e1252mr21410333f8f.44.1730740594471;
        Mon, 04 Nov 2024 09:16:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad3fsm13604311f8f.95.2024.11.04.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:16:34 -0800 (PST)
Date: Mon, 4 Nov 2024 20:16:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Benjamin Berg <benjamin.berg@intel.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: skb: use "gfp" variable instead of hardcoding
 GFP_KERNEL
Message-ID: <57a8d38a-6299-4d2c-bb2e-c9d1e3bf1c99@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The intent here was clearly to use the gfp variable flags instead of
hardcoding GFP_KERNEL.  All the callers pass GFP_KERNEL as the gfp
flags so this doesn't affect runtime.

Fixes: b3231d353a51 ("kunit: add a convenience allocation wrapper for SKBs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/kunit/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
index 44d12370939a..345e1e8f0312 100644
--- a/include/kunit/skbuff.h
+++ b/include/kunit/skbuff.h
@@ -29,7 +29,7 @@ static void kunit_action_kfree_skb(void *p)
 static inline struct sk_buff *kunit_zalloc_skb(struct kunit *test, int len,
 					       gfp_t gfp)
 {
-	struct sk_buff *res = alloc_skb(len, GFP_KERNEL);
+	struct sk_buff *res = alloc_skb(len, gfp);
 
 	if (!res || skb_pad(res, len))
 		return NULL;
-- 
2.45.2


