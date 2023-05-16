Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5619705A93
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 00:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjEPWaz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 18:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPWaw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 18:30:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C115FC2;
        Tue, 16 May 2023 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684276251; x=1715812251;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VJlRw0cVqZbnlLBS7pOMQzrAmvHSD2FA3uV2tmyOarg=;
  b=EGv1iCEWPpOvVmE+mWWEGj195JHeSihmkISqN7kGMp2t5fE2+hAnZ33B
   Kk+plVe4bcuDT+EnkY1JOebCKJAYH0m3FNuj5XcuEVtI8Doh0wU3GHRx9
   OI8J+/e73JQrwUK5fBnnV3dBIvw9uw1poPE534SKb7iwgouN4oQdSge9T
   SYhI9E321nPhwVbj/+m3kQACosW5J8IEzGYvOlGXJzOrDG2+/2jYa8XMK
   GrQQV9vaJEbtdunersvTIqLHQXr3k5Hhw6zm5ByEkG16JtPjLgkAq+j/4
   +ZLHBd+GSzV24cdm8y7VON/Hkw/C3dKmsfKarB+PAv3XdHe+YXjj7M2Vi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="340986803"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="340986803"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:30:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="695636016"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="695636016"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:30:50 -0700
Message-ID: <1656e926-f277-710e-71ad-1ff2fe77886b@intel.com>
Date:   Tue, 16 May 2023 15:30:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        groeck@chromium.org, jannh@google.com, sroettger@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <202305161307.4A16BB6A47@keescook>
 <CALmYWFteCd+h+tn+LmgTpN9Ld5=qAMMQ34=b1KCoE3OSBun+DQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CALmYWFteCd+h+tn+LmgTpN9Ld5=qAMMQ34=b1KCoE3OSBun+DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/16/23 15:17, Jeff Xu wrote:
>>> This set of patch covers mprotect/munmap, I plan to work on other
>>> syscalls after this.
>> Which ones are on your list currently?
>>
> mprotect/mprotect_pkey/munmap
> mmap/mremap
> madvice,brk,sbrk

What about pkey_free()?

Without that, someone can presumably free the pkey and then reallocate
it without PKEY_ENFORCE_API.


