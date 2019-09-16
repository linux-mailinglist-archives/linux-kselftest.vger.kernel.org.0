Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657A5B3EBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfIPQSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfIPQSn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:18:43 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4ABC20678;
        Mon, 16 Sep 2019 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568650723;
        bh=pywK1wFWvJV/TiAUcs6evxRAXvFRCHuSPueIlpKBJY0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1EZOs0aBVRlFkJotNJfHiLyD+xl0RnVTDqXAEmbInqulXtZC2zgdIavcUa81rakFa
         95dmLWusMKqWp3Eoj4xF2JHZtcMEJdEsx5T1qDj3EaytbXf9EqtORZt3vf71aB/0/I
         M4kRhZx4ynD+XduyyPJG7P5atKInNon6J/XSuZd0=
Subject: Re: [PATCH v2] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, shuah <shuah@kernel.org>
References: <20190910121813.45742-1-iii@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <cb4e3c3c-3ab8-5d21-495f-5f751c79dde6@kernel.org>
Date:   Mon, 16 Sep 2019 10:18:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910121813.45742-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 6:18 AM, Ilya Leoshkevich wrote:
> The current logic prepends $(OUTPUT) only to the first member of
> $(TEST_PROGS). Use $(addprefix) to prepend it to each member.
> 

Can you please send me the error messages you are seeing so I can see
what is being fixed.

> Also, $(OUTPUT) is assumed to end with a / almost everywhere else in
> the kernel, make this the case for kselftest as well.

Why are these two changes in one patch? Does this fix 1a940687e424?
If so how?

> 
> Fixes: 1a940687e424 ("selftests: lib.mk: copy test scripts and test files for make O=dir run")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

thanks,
-- shuah
