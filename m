Return-Path: <linux-kselftest+bounces-18252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360597F12C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 21:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9302824D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 19:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035541A00F0;
	Mon, 23 Sep 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K8IhfDBr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804F3BB25
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727119192; cv=none; b=FRI7f7lMBSQoQib42/qHm8KuWaSEcBOvMjoXBL9GDBfJaTDg6xQozCrubEvrd5/478WTa3QoH9p0o94THZHya4SFLvRDldjhjAMXv2L5Cv0EClbh3zCOfTxSi3Kw+o8mX4JjEvnY1OEWVtXvCj1QFieTm5b6fyWbZCA9ntgQ4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727119192; c=relaxed/simple;
	bh=LVDRAwNA4/yiZ68j+P1qvF9Vq9TVO0UXupxwXynk5pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLxbjAizJCXLHvoPIVijnbJxnXkg5EfwvhlbKK3y60bKN3uY1STCPdRXZyF+iEN40KlRaz8Qzg3betuuhh+3j54ZIUql6D0Vq5Umdnm7QLrOoDmLwqhiAWenEXwsrUfYoOeV+aE2rtNFXX+q1OwXbmzsH/TSxf2wHdDySKzFsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K8IhfDBr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1c49f9b9aso1814991eaf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727119189; x=1727723989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Aj/w0ltn4aaO/BsDzIkH+vPisv+CKf4iCYv1JDmDCY=;
        b=K8IhfDBrJNaGj7T16uiI2rN/VR8/P27gUlZeU/WsrHgxUdYEG/PM8XQcWVkUOCXzzO
         F498n7ORmoYmXCkB2yk0mGtGsm1pTZZReoe8seXF418DSLK0pLe2MbuBKiM7GGajb4Lj
         VX/afGqOYZSgYXGSRTrgaG3TdUPN3Te6N2cps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727119189; x=1727723989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Aj/w0ltn4aaO/BsDzIkH+vPisv+CKf4iCYv1JDmDCY=;
        b=Egz3BdCiRSS5sxyyBNwgbwVEhklo3Py0V03K3pS/lUsxu27sghgroHJDXNDtTA1+nL
         iic+s94uooGDH8Uc5lDEOwdENeV3ctblHexNbFKkWMw0b/AR9GUqRd/rEmcmjqZ13s0n
         eBT/3LHHjB3C4dLOC0uJ9J0ZuQxHCSi++PJH8KZk41ruO/FjGQYeAWgPTCTD40/8Gy7n
         ASrK6TmQNw/+7JLgCRKBmzatCXtRZ8CWHOBfgJ56NeuPmmJND98KYV237mY5LmBFTUK6
         z1RcfLTRpq0h6RrA6Tr6z5+hHIf2M7tSrTFCus8qDJPHI8eCi7JwUPbRrTXBwZYOVHfH
         LuIA==
X-Gm-Message-State: AOJu0YxTTsDmp+rx1uaQULWa8YTRSoXz7aWf7Oc+yuT5FTj7ONfuaTY/
	EECm2+130dLHP1TSg63SlpVUzjf878zFr1lFgOQrFjQOLdJ4h+pr6wueLGZR/Go=
X-Google-Smtp-Source: AGHT+IGTe/rdyrQFSEsFu1IZGEeJfCQf2lhyHoBH3eSWs54EiOs6qK1PDbLNTVtnIHCiH27bnYPQIQ==
X-Received: by 2002:a05:6820:820:b0:5e1:de92:6b42 with SMTP id 006d021491bc7-5e58b81ee12mr6469670eaf.0.1727119189597;
        Mon, 23 Sep 2024 12:19:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0d6aea3sm3560435eaf.4.2024.09.23.12.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 12:19:49 -0700 (PDT)
Message-ID: <7e831d5b-1bc4-4d6d-99d7-b160cd580528@linuxfoundation.org>
Date: Mon, 23 Sep 2024 13:19:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] unicode: kunit: change tests filename and path
To: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, David Gow
 <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 porlando@lkcamp.dev, dpereira@lkcamp.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
 <20240923173454.264852-3-gbittencourt@lkcamp.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240923173454.264852-3-gbittencourt@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 11:34, Gabriela Bittencourt wrote:
> Change utf8 kunit test filename and path to follow the style
> convention on Documentation/dev-tools/kunit/style.rst
> 
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> ---
>   fs/unicode/Makefile                                | 2 +-
>   fs/unicode/{ => tests}/.kunitconfig                | 0
>   fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
>   3 files changed, 1 insertion(+), 1 deletion(-)
>   rename fs/unicode/{ => tests}/.kunitconfig (100%)
>   rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)
> 
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index 37bbcbc628a1..d95be7fb9f6b 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>   obj-y			+= unicode.o
>   endif
>   obj-$(CONFIG_UNICODE)	+= utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
>   
>   unicode-y := utf8-norm.o utf8-core.o
>   
> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
> similarity index 100%
> rename from fs/unicode/.kunitconfig
> rename to fs/unicode/tests/.kunitconfig
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
> similarity index 100%
> rename from fs/unicode/utf8-selftest.c
> rename to fs/unicode/tests/utf8_kunit.c

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

