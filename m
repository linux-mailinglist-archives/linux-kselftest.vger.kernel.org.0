Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A211B39E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVIS3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 04:18:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:61437 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgDVIS3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 04:18:29 -0400
IronPort-SDR: 4ojm2U4Ac5MjOif0DneeF2aRP5AApzlmOvc0NyUg2bPUT0s0j5O/hW8MQDbMJEMNJ7d9zX77AW
 njbMisp9bqAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 01:18:28 -0700
IronPort-SDR: zBoNKmqvOHMEH6r9B/FHhDN/Wcdo1P1Rhs1Lcy0TKntv2kXPe6FH64TBgDnyjRi1LI+rfphMT8
 Ph0Xc4dtqnCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,413,1580803200"; 
   d="scan'208";a="456419707"
Received: from mengjiew-mobl.ccr.corp.intel.com (HELO [10.255.31.36]) ([10.255.31.36])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2020 01:18:27 -0700
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kselftest@vger.kernel.org
From:   Liu Yiding <yidingx.liu@intel.com>
Subject: selftests/openat2: subtests "openat2 with valid how.mode and
 O_TMPFILE" failed
Message-ID: <8c04b687-db6c-3cb0-a559-1b44883eecaa@intel.com>
Date:   Wed, 22 Apr 2020 16:18:07 +0800
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

Hi, Aleksa.


I met error "Operation not supported" when i ran selftests/openat2

```

# openat2 unexpectedly returned # -95 (Operation not supported)
not ok 106 openat2 with valid how.mode and O_TMPFILE succeeds

```

Is there any limits to run selftests/openat2?


Some info of my testing env.

```

root@vm-snb-79 ~# df -h 
/usr/src/linux-selftests-x86_64-rhel-7.6-7111951b8d4973bda27ff663f2cf18b663d15b48/tools/testing/selftests/openat2 

Filesystem      Size  Used Avail Use% Mounted on
none               0     0     0    - /
root@vm-snb-79 ~# uname -r
5.6.0-00335-g7111951b8d497

```


-- 
Best regards.
Liu Yiding

