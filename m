Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5C1DA457
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 May 2020 00:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgESWQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 18:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESWQl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 18:16:41 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD40C2075F;
        Tue, 19 May 2020 22:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589926600;
        bh=RyWC/bFV8ItGh7pgttI1BldvKPNDCEUggcCOKsPQbqY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AEjsNdF+gGHFEP7llvxMaPuc9ZKhdIspTY6TmH3231krk1J38kqhjBOKYZSTjHSic
         KjssEgLzGTEJYERmdw/rEZ9CY79EYw7h0FfMSDwN4URkj3pNgw/WZuyRpvIbM4BOH3
         lyT9RicU6ERj4Z4dVyAzXcjocSyJY6MwfhZQ4dYA=
Subject: Re: [PATCH v2] selftests: introduce gen_tar Makefile target
To:     Stefano Brivio <sbrivio@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200519200045.317516-1-vkabatov@redhat.com>
 <20200519225722.49e4d067@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <35755630-2653-719d-5684-7cf7cc86fd2b@kernel.org>
Date:   Tue, 19 May 2020 16:16:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519225722.49e4d067@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/19/20 2:57 PM, Stefano Brivio wrote:
> On Tue, 19 May 2020 22:00:45 +0200
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

Applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
for Linux 5.8-rc1.

thanks,
-- Shuah
