Return-Path: <linux-kselftest+bounces-21539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA19BF194
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAA5B22FAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5972036FB;
	Wed,  6 Nov 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNr1foqo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B847202F6C
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906778; cv=none; b=ZsHCrS2M7KoNmlsfA+DiIGSxsw7iCD5k44yLH414ARXPJ6qDz5DHpB+/WWf40KcV1TuxhbkcqXtkFwUscgdMbRe6uV1HuOiMuaFJ9UjxM1VKym95SZZoDDYJiDdobMLRhdR1ACdzWYLfiIF4YmEhhJ8+XAmsIYi2XiCWBKSkIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906778; c=relaxed/simple;
	bh=F+R9cohepa/j4/DCaDMsX7Bkp0RVEuvxdeP7ZEr0aaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMG50+UFtVzz2bn7DIo/xLhFh3J1nFQN1BQ3oSewoh4SgRJRLvgQp9ahv+108LepIa3Ir0YbFYshnLNNgrHQR+N/iJnMWFVCYvY4PFNb4mbwRleOon43Gwi5Sl5c/2Gb9Id9aNUaxx2Gl68Zd71p/Z5K6/Znqtesca23Ld5IKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNr1foqo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730906774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HcTk5QhrwmUlESiEL93g25An31FCHuPHBmx7Qi3uc0=;
	b=VNr1foqo9gkYpvKExLt0hfrt2gTJ6OI41l7o8WXe0/KhUKQfFKecmTv37hJEV+rFYUiyOe
	Dau0kqH8kbXjwsgqEjBvOCPFVf/GcLMnfX1vVSVVCIzre+n7QcYSSr7fiavEBL1b26AOmg
	MRlrj1F3PS1TovYkumcQoNn+X8QX1a4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-2OJCRvCjNdSdNQwiP3-rFQ-1; Wed, 06 Nov 2024 10:26:13 -0500
X-MC-Unique: 2OJCRvCjNdSdNQwiP3-rFQ-1
X-Mimecast-MFC-AGG-ID: 2OJCRvCjNdSdNQwiP3-rFQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso46946515e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Nov 2024 07:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906772; x=1731511572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HcTk5QhrwmUlESiEL93g25An31FCHuPHBmx7Qi3uc0=;
        b=ZCiMDlhFN0g2+HB2XZlwzS6YhOAef8vcl0d/jknAhXB1NJa0EYGQMuQlbMwc8rfedo
         5mO2PDZUEkXqdO7SNDEbvxnEoEXBi4VXNgrvEkyfvbdmNwuIpPUBs5ftR9wKtE4L+rBZ
         O7u6LwR+wwNdAq5Jx5ymmx549Or1L4JQj1FK4urFnK+PTUVInv+8EEn5b2IwEA91IXs/
         wzLgPbuS6m4X8/5g3iwE9KB/cyXPsOCFtFR4xucJeIl/Wo5KuxbydcWWHeI3MUlhH7Oi
         ECJ5bdMsYTKaJ/qqdLvv3JVtOMXf+AKBxYx5mE/V/9YNTEL2wt4bwj7EY7UUEzmd4Sad
         1k1A==
X-Forwarded-Encrypted: i=1; AJvYcCX/iTRixFancpU6MTo5YUv3xv9iah7jTnWXTfig/jw1cPZW7lhGTVdcXQeuYPbLcEsAKDGwaT44eq91KMKyXzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62HFQdOj+0AGn1FW42T7mFFFihKPe67mZ0TMfguByTyCBVmLt
	FJReRXqixadjdX2y1OCzmu89RZy0mdIa5pYwv++gQCVNKIq3VPUZn5wIfrF+vdeyTBo6vcjx6hF
	1clHGeclE7UwfEz1mFhfjIQTbb1EqzKZmDX0dZUGMD53RO3B3saDuqZE4k9+ViYHa+w==
X-Received: by 2002:a05:600c:468b:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-4319ad34be1mr380307315e9.31.1730906771933;
        Wed, 06 Nov 2024 07:26:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0qa2VH2AUL+LKPiEYp6qAItG/QqxwsVxomcY+9weguHrQhkbYtHnBvQBRNtWpvgYZQBNMmA==
X-Received: by 2002:a05:600c:468b:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-4319ad34be1mr380307005e9.31.1730906771517;
        Wed, 06 Nov 2024 07:26:11 -0800 (PST)
Received: from debian (2a01cb058d23d60051d26877cf512a7d.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:51d2:6877:cf51:2a7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432a368780dsm40066505e9.1.2024.11.06.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:26:11 -0800 (PST)
Date: Wed, 6 Nov 2024 16:26:09 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Vladimir Vdovin <deliran@verdict.gg>, netdev@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	linux-kselftest@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v7] net: ipv4: Cache pmtu for all packet paths
 if multipath enabled
