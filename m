Return-Path: <linux-kselftest+bounces-25500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF9DA245A4
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 00:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076CD1889925
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 23:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1601B6D06;
	Fri, 31 Jan 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xIXWpV/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB51AF0DB
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738365633; cv=none; b=u4413B/NlJ7yyc3bnulBMqIkYlNwuQjjCuFU/m95oPbJpNURWsfMHVK6oOCrw+7qb6pSvCdjqMi5wqd43eXSSwgXxAHedIR50SrzFrj0e0w6z3fgNn1THPjLOhgdNr8GYYRA5LdPLn/fT59gM6VAvKrfDUkKfp6wEPLr0ieFZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738365633; c=relaxed/simple;
	bh=emQk/OSr538voBT6waZJqbs1DusKxAXXFgqTSnKGxaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hex58eksS3B5cvlei/pTAes5ZcHyCIxu/Cw+pMpbHGUHv/Ic6kENnUMnXTyyuobNO5S2TrZkpFYXKVjaZkbF2CA5uQsSpDWyn5+zhZ0jSUzLZ+F+VZilM1KMG0DrMe3s7S98rhKZCeFWd6d6NzmK3aUVdsbTs203NIK52phn75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xIXWpV/H; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae3c9fed-2cbc-4309-9ab6-8615c373e5bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738365618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emQk/OSr538voBT6waZJqbs1DusKxAXXFgqTSnKGxaQ=;
	b=xIXWpV/HnJtiskiw7NErtR34cKiW9lIo1c1PLOPr10nT+onRlcYbqB76U/wmU5fN7c2lP8
	HNCTs2oncPIxc51KzuQICQ+kLCGDNXgTRGL00jU4rbiSjnJbgbZ5B6kQ4nPoyfigOy1V6O
	noAJ9McqVtpFH05DzgOvnRaQljyLNoc=
Date: Fri, 31 Jan 2025 15:20:11 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] selftests/bpf: Define SYS_PREFIX for powerpc
Content-Language: en-GB
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
References: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/30/25 11:05 PM, Saket Kumar Bhaskar wrote:
> Since commit 7e92e01b7245 ("powerpc: Provide syscall wrapper")
> landed in v6.1, syscall wrapper is enabled on powerpc. Commit
> 94746890202c ("powerpc: Don't add __powerpc_ prefix to syscall
> entry points") , that drops the prefix to syscall entry points,
> also landed in the same release. So, add the missing empty
> SYS_PREFIX prefix definition for powerpc, to fix some fentry
> and kprobe selftests.
>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


