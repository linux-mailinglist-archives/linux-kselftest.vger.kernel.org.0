Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154A01E3526
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 03:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgE0B7l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 21:59:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:29879 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0B7k (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 21:59:40 -0400
IronPort-SDR: wA2BNaJSssGESzD44hpBBW4df+gdxupR20JwVR4VDlhm2aw1YQLDRpxIJrc37o6DbeOL6NXr4I
 lGi+kGtNUM9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 18:59:38 -0700
IronPort-SDR: SJWcPiSssmwrrJnZdtDB1lDCQcqd2t+PTvKrRXAG6wZ0vYr8gjRgo8QnUzsXmcFWh55T4cFIaM
 SyTG4+Vpww6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="310433119"
Received: from xyang31-mobl.ccr.corp.intel.com (HELO [10.255.31.210]) ([10.255.31.210])
  by FMSMGA003.fm.intel.com with ESMTP; 26 May 2020 18:59:37 -0700
Subject: Re: Kunit get 0 tests when run defconfig in Debian9
To:     David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <ef994ce9-ccd8-e9c9-9838-049a62a3a561@intel.com>
 <CABVgOSnj6H5UXNGktT2NAHPF1KxAu5=Mg0hyuBu+NpjAdh+Q4A@mail.gmail.com>
From:   Liu Yiding <yidingx.liu@intel.com>
Message-ID: <41db8bbd-3ba0-8bde-7352-083bf4b947ff@intel.com>
Date:   Wed, 27 May 2020 09:59:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSnj6H5UXNGktT2NAHPF1KxAu5=Mg0hyuBu+NpjAdh+Q4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David.


Sorry for the delay and really appericated for your help !!!

On 5/22/20 10:33 AM, David Gow wrote:
> A few questions/suggestions:
> - Are there any test results visible when running
> ./tools/testing/kunit/kunit.py run --raw_output  (older versions of
> the KUnit parser may not work well if the kernel log is decorated,
> e.g. with timestamps, etc — this should be largely fixed for 5.7).


--raw_output is really helpful.

The root cause of missing tests is that tempdir doesn't exist.

I create that file and kunit runs well now. :-P

```

root@vm-snb-195 ~/linus# ./tools/testing/kunit/kunit.py run --raw_output 
--defconfig
Generating .config ...
[09:35:37] Building KUnit Kernel ...
arch/um/os-Linux/signal.c: In function ‘sig_handler_common’:
arch/um/os-Linux/signal.c:51:1: warning: the frame size of 2960 bytes is 
larger than 2048 bytes [-Wframe-larger-than=]
  }
  ^
arch/um/os-Linux/signal.c: In function ‘timer_real_alarm_handler’:
arch/um/os-Linux/signal.c:95:1: warning: the frame size of 2960 bytes is 
larger than 2048 bytes [-Wframe-larger-than=]
  }
  ^
[09:39:48] Starting KUnit Kernel ...
Core dump limits :

     soft - 0

     hard - 0

Checking that ptrace can change system call numbers...OK

Checking syscall emulation patch for ptrace...OK

Checking advanced syscall emulation patch for ptrace...OK

Checking environment variables for a tempdir.../lkp/lkp/src/tmp

Checking if /lkp/lkp/src/tmp is on tmpfs...No such file or directory

Warning: tempdir /lkp/lkp/src/tmp is not on tmpfs

[09:39:48] Elapsed time: 257.808s total, 6.515s configuring, 251.274s 
building, 0.018s running

```

-- 
Best regards.
Liu Yiding

