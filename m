Return-Path: <linux-kselftest+bounces-37056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA2B0111F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADD2565A6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F27141987;
	Fri, 11 Jul 2025 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJGm4sqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCEB665;
	Fri, 11 Jul 2025 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200052; cv=none; b=VoLwq5SyBXifbRhZKXDEhaUfNCsb3j7st/KbnrW8hjgmxE2PXAjtRUjxcnB+36p/5yAcMQ4B7o4/xUEkNNQUZIMmPYm/Cd44p/FKmX33bY91x5jWsqQh7eiFv+ZKbDODXEZcVZ53gdpae0DhGYn7+S0AwFipticv51esi4HyCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200052; c=relaxed/simple;
	bh=LCrOwh5T+ylicI25k9ihSwSw7r5zv4k5mJRrI6eCl8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWbbM9vZfhJkHuqk533Xyp3B8wn2McZRnH0oaSmUD6P53VxUhnj4UdWGYPBRxQG5K+XdA+RHeuncqoMx8r8/PVfP0ecZIzifyegD2miPL7O50ohXxhe8j+CvyAH9bGlRxZ6RMiPwGvFRBOGvSDxZFwBi3FguPxQe7EP9IlDicRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJGm4sqI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-749248d06faso1429790b3a.2;
        Thu, 10 Jul 2025 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752200051; x=1752804851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDVaSyXHOgKkfMXp9CzyBGiGzi34di4+wXZorD4U00k=;
        b=gJGm4sqIYm2FHSLmIrJQFmSmK5ncNbcW4yIerAX+EMDe1v2E21iO1mMf9O1ktWiPjr
         A9eUD3uelLczoYtm3fAxFS5nVfqitkHlF2lFs5I+pfkL9P2IPBDo1WSWk5swXADa95qw
         J8xi3+f1msn/KMn5cY5v6GHORJQzChH/MBzVjgaECpms2YznFvnoZ8NMKeH0vLC8dS/W
         3/iebThbR+xsCXL7em6Jg5GDhgMaNW0rrVVVHVY27DdKwar/ZeVImYn4o+RaPyQiM0Pc
         Q5VWApw8YP7sbYGsirWFVbkMUt4Qsa5rJ635sZ+2MmlWd7ia+FYiKXJ982W8b//fMmIj
         v+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752200051; x=1752804851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDVaSyXHOgKkfMXp9CzyBGiGzi34di4+wXZorD4U00k=;
        b=mmlC93DRAjz/Yz6mwj+zJD1YX4V0q5FpXhjfpQkD50YsakeOaasST7+hFcb8AngUMa
         YETkoGUt46R2Npjid1Ghw1JD8xdBMpjjNlRy3H7z3CHBFSi+7xK6WfZt90Ws0fY4RnlX
         Tc4/d4iKY+vwv8kCHXdiu1dkphmdl96zaZk8R4oWdJDd5XoGram6NI7wpx+wchcN8noM
         A9ZCNx+ktml4rIlnAyLwprOcLEuwV4rMtQSNmlFmEV88cS7M4EG5jcLCByd1Hkvz8woJ
         +B4XUqTj3FGCEy7LaSbrVLydo68cQ2OvNHrCXkja0cyZGo+tILqlQg3uhr/S+j5Xjd1n
         I+mg==
X-Forwarded-Encrypted: i=1; AJvYcCUzGz8VQyVksU8W7Ah5dxSJAJvqJ5ycrM3xZt26I2QdAnPz872Szi/s/06cw7MAByft4cFbqC372sDhvZf70o4=@vger.kernel.org, AJvYcCVqkacqVY5CmtfJ8ECpsk1SweEW/ko9FuPaatSyNRx1Q9QDZX+Gl+s+X/LFusqI/fRqEKKU8vF9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywred9n++FA1NYPpbF3trYNtRkjNRlm45I3QKjxcGeVpiB/7VCI
	SZ2OT/oelktaKFHwCPwQwQKKFvLdkwNnBBYbConz27DTBqQgEpbyhFQq
X-Gm-Gg: ASbGncuYCFpzE0s7ageaBGwfE6gCyiopzneTl+2cQSEzVpLeg8ZR9v5rYjDZQ3g/NBM
	Nm4GM8OAs/pEa8ZyIBrTDR8523u7PEZnptYtGVqiiBK5FHzeWBZ8NKGay3c3CqxQpCVCHAFG/cK
	WUflETljVjYXkIYiDHm3XWG9t7W+8pHnmGLspq5jtpuYhd22psmD65zC4g10CuZobPy2sJUh41B
	m8HffJ0w4bBzOSwV82CC05RwqfixKsQuQrvdJ5j536XltHVM1UDioPYjGCnvi4gVgh4s0Q9fNob
	ODJS3IcGcMD0ddQAWWkLNqUBhMsLIdk6kUSrcxTJPw/oe/Caw1pN4GncQwFrj+keCe1djfwCslp
	xlWoA8X7u7vXNcFdIumtH+YmhGoA=
X-Google-Smtp-Source: AGHT+IHFNG+mkaoyTbxab0Dd/8KAN1YsV1lJbxpq7TB3WKjPwYmtrNAjCLeCdS4zcakk+sW0UpC4oA==
X-Received: by 2002:a05:6a20:549d:b0:1f5:6f95:2544 with SMTP id adf61e73a8af0-231202f284fmr2235036637.33.1752200050765;
        Thu, 10 Jul 2025 19:14:10 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5e9asm3854821b3a.25.2025.07.10.19.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 19:14:10 -0700 (PDT)
Date: Fri, 11 Jul 2025 02:14:03 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: try double sleep to give WQ a
 chance
Message-ID: <aHBza5P50wcKjG_h@fedora>
References: <20250710145312.3361964-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710145312.3361964-1-kuba@kernel.org>

On Thu, Jul 10, 2025 at 07:53:12AM -0700, Jakub Kicinski wrote:
> The rtnetlink test for preferred lifetime of an address is quite flaky.
> Problems started around the 6.16 merge window in May. The test fails
> with:
> 
>    FAIL: preferred_lft addresses remaining
> 
> and unlike most of our flakes this one fails on the "normal" kernel
> builds, not the builds with kernel/configs/debug.config. I suspect
> the flakes may be related to power saving, since the expirations
> run from a "power efficient" workqueue. Adding a short sleep seems
> to decrease the flakes by 8x but they still happen. With this
> patch in place we get a flake every couple of weeks, not every
> couple of days. Better ideas welcome..
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: liuhangbin@gmail.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 2e8243a65b50..b9e1497ea27a 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -299,6 +299,11 @@ kci_test_addrlft()
>  	done
>  
>  	sleep 5
> +	# Schedule out for a bit, address GC runs from the power efficient WQ
> +	# if the long sleep above has put the whole system into sleep state
> +	# the WQ may have not had a chance to run.
> +	sleep 0.1
> +

How about use slowwait to check if the address still exists. e.g.

check_addr_not_exist()
{
	dev=$1
	addr=$2
	if ip addr show dev $dev | grep -q $addr; then
		return 1
	else
		return 0
}

	slowwait 5 check_addr_not_exist "$devdummy" "10.23.11."

>  	run_cmd_grep_fail "10.23.11." ip addr show dev "$devdummy"
>  	if [ $? -eq 0 ]; then
>  		check_err 1
> -- 
> 2.50.0
> 

