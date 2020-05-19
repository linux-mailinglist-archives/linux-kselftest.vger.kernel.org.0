Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466D61D9FA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgESSjZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 14:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgESSjZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 14:39:25 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88897207D3;
        Tue, 19 May 2020 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589913564;
        bh=KStAFTlR47KmXl1GzAy98aMWrh+mGBMToQO5AHu1/Hg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PhMx8KKcC13IvukzSxjvdw9D4V5NjWsEx8IS3yTWsEyTx19C9QceFLZx6Gs8wdq9f
         9Gn1Ixl73nqTg6KaIVPlTtBzW0ZNjqi4YJTK2fPBWDZh+OxurW1aULf1SK+hN7Py4D
         m2fkcoapz+TKuNdeiVt+HWq3+caJt+/l7yXtNifs=
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     Veronika Kabatova <veronicca114@gmail.com>, sbrivio@redhat.com,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200428123841.2953099-1-vkabatov@redhat.com>
 <529c2308-0840-a794-fc09-d44272066b08@kernel.org>
 <687583033.21650764.1588593000351.JavaMail.zimbra@redhat.com>
 <492228e8-9762-dfe9-8cb6-534c8e6171b9@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <cb18f49a-02aa-4a85-a80d-e991254cd6b9@kernel.org>
Date:   Tue, 19 May 2020 12:39:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <492228e8-9762-dfe9-8cb6-534c8e6171b9@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Veronika,

On 5/6/20 8:56 AM, shuah wrote:
> On 5/4/20 5:50 AM, Veronika Kabatova wrote:
>>
>>
>> ----- Original Message -----
>>> From: "shuah" <shuah@kernel.org>
>>> To: "Veronika Kabatova" <veronicca114@gmail.com>
>>> Cc: sbrivio@redhat.com, linux-kselftest@vger.kernel.org, "Veronika 
>>> Kabatova" <vkabatov@redhat.com>, "shuah"
>>> <shuah@kernel.org>
>>> Sent: Friday, May 1, 2020 4:49:34 PM
>>> Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
>>>
>>> Hi Veronica,
>>>
>>
>> Hi,
>>
>>> On 4/28/20 6:38 AM, Veronika Kabatova wrote:
>>>> The gen_kselftest_tar.sh always packages *all* selftests and doesn't
>>>> pass along any variables to `make install` to influence what should be
>>>> built. This can result in an early error on the command line ("Unknown
>>>> tarball format TARGETS=XXX"), or unexpected test failures as the
>>>> tarball contains tests people wanted to skip on purpose.
>>>>
>>>> Since the makefile already contains all the logic, we can add a target
>>>> for packaging. Keep the default .gz target the script uses, and 
>>>> actually
>>>> extend the supported formats by using tar's autodetection.
>>>>
>>>
>>> Thanks for working on this. gen_kselftest_tar.sh  a while back before a
>>> lot of the install features went in and Makefile supports it fully. It
>>> makes perfect sense to use Makefile drive this.
>>>
>>>> To not break current workflows, keep the gen_kselftest_tar.sh script as
>>>> it is, with an added suggestion to use the makefile target instead.
>>>>
>>>
>>> Not sure how many people use this. It is a good idea keeping it around
>>> for now.
>>>
>>>> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>

There is a mispatch between your from email address and signed-off line.
Please make sure they match.

Also there is a spelling error in the document.


WARNING: 'overriden' may be misspelled - perhaps 'overridden'?
#125: FILE: Documentation/dev-tools/kselftest.rst:163:
+default, `.gz` format is used. The tar format can be overriden by 
specifying

WARNING: Missing Signed-off-by: line by nominal patch author 'Veronika 
Kabatova <veronicca114@gmail.com>'

Please fix them and sen me v2.

thanks,
-- Shuah
