Return-Path: <linux-kselftest+bounces-6672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49088CF9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 22:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A837B217B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D4813D24A;
	Tue, 26 Mar 2024 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNjq53d0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609277353B
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487227; cv=none; b=k58tWY0N1eAFSdTkzTMNtONcB2f3WOyYziVU8nHFZUp0PpvuvaYMo4QCSaAmDV6J1eP0iMCLaGU7yyt0CYzjSCZsE3zEmmLeUn5XG3vbTIN9/lD+hMelmTrgWEXSdfsxjA1lew6Cww16Tu6uUP5pXb2KNU+OKKAAl9rg8Wzs2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487227; c=relaxed/simple;
	bh=CC5FyE0zQfuIyeTw+Qxp7dURi4ajWPDxw2mwU+3pW8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWTYy49NnXV1nKslBs+5o7c4bugkPrP34Crzst1yhBUe2r56fBv7sduA2wBG/ePcSd+hu6nI2OS0ZZYaMIZmRzpUikRwVFM8W0tPkWEebhufBWs8d322AjDWg4AlGoWx5vefcpEEnDE8mgJxEsJXy0/9zUzRWEfqO6YcWt7ki6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNjq53d0; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so87495839f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711487224; x=1712092024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PLiSINvcugXBKIj3e2GZRldo2gahoHYSJg2AQjA7b78=;
        b=cNjq53d0fgPpe+1Nx3ewg+3NfsFcesgEh0of0sFewLx5kTkV44Val4/3Wbk7jlF5QA
         J9dgR3Dx3VD3737UD8+wihh1jeCgF1nPO0gigJWMlnnIb0VXqTqfNhRFRFFYmTwrtT8F
         cyzZG1jxayTIYiZaSGamRxE/ygpGhUt44cu0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487224; x=1712092024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLiSINvcugXBKIj3e2GZRldo2gahoHYSJg2AQjA7b78=;
        b=I5DpSGikBtgKqOApO2conMBgVSL5U1JY6PWzbx3JU96uEdEKrTDWhQv6gyoHQ8nPTi
         sh9Tf7EtzB/YDAJ51JhAznwlAzrzvRxsgk9rkAR8IQ+B36ce2Ma3o+hcDqBuIgComurT
         ScTAphUMH+GwzuI0toTKYf6nZJGvKAHj/R7OjtbfGBiOFZaXv/rMxyHdWVms7q+bwpaT
         4omoIvTvkOH+6gaz/c/liCxIiajGe2o0K0RbQGXZ5duMwDerZFoqk6YCT/SNTWqUeR4J
         +H9xZ260kS9mR+AGnT2sLgnm01anCmjQcSzIaRUfYBpxgoLLlUppXuRK30A0VerBLev+
         HW7A==
X-Forwarded-Encrypted: i=1; AJvYcCXfFpMwcaYnTI+xDdO+VXkAfFM/h5eRVUxPielsCDDDsA90sWc8wLVZfWHEa3eB8lW7KgWgdwx5IZQdUexrNOPZjgnmxvN2o1SzPLIQ+/Fv
X-Gm-Message-State: AOJu0YxDvulSgSmzrhOzJAZ1ISGVxc99aB12dlJuQTL6XSqwW/rB5J2U
	uu3ZWNEQdtxOm9rWOa5Nv+hdMTVA76LzJ4AvpXHGl546Cin1javwHVty1g9u+oE=
X-Google-Smtp-Source: AGHT+IEK6tjwy+wB5PmyL0t0pBd4tBi15bL0x9BUGWONuNhn8WQmANTLFnYKEwZSV1QCbXcPi+PqbA==
X-Received: by 2002:a5d:81da:0:b0:7d0:4d78:989b with SMTP id t26-20020a5d81da000000b007d04d78989bmr8091369iol.2.1711487224561;
        Tue, 26 Mar 2024 14:07:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a029508000000b00476e3cabd48sm1081667jah.69.2024.03.26.14.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:07:04 -0700 (PDT)
Message-ID: <984f9c34-7117-466b-afde-228f4a2d8522@linuxfoundation.org>
Date: Tue, 26 Mar 2024 15:07:04 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] selftests: dmabuf-heap: add config file for the
 test
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "T.J. Mercier" <tjmercier@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240305060848.2478806-1-usama.anjum@collabora.com>
 <20240305060848.2478806-2-usama.anjum@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240305060848.2478806-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 23:08, Muhammad Usama Anjum wrote:
> The config fragment enlists all the config options needed for the test.
> This config is merged into the kernel's config on which this test is
> run.
> 
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Add reviewed-by tag
> ---
>   tools/testing/selftests/dmabuf-heaps/config | 4 ++++
>   1 file changed, 4 insertions(+)
>   create mode 100644 tools/testing/selftests/dmabuf-heaps/config
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/config b/tools/testing/selftests/dmabuf-heaps/config
> new file mode 100644
> index 0000000000000..34bd294836df0
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/config
> @@ -0,0 +1,4 @@
> +CONFIG_DMABUF_HEAPS=y
> +CONFIG_DMABUF_HEAPS_SYSTEM=y
> +CONFIG_DRM_VGEM=y
> +

I am applying this one linux-kselftest fixes for next rc.

thanks,
-- Shuah


