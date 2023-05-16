Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A457F705B35
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 01:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjEPXTR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjEPXTM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 19:19:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96749CC;
        Tue, 16 May 2023 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684279138; x=1715815138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aTTXi21fx3EQBbKsXrlszRhCxMf11Htc3j/PZEduJLo=;
  b=GZXmWHOIkZF+X7U4QaVswU1y/ExSRLC0cMxKDjJRQZW6uyKXW8fT95Gm
   bgBH04q2HQKwbndbpskD68U88bonOPbG3Ve34S6zaLpF5qcjQ0g7S1JhD
   OESu5wL2+y1BscJPJlzmbLgHHylf9x2pptVtK86frajI7mVudWaCeq90Z
   8eOT1rVOkXQzLOu0g8qTf2ELPL6bwZILpAZ6XtbGTxo7Q1xbOkUCCbwij
   ty0gn8ZBrOGtXs1GTVoGAVKlRA79lrNJ0s0+G7MWy6rJZEnubq3RF5RDa
   nFbInCWsApPlIyg91q0UChFOrtIDcNmKdBlUccMcSggLF5cOUgxh/kSfg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="417270309"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="417270309"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="791257808"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="791257808"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:18:57 -0700
Message-ID: <78bb0097-7dca-254f-45a6-5cea6baec0c4@intel.com>
Date:   Tue, 16 May 2023 16:18:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
Content-Language: en-US
To:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-4-jeffxu@chromium.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230515130553.2311248-4-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 06:05, jeffxu@chromium.org wrote:
>  /*
>   * pkey==-1 when doing a legacy mprotect()
> + * syscall==true if this is called by syscall from userspace.
> + * Note: this is always true for now, added as a reminder in case that
> + * do_mprotect_pkey is called directly by kernel in the future.
> + * Also it is consistent with __do_munmap().
>   */
>  static int do_mprotect_pkey(unsigned long start, size_t len,
> -		unsigned long prot, int pkey)
> +		unsigned long prot, int pkey, bool syscall)
>  {

The 'syscall' seems kinda silly (and a bit confusing).  It's easy to
check if the caller is a kthread or has a current->mm==NULL.  If you
*really* want a warning, I'd check for those rather than plumb a
apparently unused argument in here.

BTW, this warning is one of those things that will probably cause some
amount of angst.  I'd move it to the end of the series or just axe it
completely.
