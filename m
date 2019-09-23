Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAFEBBC7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 21:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502444AbfIWTw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 15:52:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWTw6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 15:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DbsCXCICsdIBOG6eQYsdKwB9i0kFNIakPhaDmZrBg2g=; b=TJWrb2OlXCdFm11DRcSuG6Xag
        Nr7BeGhiaCScQYo4fDEGV0ktT1BKSjVqnrVfEhEUzObBxHDVieqFOsG7ZpdG5bLTzzZpy1h4ebEeq
        kagC3q8znEzSZfj7SR3L2Gm3HFPX496ylz1YsUEJf9Qc0sCgE/71150MRwIHhSncw86L17MyV6fBh
        v/2d0LkA9scbWB9MvJCcU5qnXsNf89Hsqag2WIMArybX7TFQJ4n7RJ/4c9JRf+PYqjjIyQuS49KtA
        JzPrqDzkgFfgYViuwdEZrMpKDtxrV90GmnRhceRracHIWraUfbEwt5SilefGrUwy8Ua7vv0Z5o7Uy
        ucMy6pJnA==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCUOH-0006Bw-MV; Mon, 23 Sep 2019 19:52:57 +0000
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Ingo Molnar <mingo@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com> <20190922115247.GA2679387@kroah.com>
 <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
 <20190923194322.GA55255@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <32d0e94d-bf9a-01e9-2548-1fc976c7f17b@infradead.org>
Date:   Mon, 23 Sep 2019 12:52:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923194322.GA55255@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/23/19 12:43 PM, Ingo Molnar wrote:
> 
> * Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> I am exploring the possibility to move selftests to a better location 
>> or add a git alias so it can be found easily. With the addition of 
>> KUnit and future work that is planned to connect kselftest and KUnit, 
>> it would make sense have selftests to be in a location that is better 
>> suited than where it currently resides.
>>
>> I have been getting feedback from some developers that they would like 
>> to see selftests more visible and easier to find.
>>
>> There are some dependencies (unintended, shouldn't exist) between some 
>> tests and content under tools that might pose some logistical problems, 
>> in addition to the churn of backporting.
>>
>> I haven't explored "git alias" yet though. Since this topic of moving 
>> came up, I would liek to get feedback on selftests location in general 
>> and where would be a good place for it.
> 
> I'm not sure about the Git alias thing - but I do agree that 
> tools/testing/selftests is a pretty obscure location given the importance 
> of kernel unit tests - and I think it could be moved one level higher, to 
> tools/selftests? The "selftest" name already implies the "test" aspect 
> after all.


Without trying to use too much paint, I would move testing/ to a top-level
dir, outside of tools/, and leave selftest/ under testing/.

-- 
~Randy
