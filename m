Return-Path: <linux-kselftest+bounces-29965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75956A7714A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 01:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3643A4761
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB11DEFD2;
	Mon, 31 Mar 2025 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNqZ/kOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F511C3BEE;
	Mon, 31 Mar 2025 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743462797; cv=none; b=Ze0xXTLPqI9PbP+cX0dD+gFhoS4ufEc6CQTg83jL9d42BPLuU7Yka5wCHiC0Yu2Tlo21qE4i/7J/DYhy/ITRjvLusEFCQ9gKLDz/CwfTFanb3H067y+w2O8hoWpABXrijopmb/bYcdbk0KCC3K2n8ktNndhU7YnRawDfYUYe8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743462797; c=relaxed/simple;
	bh=SoXQ0vl/e8Er9ixprO598GbGxQx0cm5urekCqBWa5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUQmH3+RdZ7X41S4chKULwlWxS3DRm+4vQVO/bs9e8kpZLCSF8bPHNTlrMX8tX9G7vYJVK8oL4YMT6D5pXFC0FS3zFZlkmD4NYUn7tJcaGFLShAdBtYAZ87WeU6ZqtJVmDOf8V1ZENHYsc9g6KQBmt5tnQLel3mUg61cbtakkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNqZ/kOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF83C4CEE3;
	Mon, 31 Mar 2025 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743462797;
	bh=SoXQ0vl/e8Er9ixprO598GbGxQx0cm5urekCqBWa5vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNqZ/kOYiEivM4Htiml5KfdEkTPwq20W8ztJ/crC8JhfIrGarHa/UAMGyrhZozM3D
	 6FzuSiugUxLAcQoabTARvzLRT/erRDhhl8kgqC2mn5sDRC0fgO7OuTw/V+S2/TusUS
	 3t6IbCn7LostHAffWitKkWVJvK8y1zj+ZANe5NLrHj/2pbFMjPDT1HGz4CpJkkxf/E
	 1puGlJucyeOd7HcVyGynGU8hvNrClfqP1nuGG20/7wM1a0nXR+VNENGUPPYbub78Mp
	 aavSppLzcmMqU1/VuInP274w/anDts5z5nB0QEvDZF+c2Bjg2TJceEi0Cmt6FV3rvt
	 V8AaIwvEWavDw==
Date: Mon, 31 Mar 2025 13:13:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
Message-ID: <Z-shjD2OwHJPI0vG@slm.duckdns.org>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330215248.3620801-2-longman@redhat.com>

Hello,

On Sun, Mar 30, 2025 at 05:52:39PM -0400, Waiman Long wrote:
...
> One possible way to fix this is to iterate the dying cpusets as well and
> avoid using the exclusive CPUs in those dying cpusets. However, this
> can still cause random partition creation failures or other anomalies
> due to racing. A better way to fix this race is to reset the partition
> state at the moment when a cpuset is being killed.

I'm not a big fan of adding another method call in the destruction path.
css_offline() is where the kill can be seen from all CPUs and notified to
the controller and I'm not sure why bringing it sooner would be necessary to
close the race window. Can't the creation side drain the cgroups that are
going down if the asynchronous part is a problem? e.g. We already have
cgroup_lock_and_drain_offline() which isn't the most scalable thing but
partition operations aren't very frequent, right? And if that's a problem,
there should be a way to make it reasonably quicker.

Thanks.

-- 
tejun

