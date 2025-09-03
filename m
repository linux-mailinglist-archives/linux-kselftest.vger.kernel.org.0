Return-Path: <linux-kselftest+bounces-40690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA6B42710
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 18:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 757F84E1AAC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9574A303C88;
	Wed,  3 Sep 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvlRZCnH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5929B77C
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917601; cv=none; b=o8FR3JtuIQhq9sKz1GOK/T4EZrb0/p5lpAKXu1E4ksSx1+nQsGN0feZKUMdnq/pJ8DeIxb7/Sgy5paguqhUkWDvSkRdIn1Es4p6zjFAevNw0uQ4y/FA62lQsTWP8k3ol6+vjNAX7Ab6zn8JCkYhhMmWOCg4btE0qXZbRqkJLIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917601; c=relaxed/simple;
	bh=GkT27k8521xKwE4vsVHYIijN+ErqAhuCYeNB+5iTVR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccXpHkZIKpug+QAEGEbY2DYEBpU3R3opDYrb/MOpOgTDfSjPLAexhxMFUcyJWSIlLs1HgYvEwNDVo+zgaEkrdBx6+PkzORJN1jyj9OAt1OoOHPNSVDBgBrCl4ml5QjiqJGkUtbTtCPtiUHXscwx+su+Cr6SjwWW4iKOoqgdB8oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvlRZCnH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <809a98fc-2add-4727-af98-6f72e16c71e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756917593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkT27k8521xKwE4vsVHYIijN+ErqAhuCYeNB+5iTVR8=;
	b=MvlRZCnHdLtPkMM6ZWpEknGYCt88jSY7I/cEeQD9cSaxHJjfW/S92+tLoPcvFO6zldfvST
	6Av55wkxEencakn8CMgJ3Fj+5ElmKwJwae74p3KOO9X0/ew4bGx373NKcNu1JMCFWQg9k7
	LUwIEo7ptFZGaRifa3lsVEbRMYuX1dw=
Date: Wed, 3 Sep 2025 09:39:33 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add bpf_strcasecmp kfunc
Content-Language: en-GB
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org,
 vmalik@redhat.com
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756856613.git.rtoax@foxmail.com>
 <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/2/25 4:47 PM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


