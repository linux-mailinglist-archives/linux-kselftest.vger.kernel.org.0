Return-Path: <linux-kselftest+bounces-20791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC999B253B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 07:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1560228183E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 06:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F4218E020;
	Mon, 28 Oct 2024 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOx5OKFM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1118CC12
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096749; cv=none; b=sSA4vEsUwzwGNuhlGUht3hgEz394G3zDuyF4O7eyaWjoH0CzeIvnDOZy9CTtPa5z20AVE+FwOHdkASGQ6zdYtP0ZPsrgQx50XfhmK5jvF+FvSXSAK7nRvfKHoLU5XxrpoItNf6kt3e7r216hoEc1dR3uQcgWD4U1bjEICFaA1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096749; c=relaxed/simple;
	bh=Ej3AeKhS5/abexGCtjpcoEfZrYldhNDzcJtRJE3vgls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSNY1Gag1jtHrYG/H0ZnC9XWAfpFCtNjxlBdNI5fpPTjDQptJdkNNL8teUiqWaEzV9sNYw4XeTIzjfe3HUdQsDSn7URPlGwLr1cvzu+ZZ0Io7pzbfxPXN0bD2DCg2BiXZeMvtI8QvJfy4oXScXeuE+3Gjdlb+cX4siDuujwQZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GOx5OKFM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caccadbeeso41344275ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Oct 2024 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730096747; x=1730701547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fAlQccG7+nYMAb+dll6jP8YdzAnpJv1Fs1IZeu8SYo=;
        b=GOx5OKFMZPMVi9D7MFVYXETrbwuuhZ1jzwPLI8XmE8Ia+b3O7j6iDlR4wIA9nTC7dD
         30vLop3pq9fqvoZ+u94SKqm3u1WmQPm3MNkR5e8RpLYQU+GbSGr7pphq/ckxoe0bkznB
         4EbrpD+UqcBTN7s9xDs96WqrHWZO/Y2pHlSD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730096747; x=1730701547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fAlQccG7+nYMAb+dll6jP8YdzAnpJv1Fs1IZeu8SYo=;
        b=L2CSAkzOrJ1o6UQ8CpTCEXbI4uOjH3YAaV/TajQFgeuFOMBnOUUwKQ4SZWBCmEWNUF
         gKchbeBKkOcLgVPEj7a4ifxJBlq+UxHDmXtAcQpFeQY49QnL7IG/ykyViwGrkuSFqTqw
         YBU/K98376Zi2oRcA0Y4TinYFeF8dXyqsIrRQw9iyb0oFYw2wf03j3e8kH1NGuMNPKdT
         fXfokm07bsPDWrpS6vf0V8jU7WxUfATHMD8C1xRITfi45SX07X5DdPjoFMGyWKRIfocv
         UG2aB3zeZXEWOQTd2SY6yb5fjPWQH141Lj/GBzxl81rB9PgHfNmInNxytvNNfapXM47N
         aSfw==
X-Forwarded-Encrypted: i=1; AJvYcCWxzoq1DSl0HAnxglYrf4LZa7TjbJjJdCLEzP8g3TnWQWA7ohmS/01oS7h9uJPFjFq8wn7SMvxf/qcIRwsGMxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6W4ydFC11BPXw2WiCmYTkYzajXvd6DX/E3DoMM5T8XOiNzAWh
	99ELQoYVJR4czJ6EHvZhfjjl4iGYwlkUOwdzyX0lSATeUCSjTw/sQve/KluOu0CViZ6WSVXIoO0
	4gDc=
X-Google-Smtp-Source: AGHT+IFBoCs2QY2GYSDMjnCjHu0aK68+gTisee8FtRtpwIHjDkAm+Jokl2+buZlLblNszHpOkHGD/A==
X-Received: by 2002:a17:902:ecc9:b0:20c:5cdd:aa7 with SMTP id d9443c01a7336-210c6cd3ba7mr108520635ad.43.1730096747327;
        Sun, 27 Oct 2024 23:25:47 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04b567sm43507695ad.274.2024.10.27.23.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 23:25:46 -0700 (PDT)
Message-ID: <19579b1c-0a9b-4c72-be00-44871dd37b9a@linuxfoundation.org>
Date: Mon, 28 Oct 2024 00:25:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
 <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
 <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
 <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
 <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
 <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 00:06, Zhijian Li (Fujitsu) wrote:
> linux/tools/testing/selftests/watchdog# make run_tests
> TAP version 13
> 1..1
> # timeout set to 45
> # selftests: watchdog: watchdog-test
> # Watchdog Ticking Away!
> # .............................................#
> not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
> 
> 
> And i got warning in dmesg
> 
>                                                                                                                     
> [ 1953.229511] watchdog: watchdog0: watchdog did not stop!
> 
> 
> 
> 

Run "make run_tests" under strace and send me the output.

thanks,
-- Shuah




