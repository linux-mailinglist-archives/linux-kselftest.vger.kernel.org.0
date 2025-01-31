Return-Path: <linux-kselftest+bounces-25461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB79CA23982
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B433A5B95
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A513A3F2;
	Fri, 31 Jan 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZmNxUlJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E018AFC
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738304572; cv=none; b=T0sKB1Jie63dJWMcNSfdUKaX390GVUn45uQnJTGkEzF73LsfxKwz2GOXxYtfVaKef3cr3lBSIdRRsLdNdDl5w/ibd55IUleUAb4/2R1WbEdK+B6QfrubAF6h/fvhi+UFPZ7zS/JxxT79gTlXg9ee402Zzzqr59j+rI926NXzQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738304572; c=relaxed/simple;
	bh=txktSzkB8qp+h7B6PL4XI68VaK515PGsGP9PT1XlBzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJQLf6e7KwbqO8kHtR6LspsD+TpBGyi0NvbqRaQXqDTTX227U+qT2E7c5C0GAfHNB8GHB2qFVH8wOokZwC9v5rATUdg5htWeXK9zbOiojd1XCbYccbSPlvuCZEWh7BR3gg75+erCogvUGHbwmC+OaQGO6zx179bryQvMyGz4yAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZmNxUlJY; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16e32444-61b0-44f0-9466-b4041dc57267@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738304558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txktSzkB8qp+h7B6PL4XI68VaK515PGsGP9PT1XlBzs=;
	b=ZmNxUlJYHMZ1rhYSA3hiwxINUeEVAOjZWa0GMnN21OpVCny8XY6jQn674Z4yvwi3j1UDI4
	ReWLms9BGaWp+hW997jA/MO/WGIw4jAqKbZuk/UTEYdGwK9J4paf77ayVWMrAAhwZeO7Pk
	silrX2nMGFP8LBtkt6JQbSMsliaLIl8=
Date: Thu, 30 Jan 2025 22:22:28 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: bpf: Support dynamic linking LLVM if static
 not available
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, nathan@kernel.org, daniel@iogearbox.net
Cc: martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/30/25 2:33 PM, Daniel Xu wrote:
> Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
> libraries"), only statically linking test_progs is supported. However,
> some distros only provide a dynamically linkable LLVM.
>
> This commit adds a fallback for dynamically linking LLVM if static
> linking is not available. If both options are available, static linking
> is chosen.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


