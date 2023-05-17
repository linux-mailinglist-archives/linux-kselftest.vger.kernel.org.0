Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE245706C37
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjEQPIh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjEQPIg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 11:08:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524D88A7D;
        Wed, 17 May 2023 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684336088; x=1715872088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m3M2b/UpB2Fp67mqL0iGGBx6gX63ZHkbp9fZFhoFbDc=;
  b=LNktfhyb5vDqIPrqV7/yvy2WlB865lqQnQZHhYPQWj/67OArkLyXzWMK
   StJ5rhDaIBFFL8BehlI5pC4FsgqlZ70NoKwczxnYzsTT/zlzvC8B2PfZ+
   LHv3wmRf5qhtZn6w8gSKazCdL2UWa7cgcKkweqhs+r10OhobZfZeGiURa
   F3r6XB6hjqs4ZFq0tPa9vGCXOKnySo8GR315xpApPrCALnhwW+XY70lPp
   dJ/9Ct9i5by0rgG5b2i297EZ9R5vUvWz3u8/az3LRAr52Lr+XwanlybU5
   JoUCE26iayD3RC8EjFGgD5FEjPQR28JMqcguPGTEVzae5Fp5hjbQdDsdq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="354083128"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="354083128"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 08:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652277994"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="652277994"
Received: from cbrown-mobl1.amr.corp.intel.com (HELO [10.212.129.207]) ([10.212.129.207])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 08:07:07 -0700
Message-ID: <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com>
Date:   Wed, 17 May 2023 08:07:07 -0700
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
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
 <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/17/23 03:51, Stephen Röttger wrote:
> On Wed, May 17, 2023 at 12:41 AM Dave Hansen <dave.hansen@intel.com> wrote:
>> Can't run arbitrary instructions, but can make (pretty) arbitrary syscalls?
> 
> The threat model is that the attacker has arbitrary read/write, while other
> threads run in parallel. So whenever a regular thread performs a syscall and
> takes a syscall argument from memory, we assume that argument can be attacker
> controlled.
> Unfortunately, the line is a bit blurry which syscalls / syscall arguments we
> need to assume to be attacker controlled. 

Ahh, OK.  So, it's not that the *attacker* can make arbitrary syscalls.
It's that the attacker might leverage its arbitrary write to trick a
victim thread into turning what would otherwise be a good syscall into a
bad one with attacker-controlled content.

I guess that makes the readv/writev-style of things a bad idea in this
environment.

>>> Sigreturn is a separate problem that we hope to solve by adding pkey
>>> support to sigaltstack
>>
>> What kind of support were you planning to add?
> 
> We’d like to allow registering pkey-tagged memory as a sigaltstack. This would
> allow the signal handler to run isolated from other threads. Right now, the
> main reason this doesn’t work is that the kernel would need to change the pkru
> state before storing the register state on the stack.
> 
>> I was thinking that an attacker with arbitrary write access would wait
>> until PKRU was on the userspace stack and *JUST* before the kernel
>> sigreturn code restores it to write a malicious value.  It could
>> presumably do this with some asynchronous mechanism so that even if
>> there was only one attacker thread, it could change its own value.
> 
> I’m not sure I follow the details, can you give an example of an asynchronous
> mechanism to do this? E.g. would this be the kernel writing to the memory in a
> syscall for example?

I was thinking of all of the IORING_OP_*'s that can write to memory or
aio(7).
