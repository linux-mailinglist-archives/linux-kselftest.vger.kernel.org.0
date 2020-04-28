Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024D01BB29E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD1ARn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Apr 2020 20:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD1ARn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Apr 2020 20:17:43 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20DB2072A;
        Tue, 28 Apr 2020 00:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588033062;
        bh=RvIxbz6xV8TKE7G+MxbFyTQV5ilrjLjm+DZT86ra/fs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=otOtwt713Z4AldxEewg5HRKiJKciN128nsMQ+bq0PGpC5D7ZU1ZqpF+3YO+/efMIb
         4JSS6JEk3VORZoRjGMcoCcSQa20amQXXy9q1o5E4kMz/Hi+SkSFK247KCsmnKx3iMH
         zASZDdB6wlpUYYkigoji7kgG+ImikasglcTVgkFI=
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
To:     Stefano Brivio <sbrivio@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200427192141.2926018-1-vkabatov@redhat.com>
 <20200427212405.2747394d@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <bd179be3-2515-1efb-ba95-3c223d573753@kernel.org>
Date:   Mon, 27 Apr 2020 18:17:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427212405.2747394d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Veronika,

On 4/27/20 1:24 PM, Stefano Brivio wrote:
> On Mon, 27 Apr 2020 21:21:41 +0200
> Veronika Kabatova <vkabatov@redhat.com> wrote:
> 
>> The gen_kselftest_tar.sh always packages *all* selftests and doesn't
>> pass along any variables to `make install` to influence what should be
>> built. This can result in an early error on the command line ("Unknown
>> tarball format TARGETS=XXX"), or unexpected test failures as the
>> tarball contains tests people wanted to skip on purpose.
>>
>> Since the makefile already contains all the logic, we can add a target
>> for packaging. Keep the default .gz target the script uses, and actually
>> extend the supported formats by using tar's autodetection.
>>
>> To not break current workflows, keep the gen_kselftest_tar.sh script as
>> it is, with an added suggestion to use the makefile target instead.
>>
>> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> 
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> 

I don't see this in my Inbox. Please include everybody get_maintainers
script tells you to do.

You can add the Reviewed-by: Stefano Brivio <sbrivio@redhat.com> to the
patch when you resend it.

thanks,
-- Shuah
