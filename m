Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB741317F4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2020 19:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgAFS4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jan 2020 13:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgAFS4k (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jan 2020 13:56:40 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1310B2072A;
        Mon,  6 Jan 2020 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578336999;
        bh=B/kWhHx1btx8ugLNBM9UY7cdDolaEByVRoHh+OX9Nx4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wFB5cCk6ZBpaS/EqqKbo5pIKR+rsp94ZcY9zSFOsbabe5bOQG+RPLOjinJj9CYhfV
         zGVAr6t+miSuHWR62tfbt/nFiaAwYJuehtQup86EKEFGyMfGOoWEStJnsT45bwEcEe
         +VnUJX0LWJM/pNqWLI5ivdY70s4gznekvt1E2byc=
Subject: Re: [PATCH v6 linux-kselftest-test 3/6] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, davidgow@google.com, adilger.kernel@dilger.ca,
        tytso@mit.edu, mcgrof@kernel.org, linux-doc@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>, shuah <shuah@kernel.org>
References: <1575473234-5443-4-git-send-email-alan.maguire@oracle.com>
 <201912190658.JKOfMs2i%lkp@intel.com>
 <alpine.LRH.2.20.1912191424440.27984@dhcp-10-175-218-218.vpn.oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <5671f077-d2ed-2e26-7588-29d1e4b8123e@kernel.org>
Date:   Mon, 6 Jan 2020 11:56:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1912191424440.27984@dhcp-10-175-218-218.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/19/19 7:28 AM, Alan Maguire wrote:
> On Thu, 19 Dec 2019, kbuild test robot wrote:
> 
>> Hi Alan,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on linux/master v5.5-rc2 next-20191218]
>> [cannot apply to ext4/dev]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Alan-Maguire/kunit-support-building-core-tests-as-modules/20191207-021244
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b0d4beaa5a4b7d31070c41c2e50740304a3f1138
>> config: x86_64-randconfig-e002-20191218 (attached as .config)
>> compiler: gcc-7 (Debian 7.5.0-1) 7.5.0
>> reproduce:
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/base/power/qos-test.c:117:1: warning: data definition has no type or storage class
>>      kunit_test_suite(pm_qos_test_module);
>>      ^~~~~~~~~~~~~~~~
> 
> I hadn't thought about the possibility that other trees
> would have added kunit tests in the interim; it probably
> makes most sense to not retire the kunit_test_suite()
> definition (it can be trivially defined via kunit_test_suites().
> Converting the test suite isn't an option as it's not in
> the kselftest-test tree.
> 
> I'll spin up a v7 patchset with that 1-line change to patch 3
> as I don't _think_ these changes have been pulled in yet.
> 


Alan,

Please do send v7. I will pull it for 5.6.

thanks,
-- Shuah
