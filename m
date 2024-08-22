Return-Path: <linux-kselftest+bounces-15941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73F95A94B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 03:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69BA1F23346
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 01:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315686FC7;
	Thu, 22 Aug 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzpPP7Vi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050E1101F2;
	Thu, 22 Aug 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724288524; cv=none; b=GETW1RvpTryscy9jfSDbNBU7JVLb1DSjvjwCnm/3K2PBo9FI4AAFjMR2kPZoev7e8kIbWkusXa2ixQRjjBHnpDwvV/WQ8xIkNBXsQ+eSuY3n2hT/uXkhGewxtiT6/fkPML5rCSztI1bY+vdvbKtij4YzI0mwm3QXBuFZ2DNcOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724288524; c=relaxed/simple;
	bh=fho7yigoNJT7U1KQajZC0LtAUCpxXnxEcxYMwYgaq1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICHFYLlQTy8zhRT03QQQdoHfh8/Z5dB7K5+JJY+4yA+XFTY6L+5kzQcU4BZVzBdf2pb7vDfZY/ldLvJuoIT9yJEzgQUNNdKt8KXfu9YziNOIsjRzysmnHMSF887iho/Of0DtOFX96mT+dbOeRaqwPZdvzS8bTh95QI4uCzTM/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzpPP7Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA9C32781;
	Thu, 22 Aug 2024 01:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724288523;
	bh=fho7yigoNJT7U1KQajZC0LtAUCpxXnxEcxYMwYgaq1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qzpPP7VirvMAvrOA8Zj2gUNpG7/QauO+WenfkO+EUuRKRaQITLogtQQ2I46au9rRn
	 NvgKPQO0tNJzdFEpn5xchwRRr8bS8usX2x60NjLi6Zmu6GxSTQCM3QXoOxcrfIMzZC
	 47Fo3yW9QVkxyi+sjPvC7k0p5mmmJ7yGnyG/NxS6JOz6S64SoV0akCILHZIESyxK4v
	 a1s098AdD/bDDPSWu4NuUKa5HtuKr/0QcQbhFEAilbTJuZd8+39Zw0PoGH4Sx+k5YW
	 rU9tFxtB6LFh3f+z9HtPnSIpwQGyMPkRfVFrfIV3iWZ/kvUi/TZgm2o06Gp6JYkQla
	 B7xiKdFU088IQ==
Date: Wed, 21 Aug 2024 18:02:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH 1/1] Improve missing mods error message and make shell
 script executable
Message-ID: <20240821180202.6da48f29@kernel.org>
In-Reply-To: <20240820202116.6124-1-david.hunter.linux@gmail.com>
References: <20240820202116.6124-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 16:21:16 -0400 David Hunter wrote:
> Subject: [PATCH 1/1] Improve missing mods error message and make shell script executable

Would be good to add a prefix to the subject:

selftests: net:

> Make the test executable. Currently, tests in this shell script are not
> executable, so the scipt file is skipped entirely.

Could you clarify how it gets skipped? We use make [...] run_tests
in our CI and it does seem to run.

> Also, 

If you say "also" there's a good chance the commit should be split into
two..

> the error message descirbing the required modules is inaccurate.
> Currently, only  "SKIP: Need act_mirred module" is shown. As a result,
> users might only that module; however, three modules are actually
> required and if any of them are missing, the build will fail with the
> same message.
> 
> Fix the error message to show any/all modules needed for the script file
> upon failure.
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> ---
>  .../testing/selftests/net/test_ingress_egress_chaining.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 tools/testing/selftests/net/test_ingress_egress_chaining.sh
> 
> diff --git a/tools/testing/selftests/net/test_ingress_egress_chaining.sh b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
> old mode 100644
> new mode 100755
> index 08adff6bb3b6..b1a3d68e0ec2
> --- a/tools/testing/selftests/net/test_ingress_egress_chaining.sh
> +++ b/tools/testing/selftests/net/test_ingress_egress_chaining.sh
> @@ -13,8 +13,14 @@ if [ "$(id -u)" -ne 0 ];then
>  fi
>  
>  needed_mods="act_mirred cls_flower sch_ingress"
> +mods_missing=""
> +
> +for mod in $needed_mods; do 
> +	modinfo $mod &>/dev/null || mods_missing="$mods_missing$mod "
> +done
> +
>  for mod in $needed_mods; do

Do you have to loop again? Maybe just check if mods_missing is empty?

> -	modinfo $mod &>/dev/null || { echo "SKIP: Need act_mirred module"; exit $ksft_skip; }
> +	modinfo $mod &>/dev/null || { echo "SKIP: modules needed: $mods_missing"; exit $ksft_skip; }
>  done
-- 
pw-bot: cr

