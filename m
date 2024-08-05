Return-Path: <linux-kselftest+bounces-14797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA29483B9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF8D1F2350D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890FF15F30D;
	Mon,  5 Aug 2024 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv67lRO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC18469;
	Mon,  5 Aug 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891202; cv=none; b=q0MKbgNnWibKNVuOKhazn05saMr2rw+nRcmO2a+acxjvtCMdpF0rzhREgwYspTATj0p/Ls16WzmLubF5KBHYVeXti8uTQs897k3bMggbHhkML35AygQLqSyyPiCa1MRwBTCQqzChHfehYaEgesX8H4W7MHOnRPz+2dwLt7qEWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891202; c=relaxed/simple;
	bh=y1xo8rwkPsGbX5QYPhg43l5VAHouRl6947m47UdVhfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAiIkHjIpKl1kd0ice2CC7rLbvgPfL0yCo7VSTgi/1nzt3+E7jkJ1a4AwzsO7Fsv3Xu6FBiJUNa4Qusc8PJEDSumAD2G3d8Em6v4kygLP7pqb//1HQjfXwcB8JYWe7ltutGppfEMLLYUT3iR4hyEEvuAPgLw5Ga1W1+wRcpVHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv67lRO/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso51262465ad.1;
        Mon, 05 Aug 2024 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722891200; x=1723496000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HoHqms9+0/tY2gizWucMJ9q6stXqDnf9Flrxt6daeU=;
        b=Tv67lRO/JBPb8jegHj33o9xmR7NrzQc3RxMnVD7PRXczaJQgEM5RI1C7UaJqO+eMXI
         XeUSqR9D6V/YC/2mo5EVgvBe4Oes/0QxU5LHaz6sk6Jwc2V/kizuamw7lZUTc45RXURQ
         f82bRnRVL23R6FgoosT9Qem2j7svWBb72buzW2G8H4OxCBeqa9NT7cWBjKvDIe0D4fy0
         gm1oMswF7/q/Yn9kv94McyWwUTsHIGq2OhZ7XF3jNxEqvaclLbUtUJ7Y3S1BdepAYQOY
         ycuDmo80R8fuAPNRVjKAXnXeI0Ur7IsTiX+1tcovlD+VYYDEES/GmYNKMBkZJlc9/ECK
         4RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722891200; x=1723496000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HoHqms9+0/tY2gizWucMJ9q6stXqDnf9Flrxt6daeU=;
        b=mYbPqksPXbifF0on3tdqQP+j4RRYxeb00eQgTGaZW2Wzkm5oCJaYXYZtw5o5zjEX66
         RZjhRGLeUkErtiJ2dm49tD418kBOV8/1UANLvb3JKiilPhO0N1XJnPC4nG0nBwZH99yu
         ta24FCPDZ92LuZkVS2Kfi4LdhNtcvDJ7v1f7JV/ygjo/Zna5xbxBq5B3kpYgbvI+Dsnx
         rkk2hSGUbbZ4mNBa1RWDHZFR67d6m59pjPvIOThN3qIWsp4K5LbXcM2j/QAOhJvF+23G
         ymRgVfOSFlK9H3zYCsuAgDzsRlh0rXaBx2NzAAmKFn7GeMEfBvSv95syT6RaHO5BNnvN
         9sQA==
X-Forwarded-Encrypted: i=1; AJvYcCUXIKv7g1Ow7SrjcJAhSFdTImfjktYHYfd54clQ2G3Bhp12Ira9UhveLE5aA/2R8TWHC64X010QrmY1iyN2bA/4N9s4cyyuLVkxwT7RSP6X6rod2WgBdwnY1jzjktgaWTVfjuX793kXiCfl5JDexNuQz7gYuPRmTZa9U7rU1+CB2RmAJcCjxg==
X-Gm-Message-State: AOJu0Yya4FJ5x/KPGhe2YwECC1vyNP8miOaEpV0wUaln1qrtZVryVNYm
	CO8VB48ER/e6KY14U4TSZE5X5f4hG19HNNdY6ekE/XkMvkhgykGx
X-Google-Smtp-Source: AGHT+IER7MImBl1ax6v5k1mCVCuO9iad5adNijX3pUG8zDdywVTk9JecqjehUPEVVLbLmp9HprRSjQ==
X-Received: by 2002:a17:903:1c2:b0:1f7:1655:825c with SMTP id d9443c01a7336-1ff573d903bmr114138625ad.36.1722891200121;
        Mon, 05 Aug 2024 13:53:20 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f26064sm73042265ad.57.2024.08.05.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 13:53:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Aug 2024 10:53:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH-cgroup 2/5] cgroup/cpuset: Clear effective_xcpus on
 cpus_allowed clearing only if cpus.exclusive not set
Message-ID: <ZrE7vkGZsBRdlaQP@slm.duckdns.org>
References: <20240805013019.724300-1-longman@redhat.com>
 <20240805013019.724300-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805013019.724300-3-longman@redhat.com>

On Sun, Aug 04, 2024 at 09:30:16PM -0400, Waiman Long wrote:
> Commit e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for
> v2") adds a user writable cpuset.cpus.exclusive file for setting
> exclusive CPUs to be used for the creation of partitions. Since then
> effective_xcpus depends on both the cpuset.cpus and cpuset.cpus.exclusive
> setting. If cpuset.cpus.exclusive is set, effective_xcpus will depend
> only on cpuset.cpus.exclusive.  When it is not set, effective_xcpus
> will be set according to the cpuset.cpus value when the cpuset becomes
> a valid partition root.
> 
> When cpuset.cpus is being cleared by the user, effective_xcpus should
> only be cleared when cpuset.cpus.exclusive is not set. However, that
> is not currently the case.
> 
>   # cd /sys/fs/cgroup/
>   # mkdir test
>   # echo +cpuset > cgroup.subtree_control
>   # cd test
>   # echo 3 > cpuset.cpus.exclusive
>   # cat cpuset.cpus.exclusive.effective
>   3
>   # echo > cpuset.cpus
>   # cat cpuset.cpus.exclusive.effective // was cleared
> 
> Fix it by clearing effective_xcpus only if cpuset.cpus.exclusive is
> not set.
> 
> Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
> Reported-by: Chen Ridong <chenridong@huawei.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied 1-2 to cgroup/for-6.11-fixes w/ stable cc'd.

Thanks.

-- 
tejun

