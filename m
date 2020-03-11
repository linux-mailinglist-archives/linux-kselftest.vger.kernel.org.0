Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE831825E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 00:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbgCKXb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 19:31:59 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36904 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCKXb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 19:31:59 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so3748067ilc.4
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 16:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tWMg+vrny6yAnLZ7P1+Uq3GSafHzz2ZiJHHvFx+tZ+Q=;
        b=VrP/U/elKH+pog6YRt0R7QB8ZGkgty6E35ojdAtd5sL2GKz1jEg4osj8N6DyDrDTDA
         yhzO33zMD9xi3xkYRBLOyYTpGe9X9BroyoGSgiwHdiFEDKOdbAGPv5xeJBo83VP4fpjP
         Bh+gNtxZNR1ji390quo6DWINdj8nVunK0fGGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tWMg+vrny6yAnLZ7P1+Uq3GSafHzz2ZiJHHvFx+tZ+Q=;
        b=WgX3weY13fYq1Pho/mXN4w5gCAWZ4Wp8Ynz9VXMU4TRwhxCLmC+dpZkuwKVt+x13xD
         y9oFmWlBP3fP6vuPyaRD+rX/qCEjAIEJ20c1h6o6k6NwEDdlq0wSOYPwl320/mxQQRM2
         2yUZT+qPK2PLH1dArGIh/RuwiXDyF5qbcNYUpH3DU4s8PzVyokJJ+V6wqXgFjCy6mnla
         NvEzbrPuTEGUxwKDO2tQuQHaDnICguerVxJg2cGMYYpp7sB2xZUl+6bCFoQcFxOqazjq
         +/uXHdM3w3YdrrIMU2einazTksa1nsRJrHTB0+WpDB/b95ZgEROds4i8wRWbXBjFvEf/
         k7sQ==
X-Gm-Message-State: ANhLgQ3BCxieVvzoFwhGB9Fpi8Q8JfBRNT6GYumpVngFju7o6/EyS9l9
        bw9gjrvXZR0KNw0EUqa63tgu9rMjz4I=
X-Google-Smtp-Source: ADFU+vtFXxSt5AFuuZzVRZiUmKdtjk4VJ4VPJuuo7GpY1CyX4omGF7b4hkWMjEmRoqTiTD61+FeMeA==
X-Received: by 2002:a92:88d0:: with SMTP id m77mr5234082ilh.282.1583969518243;
        Wed, 11 Mar 2020 16:31:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b5sm2334097iln.64.2020.03.11.16.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 16:31:57 -0700 (PDT)
Subject: Re: [PATCH 1/4] selftests: Fix kselftest O=objdir build from
 cluttering top level objdir
To:     Kevin Hilman <khilman@baylibre.com>, shuah@kernel.org
Cc:     mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
 <58d954867391c90fe0792d87e09a82bda26ba4fc.1583358715.git.skhan@linuxfoundation.org>
 <7hwo7qijn0.fsf@baylibre.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ceb910b1-2ab7-b27f-7e53-c445d96cdeb1@linuxfoundation.org>
Date:   Wed, 11 Mar 2020 17:31:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7hwo7qijn0.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/11/20 4:58 PM, Kevin Hilman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> 
>> make kselftest-all O=objdir builds create generated objects in objdir.
>> This clutters the top level directory with kselftest objects. Fix it
>> to create sub-directory under objdir for kselftest objects.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Only somewhat related to this patch, another problem that wasn't in your
> doci is that the current O= support doesn't support relative paths.
> 

Yes I am aware of it and it is in the document as something that will
be addressed later.

"Note: Relative paths don’t work - supporting relative paths breaks 
work-flows e.g:
powerpc. Explore fix. Compile work-flows. Not planning to support at the 
moment."

> For example, using O=/tmp/build-arm64 works, but O=build-arm64 doesn't.
> Try this:
> 
> $ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 defconfig
> $ make ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- O=build-arm64 kselftest-all
> make[1]: Entering directory '/work/kernel/linux/build-arm64'
> make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
> 	ARCH=arm64 -C ../../.. headers_install
> make[4]: ../scripts/Makefile.build: No such file or directory
> make[4]: *** No rule to make target '../scripts/Makefile.build'.  Stop.
> Makefile:500: recipe for target 'scripts_basic' failed
> make[3]: *** [scripts_basic] Error 2
> Makefile:151: recipe for target 'khdr' failed
> make[2]: *** [khdr] Error 2
> /work/kernel/linux/Makefile:1220: recipe for target 'kselftest-all' failed
> make[1]: *** [kselftest-all] Error 2
> make[1]: Leaving directory '/work/kernel/linux/build-arm64'
> Makefile:179: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> 

I am looking to address build and install issues first.

thanks,
-- Shuah
