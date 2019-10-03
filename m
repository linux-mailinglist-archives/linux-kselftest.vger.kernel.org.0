Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD7C9684
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 03:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfJCBwm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 21:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfJCBwm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 21:52:42 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFEE222C0;
        Thu,  3 Oct 2019 01:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067561;
        bh=GYVW+168ZxlNiDr0PK2hJWCYxSab/8u193dsh8PS+Hg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=myrgDAT9Z2BLpNn1+v/lxT0l1O4goIP6amEl5Htna0AvDR1pa/TI7rOqSA/jXhWdn
         sssPszD3y3r3q64XrbWPqOMujdLeYwXbWd4FKALL8N2QrZuewvosR3H30uwgVi6iz4
         MBbb+xigWYsAIaJi0PzmiY4AHdlKxwLQspqsOyhQ=
Subject: Re: next-20191002 kselftest results
To:     ci_notify@linaro.org, lkft-triage@lists.linaro.org,
        dan.rue@linaro.org, anders.roxell@linaro.org,
        naresh.kamboju@linaro.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1018171707.4561.1570021237760.JavaMail.javamailuser@localhost>
From:   shuah <shuah@kernel.org>
Message-ID: <09618fd2-eb41-5a82-3fb4-4f4ca18bd075@kernel.org>
Date:   Wed, 2 Oct 2019 19:52:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1018171707.4561.1570021237760.JavaMail.javamailuser@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/2/19 7:00 AM, ci_notify@linaro.org wrote:
> Summary
> ------------------------------------------------------------------------
> kernel: 5.4.0-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: a32db7e1172439240202b843642465618498170d
> git describe: next-20191002
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002
> 
> Regressions (compared to build next-20191001)

This report is nice for quick glance of test pass/fail/skip dashboard.
I am finding very difficult to figure out why the test failed.

Can you please save the test run logs and stash them for access?

thanks,
-- Shuah

