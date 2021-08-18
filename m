Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9746D3F08EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhHRQWA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 12:22:00 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:34368 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhHRQV7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 12:21:59 -0400
Received: by mail-io1-f52.google.com with SMTP id i7so3616684iow.1;
        Wed, 18 Aug 2021 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0gC+WjafyAckvmR2jgKWhTEEwfe3iTWJAbJzTBop3Y=;
        b=qaNnVTTenGBBwVQYiZNGKQxtSYeD0voImZtowRcvA1K82JCxDKiG/lZPpLwmp8uT8p
         zm4TgmXmYlR7zIJzq+99nPaWxD1Bfhbj+HhWTkay4q683d2vzptvnJtez0/LmTaXNJFM
         SvCOaxR1IaFxbvcTU3bUSZSe4EPLYmFX1Dj6ra0xt1CnXDg5Uik9lgXGf5zpYLcPg0lz
         oCxk+WyU7uoQode0jNBZ8oNh/nwze6mh0mmffVrqXp6q9xflIzS5Ssw9syWdvamRDx0v
         FBS7gbAOThjwTnSINl1WT8st71RionMTFJCu/g6BARVOKyd72Tqlwvldi+Sl9zUOUlKg
         Myig==
X-Gm-Message-State: AOAM532nqalWE3iz9olvaAu+eYqSTilGf1/rVQ7o3NPTSFG0QlpqrOTu
        g2/bwSCTcv//hQxjL2IbWbE=
X-Google-Smtp-Source: ABdhPJxyCAXZZk17cmWbI2Hyif0mg+efhnTUqCkpRprycPO3ktyBAjtCIokfL8Wbv8TNGNohwm0Oww==
X-Received: by 2002:a05:6638:2613:: with SMTP id m19mr6725966jat.11.1629303683988;
        Wed, 18 Aug 2021 09:21:23 -0700 (PDT)
Received: from [10.68.32.40] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id a11sm63956ilf.79.2021.08.18.09.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 09:21:23 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
To:     Joe Perches <joe@perches.com>, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
References: <20210818154646.925351-1-efremov@linux.com>
 <20210818154646.925351-2-efremov@linux.com>
 <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
Date:   Wed, 18 Aug 2021 19:21:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/18/21 7:00 PM, Joe Perches wrote:
> On Wed, 2021-08-18 at 18:46 +0300, Denis Efremov wrote:
>> Properly handle commits like:
>> commit f2791e7eadf4 ("Revert "floppy: refactor open() flags handling"")
> 
> Try this one:
> 
> https://lore.kernel.org/lkml/7f55d9d0369f1ea840fab83eeb77f9f3601fee41.camel@perches.com/
> 

It works but why not to use .+? then?
I'm not sure that non-greedy patterns will properly handle commits like:
$ git log --oneline | fgrep '")'

e.g. 
commit ece2619fe8ed ("extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol") call")


>>
>> Cc: Joe Perches <joe@perches.com>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>>  scripts/checkpatch.pl | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 461d4221e4a4..cf31e8c994d3 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -3200,20 +3200,20 @@ sub process {
>>  			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
>>  			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
>>  			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
>> -			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
>> +			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)"\)/i) {
>>  				$orig_desc = $1;
>>  				$hasparens = 1;
>>  			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
>>  				 defined $rawlines[$linenr] &&
>> -				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
>> +				 $rawlines[$linenr] =~ /^\s*\("(.+)"\)/) {
>>  				$orig_desc = $1;
>>  				$hasparens = 1;
>> -			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
>> +			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\(".+$/i &&
>>  				 defined $rawlines[$linenr] &&
>> -				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
>> -				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
>> +				 $rawlines[$linenr] =~ /^\s*.+"\)/) {
>> +				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("(.+)$/i;
>>  				$orig_desc = $1;
>> -				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
>> +				$rawlines[$linenr] =~ /^\s*(.+)"\)/;
>>  				$orig_desc .= " " . $1;
>>  				$hasparens = 1;
>>  			}
> 
