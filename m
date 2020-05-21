Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3A1DC6BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 07:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgEUF5U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 01:57:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:44560 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgEUF5U (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 01:57:20 -0400
IronPort-SDR: uF84ioNlIZgshe0Bv/Gn3XR3PbjfbgMoOOhdMFlbvY6T5YVOyHMtBI5j71FPj9rR6SXTOIc4I3
 HD/Hg0xLszVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 22:57:19 -0700
IronPort-SDR: sEkqRBqtQIV3FmcWI9c8d0l2164R5MraC8fKxDxbI2r2tSdqXW1+t9UhNRdIgnFCxWRMFfDo6o
 rAO1ik3xs1hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="300188560"
Received: from jsong19-mobl.ccr.corp.intel.com (HELO [10.255.29.96]) ([10.255.29.96])
  by fmsmga002.fm.intel.com with ESMTP; 20 May 2020 22:57:18 -0700
From:   kernel test robot <yidingx.liu@intel.com>
Subject: Kunit get 0 tests when run defconfig in Debian9
To:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Cc:     "Li, Philip" <philip.li@intel.com>
Message-ID: <ef994ce9-ccd8-e9c9-9838-049a62a3a561@intel.com>
Date:   Thu, 21 May 2020 13:56:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, all.


I met a strange problem that kunit run 0 tests in Debian9.


Env:

```

root@lkp-hsw-ep4 ~/linus# head /etc/os-release
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
NAME="Debian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
ID=debian

root@lkp-hsw-ep4 ~/linus# uname -r
5.6.0

```


Reproduce: Just run `./tools/testing/kunit/kunit.py run --defconfig`

```

root@lkp-hsw-ep4 ~/linus# ./tools/testing/kunit/kunit.py run --defconfig
[13:41:30] Building KUnit Kernel ...
[13:41:33] Starting KUnit Kernel ...
[13:41:33] ============================================================
[13:41:33] Testing complete. 0 tests run. 0 failed. 0 crashed.
[13:41:33] Elapsed time: 2.619s total, 0.002s configuring, 2.610s 
building, 0.007s running

root@lkp-hsw-ep4 ~/linus# cat .kunitconfig
CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y

```


As doc said, looks like everything worked correctly.  But kunit run 0 tests.

```

If everything worked correctly, you should see the following:

Generating .config ...
Building KUnit Kernel ...
Starting KUnit Kernel ...

```



-- 
Best regards.
Liu Yiding

