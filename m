Return-Path: <linux-kselftest+bounces-37886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886EEB0F83C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238E31C21D89
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A391F8728;
	Wed, 23 Jul 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCl1oCF8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A1C1F582F;
	Wed, 23 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288636; cv=none; b=aIspDH1RJTV8SEULBkNjFVcgy0wzxVW/BLiO9plYwUW9l+Xm9Q5cf9IN584QcK6gSqr/+co70PIuTJfLCPloIgCjLARWJqtI9L1hHvOmHRchq5/UK7ZoRk1uDjYhyKw2Tvf+Vhl0rAtr86Q/4Q4t432McLRVZPpkZy9rz1KYb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288636; c=relaxed/simple;
	bh=uQK/kDm5O1+JDjGflQAUOpedr2WcSif01QDjqbCyJng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D4YA5cLtsiKjEokh7xH4WUqktVMqNrWEBUJBwYIq4VDJeCWa6raziyQd+mwk3wyhZ6TQqfNtrkyhP6R/PDrDxcqXEM6UuHM426cg0bS+wHaIAHl1Jfwjz9YTGlvSEb4eGPvWSTZjRUo+r2tt6REGtwKDihAk7lkNwCYHYeVYang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCl1oCF8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64ad1cf5-16a5-4d01-a6ef-17f2afa92663@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753288620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQK/kDm5O1+JDjGflQAUOpedr2WcSif01QDjqbCyJng=;
	b=iCl1oCF8ys4oRJWVZXAfqNIkO5CU7zD+DU6vMhIK0aRioPQ5Y0zVdUk6tdh9En5JCwan4V
	uYLXDZwD5BkpQCXcE8fPpNaVCiezcfMeD/SPFn4TYaJ0L2SAHc3EyIY5I9vMP3GSs2VVN7
	KT6YrpPhdn/RxhUeY17tjJK0ZSKToss=
Date: Wed, 23 Jul 2025 09:36:52 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Show precise rejected function when
 attaching fexit/fmod_ret to __noreturn functions
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-2-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> With this change, we know the precise rejected function name when
> attaching fexit/fmod_ret to __noreturn functions from log.
>
> $ ./fexit
> libbpf: prog 'fexit': BPF program load failed: -EINVAL
> libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
> Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.
>
> Suggested-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


