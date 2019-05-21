Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38B2557B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfEUQYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 12:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUQYV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 12:24:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C57208C3;
        Tue, 21 May 2019 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558455861;
        bh=0MrOO8qAwS6m3jHlfFQPJ1Vu0EAH7xCauWk003pch6o=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=0O89NFV+hn0e5JJWKjTO2WpE7mJZgqBUnNgyVGXyS3jyGf1tJcHkHIdHAgBECWFBw
         umxnOdF5G+46GjtbQSOODZ4wEsZz11radfOeNvKiALdbhH7xsHGLWPZ1YKfkklzaKL
         Xgc3MPf7VcfRcUaWdzcgWDz52WWo4LlpOL/ljSR4=
Subject: Re: [PATCH v2 5/5] kselftest: Extend vDSO selftest to clock_getres
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-6-vincenzo.frascino@arm.com>
 <f07e07b0-4e53-96c8-ebe2-a0f5528fa329@arm.com>
Cc:     shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <252b011e-974a-2f3b-2cc3-0892d1c4a3c0@kernel.org>
Date:   Tue, 21 May 2019 10:24:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f07e07b0-4e53-96c8-ebe2-a0f5528fa329@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/21/19 10:11 AM, Vincenzo Frascino wrote:
> Hi Shuah,
> 
> I did not see this patch in 5.2-rc1 and I was wondering if there is anything I
> can do to help with upstraming it.
> 

Thanks for the ping.

Sorry about this. I saw that this part of a series and thought it
depends on other patches and should go through another tree.

Totally missed that Will suggested that I take it though selftests.

My bad. I will get this in - I hope there are no dependencies with other
trees.

thanks,
-- Shuah

