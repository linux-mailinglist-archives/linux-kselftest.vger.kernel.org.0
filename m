Return-Path: <linux-kselftest+bounces-3165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB3830BAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 18:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F401F22302
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8545224FE;
	Wed, 17 Jan 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaBHiyK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800820325;
	Wed, 17 Jan 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511234; cv=none; b=moOv6IFdqVmHsS/Cyf+sb0pknefDifNxew+cPBn+jt2auHvQAOUUk8Tcw+LoVx/xeiOBjmvKHCX7o9ZOwbUvHhAykIiH9FZTyW9iL63unps1ckafEKujVxmQCMociQ/ZJfuToxaG2tbZNllovSLuNSyNLeRZCtuAx4LNLIVrRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511234; c=relaxed/simple;
	bh=z6DHV9nI4jMmYcNar205Ahgb8zqKb0GneJ6hFKq7cfE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkOr9MoMXtf9TfoBtsUu2v0xtT8i6cgNZ+SYtDKD+U9CwHwVu5uu2QtREia2i7oL1EEqMbtsdFUc63awqHW2WrWDLtxfP5TTVMn7BnaF+BZD7O8mT+vhkfO45N6N14zgDK9x1GlOqHvrztoBraAiSw5mKDTmfpQ1deCE4/4zx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaBHiyK+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so8167340a12.1;
        Wed, 17 Jan 2024 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705511233; x=1706116033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qc3wJ8un1HLyTnJdIdlaIzF/ByCjBoYDp2Jt1SaaKDA=;
        b=MaBHiyK+v5MpnxjaJJE5vQUwhO36+Qo4q/DlLTrEeQ3OYTZRDEjCW+il39zPFj6L2W
         TUyFal5q0AI1ERBiX4rdRo3+4i9e5Vp4Z726J5XKu/k0H0qowGL1kJR1qXZ0H+9J+2CV
         /BSgtQ3mhfacXWgug1pMNHb2vJPCdNyRfZOVaxGdsrCGCwo6r8yhaLldksK8uh8dd7Kj
         0NlOqtrUKRz87U38wI3A7nT21MxWnfgoaVl0tcm9Eg7sbWPqW5y0pR2Z+bUL/3u1g0/P
         fQgMjHmRAPetNdwV0Os46OSmuSp6Yjzi06S+b0KZD9Nj/0bSjvZpi/5FvISMemY6/xaL
         ehIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511233; x=1706116033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc3wJ8un1HLyTnJdIdlaIzF/ByCjBoYDp2Jt1SaaKDA=;
        b=NnBQ1IqybStsvx6HQZ0+NskUoOExPinzHr/td3I0/6+5SlPneI3gs21iAnr/np1hx9
         fwIc9JLQ8ZjWqAlGcEP62Jznt6gA9I7UTsaQiZ+op+2pDPjQMSPuCXmzQ4PtSAmyVsvE
         cA8m2u0xwTwKm1XiCr+Rj8bx8qtg6Fb3NyzWlWtDhSP+7JSxFdOnph3fup4n47p+Jtmp
         hEe+g5jxYzESoG+a+nN6EIEiJKP7jhQN/jeKXUisa5dE2ussfXGYBDHVm0+u69t3Nmjd
         7SpEpc/YmQC+tCdhHv3qoWYWE3+WOxxTGkh9xLCF568NmA0NvL14nhfs0MbmUg40OBvk
         jY/A==
X-Gm-Message-State: AOJu0YwrFeTWDJtubPaL7jG1pNn/GWIO7GRU5Xh9h2qnmwVh5bJEhbq8
	CnsDNcsI0wxMKN5z6HwOPpg=
X-Google-Smtp-Source: AGHT+IGMktxjM/qsDQ11rUiNkkQ0XT7nVRjtjMGwgTOrfXbrq9w1emNOsCBSN2+HCjKxTRsLWUaoJQ==
X-Received: by 2002:a05:6a20:9195:b0:19b:5cbd:efd0 with SMTP id v21-20020a056a20919500b0019b5cbdefd0mr1444939pzd.61.1705511232629;
        Wed, 17 Jan 2024 09:07:12 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id lp16-20020a056a003d5000b006d9a0902934sm1662630pfb.70.2024.01.17.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:07:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jan 2024 07:07:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>, Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [RFC PATCH 0/8] cgroup/cpuset: Support RCU_NOCB on isolated
 partitions
Message-ID: <ZagJPoEsLZ6Dg-NG@mtj.duckdns.org>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>

Hello,

On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
> The first 2 patches are adopted from Federic with minor twists to fix
> merge conflicts and compilation issue. The rests are for implementing
> the new cpuset.cpus.isolation_full interface which is essentially a flag
> to globally enable or disable full CPU isolation on isolated partitions.

I think the interface is a bit premature. The cpuset partition feature is
already pretty restrictive and makes it really clear that it's to isolate
the CPUs. I think it'd be better to just enable all the isolation features
by default. If there are valid use cases which can't be served without
disabling some isolation features, we can worry about adding the interface
at that point.

Thanks.

-- 
tejun

