Return-Path: <linux-kselftest+bounces-9050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25918B5E2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A701F21DD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5427882D7C;
	Mon, 29 Apr 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="InaVhfaI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A281741
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406048; cv=none; b=IjVEbJ4M0pKZBNz8KzqBzTJGU8vnYjmkQN4MlpJRLGgmVRQotKgEqKNU66KlHKMIahaUFqzZ3KbW5srHFUQGgQUKQjNW3m/838EVGW2ZucrA96d6lN50wGoUoFFOOt+Joik0m4hlN94CgRVoUg165u0amPWebZyVFady8ukVUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406048; c=relaxed/simple;
	bh=3tMffTlWqYOLrBeShO5Vw6pzAWYKcBMjzLueCWRTp70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3cEjQXo8CrWqDPyvibb2/wCOGPA9ph65S/XKvMELkaHJyWewn8PHlonhcXuWvtFLyI24Y62YVmYdrvJKpiXRaZ66skqh4qlNNh67z7MaMPTC79fiPH9HwmsOaivCKhryVrvom2YaLjx4/9h9VbbR2pvmErPS3lo7MkD74X9Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=InaVhfaI; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19952499-cebe-4e77-b830-d0a666cde651@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714406043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tMffTlWqYOLrBeShO5Vw6pzAWYKcBMjzLueCWRTp70=;
	b=InaVhfaIK0qTVZejddevfW0119rTt2RItxwT1O86a3+cJsJXhzGVgdQLGSy5DUOR2ySjlI
	I+16Lik24Q17NaX4ZRqtMc9cneQCRKKKJlkLNSO4xsr55JPiFe5yWFk90IdLN86wuvMdw2
	yKagq/qvQcm5hb6PsZILr561ZW7lqjk=
Date: Mon, 29 Apr 2024 08:53:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Free strdup memory in
 veristat
Content-Language: en-GB
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
 <ded44f8865cd7f337f52fc5fb0a5fbed7d6bd641.1714374022.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ded44f8865cd7f337f52fc5fb0a5fbed7d6bd641.1714374022.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/29/24 12:07 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> The strdup() function returns a pointer to a new string which is a
> duplicate of the string "input". Memory for the new string is obtained
> with malloc(), and need to be freed with free().
>
> This patch adds these missing "free(input)" in parse_stats() to avoid
> memory leak in veristat.c.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>


