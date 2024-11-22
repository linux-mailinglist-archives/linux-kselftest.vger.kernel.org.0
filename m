Return-Path: <linux-kselftest+bounces-22439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77A9D5ACB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BCBCB23D3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5A18308A;
	Fri, 22 Nov 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHz9BAUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5217107F
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263190; cv=none; b=ta3PqcaNMtyjPfdrnwHZfDHb8oGC03mVfiKy285vnha1C4IJhBZ+0V/vkJMJbeOJqm1Mrfuwg2fUTvth8E71blGqXBwfb1SCmKWZt3QQphMqXVPlDDa0Wkxcn+lgq4OzF34BOEbjmiRtz+L88NAD26lKmN4GT1+fGHg2+fjWGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263190; c=relaxed/simple;
	bh=2cC5+ylqaAyXDN4/QbFBkSVRcxQfIpjqqG260ixa/b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjLmpN1zIqzbJ2bxFYVTCP6c4wBijat3xH1Cy/U9BcWqDnfttlY6Eq6nwxRhc0kJM6nZD9qY4q/NPnRclP3rZyz77uAoit9KYm22lQOU1hSLnGiLwVgDZ3s1MZ4HnBYbJsnL/n/DLVVAvbk4FVs657ieYBa6luWDwjAgpR5oT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHz9BAUu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1258016a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Nov 2024 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732263188; x=1732867988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtiM7FGfMA/9Bsc4nOUQdU11ZmJTmqiA1GxS7HwsgKQ=;
        b=dHz9BAUu7Y1/Z9lGnVDXwT5kPGIgQN9zzr0YX0ulX23DdNsDgflpvYzURB5zkwbUL9
         77ebqswHThX2nFRVc8bq8lUtAHMuME18CqIb7W/eA9J+Sp6Yx3rLp0tjiUmiMv/bJsCP
         P4LtGPuR7PgF9BufivCB3tGDYa7GY/vrkdLW1LA6YTPLe4lMvduezQQskMXTAg1Z6uFw
         cnPGwUOnttYFxE+ULLbAoBs3jmL2s5ooJgKcwnrBC5cCiLS9ykJzgA98D7rLXfuDXtZS
         wzpfXvHzlEsiSjpdItsNJ71xwcx9MPN6lK79zIGR36KInb4fJfkl+w+ik3eq3kLhcaLG
         5TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732263188; x=1732867988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtiM7FGfMA/9Bsc4nOUQdU11ZmJTmqiA1GxS7HwsgKQ=;
        b=otv9bc5tl514UjggSyhDYGPcu0gygHhddH3DJAGa7BnmPMaoagxvzJgF7kkD+jO3XJ
         H0BEjHbJqwAba5IhS8V7mAWDcmenNMzRm2nGRK10lKYTCRlLG6FctmFVxu4ewcWGn5tP
         CxpRDWRNwbho+ENVnG6NUY3C/zcpOib4rfh8WVTit03h+VmmEmolDf64OOIXeO3EaVdZ
         Um+3u2ds4x9hlPfu+FTtTTvft+UbDEF+SS/RFPwoSGwL5lfw5WwfGG9Q9mjo8JHSg2cL
         IyldQilxbszNqUGrtXJi8vGAu7AYV9Wzt8BV060io7JZRyJwqodVCDWjvzRK54R/1y3m
         tNfg==
X-Gm-Message-State: AOJu0Yw1EmGVmC/67SFQaj0v2DpftmVX0FY02sIKqUMUeTfLRfc0kcNY
	fzHOl/Vcea6y9YUlbUhOmrIO7up0ldRIDfxI16AGZ7aCazIOGUbKnrS+FxrxhU8=
X-Gm-Gg: ASbGnctnAYnUbE2hAvkThhI+DP7/XyK3vjv00yaw/KGjKrkbo3PYMTkEK3e3Zwv+8ed
	EjuotQwpZ2jm0Y195ntylDP5O1THAIfRp/W1zDvlzaf8lTPq4jKTH11FupNC+Wfx42kBWOFDvF0
	Nv+pAC4yUBz63SS/DD8LUiGPbZA4sccjAE3RrabIqgZ1kBQpS7PjVgDV/B7jgrVUvOYEnUnc8YB
	be3zvdHiokjbP9I01B1lEvJpWjoBo8mgRA5UbjIHZHjb0UjMiEs
X-Google-Smtp-Source: AGHT+IHev06k9pGAl1nqt+OQo9UbIc+5qm1amkYSvGMCzvONl7a9WGyQtu/RSPc8s9vIp3SP7KWhDQ==
X-Received: by 2002:a05:6a21:6d88:b0:1dc:3023:bd97 with SMTP id adf61e73a8af0-1e09e5da6ffmr2314612637.41.1732263186820;
        Fri, 22 Nov 2024 00:13:06 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e2490sm1064181a12.31.2024.11.22.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:13:06 -0800 (PST)
Date: Fri, 22 Nov 2024 13:43:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH for-next v3] selftests/cpufreq: gitignore output files
 and clean them in make clean
Message-ID: <20241122081304.j2zbjvmgd2nnfca3@vireshk-i7>
References: <20241122074757.1583002-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074757.1583002-1-lizhijian@fujitsu.com>

On 22-11-24, 15:47, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>         cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>         cpufreq/cpufreq_selftest.dmesg_full.txt
>         cpufreq/cpufreq_selftest.txt
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

