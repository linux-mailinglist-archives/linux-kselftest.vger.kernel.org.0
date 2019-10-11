Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E1D483C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfJKTLJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 15:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfJKTLJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 15:11:09 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6E9214E0;
        Fri, 11 Oct 2019 19:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570821069;
        bh=LPAY/Fw44gj3OW0bllXbuUd7yBAhG2IkAN8I5jcs+Qo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LuLNszIGxQfEqEA1g3AhAdNMfx/6RSMRCG6xPa784MevgEhZKMPlORw9gCJarQEgb
         jRpWrclxUefAmozyM2ftB5zKHw+VZR787+SWm8muJhshR0lW0lW511N16WAEkrxxAf
         o/XW+1FHWCaD6Ksct7yYJ9drN4V8rpGNnn3gRnVU=
Subject: Re: [Automated-testing] syzkaller reproducers
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        George Kennedy <george.kennedy@oracle.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>, shuah <shuah@kernel.org>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
 <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan>
From:   shuah <shuah@kernel.org>
Message-ID: <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
Date:   Fri, 11 Oct 2019 13:11:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011180248.GA24089@rei.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/11/19 12:02 PM, Cyril Hrubis wrote:
> Hi!
>> Playing with the git getting ready to host it on kernel.org git repo.
>> Build worked fine and I can't get the run.sh to work.
>>
>> I expected it to run what is in
>>
>> syzkaller-repros/bin
>>
>> It doesn't seem to do that. Looks like it wants to build. Here is what
>> I see. What am I doing wrong?
> 
> You are suposed to run the run.sh script in the bin directory.

Yeah that does work.

Would be helpful to have usage instructions instead of failing. :)

> 
>> I did a build which worked. There are some errors due to sys/cdefs.h
>> missing.
> 
> That is because you are missing 32bit gcc and devel libs.
> 

Yeah. I didn't think about that.

thanks,
-- Shuah
