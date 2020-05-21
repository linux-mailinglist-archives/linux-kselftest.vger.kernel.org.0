Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA51DD2DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgEUQM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 12:12:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:17713 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgEUQM2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 12:12:28 -0400
IronPort-SDR: biol4xyfpVuLWxfGGjbELmFVUWEy9eJ0tgG6cUuODxVe+dP5vtofhK9ZIDpWAbfrLuz6AqO1I7
 E4EogdAjb94A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:12:28 -0700
IronPort-SDR: LWLf3MShLYs2YLg0NTxtzEz/O6GeAzCRLR2giotr4PTlz89esfcg+EQJQzlIvm3RU04NWbj+In
 /G1zrBPCMcNw==
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="289789281"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.101.239]) ([10.254.101.239])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:12:27 -0700
Subject: Re: [PATCH V2 00/19] Miscellaneous fixes for resctrl selftests
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@oracle.com,
        dcb314@hotmail.com
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3669988f-2a76-c698-dd95-7972056353cb@intel.com>
Date:   Thu, 21 May 2020 09:12:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 5/18/2020 3:08 PM, Sai Praneeth Prakhya wrote:
> Fenghua Yu (1):
>   selftests/resctrl: Fix missing options "-n" and "-p"
> 
> Reinette Chatre (3):
>   selftests/resctrl: Fix typo
>   selftests/resctrl: Fix typo in help text
>   selftests/resctrl: Ensure sibling CPU is not same as original CPU
> 
> Sai Praneeth Prakhya (15):
>   selftests/resctrl: Rename CQM test as CMT test
>   selftests/resctrl: Declare global variables as extern
>   selftests/resctrl: Return if resctrl file system is not supported
>   selftests/resctrl: Check for resctrl mount point only if resctrl FS is
>     supported
>   selftests/resctrl: Use resctrl/info for feature detection
>   selftests/resctrl: Fix MBA/MBM results reporting format
>   selftests/resctrl: Abort running tests if not root user
>   selftests/resctrl: Enable gcc checks to detect buffer overflows
>   selftests/resctrl: Dynamically select buffer size for CAT test
>   selftests/resctrl: Skip the test if requested resctrl feature is not
>     supported
>   selftests/resctrl: Change return type of umount_resctrlfs() to void
>   selftests/resctrl: Umount resctrl FS only if mounted
>   selftests/resctrl: Unmount resctrl FS after running all tests
>   selftests/resctrl: Fix incorrect parsing of iMC counters
>   selftests/resctrl: Fix checking for < 0 for unsigned values
> 
>  tools/testing/selftests/resctrl/Makefile      |  2 +-
>  tools/testing/selftests/resctrl/README        |  4 +-
>  tools/testing/selftests/resctrl/cache.c       |  4 +-
>  tools/testing/selftests/resctrl/cat_test.c    |  8 +-
>  .../resctrl/{cqm_test.c => cmt_test.c}        | 23 +++---
>  tools/testing/selftests/resctrl/mba_test.c    | 23 +++---
>  tools/testing/selftests/resctrl/mbm_test.c    | 16 ++--
>  tools/testing/selftests/resctrl/resctrl.h     | 20 +++--
>  .../testing/selftests/resctrl/resctrl_tests.c | 69 ++++++++++++-----
>  tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++------
>  tools/testing/selftests/resctrl/resctrlfs.c   | 77 +++++++++++++------
>  11 files changed, 195 insertions(+), 118 deletions(-)
>  rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (88%)
> 

Thank you very much for creating these fixes. There are a few to which I
responded directly, the rest look good to me.

Reinette
