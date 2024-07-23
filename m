Return-Path: <linux-kselftest+bounces-14079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B37939F80
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 13:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A5A1C22058
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B7014F9D4;
	Tue, 23 Jul 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="BbSmMJiB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135314F9CB;
	Tue, 23 Jul 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733229; cv=none; b=Ed+CW8p76tG7k2JopQKu/5rAXUl5ZNe42NtfmZP7GNbaPdj31iVFczLRl7CNmHl9Yw7fUn1p+ZMcgoaS4OwDw0+hkMwBNVsDJX8n/woKk5JjWAQqtM8QVW117qTNglPBYdn/qpRPoiKKJL1cg4v3edVdEXW7rBHVTVcyozH2P8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733229; c=relaxed/simple;
	bh=lzL84Xklp4nXKsyWvGSuKKibFi7JFlcWQN/GOSlmaYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/uwKxxzM0MzUjXTGlaHzvD++nAwWLwGnDPXXv3fh9FuJajmxRxKSBwBrNRl1STT69UF3bmOC0XeTr1C9aCFwhxJwk8nDV4vhwyT5bsR4B+rcskV8YvAKaFgpLdtcU/qUn/uBWkZUmNqG66kAkEOJJyyF42Y30RaLpVu6aVFI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=BbSmMJiB; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1721733222; bh=lzL84Xklp4nXKsyWvGSuKKibFi7JFlcWQN/GOSlmaYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbSmMJiBFrCPWR57sb/+Mv/+zV3Eq7EnclVOQhPJLnmu6Ep3IGwTxsdnEOQqrh+mB
	 D70eq1OSesQ6a8xkltNUnBP8mjEjnGDNnTz8u3SDNSyG8NlQCdg4keKunzZHkoSUdS
	 5uTKH43lp6rttj+VZpV8cFrIK7AFMdwxY7BiME/Q=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 23 Jul 2024 13:13:42 +0200 (CEST)
Received: from localhost (unknown [172.17.88.63])
	by mail-auth.avm.de (Postfix) with ESMTPSA id 119A480825;
	Tue, 23 Jul 2024 13:13:42 +0200 (CEST)
Date: Tue, 23 Jul 2024 13:13:42 +0200
From: Johannes Nixdorf <jnixdorf-oss@avm.de>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: forwarding: skip if kernel not support
 setting bridge fdb learning limit
Message-ID: <Zp-QZjrSYsPJ6ig0@u-jnixdorf.ads.avm.de>
References: <20240723082252.2703100-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723082252.2703100-1-liuhangbin@gmail.com>
X-purgate-ID: 149429::1721733222-A575580C-F0E48092/0/0
X-purgate-type: clean
X-purgate-size: 2190
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Jul 23, 2024 at 04:22:52PM +0800, Hangbin Liu wrote:
> If the testing kernel doesn't support setting fdb_max_learned or show
> fdb_n_learned, just skip it. Or we will get errors like
> 
> ./bridge_fdb_learning_limit.sh: line 218: [: null: integer expression expected
> ./bridge_fdb_learning_limit.sh: line 225: [: null: integer expression expected
> 
> Fixes: 6f84090333bb ("selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../forwarding/bridge_fdb_learning_limit.sh    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
> index 0760a34b7114..a21b7085da2e 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
> @@ -178,6 +178,22 @@ fdb_del()
>  	check_err $? "Failed to remove a FDB entry of type ${type}"
>  }
>  
> +check_fdb_n_learned_support()
> +{
> +	if ! ip link help bridge 2>&1 | grep -q "fdb_max_learned"; then
> +		echo "SKIP: iproute2 too old, missing bridge max learned support"
> +		exit $ksft_skip
> +	fi
> +
> +	ip link add dev br0 type bridge
> +	local learned=$(fdb_get_n_learned)
> +	ip link del dev br0
> +	if [ "$learned" == "null" ]; then
> +		echo "SKIP: kernel too old; bridge fdb_n_learned feature not supported."
> +		exit $ksft_skip
> +	fi
> +}
> +
>  check_accounting_one_type()
>  {
>  	local type=$1 is_counted=$2 overrides_learned=$3
> @@ -274,6 +290,8 @@ check_limit()
>  	done
>  }
>  
> +check_fdb_n_learned_support
> +
>  trap cleanup EXIT
>  
>  setup_prepare
> -- 
> 2.45.0

Thanks for the fix. I also assumed that it's fine to depend on new
features after trying to find out how those feature tests are usually
done from the surrounding tests and their history.

The code looks right to me, and seems to behave as expected when feeding
it data with and without fdb_n_learned.

Reviewed-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

