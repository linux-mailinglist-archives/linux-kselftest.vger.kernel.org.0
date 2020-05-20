Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00BE1DC339
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 01:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgETXwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 May 2020 19:52:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:7191 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgETXwZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 May 2020 19:52:25 -0400
IronPort-SDR: Z0OHpkZSdpYyoloUOBWjd2lLuuluSodW1Sj180mNM1mOqdzX+SoPHZXSggZZVSOTpgLfpYCIDu
 qOFl8QY+AesA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 16:52:24 -0700
IronPort-SDR: xpF4PiG3axVKtDZYRKKMLejzJSpR9BJujWHEG8SbgnNg6u+WKKtRkip4QRe0jw3QJsvTsZWbIK
 HPFKKdOsBsVQ==
X-IronPort-AV: E=Sophos;i="5.73,415,1583222400"; 
   d="scan'208";a="268436707"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.101.53]) ([10.254.101.53])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 16:52:23 -0700
Subject: Re: [PATCH V2 15/19] selftests/resctrl: Change return type of
 umount_resctrlfs() to void
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel, dan.carpenter@oracle.com,
        dcb314@hotmail.com
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
 <3c00e744acbfa67a1988638f1718cd67382a6f59.1589835155.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5703181d-832b-27c1-4b32-241f5cc868fd@intel.com>
Date:   Wed, 20 May 2020 16:52:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3c00e744acbfa67a1988638f1718cd67382a6f59.1589835155.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 5/18/2020 3:08 PM, Sai Praneeth Prakhya wrote:
> umount_resctrlfs() is used only during tear down path and there is nothing
> much to do if unmount of resctrl file system fails, so, all the callers of
> this function are not checking for the return value. Hence, change the
> return type of this function from int to void.

Should the callers be ignoring the return value? From what I can tell
the filesystem is unmounted between test runs so I wonder if it may help
if the return code is used and the test exits with an appropriate error
to user space for possible investigation instead of attempting to run a
new test on top of the resctrl filesystem that could potentially be
having issues at the time.

Reinette
