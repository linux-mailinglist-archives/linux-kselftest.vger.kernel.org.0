Return-Path: <linux-kselftest+bounces-23666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FECA9F96CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E085016A384
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B321C4A1C;
	Fri, 20 Dec 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5s/cyeU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC82594A8;
	Fri, 20 Dec 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713183; cv=none; b=NF+3G47EA+piHjvRUNTmmiU3MfpqTVRwlz/9oEUjYJPrLUTfEGsMjfQ25RXxY36oQ07th5yKUolwL9UMM3OnDgR40Bg6xoPQQVPOOBUUTpxDp3RgTxTl+UrKN37a0OgeVe8nNfWN6WpiBsgBfXmolpcRylvrYOjZ+Xvx1f7AdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713183; c=relaxed/simple;
	bh=yr+4lNW/m2/5RqhgXT+K2R0/IE5cnhKIttu4boiQs8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpIm5hqTK3SAuy7HgMC8sW5vU/ihySXno8oysSvmXW1FM/FoPtkokkmxPs6Ut/iylL1hu/bqwKBlh2mKZ/RM8zPMBuWWdsHP0xLAHBq+v/bzEKn59MqoCmdqXXwOxC62p/R2RxzqOx6yBya7SNsCh8o7ul1fU1Y0vsNfqflGAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5s/cyeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB6CC4CECD;
	Fri, 20 Dec 2024 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713183;
	bh=yr+4lNW/m2/5RqhgXT+K2R0/IE5cnhKIttu4boiQs8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A5s/cyeUuIEI/RIU14+9tVNT+Q+Mq+kJ69YaDzsmeEwi481J7fTjfHQR8J2S24E5L
	 OJdDNlMO8QU5vRSDQt+jfK4YJWUdbOq91F0AYehaQQ+Oh3Wes84AgqEHCy7hm/tg8y
	 e/qhl1TKjWWZUG0CzdT47IFWur+xFtPojDFd+UkHykjCVXcjReAzAnZb9Sl6vLFqvV
	 C9GnQKlqp7QAgv42RiuOOoLMk+NXEwVbbdO91aufkEHuaowCVTXpGvkXMRCDbhvtD4
	 TvPyS8LWGY2nr0KyyHFE5vXxTXZmG8N1XsIJbYfQAg3wu9weWgcn+yuiLR0FWrpjbD
	 RWejeQs5R0w/A==
Message-ID: <71a0493d-8804-444f-b2bb-3f061cf7f436@kernel.org>
Date: Fri, 20 Dec 2024 09:46:22 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] selftests: tmpfs: Add kselftest support to tmpfs
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org
References: <20241219152929.4005003-1-cvam0000@gmail.com>
 <20241219152929.4005003-3-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20241219152929.4005003-3-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 08:29, Shivam Chaudhary wrote:
> Replace direct error handling with 'ksft_test_result_*'
> macros for better reporting.
> 
> Test logs:
> 
> Before change:
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After change:
> - Without root
> TAP version 13
> 1..1
> ok 2 # SKIP This test needs root to run!
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> - With root
> TAP version 13
> 1..1
> ok 1 Test : Success
> Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   .../selftests/tmpfs/bug-link-o-tmpfile.c      | 29 ++++++++++---------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index 657b64857e82..91b30a0ca365 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -41,39 +41,40 @@ int main(void)
>   
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
> -			fprintf(stderr, "error: unshare, errno %d\n", errno);
> -			return 4;
> +			ksft_test_result_skip("unshare() error: unshare, errno %d\n", errno);

ksft_exit_skip_msg() is a better choice here.
The rest looks good.

thanks,
-- Shuah

