Return-Path: <linux-kselftest+bounces-4571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA7853954
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A691A2820D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C443604D3;
	Tue, 13 Feb 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWT/RMDq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F360DED
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847204; cv=none; b=kxmSPPr15gReNTTZL2VkMPjxLMIjwXblciiyzTlggni1oUVTgkxF1+xKyERqELqzJr8XakWOrFu2gVVOgZsJkC77zg5jp+XYBIg8OaFhEKsQMjxjRlHz5eQ6ZCs4Cw66vJ/KkFhqJg7WEjq7oshFH37T9Vz1iQNnpvdehbbL3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847204; c=relaxed/simple;
	bh=TvjXDcsy5GxF/6E70d0MCgCzpnXHT2Si5PtFYjTrNA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlmsHSlASD93Vj5kEqD/qo8C2aVYblDGQKZ+yXxt+FFMcNLDYq2a6bGDzYuBk6tJJ6PSgmzVDJMRqhcT4rvZmV4fOfCf4J6ZN09mjCOnKfJmpgXCgPQQvZu7rBlBxpwVbBafsarbmY5QFLJbuYGiG6UPi7fwhyDA+jeqbD/Tj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nWT/RMDq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e10303de41so570622b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707847202; x=1708452002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxPirAQpavIzKv9fMWeC7xfOqcl8Yk4GSCo6Uvejoss=;
        b=nWT/RMDq/JtrvTEFQ0SLbkQYiXO2QjKChZWsKosCG4hJCrRHtitOevB0a4Kp4msBxl
         IITMlJWg9FyjiPdkjYuxAcEZAj5g52DmJ7dTaOwrphttIb9e+hjumBNxEhygBPSJILTL
         EUTThuzU9L0E3R20s+AA6GqaGFhWtA0UCuikw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847202; x=1708452002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxPirAQpavIzKv9fMWeC7xfOqcl8Yk4GSCo6Uvejoss=;
        b=KmNDUjrDq16uu1kBpFKSZ9+xEPZQSMkaxt3GF1lC+uLW4ejDA3O9X4VSLW0isms02G
         CS8zGP2TY3/2YAfGRKDHHCLT26qt6PJ9IyBxpwzfaZhqFZiOXLSdJgeGVc0Wn68CzHeh
         O1oZQ/+bAtxId2E74Vpx5vZepyAOiPtZSO+Gp5Qibw2VqHGkEfVY/QuODilgM6KKX0YT
         CXIWFjayM+w0K6vWr21aw7Dsi8NrAvXKe/F2byOSWtmP9uKfu9Sws4AD5usWM8viGg2X
         iPdiG4TSZ7d3/5O5etXpIlqsvWPrpIzSmBhuWX33kSiB+Xu8EOu4UgicOsCZLWXos7J/
         XVSA==
X-Forwarded-Encrypted: i=1; AJvYcCX752fAOwcwvNp5K7K9uE/i9sw1So4E+k6CZNfoASAJpiaqLXSXomckoXFlvZzr80W3kBG9LUsJ82+bGm1kr5BlSlPnfe2+uSIf37kGi3fD
X-Gm-Message-State: AOJu0YwjNsOfKxsupq4RRUTmPZ+yW7W73YtiDMbq9JgeZN2A6G/FBRfu
	ea1Xw848VLSZNgl5qhXW8Khp4pn4f4ZF/5N60vi27nPLOpdlx8k205OLUycPPw==
X-Google-Smtp-Source: AGHT+IFnLU6I8dy6/mzsr4+w4iyvfY9n9S0mJzAYlStLSt5gXorOs8zcMVnC8H1qz5TR58WkeVd6fA==
X-Received: by 2002:a05:6a21:3183:b0:19c:ad6b:e1c2 with SMTP id za3-20020a056a21318300b0019cad6be1c2mr397959pzb.12.1707847202072;
        Tue, 13 Feb 2024 10:00:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5tRAPQjI3pcLl22D2Bu0sVo+xfg5ZiS9c2TWVZRy92+lZ2xiOSFl9jDvtsNeF3x+q7ElO8Q+DJeHOOB+vtK+bmi7Z/vnIYMoWo8vXgaHgc3SSn7+lTqI5aeKniRi6dQ/Ic54kc2JqEgC9ywlYyvpo+9BDx3Kr7pDhs2vNaw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y189-20020a62cec6000000b006e0d1e6036bsm5280122pfg.129.2024.02.13.10.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:00:01 -0800 (PST)
Date: Tue, 13 Feb 2024 10:00:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 0/4] selftests: kselftest_harness: support using
 xfail
Message-ID: <202402130957.7B88284338@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-1-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:12AM -0800, Jakub Kicinski wrote:
> Hi!
> 
> When running selftests for our subsystem in our CI we'd like all
> tests to pass. Currently some tests use SKIP for cases they
> expect to fail, because the kselftest_harness limits the return
> codes to pass/fail/skip.
> 
> Clean up and support the use of the full range of ksft exit codes
> under kselftest_harness.
> 
> To avoid conflicts and get the functionality into the networking
> tree ASAP I'd like to put the patches on shared branch so that
> both linux-kselftest and net-next can pull it in. Shuah, please
> LMK if that'd work for you, and if so which -rc should I base
> the branch on. Or is merging directly into net-next okay?

I would use XFAIL for seccomp selftests too, but I can wait for the next
release. i.e. I don't need a shared branch -- it'd be fine in net-next.
But I defer to Shuah as far as the selftest tree is concerned. (FWIW, I
don't see any current conflicts.)

-- 
Kees Cook

