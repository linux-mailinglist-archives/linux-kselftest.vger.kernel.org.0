Return-Path: <linux-kselftest+bounces-34099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFBAAC9961
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 07:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B596D4E022F
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 05:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444651DB548;
	Sat, 31 May 2025 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV0EDyK2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E828D839;
	Sat, 31 May 2025 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748668802; cv=none; b=H2QkjB7P/XdjekE6BClY/jCU+etRtqA9kAwi0/q81Mp9odRIcvBJvNV5w1GswpPcYSOItkGnpaRUMdkNXE2qFtijAUUxAJPhP41THHFgmbt99ZBkj/Bfm0e4dY1+3BLI0aqTBehRjm189Qb8hvLPoNhAO3pIsY9CXRxmtrbbTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748668802; c=relaxed/simple;
	bh=BBVxLVZgcTk3DvCF23Av3f4k8kCGKBWwVpL1OyybODs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTbYMssGsGgj/fg4JynJcCqNr8Es8EIKoOKtSjOsyCOm4IurWYYbPPhzILecuPFAh4Y/uSf9kWSC5OASZ6w2h+CeSzqwy0HLCaf3xg5fi32iNgfbyoJRkMvbP46QZ3oqCDPAk27oL2TAFzCdJrsy7Gf16nTe9kpJQKp83qdr4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV0EDyK2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso1763797a91.1;
        Fri, 30 May 2025 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748668799; x=1749273599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQQOUpd2aEpd35mNHvrhLzZxqRBywxXQm12/HNX6Y0E=;
        b=UV0EDyK2uNOI6AKuWhAVV7KhJrpoTM1U/HxXFF3Num4tlN/iQ37kcJMx3hQZzvYhUa
         4vuPxQwGErSLubBTtguIKDnG5C4afTCWZSYuIoYA/ZyxNNg+yRRbMHETXHPU1Vx2revq
         jgHW9O/m215AcqrFQKTGBJJWnHDgVYtn/48YeDiSavTtd1duS2guA2QJMD2stTw+K9C0
         JvrL33JBgd+tRzQoSKy0E0ik2uZDXp4TEK54fKWw+RnnHuW1btkzIZaxnAQewGOj1ape
         lj38HmKqzt4lsdKgWpVkgq1yYhm8k4s0jUwnbkuAQSj/zHwSXD+ImO4TkUvpIxMb+wD7
         m26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748668799; x=1749273599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQQOUpd2aEpd35mNHvrhLzZxqRBywxXQm12/HNX6Y0E=;
        b=jSpFgYQNOXpsM+OgA/8K7FDTjDU3Zfk/z4pgpyOT75P0j/ttmgm6VTqhy76KPQh0en
         zklSDBI38brj+HiFdMR69AhZEdo+Fm3bCM8L2NZuW8if/wsSUsQOZs8jOPgPM1A/H+bO
         gjJP/9NkSdNrmRfl9TA3g9D6gYCoDB9w0ZtnR9F8t7Vb5Y6sZdCMIcyFcQBenKyUuIjw
         fvt/rmx0sAf46nL8Tr92Ls5TPChN2xAyg93GvqLlPHorRd793CBF9H/mZWvciEKKM5I8
         Kb9QGzeSEUuVxlK1SvCwf1NFVhq7JWdSaSUjU5Y+UBi0I8miHX5M3ACOIzgL2VtlZOAF
         38dA==
X-Forwarded-Encrypted: i=1; AJvYcCUGM8q9VZTWgq/ZyDr4gEwi4Pi6ODCifYlT7a4yhEbov9oEcEwGZoTpvplXBRtNDq8sNFZTmIjnhndjNw8=@vger.kernel.org, AJvYcCUJVCdKmXusQKnRwrrJpkJtw2HTg5kezOxFX/K415BC7nf6Z3UxIJ5owq7ES/7G14IgRTe4Iun4dXkbUDq5rXy8@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCdaag+850yyuVC4hl4NTGOV9JeYtN/0rpU+5nnPGeAkMOdyI
	YCX2GAR9NwMcYMdu6x1I5/AiUSD84w80wzQzL8nWs1yngEfmi++VLxpE0Fqa+v10HN0=
X-Gm-Gg: ASbGncuO850nLoCVQ+yrHxuSVKUb1sMuTRYeB/GpcAWwTw6X5Guvk438SzK97p/0iTo
	WwPNaI0S02LfAzlfI4ftwyU34daCW1KjrYHBoHiidr9VJEdkcHZr9kPhq0yEPaY0308w3CvHg6w
	a5vTrCn+xJZ///KIDehVWrSBVA+KU8eZDXKBrKNPD8RzOSAMmtR6ys2+6ZeWhGWDeO4ukUwVfyP
	x6mmdC/UcLZrKQOkH0zzldL3N9uE9IXrNDR4aM+JGHOz8fjmc0XUPsjHobI+gARE99Mib45DKkb
	AK/kN6uoVJ6Uu1qK38BtZmjso0yZcFKfYM+yym+L2P+YCKnzqq/fO0fnAdoQJ3yzpfUX7mPKvxe
	eLJmnKy2DBKOo90iF2iOm3SEsP2CSeQ==
X-Google-Smtp-Source: AGHT+IHURzH3SW/8f+MPckxVg/iu91qiOcC2ObXe2OhVOn6Yre4ZLCm0gWAVErDmLk+0DE0oxmcSbA==
X-Received: by 2002:a17:90b:4c44:b0:312:e9d:3ff2 with SMTP id 98e67ed59e1d1-3127c6a9a43mr1615751a91.7.1748668799343;
        Fri, 30 May 2025 22:19:59 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:1655:88ee:e7f3:487a? ([2001:ee0:4f0e:fb30:1655:88ee:e7f3:487a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3327b4sm2019691a91.48.2025.05.30.22.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 22:19:58 -0700 (PDT)
Message-ID: <5956ac6b-f1b5-42be-8bf1-c25b379398f7@gmail.com>
Date: Sat, 31 May 2025 12:19:53 +0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] selftests: net: build net/lib dependency in all
 target
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Philip Li <philip.li@intel.com>, oliver.sang@intel.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250531051039.6561-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250531051039.6561-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/25 12:10, Bui Quang Minh wrote:
> We have the logic to include net/lib automatically for net related
> selftests. However, currently, this logic is only in install target
> which means only `make install` will have net/lib included. This commit
> moves the logic to all target so that all `make`, `make run_tests` and
> `make install` will have net/lib included in net related selftests.
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v2:
> - Make the commit message clearer.
>
>   tools/testing/selftests/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 6aa11cd3db42..5b04d83ad9a1 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -205,7 +205,7 @@ export KHDR_INCLUDES
>   
>   all:
>   	@ret=1;							\
> -	for TARGET in $(TARGETS); do				\
> +	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do	\
>   		BUILD_TARGET=$$BUILD/$$TARGET;			\
>   		mkdir $$BUILD_TARGET  -p;			\
>   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
> @@ -270,7 +270,7 @@ ifdef INSTALL_PATH
>   	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
>   	rm -f $(TEST_LIST)
>   	@ret=1;	\
> -	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
> +	for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
>   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
>   				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \

I'm sorry but please don't merge this. I realize that we cannot remove 
INSTALL_DEP_TARGETS in install target, if we do so, net/lib will not be 
copied the the INSTALL_PATH. I'll post a version 3 shortly after.

Thanks,
Quang Minh.

