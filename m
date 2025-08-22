Return-Path: <linux-kselftest+bounces-39615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E517EB30AA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77F61D010EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D92919C546;
	Fri, 22 Aug 2025 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4cEqrby"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD81922F6;
	Fri, 22 Aug 2025 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824962; cv=none; b=UllJ+JXJ6HRpDNnjYD8YklCDZ02khBdeFQrA+czMu9DWCi1jp89KlQaGIDynEKDcx41JYpZ8jvLVi2u0gPuLzVSmyz5/HarYXOYPxcWKVIYQ2Otur3b3RXf07+Ah2XILuLLTJSde7OqlGBy0rKGWK7EuMbl9eZqDUh2k5Bvn18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824962; c=relaxed/simple;
	bh=0dODRNC78xNke3pHeVeJUZvgtP8G2f7317szkX2hU6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfabO1ZklmNZtSrCV+lUewlXoMID9sHFF5XetkioP+FQZN5QbHw5L6VADaqNoBAzImLj3550VscSmwPEqTpvW18yg242YazhF8+RyUOMnQpDExws20KTl/7rB7cMfRAD2yN51dKjAo6x7eqE1djhLPXIyENxSS3NquqGodoJg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4cEqrby; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323267b98a4so1348677a91.1;
        Thu, 21 Aug 2025 18:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755824960; x=1756429760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3IvWMgAQ7iyt9pErEVox3m88MWiTBgrWQ2lpL1JbMA=;
        b=Z4cEqrbyhPT4oe5WvHlF+B5OebtAuwb+QOPfaR80npcX45xeMta/oguwKvk4xpod3Z
         hu7J0KIdaHsOmmLqIv6Bzk0B/qIGajZKRGIVw0ztGRr5lEaEK8nAZg9qxLDr/a3VJII0
         +NL+e7/QjRMJ8SsylyEL1iJ61fCUtFUI6n5UNX3/wJ6VGGy47YT4vzKdjg5282bssQIc
         HQvgNH1aBVT+zkHAakoYmyvOktTYDPKsidw0dZ7UMyc+lC5YLhm4fVIkbM6xrlYkaaPp
         HFD/xxzuA6S9iXig8PstDjGPxKxSD7KysfsKBoVR+aRFpDf56MiXbLI2LvuhfiolH7Fa
         kOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755824960; x=1756429760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3IvWMgAQ7iyt9pErEVox3m88MWiTBgrWQ2lpL1JbMA=;
        b=P/G1/jNYaFy4C+7DruW21LItUUVQCrNIdGhewxZ6xi1jUj5KsAaOIwsOacPSZwRmcO
         ea2Z2mxvLQ3tLtArkiWcpTZ+y1NIGFM0iwCJeY0UNvAnSsccD3VcMPXTXt40ka85kVQy
         1zCjOGV2+SgDRj9e1TDtws0sX4WjhoaGqm6EGhBhyD8OTsLceEcrvSoJL4zLc1MPGzoo
         9ICS0sevtPIq6ocugLyxJs2WGRH7OvmcGDqZAmXaHlO6h/EN2UuWJ+kIGbymBXzm/9jA
         yo56FLYh9KzWECjms/U6cCTm25byvIMeefRE/auOGZnH+u0EOnIJ64E9o7PsHnAKFuys
         NCqg==
X-Forwarded-Encrypted: i=1; AJvYcCUA54jUG/nIWhhbDLDu6ESyloDbTJOEByAONb0gHJi7goWrwLRwSnTVMT2TcEux+uaSHha6tQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyirsy2UrpO6tSWGlt5AWdUMV6Xpu7O+WuSB/0WZWKqn8gX4FPb
	ImXwwYrtfu/f5pvgk7tLFaFiKdmxdpMcLT/exc12Z3+HYlkjaV4XhmcS
