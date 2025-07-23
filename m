Return-Path: <linux-kselftest+bounces-37889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B53B0F852
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954371C2340A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF91FBEB1;
	Wed, 23 Jul 2025 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="plnHbUig"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075914B96E
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289031; cv=none; b=Is9Frm7UTnMjCLvDQ5rmqnNVXZbA51iBXeWtwkuifYU9O9bSL5xhefaF9K7Iy513+wq7VwzGtHO3tCr7EyYGXqYRPytFJW5T8qFIe/orYDL3NsjIxWet2yaaQu23CCRvmBTSJ3pVH2BnrGOt+TpKSPtRoyVdd9cLSgwHRZREk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289031; c=relaxed/simple;
	bh=guy1THaqZXr+J9mp8qz0W034I+DBqK33XEmscipM+H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i09UEq4cQ3UU0i9nFBGcp+bFTfEpzUIPSZ4FHHCN8Nesoa6d6axnA3iiKsBdqT8MlYEp/ZHnqYRkwOgEmPs4mL1LTlY3UDlp/lYKcD0aSL/JuT6abS8o3fGGb4Rucmr53CwJPtAY2jfh2tAdbq3/ph7YuGwbeCby+PEuC1FY+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=plnHbUig; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87b26791-5a3c-49b2-9d02-a8b42a22e0f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753289028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ekh9tl/P8hIJmxG1pXhqX01V9iSOurqGVnHpkN4ek0=;
	b=plnHbUigAYs6bYqaIH+1khT1EVQFLKnYGkgiVvG8l+9ge8oAzNbcbiXEss3OFjL19YXINK
	fLPXnuMlrwUFDSkL/MSNmZtKKLJMz0vrSiolh8yAtjt4p01cmbHfSx++xD0UrHyp79f2o+
	av92OLYu+bMYwAWC6TMrbpPyaSZco2Q=
Date: Wed, 23 Jul 2025 09:43:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Migrate fexit_noreturns
 case into tracing_failure test suite
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-5-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-5-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> Delete fexit_noreturns.c files and migrate the cases into
> tracing_failure.c files.
>
> The result:
>
>   $ tools/testing/selftests/bpf/test_progs -t tracing_failure/fexit_noreturns
>   #467/4   tracing_failure/fexit_noreturns:OK
>   #467     tracing_failure:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


