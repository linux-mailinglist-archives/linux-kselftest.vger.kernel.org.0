Return-Path: <linux-kselftest+bounces-16001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FDC95ADF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD92813F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE4381727;
	Thu, 22 Aug 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L1flswx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D757C61FFC
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309358; cv=none; b=CgfHSI9KhVaW2yMiwgVBd8J+vB1VChby6P+A1Ryge/zAXKkHqvolP/hwitVbhlmHvRU/pyMlY/MKIY988LypPWtPbLrsKDsN8rvUN/e7QWic548dLHHdi1sAkU4OfYjj398t+nUG1rfRr5PUsFw+rSVPJnaBm+zt/HjjwjnZnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309358; c=relaxed/simple;
	bh=bm35xzNfjPNHwPgApXChsxl3mMGjNrYMUtPIE8+4Vc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LauLAOnZx3ENnawukzW+mjgyfha9Dap4q/xKehz7XVXdjGy2RWgtnyPVCtp2VmsEfwejLqdPW/AQmKBdRD65RIsCJc0df/ZEJUHaixPOXaNWpzUbqQ5bfibAroOmYrurZ5oeNVQpBufofQgy2B2SNri6zhYczVrN03okk15FjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L1flswx6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714263cb074so433273b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724309356; x=1724914156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDioYLjnuZOABk4MhI6ybqHWdYh/8eyEkk0WTD9uczo=;
        b=L1flswx61flErnvEM1LGC+wbF6qUGjOf2MReGPnIoVFLwFUOrfsooL4EgDiQnGOji5
         Z/9I9Rzh67rmqmcR5aC/gnowsiujp4Mv/2RHfEDK0pOEs41b/c7oxSeGTsgi7Xe/swgH
         Te5dtfNUvjQoqP/ve4pwEPP9jBN9/rAHDCqMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309356; x=1724914156;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDioYLjnuZOABk4MhI6ybqHWdYh/8eyEkk0WTD9uczo=;
        b=t2/MS6FtfgJUdmhfGRGxdhAIMVZpkNrBXA0Eo1/xDwYZ++3P7VZbHEvPSxAgj+TqKz
         sTd3t51UXY8xGvK0f/IJNwt4gEhKVVwRmFmLrlsGsscarD5xCOx3m0PdrTf9rpu8mhF4
         3fEiRUFJ6vnhV0vtTJZIVemXE0OJKd8T++tzP1jUr0Hs5k0ChEpxpYvE3FEd00Mcx2QC
         zU8P9DMfQw6yUy201DAt75H7/43aOU86d8Abr2+2I8gppPCIWCbBQdw5FT5WR39k1eq3
         ZCi36w+C/mlWKH/YEGxOv67qZpx+mrQ2iLUwPZ6EEyZDcWF9zl5h9sJ/FrQWXDyYhQi6
         V2YA==
X-Forwarded-Encrypted: i=1; AJvYcCXZvvrPz+xDop0CcGCkIDIpWVoN0rjm2+r5DTY7qoQKCZ4A/gCejNrkaQVASsqEymTeTfAteHJgNSB3yDfbTV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZTmTWdfy6XAnsB9DQeFmWpJOwLe71yf5ThlhBM5D9YZ5X3Lr
	wuA43LsaKaQOVGv9sXbhykdfVz4p2fLq8DMbENwnP5ojf0swILaVD06qCSKBZw3KcU9wvr5SiS9
	9jrI=
X-Google-Smtp-Source: AGHT+IFSSmQywai21wWHMSzrIWMLzk8cOf/eB8M4ri4UGRpHPRJ0aIJhqyrLWe/YRibmGCd+QTXXzw==
X-Received: by 2002:a05:6a00:b95:b0:714:200c:39a3 with SMTP id d2e1a72fcca58-71436489010mr1382740b3a.5.1724309355739;
        Wed, 21 Aug 2024 23:49:15 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm702839b3a.39.2024.08.21.23.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 23:49:15 -0700 (PDT)
Message-ID: <da3e91a8-da04-4c81-af84-405c5b46d345@linuxfoundation.org>
Date: Thu, 22 Aug 2024 00:49:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test coverage for dup_fd() failure handling in
 unshare_fd()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-kselftest@vger.kernel.org
References: <20240822043932.GT504335@ZenIV>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240822043932.GT504335@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 22:39, Al Viro wrote:
> 	At some point there'd been a dumb braino during the dup_fd()
> calling conventions change; caught by smatch and immediately fixed.
> The trouble is, there had been no test coverage for the dup_fd() failure
> handling - neither in kselftests nor in LTP.  Fortunately, it can be
> triggered on stock kernel - ENOMEM would require fault injection, but
> EMFILE can be had with sysctl alone (fs.nr_open).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Applied to linux-kselftest next for Linux 6.12-rc1 after fixing up
the short log to reflect the right test.

Thank you.

thanks,
-- Shuah


