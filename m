Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF21E2844
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgEZRSJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 13:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgEZRSI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 13:18:08 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506E2207FB;
        Tue, 26 May 2020 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590513488;
        bh=iVK1muSdHBemBl4sd2kRsJkH1agJlv272ocuasPt1Oc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EV7tzSdnrX75yYZziXI5cPUlpmN1Pxn8FX4hWDPTiNNfsjj+rct9dZ6xyEFmMkDFS
         hYjQIfMCnwpJMyGPj5M1/VcRNaLMwuMY+moJ6W8SA8v/Sef5GWvhYvIwbaaRlKiKhr
         h5d4yDiXTxv7ZsPqueRX5ZLr4GDofwkQyqD46gi8=
Subject: Re: [PATCH v2 0/3] selftests: lib.mk improvements
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
 <689fe06a-c781-e6ed-0544-8023c86fc21a@kernel.org>
 <xunyblmknfmy.fsf@redhat.com>
 <4e0d1e4e-9ed2-025c-1164-fd52a88c1ed2@kernel.org>
 <CANoWswmZmHo=ha65u=D8XWD7u9decs6FqubPjVu2YOvm6bz-nA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <8ca17af4-c530-7198-41b0-680f2f04c74a@kernel.org>
Date:   Tue, 26 May 2020 11:18:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CANoWswmZmHo=ha65u=D8XWD7u9decs6FqubPjVu2YOvm6bz-nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/22/20 9:38 AM, Yauheni Kaliuta wrote:
> Hi, Shuah!
> 
> On Fri, May 22, 2020 at 6:09 PM shuah <shuah@kernel.org> wrote:
>>
>> On 5/19/20 8:49 AM, Yauheni Kaliuta wrote:
>>> Hi, shuah!
>>>
>>>>>>>> On Tue, 19 May 2020 07:59:16 -0600, shuah   wrote:
>>>
>>>    > On 5/15/20 6:00 AM, Yauheni Kaliuta wrote:
>>>    >>
>>>    >> Yauheni Kaliuta (3):
>>>    >> selftests: do not use .ONESHELL
>>>    >> selftests: fix condition in run_tests
>>>    >> selftests: simplify run_tests
>>>    >>
>>>    >> tools/testing/selftests/lib.mk | 19 ++++++-------------
>>>    >> 1 file changed, 6 insertions(+), 13 deletions(-)
>>>    >>
>>>
>>>    > Quick note that, I will pull these in for 5.8-rc1.
>>
>> Patches look okay to me, however, just noticed, this series hasn't
>> been cc'ed to linux-kselftest. Hence it didn't go through the
>> necessary reviews.
>>
>> Please run get_maintainers and resend the series to everybody the
>> script suggests.
>>
> 
> Sorry for that. Should I resend to the ML?
> 


Yes please.

thanks,
-- Shuah

