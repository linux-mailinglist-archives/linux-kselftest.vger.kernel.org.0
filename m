Return-Path: <linux-kselftest+bounces-37770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DDB0CB20
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBD7A115F
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819B23644F;
	Mon, 21 Jul 2025 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZsAAZMa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CD22D9F1
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Jul 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127060; cv=none; b=l4HLZ7TzdskxVyfm6+GqqHrg2G0fRoD9Alufng9bk8NVjAHfmvQGvoGpjXtF09g4z363WEhT/zUmYjcoxnw8pFL33noulUgBOvVOQ4iZIeLmf/z6GbBO3xIi2bvfkbbkpbWBFy+3gTh2DceETP7glXk01Hn2/qwHkXNxmZZyHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127060; c=relaxed/simple;
	bh=wD4Xi7KgIEgkD90bb/rbS9MSBMuzV/WTmG+c7VjhVRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3V5dThCAAQ/gEREgGx3T8qbPrDHwn5TrWnVB9YYQfRn3wSTlYpr5aNcn6L3TdcqChDy8JMOgVAd+lSIRJu5BOqIF6SbZWXkjpW1vhsH25GdMgIODju+83dDU4yEsz3891Axb6T0N68M+WPEEaFSIyyhO8ZphFEWwj4EwIvSgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZsAAZMa; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd195e9f-e584-4546-ac29-86ae4995c6ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753127046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1+mGVoW6ZkN6g6FnLPkMY9FRQvPhJp0+w/gOlPu9jk=;
	b=xZsAAZMa76GKDitod4BQF+28fG2112Ogcm49mRewW5HsMNmQyW5c//LCJUAByZ+yhsWpXg
	m7nYDZx7H5h1NwbKlRBxTMXQs6QsSuygAwX8XI6MrXbedogwXoRJNKfzEQYHMLxpo+Extl
	D7+gdbk5e3V3wHCcKwGTcCkifSGCSJ0=
Date: Mon, 21 Jul 2025 12:43:57 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Nimrod Oren <noren@nvidia.com>
Cc: netdev@vger.kernel.org, Mohsin Bashir <mohsin.bashr@gmail.com>,
 kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, tariqt@nvidia.com,
 thoiland@redhat.com, Joanne Koong <joannelkoong@gmail.com>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
 <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/21/25 4:43 AM, Nimrod Oren wrote:
> To ensure correctness across all drivers, all direct accesses to packet
> data should use these safer helper functions instead:
> bpf_xdp_load_bytes() and bpf_xdp_store_bytes().

Not sure if the test will be run on the older kernel. fwiw, there is a 
bpf_dynptr_slice_rdwr() kfunc which was added in commit 66e3a13e7c2c.
It uses bpf_xdp_pointer() underneath, so it can avoid a copy if the requested 
data is contained in a single frag.

