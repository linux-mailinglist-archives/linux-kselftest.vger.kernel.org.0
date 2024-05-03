Return-Path: <linux-kselftest+bounces-9421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6C8BB3AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566C81F23E5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8432155320;
	Fri,  3 May 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYC4ktpa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6112EBF1;
	Fri,  3 May 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763214; cv=none; b=u1gdJaBkAJrU/1A3rTLUjfBjXu8fUrSoFY0kUaJ7N2M/dBjXZqngE+/yirOmJI9yMdDuBTTznLFLiU2kcHGwpJKDG/ehcZQSkGvKQGzMg5YavQpu+VXKC9sdLo0cOUL4fIL8hXNcEiaBkIQKpJ3L5BzXyf1p4+8jPd2pFtVp/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763214; c=relaxed/simple;
	bh=3fMQGIHvCxuh/KI+QGtnXkUw9u+MmF/lvsQK73wS5lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agdt4jaHYtOX1p4OBJRFakYMfO+wuUs4fZk/s377WMM2pDRhUUzWMsXkRY9adRysQXQp9V5Ou4O7MmdctEToa+XzBrLjOuPbh/PMKJ9QtqdJZHfrkvFEdOTq0hjiKL6qTO3QBSoHYIkB0NaLQXfLAe/jcNQ+J9k2FvSivuisZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYC4ktpa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so266525ad.0;
        Fri, 03 May 2024 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714763212; x=1715368012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcmBSm5zJ4Ky10rROpSv6jdG1exUyb1cNnY853+P3xQ=;
        b=IYC4ktpaJW/oa5UQAqeNVJQZXwEMk33Lj/+zELKqT0vjiqX+veiTVtm7+GGVBBDoDs
         Jj2Q4XCsf6w1D8GNtJupojDKu+zHAn5ixuzcV+k9cWsL0qmAhMygvog/vCajavQiScNH
         WTtmSgESkCDrtJNSseXVEjzpcKkRAYxbYC9H3rFfRoUrdGQxWzu3SJZQwXDTZTgo0L/w
         Y+QRXSHPcAu7BQ54bEBGDLWZ50Ec53eka5q+UQNBOsq6VGLkFUC5KanegNSCbrGkl9V/
         CX2aFVigSdvxpnHT6zl1FqZ6Eg07Jm10tNhsAlMJ3X7xj3X5sLhoCShwUWOHhlqGIzIM
         GEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714763212; x=1715368012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcmBSm5zJ4Ky10rROpSv6jdG1exUyb1cNnY853+P3xQ=;
        b=VD8qfwl84SUtu46L2OlZ2pDepO+tIxMDQMrvHpodisF+1bXV9cFkaMoFbOaU8hG/jp
         vAkDc9U2w4prwLsl0uqZca2vTLPbbBtqfGHZvgOJjp7oGuOcU/T5H32syYH5iGhflT82
         cxhYk7/2kkhcnocoBk1830YSEXZLLlxvLL8Ckaywyb0V6+4SGWH29aIwz3Yso+pjWiXc
         e8lKoCP5fm5QDGoYMFt3YbMC4WqU9sfex9/XZnZlK0TlgC5ukKGwA/LaVgUR7Qr4SVaq
         qlsz2PekNBZa6vCPThufXqdYT+BN+GfjJWncAwuZhbH2vHhEIV7q3Ulv7CPIY9WrCrGa
         JEsg==
X-Forwarded-Encrypted: i=1; AJvYcCXcHldNAV9lV5U4EIzbSGg9QL8BYkIbsCodr0S0zZloUyoCJW9gHvLcBHn4FabbcFb1rvMkDb6r2R7wfSUAQFK4eHQTLZmOjfl33NIBUaKofcOVj2nyyr0LecdwO6INZ7xYuO26LRB6WkxJWd5xlCjZTyLgrh2/TZnRnFVJUcU/8C7906ot0Q==
X-Gm-Message-State: AOJu0YwuffC12nqVZue4geo9WUdPoH2s2J6/7Xg7381+aZMiJta2Ktj3
	FU4693TMgB8LDT059yTrGH1UKJaaxRAnhzDFeVJRLuJ/wgqos5/C
X-Google-Smtp-Source: AGHT+IFg6GGVyu95XtXhoIqjH+6iNScaK7UWQsRzeKPiKvgKFmZuo0v+/xZaWfl1gbkOvDC7TZ4nqw==
X-Received: by 2002:a17:902:e885:b0:1e2:45f3:2d57 with SMTP id w5-20020a170902e88500b001e245f32d57mr5255562plg.6.1714763212311;
        Fri, 03 May 2024 12:06:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001eab3ba8ccfsm3587280plb.285.2024.05.03.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:06:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 3 May 2024 09:06:50 -1000
From: Tejun Heo <tj@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH 0/4] selftests/cgroups: fix clang build failures, warnings
Message-ID: <ZjU1yt3zU1p60JS7@slm.duckdns.org>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503035105.93280-1-jhubbard@nvidia.com>

On Thu, May 02, 2024 at 08:51:01PM -0700, John Hubbard wrote:
> Hi,
> 
> Just a bunch of fixes as part of my work to make selftests build cleanly
> with clang.
> 
> Enjoy!
> 
> thanks,
> John Hubbard
> 
> 
> John Hubbard (4):
>   selftests/cgroup: fix clang build failures for abs() calls
>   selftests/cgroup: fix clang warnings: uninitialized fd variable
>   selftests/cgroup: cpu_hogger init: use {} instead of {NULL}
>   selftests/cgroup: fix uninitialized variables in test_zswap.c

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

