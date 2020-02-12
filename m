Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F13715AAC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 15:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBLOJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 09:09:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37049 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgBLOJp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 09:09:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id a6so2627357wme.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2020 06:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DZYSr9Lthmw0rEdKlAUNqWqVy2KZbgG19jAuOZOJ4u8=;
        b=Ac8PH9gvOLzanxQ9KYMov+xhlfa8TnIZ+Xf/tJUXNpXqBpkBBJl/ZdSH3o9EqMCd8P
         6bbIkGSqk2wOXavdvurN1a4f3Dp8r4HC3siE9nrJNq4gx+Vl8QaXgmgU+LSIcn0NtuKQ
         B/KS3jjXJLTr0P5mvq2OKJmCMmrKC/gV1g+xRQvMC17WI4kSzRwnHLuupgf0vI4S5x8I
         +sXJFBxZMUN3jQmmYWPQWwxLxc2l/T9q2nuxUXm3pC8BNBen4JSSLF2gI70E52NO1Naa
         TmEECb+uH6zfKXDk11hUsEJNEYLdOd+giVI8s5lQ9ndMEGQ7KhRJxtIk0m7Lt79p+kq2
         10Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZYSr9Lthmw0rEdKlAUNqWqVy2KZbgG19jAuOZOJ4u8=;
        b=ew8eQ/J6MJt1tacRenJoIiBEu1kP9A5MQoS+hco2F5TOYotpSA2G3JNB6aFBkt3HB5
         Q8M+0eYO2ooowC9AATM/5yWyv0k7K/zOBf6fX5oZukyfcScsWH1bJIdpx2xWqKZxBnVL
         9axA6ogCC12sst7TsBPhFM2KW15fHJUwoIpX6YGRl076nfXtFHOrCJBEqPRQr+W1D4Dw
         aSLDKyYuB88OHmVahc7ryWy+g+92k7rO4WpWmXCuIuqP5TXCIompEPFv0IGhoLEqPC5l
         CCZ6up4GpJxUrccdH6umSZTFYynyJ4SO6F3cGe3Vvr2hxK5KRBtNC6YTvF2HOjyJnLr+
         JPIA==
X-Gm-Message-State: APjAAAUcaxMQJIC6SSutqoAXHyLOcsISyM+jhGauLYYdfik7FKAL0ZwA
        N3UQWQNW89hucG4AvUImbcVR4Q==
X-Google-Smtp-Source: APXvYqzsyWi/3pMvejlnOOdjV8T8KAb10ZXcoRdiHPdLErpXYSk6E13Et4wSUp809q63cBGH7G3Ekw==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr13269388wmo.147.1581516581552;
        Wed, 12 Feb 2020 06:09:41 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b10sm721174wrt.90.2020.02.12.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 06:09:40 -0800 (PST)
Subject: Re: Linux 5.6-rc1 kselftest build failures
To:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Andrei Vagin <avagin@gmail.com>
Message-ID: <c31e468a-3afe-f9b6-b006-c3bc3f35f1cc@arista.com>
Date:   Wed, 12 Feb 2020 14:09:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 2/12/20 12:35 AM, shuah wrote:
> The following tests fail to build on x86_64
[..]
> timerns:
> 
> tools/testing/selftests/timens'
> gcc -Wall -Werror -pthread  -lrt -ldl  timens.c  -o
> tools/testing/selftests/timens/timens
> /usr/bin/ld: /tmp/ccGy5CST.o: in function `check_config_posix_timers':
> timens.c:(.text+0x65a): undefined reference to `timer_create'
> collect2: error: ld returned 1 exit status

I've just send a patch to fix it:
https://lkml.kernel.org/r/20200212140040.126747-1-dima@arista.com

Could you try it?

Also, it seems that the same thing affects futex/rtc/tcp_mmap/tcp_inq tests?

While looking into this, I see there are new auto-generated lkmdtm &&
pidfd tests, is it worth to add them to .gitignore?

Thanks,
          Dmitry
