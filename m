Return-Path: <linux-kselftest+bounces-39676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF52B318D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A2D1D23850
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972322D7DDC;
	Fri, 22 Aug 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+aXKs/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DED4315C;
	Fri, 22 Aug 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867811; cv=none; b=f3gzPgOlwmcjP/Zh8YNoaSCr6W0Csy4QFQzZaBdOMpjjAnR0lthbJcM/gLN7JiGFq0KOXcR50/HqOhC7iRUtdeZ2XvTbDFR2bATwObFv+aspnCPmW9xGiiG03evmwbijgZkibUxGwyBvP7eQYS5Ydx2NPYwFYbDl8OEES7WLJJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867811; c=relaxed/simple;
	bh=sq1yjttYIOiA0E2+VmkijmPVo4l/nZ9VSTfAag8YDCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIgBxJHf80xWIxr1s51HbfTCkW99ymhp/MaK5E0fFjHUWDDxgESuVSCmbk1P4eu8wKf1nYYAU4CgVtKZjWdmiLZ5s9BPdNzu2GzXP7CQZBKwebABaGbuBKQ+70V/HyJq3Tc8IN/LL38kotmhP+dgBQCV6hgX80pCVVpYsokGmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+aXKs/k; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47175d02dcso1623989a12.3;
        Fri, 22 Aug 2025 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867809; x=1756472609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPxDT3MTeT2ExWKSYIYcKX9QUqnfn+6TpIfMTLps2Wc=;
        b=P+aXKs/kGtBoNjE78jT01+QP3hPMoOMLVLwBZgn08r2KPI7Y0x2UQa1KMdzthfS870
         uT9umhKAlXHS9kSrQj59O5cZILNZWdE7x5P8sv96n9v9e1MKJg/kx9iy49vDD69d3RUw
         pL6qlIusnOvRWcZIBmpCI5lYAVqDfCq48tjz9m41movmDeV8xOj84Cx+Szv7C0uTDuLm
         3y84s5gOBHuS27yLXRvhG5BRqW3SiGSQg9irG5McAOuo/eh6tA6IDny5hQnFKzWC1s5J
         ZQ31d8Vg2v+G7x/npjRGEw50hzMvZHyQyU/IpXDzJ1MyEEWR8E9qHTFXEfp3i0QJyq1P
         +sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867809; x=1756472609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPxDT3MTeT2ExWKSYIYcKX9QUqnfn+6TpIfMTLps2Wc=;
        b=Isy5yxtyHCrI1P045nx4Nk4HxRzNhPqkToplwDEuhCgdvSz0HuP9XCpPRAk9lrjJ6h
         TcKrsgUSQgdM958+uC1PV9zUr9sdWOTx4LIRHvFXvvKy4WQH8uxlH9ikG/xdJnmzcHVQ
         U/9eV/KDRsnhPgvs7mJ4uskkATOLF2D/GkrKim8nyw2Bp22uZghWAEKu0x2UbJgMkMQh
         9BENOIE1Z+Zkf3y9JzYJu/hkZovAwFV9U9GL4jK6OJfS6K5yK0RwC+xIZXtc5jL3zoxl
         A4VDXHjs3eYFXQaERv1ZV5g22b8JnUH03lMNoepbzTyjU1OX7YnQHZrBEab9IoTpGrH/
         HTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz5BPLjfiUC9xLJ12qFKcfrHzAMHENNexuRim+y/gjJiVxdLuV6h2tLahSb6i4VFpEyUUEjR7b@vger.kernel.org, AJvYcCX60+fy5VsbTz5ivxMfn2TlBkKqUB5VcrJiSvKpqaIyIlQqvE1CurzqbSoExJICYQ0MGIQ4ekJuzcEHvPyb/SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrivOTrnrK0IrT4Z0XTCCvbg9UKGPtWXTwi+t+CGU/vSlmXKsX
	OSVya7ouKT9nn86F7p6HDu6f5oSwM+NcumdskCi6qBcd81Hl+qozq3st
X-Gm-Gg: ASbGncswNsxWWUB0mR5rbEJ5xDQ4lF1HbLzPnNhpmJp2TeyZC9Y/3a358L80FGYYcL4
	kXvjko5x2zgZ8OCoX2WCITFH4FtT11S8uHuvJ87jYRI16WIWJRETJuFuk4Tr4uaaUtTjW68bwJi
	D3dxwd323zB9Q6dp3spgguH5Zio1DKOhCk9R4MQNMW4Eu5+xRpXFf/cy5WiPO4NgXoW2P2EN8u6
	N4676ZJLQUBHF7WFk4dLZLH/Hy+miVKGHHt4+eHGnG3Oc66e3dwVM8GOQN+6b7l79HLZpQzJuhn
	98tnWjU/1Ss1/1hpQpYGGe9HrZzxA/GUkI+qZYFwlQMD7GfQnFOscvbhxtZ8x15abgJMcZngZ0Z
	5trb2VbJeT4T7c/Wlcdx0rkE4EcE=
X-Google-Smtp-Source: AGHT+IFEwzH4RJaeyrfnA+uUFTSQ/6I2xISEDAPtSPWHXSsMG30hN5l5J0+wd5yLFjlZbR74ST7NIw==
X-Received: by 2002:a17:903:2ec4:b0:240:14f9:cf13 with SMTP id d9443c01a7336-2462ef948edmr34456545ad.51.1755867809240;
        Fri, 22 Aug 2025 06:03:29 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73f2sm83615765ad.94.2025.08.22.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:03:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:03:22 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH net-next v2] selftests: rtnetlink: skip tests if tools or
 feats are missing
Message-ID: <aKhqmsheZAqThrSu@fedora>
References: <aKfDOSx3C8NbMJsw@fedora>
 <20250822121456.874759-1-alessandro@0x65c.net>
 <20250822121456.874759-2-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822121456.874759-2-alessandro@0x65c.net>

On Fri, Aug 22, 2025 at 02:08:42PM +0200, Alessandro Ratti wrote:
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

The Reviewed-by tag should be here

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> 
> ---
> v2:
> - Updated the patch based on review from Hangbin Liu
> - Changed subject and commit message to better reflect updated behavior
> - Added Reviewed-by tag
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
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

