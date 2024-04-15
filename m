Return-Path: <linux-kselftest+bounces-7941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8768A48D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 09:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F118284A5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2D2110F;
	Mon, 15 Apr 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrwHH+Yb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDB1F614;
	Mon, 15 Apr 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165674; cv=none; b=Y4NifN/1LJkP/c242yYE1vGppM/K7SwT8qIG7MqnNdPDOJPsGywn4pXuiS6nNLFwOJI+3I3PJrKhgW15SQWV/dY0Ng6G8NtEYyx/DkKpG4Tnkpr3n71RFcsp5LNoHyQbHTXTNYjyOaV50vhMwckRVbgKsXbbdBK6wYteY/8JXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165674; c=relaxed/simple;
	bh=VbBqtDwYH0uolRlSGs6w3s0f0N3BbyJC4yI5949TM+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0a8lvDlNhuv0tAFNa56VicXjv5ubT/0fsoPK8ayLGjG3vqvlC/z6pxBPwbW/skeM60b3M7tat4klSKapSWn/BAJAJwAPVd8Tz80f6rksmTMY6utPZCcScEiJ/JKe8YGaHVk53ZQ+YJZzWWpU/OvfQ+BRsIF6z/wC8AEda8gHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrwHH+Yb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ee12766586so1825974b3a.0;
        Mon, 15 Apr 2024 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713165672; x=1713770472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSjWt43xrIQ4UPQsjgQPkSI4uu9dZcpjEC/70G7+qCk=;
        b=HrwHH+YbepiS1NL6OCEcIbvJlxsLAtynNT/7KqqDOh7huvpTVpJgTY1oAf+DyWicqS
         mJU8kfXxld7Zei6dES+eJv/mO0AIhNGYGph9yPwsgg+Y/gch7ec6tlGWgbwrfXKLR0Iw
         p0NrAvCVNeqSuOQYkCn+ajlb+JDyJh9cjV6Mncq/RCz6ax/cbxnqz6AOHP/DnX7sEeMH
         HzREsUwJahed4TWItwSed1N1mAyedSl0DaRICS/DbSF4EM4iA249McOYCl79UKzdmHGq
         d4BWT6TTYgY9wSRzK1Wy8ewuqKdmTSGBuAo8MLFkTz6Ba8jb/3YrL32MyYmaB0+6a03g
         xFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713165672; x=1713770472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSjWt43xrIQ4UPQsjgQPkSI4uu9dZcpjEC/70G7+qCk=;
        b=xP84iPVUuaV4a5h52BQRlLbDGvAwdYAIfT8kkPyfviLuGYleAK0ScddzFP8LQ/5YyC
         BjBAcp8D3swykfiCtYadhWS0yEezY6aOg+RxPK1TZlNsyfRJ2Or5oTQpMfiHAfooYqmp
         KXwGx3VZARj3nOdRJiwauYGaobAxTn8UjxMbhLg04wAKAHl03OGMqlsBbuNHkSKWQD5x
         R0mA2++HSi6E8r1gbwGTon8NmE3gy5l6M/GONKh2nA+BUkJ1n1j0qwnZaMTB3oDYjZkQ
         GhICpsLgbDm2/bZrBm8H0BfQ+RD24MfE92KGzFR5N995vdHDRIHMXydBlRwi9XkgAy7S
         C9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFrLFzq5PXKP8kl0xJ25dqKQYQ9z4d1bmYGmZO8RjMHO65QIYsYEEoFvzlM7ePt7OyvS4FtKSyyshfF5m+We9iS18Ep50t8EndPeYReHc3MI1Ew5i1ob7H/OF7bmKuoQSwp6aguxnk
X-Gm-Message-State: AOJu0YxnYScCEWtLfNHrr038/wqIXngO+AN5Ctg0w63apVAvzlu73jf0
	LJRLGaqILuyPxVpSzhdyFLo2kTXP7SDxFpENivir+HH63qPlZHbt
X-Google-Smtp-Source: AGHT+IFMW+TSkniwUJ26r3p4R0gkuT4yVbTCCQdX2paWysXKhSKD28g/PYIsWKuWenIdoyO+eNIzfg==
X-Received: by 2002:a05:6a00:3a1d:b0:6ed:4a97:10cc with SMTP id fj29-20020a056a003a1d00b006ed4a9710ccmr14514380pfb.3.1713165672167;
        Mon, 15 Apr 2024 00:21:12 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j16-20020a62b610000000b006ecceed26bfsm6560192pff.219.2024.04.15.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:21:11 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:21:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, Benjamin Poirier <bpoirier@nvidia.com>
Subject: Re: [PATCH net-next 01/10] selftests: net: Unify code of busywait()
 and slowwait()
Message-ID: <ZhzVYgjBmELthSUX@Laptop-X1>
References: <cover.1712940759.git.petrm@nvidia.com>
 <db8b8885e254893bba61d824d7cf2a6774dcb336.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8b8885e254893bba61d824d7cf2a6774dcb336.1712940759.git.petrm@nvidia.com>

On Fri, Apr 12, 2024 at 07:03:04PM +0200, Petr Machata wrote:
> Bodies of busywait() and slowwait() functions are almost identical. Extract
> the common code into a helper, loopy_wait, and convert busywait() and
> slowwait() into trivial wrappers.
> 
> Moreover, the fact that slowwait() uses seconds for units is really not
> intuitive, and the comment does not help much. Instead make the unit part
> of the name of the argument to further clarify what units are expected.
> 
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 22 ++-----------------
>  tools/testing/selftests/net/lib.sh            | 16 +++++++++++---
>  2 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 4103ed7afcde..658e4e7bf4b9 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -95,27 +95,9 @@ source "$net_forwarding_dir/../lib.sh"
>  # timeout in seconds
>  slowwait()
>  {
> -	local timeout=$1; shift
> +	local timeout_sec=$1; shift
>  
> -	local start_time="$(date -u +%s)"
> -	while true
> -	do
> -		local out
> -		out=$("$@")
> -		local ret=$?
> -		if ((!ret)); then
> -			echo -n "$out"
> -			return 0
> -		fi
> -
> -		local current_time="$(date -u +%s)"
> -		if ((current_time - start_time > timeout)); then
> -			echo -n "$out"
> -			return 1
> -		fi
> -
> -		sleep 0.1
> -	done
> +	loopy_wait "sleep 0.1" "$((timeout_sec * 1000))" "$@"
>  }
>  
>  ##############################################################################
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index b7f7b8695165..c868c0aec121 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -58,9 +58,10 @@ ksft_exit_status_merge()
>  		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
>  }
>  
> -busywait()
> +loopy_wait()
>  {
> -	local timeout=$1; shift
> +	local sleep_cmd=$1; shift
> +	local timeout_ms=$1; shift
>  
>  	local start_time="$(date -u +%s%3N)"
>  	while true
> @@ -74,13 +75,22 @@ busywait()
>  		fi
>  
>  		local current_time="$(date -u +%s%3N)"
> -		if ((current_time - start_time > timeout)); then
> +		if ((current_time - start_time > timeout_ms)); then
>  			echo -n "$out"
>  			return 1
>  		fi
> +
> +		$sleep_cmd
>  	done
>  }
>  
> +busywait()
> +{
> +	local timeout_ms=$1; shift
> +
> +	loopy_wait : "$timeout_ms" "$@"
> +}
> +
>  cleanup_ns()
>  {
>  	local ns=""
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

