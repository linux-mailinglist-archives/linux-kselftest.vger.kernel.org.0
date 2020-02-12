Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9F15AEDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 18:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBLRiU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 12:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbgBLRiU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 12:38:20 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD0002073C;
        Wed, 12 Feb 2020 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581529100;
        bh=eIsqCr2EAi2T1dBjCc87/1ex3p/87z3JIMyiHuhlRFA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uTChRLsjaS0FFiT4Fl9khqAtV+VUhl5gev2uWDyfcUSTFyljvB5t2opjsKiJdo5II
         AV1Hb6GZlCTh7ZbNQUsAnK6A5FdaeMFs1AQTwxUsDE7oRUjiEvi6Shvhca96Ysk0dP
         zpSuhio1afDTRs+h6Bi3DQCne6VRrFelxt1Np51A=
Subject: Re: Linux 5.6-rc1 kselftest build failures
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>, shuah <shuah@kernel.org>
References: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
 <20200212081414.7bwkndf6qxg2p35a@yavin>
From:   shuah <shuah@kernel.org>
Message-ID: <5311f218-9bb0-4792-c469-019c7c2db7ee@kernel.org>
Date:   Wed, 12 Feb 2020 10:38:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212081414.7bwkndf6qxg2p35a@yavin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/12/20 1:14 AM, Aleksa Sarai wrote:
> On 2020-02-11, shuah <shuah@kernel.org> wrote:
>> openat2:
>>
>> tools/testing/selftests/openat2'
>> gcc -Wall -O2 -g -fsanitize=address -fsanitize=undefined openat2_test.c
>> helpers.c  -o tools/testing/selftests/openat2/openat2_test
>> In file included from /usr/include/fcntl.h:301,
>>                   from helpers.c:9:
>> In function ‘openat’,
>>      inlined from ‘touchat’ at helpers.c:49:11:
>> /usr/include/x86_64-linux-gnu/bits/fcntl2.h:126:4: error: call to
>> ‘__openat_missing_mode’ declared with attribute error: openat with O_CREAT
>> or O_TMPFILE in third argument needs 4 arguments
>>    126 |    __openat_missing_mode ();
>>        |    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Yeah, that's a brain-o -- it looks like you have a newer glibc than
> me which gives you a warning when you don't set the mode. The fix should
> be just the following:
> 

Nice. Do you mind sending a proper patch, I can pull in.

thanks,
-- Shuah