X-Gm-Gg: ASbGnctBI6rqQSOUBzigihk0CcItsoVbKAjfnjfcev/zQEiskiAA4eWmyl1UsefeRiQ
	iVFA8vSApfcs+S0kLF428gLy2iRt/JPWj6uzA6dyspCm8MNGbyVns39+0kbcCYl0v0So4ijhoQ7
	whK1j6eWAffrnBi+pXroM/UOOBF8Obuk5BzDV0GJhX0rI0fpqvYsKgWbJyw20szk8ir6jmkLPeB
	BpKhOVx/rZxunpbIRbSl/E6XD8DxMr/6QZxlmEfEscqFC7WUvxH4OHec/UwBXr6hnhraaVrI91S
	kY7sG8q9OvJeCITRV3ic64n6PA3K8e1FedfdG8LECvizxZJIWHFt1YJCLeYDAqh5TBiCx3fXAE+
	bzkuyolcJl6cp2C06GXbl3jWpNvc=
X-Google-Smtp-Source: AGHT+IHGU9u2H0lrds4JZ+ha02XcXfQbC9cFCfl9rGEtlVY044CJ0NqK8sNK4JELfKp6RGXi4iuSrw==
X-Received: by 2002:a17:90a:d2c8:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-32515ede095mr1618745a91.13.1755824959744;
        Thu, 21 Aug 2025 18:09:19 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325129aa68fsm950823a91.7.2025.08.21.18.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 18:09:19 -0700 (PDT)
Date: Fri, 22 Aug 2025 01:09:13 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: linux-kselftest@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests: rtnetlink: skip tests if tools or feats are
 missing
Message-ID: <aKfDOSx3C8NbMJsw@fedora>
References: <CAKiXHKejzOAiieTxZpq8+v-vnzSEyuOuD0tYbzHL5R78iS+BMQ@mail.gmail.com>
 <20250821142141.735075-1-alessandro@0x65c.net>
 <20250821142141.735075-2-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821142141.735075-2-alessandro@0x65c.net>

On Thu, Aug 21, 2025 at 04:16:51PM +0200, Alessandro Ratti wrote:
> Some rtnetlink selftests assume the presence of ifconfig and iproute2
> support for the `proto` keyword in `ip address` commands. These
> assumptions can cause test failures on modern systems (e.g. Debian
> Bookworm) where:
> 
>  - ifconfig is not installed by default
>  - The iproute2 version lacks support for address protocol
> 
> This patch improves test robustness by:
> 
>  - Skipping kci_test_promote_secondaries if ifconfig is missing
>  - Skipping do_test_address_proto if ip address help does not mention
>    proto
> 
> These changes ensure the tests degrade gracefully by reporting SKIP
> instead of FAIL when prerequisites are not met, improving portability
> across systems.
> 
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index d6c00efeb664..c2a0e7f37391 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -323,6 +323,11 @@ kci_test_addrlft()
>  
>  kci_test_promote_secondaries()
>  {
> +	run_cmd ifconfig "$devdummy"
> +	if [ $ret -ne 0 ]; then
> +		end_test "SKIP: ifconfig not installed"
> +		return $ksft_skip
> +	fi
>  	promote=$(sysctl -n net.ipv4.conf.$devdummy.promote_secondaries)
>  
>  	sysctl -q net.ipv4.conf.$devdummy.promote_secondaries=1
> @@ -1201,6 +1206,12 @@ do_test_address_proto()
>  	local ret=0
>  	local err
>  
> +	run_cmd_grep 'proto' ip address help
> +	if [ $? -ne 0 ];then
> +		end_test "SKIP: addr proto ${what}: iproute2 too old"
> +		return $ksft_skip
> +	fi
> +
>  	ip address add dev "$devdummy" "$addr3"
>  	check_err $?
>  	proto=$(address_get_proto "$addr3")
> -- 
> 2.39.5
> 

Hi Alessandro,

Next time, please add the version tag and target branch in the subject.
e.g. [PATCHv2 net-next] your subject

I'm not sure if the lack of a version number will have an impact on the
patch work.

The change looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

