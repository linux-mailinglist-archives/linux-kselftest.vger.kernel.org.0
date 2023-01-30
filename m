Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F75668170C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 17:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjA3Q5y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 11:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjA3Q5x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 11:57:53 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560FF2680
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:57:51 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w13so1284340ilv.3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9FOzbQzT+JXPXKeHlfH1z+hgpT+neOh4BngGa9Z1Bc=;
        b=TttKP/i7vtuAZ8pKaTh+sofK3a27HCNy4KufY3/BNMoRANmsIQ2572lnptPciHWZZf
         P5qlDlXVeinJkdOmA3m9+pYT3T5947TpTwDNdY6R1P+KZFqpOs7VQyc3cgJD2rAZF46P
         0x3x8ZKF1WSpuNfLhGEiLBUU4BQA6t3Lo09ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9FOzbQzT+JXPXKeHlfH1z+hgpT+neOh4BngGa9Z1Bc=;
        b=uoXK8jEnw+Xd2YpibH5pXB2Zw7UbtqSt2pSj0icJImjE8Ig2qA7eCd1pSbNP1P3UTA
         +wQnZVLxX15RHUWPtgx/oGi6OIiVXmUqE5JRajP/PaMiJQ4wFjLL4kr2m0Ezak2wpt8+
         fuMHObo1OhB8LC+3HXzmjy1V2ql99kDxJRpdh/hzd96EixR7Bm4Hoa6uG4FxbyEfDLD+
         YMA3S4BBEIFgYp/xBTjQ6rw75B5el18rqKQmswmv/jhJvXr7I5fd4s8I65KPoYhMhunN
         ryC6l3YHqoF6N/ePlw8QRznDy4x3QZohaAdzQqzlmkWouptMOcNco3/93hDsP2kUhlPb
         /aiQ==
X-Gm-Message-State: AFqh2ko+kNybbb4uvVSl52oUcNJwSQndse5WuWgEMxfqobM5EU47KyCb
        ezixZMVKOOw8ZSQGoO8Ykov/vw==
X-Google-Smtp-Source: AMrXdXvE7lWIIbVRIP8G+LRGLb33nzB4GToWKYt9FVK249yeDSaRKLBitGXd9WC0EEGifClZ8ZeuTw==
X-Received: by 2002:a92:cda4:0:b0:30d:bf1a:b174 with SMTP id g4-20020a92cda4000000b0030dbf1ab174mr9702736ild.1.1675097870709;
        Mon, 30 Jan 2023 08:57:50 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v17-20020a92c811000000b0030258f9670bsm4203021iln.13.2023.01.30.08.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:57:50 -0800 (PST)
Message-ID: <34a11c33-5a3e-7ba9-59c5-4588033549aa@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 09:57:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 30/34] selftests: bpf docs: Use installed kernel headers
 search path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-31-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-31-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
> than using kernel headers in include/uapi from the source kernel tree
> kernel headers.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>   tools/testing/selftests/bpf/Makefile.docs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
> index eb6a4fea8c79..0a538d873def 100644
> --- a/tools/testing/selftests/bpf/Makefile.docs
> +++ b/tools/testing/selftests/bpf/Makefile.docs
> @@ -44,7 +44,7 @@ RST2MAN_DEP := $(shell command -v rst2man 2>/dev/null)
>   # $1 - target for scripts/bpf_doc.py
>   # $2 - man page section to generate the troff file
>   define DOCS_RULES =
> -$(OUTPUT)bpf-$1.rst: ../../../../include/uapi/linux/bpf.h
> +$(OUTPUT)bpf-$1.rst: $(KHDR_INCLUDES)/linux/bpf.h
>   	$$(QUIET_GEN)../../../../scripts/bpf_doc.py $1 \
>   		--filename $$< > $$@
>   

Adding bpf maintainers.

Here is my ack:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
