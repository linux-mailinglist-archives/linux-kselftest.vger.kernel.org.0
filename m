Return-Path: <linux-kselftest+bounces-18672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D698AB37
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6DF281B9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5051957FC;
	Mon, 30 Sep 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn2qctQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DE19047D;
	Mon, 30 Sep 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717836; cv=none; b=c6BLKmZk/AZXs7Pi6lT6xTNbDVI625RHUh1Q3BP7dYwURdpD9U9/Uh73o/8nDtfawyPuDpFoeWixhKiLHcV+I/NdaYcCrkJmRNgjW4JJYSeiodOIQeGn4qgHlHG8fnrQ25ydYqJKFmVHLZXAa2LOyBtRmUEXomkkCmn1C6IN0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717836; c=relaxed/simple;
	bh=dGcJj9eNXGHvyYApm7mEg/otB0xqAYn0zz8pSjqVKsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVlLd4goU7CEu4fARHptZeTulOgmQL/ZFsPgykE+7uucad/QPJdcc60zUsMExcqQ4stHqy2RcHgQXkAtBkOGmtkxUja2Mad1iB7voVOCUVrp8TkxKf/uEnh5+TlusI2Vra6aKZqoo7P8NCIIDQ5LnBoT5UjNdr1qfB1bnUNwRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn2qctQX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso37276415e9.0;
        Mon, 30 Sep 2024 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717833; x=1728322633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEYf4HAASzoFKE/q7lqWoHsmJU1YmaheBDaJDh/hQeE=;
        b=Wn2qctQXGQ9OkkjLRTcthAooNHSyYYHHoUZtHPAPnPn5CDz5XEPLffsHZpCGrEWzRg
         31XyXyjnX1rEFmdb8qneExxt01CcH60Kd4+gdQTMtmgu1HT8I5K9CIVrg6znBRDD5KMm
         nqnS3gRIDPy3fjPAW9poE3i7XvPczwMKhvgkZob7UNt4W+ZWrWIbsRlMFU5p1NZzVr7t
         5x6R+xuQ0jlo+zNqwJmpQFH/0miN6hZGJcF66c9J6opvFUzzOjB+wc8PiDQ+/DJ5HGxl
         8fOLiJ0Ho/8MvM8UyiCrKZZg9dJ22GaXwRXBB2jxhFZACHaBZaegFgChNua6bw1Q/ymi
         lWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717833; x=1728322633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEYf4HAASzoFKE/q7lqWoHsmJU1YmaheBDaJDh/hQeE=;
        b=OLdl55a5hB6XOZMHV0EvNBjnGMYoV9RZnrN/O653kblRsUeQDdhl4ndT7QvddRMity
         g5Pn1hq9HaR3SIlgCxQ3ix/mrMzdCXFeZafHc9kJL9CA/2Cosoz2KwctvR+tTD4zd922
         MSJcKt1yJ8I8QAMJZhC+PVVRyX+RrKZ9Nip8BtI1qL7hSey4yq38t/rVNjqL7OobmRRn
         crN/jPKsa0dv4Zvfz40LEpgy9gBzSCeQWgop4oH3S33SSK2t3rPTRKWekfsjM21SyYYV
         xw1jg08raPFBcPs2Dlw7M1ezsP8TBLbu815NA82dqQrkEq9Zbn0SqNMt7KolUPi4ciip
         /1BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbZFFMHihS0G2Cbzdc9nVys1Vuefm8IadjgW3h6e1OWDN/XHu8BjpzYp5QIdd+3Nrnu6bqHaWXetlMJA==@vger.kernel.org, AJvYcCV442W3BYaZfHfj2+ndRDa3iwqhqcRPhB4lDAaEugZUMyTp1QC/lz9trKqPVMOD+b6raOyFgaRH@vger.kernel.org, AJvYcCXjv1/ECnAcOrAcLxZ0EaqMjVs8zY86Neb2R5f0TbWuGBgagZOsy1AFiCOHunUZYT3Vr9JPnA2vl2hg44E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRpb1SCbI9XstNiG6oHqEDQtws85LPNrZE/xUTvQRvNpt6jD5
	zGwwuHoxIGjYBXOlrKvVz4ynxA4OmDhhnbQy3rv6fOzCB8zwjUs8
X-Google-Smtp-Source: AGHT+IFNNIUNqSb9umiZTgmXgbPzkzlMldhDtmiMP7aFOiTlHumpiLU/2DfUa8nRZvMXT3FgQiTNhg==
X-Received: by 2002:adf:ec8c:0:b0:37c:d02a:7e41 with SMTP id ffacd0b85a97d-37cd5aa9d1fmr7605458f8f.15.1727717833392;
        Mon, 30 Sep 2024 10:37:13 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:91b0:e3db:523:d17? (2a02-8389-41cf-e200-91b0-e3db-0523-0d17.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:91b0:e3db:523:d17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e669sm9585446f8f.34.2024.09.30.10.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:37:12 -0700 (PDT)
Message-ID: <985eaf77-3e63-4fef-bd47-e6214a6639fe@gmail.com>
Date: Mon, 30 Sep 2024 19:37:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] selftests: gitignore and clean target file
 additions
To: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2024 23:55, Javier Carrasco wrote:
> Trivial patches to update the gitignore files unders selftests, and a
> little addition to EXTRA_CLEAN under net/rds to account for the
> automatically generated include.sh.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v3:
> - Split new entries in core and net gitignore files into two patches.
> - Link to v2: https://lore.kernel.org/r/20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com
> 
> Changes in v2:
> - [PATCH 4/4] add excepction for load_address.c (must be tracked).
> - Link to v1: https://lore.kernel.org/r/20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com
> 
> ---
> Javier Carrasco (5):
>       selftests: core: add unshare_test to gitignore
>       selftests: net: add msg_oob to gitignore
>       selftests: rds: add include.sh to EXTRA_CLEAN
>       selftests: rds: add gitignore file for include.sh
>       selftests: exec: update gitignore for load_address
> 
>  tools/testing/selftests/core/.gitignore    | 1 +
>  tools/testing/selftests/exec/.gitignore    | 3 ++-
>  tools/testing/selftests/net/.gitignore     | 1 +
>  tools/testing/selftests/net/rds/.gitignore | 1 +
>  tools/testing/selftests/net/rds/Makefile   | 2 +-
>  5 files changed, 6 insertions(+), 2 deletions(-)
> ---
> base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
> change-id: 20240924-selftests-gitignore-e41133e6c5bd
> 
> Best regards,

I sent the net-related patches in a separate series:

- [PATCH v3 2/5] selftests: net: add msg_oob to gitignore
- [PATCH v3 3/5] selftests: rds: add include.sh to EXTRA_CLEAN
- [PATCH v3 4/5] selftests: rds: add gitignore file for include.sh

The rest of the patches belong to selftests too, and can be applied from
this series:

- [PATCH v3 1/5] selftests: core: add unshare_test to gitignore
- [PATCH v3 5/5] selftests: exec: update gitignore for load_address

Thanks and best regards,
Javier Carrasco

