Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66E46E0B2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjDMKNb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjDMKNJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 06:13:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABB9EF5;
        Thu, 13 Apr 2023 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681380755; x=1712916755;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/3k6r7D074PJRZk84hYx9S21xi/ERnExtP9WJloOvro=;
  b=KnfpTgpGWLIB714e3Eb0XZnLVpuPMd0QarydJl0hYb01okfCHH/M0EzC
   9fxyhyjB/iUeeVewrc3R9M+yccDnC7n38/Mo8Vmg/TPBzqGS+3zhgnAGs
   se+vzx87jliZaTGc+zWxXoDMgtCE8QSlkNIKKY1QFFfXPiwmOF+TjxuS3
   4rNVeazgy2nN05Vl6dT9sI7j5grsMQbgOo2M6lPYTB8KXB40W1shfKgxV
   MmQm4cRXWrFcl+8AeQmYgkeCLfsnoGyW6kw+ru+Zuq77VoxXihS9PRVBs
   R37b+cRZwUM17AwwyDuKrgsZNQExlmrEMmitD5gRZDOAtnQojMJmqrXyb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346827758"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="346827758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 03:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719785391"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="719785391"
Received: from pkudryav-mobl1.ger.corp.intel.com ([10.252.45.220])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 03:12:32 -0700
Date:   Thu, 13 Apr 2023 13:12:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org
cc:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 22/22] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
In-Reply-To: <20230412132122.29452-23-ilpo.jarvinen@linux.intel.com>
Message-ID: <9912c0bd-f1c8-1f27-17a0-2a3d48279e75@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com> <20230412132122.29452-23-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1640494227-1681380754=:1987"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1640494227-1681380754=:1987
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 12 Apr 2023, Ilpo Järvinen wrote:

> Rewrite the CAT test to allocated a buffer sized to half of LLC. Then
> perform a sequence of tests with different LLC block sizes starting
> from 1-bit CBM to half of the CBM bits. Flush the buffer before each
> test and read the buffer twice. Observe the LLC misses on the second
> read through the buffer. As the allocated LLC block gets larger and
> larger, the LLC misses will become smaller and smaller giving a strong
> signal on CAT working properly.

I realized this description is now wrong way around as I at one point 
reversed the cache allocation mask to go from half of CBM bits to 1-bit 
but didn't remember to update the changelog (in case somebody ends up 
wondering why it doesn't match to what the code does). V2 will contain the 
correct way around description.


-- 
 i.

--8323329-1640494227-1681380754=:1987--
