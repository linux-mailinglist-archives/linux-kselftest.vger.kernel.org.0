Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50DB705AB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 00:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjEPWln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPWlm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 18:41:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062AC7688;
        Tue, 16 May 2023 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684276901; x=1715812901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IDhBF4fgjJGRK2kGvqetdUuW5dTqUG9nUhpZg9K0OCo=;
  b=EyeYxWO9vH3wtSkq7AqI4AtjGmN7pjq8oIiTewXUFQZYljmAyMITAY9M
   SepucNT+TiS2Q04y6ajTv/p46syN3auOru5gqEQDW9wlO79FfkSBIV8aD
   fqIhRbWhe3SHRpPSmqrPB9/6nCNxxPVuOxjO72vDUBDdwrldKkLLmSDme
   1J7GmEitfpa9U0bQUB9qnmKszw7Qafko6/CzcdroKNvZSHkDwM+Qyh3pf
   fncOZgFN5HQzx4+KHl3jROTVesq20n841/qR9h9IV9RxvBNfD9k2rAyw+
   QAgBd+ovSlfQz107TpHaEXj/XQ9D70AgMpmo6s2P6wHxHGkF3Wb/gAcFK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="350447269"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="350447269"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="766534490"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="766534490"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 15:41:40 -0700
Message-ID: <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
Date:   Tue, 16 May 2023 15:41:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Content-Language: en-US
To:     =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>
Cc:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/16/23 00:06, Stephen Röttger wrote:
> On Mon, May 15, 2023 at 4:28 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 5/15/23 06:05, jeffxu@chromium.org wrote:
>>> We're using PKU for in-process isolation to enforce control-flow integrity
>>> for a JIT compiler. In our threat model, an attacker exploits a
>>> vulnerability and has arbitrary read/write access to the whole process
>>> space concurrently to other threads being executed. This attacker can
>>> manipulate some arguments to syscalls from some threads.
>>
>> This all sounds like it hinges on the contents of PKRU in the attacker
>> thread.
>>
>> Could you talk a bit about how the attacker is prevented from running
>> WRPKRU, XRSTOR or compelling the kernel to write to PKRU like at sigreturn?
> 
> (resending without html)
> 
> Since we're using the feature for control-flow integrity, we assume
> the control-flow is still intact at this point. I.e. the attacker
> thread can't run arbitrary instructions.

Can't run arbitrary instructions, but can make (pretty) arbitrary syscalls?

> * For JIT code, we're going to scan it for wrpkru instructions before
> writing it to executable memory

... and XRSTOR, right?

> * For regular code, we only use wrpkru around short critical sections
> to temporarily enable write access
> 
> Sigreturn is a separate problem that we hope to solve by adding pkey
> support to sigaltstack

What kind of support were you planning to add?

I was thinking that an attacker with arbitrary write access would wait
until PKRU was on the userspace stack and *JUST* before the kernel
sigreturn code restores it to write a malicious value.  It could
presumably do this with some asynchronous mechanism so that even if
there was only one attacker thread, it could change its own value.

Also, the kernel side respect for PKRU is ... well ... rather weak.
It's a best effort and if we *happen* to be in a kernel context where
PKRU is relevant, we can try to respect PKRU.  But there are a whole
bunch of things like get_user_pages_remote() that just plain don't have
PKRU available and can't respect it at all.

I think io_uring also greatly expanded how common "remote" access to
process memory is.

So, overall, I'm thrilled to see another potential user for pkeys.  It
sounds like there's an actual user lined up here, which would be
wonderful.  But, I also want to make sure we don't go to the trouble to
build something that doesn't actually present meaningful, durable
obstacles to an attacker.

I also haven't more than glanced at the code.
