Return-Path: <linux-kselftest+bounces-18978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F898F833
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130DDB21384
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850BF1AD418;
	Thu,  3 Oct 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK8+l19S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D91A4E95;
	Thu,  3 Oct 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727988277; cv=none; b=GghfuyjPbOQtwIPBXHmq2anYDPnQoVP3ZnTb6IMLLIP44MeBim1Y3YTcCwkKkrBkHsQ8+RFXb9GO8yClHdVHIn74uOLIDNfmM5HSQQhBG3kpbA1Ee6gbE7JYXR0SzlQOAaAEbN8fosUY8zq4AvO2pQMBEzA1ZePuAi44mE5IO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727988277; c=relaxed/simple;
	bh=Z/NepnLQvC9zwa506iqymehwr9+AQKb4uIfYu9cH2E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeqwso1/8wwZVYuV9Furh3c/F1nzVuacqYyOd7BUZBAoZlmqC2PrDKAFgWzeKd8bm7GT85511PlSARMfl79WaxQIAAcr7GYjcpJKNd72hFRK6XtUu69QYMZ/XhgTdWTLkC+tPAeuw6zPL11bMDD1+s8y7ik7+Q3iehCSS6v6/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK8+l19S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE95DC4CECC;
	Thu,  3 Oct 2024 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727988276;
	bh=Z/NepnLQvC9zwa506iqymehwr9+AQKb4uIfYu9cH2E4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CK8+l19SonV9F/8OHmIX9AZnWPEyXlF6mWIMkcxFeE3SWnosoNiw/XeAufsSL6+s8
	 //usIvCVUjRilpr/BCZiT9usSpw8AlJj3O20AzA4ejQaiEnd1rX7OJDsBCh6Mop8jY
	 j+h6E+fINX9wpR6y/zBWkztO1pEj7y6akwL52FZ5CPahqMR2AH8+HGIcXOa9YbADcR
	 HKIduhcjmMRpNhq6z0qukg0EdNz5jp9AWiBTyNE/x2+khKBiy6Ll09ePaAgG6D249X
	 zZbJlYKJMI+fj8CNWQJGvCxMlpAeKsOz0tgcNw04UABAZ82EsylqzvoXcK9TCypJUL
	 YSzIcaBS4Tw2A==
Message-ID: <a15bd01b-dc78-4a74-ab71-42b14bb1cedd@kernel.org>
Date: Thu, 3 Oct 2024 14:44:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] MAINTAINERS: split kselftest entry into 'framework' and
 'all'
To: Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, workflows@vger.kernel.org
References: <20241003142328.622730-1-kuba@kernel.org>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20241003142328.622730-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 08:23, Jakub Kicinski wrote:
> The testing effort is increasing throughout the community.
> The tests are generally merged into the subsystem trees,
> and are of relatively narrow interest. The patch volume on
> linux-kselftest@vger.kernel.org makes it hard to follow
> the changes to the framework, and discuss proposals.
> 

I agree with you that the linux-kselftest mailing list is high
volume list and it is hard to keep up with it.

> Create a new ML for "all" of kselftests (tests and framework),
> replacing the old list. Use the old list for framework changes
> only. It would cause less churn to create a ML for just the
> framework, but I prefer to use the shorter name for the list
> which has much more practical use.
> 

I am not sure if the split it helps with reducing the work for
maintainers and reviewers. We might end up watching both lists.
I know I have to.

It is hard enough with one list for people to cc the right people
and the list itself when they send patches. I am concerned that with
two lists it becomes harder.

selftests have grown year after year and we have about 109 subdirs
under selftests as of 6.12.
  
Some of these are high volume, active, and longer term citizens of
selftests: net, mm, and bpf. Developers and maintainers from these
subsystems are very engaged in test development and using the tests
for their development activities. This also includes they fit into
the selftest common infrastructure or core.

These are the subsystems that don't require my attention as much to
make sure builds and installs are working correctly. These tests
have been around a long time and the problems if any were are ironed
out. I sanity check the Makefile changes and if there is new test that
gets added.

There are several other subsystems that aren't highly active. I take
these patches through my tree. Whenever a new subsystem/directory gets
added, I review to make sure Makefile that anchors the test to selftest
core is correct.

Most subsystems' test patches get reviewed by their developers which
is how it should be. The tests should be reviewed by developers
and maintainers in those subsystems.

Can we solve the problem of hard to follow the changes to the framework,
and discuss proposals another way?

- Naming convention selftests/core for core/common framework patches
   We have to get people to do this. New ML has the same issue of getting
   people to use the right ML.


> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Posting as an RFC because we need to create the new ML.
> 
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: workflows@vger.kernel.org
> ---
>   MAINTAINERS | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f3190737f..9a03dc1c8974 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12401,6 +12401,18 @@ S:	Maintained
>   Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>   F:	Documentation/dev-tools/kselftest*
> +F:	tools/testing/selftests/kselftest/
> +F:	tools/testing/selftests/lib/
> +F:	tools/testing/selftests/lib.mk
> +F:	tools/testing/selftests/Makefile
> +F:	tools/testing/selftests/*.sh
> +F:	tools/testing/selftests/*.h

I would add these somehow to core/framework. Some of the
issues CI runs into require fixes to individual test makefiles.

selftests/*testdirs*/Makefile

If we do decide on creating two lists, I would prefer creating
an alias for exiting linux-kselftest to linux-kselftest-all
and then create a new list kselftest-core

> +
> +KERNEL SELFTEST TESTS
> +M:	Shuah Khan <shuah@kernel.org>
> +M:	Shuah Khan <skhan@linuxfoundation.org>
> +L:	linux-kselftest-all@vger.kernel.org
> +S:	Maintained
>   F:	tools/testing/selftests/
>   
>   KERNEL SMB3 SERVER (KSMBD)

thanks,
-- Shuah


