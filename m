Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEF708C91
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 02:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjESAAE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 20:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjESAAE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 20:00:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFAEA;
        Thu, 18 May 2023 17:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454403; x=1715990403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5t/LbPMDhw3OuvazmSL5YCXrk6Z1rz2sQn9LegvfpFw=;
  b=OqZQrbWcEh7sjE/ph87CEn3UDaDnG9jWwgtLprotujV3EaKyHxTwQI2y
   ZQ04cv6qXXRGmuoARpBynnNLo/9fy0gOOEr35gy/7noN27UlfVy20lOP1
   1Lc9eRXJdxfaxaImgFZ9owa/3KEh9TsdMdTZTks5SIBut4BO6h8Y9lEeS
   cvDFMstPX8Rc3ZTeb8Avd2pgnBFFMIitqD/45ID5nEDxLTAz2I9q1JYaY
   u1myV+OXd64fCFWSdC0nQdY9n9d84mj/Vpckzdk+67kdjAr55d628qb+P
   L+X3DLr4N4V9EkqUnn049NGRxhnPun9i0InuIs0Bh+oKXgKD2Xlyp6DCI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="352246432"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="352246432"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="792144716"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="792144716"
Received: from mkim1-mobl.amr.corp.intel.com (HELO [10.209.118.171]) ([10.209.118.171])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:00:02 -0700
Message-ID: <c53c03e8-529f-5b72-42ab-f32f50aaab35@intel.com>
Date:   Thu, 18 May 2023 17:00:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] PKEY: Add arch_check_pkey_enforce_api()
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-3-jeffxu@chromium.org>
 <6dbbc3da-78c9-8101-d52a-0be47da9d67e@intel.com>
 <CALmYWFtu-WzOTEs2aWU3zMW=KZUjaaL7OTE7hQtHjfwQfQNyEA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CALmYWFtu-WzOTEs2aWU3zMW=KZUjaaL7OTE7hQtHjfwQfQNyEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/18/23 15:51, Jeff Xu wrote:
>> Do you have a solid handle on all call paths that will reach
>> __arch_check_vma_pkey_for_write() and can you ensure they are all
>> non-remote?
> Is this about the attack scenario where the attacker uses ptrace()
> into the chrome process ? if so it is not in our threat model, and
> that is more related to sandboxing on the host.

The attacker would use *some* remote interface.  ptrace() is just one of
those remote interfaces.

> Or is this about io_uring? Yes, io_uring kernel thread breaks our
> expectations of PKRU & user space threads, however I thought the break
> is not just for this - any syscall involved in memory operation will
> break after into io_uring ?

I'm not quite following.

Please just do me a favor: have the io_uring maintainers look at your
proposal.  Make sure that the defenses you are building can work in a
process where io_uring is in use by the benign threads.

Those same folks are pretty familiar with the other, more traditional
I/O syscalls that have in-memory descriptors that control syscall
behavior like readv/writev.  Those also need a close look.

> Other than those, yes, I try to ensure the check is only used at the
> beginning of syscall entry in all cases, which should be non-remote I
> hope.

You're right that synchronous, shallow syscall paths are usually
non-remote.  But those aren't the problem.  The problem is that there
*ARE* remote accesses and those are a potential hole for this whole
mechanism.

Can they be closed?  I don't know.  I honestly don't have a great grasp
on how widespread these things are.  You'll need a much more complete
grasp on them than I have before this thing can go forward.
