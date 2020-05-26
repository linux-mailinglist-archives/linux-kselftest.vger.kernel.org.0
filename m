Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E341E2811
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 19:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgEZRNb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 13:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgEZRNb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 13:13:31 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 855E62073B;
        Tue, 26 May 2020 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590513210;
        bh=5wgDx0HRqFo+8rbopttzAsy9cScrP/BLJX94ZpGLj10=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g3BFgzBWoWtEVfHoN7P8krCHqY9+9HcXAaJHdA+wbYi2eJq2XY/ZtAQl0iZiUxWiJ
         knczh8g6vVQsJHXdXhuoj718ARHiRl2Fdes40dDrYHWBDpm8M1PAGv2aBX2kB9kDko
         I8lrsrVvX/elFkWW4wZJh/rKn+NYQaLYGb0bjy/8=
Subject: Re: kselftest OOT run_tests
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <xunyblmcqfuu.fsf@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ad5ee014-759c-d0fb-5dc1-f1f25481a453@kernel.org>
Date:   Tue, 26 May 2020 11:13:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xunyblmcqfuu.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/20 7:55 AM, Yauheni Kaliuta wrote:
> Hi!
> 
> I'm wondering how out of tree check is supposed to work for make
> O=dir run_tests from selftests (or make -C ...) directory?
> 
> (both with 051f278e9d81 ("kbuild: replace KBUILD_SRCTREE with
> boolean building_out_of_srctree") and without)
> 
> make M= ... does not work with run_tests.
>

Kselftests run_tests target isn't intended for building and running
tests OOT. Also make M= doesn't make sense for them.

There is no support to build OOT at the moment. I would like to get
a better understanding of your use-case. Can you elaborate?

thanks,
-- Shuah

