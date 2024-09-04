Return-Path: <linux-kselftest+bounces-17147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E630796C3B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6562822AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4B1E00BB;
	Wed,  4 Sep 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO5Jo5lJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BEA1E00A9;
	Wed,  4 Sep 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466514; cv=none; b=rZJli2HBzT05a8GhHKZ1/AfS1gfNKFdfBApRBeFVNpdu7dcPJ9c47vUSIgPNBEqcZDhETbLm6L/U3Bt1BAdY9Mqd6t64VwCTwPVcXjxHJ5lPccB5K2czpoCA8V6/DksGacftpyxwbZX/2y8/3EVaFbZV1Ix8ld43hG7sFNZkNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466514; c=relaxed/simple;
	bh=CQbJvgdx+HftYu1CScSMfRU+2H/4ei0sp9Z+jGmkCNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpQ65xGBN9A3LD1JcbIv2gJqJz0hLhtl5lbJC7gEN8YJ3mJJfE5AEFst7nfa4DWQv9zjMCZA/Bh7IMMtk21pBInFnf5JaWvpkKMT7dogqGtwzBCoyzXLXgSZRjsE16RPOdojisH3liesM73lVXJwxHRP0RA54gPBj2oDNeShSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO5Jo5lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4BCC4CEC2;
	Wed,  4 Sep 2024 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466513;
	bh=CQbJvgdx+HftYu1CScSMfRU+2H/4ei0sp9Z+jGmkCNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UO5Jo5lJh6lThqSjATwMR1CzlfJTm7KFPfOJYJ1IsMqB0jm8XBr5j0Wfv0AgWQaKp
	 mvh5/CfiV1Wss2/+eQpCyZma6E5ZZmdgR30EJb2l8hlHZsxAm0LUZUcFrxt+gdROWz
	 Te1l98LoLmsToNDWJSY9U077ghqZJzSAUwBoUCVKHzh2RVVTh7jRZLXR/Zbjrr7H12
	 RYSCSwn/ivTTczt6njYa9kKwaiRG/Ld1CG/H7k8PljAQHY7OMpQxEMCr9urU2qS5vb
	 AuPdK1Lz5P8MaHSZ1oHgnlCI4odq0PokQGJswJTnXfgIVt6jvC2BW40GHZIgEnpti/
	 Sspv+bc2grKhw==
Message-ID: <559e1458-b593-44c7-92b1-6946c57496c5@kernel.org>
Date: Wed, 4 Sep 2024 18:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 0/3] selftests: mptcp: add time per subtests in
 TAP output
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240902-net-next-mptcp-ksft-subtest-time-v1-0-f1ed499a11b1@kernel.org>
 <20240903162217.07c366c9@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240903162217.07c366c9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 04/09/2024 01:22, Jakub Kicinski wrote:
> On Mon, 02 Sep 2024 13:13:03 +0200 Matthieu Baerts (NGI0) wrote:
>> Patches here add 'time=<N>ms' in the diagnostic data of the TAP output,
>> e.g.
>>
>>   ok 1 - pm_netlink: defaults addr list # time=9ms
> 
> Looking closer, this:
> 
> # ok 3 - mptcp[...] MPTCP # time=7184ms
> # ok 4 - mptcp[...] TCP   # time=6458ms
> 
> Makes NIPA unhappy. The match results for regexps look like this:
> 
> (None, '4', ' -', 'mptcp[...] MPTCP', ' # ', 'time=6173ms')
> (None, '4', ' -', 'mptcp[...] TC', None, 'P   # time=6173ms')
> 
> IOW the first one is neat, second one gepooped. The regex really wants
> there to be no more than a single space before the #.

Good catch!

> KTAP definition
> doesn't say that description must not have trailing white space.

Indeed. Same for TAP 13. (TAP 14 is clearer about that and allows
multiple spaces)

> Best I could come up with is:
> 
> diff --git a/contest/remote/vmksft-p.py b/contest/remote/vmksft-p.py
> index fe9e87abdb5c..a37245bd5b30 100755
> --- a/contest/remote/vmksft-p.py
> +++ b/contest/remote/vmksft-p.py
> @@ -73,7 +73,7 @@ group3 testV skip
>      tests = []
>      nested_tests = False
>  
> -    result_re = re.compile(r"(not )?ok (\d+)( -)? ([^#]*[^ ])( # )?([^ ].*)?$")
> +    result_re = re.compile(r"(not )?ok (\d+)( -)? ([^#]*[^ ])( +# )?([^ ].*)?$")

Looks good to me. While at it, we can add a '+' for the spaces after the
'#':

  ( +# +)

I see you didn't commit the previous modification. I can open a PR if it
helps.

>      time_re = re.compile(r"time=(\d+)ms")
>  
>      for line in full_run.split('\n'):
> 
> Thoughts?

In my v2, I will also strip these trailing whitespaces in the selftests,
they don't need to be there.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


