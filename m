Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AF41A2499
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgDHPHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 11:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgDHPHQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 11:07:16 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44972206F5;
        Wed,  8 Apr 2020 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586358436;
        bh=QuHEGNN4a+Ol4/SqzFT7wRXfZokugzHBH9s6SUo5j8Q=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=s5fuOcQftmF0VE7ftbATIv52dU+A03FAKQgUt+HED8YYdql9qOu2n2J4b09LNyKbB
         bX+Bq+Z9fy18L51Mocu2i6aKvS6iSMw8Qub4/03vQq4rfx+QnNhu1Nz18pIekbRxFA
         EeLPv55IQVJAZgZCUKPP3OkQhedf0pf43vt/x1LY=
Subject: Re: kselftest build error: ../lib.mk: No such file or directory
To:     Deepa B <deepa01012015@gmail.com>, linux-kselftest@vger.kernel.org
References: <CANmdEh3Ukq6+WbdN49B0uPZqC0Cm=jve=cL9vFv1YYaXHqL63Q@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Cc:     shuah <shuah@kernel.org>
Message-ID: <38bb916a-b8b4-143e-48aa-594bc8ff546c@kernel.org>
Date:   Wed, 8 Apr 2020 09:06:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANmdEh3Ukq6+WbdN49B0uPZqC0Cm=jve=cL9vFv1YYaXHqL63Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/7/20 11:51 PM, Deepa B wrote:
> Hello,
> I'm running kselftest on Ubuntu 16.04lts.
> Details:
> deepa@deepa-Inspiron-3576:/usr/src/linux-headers-4.15.0-88/Documentation$
> uname -a
> Linux deepa-Inspiron-3576 4.15.0-91-generic #92~16.04.1-Ubuntu SMP Fri
> Feb 28 14:57:22 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> 
> Command:
> deepa@deepa-Inspiron-3576:/usr/src/linux-headers-4.15.0-91-generic$
> make -C tools/testing/selftests
> 
> Error:
> make: Entering directory
> '/usr/src/linux-headers-4.15.0-91/tools/testing/selftests'
> make[1]: Entering directory
> '/usr/src/linux-headers-4.15.0-91/tools/testing/selftests/android'
> Makefile:7: ../lib.mk: No such file or directory
> make[1]: *** No rule to make target '../lib.mk'.  Stop.
> make[1]: Leaving directory

Looks like you are trying to build in /usr/src/linux-headers-4.15.0-88
This doesn't contain any source files.

Go down into directorties below selftest or

/usr/src/linux-headers-4.15.0-88/kernel you will see that there are
no .[ch] files in these directories.

You have to install Ubuntu 16.04lts source package for kernel or
checkout kernel git repos to build kernel and selftests for that
kernel from sources.

thanks,
-- Shuah



