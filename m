Return-Path: <linux-kselftest+bounces-39465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F9B2F250
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B511CE3D38
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512F26B09A;
	Thu, 21 Aug 2025 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5iw6FwJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E21F4C8E;
	Thu, 21 Aug 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764741; cv=none; b=Ai5QTlv4x2xgxKBJ3ZHYs3EdMUW8jX566nIY3MXJJKMuBACjWPHR3WgxyCBUGGkR26LNe5onODMyUjBQKvoV4+Tm9UwOYS+LVY2MfQuptnVnpFMHk97nIWYuG+kJfHHjC/v+LYgoh1u8xCbgZcJJt/Cu39ZaWVPb2at6PXStzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764741; c=relaxed/simple;
	bh=vqjVSAC39DLzfmRq6oEZZ4wUyUSsoaxOHIsxethJGaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqeulOD/7exhZYyIwTDEzqV8nLPDCVXaLQnCksZTB1DFIw1fQiVopMTo7NDXUnxIOMuP5kSa74zI2VVqnYXrFi906uncpSDkJqSSibIQ99qFAIYil1JkAwELqxyR2MLzBHa+dPRWHggGlv4VdnvGS8HAnT1LPlwcDJgVoLbW58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5iw6FwJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so591003a91.2;
        Thu, 21 Aug 2025 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755764739; x=1756369539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhSKPDIlNSYqB854DlTsEXLBDzoRep9gv44E1FLx6cA=;
        b=L5iw6FwJwWj3mOqWyD2IYFZJdD55rnh46O3lJQhUdJxpDVLC/eVYXiF7dfoe19MsaJ
         8mMmAkYDtDuWkdQNgN2EgsKCPH5klxb3Dnh+jKNxv++HenKkeEEyAQPq50E8vm35A3pW
         3SwUjgUEqNf6T2Tss4AcbOxN+4zYc7ENFsKSyoOgzdJYlPs0W/7v9dSPiHyeLhY6lqEG
         xkF7Xvm3l3XhHymrNd3OiX68ep69WQFZzteUE00A33ObY9Jil8O8Mm9V5AI5J2pzo6hi
         S/o2t/+eO2X6tUNA90PgXrQVuqcwd3Jw5ST1PgiPDbYIp2lkPKbHj2LVDIuJdma62c/I
         r/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764739; x=1756369539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhSKPDIlNSYqB854DlTsEXLBDzoRep9gv44E1FLx6cA=;
        b=Lds0lOE0UMGwqmZpzewnR+rfb5OXEbVNt4v3ATw8X9ur3/Wti9gQHQI8sxQ2qg5VkP
         xX7Ze5XJVYleWw7ZQjz/WIT6XEoRIhKdy9CFK07kV7oWNtwVScvmHjUl2EfJfwvIp0r5
         eobt23bcM3d0ZbwCw6bi6VGhSnHi4j5ro4AYgfvtxqBZIXclSjMDJhYjDlqvSog7wylU
         9ps3xvgaDQpVwDW60F2cuIhF8onjR2xteoKIoYjrmgdja1SOK+oitZCXTUTWVBl1/8e4
         5pT06NG87yxL/bUujLlmLjfIHNDDkVA8ws8G2kwZtdI1JjFol+Cy7+w/g9qPZwnTnsNn
         +gKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW26gBeINy0X1EMiS8aQXJAaCcHRdtonBIBoY6dBUwono8XGehEn4TiCpyf0eA2m5QQrLdSHxIVXbPoRB070Y=@vger.kernel.org, AJvYcCW/kAsE4npefHvmPY7Gh29QDhoLmbTxbN1UJ/4lXATxsp/G5NwwsJnjssOmBozTHcHGlX5GvVEC@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPGNA4nG3bIHGhkMd6mAqNrukhafm0NjjXykiOQS+Qrrs2IFJ
	CpAURK6ZA+baVhyzJp/q89XAmtLyxT3jFqCEdK/gNhpWmumqtgm1whLGs/Z1qa8X
X-Gm-Gg: ASbGnctTV0wRBLhsSLrhQxqeFmj7fV+5B5uMKm9kTIzkA62WtHiS0+BbmuwTS+ek2nC
	nl4A+zMRHd8HHOUInmLcg+28ALgHjy7tZiFRdJlC1az0YbHcxgqdvWBr5/z6gCXxSSsWh3iaf5Q
	mvJHb7oAG/5qtE1XrBIQKua06uEscGZQxj1Yc8w0USywVOXRFqC3hNM9acgquIQvpKXgcO/w8s/
	oLB3gnKjiH/KZoV3Wai8li7zFFwqBkR0bE1EFAQgQKXsRXQfVqxpA+BsEOzmbQLro3IlT8iklvO
	N7NcoQ7kZfTBydAte8Oka6Tei9X2fDl1QpFY7MBZ4kUeh/JZif+y4C4GSP/iq878m780Xl9q2qr
	Q1TcHGhL0xiDNfcLDzPdgQERhxJINldUoJ2tFpA==
X-Google-Smtp-Source: AGHT+IGDx0HzUgM7euXlpNBzSXjRDzWhTDt9pKPGYUt4vhHfLjOysfxGJgRHIebr+TfnmjUIWlqapg==
X-Received: by 2002:a17:90b:5443:b0:321:937a:6d79 with SMTP id 98e67ed59e1d1-324ed1bff14mr2036303a91.30.1755764739147;
        Thu, 21 Aug 2025 01:25:39 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d52cbfdsm7466463b3a.84.2025.08.21.01.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:25:38 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:25:32 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alessandro.ratti@gmail.com
Subject: Re: [PATCH] selftests: rtnetlink: add checks for ifconfig and
 iproute2
Message-ID: <aKbX_CzxSi7T9Bcp@fedora>
References: <20250821074552.682731-1-alessandro@0x65c.net>
 <20250821074552.682731-2-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821074552.682731-2-alessandro@0x65c.net>

On Thu, Aug 21, 2025 at 09:43:11AM +0200, Alessandro Ratti wrote:
> On systems where `ifconfig` is not available (e.g., modern Debian), the
> `kci_test_promote_secondaries` test fails. Wrap the call in a check.
> 
> Additionally, `do_test_address_proto` fails on iproute2 versions that
> lack support for `proto` in `ip address` commands. Add a minimal feature
> check and skip the test with a proper message if unsupported.
> 
> These changes allow the tests to run and report SKIP instead of FAIL on
> platforms with older tools.
> 
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index d6c00efeb664..9bff620ef595 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -330,7 +330,9 @@ kci_test_promote_secondaries()
>  	for i in $(seq 2 254);do
>  		IP="10.23.11.$i"
>  		ip -f inet addr add $IP/16 brd + dev "$devdummy"
> -		ifconfig "$devdummy" $IP netmask 255.255.0.0
> +		if command -v ifconfig >/dev/null 2>&1; then
> +			ifconfig "$devdummy" $IP netmask 255.255.0.0
> +		fi

Maybe just skip the promote_secondaries test if ifconfig is not available?

Hangbin
>  	done
>  
>  	ip addr flush dev "$devdummy"
> @@ -1201,6 +1203,12 @@ do_test_address_proto()
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

