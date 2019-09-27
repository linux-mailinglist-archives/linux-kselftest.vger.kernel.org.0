Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D566C0BE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 21:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfI0TD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 15:03:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40880 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfI0TD0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 15:03:26 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so19014777iof.7
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E+qSxd+B5mAgasMeWMwc/UaJE1Xo8BpaT5oY9Q4d4wI=;
        b=M8LKNRgSLYPUMGMl7I2w8aeFVONEoHT740JVrcttiLb0emgEnbPRGT4xrNWwgYTm37
         OYNW6NeTPL8JAoxJiQp3ZD+GURM321crEPdivjuooi6+G0LevLZMWHea0ZcquoFLMi6X
         7mQnLMIvY0JkTKn2G61mO5yjE9LrSYKzP5TsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E+qSxd+B5mAgasMeWMwc/UaJE1Xo8BpaT5oY9Q4d4wI=;
        b=Sc8ISLZYYBXUBtuCG7iC64cac+jgOTw2bMfH6hXMiAYqv2/FtcZRHDHTAbtIY+uzLZ
         vqy85cBMd0u+rqe3efdiFuAs28SYqQ3g+F+8GSZoQQZINnuvgwtOBwcsqoCehDDO8wDy
         nTLHTZxCjQ+JC9qeLCvezOh94hBIYRsGZIe+OZXRkC8yTnyVpHq5vhuLeQQeGhH7KQ/e
         fXlfDHo3hwlcnG9PAWVrB3EIF3OoC+9WRwBBmLFxjO4sFxFMaNGfXw0i6jk1QBaFcpW9
         Ru6ciobXy2VtSTPUOMtNHvbVzJgO1DNXtuce6k6pAhSB6ICTZkWeeTMvNJIVArJM2CEV
         ST9w==
X-Gm-Message-State: APjAAAWQ72CTuFkVBepN8IW3JfGJlrMR9KbgsqRsVDSXTZ2cpoGc4bFo
        R9kPc0cHq11enY4ygs3BMyaMmg==
X-Google-Smtp-Source: APXvYqyHENgSj2WMDvi6eFaafpsFE/M30Ldy7dsDBryeYnpc0Mkk2ZpDpcDkPaiCljRGm46/wCsq+A==
X-Received: by 2002:a5d:89da:: with SMTP id a26mr9289421iot.61.1569611005604;
        Fri, 27 Sep 2019 12:03:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t17sm2519972ioc.18.2019.09.27.12.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 12:03:24 -0700 (PDT)
Subject: Re: [PATCH] tools: bpf: Use !building_out_of_srctree to determine
 srctree
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190927011344.4695-1-skhan@linuxfoundation.org>
 <CAPhsuW5EncjNRGjt7F_BN2bNhRkf=uXVeDe6NCbJe=K2J+hdyA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5ec40572-5df9-0e5b-5a85-eb53be48b87d@linuxfoundation.org>
Date:   Fri, 27 Sep 2019 13:03:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5EncjNRGjt7F_BN2bNhRkf=uXVeDe6NCbJe=K2J+hdyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/27/19 12:44 PM, Song Liu wrote:
> On Thu, Sep 26, 2019 at 6:14 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> make TARGETS=bpf kselftest fails with:
>>
>> Makefile:127: tools/build/Makefile.include: No such file or directory
>>
>> When the bpf tool make is invoked from tools Makefile, srctree is
>> cleared and the current logic check for srctree equals to empty
>> string to determine srctree location from CURDIR.
>>
>> When the build in invoked from selftests/bpf Makefile, the srctree
>> is set to "." and the same logic used for srctree equals to empty is
>> needed to determine srctree.
>>
>> Check building_out_of_srctree undefined as the condition for both
>> cases to fix "make TARGETS=bpf kselftest" build failure.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> The fix looks reasonable. Thanks!
> 
> However, I am still seeing some failure:
> 
> make TARGETS=bpf kselftest
> [...]
> test_verifier.c
> /data/users/songliubraving/kernel/linux-git/tools/testing/selftests/bpf/test_stub.o
> /data/users/songliubraving/kernel/linux-git/tools/testing/selftests/bpf/libbpf.a
> -lcap -lelf -lrt -lpthread -o
> /data/users/songliubraving/kernel/linux-git/tools/testing/selftests/bpf/test_verifier
> make[3]: test_verifier.c: Command not found
> 
> Is this just a problem with my setup?
> 

You are running into the second bpf failure because of the dependency
on the latest llvm. This is known issue with bpf test and it doesn't
compile on 5.4 and maybe even 5.3

You have upgrade to the bleeding edge llvm.

thanks,
-- Shuah

