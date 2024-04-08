Return-Path: <linux-kselftest+bounces-7431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B253A89CAE9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D0C1C225D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43709143C59;
	Mon,  8 Apr 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOQSMnet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD81E489;
	Mon,  8 Apr 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598038; cv=none; b=HoqS6nMXIA3+RjXfCTB6aPSfNtZ8Vwoo30TJfuGfn+uPc6TGkDnrPlV7j4Aa0HzIX1SQSZNs4bMhY2nIEcdlMJtLMxXyoH5j1m1UVVSGLD1nPcSKJ/jTcdB5vtyMh4g17kqu8F4EBIDn8PFDWZGo45ZBem7yKiDpUNMETKYpHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598038; c=relaxed/simple;
	bh=0t2Bpc123pAXmXsM8799oE5ds9SByPwdC46wy2Ype2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh9MIttxbIFbArBkV8rwEbsHgMGopvgUPAan8sxx7BqNSHV+EjWCR1XUBX64fAYWeZyzFEbkG4mM1+qv3+PJuc9T/Peum/EBNtgVO9blfxKsCekEBrK32u/VUh3KF1Tiw7Y++gemHFo7TcXjXJR3V3+TfwbCrj6qb7VhCSXW7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOQSMnet; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a526803fccso700099a91.1;
        Mon, 08 Apr 2024 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598036; x=1713202836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67qLt4AzcbjXyX04hZDnLSNr7BdUcYeQncTdQc0kA5c=;
        b=fOQSMnet0NHXFhamklkyxU/By/feu4NjWCO6Wb5J0E+kmy+SPSapwZ3K/tuHfOVdif
         njSBfGP7/0BrHciwfbvhC6LjEDzs3gU853ulgsqy8S9LYN+b3dbR9zUe01qdar9nEzjr
         TM3fYCjZTXbcU2bQmDri3Y2s+S2IEatDXJnUF4BYFjRWZrULLCgqvDgldB/7cjbTeMA0
         kkU97PVRjhilzsqqzKlpb5RyOuzucYdovucafmqyWcMJmGMO0FLs9QQaU0fiPaM0oxy+
         uDgpnojJARMLLWYmrNR1PUiiqxB7bZvvlnfGLVVdm734OVLAaVLiehUG7PZYxz008hbj
         veWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598036; x=1713202836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67qLt4AzcbjXyX04hZDnLSNr7BdUcYeQncTdQc0kA5c=;
        b=Q8Y/05DmPDNhrlsUDhPTprT1Aixp7p3tfntmNRlbDCz2cpn3gH7znY3l2654L2fV8p
         sAXOcz+mWIs4wf8E7M+mYxz5RmtCN+EmMT21oNiZkyhkGTb1tttLBvZg5jzU4pbHO646
         gMb6+uekT1PctG7PQNLiLiNjoj+Ui89vDQHB50vBz9H+mNd9rnRKijd2A/oCUlfLLXDa
         VfAnilylz2PAdwXPyMXuc7D0Suua9Un+m3cZVNixi/ryZgpJAFw2uJy4+M7QgLMI3zdT
         DJtjw1ZbGhIDmT6gFVFXbBn+WTKKO13sxMJ2+dFgbJIkY/zxxvBCfHIZtDh+0jwy6DG7
         0Iqw==
X-Forwarded-Encrypted: i=1; AJvYcCXEs6ybxzuMVfxAkqwvG5c+6uNbr54sJJKLrjsTtnTGNlvQ+rB5eNnHhhlVjjtGj/Rotl8AbHhMLeNUkyJ5Rvaug4eLM8I8+5EpsFUS1D+OQ+mpHUqZ2MiG1VDIEUg20zyRBqkJDnuCyWvhLr5Um3JHdhy9uFcYYS1iekgfBfO6rNPS7z2qX5bT2tb5LgeaJMg5NO1Zq3wlM4o+wuUASxaW
X-Gm-Message-State: AOJu0YxZB7sD4YBRc6q5Y4rL/AuEWwX/BP2lXWNHaAs8PP+CO2cJzXQR
	Tdtsk8EabCktmtLJ2aWIXH8NXM+ICPJjSMPg6pUmBckpPE5F8yi5
X-Google-Smtp-Source: AGHT+IGJpqaEj0ve/GvVry9/PXmcU1mCac94AlQ6tO3MBLesQOSeKIOmAx/IhFrkqWmuQqeMmgb6rw==
X-Received: by 2002:a17:90a:1649:b0:2a5:4a76:81af with SMTP id x9-20020a17090a164900b002a54a7681afmr1622299pje.20.1712598035791;
        Mon, 08 Apr 2024 10:40:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id gk21-20020a17090b119500b002a54222e694sm1420162pjb.51.2024.04.08.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:40:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Apr 2024 07:40:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2 0/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
Message-ID: <ZhQsESPi9PwpPhx7@slm.duckdns.org>
References: <20240404134749.2857852-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404134749.2857852-1-longman@redhat.com>

On Thu, Apr 04, 2024 at 09:47:47AM -0400, Waiman Long wrote:
>  v2:
>   - Found that rebuild_sched_domains() has external callers, revert its
>     change and introduce rebuild_sched_domains_cpuslocked() instead.
> 
> As discussed in the LKML thread [1], the asynchronous nature of cpuset
> hotplug handling code is causing problem with RCU testing. With recent
> changes in the way locking is being handled in the cpuset code, it is
> now possible to make the cpuset hotplug code synchronous again without
> major changes.
> 
> This series enables the hotplug code to call directly into cpuset hotplug
> core without indirection with the exception of the special case of v1
> cpuset becoming empty still being handled indirectly with workqueue.
> 
> A new simple test case was also written to test this special v1 cpuset
> case. The test_cpuset_prs.sh script was also run with LOCKDEP on to
> verify that there is no regression.

Applied to cgroup/for-6.10. Hopefully, this one will work out. Thanks for
working on this.

-- 
tejun

