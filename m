Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75113DD126
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440330AbfJRVYt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 17:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfJRVYs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 17:24:48 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C003220679;
        Fri, 18 Oct 2019 21:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571433888;
        bh=XodxEAJdmw1CAkdlRH8NDfuJ2VdPX6jco4O3Dft4HDg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KoftfP9L9mtOV63jzH9uu+GmN+JK5PpRj3eSRelYfKiy6VH7uM4mcfNv/2BgUhLwu
         KAG5tIcPS2ugb0iRDxQ7V59K2OO7FlSry9EhwqOxPT3htauyAb7jE2f0DpqMNinClF
         Nu83MEJLmwFc9xXqtgqwB8LbBWu/TFB4+R4lefXQ=
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for the
 'list' doubly linked list
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20191010185631.26541-1-davidgow@google.com>
 <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
 <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com>
 <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
 <CABVgOS=W4cfFoE=JT4mbk1zkUsreucrw_B81R2jwDCFPocomHQ@mail.gmail.com>
 <20191016173233.2bd9c9d47f12453c1cb4a9b7@linux-foundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <84f0b15f-f451-fce7-1ab2-1ecdf740c864@kernel.org>
Date:   Fri, 18 Oct 2019 15:24:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016173233.2bd9c9d47f12453c1cb4a9b7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/19 6:32 PM, Andrew Morton wrote:
> On Wed, 16 Oct 2019 14:48:59 -0700 David Gow <davidgow@google.com> wrote:
> 
>> Since KUnit is not yet in Linus' branch, though, it probably makes
>> sense to put this test into the linux-kselftest/test branch, so that
>> there aren't any chances of the list test getting in without the KUnit
>> infrastructure. Ultimately, once KUnit is upstream, this shouldn't be
>> an issue, but it is probably easier to consolidate things for now.
>> Does that sound sensible?
> 
> Well, whatever.  I have a note that it's dependent on kunit.
> 
David and Andrew,

I have a few comments on CONFIG naming to be consistent with the other
kunit ext4 test and a couple of other comments that would requite v3.

I would like to bundle these in the pull request with KUnit framework.
Hope that is okay with you.

thanks,
-- Shuah


