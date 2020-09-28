Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC9527B622
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI1US4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:18:56 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3433 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1US4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:18:56 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7244cc0000>; Mon, 28 Sep 2020 13:17:16 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 20:18:55 +0000
Subject: Re: [PATCH 8/8] selftests/vm: hmm-tests: remove the libhugetlbfs
 dependency
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-9-jhubbard@nvidia.com>
 <20200928130245.GQ9916@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <982fd9bf-64cb-00e9-f092-13849c7cf7d9@nvidia.com>
Date:   Mon, 28 Sep 2020 13:18:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928130245.GQ9916@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601324236; bh=O2i3Vdy5N6Vs0TRULMqHmrEurgd7OBZM5lfhatrbaRg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=mzXVXwiRJ+Il0yV0xeEzTd7ksvI/MhOCIjEBbWjkvlITArH3Mqb9yFhwVo3s2Qq6H
         uRxhc98vGseLTO//ZeUc98XyvBExMD0JZbk9uO+fkSK9463sKShxdXO4PSHDhpVY6l
         6ZRqsNpkB3oXpo/f3MA9WLP9zTxu58u59M5XbkWfXsLQaOWl/ABVQuCqG+7Qq111nG
         RmMzTPY8pK3CMb1292VSCjmeXOhODzka6F+vTjqwkUzp8fm3msMU+vpSJQCcvO7mmk
         w0cr273zgoiDsUaJpISMH9GmXR6RgXeCPeflmVz+1CC2bFmtBzYpgvvNBBcBgqQlOp
         KN5PBysEory5Q==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/20 6:02 AM, Jason Gunthorpe wrote:
> On Sun, Sep 27, 2020 at 11:21:59PM -0700, John Hubbard wrote:
...
>> +gcc -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
> 
> This gcc has to come from some makefile variable

ahem, yes, that really should have just been $(CC), will change to that.

> 
> This is kind of janky :\
> 
> Could we just not use libhugetlbfs? Doesn't it all just boil down to
> creating a file in /dev/huge? Eg look at tools/testing/selftests/vm/hugepage-mmap.c
> 

Well, the situation is a lot worse than that, because hmm-tests.c is using a few
helper functions that end up pulling in more and more.

My first attempt was actually in your direction: just grab a bit of code from the
library and drop it in. But that ended up turning into several pages of code from
quite a few functions and definitions, and it was looking maybe excessive. (I
can look at it again, though. Maybe it feels less excessive if there are no other
acceptible alternatives.)

So then I thought, why not just *delete* those two routines from hmm-tests.c? But
Ralph didn't like that because he notes that hmm_range_fault() loses some useful
test coverage by being exercised with hugetlbfs.

So finally I landed here, which is so far, the smallest change that would be
potentially acceptible: a couple dozen lines, in order to selectively disable the
problematic routines.

Anyway, thoughts? I like the current approach but am open to anything that makes
hmm-test Just Work for more people, on the *first* try.

thanks,
-- 
John Hubbard
NVIDIA
