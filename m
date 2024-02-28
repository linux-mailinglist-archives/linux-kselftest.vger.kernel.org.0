Return-Path: <linux-kselftest+bounces-5534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98A886AFF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 14:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905371C2519A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0D14A4C9;
	Wed, 28 Feb 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xHRF6XNQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612D1487DB
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125778; cv=none; b=nG+pKXrHkPLa0S40m+dGfXZ/2eamJsoj7hMOafwL2U+Vfeh4Py0JtG60dFXHA2CvPJbtjT/uF4NOix5Wn7DNK+LRyNOPeGAi5/uypXw+uDC0XiHhdH2WW+c+aTj86S+zTTuEl91mJNPiToK7uTU4kee0KWOG5vgY8id5U7SymeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125778; c=relaxed/simple;
	bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho+8JjRvKknYndy2fV27KSganGbT6xU6drZaghPeyGbUvGHwkU1/APB5CLeBAQzNL57JttWbSKD0vE0l/gBPSCsoPSJbicmCgrp2pgFexKR4H9OqxaVJqik9MjUdZd2skUldccuHrMucGOi2wU5Ogf48qYE0psojvF5pYWY9Jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xHRF6XNQ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d28464c554so52783551fa.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 05:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709125774; x=1709730574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
        b=xHRF6XNQAxY19zdHQdOUBCXhFqvg9nw0+LncpnZg/0WCV1tFKM2DxOf4CiqN0P15Aw
         bF0OlGn6NEd/eq0BmVJqfnCNKsMS6V2uTTYGp/mPPzK4lTlol24rUygt9M5lsn/OqZ1f
         hbRRklnzvqTyxX9oQGpjEY0/EfSee5cS8UHfRy9+tvpjeqgrMLzTDtVMe7ywPA7axsVG
         fivU9MKwltu8QhEUujK5P7fdWLynqYJAIE5Ovn9OSiTBVZrjVRRUGk9ey1990QeJmkTx
         gkKa+Zsk6KzmZMDLgmSFBAfHqOrPEfFHRlf9z6JOHuRoqymNhujXFiucULye1pVzTqY3
         RmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125774; x=1709730574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
        b=o9lCWV7sg5mMuMe5CAEjwtq+RpxabE8CgaivmXIf/biUnqjLlGggOEwybmo5l2bRvP
         uJ1eh4KMq3ND5p1QdDOP/DMder8/8T1tHyLEYDG/lfXtrgyg8FY1Xphn+83W4BZmbcK7
         h3Xpo2fRzQNIo7gynpJ18pHG3uZutL/hdrY4Q9j408X3i/eG7qDOrH3QD6edFpyhqKu9
         9pA4vkn139c2VI0QFmksyfIFueO+1+twg4Vy+65IqTX8JiWUV12OviuDYsTc/xbLl3oM
         xH2zx0kZVSP0guZxF2/L5MhFquE9/HS0ToWgzMgxAG0jCO4GzCHiVQnwjDtvPiJyFBRE
         BrFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1EOnbLSbAIObHO2rjjCHhHheUrlpOiwSy8WqSnARNSvl3evTyk0S4jMEQ45LUiN+6WN7q07GZZfq3ZNvG01cSDT06FobMzydwgBaiT99Z
X-Gm-Message-State: AOJu0Yz96LpxNxc2FGCpzE1caBcYLELYMsw4xCO0mxy0rdMlxt0d9RbN
	/9G5Q0KU0EyonDWKYqGIV7etlneVbBao6l5ODkbMM6bCFijy/VUaYqRiluU9s/I=
X-Google-Smtp-Source: AGHT+IEXjIeaqkm6aDYE/p8eQaQhxLsM4l93SBBtG4gumRuwRAuP9F46ubbWmhhXEYGUD/OSV2vyhw==
X-Received: by 2002:a2e:860d:0:b0:2d2:9b00:2289 with SMTP id a13-20020a2e860d000000b002d29b002289mr3237613lji.29.1709125774294;
        Wed, 28 Feb 2024 05:09:34 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b00412b0ef22basm2091407wmq.10.2024.02.28.05.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:09:33 -0800 (PST)
Date: Wed, 28 Feb 2024 14:09:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] Correct couple of spelling mistakes
Message-ID: <Zd8wirexgBacmsv1@nanopsycho>
References: <20240228115707.420200-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228115707.420200-1-pvkumar5749404@gmail.com>

You sent this already here:
https://lore.kernel.org/all/20240228082416.416882-1-pvkumar5749404@gmail.com/

I don't understand why you send this again. Could you slow down a bit
please?

