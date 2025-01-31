Return-Path: <linux-kselftest+bounces-25501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D70A245A5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 00:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03971676B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163061B414A;
	Fri, 31 Jan 2025 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OiydVhAd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFB2AD20
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365683; cv=none; b=tBSoQhqYVBil7M63qtaCARRDuaXOyQKBMkjMxSIa3tesYCRgHeOukaFg6iQD3edYzF/Pz+FBCuukH5jk6g67YIjmXkWC/t8vANprjqlKjyyiwTLMyGhlp5RN4t0WXKUdAryw2FS7CVYtV97dx99GZfcJ2PvIq75aCgwGVx1M9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365683; c=relaxed/simple;
	bh=0jZgI8HjwW28cfb0yaKtcfeEFNmZ3ZmAE62YZbJw6ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnkmALsSESsTj9XLj8hMdk3v69B1d2WrV6jVfl/KOzouF0O2UxKgnI4PEPZAFelcmAUuRv4cxxOY8YtrGccSfEZa/s/mV4TydnjPAINLgWCzeq/7ARM8/hJPvjb0nMijE+S8RdrUjJX/AK09E8Gq0ntlU7mhb/QMpHQ1iN9U0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OiydVhAd; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c7f3209-4259-44c2-8d13-94caa88e1468@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738365679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jZgI8HjwW28cfb0yaKtcfeEFNmZ3ZmAE62YZbJw6ow=;
	b=OiydVhAdi8bt1+1QlgtQB4phkxn784jjz/X9v3lxTEHiH/81D9LwnNMFYNNC0k7RT9raL6
	HbaQRue5qD/cWqVOQcURfQwiUiwsmsTqx1vP3FDc7oT5CppxQhKlr1Y5JrNNijRiGZHfbi
	9Z3uHUeWD0PK+omNuAQjOAsrh23JMVA=
Date: Fri, 31 Jan 2025 15:21:12 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] selftests/bpf: Select NUMA_NO_NODE to create map
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
References: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
 <cf1f61468b47425ecf3728689bc9636ddd1d910e.1738302337.git.skb99@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cf1f61468b47425ecf3728689bc9636ddd1d910e.1738302337.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/30/25 11:05 PM, Saket Kumar Bhaskar wrote:
> On powerpc, a CPU does not necessarily originate from NUMA node 0.
> This contrasts with architectures like x86, where CPU 0 is not
> hot-pluggable, making NUMA node 0 a consistently valid node.
> This discrepancy can lead to failures when creating a map on NUMA
> node 0, which is initialized by default, if no CPUs are allocated
> from NUMA node 0.
>
> This patch fixes the issue by setting NUMA_NO_NODE (-1) for map
> creation for this selftest.
>
> Fixes: 96eabe7a40aa ("bpf: Allow selecting numa node during map creation")
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


