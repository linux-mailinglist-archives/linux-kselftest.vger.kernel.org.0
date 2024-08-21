Return-Path: <linux-kselftest+bounces-15921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8895A64D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394DCB21DFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6175170A2A;
	Wed, 21 Aug 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o8r9CJvk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948516F837
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274208; cv=none; b=dc3o9rxRiBW7QzP7CnKsckp9xm8y2xiymApPZ8KT00h7L2rfJKnoQN4tC7Uj+jNJjJb9BEGMQs4JbI4CJitdeGpagSmVzYfWuTU4WxZePldvowzquMAF1pwa4O9IvQeCY8R66iFDvwoUstvwUEXeo6JHKxJe9w7+z/Y+bGWue0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274208; c=relaxed/simple;
	bh=cDiCTjyGyZe6FUSam0Z4JCrWJlpk3SZafhYt0vOYGWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1gLa1OSvG/6XNUZak8ZVAwLJ2Ex/9uDRYx996qDq+OPYOJ0s+EJ48IYF4m4G738wg8pn3C0l+8Rs0MMi4l2uAx9XyfR0MAqSUqAs3djqKTORctZ+VaW9M3LlQgBRLTTwJ9H2e5LC4kd7j7c1oMntO0y1TutIJCJz32wDQ4qTg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o8r9CJvk; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724274204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE5cPhg4MLsyr29aiCjr4pC6mToQl9x3/vD2EHyeviM=;
	b=o8r9CJvkVR0wt00ZhDkU/BBJJRa9InBPX1/l4AHbdachzNoGXhrD28SzAjoOX3wLsyyaub
	Y0JSnUH2RYXcn7FsC8/BTtc5B3aDkvCTq3psY3JlNlztgjAsgqqJ7hFWw3lYXmX/QKVxEn
	UutD4qJnaXdWkQf02/p/Y6QrNFQ9mw4=
Date: Wed, 21 Aug 2024 14:03:17 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer
 checking
Content-Language: en-GB
To: Hao Ge <hao.ge@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240820023447.29002-1-hao.ge@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240820023447.29002-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/19/24 7:34 PM, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
>
> Smatch reported the following warning:
>      ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
>      warn: variable dereferenced before check 'buf' (see line 454)
>
> It seems correct,so let's modify it based on it's suggestion.
>
> Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
> check in get_xlated_program()") fixed an issue in the test_verifier.c
> once,but it was reverted this time.
>
> Let's solve this issue with the minimal changes possible.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain/
> Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() helper")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

In the future, please change subject '[PATCH] ...' to '[PATCH bpf-next] ...'
so CI can properly test it.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


