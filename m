Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D48B96F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2019 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406229AbfITSGk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Sep 2019 14:06:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41214 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389658AbfITSGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Sep 2019 14:06:39 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so18131364ioh.8
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2019 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJi+jkD9qkHLIeHwUoAJGIQIqvA5hcES7DlWqDuq6Uo=;
        b=M7KNKfCYlTuZYd5fJJ2JsOl9hW194OD55o4viiTNyKlcrYO0rDmZoxtNZd4ZB+KS2y
         ralsCLv78mEryfEF7fz/DcUaj+6ezd0i2fS+q4+ysIRasL9xeEMWMJveP4Ej8BML7QO0
         LLV5JfMtSFzBnFdKfTUMeIAxG/AIpg6jr2Kqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJi+jkD9qkHLIeHwUoAJGIQIqvA5hcES7DlWqDuq6Uo=;
        b=sf0m+j7HsOSGei07cXANk3cVxKWBwhwDPv53PkcY7K/Dvz1e9dSxhtxmTTv8D9e1kr
         /jdDxalDOrPjnhfJNOtV19/oOknWJGYEIVVuZZg/VahRh+VHknTZ0YT0iGTPO7jSh529
         lGkN4SXjE6P7tGIdcQvXUOkShFa3nsWeD0Lq0dVMJ27oR+MyFJEmL6X7ZpTsh7WtuSa4
         dXAxx0tyen3mmlFAEOlhHnK39jrZk9udMLApZ0WZlWtA6GmYRFxgWKfRGwOZ3cH+Ycp9
         xCu0k0DU7j4hoQcGFvkMl1Cz4V89JbKEbt96oY1PliE9Cxr7As2kCH/555iVTP7PJ8/m
         DW0g==
X-Gm-Message-State: APjAAAXpzAkPGBGcDh9eQyX+eSUEU18kaXghRJ8/JZcFOneSWc8WkWnT
        HCt9XBEnAB4ROW9KPcRz2i2S9w==
X-Google-Smtp-Source: APXvYqzcxmufuhpTV8cPIXs3gqKlIndr6SLD+RwC0Nj0QKygB/UhV/bxz2HEf/+9nCsKFuqws5/ZmQ==
X-Received: by 2002:a6b:7109:: with SMTP id q9mr15165154iog.229.1569002798715;
        Fri, 20 Sep 2019 11:06:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a26sm2573274iot.46.2019.09.20.11.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:06:38 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2474b796-2e38-2e27-06db-4d917e822a26@linuxfoundation.org>
Date:   Fri, 20 Sep 2019 12:06:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/20/19 10:51 AM, Linus Torvalds wrote:
> On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>>
>> Sorry about that. I am surprised that none of the other reviewers
>> brought this up.
> 
> I think I'm "special".
> 
> There was some other similar change a few years ago, which I
> absolutely hated because of how it broke autocomplete for me. Very few
> other people seemed to react to it.
> 
> Part of it may be that the kernel is almost the _only_ project I work
> with, so unlike a lot of other developers, I end up having muscle
> memory for kernel-specific issues.
> 
> Auto-completion was also one of the (many) reasons why I hated CVS -
> having that annoying "CVS" directory there just always annoyed me.
> There's a reason why git uses a dot-file.
> 
> So I just have issues that perhaps other people don't react to as
> much. And aggressive tab-completion happens to be a thing for me.
> 

Thanks for explaining. Brendan and I will get this sorted out.

Looks like my previous response didn't make it to the kselftest
and kernel lists.

thanks,
-- Shuah

