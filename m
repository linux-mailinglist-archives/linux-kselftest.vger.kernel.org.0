Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22116EF31
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2019 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfGTL0f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jul 2019 07:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfGTL0f (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jul 2019 07:26:35 -0400
Received: from [172.20.8.67] (fs96f9c61d.tkyc509.ap.nuro.jp [150.249.198.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697C52085A;
        Sat, 20 Jul 2019 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563621993;
        bh=3SUZmadzDe7fZKtemUgCqA58AeiwBRjEiZfEGCfW8uY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kyWQh1KGlBxoFNH5Qlz+xQb1thWWJQr5Bxog3NC4B/3yL/NPuPvC+9nusDXUL7Uzk
         fKKbgTzBqYjyzto++wL8OJt+nlLWlEKS0RGFHF1e2EZDHam7+Z4xQ0K7mRwsDTyv5N
         4AW29sQvANn6A/7dVAbJDZbnY3PEOAdPubCY+JmQ=
Subject: Re: [PATCH] selftests/livepatch: add test skip handling
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190714142829.29458-1-joe.lawrence@redhat.com>
 <20190714143306.GA29501@redhat.com>
 <5535ff5e-0f75-9185-11bb-400465f09f5c@kernel.org>
 <42feff41-8a92-e252-0e90-5c0335547de1@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <215509dd-27d9-244a-870b-69df69fef38a@kernel.org>
Date:   Sat, 20 Jul 2019 05:26:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <42feff41-8a92-e252-0e90-5c0335547de1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/19 8:51 PM, Joe Lawrence wrote:
> On 7/19/19 6:11 PM, shuah wrote:
>> On 7/14/19 8:33 AM, Joe Lawrence wrote:
>>> On Sun, Jul 14, 2019 at 10:28:29AM -0400, Joe Lawrence wrote:
>>>
>  >> [ ... snip ... ]
>>>
>>> Testing:
>>>
>>> Here's the output if modprobe --dry-run doesn't like the modules (not
>>> built, etc.):
>>>
>>>     TAP version 13
>>>     selftests: livepatch: test-livepatch.sh
>>>     ========================================
>>>     SKIP: Failed modprobe --dry-run of module: test_klp_livepatch
>>>     not ok 1..1 selftests: livepatch: test-livepatch.sh [SKIP]
>>>     selftests: livepatch: test-callbacks.sh
>>>     ========================================
>>>     SKIP: Failed modprobe --dry-run of module: test_klp_callbacks_demo
>>>     not ok 1..2 selftests: livepatch: test-callbacks.sh [SKIP]
>>>     selftests: livepatch: test-shadow-vars.sh
>>>     ========================================
>>>     SKIP: Failed modprobe --dry-run of module: test_klp_shadow_vars
>>>     not ok 1..3 selftests: livepatch: test-shadow-vars.sh [SKIP]
>>>
>>
>> Please refine these messages to say what users should do. In addition
>> to what failed, also add what is missing - enable config option etc.
>>
> 
> Hi Shuah,
> 
> Note that v2 was posted [1], but the output remains basically the same, 
> so your comments still apply.
> 
> Off the top of my head, modprobe can fail for many reasons: unprivileged 
> user, missing .ko files, missing modules.dep entry, kernel vermagic, 
> interface versions, etc.
> 


> What would you think about modifying our skip() function to provide a 
> catch-all list of CONFIG, environment, etc. requirements?  Something 
> like, "Please ensure that the kernel was build with CONFIG_XYZ and that 
> the tests are run with foo privileges"?  That would let us avoid trying 
> to figure out exactly why the modprobe failed, but still help out the user.
> 

I understand. I am not suggesting that you have to figure out why. I am
suggesting that instead of "Failed modprobe --dry-run of module", say
"Unable to load test_klp_shadow_vars module. Check if config option is
enabled"  which is user friendly compared to the current message.

thanks,
-- Shuah


