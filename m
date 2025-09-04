Return-Path: <linux-kselftest+bounces-40727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD9B4319B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 07:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23531B27BE2
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 05:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD2D23B627;
	Thu,  4 Sep 2025 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVd2RIGB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE68F40
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963858; cv=none; b=sQ/tVsz4fGDWeC8usaD8+PVYLsrhUMOv6FgpNfZcPPdQMNU2hxTZxErUXgy/Xw/zTbMaT9D1Piw1rOuLT6t2fnM2RX8iGNrVRLDeVpeUkdTpM6ZkfPV/4CgaC+SRR7geb1elP7l+4QAy9dQXJWicfJOe7ZabPaAEhrehwo99tDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963858; c=relaxed/simple;
	bh=QbtysNsVS2fD+bIGwCcBf0x7URUoQDF5HoZ72mIJ+r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXpng/8cbLdalUep5/U6syOMyuPGHudmKv39jAbHRREYEn0VaVm1tgiN3emN3EzfDLq/NoQKh1Qzvb43kHMcz5+eHfGd7wrYEv1N9bOzQVL1VWFi/x6WPPUC7/+KSkAvjvl+Rt5Hx4kNRUQjSyuxmMScMQpIq1N39gpHsuvc+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVd2RIGB; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b86ceb7-5dd4-4531-83cb-4b0229caae97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756963843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbtysNsVS2fD+bIGwCcBf0x7URUoQDF5HoZ72mIJ+r8=;
	b=eVd2RIGBDJEqSGK3foxgaEsefELGup0McpeOxqMLEq8zE0kMF8LW1sewIM34PXqFyR2UWZ
	Y8Z0imChzysfJSH3d01WAbvg95txXcCA/P4kYki9h54T6YTdOpUJ9SyiXKsrV5zjTmkdyj
	m4KAJil8Ahm/OUmmTAeEqU+X2/HlRMw=
Date: Wed, 3 Sep 2025 22:30:30 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] libbpf: remove unused args in parse_usdt_note
Content-Language: en-GB
To: Jiawei Zhao <phoenix500526@163.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904030525.1932293-1-phoenix500526@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250904030525.1932293-1-phoenix500526@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/3/25 8:05 PM, Jiawei Zhao wrote:
> Remove unused 'elf' and 'path' parameters from parse_usdt_note function
> signature. These parameters are not referenced within the function body
> and only add unnecessary complexity.
>
> The function only requires the note header, data buffer, offsets, and
> output structure to perform USDT note parsing.
>
> Update function declaration, definition, and the single call site in
> collect_usdt_targets() to match the simplified signature.
>
> This is a safe internal cleanup as parse_usdt_note is a static function.
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


