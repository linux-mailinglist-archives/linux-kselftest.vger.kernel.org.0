Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC9689F2F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 17:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBCQ0n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 11:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjBCQ0l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 11:26:41 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71632A6C1C
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 08:26:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id k12so2264696ilv.10
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzLSTilkTqHv5zqJq4XrgBlNDh4B17SJN2rgulEb5xk=;
        b=d7kPQhIauFu7vhvmYuzzHJii3z93jbo8da5vvEAJvij6FF2hHODbovtTwaR//XIqB6
         IDIvXVPISW0bwGn6f/uwmd8dHTwDSn2kOobXOqmYAgqMSghpBvDM48pRn5IzbuO+8qvj
         YLDPv1eR3uAXHCfCs/3lhe8N2TuQC4ReiAR7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzLSTilkTqHv5zqJq4XrgBlNDh4B17SJN2rgulEb5xk=;
        b=tMMUC0z0DxEKuFUJipn2yVW2ty+t6qBGGNNSmn/aKHeZrP6fOGHH7RF75wRlwV0ZF4
         I6xdxmHJiXanfITsKqPtGhDhNDYrMLPv6BLLHzoTerp8f2WatkZjT+OxS9mkhyrkcrlw
         SzS4KUov/kDLgtQynBLoVNkh0C0IknHQNeAzcC5DlvdohIaXK0na5FaZUZ6ptP0LEr4h
         Y1HVjqfbGqboPNWviMvbyCASp6NwOmVOCYpOdlZXXcYJGaRbd7vvJy5AP54QzL+dBTTm
         mHfD0zOpSCWOwMBygrWjz73R0slFB5J+xmpk2as8ai3+4b36nnzi8Gq8SX32YZl3j0Qr
         ZB3g==
X-Gm-Message-State: AO0yUKW7L35ZZiZl7PHiJuhTB0thWWbbtLbZpfjGuR9hoESuTw310BSU
        clcu91jgGh+/+VEre45hs+v1XA==
X-Google-Smtp-Source: AK7set+SWBkzsLF7SwKMgA+I+wyLq5+0NPN1Gmn1itfKTHMLjlocRZMy3fHFcQDgtVDC6mqhqZ7xwg==
X-Received: by 2002:a05:6e02:1ba7:b0:310:b84b:c893 with SMTP id n7-20020a056e021ba700b00310b84bc893mr7862837ili.1.1675441597740;
        Fri, 03 Feb 2023 08:26:37 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q21-20020a056638345500b003af38f526aesm943667jav.81.2023.02.03.08.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 08:26:37 -0800 (PST)
Message-ID: <ebaaa261-84db-c118-2c2b-d8a31c90a1aa@linuxfoundation.org>
Date:   Fri, 3 Feb 2023 09:26:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: find echo binary to use -ne options
Content-Language: en-US
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Guillaume Tucker <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230203152603.11450-1-guillaume.tucker@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230203152603.11450-1-guillaume.tucker@collabora.com>
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

On 2/3/23 08:26, Guillaume Tucker wrote:
> Find the actual echo binary using $(which echo) and use it for
> formatted output with -ne.  On some systems, the default echo command
> doesn't handle the -e option and the output looks like this (arm64
> build):
> 
> -ne Emit Tests for alsa
> 
> -ne Emit Tests for amd-pstate
> 
> -ne Emit Tests for arm64
> 
> This is for example the case with the KernelCI Docker images
> e.g. kernelci/gcc-10:x86-kselftest-kernelci.  With the actual echo
> binary (e.g. in /bin/echo), the output is formatted as expected (x86
> build this time):
> 
> Emit Tests for alsa
> Emit Tests for amd-pstate
> Skipping non-existent dir: arm64
> 
> Only the install target is using "echo -ne" so keep the $ECHO variable
> local to it.
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---

Thank you - will appear shortly in linuxk-selftest next.

thanks,
-- Shuah

