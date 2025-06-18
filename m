Return-Path: <linux-kselftest+bounces-35327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D73ADF8B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 23:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FCF169C4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 21:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604927A909;
	Wed, 18 Jun 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Unydjvjz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2227A927
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281903; cv=none; b=pxk8Ljeuk2WaQSXoWAfeJICzOX9nE2q6FvXbi5gt8ZKGdFYS+26E4oGDvjkH7l8GnFs4cKoQdue1S3o/zQYw5v8vCpprS9Eki0wrq9prtZlpIpe2XY74zb6Tn9O59Lq4Sh4W2vpIgPzkRkgAiSJeXrBpnwKM+BOjTJvH7eAN9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281903; c=relaxed/simple;
	bh=4TnKHVuK1SxXh4SdmJti3/CTGjaeWeFbmFWbLEc5+Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXmgV2wEBN2iSAD6KXx7CuO3Seqp1VigVDblpSjNVqJHdQ5tYw65X0FPR3K8RV7Nd67xSQmru91/pLLstYepA5rGdBw0WAQRDQ9FoL3zSWs/+14yEmP7tndg10IxRZMcRJqGmaHQzV5OdZ4RLE1D/hpEBM2jfWUtAAYjg7ZFWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Unydjvjz; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso1189745ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750281900; x=1750886700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/stNUEq4UDmKbaaw+CMdc4IVQ+kMvVtSAce9sGS+c0=;
        b=UnydjvjzEQnaBKia9+dlVLaw20KAB8lEWPuRECdsOo/CFZHw4V6yVOKfKS2CZdMQCe
         jKDgmAieNYGUvNVIEscVz6G3RfFkXCZb5fkGm8Y/2jhWef/lFzNPWQktGtLHOmeeqVg8
         edOweoYcG8IDHV16CYiws9w2rQrLyAQN9by7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281900; x=1750886700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/stNUEq4UDmKbaaw+CMdc4IVQ+kMvVtSAce9sGS+c0=;
        b=CAmRb1gvHQCdl9dsOxnqHpjTcKayxY5531okYfjv5SBIZxLomdrr+7XkqQgRea+QoT
         2lfqDeViLixaKpg+hK+/pTBYdqoTu2orsc0IN9TS1H3TgL+92eYyI8Z1uSC0CmxAbgTI
         f9Zh4rVf0k7JaY1RwahXdRscUsGPIKfKaD7IZhyidvvySpffuTPDU2ozq2X0Mh93M039
         iaImO09BhJSjkfu+DKG1P7cHsGS5YIJAK666zcGsJGQJeEeYgYngyRZ6RMmGtfrNSgOE
         agRgh9JLWy+m7phaovzn0U80HC3UGaWRkA+LEh59sSUFobLfJ0S6eGDDPVNytrO3KM+9
         bR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkbYnnaDR9xpNSF1/eM7Q2UzxLU7VHGNNZop49n78ASgWCe4/p53hq2bPCiRS+WSFqwpKqNQq//+LvCVUdGgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9/b+1tuUsHZQPTAyPH4fktg6Bjj8yiqMw5rYpOLn5nR8hvFi
	rc//L8uQeOAHJfT8VpRaS0eROpX6/qWOCk1dTy9fyT3iuXlU2xYlX+276qKppQKRoys=
X-Gm-Gg: ASbGncuF0asFpwPhPB/lAyHxXs8cJyYwYRsrb5NC8mS+vXjNtzKx6NFpKMqj6Liprue
	X+3XYQ4+ANyQDoC9tHhL1H3KULuyiMQI976SeNzRvYUk+6LVCxsnXRA70OpqFI9npE/Vi0igVfw
	SGb731+vsL3lZ9MLvWajfDQTZrLAXQiwCsvUQpGxtF9I0eQeouq26Oo6qKiigNRyU5Jp1EMGpP6
	vQIyNbTs+nHnTa/PNZs3JRFx+JaiqUDQhYSC/AXph6Fb9j2yc2eePbMCmV0GIG0TXBky4fDQBKy
	W8Cf8vk3ELf4K6dN+d4FLahyiKR/EcoEUjKJfEm3TXaQ3hJlq5mm/KCSS5cN1ZQucBYMrxCx3zA
	PYcCx5Ql6
X-Google-Smtp-Source: AGHT+IHmdfovRRvTsAll6RfN5zR5l+XX4iyEE8X7FBGxM0+hSaxUSUCkMemNO4l2Dex3NydMszgq1g==
X-Received: by 2002:a05:6e02:1c05:b0:3dd:f813:64c5 with SMTP id e9e14a558f8ab-3de07cd451emr241287485ab.22.1750281900220;
        Wed, 18 Jun 2025 14:25:00 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de01a588d2sm33111265ab.71.2025.06.18.14.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 14:24:59 -0700 (PDT)
Message-ID: <97e0eae8-954a-40dd-91ee-4a0a7cc4b9b4@linuxfoundation.org>
Date: Wed, 18 Jun 2025 15:24:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests: add missing include
To: Chen Linxuan <chenlinxuan@uniontech.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250610020839.2799222-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250610020839.2799222-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 20:08, Chen Linxuan wrote:
> I failed to build this test on Ubuntu 24.04.
> Compiler complained about undefined functions mount, umount and some
> mount related flags.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>   tools/testing/selftests/pid_namespace/pid_max.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/pid_namespace/pid_max.c b/tools/testing/selftests/pid_namespace/pid_max.c
> index 96f274f0582b6..c3ee8a2eff75b 100644
> --- a/tools/testing/selftests/pid_namespace/pid_max.c
> +++ b/tools/testing/selftests/pid_namespace/pid_max.c
> @@ -12,6 +12,7 @@
>   #include <syscall.h>
>   #include <sys/mount.h>

Hmm. I see mount.h included here?

>   #include <sys/wait.h>
> +#include <sys/mount.h>

You are adding a duplicate include for the same file?

>   
>   #include "../kselftest_harness.h"
>   #include "../pidfd/pidfd.h"

thanks,
-- Shuah

