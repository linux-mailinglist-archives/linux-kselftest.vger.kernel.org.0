Return-Path: <linux-kselftest+bounces-11440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215C900CCA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4501F2204A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C013D29E;
	Fri,  7 Jun 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPyWDHNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C719D89B
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791482; cv=none; b=Uu+DyOfp4X1cRdArzA1jKe08SN5sEIr0C2z0TNq4/qqmhYicIJkZA/70p4PRaeiLBxFYaB1iN9iGeQ0Q7LiBi18t/EPj+I2U1C7ON8mwKkkw5JZyg92UmLJ0H8uclytbCAXRv2T6AI4f0a/898DBEXQX6neRFhI2R1pHNu54xGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791482; c=relaxed/simple;
	bh=UB5s80mJjpD5S2fyPWM89kkMDwEBiG8QWTL/KS+R40c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgvlQSc+8IDDoa9C77aqHjWk22+zt4dB8uMvJvzI6B1yiW/KNTGY+2D51okLz07+PdYX6AoPHCGejE6e1GGmJgqdFPPJIpo5qB7+/3Y/RZpKznEPSLkSHe9DgvnyVrq/Vb8CpZcvXZrkTByncDqkvGx/xDjrXCwAYVdqkug20MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPyWDHNP; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3758686ef2fso536175ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717791480; x=1718396280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41SiVGCrDx5VIgYy2QMpfJPy2T9XtE7ishwFfeWvRFA=;
        b=XPyWDHNPtls00wLn5ftQ9hqhsEcR7plHcSSgn/9pB3SVWlrA9KE9Enk38TW7Ve3NF6
         mWtKALFyb/Sn3ZSgi+BeAk9Lf9Vq2dY276ePPPCrRLS92je2ZqAJWdatr+S6hce5Gd9q
         D56PYweNiPCzx2dvUmRkopau8NMQ8EWA4haww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791480; x=1718396280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41SiVGCrDx5VIgYy2QMpfJPy2T9XtE7ishwFfeWvRFA=;
        b=LUe1nLSnK0IVtpxmyrgJIcEuDd/HxCSVkiMVKENHstASugbkqsw49zwmkfCyBxDzpu
         /OirT+Gyh+R8aphzL6lJ6sKJ07QU24KUA1qAy+UXMPYr8k0eNlpopecxIyxaqfnDkoQm
         +B3K0VzIqZHy5IFwYhY2PeeeM5PJwZewapGWUzrZP+j/KzG1vtTTsrc+FlvzSuRbQm47
         G9OOdjSQH88Xs4Zl2ZCw7xfB28KugNVtZJZlnjSmPXEVa7arlwTfwXy1h7swmT/nM2Lh
         8tv5s1UH1QlzXuThvKsiMofap91Z+IcYobIsS3+gEQDSlc6SdcuymzN8zuwOq1Be6xjq
         HxPA==
X-Gm-Message-State: AOJu0YxDv8DiQpXeKH4PPM9hQ8IlNN+nW0wMYb8HibAJ4D8T3SZPPA7N
	y3ZuQVYfnq2rOofzWND6l1VlAkE2nDJ6Nsti23K52WP6O5TSmmuGsW9VNSx4XRGV2WJ/a2E+FK4
	6
X-Google-Smtp-Source: AGHT+IG8Rqv1GtpDT6UOg/8KVMOhC1Xk9ajvVoVWwul9f7DPuynx9xS5SOnHzaa63v2kaVPp5Et6ng==
X-Received: by 2002:a6b:720e:0:b0:7e1:b4c8:774d with SMTP id ca18e2360f4ac-7eb5712cfafmr365912939f.0.1717791479831;
        Fri, 07 Jun 2024 13:17:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7eb4c47cb80sm87609839f.42.2024.06.07.13.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:17:59 -0700 (PDT)
Message-ID: <02ef91f7-9787-41be-82e7-b9403ce1046c@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:17:58 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/testing/selftests/x86: add dlclose function in the
 vdso_restorer.c
To: liujing <liujing@cmss.chinamobile.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231204090111.2967-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231204090111.2967-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 02:01, liujing wrote:
> in the main function of vdso_restorer.c,there is a dlopen function,
> but there is no dlclose function to close the file

Explain the change this patch is making in addition to describing
the problem. Also tell me how you found this problem.

> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/x86/vdso_restorer.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
> index fe99f2434155..a0b1155dee31 100644
> --- a/tools/testing/selftests/x86/vdso_restorer.c
> +++ b/tools/testing/selftests/x86/vdso_restorer.c
> @@ -57,6 +57,8 @@ int main()
>   		return 0;
>   	}
>   
> +	dlclose(vdso);
> +
>   	memset(&sa, 0, sizeof(sa));
>   	sa.handler = handler_with_siginfo;
>   	sa.flags = SA_SIGINFO;

thanks,
-- Shuah

