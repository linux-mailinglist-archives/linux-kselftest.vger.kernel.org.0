Return-Path: <linux-kselftest+bounces-7116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E199897929
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 21:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DD1B255C7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 19:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B9155315;
	Wed,  3 Apr 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZJT+mgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B52F24;
	Wed,  3 Apr 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173378; cv=none; b=JSxb9bfzDSFz+e1TWcYuNoHFXzttCw9KtmlWt5XHr87uN+Cb0DLeVC1g7gFu6smk4rYrQSkG08LANBuG2KP7VsrDdfIoRysxvN4VihFtHXJl6ywotz5A8STz1d/QU6rlgl2Qm5ZBRLby1XXf5iv3heWKSItaNpMwWyvehpIkM54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173378; c=relaxed/simple;
	bh=3WUH9SubfwYcKxvgcz+D1M4r1DIyiUItWr+37jMl3Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exzdnVnn1PlQh3YExmyxlRg8WKqMUmmovjhSR8YAnULyv7QyjH52XZTUivkGmWYB0Pzg75iRgnaZw2TeOmfBNK7wzLwwxMwueB0jrSxZzcbONxeuLqanVYQoDmuEOc3lfYzYzAwuVUEpoqkbFbIoCDXJ2BMoQbF8w/+rDtGmhB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZJT+mgl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a28b11db68so110749a91.2;
        Wed, 03 Apr 2024 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712173376; x=1712778176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUae7FX57GCbhwQ8NWUH2pJwsLTvGchJ6LyegeiE4d0=;
        b=OZJT+mglv8j4K+Q6smrVixru9z92cltp74WDeoxWjcbgJ3dqUZv1rA3XSO4xBe0vlA
         JDwRcHniqTXgh6JcTvUfTqhrm0v+5tYURVq++tp+za6Wn+Bb1puKuUiTVNUn3vgCfInb
         ftFBhiQJYiujhiYJ+TeEEBplguAw4hUxZnzxZw/qJY5Qg9peeViri3CT/mN87Ma8N0Ie
         ac6FLeVEu+fmpxRu05RxMkKI7H0VLsCkVqmw5V27adNMOmR74NM4oeXwcpIjG00/XwRQ
         61EhcHsxveDHlv1bqZKeDPL5y6NaOSDWbnEOvroMp3AOrnTOMmK1N+aJGj7AfnKIJxYR
         51AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712173376; x=1712778176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUae7FX57GCbhwQ8NWUH2pJwsLTvGchJ6LyegeiE4d0=;
        b=WjkX1YyyEotKyhkd1hyxqPczeiuopidwA0YQInwgSawyAf/L6adJ4WJJ8CywmFX0xN
         wqzYm+YMT+EOY3tdOfsqijCmX/MuFHSes2mg1SlDxy8j/XpgStvHbcgOYW5BfP8wOhGC
         3KKTpygFDSWxVcUJvfKorczaoM1Xol2nTeWtI+VPWAJA+VIXYeeuyo1YmR7ysivIYI+s
         s3xrx/jAvjP2qu7W7n++8wtYbmtKYnRtgcuHn6iPLzX58tRuqLHAJH6RRJs8vMlIn8Ct
         xp79eBEqRQzVIg/XvNVudW3tkpRVG7OURzRu1/hu5XMFcpYs1XqKV42oHTxBEtSPlLff
         ICig==
X-Forwarded-Encrypted: i=1; AJvYcCULJHWELfRobEGZYa8xhlRuslmKt/FmGucqlwFvSVtJ/3unKWs8DA6CN+s850/7WZFqWVTHSs9RHfcEpGh94Vqki0MVLLYk9+wGZGM//H+zNBpT5MpbQqBhuphWbrKsZzbu2Jv/OHLE3g==
X-Gm-Message-State: AOJu0Yxv5SqHKVeofOLzEbJYuNHyz5WzRnSwkAx/qtZ33LMSzCCMOgm2
	Cy4jkfCYpCudGaqbXJ0k70ZXmoazp1bOg54Vw0aS5v6WSXRXFsVj
X-Google-Smtp-Source: AGHT+IEVXZX4Q2IoMb+hEcs5wG+rtM60qFsELk5WmIi68s8cL1mTcSnvyfYFxW/wOCpaOy2eQGQZBg==
X-Received: by 2002:a17:90a:43c5:b0:29b:2268:3349 with SMTP id r63-20020a17090a43c500b0029b22683349mr508502pjg.18.1712173376438;
        Wed, 03 Apr 2024 12:42:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id nh12-20020a17090b364c00b0029c61521eb5sm64786pjb.43.2024.04.03.12.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 12:42:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 09:42:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: skip test_cgcore_lesser_ns_open when
 cgroup2 mounted without nsdelegate
Message-ID: <Zg2xPtwFvT-lsSJX@slm.duckdns.org>
References: <20240327024437.3196-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327024437.3196-1-dtcccc@linux.alibaba.com>

On Wed, Mar 27, 2024 at 10:44:37AM +0800, Tianchen Ding wrote:
> The test case test_cgcore_lesser_ns_open only tasks effect when cgroup2
> is mounted with "nsdelegate" mount option. If it misses this option, or
> is remounted without "nsdelegate", the test case will fail. For example,
> running bpf/test_cgroup_storage first, and then run cgroup/test_core will
> fail on test_cgcore_lesser_ns_open. Skip it if "nsdelegate" is not
> detected in cgroup2 mount options.
> 
> Fixes: bf35a7879f1d ("selftests: cgroup: Test open-time cgroup namespace usage for migration checks")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

