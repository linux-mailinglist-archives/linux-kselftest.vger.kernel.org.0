Return-Path: <linux-kselftest+bounces-9049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17148B5E2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D750282B7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A578289E;
	Mon, 29 Apr 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="la50SNEx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA782881
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406030; cv=none; b=OAW3NG5f2XzOKZXXj7z5Ride4t+YWVmeh0c3MghWT9s0zX1ME47X1QX7Tnc9LxI1PUiqV3TiivmvxDwf5M6LWNS9BZXn5X7FC5KYj/vyxQz6Q2T9pYERbbOsrMF8SRTZNf/iRN+RmyjbC9SXDllGZfe/jRl/YbSQr5MzVOLc6Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406030; c=relaxed/simple;
	bh=NsRBY74Bfg5heYt2w1gPVTY1zYEHG1o7HaSNvAT0veY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDgovWpjeYrAbWLeW2mTUvyT9/+gT6VjfGChDpQ2p4ANbngdx69K1Obh3vVjZsswLT5QuF7WiXaXLO0uI61BlyNRV5C82+ZbNgw313XW3CLVm4FaOo1Oc8yUx02VVtg8e8t9jxuP+6nHgTkKneonTakIhCjk9gVFFykQl81rI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=la50SNEx; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7eddbfd3-2acd-4a25-8fc4-29689b39c3f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714406025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsRBY74Bfg5heYt2w1gPVTY1zYEHG1o7HaSNvAT0veY=;
	b=la50SNExVrvfi1d39DoSe/ovc3ZWfeh2yzBpLe97/jNasfxZL06OiPIObS5/vmQmymQC/U
	i03mLwyJjyiB46SxI6uSag+80FGyv1z9bzQaW+WRYcFgy+K++1AkLb2Xi8j4jduU92YIlW
	iCLzZN28IhHivqB6wTIIi1mUAsOmiA0=
Date: Mon, 29 Apr 2024 08:53:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Free strdup memory in
 test_sockmap
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1714374022.git.tanggeliang@kylinos.cn>
 <b76f2f4c550aebe4ab8ea73d23c4cbe4f06ea996.1714374022.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b76f2f4c550aebe4ab8ea73d23c4cbe4f06ea996.1714374022.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/29/24 12:07 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> The strdup() function returns a pointer to a new string which is a
> duplicate of the string "ptr". Memory for the new string is obtained
> with malloc(), and need to be freed with free().
>
> This patch adds these missing "free(ptr)" in check_whitelist() and
> check_blacklist() to avoid memory leaks in test_sockmap.c.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>

