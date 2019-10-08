Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE1CFD00
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfJHPA0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 11:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJHPA0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 11:00:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8529320659;
        Tue,  8 Oct 2019 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570546825;
        bh=jXgFsV8B2WE5Wn1aOTrbzPny3ag79sQYvpOaVnwykbc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LXW/qtrrjsjRHakzuFnoJsNFuwSdi15Gj/5xGR6pe/try0KD7vcrdATfEco7snoxN
         Y0I+GTqtp0z/R03Jrg74wbMj8KhhJzdibSzyLaXibEp9Aun0/TfAABTnFQhSFEvrYD
         HbdGNFcUX4Xn5xA2eKjvCstON8C1vuJUwo/LllfU=
Subject: Re: syzkaller reproducers
To:     Dmitry Vyukov <dvyukov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        George Kennedy <george.kennedy@oracle.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>
Cc:     syzkaller <syzkaller@googlegroups.com>, shuah <shuah@kernel.org>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
Date:   Tue, 8 Oct 2019 09:00:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/8/19 6:16 AM, Dmitry Vyukov wrote:
> On Tue, Oct 8, 2019 at 1:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> Hi Shuah,
>>
>> We discussed collecting and uploading all syzkaller reproducers
>> somewhere. You wanted to see how they look. I've uploaded all current
>> reproducers here:
>> https://github.com/dvyukov/syzkaller-repros
>> Minimalistic build/run scripts are included.
>> +some testing mailing lists too as this can be used as a test suite
>> If you have any potential uses for this, you are welcome to use it.
>> But then we probably need to find some more official and shared place
>> for them than my private github.
>> The test programs can also be bulk updated if necessary, because all
>> of this is auto-generated.
>>
>> Thanks
> 
> +more people who expressed interest in the test suite before
> 

Thanks for putting this together. I am going to create a repo on
kernel.org t host these and pull your private git content in.

I will work on it this week and set things up.

thanks,
-- Shuah
