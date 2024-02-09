Return-Path: <linux-kselftest+bounces-4405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87784F36E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D03B1C23BCE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32004C7C;
	Fri,  9 Feb 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ttWrx5vm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776214274;
	Fri,  9 Feb 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474651; cv=none; b=a8XM/E6ueCsSCIKqMMvPFAFW+7f3ZpEeK2bm+v9o0y8BHL0BBovpKyYHk/G7eYo6NF1IUcB4s3wIcvfmzScngiLZzs0GWn/bY6NDc3Bqfo6fANm6ojhZu0t8i60z3N7mErqH0DvG7hevJy8fW2DdPWpNO01Jnqi20BQKB+obO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474651; c=relaxed/simple;
	bh=S90tsiNBuQei67BU/w+VivZ9gITZ6HcfQO6PwypOXow=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BwWg9xNZ8X1Rg+PMVQZROri2hsRe1gYtOPK0vss/BqvLNw4LLWShk3q085AWtFYTEhxxdWG+h/3xtnI39F6kUEvyxz4VtTXPWXAY1xkQH8kHZ8xjhX1UCc0uCoSY5+tvsUXPFkNnwyGCABJ5Ev39l8/4pEztU2qJ38jNB1fM6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ttWrx5vm; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707474651; x=1739010651;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=8cmbdcMBJ5Ld8b8nyy4kSbgPecC+AcRoULRs7ZzT0pM=;
  b=ttWrx5vmjZrPe2Bpm9Q3heWlHq6ja7Frh+iFFuZKo2OdHAaj6c28SkVN
   v6OanHqEQIjnfu5uu3Kz3Iuj+Ck71Xp6yIEde+l8XmKTRVFwXuEx2qp4X
   iK2qdWTpjJqqEHlLys/94tm3KhcsfyUVedKSc3IbnG7kVmia9RDb9TCu6
   8=;
X-IronPort-AV: E=Sophos;i="6.05,256,1701129600"; 
   d="scan'208";a="636863554"
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:30:47 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:32464]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.19.116:2525] with esmtp (Farcaster)
 id b6386548-311a-4f21-b695-73bf0bfaed3a; Fri, 9 Feb 2024 10:30:45 +0000 (UTC)
X-Farcaster-Flow-ID: b6386548-311a-4f21-b695-73bf0bfaed3a
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 10:30:45 +0000
Received: from [192.168.8.114] (10.106.83.14) by EX19D018EUA004.ant.amazon.com
 (10.252.50.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 10:30:42 +0000
Message-ID: <4c17a7bb-c32c-4314-bd29-6d74b2413d54@amazon.com>
Date: Fri, 9 Feb 2024 10:30:38 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: SeongJae Park <sj@kernel.org>, <shuah@kernel.org>
CC: <keescook@chromium.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<Vijaikumar_Kanagarajan@mentor.com>
References: <20240208212925.68286-1-sj@kernel.org>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <20240208212925.68286-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 08/02/2024 21:29, SeongJae Park wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> While mq_perf_tests runs with the default kselftest timeout limit, which
> is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> AWS instances.  Hence, the test always times out.  Increase the timeout
> to 100 seconds.
> 
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Cc: <stable@vger.kernel.org> # 5.4.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   tools/testing/selftests/mqueue/setting | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/mqueue/setting
> 
> diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> new file mode 100644
> index 000000000000..54dc12287839
> --- /dev/null
> +++ b/tools/testing/selftests/mqueue/setting
> @@ -0,0 +1 @@
> +timeout=100
> --
> 2.39.2
> 
>

Added Vijai Kumar to CC

This looks similar to [PATCH] kselftest: mqueue: increase timeout 
https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7 
which was increasing the timeout to 180 however it's not clear why this 
hasn't been merged yet. I have seen the same issue on v5.15.y so it's 
very likely that we will need to apply this on all LTS branches not just 
5.4 as mentioned in Cc: <stable@vger.kernel.org> # 5.4.x

Hazem

