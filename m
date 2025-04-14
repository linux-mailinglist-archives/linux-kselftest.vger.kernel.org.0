Return-Path: <linux-kselftest+bounces-30733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52942A888E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB671899743
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F159C2820AF;
	Mon, 14 Apr 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="BGqM1k8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E62798F4
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649250; cv=none; b=Qf5MKf9yDdaTws071TrF1oFfxV/O+Wq4YRDgP00VNzArJIHxrbK14I0xpnbwnOEUmQYi+tRr+moSVvezQ7Avl+czMOzvRS826s3mhjRvs3sHWnFJznid+v/zClaPzSv/3w7+JK82mqFs0PSSRS7N0+x5E+V3nJmoXrXXh4CGix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649250; c=relaxed/simple;
	bh=C378C9Sed227nr/gwJbV0c7C3hVPbUh88wSNKGMT/4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnE3shiURR9wFGOvqXHfJTURy9qHlE+uhsbbQgXw/6NG7gofFBy52wol4fHcbgg5I2kmWrWh+sJniOjg+QGvECKSEhwWRK3e2syCTiooeHKyaKtqakvuSAONtE7QeM/ScIG0tTVK2OxpYl61Wy1G8bwuFvSgtaOp+V/FEUDidvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=BGqM1k8d; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecf99dd567so58460246d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744649246; x=1745254046; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gvr1Eg7lK7Y8HhVqNwImZJnjSK1mbZPXBkM7KTJCKgE=;
        b=BGqM1k8duufmmTpB9Aay+GnUw9x/XNfdW/P8tWwDwL0kATYCCsUuF+YQ8MuWWFUXdM
         NIlc3Jsd2qBpzgZ8XHmlmoTwJTMcRl7T+bbKuGwLdf2UDKckMd4ANMhCujC8el/5mo5k
         fIBYcvY3gzrpZChPkBC1Qi11giuqovPUIyMyRTiqeWQFtLUdyslOBboWyMB4g/4uOM0t
         Rdg/THMpgSVuz1Ay47uKjFmOjL+lnvfg23Qfq0SFb+84eXOEnlkAiMC6ZDCyMS7WMifD
         JDus9nt2Af64f0OpJyElTCimbFPGAsgyxuUtJ8lMrGlmg8g/yGACMYQ34hifPsjCT5Jw
         EkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649246; x=1745254046;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvr1Eg7lK7Y8HhVqNwImZJnjSK1mbZPXBkM7KTJCKgE=;
        b=h+wadX37ObdVqR9lcNQE08u1gj2WTmCfyxEhb/SjNNsiD5SCvzKRX8iZdSWDsqjf/c
         m0ScI08vPg4SMxaCGFDqbdg/WIaLFqCsiXTq9t3YG7UpXEJIvY04PYkfUjmieMV0WB+o
         Ew3Y0bb3NS8RBUNgykQqg5vnYcDe+R/zm7c19PXiC3uWNkVA0vmUYpHGd0FE5khR/pD8
         Ph2xc5wldZ5R6jabylx7SZuG5KDGbGf5s+pzRlnN9NLVsKEK0Hyylp143qVyjudZgNvz
         E4GnerUpKvuFxFqcrzHQC0VcJtP042+Eu3kgTk/wdLVqE+aYFUiIqRn4hRqrvuPlk657
         wjWw==
X-Forwarded-Encrypted: i=1; AJvYcCUlK6WGvpvk7jxgfKL/x8OF14xSbrZCogxrLTV1hEsnafICyd2geXnRtZeGluB5yqexVZ3yyhcC0wjQBOMAtB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQBJtj7TsjoTOdZId58ImgwJMTM3OzugfsA7rUWwht6EGyhML
	1gzIABtIRbmHwr6xObo7wuZExtTL+dNrzpKPLSzCYYqu+QJeuZbLNIfQhJRlqS8=
X-Gm-Gg: ASbGncvTateAF/louIXwC88PtPgwajRLQDEWkXFwanTfBW1YXBHHCMm8V1XXRmtachq
	zoZkkXcMlaJ/5Tw9C0vVmWl1yJX1plx0UIwj/NYg1I4WEKv/COqafXy1zD8/WLlrdYPmloj/BuR
	03QHO7mFtOlySBVq4bJK6AqeuleCKbqEY5Njqg1GnvpowrpHU4I8hMeuMf34Bns+217puSV+sHJ
	gEtZhUE+dHsVWiJoiqaHZLsnc6+GYePvSXofzqKRNNsfjjX6c0PVLgxcFb7boQaH2JRHS8yLa2o
	tc96Adkcnq+HYjVIQV7FwLPRqv3DG3vVutFJ09+MZ9AmNLU1FQ==
X-Google-Smtp-Source: AGHT+IGyn19E6PStgkF0prqcjwzNPkKDdnhAlejJTPbm0jkoKGh1Or323otXTafl0CJ+s0xtuj6ZeQ==
X-Received: by 2002:ad4:5e8c:0:b0:6e8:f445:3578 with SMTP id 6a1803df08f44-6f230cc177emr218119656d6.2.1744649246264;
        Mon, 14 Apr 2025 09:47:26 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea106cesm85684596d6.103.2025.04.14.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:47:25 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:47:21 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <20250414164721.GA741145@cmpxchg.org>
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
 <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
 <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>
 <uaxa3qttqmaqxsphwukrxdbfrx6px7t4iytjdksuroqiu6w7in@75o4bigysttw>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uaxa3qttqmaqxsphwukrxdbfrx6px7t4iytjdksuroqiu6w7in@75o4bigysttw>

On Mon, Apr 14, 2025 at 03:55:39PM +0200, Michal Koutný wrote:
> On Mon, Apr 14, 2025 at 09:15:57AM -0400, Waiman Long <llong@redhat.com> wrote:
> > I did see some low event in the no usage case because of the ">=" comparison
> > used in mem_cgroup_below_min().
> 
> Do you refer to A/B/E or A/B/F from the test?
> It's OK to see some events if there was non-zero usage initially.
> 
> Nevertheless, which situation this patch changes that is not handled by
> mem_cgroup_below_min() already?

It's not a functional change to the protection semantics or the
reclaim behavior.

The problem is if we go into low_reclaim and encounter an empty group,
we'll issue "low-protected group is being reclaimed" events, which is
kind of absurd (nothing will be reclaimed) and thus confusing to users
(I didn't even configure any protection!)

I suggested, instead of redefining the protection definitions for that
special case, to bypass all the checks and the scan count calculations
when we already know the group is empty and none of this applies.

https://lore.kernel.org/linux-mm/20250404181308.GA300138@cmpxchg.org/

