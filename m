Return-Path: <linux-kselftest+bounces-41199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27475B5217E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 21:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1F35656A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C8C2E0930;
	Wed, 10 Sep 2025 19:59:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A429D275
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534377; cv=none; b=f/WqnFg602VBvJig50vrInwtfUmPGtPC2C7l+l0/RiXOGYAwWb/N7gl2Ea0Edq57qY0cAZEPYSk5BvLV20quOpGa+tfFlNayofXZg8XUh6vvrRizteoLxUEUbnllCUOw2E+E2/vbubq9x1Tf8WWuKbGy4OfnoGUUDkYPaq358dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534377; c=relaxed/simple;
	bh=L+P5yZZfaz2UZ/A+ieU33ytsnNjJDuKZ4CYymzgFooE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy6DKSih0ehtvw9wnaO3YEivu99et+JRVONrHUm+3uyqYp9wTyF27GMaVyAO4c4GR8pnnMyN83zppWO3EKvLIP2/syq/SQCfkb0meMLhynofXtrXZdCVDVT5MsAcSaURc8bPbu+aq3wLylugW0AiBL8a4OWOjjwArbkr2CW3sG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so12410370a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 12:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757534374; x=1758139174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSyW+bCKM+mTcYP257eKxq8oqjrK37Brx0AQ56rh9CU=;
        b=Tb3TMZAcc/wYaofw2ABRpRTQqJ50VDE2TD2jDmiM4YkRISM9X5rVHxAhnzAwgU9BlJ
         R28aQ9VqcocAF1qlrq23OiB5H2Zsdeq1bfr1vKF0AXbFVxq7VGT7FeXElThhgSp+eppe
         i+426urPnLcF42zvCYg5iWG51EA6tHgTcqRH3IAQlcCrHMHNOAV3uFv9CaWGEgH+2+q4
         O8dZgxEuUFjU92/7TDU7lXBB0NUfTclsrTpqEEyelM4FQxVz6E4WkXAzA+2dL6BjmlxN
         6F0+ISOG//NbyysRsvzHS6y3mMBhVuPpgpPKmf9j8RJQSQQIwN31LP3A8rSMubShgdk0
         Toag==
X-Forwarded-Encrypted: i=1; AJvYcCWocGzJkAwhiD3rbV5iSvsb6HDklVqI0HwGzFuWOJTS+pQIxgWJot/MHcuYe+NUR8MUXcmpGrM5BoZYsTNa00c=@vger.kernel.org
X-Gm-Message-State: AOJu0YygU8H95oWtUDZ8DlKqmzczdx1dH0S4Car50sXuU3QPO62JmWV9
	kIZ7iT0JUL9W+PdWqMqOUE886dBDaS7zItQnvhjzsXBP/WiodFwX67Xn
X-Gm-Gg: ASbGncsowaBNs8G/PwXPLvyRtQhnpdypXvVd2s62O28b4SKKYKT9UOo0RRj/rU3HRD/
	WkWlczdo6Mc1i6O7dkyw8m9ksgR2CCZkjPJDTsjLR16dp85bXx38oEtQUZiQvY30z5mMF1gEgcp
	AcWrdCmHFd8AsHlTXLA+LH8f3Bq9+FMbn7nPe10DAMU/BcNLxwkGhfwgqW6HT40PjiZaYtbtUIL
	BIGEw6apOE0y7LnRK/GoeaXoap03+jp1Mgb+JLlcG1/FKiK/2H9xs252QzI66afgNdeZu/JzePy
	iFN/mOZIN3VXoRxb5OH6w/bnFBjAL3MP/+ke3NWmxNjGf80uuFrH2EjShuFBt8Jp3v7+zd0Lg8I
	oIvXf8oVK9hBnJg==
X-Google-Smtp-Source: AGHT+IHnlnmQF7cjCqFq5bXs72wG6wVY2EzGivBZpZmg4onT8Pw3/dnwNDVwAAeyGz4vDiDC7oXEUw==
X-Received: by 2002:a17:907:3c92:b0:b04:706a:bcfc with SMTP id a640c23a62f3a-b04b1547768mr1642728966b.33.1757534373934;
        Wed, 10 Sep 2025 12:59:33 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783047d98sm227097666b.22.2025.09.10.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:59:33 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:59:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: netconsole: validate target
 reactivation
Message-ID: <yj3q6gy5uxz5vosqxpmq7a24qpiu6zihj6gqgi6w7lnyekhqxk@silweslakkev>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
 <20250909-netcons-retrigger-v1-5-3aea904926cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-netcons-retrigger-v1-5-3aea904926cf@gmail.com>

On Tue, Sep 09, 2025 at 10:12:16PM +0100, Andre Carvalho wrote:
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 984ece05f7f92e836592107ba4c692da6d8ce1b3..f47c4d57f7b4ce82b0b59bee4c87a9660819675e 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS := \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
>  	netcons_sysdata.sh \
> +	netcons_resume.sh \

we try to keep these tests alphabetically ordered.

>  	netpoll_basic.py \
>  	ping.py \
>  	queues.py \
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 8e1085e896472d5c87ec8b236240878a5b2d00d2..ba7c865b1be3b60f53ea548aba269059ca74aee6 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -350,6 +350,29 @@ function check_netconsole_module() {
>  	fi
>  }
>  
> +function wait_target_state() {
> +	local TARGET=${1}
> +	local STATE=${2}
> +	local FILENAME="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"
> +
> +	if [ "${STATE}" == "enabled" ]
> +	then
> +		ENABLED=1
> +	else
> +		ENABLED=0
> +	fi
> +
> +	if [ ! -f "$FILENAME" ]; then
> +		echo "FAIL: Target does not exist." >&2
> +		exit "${ksft_fail}"
> +	fi
> +
> +	slowwait 2 sh -c 'test -n "$(grep '"'${ENABLED}'"' '"'${FILENAME}'"')"' || {

shellcheck is not very happy with this line:

https://netdev.bots.linux.dev/static/nipa/1000727/14224835/shellcheck/stderr

> diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..7e8ea74821fffdac8be0c3db2f1aa7953b4d5bd5
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> @@ -0,0 +1,68 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test validates that netconsole is able to resume a target that was
> +# deactivated when its interface was removed.
> +#
> +# The test configures a netconsole dynamic target and then removes netdevsim
> +# module to cause the interface to disappear. The test veries that the target

nit: s/veries/verifies/



