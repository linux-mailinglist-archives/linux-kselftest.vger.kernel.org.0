Return-Path: <linux-kselftest+bounces-14882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB679498EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 22:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D460B21F8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 20:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5614B06C;
	Tue,  6 Aug 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLZn7vYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607A78C8B;
	Tue,  6 Aug 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975531; cv=none; b=N091XnGqgKR7pkj4RNOwIllvDtQlZP2xPifVvV9DT9sCVW2MmDwd9SyPp3rQkx3l1bzN2dP73oazFjIgzkRKdYFBI9d40G8uvrblj6MIzTx9EAIjYP2QSgjGcoFGe+T7ZGWeQ8/YcoFwrteTjBBEPV1Sljam+Wz7MRwQOCPIVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975531; c=relaxed/simple;
	bh=VCltF6XOt2c0dGW4i2lhael7tNY14wjoUjz679mbDc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpCvGyWf+2GvbeXNLOlbTuSb0yqlkK/3ATkThm2IPGQwn76v9Jq017iXSLRaQldSCfI/lg89ESVCksTtoxW/tGEJkX+K/39PdIrGJ/rWLVRIVqGdm+4LM8Ufwsze5J77lzvFnGuktbmStwlzg42QlB+yXgYXO+VNR/L50dWblCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLZn7vYW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc49c0aaffso9203795ad.3;
        Tue, 06 Aug 2024 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722975529; x=1723580329; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e62sGxarMTtJYlSOM4A7kn+Z/ikWkvGWr6UsX3CMV/c=;
        b=cLZn7vYW0Je026XKhLE298DlFhrtJ8BqFA0vEsxyoH3sP4VQV7eZVazb6We9zBZNNm
         3O+GRx3lElmoUDV4zIBRo86657AAy9Yn4enVn4KaBqN+wY+Xz4hErL1DkI9ZM2ckynxb
         Iqswa6NpcgtMAUrwY+Oy4yLvIaallFFXzFQercXMwGci82Wxnwy2lqZO9F5pxjzkO5z9
         9aOUSehcnvBp5lMJnEoMBr8mFqXxE3AL9LNYWOFSbENhT6qhjV2Y2CwecMB3LQQa/Z/V
         KZ9kUjyXtgmc3NNUya4r5IP3Ep3frYcnZ/MjBagUnWJnyCSNYNZ9xGkJPtUy9KXkl/GE
         aQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722975529; x=1723580329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e62sGxarMTtJYlSOM4A7kn+Z/ikWkvGWr6UsX3CMV/c=;
        b=FICVqqHG3ZemZQKTe6oefzFxV0H9yuKiH7CCKIlAh6SPoLd9Qfla8n4MZwTG2jWee4
         qL0we659ziag72X0IOzR52UuyzEc8irIvZgp/JWHedM5VzEf5azTI4vwpD0cvuSbtZq8
         EK3GI32xPxcW4PLD77luvVa6fgC44H0+Ym+8OTUdTTDFHBFrmBUJVk+er7lCRKaeABhE
         MDkFLpnt4KbrbIzdcviWTvUN1gD4IDKvz/VUKk023rarvYBvutt8oSMwdKRGj0l8lLtk
         x+m4LrJ1Ka9ZM/C4Px1iRozhRrz7D22akHF6Ik992wdEGP9Dt4zSfscKtn/+qqzhmzIi
         Y+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2JVJl2dLndBr3x/H5QmgebeYPqaDhfAlpQTK36+Lko1ZsMyWTRmThbXP/WJ0ARrr21ZAT6UcF77CJ7hl8ymaew5tqvy6ZbIh4hL+bAj0oKh3O7eivZoboOMHURC4O8Y8GQWHMdhxg9SajH6EyiMYnQnhwf8ADli2wxof7fuL9i8sKJQ==
X-Gm-Message-State: AOJu0Yy0OeU3xPoB0M1+lOSNdA0YPtSLTf12SlN6iuK/sYvD89CrOmb4
	osMqb1+E0W4z/u26nRSi9f/ttVLOvkRkSP706W8+youXAalo0hmT
X-Google-Smtp-Source: AGHT+IH5x0BLUhFFDdEROR9cT95VNvIyhQVnchuezQN0WU6V0AursJb3CTCxKvQr5aYUEJOkX+jg4A==
X-Received: by 2002:a17:902:dac1:b0:1fa:2401:be7d with SMTP id d9443c01a7336-1ff572581c0mr176566375ad.8.1722975528810;
        Tue, 06 Aug 2024 13:18:48 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59060107sm91438675ad.121.2024.08.06.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:18:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 10:18:47 -1000
From: Tejun Heo <tj@kernel.org>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v7] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZrKFJyADBI_cLdX4@slm.duckdns.org>
References: <20240730231304.761942-1-davidf@vimeo.com>
 <CAFUnj5Nq_UwZUy9+i-Mp+TDghQWUX7MHpmh8uDTH790HAH2ZNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUnj5Nq_UwZUy9+i-Mp+TDghQWUX7MHpmh8uDTH790HAH2ZNA@mail.gmail.com>

On Tue, Aug 06, 2024 at 04:16:30PM -0400, David Finkel wrote:
> On Tue, Jul 30, 2024 at 7:13 PM David Finkel <davidf@vimeo.com> wrote:
> >
> > This revision only updates the tests from the previous revision[1], and
> > integrates an Acked-by[2] and a Reviewed-By[3] into the first commit
> > message.
> >
> >
> > Documentation/admin-guide/cgroup-v2.rst          |  22 ++-
> > include/linux/cgroup-defs.h                      |   5 +
> > include/linux/cgroup.h                           |   3 +
> > include/linux/memcontrol.h                       |   5 +
> > include/linux/page_counter.h                     |  11 +-
> > kernel/cgroup/cgroup-internal.h                  |   2 +
> > kernel/cgroup/cgroup.c                           |   7 +
> > mm/memcontrol.c                                  | 116 +++++++++++++--
> > mm/page_counter.c                                |  30 +++-
> > tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
> > tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
> > tools/testing/selftests/cgroup/test_memcontrol.c | 264 ++++++++++++++++++++++++++++++++-
> > 12 files changed, 454 insertions(+), 35 deletions(-)
...
> Tejun or Andrew,
> 
> This change seems to have stalled a bit.
> Are there any further changes necessary to get this patch merged into
> a staging branch so it's ready for 6.12?

Oh, it sits between cgroup core and memcg, so I guess it wasn't clear who
should take it. Given that the crux of the change is in memcg, I think -mm
would be a better fit. Andrew, can you please take these patches? FWIW,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

