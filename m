Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41E158435
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 21:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgBJUXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 15:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgBJUXY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 15:23:24 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2270C20838;
        Mon, 10 Feb 2020 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581366203;
        bh=btnofd/k+jH3nX/rejupwEnRoAy92mLvJNzRBam4i08=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=xLfMkfDjZaza/wEwkusARSsJyuP4zMbsFKmEcdvmvvsJbnOhPLggr1c6z1wSUK8D5
         Je+GSCKNeG9hmtbLNkMkTa8YhZe3+eSNRJjY4y+EtsUZKo197qO/GhEq9YiY24AZmC
         5iNvIJLkBgncsy3XEc5ZD6b5yNGP3PBW0uiyoLVQ=
Subject: Re: [RESEND PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
To:     Fenghua Yu <fenghua.yu@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, shuah <shuah@kernel.org>
References: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <72bbb370-9880-2de8-3c50-967bbc3aab10@kernel.org>
Date:   Mon, 10 Feb 2020 13:22:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579210366-55429-1-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/16/20 2:32 PM, Fenghua Yu wrote:
> [Resend the v9 patch set to Shuah Khan and linux-kselftest mailing list.
> No code and commit message change.]
> 
> With more and more resctrl features are being added by Intel, AMD
> and ARM, a test tool is becoming more and more useful to validate
> that both hardware and software functionalities work as expected.
> 
> We introduce resctrl selftest to cover resctrl features on X86, AMD
> and ARM architectures. It first implements MBM (Memory Bandwidth
> Monitoring), MBA (Memory Bandwidth Allocation), L3 CAT (Cache Allocation
> Technology), and CQM (Cache QoS Monitoring)  tests. We will enhance
> the selftest tool to include more functionality tests in the future.
> 
> The tool has been tested on Intel RDT, AMD QoS and ARM MPAM and is
> in tools/testing/selftests/resctrl in order to have generic test code
> base for all architectures.
> 
> The selftest tool we are introducing here provides a convenient
> tool which does automatic resctrl testing, is easily available in kernel
> tree, and covers Intel RDT, AMD QoS and ARM MPAM.
> 
> There is an existing resctrl test suite 'intel_cmt_cat'. But its major
> purpose is to test Intel RDT hardware via writing and reading MSR
> registers. It does access resctrl file system; but the functionalities
> are very limited. And it doesn't support automatic test and a lot of
> manual verifications are involved.

Thanks for the series. Sorry for the delay in getting back to you.
I will pull these in for 5.7.

Couple of global comments and things to watch out for:

- Are there checks to prevent this tool from compiling/running
on architectures that don't support and/or exits gracefully?

I didn't see arch checks in the Makefile.

I am pulling them in and these can be fixed later.

Sorry for the delay.

thanks,
-- Shuah
