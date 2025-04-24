Return-Path: <linux-kselftest+bounces-31471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F0DA99CB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 02:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E66C462345
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 00:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC23634;
	Thu, 24 Apr 2025 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d87D02gG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64408BE8
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453922; cv=none; b=LoeOKpD4mktPLn8tBjAhbGyCHKHaYUAi5aUyLIzk/NoQKMC37KF/t5Rlrlm+p+5AwBSstdgbb1PtqKhktBcphcd/qQ4KwsC/HhqjAZWPil2X9IpVw4DOG6zZXFe2fNLsj0NTTulGDXoK27nOjaOeiSsv7oOxkQj8IxqfZT0iJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453922; c=relaxed/simple;
	bh=DXH1IO1hAdU2AUtjl6a4PRgTHigbz0MdgoHTabtuTrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+75PlGoB/cuHo7xZmu4ROSu2IqH700GN1stDoFMbYWbOJmcLPbOOjHYWn2xLLxQP1ksXAKzwY2owPfx1LVGaNoOYix7qkG++a9VLa1XSpP0PYnZEI9LS2ZcleeOOJSUZvo+AbTS3xwNPkN3uNLG0qBZnJb8iK+jlkBBS50O0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d87D02gG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d46ef71b6cso3699215ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745453919; x=1746058719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=no699vHbUtCiDhtLMFa9ixz998D4Np4s8xMtsBpgtGE=;
        b=d87D02gGa/UZORutiv03V45T81hXnmmU+G3VpRlz9SjGV6rGeWbrPDPntpPLFihWPZ
         M9IfOkMlSenOm+fU53pdMJyWhBHTU7BWD+6UA88n4peLvi2fQDzWtZTuBwDYiRl/ejDQ
         Shp8YKMciKEDOvCiK/uMKf1GLqzt1LOG+yLZUijtwh3m5aBBV//RvPhmrlr0yG8fvbsa
         zmd1Pa+go8j4OIFHJ4pW9rylm+9ZZLERQ0QhxYB3sT1/YEnaonDPVEwuFHaE7u4vorwW
         4+/Tcs17BSq52Au8eSDu1pa098/AQ1IfXTaUUBEAaw36KRoQVoz3C54DBNLyxfczmYKs
         E25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745453919; x=1746058719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no699vHbUtCiDhtLMFa9ixz998D4Np4s8xMtsBpgtGE=;
        b=sgVm25twrP4Tbu29NoghiOKsEvS4SNQoNcADbNNqZRmLTglnl2kE6ztSeHr/ZMFvAA
         e+IZr+j1AP0yY02CT9JRiXg8d4eOZjgZVrpNRld8YkKlqbF28fTtGSNXAGQShk9KksLy
         Ga9QZ1f17vkdOHKOjh4xSdoL4XVD2GiBBs6pbS6dqllfwLdp4WoRsE7lb0Pc7iqwD7JJ
         tEmAZkFgDct3hOo3PkvnYs4sJmjjIjLOaxJ3CRonUivsDHp7Rletn8ZZ5SKq/d3qE7zS
         s/2qPkYqgcxzfp6qILrPHndosJWm01j0v9Vc6rIIhdOx07TkUjBIc6rTy25FI2OKzlGu
         GdYA==
X-Forwarded-Encrypted: i=1; AJvYcCX5GHwhPACJt4C7wZ6V+wvduzryBNMiBgnBn171uBiDnsG50jDjlZgQnLcNshiHt7/SwCSKHNWJJyYslhKXfmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnY6jJh7Q5Ur3UOGC2rJI4XFQjun1MBEB5a2vXEBPbmZRxLEe
	lp0BXLwixnDR/1SktA1KlZ5kwSh02owwdyrbgy7/PEjZEOVzpiQzy+xC9BldSb0=
X-Gm-Gg: ASbGncumhw7Z3QlOtuM24YZ7m9Mn0dbtwtD+5Rf3DpbwDKpI1eWqBMAoT/fLvPfI2pT
	BanaYIuF1LT6S0v3FghJeqvKZmM2hGC/1qtH2ZZ8w2vqKZ41KZ11Ct9ilyc/zTsorkKvD1kl5OJ
	JR1YwrNoXPaYx300OoLbdaIRgkMSfnIzEhHjLZvcUTWRWdeca2R3678rkuBbS25Y+AgRVAo+JWW
	rBgqfiUcT41fXvRZG3kU0LjlWt7MpwfwGlprVk7OBJn+8Byq3YkofkF28V0eTz9m3bCzmueGyyI
	eTAjIMEs5+XI0JSh5zDzzICR0IvNpjQhT9TrKw==
X-Google-Smtp-Source: AGHT+IHb+es9H9M9kGSwtETCKJLbMt7YPfw3chQ/Lxuw7WSyGf0XVM1d+FlyYn7Hy8udiuXpl/zxhQ==
X-Received: by 2002:a05:6e02:188f:b0:3d4:3db1:77ae with SMTP id e9e14a558f8ab-3d93041d81cmr7327905ab.18.1745453918771;
        Wed, 23 Apr 2025 17:18:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d9314c828bsm410385ab.27.2025.04.23.17.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 17:18:38 -0700 (PDT)
Message-ID: <1c7744df-329f-4b95-9afb-a005a358851b@kernel.dk>
Date: Wed, 23 Apr 2025 18:18:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: ublk: kublk: build with -Werror
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
 <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 3:29 PM, Uday Shankar wrote:
> Heeding compiler warnings is generally a good idea, and is easy to do
> for kublk since there is not much source code. Turn warnings into errors
> so that anyone making changes is forced to heed them.

Honestly not a fan of this, it tends to cause random warnings on
different compilers, and then just causing trouble for people
rather than being useful. If you think it's a good idea, make
it follow CONFIG_WERROR at least, don't make it unconditional.

-- 
Jens Axboe


