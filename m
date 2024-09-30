Return-Path: <linux-kselftest+bounces-18682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB7198AC61
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782DA1C219CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77C71991D3;
	Mon, 30 Sep 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IteaKldz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322A198850
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722189; cv=none; b=VTLRB0BXvpxx6hxomd1MTsuKUlBxdvxjNSpGp0wAZyxDwPiU113yGx7tFACjVvzA3OxN5dRXS+jECEM1lK0+pC8fEbpbKX1EacID7cBjrvbWpOBNIi6tUs7Wrao/1eK0FMDq5sI1rs+tSac0VogMddaR5CaoQi+LUmi9sTCXMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722189; c=relaxed/simple;
	bh=058ine7/VNy79CgT425CPqN+8vvJjeOo1Wv0JRTaNDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNhWOmARtRXLkuM9m6UcNzAZoeewpkP9ksg/SxhQGw/GWTLTsoHXqnS8BuiZa9Ocz45m4C6LNAepxv/In9J+PcbMsgDO01QVaJCeZDnRjUsG7+x7hWIDUslDYfyI0lCUbEOgQXg4WmTeeYOAuIK7ztIlgA0qFO9ExWqMz3VF84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IteaKldz; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8323dddfca2so280977239f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727722186; x=1728326986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a60vBEwneKd4X7+bDew6gvsUX4D2oqmSLXGoRIIlbvA=;
        b=IteaKldzVbxHBjsadJskwFYK8Rl76F7MGLvG0MuoBLI1CryM3p/xJruG0NAqCNrYTo
         O5EjLjpWhx1FdrczP71MOTplZKqI/EXD84o43GkbIp1eqMpiw7zHjS53TVpI8xlvtMjS
         JkayN8qpB3AlGY9VGJsR7tfgss911JqdDxI58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722186; x=1728326986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a60vBEwneKd4X7+bDew6gvsUX4D2oqmSLXGoRIIlbvA=;
        b=hycNhvQXVHGEXNagK5L1Urf96F2txUav0MqJ2L0zm6BX8OP8oaNZlZDLYegf36n/ZP
         VYAUpKiaWOAj5fVjdTBU2OqAjFYCv2ji5e/98IiHxYtVOHSmA1pKFdwytejN+UG3AKxs
         giViEL7F4N58MhSe/3HWSGtTcLfqNRFqJU1gi1Or9xDYBhCvPKlKNIXho/UuLd4vBzCp
         8GJyaw1zohg8vI7kuXcgxqbKQ1KDRlCk6XEsYCHsi80Q9SK12fkKjoi0SWkO9lYeFbVP
         mWhRzyB1o8FDxVyIhCj/QQMrJwW0FYyRTS2zLdnSmtdlXdsbQA39RwNdZoo0T8UKF04v
         QuHw==
X-Forwarded-Encrypted: i=1; AJvYcCWH9Ag0f1sW1PbNId3YOKa2yL6nXdtN432x9B+/GTptdoKMqjI3ciRlCQYN4YtehKlGehzvYdFmMObLEL1Pb6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdju0WRqFRtc26+imBu2URZnfYkVdMUacoGClBNlA8zrgcy0/
	N6IZ65pCLzefxTxxyFcvvQrWncwpmP6kgw4fMhEwuiumUG/OuaW5zk2U3budHXo=
X-Google-Smtp-Source: AGHT+IGKQ+dozzTAqgMX8sd4LRbQCtOhrdrHVPEMD0oL12CzQY+1S9hCbuAGwNg1/laxIb9nfe1H6A==
X-Received: by 2002:a05:6602:340d:b0:82a:2a0b:1c7d with SMTP id ca18e2360f4ac-834931c3c44mr1063694439f.5.1727722186133;
        Mon, 30 Sep 2024 11:49:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834937194d6sm237965339f.40.2024.09.30.11.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 11:49:45 -0700 (PDT)
Message-ID: <54d1bcb6-b817-4ab5-be0e-aea34cfe0d5f@linuxfoundation.org>
Date: Mon, 30 Sep 2024 12:49:44 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: improve timer_create failure message
To: Gianfranco Trad <gianf.trad@gmail.com>, jstultz@google.com,
 tglx@linutronix.de, sboyd@kernel.org, anna-maria@linutronix.de,
 frederic@kernel.org, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <877cbz9x8t.ffs@tglx> <20240829153725.4437-1-gianf.trad@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240829153725.4437-1-gianf.trad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 09:37, Gianfranco Trad wrote:
> improve timer_create failure message with strerror() function
> to give more information to the user.
> 
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
>   tools/testing/selftests/timers/alarmtimer-suspend.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
> index ad52e608b88e..74acdb87d4f4 100644
> --- a/tools/testing/selftests/timers/alarmtimer-suspend.c
> +++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
> @@ -28,6 +28,7 @@
>   #include <signal.h>
>   #include <stdlib.h>
>   #include <pthread.h>
> +#include <errno.h>
>   #include "../kselftest.h"
>   
>   #define CLOCK_REALTIME			0
> @@ -142,8 +143,8 @@ int main(void)
>   
>   		alarmcount = 0;
>   		if (timer_create(alarm_clock_id, &se, &tm1) == -1) {
> -			printf("timer_create failed, %s unsupported?\n",
> -					clockstring(alarm_clock_id));
> +			printf("timer_create failed, %s unsupported?: %s\n",
> +					clockstring(alarm_clock_id), strerror(errno));
>   			break;
>   		}
>   

Jon, Does this look good to you? I can pick this up if you
okay with this change.

thanks,
-- Shuah



