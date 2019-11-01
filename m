Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6FEEC15F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2019 11:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfKAKuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Nov 2019 06:50:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46611 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfKAKuM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Nov 2019 06:50:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id 19so1754336lft.13
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2019 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dSTkZ3gJr9RHofvoMOdrYurKDo1euKiXxFo6I0S5MME=;
        b=TP7wjRIIldd6f149q7ZYazFr0cKDyA3RDCsG91Q97OhRmJm747gICMnYi+aftXR2mI
         QT5Frf2tO23R/gTAFQAlufET+UwaTz9TymoyxavjU9y3a7adhgEnjebEjK2vzE6cy3uo
         /cmTsAd8guON80ez2qiVszH4PPauwps8G3PsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSTkZ3gJr9RHofvoMOdrYurKDo1euKiXxFo6I0S5MME=;
        b=oo9Yp8AtcZEN7QihGv/ovSXvWIFBG06Mipf0egDcnUFDydKPNOYf5goWvGpgt7WUmz
         nFAu+ffjq0iw5FLNi6/iLb/cLWmyQcj+oK37Wbe71y/xMB+lYXJO9gd0RNIE8jXKzE+/
         sV9wvD+wLSDvCYXOtGaD9ytYPfIEucBx9U3F6IjsBxU/yj9UvFpdDepRKuCEUrzbohmn
         ds2wYq38y2oCBxH9rFeu1ike3i9yFZIcoI0OC7GnTAbr1VcTh/iqjEL0ANIJ5PycY0p4
         R7bKWhhnqPUUsloxzrvkxjzHc9gwCqsEQ7JEPZZiIDldTkPzFj4iFvTvLgjDdBNBcp09
         fxkg==
X-Gm-Message-State: APjAAAVFc8+D8DaorXY6BIjgKfH5ImCzcFXs/cVuaznWJ6+sFHdJ/Avy
        NvDEgqmousN5/eViM1pcYiCzCQ==
X-Google-Smtp-Source: APXvYqxQxPQDEux7hWSTiO63Y8iwSwLLWeFP/8NIgD4MGfM9h5FyYt0mNJkKU9AYNJeO1RGZ/WCXfg==
X-Received: by 2002:a19:c354:: with SMTP id t81mr6546520lff.179.1572605408939;
        Fri, 01 Nov 2019 03:50:08 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d19sm2566388lfc.12.2019.11.01.03.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 03:50:08 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for the
 'list' doubly linked list
To:     Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
 <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <20191030184600.GC18421@kadam>
 <2b3b48a8512d2c567fce388394ad1d262d31908e.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8e8654d4-f81e-be04-7a43-68ff98cdd293@rasmusvillemoes.dk>
Date:   Fri, 1 Nov 2019 11:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2b3b48a8512d2c567fce388394ad1d262d31908e.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30/10/2019 20.15, Joe Perches wrote:
> On Wed, 2019-10-30 at 21:46 +0300, Dan Carpenter wrote:
>> Hm...  I imagined the checkpatch code a little different in my head but
>> this would also work to make it stricter.  I doubt it miss very many
>> real life style problems.
> 
> Well, doubts vs reality...
> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3607,7 +3607,7 @@ sub process {
>>  
>>  # if/while/etc brace do not go on next line, unless defining a do while loop,
>>  # or if that brace on the next line is for something else
>> -		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:[a-z_]+|)for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
>> +		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:list|hlist)_for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
>>  			my $pre_ctx = "$1$2";
>>  
>>  			my ($level, @ctx) = ctx_statement_level($linenr, $realcnt, 0);
> 
> So - nak

How about changing the check so it only matches the
if/while/for/*for_each*/ thing when it's the first thing on a line _and_
has non-trivial whitespace in front. Then a function declaration as

static void test_for_each()
{

would not fire, nor would it if it were written in the other common style

static void
test_for_each()
{

?

Maybe there'd still be a problem at the call-sites

  test_for_each();
  this_is_not_indented;

but the ending semi-colon should actually make it appear as a loop with
an empty body (though that in itself might fire a different warning,
dunno if checkpatch has that kind of warnings). But in any case the
above should remove _some_ false positives.

Rasmus
