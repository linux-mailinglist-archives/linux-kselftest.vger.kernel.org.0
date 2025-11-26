Return-Path: <linux-kselftest+bounces-46565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF47C8BBF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 21:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14CAE357D32
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C833D6C7;
	Wed, 26 Nov 2025 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYN2xCna"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5182BCF5D
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187281; cv=none; b=DH7CjPnR/YsMeveE42tEIisOekwLJsKvzQBtotHgT4kdXERP+CXLYiF8yFLphQknIE+m0vKpOhuiXNsqw9N8X9L/mwWdcOZAC3hT1/aIVAQ44QNG1MMdIReWNt3pa+f/zfmC4R6+remrFcAOXaguCQGHD9rqnUDjuonLZHLX1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187281; c=relaxed/simple;
	bh=CVk5Ik3dMIJ4Xe2jy9D7p0ieUE7u9nbrX6GfzALmaqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjWPIlM46LCQ7zcNldrzxuv7tGK1ia4dhlbFUwoaOblSONk1/4A+g88nSGjYFpvM70qN1cmTpj/Z2wZi7xCdVMsG1uixywxDuc9hJ7u1YWQ4FLYJho/ckm5ukUZthVNsYUcqCDGvtphNG+052wDrLLPJcO0tM101+YVFknOWJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYN2xCna; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b98983bae80so173458a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 12:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764187279; x=1764792079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qMn6bFYv6kGyj9tjqAoP1eZ0Ua/HYVXcdKwly7wduc=;
        b=PYN2xCnaRgPjqeetusEZbuufrQ+wK6EsLQ8THeyYpNIjt95WHCimmVz6VErlmiyCOF
         pXXUpaqXV6IVyj1eUVek5l+FEYzBj9YaBFZyGcZJIozcktI//abygjvIwKrGNW3UNMIr
         xNb5CvwW6im3BWjD/j5Y/Z+hp96/qXqy56PbATJPoWRVOzVLCarRtnqAVvNYhTdy5IP1
         rxVxwlS9qcGRoUD/8fn63V2hFt5ZHD5WJNX6u2VZm6pc1FzOremoExxvRns2cZ4ly8Bq
         Muvmb4V90QZYxcXMl3O2R2ObFZ32vxlv16HzKqhpKYpTteNH/ZiewmFeesapIMzNxemx
         yPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764187279; x=1764792079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qMn6bFYv6kGyj9tjqAoP1eZ0Ua/HYVXcdKwly7wduc=;
        b=uqQzKB2Fi9Ln2m8yMrvKNbSV1B5L2SmcRlfI9lYIk2riD9GJrHQW6C87peWPD0rMjA
         95WPYupNDzCCODutHF8032L8SbKYBKO3e7KgbJvVg8jTLO2cJSRSFPDRY3n06V3VmwGv
         gWfzS8YWdbNfosiPEuljvAf3h4AhS6ShsdWtyAOmNQh8fPtzmGKrC/ZLZE5pHcW7gwW9
         3nLGjcqJFAgFtkM83iatdHHIeiG6l37tDD2aBfvShrC7HwuoilUeYLzkQqywE40L9x8S
         +CZBiKoI5WJhr2uhxTB1qFFqMc80sWhr6MrB85aT3zeFAbBnWWqHGfbxwqjx8/vCJc7Y
         Jbzw==
X-Forwarded-Encrypted: i=1; AJvYcCUUG4B+kKIvN83T9Kev5GHVeET3Sw5j/A0NM/1WrExlN4rxvcBnI0oxA0Jw77nU/BMbJp1r1lfGn7RgMjjoUeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNAWAJavNZW/rZvv0FA44Dfgw6VH8LiG5GplJpP2Ukhs+Pcv0
	2cxFEMvfqxUJY7wuaIT7GMFWPAFE+qwnX0E0FMfElEfZY7MwFgNXX+oH
X-Gm-Gg: ASbGncvOg3Ba7l0toXN/Y7yRKcr+eIXYuf8cQ6Yh2nqU5AMAQYU7qJkna+neoxOSyLr
	LxQ2PxFVqkM6NjEO3IGw/FgmTjvZGg2qW1p1Bsjrhmm1cwhZAxb3R1MKIjMIn0qMshMjLIxlbRb
	NNwOWqe9OYFY5IIpdDRlr/cAzXusiZS14WgtlR7mLRKXrfllhvZGEFFydngZzYfPGZqHqZLk+41
	1XvdE2bjfuKtrjRWvFMg4hZlJAN6Ux/5tNXGLMIxK9cKLPt7KK4ZAdIoBa46l7L7vT9+PEUCm0O
	bRGf1l4BQq7Se8kqdZKInMOUot2SFsa/h+Iw33BSvp4/m7ch/dj7jZBnfW2vnYICjKAHWKIZp9y
	euULnblb5gdpST4U/X77kHfUdLiWXXYCjTeP2YvngODGQNDAT7f/J6f/TsYB3jCnwZMJk86dNi9
	2jc7QzSpuYohD9JC3bohjB
X-Google-Smtp-Source: AGHT+IHXHo6GNNm0POh1mAORb4BYcYXcF5Rd5TJ50ua+awlutI6+xROA5iFvORHBUkDOoIW/B5qFaw==
X-Received: by 2002:a05:7300:6115:b0:2a4:3594:d54e with SMTP id 5a478bee46e88-2a719d86ae3mr13955158eec.27.1764187278729;
        Wed, 26 Nov 2025 12:01:18 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a93c5562b2sm24363259eec.3.2025.11.26.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:01:17 -0800 (PST)
Date: Wed, 26 Nov 2025 20:01:11 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/5] selftests: netconsole: validate target
 resume
Message-ID: <hjty4katdz2lmkbjqt4tourk6nf5eq3x2nh6if4ay5xdslpr6n@3htraj5r67py>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
 <20251121-netcons-retrigger-v6-5-9c03f5a2bd6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-netcons-retrigger-v6-5-9c03f5a2bd6f@gmail.com>

On Fri, Nov 21, 2025 at 12:49:04PM +0000, Andre Carvalho wrote:
> +	echo "${BINDMODE} : Test passed" >&2
> +done
> +
> +trap - EXIT
> +exit "${ksft_pass}"

Shellcheck complains about this line given that it expects that exported
variables from other files are always uppercase. I'm going to submit a new
version of this test using ${EXIT_STATUS} instead, which is the same approach
taken by a netcons_torture.sh which was recently added.

We may want to refactor these tests to make use of other selftest's functions
that actually mutate EXIT_STATUS based on the intermediary results of the tests
(by using log_test and other functions from lib.sh) which I think may also
help with making result logging a bit more in line with other tests. I'd like to
do this in a separate series and migrate all tests, if we agree on this direction.

> 
> -- 
> 2.52.0
> 

-- 
Andre Carvalho

