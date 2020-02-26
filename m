Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840A117082C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBZTBd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 14:01:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42939 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBZTBd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 14:01:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id u3so55404plr.9
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2020 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ATCKzo/gzRmMNQS8TBoj8F2LcVte5l4YReuJidbYCk=;
        b=JN3PoAv4GK1eTqJJvP77PN8TbdvNTRarphHEwxan72jmJPgZzYH/RakPIG8YP5cwuY
         PcVPGQyZCUYbWRgaM9aQEu06iMRJr9xaHoujPc6GOtKZJQ3CSK8sD3phuh+gModawnHE
         qjZvrugvNpbyLWGcFKEmNAtqTOHwWIyTH5LuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ATCKzo/gzRmMNQS8TBoj8F2LcVte5l4YReuJidbYCk=;
        b=pvTwkGgpcGA5Q/04JZAPkEC8YCuIOeJlwUwd/iKxoLRMAXZIZata7UH4KPtmz+2Ll3
         15MhbPLSUfcGRciIrjJ0xNIuVI/qqpHe6m4g1ENm5LZTNQhDh8/BKpon0wYf2AWbNseM
         yeln+h7rYTbwWaU0eSc9vQeSo37uehwirTZufEMmDvRsDgmKHahdNM2A6IIxerlZ+dUM
         kt1dCVCmIGTCrHn0VGoUMtQWHi/NlVQ5u0bSwUsDBOJRGnxWBeFDMxie0Q30QpkCQFHc
         6ie6ITFwhFQNZwS1uFDVZmVTtaYNDczCAOjNFTTNg1uqtVn6OatPN6ZpBjNYP4V0OU63
         E+iQ==
X-Gm-Message-State: APjAAAWRtAIRuqeUj7SJLnN5NjJDBO7SnWXlwlC8KOsQ+7G0LOGiTSsf
        hu2XVZgqZ0mLE94npQG8svl/aA==
X-Google-Smtp-Source: APXvYqwg1MbijmVQVnfYFIBi41a8NSAB0pByCSDUzo7KP9zG9KvOInzMkhGjNZLsNIqp3JTlAzNPlw==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr659964pla.313.1582743692593;
        Wed, 26 Feb 2020 11:01:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h185sm3973110pfg.135.2020.02.26.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 11:01:31 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:01:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: Re: selftests: Linux Kernel Dump Test Module output
Message-ID: <202002261052.62C3132B0@keescook>
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
 <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com>
 <202002251131.3216B3B50C@keescook>
 <b485a8a9-5312-ca77-d091-3dbfac33ec5b@arm.com>
 <CA+G9fYuQJjf3v53HNj4TOAL2NcgDCYCrsUkfL6h93ntXO3WWwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuQJjf3v53HNj4TOAL2NcgDCYCrsUkfL6h93ntXO3WWwg@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 26, 2020 at 11:32:46PM +0530, Naresh Kamboju wrote:
> Yeah i see this case at my end also.
> 
> my two cents,
> I have two comments,
> 1) shell check

I'll fix these up; thanks for the suggestions!

> Test output with set -x for debugging shell scripts.
> [...]
> ++ dmesg -c
> +++ mktemp --tmpdir -t lkdtm-XXXXXX
> ++ LOG=/tmp/lkdtm-r5yZ7K
> ++ trap cleanup EXIT
> ++ /bin/sh -c 'cat <(echo BUG) >/sys/kernel/debug/provoke-crash/DIRECT'
> ++ true
> ++ dmesg -c
> ++ cat /tmp/lkdtm-r5yZ7K

This is the part that is failing and I don't know why.

clear the kernel event log:
	dmesg -c
trigger the kernel event:
	/bin/sh -c 'cat <(echo BUG) >/sys/kernel/debug/provoke-crash/DIRECT'
dump the newly added event logs into a file (set -x doesn't report
redirection to /tmp/lkdtm-r5yZ7K):
	dmesg -c

It seems /tmp/lkdtm-r5yZ7K is empty?

-- 
Kees Cook
