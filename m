Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF572BBDA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502926AbfIWVLs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 17:11:48 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:33592 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502746AbfIWVLr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 17:11:47 -0400
Received: by mail-io1-f49.google.com with SMTP id z19so14913453ior.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2019 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kb11ljOxE66EWQjXInWOAiNcDl56QbPFhGLa/O0xUL0=;
        b=V4iOb96WFXPAV2pkWfb2ad3hkRizfthkWYXB2z62ulZC9rn03K1je1XGn4rCXzjkrI
         u68PBFj9fgRKd0S9gKlX9Ja74N7eauxwdfdz4LQwHOobrBDrNn5kEhCTZx25nR1T8/Ok
         n2YmHoPmM8QglavVMehT18Ke2dCIwlBOnmgMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kb11ljOxE66EWQjXInWOAiNcDl56QbPFhGLa/O0xUL0=;
        b=ZyXcKMNU2OFxvxYbV9tpXYKnbPUqNz4xlirtgFucvYzpDcwszkll4KE2pRfs53XYtt
         7n+3NdZHqVDpjWDDR3fXJQaAGyqmWrQoM3zPVLGx88HbHOJsYcbPejbi41ZJiDYQOZZ/
         e79L4mMDiBxw+uwOaXhI8kBsJzSxqW09yrOYxF0VxFUaC1c3i+iDcOusNOQC7Vg0WmeY
         li6ECx2Jprp1fKIDEFq7PaEMH5JG5hwySi8ghe714KumOMUr0s8kjjVyd0K5zrb0RvmL
         xAs9jbzLmLVXQldM7kNcYJEQ4zlg1VGeWTGtXT0XuzutALyIi9DFXLTQjtEzY8lpIRYR
         nPRg==
X-Gm-Message-State: APjAAAVdB2YNh/IeSomu3NV/7aTqxe6WxglM2weIj7TVNXxXkbD9n4Kl
        ah6JT8TkPy11JUkJ+BPbF2jgWg==
X-Google-Smtp-Source: APXvYqwH4eH6TW7369AQ09FANNvkI1T5MLNAJhY2uMu9+B+krdUXew+s9MOPek8Bj+Imm2cL0wiWWA==
X-Received: by 2002:a5d:9814:: with SMTP id a20mr1632862iol.19.1569273105538;
        Mon, 23 Sep 2019 14:11:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a14sm13952481ioo.85.2019.09.23.14.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:11:44 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com> <20190922115247.GA2679387@kroah.com>
 <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
 <20190923194322.GA55255@gmail.com>
 <32d0e94d-bf9a-01e9-2548-1fc976c7f17b@infradead.org>
 <f4c21702-f7b5-e6f9-b31d-8fc9e4d1c67d@linuxfoundation.org>
 <20190923205325.GA121000@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <71d15ce8-5bb4-c4c7-42ab-8dc5ce45b73e@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 15:11:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923205325.GA121000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/23/19 2:53 PM, Ingo Molnar wrote:
> 
> * Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> Right. What you suggesting is very similar to and more complete than
>> what I have been thinking about and proposed at the KS kselftest track.
>>
>> i.e move tools/testing/selftests to kselftest at the root level. I like
>> your idea of moving tools/testing up to root and keep selftests under
>> it.
>>
>> If we are good with this kind of change, I would like to get this done
>> sooner than later. There is some back-porting churn to worry about.
> 
> I think the movement I suggested would be sufficient:
> 
>    tools/testing/selftests/ =>  tools/selftests/
> 
> I.e. let's not clutter up the top level directory.
> 

Yeah good point.

-- Shuah

