Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6ECDA222
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 01:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406711AbfJPX0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 19:26:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34577 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390440AbfJPX0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 19:26:32 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so698095ion.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALqoFhbrnK92+EsGdW3MzBdtB/MfZ4NI71UqQ56Wjro=;
        b=QvcAupNYUIeNyIZotmMk1JsF16omX7CtqAazx8G7WPLjCL8VxpyM3wM98mQ065R90J
         2x+RzpwBohCAE8N16Di7Tj0yA7S/NKBb864ssgBU2Mvk0B9W4cy9BlcVPP39y03EvCWi
         cBhb45MYsF/9UVGqODW1FjAz5kgzCYW36Bgzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALqoFhbrnK92+EsGdW3MzBdtB/MfZ4NI71UqQ56Wjro=;
        b=rLbh/R3xmOzP5vhWkQQdBReyCxVWVjNA/OpwW5h+viG9T51X3jdeg5Stm1JPIbtVO+
         aViT7oA/pR/8mtOhW//c+t/ba2bGAIGAZbwgHz05FHaQZIFbNJHRi7hUWsm81MzbiZ3B
         xPghZBfmBJW9ZIWDbZsFckezEb2/cDVUdaxhSWcRCnNdvPIfoF9xXuUeGa5jwqW6M1dw
         WNqilsOA35vsOYIvfJvnTyG1DPPd8yjKKLc4/lRbRlXPxj6FgTXw8PK8KM19g/14tnKg
         6pFjiV+7920QkluixMWWoTAQdpkPgytqitc2I60ExCdSZGEtXgEaJNsm0TUHCFzoEYIv
         GbTw==
X-Gm-Message-State: APjAAAWWrej9qILJViU18mqWJGEhZxLnoVu+gZps+abhL3GPE0H3f0WZ
        yYFvOCnlOXD/XChD3sWKLLyE0g==
X-Google-Smtp-Source: APXvYqzoR8qettcJiq77CKQss21JvYq+xCoAaPUBywv0gL5OaGCdzz6oWHFSnuihBBPtDUGn/r3dMg==
X-Received: by 2002:a5e:8f04:: with SMTP id c4mr237800iok.57.1571268391243;
        Wed, 16 Oct 2019 16:26:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t8sm135004ild.7.2019.10.16.16.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 16:26:30 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Brendan Higgins <brendanhiggins@google.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Iurii Zaikin <yzaikin@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
Date:   Wed, 16 Oct 2019 17:26:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/19 4:18 PM, Brendan Higgins wrote:
> On Fri, Oct 11, 2019 at 6:19 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>
>> On Fri, Oct 11, 2019 at 03:05:43AM -0700, Brendan Higgins wrote:
>>> That's an interesting point. Should we try to establish a pattern for
>>> how tests should be configured? My *very long term* goal is to
>>> eventually have tests able to be built and run without any kind of
>>> kernel of any kind, but I don't think that having a single config for
>>> all tests in a subsystem gets in the way of that, so I don't think I
>>> have a strong preference in terms of what I want to do.
>>>
>>> Nevertheless, I think establishing patterns is good. Do we want to try
>>> to follow Ted's preference as a general rule from now on?
>>
>> As I suggested on another thread (started on kunit-dev, but Brendan
>> has cc'ed in linux-kselftest), I think it might really work well if
> 
> For reference, that thread can be found here:
> https://lore.kernel.org/linux-kselftest/CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com/
> 
>> "make kunit" runs all of the kunit tests automatically.  As we add
>> more kunit tests, finding all of the CONFIG options so they can be
>> added to the kunitconfig file is going to be hard, so kunit.py really
>> needs an --allconfig which does this automatically.
>>
>> Along these lines, perhaps we should state that as a general rule the
>> CONFIG option for Kunit tests should only depend on KUINIT, and use
>> select to enable other dependencies.  i.e., for the ext4 kunit tests,
> 
> I support this. Although I think that we will eventually find
> ourselves in a position where it is not possible to satisfy all
> dependencies for all KUnit tests, this may get us far enough along
> that the problem may be easier, or may work well enough for a long
> time. It's hard to say. In anycase, I think it makes sense for a unit
> test config to select its dependencies. I also think it makes sense to
> make each subsystem have a master config for all KUnit tests.
> 
>> it should look like this:
>>
>> config EXT4_KUNIT_TESTS
>>          bool "KUnit test for ext4 inode"
>>          select EXT4_FS
>>          depends on KUNIT
>> ...
>>
>> In the current patch, we use "depends on EXT4_FS", which meant that
>> when I first added "CONFIG_EXT4_KUNIT_TESTS=y" to the kunitconfig
>> file, I got the following confusing error message:
>>
>> % ./tools/testing/kunit/kunit.py  run
>> Regenerating .config ...
>> ERROR:root:Provided Kconfig is not contained in validated .config!
>>
>> Using "select EXT4_FS" makes it much easier to enable the ext4 kunit
>> tests in kunitconfig.  At the moment requiring that we two lines to
>> kunitconfig to enable ext4 isn't _that_ bad:
>>
>> CONFIG_EXT4_FS=y
>> CONFIG_EXT4_KUNIT_TESTS=y
>>
>> but over time, if many subsystems start adding unit tests, the
>> overhead of managing the kunitconfig file is going to get unwieldy.
> 
> Agreed.
> 
>> Hence my suggestion that we just make all Kunit CONFIG options depend
>> only on CONFIG_KUNIT.
> 

Sounds good to me. I am a bit behind in reviews. I will review v5.

> That makes sense for now. I think we will eventually reach a point
> where that may not be enough or that we may have KUnit configs which
> are mutually exclusive; nevertheless, I imagine that this may be a
> good short term solution for a decent amount of time.
> 
> Shuah suggested an alternative in the form of config fragments. I
> think Ted's solution is going to be easier to maintain in the short
> term. Any other thoughts?
> 

I don't recall commenting on config fragments per say. I think I was
asking if we can make the test data dynamic as opposed to static.

Lurii said it might be difficult to do it that way since we are doing
this at boot time + we are testing extfs. If not for this test, for
others, it would good to explore option to make test data dynamic,
so it would be easier to use custom test data.

I don't really buy the argument that unit tests should be deterministic
Possibly, but I would opt for having the ability to feed test data.

thanks,
-- Shuah
