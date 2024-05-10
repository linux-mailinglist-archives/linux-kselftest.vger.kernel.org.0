Return-Path: <linux-kselftest+bounces-9983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CFF8C1CDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 05:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F732823E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 03:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3DE148857;
	Fri, 10 May 2024 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFPzsuPb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92033CD1;
	Fri, 10 May 2024 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310965; cv=none; b=rhBjW/8UOcaQ5nF5/y4dfIpwmJ1QNHugvlrCnd4E9Hm1U7kqEFR/2xAQIKXWKaunWWdX732nHGnWggbFz+stq0yYhXAzlHhcYCDteNNHeB2UEPqaELVW0uUR66+CMxtCfOcSCOa3k8c+7wVYcJ2ETZyICRIdG4+KrM7UwT3cuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310965; c=relaxed/simple;
	bh=EZCtcC832okbCoOmAXdjjo9bFvPzED2Zv15Z4Du/YSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMbSy3w/9+Gja3e5jhHE7+CG9owZ6bFWx5/XfWLZYYuH28Z1QAn79dTHVoL1Nsm4/WBHp+sEnmEMcgJClaHpITdhCCs1hzKYjgGuVWGb7n1UE80z0FAf4HqE9tOVoeggHJVNwiQkurbw2KyesPVzuYbT+i17cZRnw4fMC2ANxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFPzsuPb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-61bbb208ea5so1270473a12.0;
        Thu, 09 May 2024 20:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715310963; x=1715915763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eCEQn7dgWiTVUcqJQl6AoPw5dlj4qntOgHjUfcOjVw=;
        b=hFPzsuPbCP7Ms5+cuEXJtEktBjuYDxTdI7FHxXAtWQ0yo1Ps2zWrPCKWM/UE1kPlYZ
         Xwj88pLuj7Nw2xJ9f4EUkM0rDxkJTITCNZBfLfrRE7MRBSuAXHGGFnKx8nqjF2FPrIGv
         RWfwXxyoLeaBlZqsWVbivEJsqYN+AIjPYbAVa4pFH7m8LXZSfa/LO/ulkKIF+R3wYVmy
         VVCsgct2fg7dIc4RtKJzvzvxONeTSaxCYFQaQn0U36Wu5t2fDHiVmG/d/qA9T/XN4Iy9
         F/Z5nEYUulks0rjyPg77mdTPy1uQYZw+IBXZtDvbVv4MlItW6bpho4mwcHZC33hNsAKX
         dBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715310963; x=1715915763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eCEQn7dgWiTVUcqJQl6AoPw5dlj4qntOgHjUfcOjVw=;
        b=GOsRd8xGmKathDnY76TzLPgvLUIj2vk0ZP97h9WGVkV0uWNwz+uThliVEE0jWlHf4K
         7G4i8t6kuxM3scQH7Y4qMePTkH5gaB7Q5JVbKAz/YezOxUNLOugjgUNdLE6pPF1t00f2
         6TqL78bKsMemNJmH3B/LSpUrmBBaBQd7fX+4+8xI/Syx62T5skAEpX5Pxpz3Ry80Vabl
         zNvTfpGCI448afTSXpOkUZPAzwFec1h/WHa2nlXzgEpu5hBhJRoCCOTE5V0MB28jPXvL
         XPgx9DnafOXURedekifFrNtqUg3Isg1xL/9qKkgp2Jz/mRG3IBDp8Crn5LEMd6sog1kt
         JVkA==
X-Forwarded-Encrypted: i=1; AJvYcCVaWAGSt3mkow4JDWxMPPAuJoDaa0qfCWEWquZ0IIS06fZvH695PL3AG+kpaIorbXQmuQWo/a9/DtloQp6Dru5g8ZzzRH+BSZEX2q6dM2PI5XA8kE44k6MolfPRoWm8gE3VrpyoQuCL
X-Gm-Message-State: AOJu0YxoEynlMflQBANOHm/pH1PckKcm1LynMwKKnNhcrmTX+SMtrSAw
	Yza42pt33L0gY3wtPyJFKA0QjaULW76LhlqSTJrvfL6t2CGaaMVsScWEifpB
X-Google-Smtp-Source: AGHT+IE7+Jpi8WD1iSlMGbKoqJjapAG+wbrWmiPigh+jFHBDu8OlAErlx2ysDCFwYE2buJg9MKnrYg==
X-Received: by 2002:a17:90b:4f81:b0:2a0:3a16:7489 with SMTP id 98e67ed59e1d1-2b6ccfed28bmr1219313a91.44.1715310963377;
        Thu, 09 May 2024 20:16:03 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671056629sm2223503a91.7.2024.05.09.20.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 20:16:02 -0700 (PDT)
Date: Fri, 10 May 2024 11:15:58 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vladimir.oltean@nxp.com, shuah@kernel.org,
	petrm@nvidia.com, bpoirier@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: local_termination: annotate the
 expected failures
Message-ID: <Zj2RbpO6tu7Sq8za@Laptop-X1>
References: <20240509235553.5740-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509235553.5740-1-kuba@kernel.org>

Hi Jakub,

On Thu, May 09, 2024 at 04:55:53PM -0700, Jakub Kicinski wrote:
> Vladimir said when adding this test:
> 
>   The bridge driver fares particularly badly [...] mainly because
>   it does not implement IFF_UNICAST_FLT.
> 
> See commit 90b9566aa5cd ("selftests: forwarding: add a test for
> local_termination.sh").
> 
> We don't want to hide the known gaps, but having a test which
> always fails prevents us from catching regressions. Report
> the cases we know may fail as XFAIL.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: vladimir.oltean@nxp.com
> CC: shuah@kernel.org
> CC: petrm@nvidia.com
> CC: liuhangbin@gmail.com
> CC: bpoirier@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/forwarding/lib.sh |  9 ++++++++
>  .../net/forwarding/local_termination.sh       | 21 ++++++++++++++-----
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 3353a1745946..4fe28ab5d8b9 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -605,6 +605,15 @@ log_test_xfail()
>  	RET=$ksft_xfail retmsg= log_test "$@"
>  }
>  
> +log_test_xfail()
> +{
> +	local test_name=$1
> +	local opt_str=$2
> +
> +	printf "TEST: %-60s  [XFAIL]\n" "$test_name $opt_str"
> +	return 0
> +}
> +

I may missed something, I saw there is already a log_test_xfail() in lib.sh

log_test_skip()
{
        RET=$ksft_skip retmsg= log_test "$@"
}

log_test_xfail()
{
        RET=$ksft_xfail retmsg= log_test "$@"
}

log_info()
{
...
}

Added by a923af1ceee7 ("selftests: forwarding: Convert log_test() to recognize RET values")

Thanks
Hangbin

