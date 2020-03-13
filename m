Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8962C184BE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 16:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMP7b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 11:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMP7b (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 11:59:31 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7185206E2;
        Fri, 13 Mar 2020 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584115170;
        bh=q9WzrSwm8gOHIC2hvEzyR4UE/XyTmPtQJMYzG4PWkSs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fdkTDeL/URUyZJzQlHFoUy3sQpV5iCzz3SoIxmy5CQUcbRL/a1RkEJkomfLgO0eJF
         LDMlXUzFgooIJE+UZSd1kmhyDYWVW67omPpbb3gDU89el/32tggakV1OvG9Rk7lsAF
         OSzbNbbVBD8L4k1+FZA9qY5ZarmHsYrGRemX/wUo=
Subject: Re: [Automated-testing] syzkaller reproducers
To:     Dmitry Vyukov <dvyukov@google.com>,
        George Kennedy <george.kennedy@oracle.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        shuah <shuah@kernel.org>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
 <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan>
 <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan>
 <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
 <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com>
 <86bde120-e5fe-4bb1-9b93-769a444500f9@oracle.com>
 <e8b11b09-37ac-6ae2-0908-b803b4160f7c@oracle.com>
 <CACT4Y+bShy-3vO3ifNKVcGGNf3X9XA7zL-Ja9-T+gZv5=QNe4w@mail.gmail.com>
 <8a4dbbb1-f8ba-00ba-41d2-d82a35fc0f81@oracle.com>
 <CACT4Y+aZ=rBZXdnrU0D-21QqSK0G3vqHU+iD=k0PhGgo3TL6rA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <fe365a78-0768-ea1f-25b8-6bd05a57c751@kernel.org>
Date:   Fri, 13 Mar 2020 09:59:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aZ=rBZXdnrU0D-21QqSK0G3vqHU+iD=k0PhGgo3TL6rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/3/20 1:45 AM, Dmitry Vyukov wrote:
> Shauh,
> 
> We've added more reproducers to:
> https://github.com/dvyukov/syzkaller-repros/tree/master/linux
> 
> It makes sense to pull in them to the kernel-arts repo. Not sure
> what's the most convenient way for you since it's not exactly a
> traditional "patch"? Perhaps you just copy linux/*.c files and commit?
> 

Thanks Dmitry. I will pull these in. I will pull these in.

thanks,
-- Shuah
