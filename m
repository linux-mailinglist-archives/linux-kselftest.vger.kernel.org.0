Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FCDCFFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443427AbfJRUYx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 16:24:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41299 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443422AbfJRUYq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 16:24:46 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so8921038ioj.8
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NuSCTuHLyeIME2hbrerbprSKbzeZs/hKIavOLJRoGRQ=;
        b=HtCk0A8CHBSeN/vkbSv/7Y2ykRo+7yexMnvlVxS0NDBJHW3+GiIXbExrf6RB731B6o
         a4ARGEbe+sW4LYEuHqWT5/bhoeDx+edmwvMwzONWe+5H5uxyGZOUEsi34JWviWu56Fe6
         /JclB31wrotM6MfNpR/Wqa8lSJOJV7CUEFiJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NuSCTuHLyeIME2hbrerbprSKbzeZs/hKIavOLJRoGRQ=;
        b=WjmcirVsA+4UHJfYzPuK3Mnsp47PiybgH7EYgC5S7tK8fbg18mlfn9ZCjkJZ8YjbAm
         +hc2xBM9NOODlZU7yhzInvupGXy0tQGsgu6m+COi4X/ip6/UVxi4c/BbKeFyo4AEjgog
         46W+iRt/jOER9oB4LscuxbcgGQIJ9ppTX0VkfyBvzFPjROwpHw/82i3y04cZw61vePJP
         uIUSpxLyP6HTStVYhWdb8GDfBa7TfazK4T18Ri6gSOY7AshHV9XetS4b69eUs0fEfAH6
         YQvBaFwGBf02QtAzpAfYQTstLsFcBWdMK8/kOnVBFrUKT/V+blSEtAXmTTC+kHJmBpqG
         IY+A==
X-Gm-Message-State: APjAAAXxpGtatT/FnPgj75wVyxDFP4enKPFT8xDDrFFGGqfuaFAT55IL
        N1PY3pIJnmaSM6hCc/0hl/5izA==
X-Google-Smtp-Source: APXvYqw0zqeIpXublcbBrspxIImYvwsqyX3848ANoqBLSESQe4clT0dZGWwSknNUeo8XUDx1yoEmMg==
X-Received: by 2002:a5d:8185:: with SMTP id u5mr4375511ion.147.1571430285037;
        Fri, 18 Oct 2019 13:24:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s24sm2019056iog.26.2019.10.18.13.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 13:24:44 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Tim.Bird@sony.com
Cc:     brendanhiggins@google.com, yzaikin@google.com,
        linux-kselftest@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D0023@USCULXMSG01.am.sony.com>
 <20191017225637.GB6371@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D00A4@USCULXMSG01.am.sony.com>
 <20191018014027.GA21137@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D01DC@USCULXMSG01.am.sony.com>
 <20191018152746.GF21137@mit.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b433854d-3140-95cd-6847-003dcf3851bc@linuxfoundation.org>
Date:   Fri, 18 Oct 2019 14:24:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018152746.GF21137@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/18/19 9:27 AM, Theodore Y. Ts'o wrote:
> On Fri, Oct 18, 2019 at 02:40:50AM +0000, Tim.Bird@sony.com wrote:
>> We're just talking past each other.  My original e-mail was a rebuttal
>> to your assertion that any test that was data-driven or non-deterministic
>> was a fuzzer.  I still believe that's just not the case.  This is independent
>> of the mechanics or speed of how the data is input.
> 
> Apologies, I was still focused on the original context of this thread,
> which was about suggested improvements to Iurii's ext4 kunit test, or
> perhaps adding new features to Kunit.
> 
>> I also conceded (multiple times) that externally data-driven
>> techniques are probably more aptly applied to non-unit tests. I've
>> heard your pitch about speed, and I'm sympathetic.  My point is that
>> I believe there is a place for data-driven tests.
> 

As such what this current test does is data driven right. What we are
discussing is how the data is supplied? In this case it is embedded.

> I guess I would put it differently.  The key goal is it should be
> really easy for developers to run, create, and extend tests.
> Data-driven tests is certainly one technique to make it easier to
> extend tests, and indeed fs/ext4/inode-test.c is data-driven with the
> goal to make it easier to add additional tests.
> 

Again I would make the distinction that "how the data supplied".
Embedded in the test vs. having the flexibility to accept external
test data. From what I can tell,  I didn't see anybody say that the
embedded data is it and nothing more needed.

Instead of adding the ability to read, the suggestion is for modifying
the data. This gets real tedious and don't think anybody will take the
time to do it. On the other hand, is there a few test data files to run
with, it makes it easier to exercise different cases.

> Having the data for the test be external is certainly one option, and
> there will be cases where it will make sense.  However, the overhead
> in creating the parser for the data, and additional complexity
> required to get the test data to be fed to the test program means that
> that benefits need to be pretty large in order to balance the
> additional costs of having an external data file, especially for
> Kunit.
> 

Let's explore it further before deciding whether is useful or not.

> In terms of the abstract question, is there a place for data-driven
> tests, I'm in complete agreement with you.  I've used this many times
> personally, especially when writing tests which are implemented in
> terms of shell scripts.  Examples of this include e2fsprogs's
> regression test suite and xfstests.  I don't consider that a terribly
> interesting question though; I view that as on the same order as "is
> the sky blue?" or "are apple pies yummy?"
> 
> The more interesting, and more concrete question is whether there is a
> place for external data-driven tests in Kunit, and there I am *much*
> more skeptical. 

This is what I am interested in exploring. I do think it will add value.
I can see some use-cases that could benefit from this.

I am not suggesting that this should happen soon. This is something that
can be looked into for the future. I have a few use-cases in mind that
could benefit.

btw. I am by no means suggesting to that this test going in is dependent
on the external data. I already sent my Reviewed-by for the v6 and
planning to pull it into linux-kselftest test for 5.5-rc1.

thanks,
-- Shuah



