Return-Path: <linux-kselftest+bounces-20124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D79A3A07
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB5A1F266EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7D1FF7C4;
	Fri, 18 Oct 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnvMho5b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5441FF7BB;
	Fri, 18 Oct 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243930; cv=none; b=ouxhIGNZrsZL0fumAYtvV8FmS6JcQRW5OOou9sTvbm9fNfuNGzoliLBZOuWQmb4Q+fRwWMpkPZUEQrtHgxwJERoiHARd2dOqWWy91YhesM3U5a6279PeEvUtwXSjAXuxJrSzmdGCNhrKfS/R7d98fqBcHGqbq4yq6yrl3GTYwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243930; c=relaxed/simple;
	bh=AQ6fEYmJFBibrj9Gjf/7IjfPAPF78a/92tXhWW6r9J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHK8hxrxNA3l0RpfbavcS1Cn5PPm5Vp7gRNHD3dFpCGMI2TMWkNMaxkgXcbH8ezzpKYhoucrIFeMeC/0PIN8b3WNZ8zkET7sCxarzDozVTm1AnCa8xJoZF3Afg84xPBpAS1Ip/f4JEUzMo/+YfVAlkeEaee9EgLj9UGl0ME139s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnvMho5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9328C4CEC7;
	Fri, 18 Oct 2024 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243929;
	bh=AQ6fEYmJFBibrj9Gjf/7IjfPAPF78a/92tXhWW6r9J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnvMho5bIKzDyOJ43+p9GMEDwTt+923TPizzzgoqnTHxYp4WmHANrPwth7C9MRwHZ
	 YTXnQKYEHNKtHoarVKJURoQ1YdI3TL/OH3l6QrETFjjlNqyWFDoGtbz3WQUrhPW2Sr
	 jeVlkVi8PmL95I+ECMkuFbU8yq5RlOnRbUzVoanPyjzQ15iSHvFjOHKtuT2ub3z9AU
	 TM6BgXIV92ztwBADSXfYWZsOe9YyITPQFEgd9V1jdoaXGRxDlfS7LRplP+62y7Awuj
	 LytB4f3ZZTvwQUCPTAI4Em8X+VI+WhSHq0yzFa7ejaW1MuNb2/3gPMx2fSfQmgAgwu
	 xq3sVmNEncHWw==
Date: Fri, 18 Oct 2024 10:32:04 +0100
From: Simon Horman <horms@kernel.org>
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
	rdunlap@infradead.org, mnassiri@ciena.com,
	jiapeng.chong@linux.alibaba.com, colin.i.king@gmail.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftest/tcp-ao: Add filter tests
Message-ID: <20241018093204.GC1697@kernel.org>
References: <20241016055823.21299-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016055823.21299-1-leocstone@gmail.com>

On Tue, Oct 15, 2024 at 10:51:52PM -0700, Leo Stone wrote:
> Add tests that check if getsockopt(TCP_AO_GET_KEYS) returns the right
> keys when using different filters.
> 
> Sample output:
> 
> > # ok 114 filter keys: by sndid, rcvid, address
> > # ok 115 filter keys: by is_current
> > # ok 116 filter keys: by is_rnext
> > # ok 117 filter keys: by sndid, rcvid
> > # ok 118 filter keys: correct nkeys when in.nkeys < matched_keys
> 
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
> Changes in v2:
> - Changed 2 unnecessary test_error calls to test_fail
> - Added another test to make sure getsockopt returns the right nkeys
>   value when the input nkeys is smaller than the number of matching keys
> - Removed the TODO that this patch addresses
> 
> Thank you for your feedback.
> ---
>  .../selftests/net/tcp_ao/setsockopt-closed.c  | 180 +++++++++++++++++-
>  1 file changed, 175 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> index 084db4ecdff6..4bfa76c28e4e 100644
> --- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> +++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> @@ -6,6 +6,8 @@
>  
>  static union tcp_addr tcp_md5_client;
>  
> +#define FILTER_TEST_NKEYS 16
> +
>  static int test_port = 7788;
>  static void make_listen(int sk)
>  {
> @@ -813,23 +815,191 @@ static void duplicate_tests(void)
>  	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: SendID differs");
>  }
>  
> +
> +static void fetch_all_keys(int sk, struct tcp_ao_getsockopt *keys)
> +{
> +	socklen_t optlen = sizeof(struct tcp_ao_getsockopt);
> +
> +	memset(keys, 0, sizeof(struct tcp_ao_getsockopt) * FILTER_TEST_NKEYS);
> +	keys[0].get_all = 1;
> +	keys[0].nkeys = FILTER_TEST_NKEYS;
> +	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, &keys[0], &optlen))
> +		test_error("getsockopt");
> +}
> +
> +static int prepare_test_keys(struct tcp_ao_getsockopt *keys)
> +{
> +	struct tcp_ao_add test_ao[FILTER_TEST_NKEYS];
> +	u8 rcvid = 100, sndid = 100;
> +	const char *test_password = "Test password number ";
> +	char test_password_scratch[64] = {};
> +	int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);

Hi Leo,

In Networking code it is preferred to arrange local variables in
reverse xmas tree order. In this case I think that could be as
follows (completely untested!).

Also, as the sk needs to be checked for errors, I would
separate it's assignment form it's declaration

	const char *test_password = "Test password number ";
	struct tcp_ao_add test_ao[FILTER_TEST_NKEYS];
	char test_password_scratch[64] = {};
	u8 rcvid = 100, sndid = 100;
	int sk;

	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
	if (sk < 0)
		test_error("socket()");

This tool can be of assistance here:
https://github.com/ecree-solarflare/xmastree

> +
> +	if (sk < 0)
> +		test_error("socket()");
> +
> +	for (int i = 0; i < FILTER_TEST_NKEYS; i++) {
> +		snprintf(test_password_scratch, 64, "%s %d", test_password, i);
> +		test_prepare_key(&test_ao[i], DEFAULT_TEST_ALGO, this_ip_dest, false, false,
> +				 DEFAULT_TEST_PREFIX, 0, sndid++, rcvid++, 0, 0,
> +				 strlen(test_password_scratch), test_password_scratch);

Likewise, in Networking code it is still preferred to keep lines at or
below 80 columns wide, where it can trivially be achieved: don't split
strings across or otherwise make the code less readable because of this
guideline.

		test_prepare_key(&test_ao[i], DEFAULT_TEST_ALGO, this_ip_dest,
				 false, false, DEFAULT_TEST_PREFIX, 0, sndid++,
				 rcvid++, 0, 0, strlen(test_password_scratch),
				 test_password_scratch);

You can check for this using:
./scripts/checkpatch.pl --strict --max-line-length=80

I think it would be good if you could do a pass over this patch with the
above in mind.

Lastly, please include the target tree, net or net-next, in the subject
when posting patches for Networking.

	Subject: [PATCH net-next] ...

More information on processes for netdev can be found here:
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

