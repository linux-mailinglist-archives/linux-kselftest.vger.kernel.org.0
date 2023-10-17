Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD017CC7D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjJQPq6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjJQPqu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 11:46:50 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19DC13D
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 08:46:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7a66555061eso4346839f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697557608; x=1698162408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qifLUWrkmypuE1HSNNdyFzpD4fELvix1NB9KRDxZL6k=;
        b=K2yfEisqlKZqRVCJlCswRZR7ZE34IYOmxwd2QVY71uccQEJomx59oVxDDvMC57KEQb
         aN2noaz0bVQEOiLrXr2PAbCwSlqoPOpu7jxnXmuNEQfbSZ1lJf+sh1A7B7vMrM6TT0iN
         voMHn4nQw5YpOrun58BVrnQ24SmYg3aymmboE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557608; x=1698162408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qifLUWrkmypuE1HSNNdyFzpD4fELvix1NB9KRDxZL6k=;
        b=JWa36lDNqTh9F58P4B+daqiprWNQPcR0KMS3jhdqJSrM7g2HKqXxaF0/mVti6AqjFv
         NQNseJqL5dseiFpsUU28YuJepVNCirzgJg+mX7lXiKG20yRCpJOjbKKoKIsUkOBBDvvj
         iHLVy+G8/j6E6ARWZhN269DFtpO074feK7YJEvRSIEVD7ORvi2aWtIxaY6sgU5amUEp2
         OadzpvBhVkLFWTRy0nNTx/vDG1A3k7KCL7p8IiDtL8G+9p61xucepAgar311kF/mWoyt
         UKmB0EzDnwalSs1jmeHJ/hms0LbmjDFaaBgcFskdlcZqwwK0byHe4E+NindoMiyHDmmL
         KSiQ==
X-Gm-Message-State: AOJu0YwM8kgeDHlg6PRAt/6wWtZrQJ9q7i0P5/yXTVIRJB8Hnk1jBwJJ
        qC3vLfhrbg2kf3WbklNlkZrBqzh0KRp7D/sOcjY=
X-Google-Smtp-Source: AGHT+IHgKOfjvzKSAB0scid4I1mm3aq4oFWhBwPqa9mWSsIQTAzX4p9v9j6dSadUHlBM2ou8xWXtnw==
X-Received: by 2002:a05:6602:1513:b0:79f:a8c2:290d with SMTP id g19-20020a056602151300b0079fa8c2290dmr3348129iow.0.1697557608211;
        Tue, 17 Oct 2023 08:46:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x22-20020a056638249600b0042acf389acesm556725jat.71.2023.10.17.08.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:46:47 -0700 (PDT)
Message-ID: <2a96e3a8-48a5-46ae-9a0c-b5f2def0a257@linuxfoundation.org>
Date:   Tue, 17 Oct 2023 09:46:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/efivarfs: create-read: fix a resource leak
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231017023335.7874-1-zhujun2@cmss.chinamobile.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231017023335.7874-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/23 20:33, zhujun2 wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur
> 

Did you find this by code reading or by any other means. Please
add how you found the problem to the change log.

> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/efivarfs/create-read.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/efivarfs/create-read.c b/tools/testing/selftests/efivarfs/create-read.c
> index 9674a1939..6812104a5 100644
> --- a/tools/testing/selftests/efivarfs/create-read.c
> +++ b/tools/testing/selftests/efivarfs/create-read.c
> @@ -32,8 +32,11 @@ int main(int argc, char **argv)
>   	rc = read(fd, buf, sizeof(buf));
>   	if (rc != 0) {
>   		fprintf(stderr, "Reading a new var should return EOF\n");
> +		close(fd);
>   		return EXIT_FAILURE;
>   	}
>   
> +	close(fd);
> +

No need for this extra line here.

>   	return EXIT_SUCCESS;
>   }

thanks,
-- Shuah
