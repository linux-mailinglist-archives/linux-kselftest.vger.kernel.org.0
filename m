Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE043EE545
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Aug 2021 06:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhHQEEd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Aug 2021 00:04:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:4471 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhHQEEb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Aug 2021 00:04:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="196252752"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="196252752"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 21:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="505156435"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2021 21:03:58 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 21:03:57 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 12:03:50 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2242.010;
 Tue, 17 Aug 2021 12:03:50 +0800
From:   "Ma, XinjianX" <xinjianx.ma@intel.com>
To:     "legion@kernel.org" <legion@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     lkp <lkp@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of ucounts
Thread-Topic: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of ucounts
Thread-Index: AQHXkxd6jQPRg5rF3UWHcji9NSI54Q==
Date:   Tue, 17 Aug 2021 04:03:50 +0000
Message-ID: <d650b7794e264d5f8aa107644cc9784f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alexey,

When lkp team run kernel selftests, we found after these series of patches, testcase mqueue: mq_perf_tests
in kselftest failed with following message. 

If you confirm and fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot lkp@intel.com

```
# selftests: mqueue: mq_perf_tests
#
# Initial system state:
#       Using queue path:                       /mq_perf_tests
#       RLIMIT_MSGQUEUE(soft):                  819200
#       RLIMIT_MSGQUEUE(hard):                  819200
#       Maximum Message Size:                   8192
#       Maximum Queue Size:                     10
#       Nice value:                             0
#
# Adjusted system state for testing:
#       RLIMIT_MSGQUEUE(soft):                  (unlimited)
#       RLIMIT_MSGQUEUE(hard):                  (unlimited)
#       Maximum Message Size:                   16777216
#       Maximum Queue Size:                     65530
#       Nice value:                             -20
#       Continuous mode:                        (disabled)
#       CPUs to pin:                            3
# ./mq_perf_tests: mq_open() at 296: Too many open files
not ok 2 selftests: mqueue: mq_perf_tests # exit=1
```    

Test env:
rootfs: debian-10
gcc version: 9

------
Thanks 
Ma Xinjian
