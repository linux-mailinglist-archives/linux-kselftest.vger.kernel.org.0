Return-Path: <linux-kselftest+bounces-5515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FEB86A93E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCECB28468A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3B2560F;
	Wed, 28 Feb 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rbJW3gxY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58925556
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106611; cv=none; b=O0gejjSdY2uPBMwIv1wyNlMaWggwbkiZobmqLFkLnBvZG0YhHTq7Uoyh3hS5im8GY1YhJrHfptIXbdZFnAbS4iQ7hHwKerRkEAhQ9V+kg/5BgjWmIoxw73aZsSSCehL3tz8A/m7wZf/I96vzrIcbwRDhWOdAsxEqJnOUDsLjV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106611; c=relaxed/simple;
	bh=1+zrWjbXEpGix8B8TOUMdQuIRU6vG0iCbRXUuvEPx3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvgHpIHlFiRlfhLyOpWpcqVhOn548yqXUvM3gngFZJKPvs6pDWUijxE+f2GBLzDa9I7kaOJOyHzEF/4x9dabfjR/hN6/aE2FaNAi5WyFNwpkjSDc/Vmoi3eRWoI9GyRrPogd0WKmVGgLvuVnDgB6DqyW30XRYyjmlcny6aZhnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rbJW3gxY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4129ed6f514so26899895e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 23:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709106607; x=1709711407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69329isM2KLBgHiujos32u3Mmd/l4PUw7PD3OY7XK/Q=;
        b=rbJW3gxYnjsDu7fDz2GtkqAw9ZscTapPZBPkTQR8qdh1mQaiS7hamMGXWAVcAKVdka
         brBX5EC0bq4Kt0oyukEoqGFTso+4o4xGbRX0PKgd8cUpjwiY6F4p9RQyKQVAR7t/UIJq
         dcOZ7B8zHbpHnwxZETejn+U5NraEMFGY3Hm44TB6TTDILIDVa0JJbziuNase9aeWy+sJ
         cA8krRRssQ3OWzLiPXwaOoDEEDeaSiRCDwuiIQZdLCs8Snq4To7EHrZgHB/zccCSni9R
         ivMBBiAIk4/r1k6E7OtqFsuuIJlqrim1ZNGjfmO+Z7cM4EhbxF/iKjNkuq4c3k5rsvUR
         U90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106607; x=1709711407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69329isM2KLBgHiujos32u3Mmd/l4PUw7PD3OY7XK/Q=;
        b=oAXlQlJvQMZ259GkknF5SBomE+JkLrtRywGbly0aayk2N7iC6c8Ja6Iv51hdzqoQYM
         /C9Y/DDkEmyJEI7+2RLdqIGf6oE1dsG2gUuxoJ0DXODRevxQAomTwoM6C5+hk7BfVeSo
         bW7/HuIeXs2mhS47jNtSpg5bBzf0HW4r2IzCnc2JngDcTj2FHOUkdbyKrn32lfmhsh8F
         7kmIrV1bXcU9bdcRJsMSAJBrSCZMKSeX49eOcXNgLn6OyxXs+6SD1h6ofFqOT2gBAqXK
         MydX6niKhynTqCwQ3cU2pRjumpmz5LuFbn98LYrO1g6BYdZ6/06Y9s3jKai1N7payZBL
         qnrw==
X-Forwarded-Encrypted: i=1; AJvYcCWNJacFZHJf1u0xA9KmEERnx3SFRohBFgSly/nDfzJ1pvNMiUhiHLqtUaPjdHTxfbKHNjBgboFB5+HetqdW7epaEc+Z5X4g8vRDBkp1hllG
X-Gm-Message-State: AOJu0YzNblF1z3l5CFU2dCz8iD9sgp6CJOqdybSY61Q8tiUVBWyBZnu2
	aweL1P8+UfZ2AL8UM/XNjyKfom3yxlkOyCKTH2e1CUGHw0nLwFFkXmI6VovP2to=
X-Google-Smtp-Source: AGHT+IHs2sLDJ2y36wdXVJ27jJkA2L/ykHYqCvfszDBeXhMNDGsixj5PcMBqZhA9Bko23I9xlaRSHg==
X-Received: by 2002:a05:6000:4012:b0:33d:d82c:d5f7 with SMTP id cp18-20020a056000401200b0033dd82cd5f7mr6483420wrb.59.1709106606910;
        Tue, 27 Feb 2024 23:50:06 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4b83000000b0033df1f1dabcsm3875348wrt.90.2024.02.27.23.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:50:06 -0800 (PST)
Date: Wed, 28 Feb 2024 08:50:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH] Correcting the spelling mistake in selftests drivers/net
 testing
Message-ID: <Zd7lqr8Cz4XrNoI8@nanopsycho>
References: <20240227175513.8703-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227175513.8703-1-pvkumar5749404@gmail.com>

Please fix the patch subject to include appropriate prefixes and
rephrase a bit like this:

Subject: [PATCH net-next] selftests: net: Correct couple of spelling mistakes

pw-bot: cr


Tue, Feb 27, 2024 at 06:55:13PM CET, pvkumar5749404@gmail.com wrote:
>Changes :
>	- "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
>	- "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh
>
>Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
>---
> .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 +-
> tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
>index 616d3581419c..31252bc8775e 100755
>--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
>+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
>@@ -869,7 +869,7 @@ bloom_simple_test()
> bloom_complex_test()
> {
> 	# Bloom filter index computation is affected from region ID, eRP
>-	# ID and from the region key size. In order to excercise those parts
>+	# ID and from the region key size. In order to exercise those parts
> 	# of the Bloom filter code, use a series of regions, each with a
> 	# different key size and send packet that should hit all of them.
> 	local index
>diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
>index 7d7829f57550..6c52ce1b0450 100755
>--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
>+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
>@@ -49,7 +49,7 @@ for o in llrs rs; do
> Active FEC encoding: ${o^^}"
> done
> 
>-# Test mutliple bits
>+# Test multiple bits
> $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
> check $?
> s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
>-- 
>2.34.1
>
>

