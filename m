Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749B1706CE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjEQPcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEQPcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 11:32:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73A5A5C6;
        Wed, 17 May 2023 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684337488; x=1715873488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s7w7liuVQK6OILCFceYzFS73/MrLg8U8eXJ3628P3TM=;
  b=oDe4Q3O/gq9qyielJx7TYnzEIPkGcm6qtYwenQBd6n7YLgzA8M+Dfaqv
   Ov/MEl30m1XUjcoHwI7CYYg9AW6yljgSMyL8tx1otenpLYhFILHkA+1R1
   5b8Z+hgYAkO1yKPOtPLUxIvGsCIrto82xC3PFAQ+8O04qn5cxtm66CaNX
   AohGwjXOwYhMFp3nU4sPuAiYfH9smv46gzCMxQzTKtoYkzR8aUtW3PN75
   y1T52Ih4Tgc9vQ+EQ6X2sR1QE7nVsoaC/l1JvUYv86Ff3TgK3u0blu/Nl
   ELAsfTvH6pZDbg+xS5bOMt3F07ql7jViJDTvyZcX9axG5gOCN2JjfHIaJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349294763"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="349294763"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 08:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="695907865"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="695907865"
Received: from cbrown-mobl1.amr.corp.intel.com (HELO [10.212.129.207]) ([10.212.129.207])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 08:29:47 -0700
Message-ID: <b69f6809-b483-158f-8be9-4976fad918d8@intel.com>
Date:   Wed, 17 May 2023 08:29:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>,
        jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
 <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com>
 <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/17/23 08:21, Jeff Xu wrote:
>>> I’m not sure I follow the details, can you give an example of an asynchronous
>>> mechanism to do this? E.g. would this be the kernel writing to the memory in a
>>> syscall for example?
>> I was thinking of all of the IORING_OP_*'s that can write to memory or
>> aio(7).
> IORING is challenging from security perspectives, for now, it is 
> disabled in ChromeOS. Though I'm not sure how aio is related ?

Let's say you're the attacking thread and you're the *only* attacking
thread.  You have three things at your disposal:

 1. A benign thread doing aio_read()
 2. An arbitrary write primitive
 3. You can send signals to yourself
 4. You can calculate where your signal stack will be

You calculate the address of PKRU on the future signal stack.  You then
leverage the otherwise benign aio_write() to write a 0 to that PKRU
location.  Then, send a signal to yourself.  The attacker's PKRU value
will be written to the stack.  If you can time it right, the AIO will
complete while the signal handler is in progress and PKRU is on the
stack.  On sigreturn, the kernel restores the aio_read()-placed,
attacker-provided PKRU value.  Now the attacker has PKRU==0.  It
effectively build a WRPKRU primitive out of those other pieces.


