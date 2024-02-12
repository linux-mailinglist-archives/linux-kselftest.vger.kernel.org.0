Return-Path: <linux-kselftest+bounces-4531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCBD851E0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 20:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7107C1C21B21
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD04CB57;
	Mon, 12 Feb 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g65SeKUI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C684C61F;
	Mon, 12 Feb 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767027; cv=none; b=Ym+ul62DbDKpLmhVjSVdgOIVblycF43ME7H8BQeEzCiUjdNaIBwbGZ3PVbkRalt8R6BLHQ0I4jutXyT2LVznJTpB/MDNkLI6b+VgQga/Q5f3epvYq4RLWMGjP9vFKYnoz133EtOurqz1uMQEdmbUtzKh59zxyM/7g0BUotqpW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767027; c=relaxed/simple;
	bh=8NjLdLZGYSTfZoJpc8zfFGwf3RhBla0sf8Mk3cizRgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3u8+S20vSRWfnYLO9DEQCEhQJDVA7OVOK/uofRwupmimt4WyuUmKqT5/uCQWfODROBFBZRfn8d2CkkSGSecpHABgw+hGDbWozxsgdkNH+c2FYTL8levLB14Zbj+YVdJxu/yBG0md3x0uptrWIZjSIFlkPXA/bQBAiKFs/B+9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g65SeKUI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511490772f6so4436166e87.2;
        Mon, 12 Feb 2024 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767023; x=1708371823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szLEne8dk3CvpXCYVBedEJwr7tcaDdWjuVgZysah37c=;
        b=g65SeKUIWcbutn5lao6eG1K+kDcha9s9onraLgqkm1eHx3iWQ4q8bPOidmajXSkF2H
         9DzfCtdK7BUxS6Jar0cuaJL85RSBGPHP1/n410+n7tiAGBGCJ1LALu+7WQCwCfIMyGOQ
         OkgFZEAxEmVmcuevkmZn5JJcBfQjJb2oTYOAQXnRPIwQHynFym7WSMxC0RBLXWVw4TFT
         kHdcOzuxgm3tyAhC51Iflq6wsSja/EO3A2YFhcahOArd7Dgqmimap5Ahc/kj7rtRTJE2
         sUMKQpYCuWdvXWFvgMfVeUzsM+6qWgmBM2oTBBqdzoRpf/zHuV2vMzpeMmdgFFUsIXnT
         vRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767023; x=1708371823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szLEne8dk3CvpXCYVBedEJwr7tcaDdWjuVgZysah37c=;
        b=fJo7e8sWa7cMS257FRl6FpUMaIxfBE2VhlflNK8eHryzmbxIJqNEWKUTHQfbIp/Yy0
         Cz5FRYVEzDCOTkny0bgmhZJDWf33SHhVE0UwD+0ihF0PoeY5kLxom1JkzS2MGN/RGj/p
         2I8eKy5K3xAVTkDcXSsAKUr2OmyDbQL4UVjbLrAyiRnR00SdJcY8UBzYulUVo3MBUmUZ
         G74j3KhMZQ/GLUqvxj8QV9dh9P1oWBbETA00cYqo2P623i2pfhxgvpTiHiirg73cm/e6
         cPOxNzJQ6sak+chyMdo2x6Vl5QUNSfY4bnCeW9k7Bw3Hj+r2Fxg8zjOZq9VLl1datHhO
         35aA==
X-Forwarded-Encrypted: i=1; AJvYcCV4cPZDImZeDnxYmYK3VbWuTL4Q1BjExgfiprPoq5M4fch6F5+137ukJHZ3WbsUFbfZP/PCozqIhmtlG+LupPv7ioPgo6zugR87s/Z8
X-Gm-Message-State: AOJu0YzjGJE81jxwLkKJOY2Vl4mCQvPB/JSs+UnKvXyD/J8CONS1eoqz
	xKpdlYIxYHm126Pk5tbp+T8HUc3593OTYz34h5ZKwF0eW58loMYYvl8jHuyBIeWcWw==
X-Google-Smtp-Source: AGHT+IGK044jQrENs6iu1m1lQbDng4kur/ujq0w8sAqaEdG9uw9ii3DWUzE/YE1PwW5R9MwXQpGDQQ==
X-Received: by 2002:a2e:a70a:0:b0:2d0:b644:57ba with SMTP id s10-20020a2ea70a000000b002d0b64457bamr4318612lje.35.1707767023419;
        Mon, 12 Feb 2024 11:43:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7Q/eWfCg3+4dsADtfwBzTb+hcpw20Nm30oHQ+rXaCNKv5F6/QJLfLHOK30J/WbDxawFxvGP0a2pNHLxtcXdJLDNf0F/4GTaVwh62STs7KYevXmo1lR7j5WAOnQA8BO3c7ihJljfj0emt61i3gLp9pYBA9xWhWx+s2NzKLWRWhpUPJtqjY3cOJQ8ZF8lScVZfc5ZeIgtYCtoOCi/B8z9/jBFji5hQF4ZtymkdVoZ/Hhe4lQLeibAD5NDNKdjsEoIcx
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:42 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:39 +0100
Subject: [PATCH v2 4/4] selftests: damon: add access_memory to .gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-4-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=636;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=8NjLdLZGYSTfZoJpc8zfFGwf3RhBla0sf8Mk3cizRgc=;
 b=RQbbdMfYd5+1Ea7LF9i9Ek8b60WTUXImPXFGgW5Txc1dS67V7ZpnjY3bIsKAkN+AeyhKJ8hw2
 giNFEmE+yjqBS0D4lIFuTVkmAxAIBM7Vdl999TMk2/LHCuxqObyc7s5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This binary is missing in the .gitignore and stays as an untracked file.

Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index c6c2965a6607..79b32e30fce3 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 huge_count_read_write
+access_memory

-- 
2.40.1


