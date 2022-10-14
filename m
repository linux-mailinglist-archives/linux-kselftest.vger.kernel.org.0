Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E315FE64A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 02:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJNAYz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 20:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNAYy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 20:24:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B437356FD;
        Thu, 13 Oct 2022 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665707092; x=1697243092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aE1+hnfKiYR3idWoXlvpbQtseYBiK39vZ4xtmA2EiTA=;
  b=movb+VxVc4OwfJ2L20xr7vxXW0PY73ZCmnMEfPo1tW6GVLkvM9faadIQ
   rnGr1ybskH9PWNJo+02sGu+DKYWroMN96MIgn22Qmd6VoNcUtwyN/UQmA
   VrySaXu9oQXuq94iP5Q5C/CzT3Bohka3tGXS8pClx5lacbDDQWrSKBEuM
   wY/40eAJ6KbPQHqnQIKW3xnONUspN4TCTjZpJ5pNSTVXMJfSSC6SbGloh
   oYSE5IyT5Qm+MOMfid0O5kSWtU1wfATjtl4J2xPKrpii6eEKTbaGWaRcd
   m27XYJ57jb/Afb5KIW2SUIiXDLhH1/gqaQPIjY/h0E1je0J6DCXq9UDi8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="305231889"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="305231889"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 17:24:52 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="660539646"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="660539646"
Received: from mkucejko-mobl.ger.corp.intel.com (HELO [10.213.24.166]) ([10.213.24.166])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 17:24:40 -0700
Message-ID: <09db0198-53d3-bc41-da5a-b518375bbec9@intel.com>
Date:   Thu, 13 Oct 2022 17:24:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 0/9] x86: Show in sysfs if a memory node is able to do
 encryption
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <Y0hrhzprPFTK+VWV@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y0hrhzprPFTK+VWV@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/22 12:48, Borislav Petkov wrote:
>> It's planned to make this check part of an specification that can be
>> passed to people purchasing hardware
> How is that supposed to work?
> 
> People would boot a Linux on that hardware and fwupd would tell them
> whether it can encrypt memory or not?
> 
> But if that were the only use case, why can't EFI simply say that in its
> fancy GUI?
> 
> Because all the kernel seems to be doing here is parrot further
> EFI_MEMORY_CPU_CRYPTO.
> 
> And that attribute gets set by EFI so it goes and picks apart whether
> the underlying hw can encrypt memory. So EFI could report it too.

I think the kernel _would_ just be parroting the firmware's info *if*
this stuff was all static at boot.  It pretty much _is_ static on
today's systems.  You generally can't hotplug memory (encrypted or not)
on any of these fancy memory encryption systems.  On the Intel side, I'm
thinking mostly of Ice Lake systems.

But, that is very much changing once CXL comes on the scene.  A system
might boot with only DRAM attached right to the CPU and all of it is
encryption-capable.  Then, some wise guys plugs in a CXL card that
doesn't support encryption.

That makes the "is everything encrypted" answer dynamic and is
essentially unanswerable at boot, other than to give a one-off answer.
