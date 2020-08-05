Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD523CF43
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 21:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHETSJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgHETPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 15:15:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AFC061575
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Aug 2020 12:15:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e6so20379720oii.4
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Aug 2020 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYEN2cvet5zB5B5eyNC+shZAVcvkiH+f+FbncW7ectU=;
        b=Ena+3Y8jxN4bGxdwm2AgkNEPvhg6MLLZCSTy7U08iocYStSazDPf+mGA4GOi9UBExJ
         yyTAwbejrI9oilVci6jN+uTDCXPdwtYjC29V613/TBch+v6qBURzpNLeeokDLwtyHbJg
         bUATeRa0Te0lbhpCWgdx5vOURqCdNxw8cjPj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYEN2cvet5zB5B5eyNC+shZAVcvkiH+f+FbncW7ectU=;
        b=nwAqOFofVBpoHYmIFLwF7yYkk3XnoD7m+5LtR7kbPmqx7fjcuAdjt3H5Ah0lUVecuu
         uYk4XUQelfoOU+ESO3c3H2GNZU/aFZ9nGWT5ocxaqh8BjTO2E7TPSWd0YK1x1k/VDJXs
         RT1A/UGXPthStH9HvqVgH5Kl6JjX8LQdYWKe3btli6NmrH/Zvmpw07rZoTS/fCp3nSEK
         8DScF+ur+DPI5EgxM/bJbltjeOFnBpKmXuL/joc6vsBhRMEGscl1/OqLlCIKGqOwqk9r
         CjK6UTFi3JdS0ZgXTx/PhLRgL7L6I9eTLhdJ6+brh+aYwLTdTcndqdDqYxFrKuqM8vqC
         77vw==
X-Gm-Message-State: AOAM533viKULsbZVTFDDhk48B1h/exU5Bwd0UWsHhmvTwb5JI7cXcQ35
        lEBei21Tvw+udcU0ejaYFYSe4w==
X-Google-Smtp-Source: ABdhPJw4kgHT2DVcqZYav5EpT9M+m+g1ZhwCut2UPLjmjltFinAwFibAgUqzfTyBmsEbXr2RgRzHYg==
X-Received: by 2002:aca:b30b:: with SMTP id c11mr2101630oif.48.1596654945457;
        Wed, 05 Aug 2020 12:15:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o22sm539984ota.49.2020.08.05.12.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:15:44 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <0e3a9c1f-7ac6-33e2-ed11-5a56659fc5f7@linuxfoundation.org>
 <CAHk-=wi4iDwuazgXQ-1yvM_JMTBepi9rc-zfSMeyjfDgSS2fgA@mail.gmail.com>
 <8d894cb3-83ac-66bc-48ec-dc273d1afcbe@linuxfoundation.org>
 <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3c439640-111e-7399-5839-a5cba4a98a54@linuxfoundation.org>
Date:   Wed, 5 Aug 2020 13:15:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiKe_rBFthfttj1fM3cwqaArSUN0Dz1KhARdMNo1a2F=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/5/20 11:32 AM, Linus Torvalds wrote:
> On Wed, Aug 5, 2020 at 7:13 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Please pull the following Kselftest update for Linux 5.9-rc1.
> 
> Ok, it worked fine this time, although now you lost the note about the
> conflict ;)
> 

Sorry about that. I should have included that as well.

> I took the version from the seccomp tree that seemed to be the
> slightly cleaned-up one.
> 

Yes. The version from seccomp tree is the one to pick up. Thanks
for working through this.

thanks,
-- Shuah
