Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77EABCB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405793AbfIFPjy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 11:39:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46760 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405791AbfIFPjy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 11:39:54 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so13625741iog.13
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2019 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8RHJ4leAR/wkyDpJhQ/x19o61jLbTWUL3D7mVMACPs=;
        b=OcYaycXHpnVraoNGvlISPzzMWYxqcvr/1roS3d7O7HbVcwJ4iowOYMyvUfToJ7ftkt
         UeLmnyQx8D4yEcbwd+FXqshQVOimZBvrXLYYQdhjqlRsft6MHtT2jJ+DLV1J6MU+XDW9
         6qljA7rqLMLqOQNPC2RsUcszjHR6PJiY3QkHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8RHJ4leAR/wkyDpJhQ/x19o61jLbTWUL3D7mVMACPs=;
        b=l2uYGz+4RfeiFn7Xgl9C6RzXhd0k502hn7k01HvJ8ixYi5ldh+Q99/eq0PDPa0XAiu
         o3SFXQvIb/sY6S5Dd/Zy/O8b59sgRGop3Avx7P0+FRf4kMFTSM97o+sMy5NLMdgeJ5p6
         7gXVlEsy3za8j5B/BIo5cHVkmDGCtMJBjb7sfFhYfr/kCMNs58Zhb1tI8Y/53+Gqpuaj
         /8j7WiUBp3X+emI0EReITBjV/2vAHrwgJFvskqFfmFGIaHN2uwUpQhy/ZIzCQgg+P8iW
         c0ACKFrcki7zqGTYefkQaYDMwByAq3ts27n8+701beuHQDIF5RoVmZdI6g15IOdb2OMH
         MeqQ==
X-Gm-Message-State: APjAAAWHK68mSPHzsQy79aO6WK5qJSqMbV4cM66OX6vXTrh3eS0XnT+u
        aGUtxTOQR7TtceLS00h1had9yA==
X-Google-Smtp-Source: APXvYqyx6+qiaYOFFceX/tUN9jPoZgdAJn3aAZscMtuYCStfnSJ0LEi+f7gjd/wREJQSPji6H8OkEA==
X-Received: by 2002:a6b:1542:: with SMTP id 63mr8416332iov.35.1567784393342;
        Fri, 06 Sep 2019 08:39:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l186sm11065424ioa.54.2019.09.06.08.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:39:52 -0700 (PDT)
Subject: Re: [PATCH] kunit: add PRINTK dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20190906152800.1662489-1-arnd@arndb.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
Date:   Fri, 6 Sep 2019 09:39:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906152800.1662489-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/6/19 9:27 AM, Arnd Bergmann wrote:
> The vprintk_emit() function is not available when CONFIG_PRINTK
> is disabled:
> 
> kunit/test.c:22:9: error: implicit declaration of function 'vprintk_emit' [-Werror,-Wimplicit-function-declaration]
> 
> I suppose without printk(), there is not much use in kunit
> either, so add a Kconfig depenedency here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   kunit/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kunit/Kconfig b/kunit/Kconfig
> index 8541ef95b65a..e80d8af00454 100644
> --- a/kunit/Kconfig
> +++ b/kunit/Kconfig
> @@ -6,6 +6,7 @@ menu "KUnit support"
>   
>   config KUNIT
>   	bool "Enable support for unit tests (KUnit)"
> +	depends on PRINTK
>   	help
>   	  Enables support for kernel unit tests (KUnit), a lightweight unit
>   	  testing and mocking framework for the Linux kernel. These tests are
> 

Hi Arnd,

This is found and fixed already. I am just about to apply Berndan's
patch that fixes this dependency. All of this vprintk_emit() stuff
is redone.

thanks,
-- Shuah