Message-ID: <ZyuKkekr2QSF3jUS@debian>
References: <20241104072753.77042-1-deliran@verdict.gg>
 <ZykH_fdcMBdFgXix@shredder>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZykH_fdcMBdFgXix@shredder>

On Mon, Nov 04, 2024 at 07:44:29PM +0200, Ido Schimmel wrote:
> 1. We should set the same MTU in both paths as otherwise we don't know
> which MTU will be cached and what to pass to check_pmtu_value() as the
> expected value. I did see that check_pmtu_value() accepts "any", but I
> think it's better to check for a specific value.
> 
> 2. route_get_dst_pmtu_from_exception() is not very flexible in the
> keywords it accepts for "ip route get" and we need to pass "oif". It can
> be solved by [1] (please test), but Guillaume might have a better idea.
> Then, the above hunk can be replaced by [2].

Thanks for bringing this to my attention Ido!
I fully agree with this approach (and I also fully agree with your other
feedbacks).

Nice to see this bug fixed and get a selftest!

> [1]
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index 569bce8b6383..6e790d38e5d9 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -1076,23 +1076,15 @@ link_get_mtu() {
>  }
>  
>  route_get_dst_exception() {
> -	ns_cmd="${1}"
> -	dst="${2}"
> -	dsfield="${3}"
> -
> -	if [ -z "${dsfield}" ]; then
> -		dsfield=0
> -	fi
> +	ns_cmd="${1}"; shift
>  
> -	${ns_cmd} ip route get "${dst}" dsfield "${dsfield}"
> +	${ns_cmd} ip route get "$@"
>  }
>  
>  route_get_dst_pmtu_from_exception() {
> -	ns_cmd="${1}"
> -	dst="${2}"
> -	dsfield="${3}"
> +	ns_cmd="${1}"; shift
>  
> -	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "${dst}" "${dsfield}")"
> +	mtu_parse "$(route_get_dst_exception "${ns_cmd}" "$@")"
>  }
>  
>  check_pmtu_value() {
> @@ -1235,10 +1227,10 @@ test_pmtu_ipv4_dscp_icmp_exception() {
>  	run_cmd "${ns_a}" ping -q -M want -Q "${dsfield}" -c 1 -w 1 -s "${len}" "${dst2}"
>  
>  	# Check that exceptions have been created with the correct PMTU
> -	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
> +	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst1} dsfield ${policy_mark})"
>  	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
>  
> -	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
> +	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst2} dsfield ${policy_mark})"
>  	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
>  }
>  
> @@ -1285,9 +1277,9 @@ test_pmtu_ipv4_dscp_udp_exception() {
>  		UDP:"${dst2}":50000,tos="${dsfield}"
>  
>  	# Check that exceptions have been created with the correct PMTU
> -	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst1}" "${policy_mark}")"
> +	pmtu_1="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst1} dsfield ${policy_mark})"
>  	check_pmtu_value "1400" "${pmtu_1}" "exceeding MTU" || return 1
> -	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" "${dst2}" "${policy_mark}")"
> +	pmtu_2="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dst2} dsfield ${policy_mark})"
>  	check_pmtu_value "1500" "${pmtu_2}" "exceeding MTU" || return 1
>  }
> 
> [2]
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index a3c3f7f99e5b..10b8ac2d7f47 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -2399,19 +2399,11 @@ test_pmtu_ipv4_mp_exceptions() {
>  	# Ping and expect two nexthop exceptions for two routes in nh group
>  	run_cmd ${ns_a} ping -q -M want -i 0.1 -c 1 -s 1800 "${dummy4_b_addr}"
>  
> -	# Do route lookup before checking cached exceptions.
> -	# The following commands are needed for dst entries to be cached
> -	# in both paths exceptions and therefore dumped to user space
> -	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R1
> -	run_cmd ${ns_a} ip route get ${dummy4_b_addr} oif veth_A-R2
> -
> -	# Check cached exceptions
> -	if [ "$(${ns_a} ip -oneline route list cache | grep mtu | wc -l)" -ne 2 ]; then
> -		err "  there are not enough cached exceptions"
> -		fail=1
> -	fi
> -
> -	return ${fail}
> +	# Check that exceptions have been created with the correct PMTU
> +	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dummy4_b_addr} oif veth_A-R1)"
> +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R1)" || return 1
> +	pmtu="$(route_get_dst_pmtu_from_exception "${ns_a}" ${dummy4_b_addr} oif veth_A-R2)"
> +	check_pmtu_value "1500" "${pmtu}" "exceeding MTU (veth_A-R2)" || return 1
>  }
>  
>  usage() {
> 


