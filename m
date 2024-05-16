Return-Path: <linux-kselftest+bounces-10307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84578C7A2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F75284786
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8330414D718;
	Thu, 16 May 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVcSA9hm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B52421A;
	Thu, 16 May 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876508; cv=none; b=AOByYUKr4JZ+U175am5wQqoyOatAOPuIdD0S4WMvrb5z3+J3XT7bPQXnoioqdXZWJpQAEVnsnQYxUPGhPduGd7EOt3GMrU5vqPW+GNfF+k583Q8xvhCtarLKA8OS+lfEW26fY83zSDM8oEgGHaBQ6dSc0kxHAqSyKHVPi8gsyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876508; c=relaxed/simple;
	bh=oxcZl7+8PVAjjKM8q0xudjNvpkx4vmZdjGUD85dJAMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPsMbl9OIFa+v5vxZ62VvYwTkI4Hh4TJj1Y1Iis70fxQvJ8nbajG7nLf2gjtJdDSBe0kiRmhCgMjtzm9Z1QD7p76u3+ScJNozd1l/vY+iUiTinrrzo3PKyi3C/FtdkAjb+TIUhF1Y8SpBHkuACSH9LgNcA5dPaQEQwZ8vTe+tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVcSA9hm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b5388087f9so321547a91.0;
        Thu, 16 May 2024 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715876506; x=1716481306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ladxmLIkYURG/7sblZ1iTNsC5RmlL9cxQCxBwW8J0dI=;
        b=lVcSA9hmwj0O71Q/dDwqHIplGUzAq0unOl7AXoZJjzffUAtGIp+pYJYPUS3kFhvTmk
         T1vHeqbwxTLwz78dx+ESazJfqajjv+4AJD5INtLo0D2nsBFHYg4MF+eptke2PYlBDV3g
         ld+1pGgrigveW2xLO0G7FcdwumbYpqsFTMlD55u1/g7zOMsNceVOWVdUwiex43jTK768
         W9mGJYg0OoJE7sqBhKoiAxyLIGNvFeT8ig1pu6FF7nA7GGgt8aWeHU4ojXMi6NllNUwb
         r/0afcN1o+SHCu5DT8mZxu0MDX2UsJ+9zr/bH6A5N6zvI6c1r2qJGSKr/zobMnpe6NqR
         qGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876506; x=1716481306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ladxmLIkYURG/7sblZ1iTNsC5RmlL9cxQCxBwW8J0dI=;
        b=HfrBpADiwd1w3c7qpfMRtYmMFGbPCq9/GOL6YVEvaGBXbS1VXaDhgQhsgrJZPoAYhQ
         YPum+Liymb/noWT+8DLnSnuOjo3ygx4+nROzkMO1QKdrw4xzRNJABf1U4wVpfakjsKZ+
         G317w1/O3tXx/qxnQpPIUiPJ2xy/vV3FRI6///Q50VXFD//Qg0OsDU5lgk4WUBSp4wSh
         LlqufBNd5bCEvqIII8akcStv+VfOigHHIs77aYPMrRYrza7nnKpNaSsVvUUNcXf+GWXg
         5Kq29ujOvMrVtcL2R1MqLCbWmPevsW46ZVViTb5iod3Cvo+KPlIXYuuG3Ht4u+YlrulS
         lbLw==
X-Forwarded-Encrypted: i=1; AJvYcCWdWFr15O07GPtHGDQEbvx1Ngl70uBzKFWe0/p6vHzgC+8fZv46N6T37VgPOEhD47sbzHIZ+y8OflOmsh0Own0uWxT+EEISlN+fztpOttFMjbnd9R87DfnYYHz5Nd+2nBdeQsIgXghXqNpr38giRmXrdyTzZ6fWR+UOZ+s4g7t2FGZQVbmF7TcrvQzUVLrPvPEon5ts/fDWdaikf27uEGti857kkvqyS54CCbWARU5HRvG1TDcDwk4B82sK9QHumWuFmo10+vMQt8FIMgXrWXy+9sTtTsAdGMVYRw==
X-Gm-Message-State: AOJu0YxbG8KFCfKFMisAiDzbD26PZ10z4kcv56A1kjbbkLhZcHLq9JLZ
	Uv1O8X+EXhEREFE0iLeCFJp9SY+gWd4aWukJy6LB1I09Qww0aA0k
X-Google-Smtp-Source: AGHT+IE2RYf/IjCzqA6lvwO63eep/pWkyyUhLJPD8PBjTkjNJiBeJ3r1GQbOnigCM2bH4+drbBXVnQ==
X-Received: by 2002:a17:90a:d3d8:b0:2ad:c098:ebca with SMTP id 98e67ed59e1d1-2b6cc44f929mr17346299a91.20.1715876506064;
        Thu, 16 May 2024 09:21:46 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a52esm15900592a91.2.2024.05.16.09.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 09:21:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 16 May 2024 06:21:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 08/66] selftests/cgroup: Drop define _GNU_SOURCE
Message-ID: <ZkYymMDd690uufZy@slm.duckdns.org>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-9-edliaw@google.com>
 <ZkJHvrwZEqg6RJK5@slm.duckdns.org>
 <bec3f30e-fc9a-45e2-b6ea-d739b2a2d019@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec3f30e-fc9a-45e2-b6ea-d739b2a2d019@linuxfoundation.org>

On Thu, May 16, 2024 at 09:50:06AM -0600, Shuah Khan wrote:
> On 5/13/24 11:02, Tejun Heo wrote:
> > On Fri, May 10, 2024 at 12:06:25AM +0000, Edward Liaw wrote:
> > > _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> > > redefinition warnings.
> > > 
> > > Signed-off-by: Edward Liaw <edliaw@google.com>
> > 
> > Applied to cgroup/for-6.10.
> > 
> > Thanks.
> > 
> 
> Hi Tejun,
> 
> Please don't include this in your PR to Linus. This patch series needs
> to go together as it is causing several build warns and some errors.

I'm afraid it's too late. The PR is too late. Do you want me to send an
amended PR with the commit reverted? If it's just temporary issues in
selftests, maybe we can just wait it out?

Thanks.

-- 
tejun

