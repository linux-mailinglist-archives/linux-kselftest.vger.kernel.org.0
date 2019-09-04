Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746ADA96A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2019 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfIDWoP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 18:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIDWoO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 18:44:14 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 782EC20870;
        Wed,  4 Sep 2019 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567637054;
        bh=xYAcO4QBGr30BVz/sHi/ubGoS3juMZ+3hMwu/Ru4De8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=LYX8ESvAgwBEWCIBUt6zYDAZy3TxPU2gu7jIE/jV0j4pNf3ZdBkKeGkVIh4ylZfrm
         C6JVUmxM7GpZLwXc5Hb8hGAUZ8K7K9eg6eLpHkhBkosEsPu2lgVbOfVe9UIvAC+U51
         QL7bkEADaLb60UfHrBG+wx7c91RTSgAQrRLV5RBk=
Subject: Re: next-20190903 kselftest results
To:     ci_notify@linaro.org, lkft-triage@lists.linaro.org,
        dan.rue@linaro.org, anders.roxell@linaro.org,
        naresh.kamboju@linaro.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <943338456.3594.1567519226589.JavaMail.javamailuser@localhost>
From:   shuah <shuah@kernel.org>
Message-ID: <34634351-ecff-4520-cbc0-8ab6a4412150@kernel.org>
Date:   Wed, 4 Sep 2019 16:44:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <943338456.3594.1567519226589.JavaMail.javamailuser@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/3/19 8:00 AM, ci_notify@linaro.org wrote:
> Summary
> ------------------------------------------------------------------------
> kernel: 5.3.0-rc7
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: 7dc4585e03786f84d6e9dc16caa3ba5b8b44d986
> git describe: next-20190903
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190903
> 
> Regressions (compared to build next-20190902)

Looks like you are running kselftest from 5.2 on this linux-next.
You won't be able to find any kselftest test regressions this way.
You aren't testing the kselftest patches that are in linux-next
for Linux 5.4-rc1.

It would be helpful if you match the kernel and kselftest for linux-next
and Linux mainline.

It will help find test bugs quicker that way.

thanks,
-- Shuah
