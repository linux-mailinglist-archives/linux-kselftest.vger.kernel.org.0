Return-Path: <linux-kselftest+bounces-48787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8ED15093
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88D0930303A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6703242BC;
	Mon, 12 Jan 2026 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0jfj09o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89EF320CD6;
	Mon, 12 Jan 2026 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246314; cv=none; b=izIoAI27Irvydf7ioBL/tpDOAnRmqtyTfg0MNtDQWEtBMzJCXDie43Tmb98akmMmrZD0NhKuKH9aDvFQ4bg8ENzyqc3A9iUHNCpk81AsfwnzMVUopqqklfU1dUwOgYmhBwrGJMjXtf7914T4gDQytFPsoDvwZ4virAbsBFPG+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246314; c=relaxed/simple;
	bh=3w3xFY/eST79iIZcVPfsOoZTYgJHV2ZKR0p8iXN/9iM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iSBvCn00oeAC9dczm5r6MxzMRV0ZV+dgp6yDXI/hXDossV72f/+A4f04P8bmfs6XZRtzsores0CDbdzBEemNngmgh+ide+KnBM3pnfb918Kx4G8quw6Yrt0ZyMn1/7gGLzYhT2TQTKo9Pd8iqWZh/36Gnzn6OPHUgTHZkggqhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0jfj09o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48400C16AAE;
	Mon, 12 Jan 2026 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768246313;
	bh=3w3xFY/eST79iIZcVPfsOoZTYgJHV2ZKR0p8iXN/9iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L0jfj09o0YxZ1CIKdrXiC8QqZrFkuUi61rdXvAhWZF5VPdKfPtCONH36gPGYAJKEm
	 mYOogEeDtvlkbW8wTpd2ny3edxhRtCictiPamE2x+0MYGM0uVCYGgp8iIRjf9vuqo+
	 T81sIK/XCmVWSEszBcGjnK5Mwhnevjf3AhJd1kx4Kkcy4OUNfyv2SKWjqxJOPlAH1J
	 DYM9b3ExyQr1eXdEUevet/rF+dCKiNdg2a1SV6iIfyMmqn3i6U9AOGHywu1d6QaoZi
	 yIN8I+w6KPqCmJtenloDSbLZgRW03WPShWijKacPU1/CAM0DB5i1iaNK7e+fnB9cR/
	 fqpbDpIUigzag==
Date: Mon, 12 Jan 2026 09:31:52 -1000
Message-ID: <47f7e8ef86973528cfc6a03174127a2e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>,
 Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [PATCH cgroup/for-6.20 v5 0/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
In-Reply-To: <20260112160021.483561-1-longman@redhat.com>
References: <20260112160021.483561-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

> Waiman Long (5):
>   cgroup/cpuset: Streamline rm_siblings_excl_cpus()
>   cgroup/cpuset: Consistently compute effective_xcpus in
>     update_cpumasks_hier()
>   cgroup/cpuset: Don't fail cpuset.cpus change in v2
>   cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus
>     conflict
>   cgroup/cpuset: Move the v1 empty cpus/mems check to
>     cpuset1_validate_change()

Applied 1-5 to cgroup/for-6.20.

Thanks.

--
tejun

