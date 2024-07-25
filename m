Return-Path: <linux-kselftest+bounces-14242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B416B93C6D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 17:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD28283DE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B119D890;
	Thu, 25 Jul 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fi6Adv0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487A18028
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922644; cv=none; b=gPcjSfgIaSbu3ldmiJPmayyqbsAUJp39CHaxC9gbimc9OhEGJi/7MAQbg5ykLya3eo7zcCa9FQ3Hsby1vujlJg9Usu2qx2R/+PxNJIi5/BlCLAxJDqrsJ2vztZaUG5DX7nmjJwnA56zTqLpOS/7WshlttKEdZiAdSsJAIEzGd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922644; c=relaxed/simple;
	bh=6m3+FHyJ+AmEj6vS4AHygVqkSGsQfYiClcdMM+4uSyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZCY8vryPB3uJ7MmQWMGNyQcx8rrIoFj6j3iOR39n5U3mWt0kbAgOGRLN023KsHu9qojHDLC+AaN3zxP+bqXURF0ps6jQh4WdO9IeWLhPSxzD5ICsH4d165rbpXMTzvA2vbJu3bXcbkI5uY94fuJSLdU6wg1oVUXBqUDq/g4r/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fi6Adv0j; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81f86cebca3so2324939f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721922642; x=1722527442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aggvme3xKg7i4TrOmjlKCfE2kTRYsrbbuWQJNB9R3qE=;
        b=fi6Adv0j4YkmnIp1EwDxq4rYgTiWkMrxjWtLDifUIAzv2yuDE81xAyZ0YAWtibzcli
         oEjVzB3bMMYMcrBK/9ucZAenHI4+vl7RefU+GJ3nyXeah+akFGuOTGm88mgwZ3YtwyNt
         tfUl/pC89H+FaRYfQAFCG4l9o0vCZJmUrq9Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922642; x=1722527442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aggvme3xKg7i4TrOmjlKCfE2kTRYsrbbuWQJNB9R3qE=;
        b=wzHsjkgikrakH50I+Wn+ur+uLkANpN5NsPfEL1a4ZTak/j7yUODZpj2sSSKiiLDrmK
         Dts6UDYgLRg7n+bjoAd+ZvRCQ4xv73hxrCfD/EBkDuKZ5tyZwTMtTSTEgwOg1zlrsGM3
         2JkXMm1T/1LbK+Dle169rJD20ukT9ptdsUDMCpUyC2v3tTCW8opxQxOQM+najb6k/2kJ
         8KI+9Nz0Z9tSkPT6v4SAeTHC6q/0CL5Xm444f25W6vqu2fHhpIurSxbhpJ5bndiN59hG
         0qxVAvbC2bC4Jp40rqLO8gOjgxwV1xLxFCrJ+zYCBmCrmf/wjcrZJ5z1vs6Q43H6Nhu3
         hjyw==
X-Forwarded-Encrypted: i=1; AJvYcCW32g26VZhJwz+PvXV1OadXoBAcgosVzD9a5tcNxwjyLzGQrwK4/0uBMtwHQ9MIGRa7z+TLppyUllU/fDPHP1/UIJPE6wRuZKPHQYj8tW6f
X-Gm-Message-State: AOJu0YyPQZshOla4s391Kd+xx/3C0xDVVKn6o3Qw9R157xIiJ4ZqNQRw
	AnfnR4XEE33/n2ya6QNY05efK3+WICKXQhoCLkOLWtnkljNj+4W5g6XtUemtkY8=
X-Google-Smtp-Source: AGHT+IFEHsFN0I8fUwEQhH9FG5DtAKwnOj8OaKgLxrdAaSfCNz0gvGEdpltGEFJdn8E7GWzFxI4Qyw==
X-Received: by 2002:a6b:e810:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-81f7d016818mr216157639f.2.1721922642214;
        Thu, 25 Jul 2024 08:50:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fbd9b8asm382241173.108.2024.07.25.08.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:50:41 -0700 (PDT)
Message-ID: <65c59f75-3810-4490-991e-62b5aafe1f5a@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:50:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] kselftests: Add test to detect boot event
 slowdowns
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel@collabora.com, kernelci@lists.linux.dev, tim.bird@sony.com,
 mhiramat@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110622.96301-1-laura.nao@collabora.com>
 <20240725110622.96301-2-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725110622.96301-2-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 05:06, Laura Nao wrote:
> Introduce a new kselftest to identify slowdowns in key boot events.
> The test uses ftrace to track timings for specific boot events.
> The kprobe_timestamps_to_yaml.py script can be run once to generate a
> YAML file with the initial reference timestamps for these events.
> The test_boot_time.py script can then be run on subsequent boots to
> compare current timings against the reference values and check for
> significant slowdowns over time.
> The test ships with a bootconfig file for ftrace setup and a config
> fragment for the necessary kernel configurations.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

I am repeating the same comments I made on the cover letter here as
well.

What are the dependencies if any for this new test to work?
Please do remember that tests in default run needs to have
minimal dependencies so they can run on systems that have
minimal support.

As mentioned earlier take a look at the tools/power/pm-graph
bootgraph.py and sleepgraph.py to see if you can leverage
them - bootgraph detects slowdowns during boot.

We don't want to add duplicate scripts if the other one
serves the needs. Those can be moved to selftests if it
make sense.

I will review this once we figure out if bootgraph serves
the needs and I understand the dependencies for this test
to work.

thanks,
-- Shuah




