Return-Path: <linux-kselftest+bounces-39235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E77B2AF77
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668743B238E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04723570D1;
	Mon, 18 Aug 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUFtlQs+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957323570CB;
	Mon, 18 Aug 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538323; cv=none; b=r14MWeUi4yDMv8nOtAeAgStN/HEEr0b/k5AuKVYRxqeqnAXlZdUkAAPsFVD9QxKyoaB5EIi8WPgwJyy+Wodb3OWt+CvYV/j+JEgXBU3JMgAQlKfeTypVElCjlEkIB7HmgR2g/3RPm0iUXW/Dsjkh6VnR1/ZXUja2NV1CtQE2mlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538323; c=relaxed/simple;
	bh=F6rqd65twG2Ytl7e+Uj8rUDrqXJJk2HNV1hEuLPJ9T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3tYjOqvc1QJ7Vp4GQGgY9Khde8PaN8i/q8CJexcrhOrY0vWgKVcVT9T4jJkPg8KGobEsEl9JHJJcqhGuEDDkRNZrJkotlTOW1zxMzPYrfNeFcXggafKmnU2r1S8S3dCDdm26b/ATIzvfQogA58WA6Bpc0CqF4SgQSECaZCEdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUFtlQs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A108C116C6;
	Mon, 18 Aug 2025 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538323;
	bh=F6rqd65twG2Ytl7e+Uj8rUDrqXJJk2HNV1hEuLPJ9T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUFtlQs+DJFRIbzOAdAhwmPJpJ6+NT1itKCRAL6jgauUXRa6jh81Jauu3CC7yEruR
	 0A5ZXdixv3LB1hZVGQUhdzZ1QmrWNx1vd0Ki1Q2K0zI+w8Z2uEBn8iKn8pkY+AkFia
	 fKM7qStwXnVWdBOsh4EWanPdB2Gv9a9qjWMEKpa2mQEkvuEJg0Q9XMZ2nNZeQIE9Ln
	 oP4CyhqA6AlrVjPopomaMmDE2dOyrRnDC6paT4mUdsOuL48cbhmYNB78dVeKsKx68T
	 hLUEwdSXs/svyY3al+uS4eyCKr+LeH8zXdRDCllwybQWlfC1cdj7JfR67Rd+jua7FI
	 67/QetZd6IC7Q==
Date: Mon, 18 Aug 2025 07:32:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Djalal Harouni <tixxdz@gmail.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
	shuah@kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, tixxdz@opendz.org
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
Message-ID: <aKNjkp5vR2ES-2Xw@slm.duckdns.org>
References: <20250818090424.90458-1-tixxdz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818090424.90458-1-tixxdz@gmail.com>

On Mon, Aug 18, 2025 at 10:04:21AM +0100, Djalal Harouni wrote:
> This patch series add support to write cgroup interfaces from BPF.
> 
> It is useful to freeze a cgroup hierarchy on suspicious activity for
> a more thorough analysis before killing it. Planned users of this
> feature are: systemd and BPF tools where the cgroup hierarchy could
> be a system service, user session, k8s pod or a container.
> 
> The writing happens via kernfs nodes and the cgroup must be on the
> default hierarchy. It implements the requests and feedback from v1 [1]
> where now we use a unified path for cgroup user space and BPF writing.
> 
> So I want to validate that this is the right approach first.

I don't see any reason to object to the feature but the way it's constructed
seems rather odd to me. If it's going to need per-feature code, might as
well bypass the write part and implement a simpler interface - ie.
bpf_cgroup_freeze(). Otherwise, can't it actually write to kernfs files so
that we don't need to add code per enabled feature?

Thanks.

-- 
tejun

