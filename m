Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE819580F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Mar 2020 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgC0NbP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Mar 2020 09:31:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:48719 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0NbP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Mar 2020 09:31:15 -0400
IronPort-SDR: 7aFRuwjBu28xF6nNeE+1WjNvBdmH7e1HN8bZKMf3LeyG1rxvqy00v0oUyRWuesZDy1ZqKIrQ4L
 NdeiO0QuHzXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 06:31:14 -0700
IronPort-SDR: FgZmlOXOdU87JV3m5kiDBGg832ML9THphBuFul4SB8aJ99Fo6P+3dZ4HDUDdHD/p94xqYf+6l0
 aOZmpb/+9dcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,312,1580803200"; 
   d="scan'208";a="326907638"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.170.128]) ([10.249.170.128])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2020 06:31:12 -0700
Subject: Re: [RFC v3 0/3] Fix errors when try to build kvm selftests on
 specified output
To:     shuah <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200326030750.173972-1-xiaoyao.li@intel.com>
 <41d5d89e-79c2-6f7d-de3e-ca3255e910e8@kernel.org>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <cb445047-ab84-0c49-cfba-ec6933971dc7@intel.com>
Date:   Fri, 27 Mar 2020 21:31:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <41d5d89e-79c2-6f7d-de3e-ca3255e910e8@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/27/2020 4:57 AM, shuah wrote:
> On 3/25/20 9:07 PM, Xiaoyao Li wrote:
>> Hi Shuah,
>>
>> Hope you're happy with this version that I only touch KVM's Makefile.
>>
>> I attempted to build KVM selftests on a specified dir, unfortunately
>> neither    "make O=/path/to/mydir TARGETS=kvm" in 
>> tools/testing/selftests, nor
>> "make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.
>>
> 
> Why are you running "make OUTPUT=/path/to/mydir"
> 
> It isn't correct.

So what's the meaning of

ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
	OUTPUT := $(shell pwd)
	DEFAULT_INSTALL_HDR_PATH := 1
     endif
endif

in lib.mk?

> 
> make O=/path/to/mydir is what you have to use. Please main Makefile
> as well for O= and KBUILD_OUTPUT usages.
> 
> Please see Documentation/dev-tools/kselftest.rst for use-cases.
> 
> make O=/path/to/mydir TARGETS=kvm is a right use-case and I can see
> it will fail to create x86_64 directory.
> 
> Let's start with the following two commands and try to fix the
> problems you are seeing.
> 
> make O=/path/to/mydir in kvm directory (this is supported,
> however, the following command from the main Makefile is
> recommended use.)

Of course we can do this, but the "O=/path/to/mydir" only has effect on 
header install, the *.o files still generated in kvm/ directory.

And kvm's INSTALL_HDR_PATH cannot find the right headers.

That's why I choose to use "OUTPUT=/somewhere"

>  From main Makefile in kernel srcdir
> make O=/path/to/mydir TARGETS=kvm

I guess "kernel srcdir" means "kselftest srcdir", i.e., 
tools/testing/selftests/ ?

Well, as I said in the first place, I tried

	make O=/path/to/mydir TARGETS=kvm

but it doesn't work. So I did some fixup, and sent out the Patches.

If the patches are wrong, please point it out and give your comments how 
to make it right.

> Also, just build isn't sufficient for you to be able to run the
> tests.
> 
> make kselftest-install O=/path/to/mydir TARGETS=kvm will generate
> run script.

This command also has the x86_64 directory not created issue.
Since it generates header files in kernel_src/usr/include, it doesn't 
have headers path issue. But as result, the kernel_src directory is not 
clean, this requires me to run "make mrproper", I *really* don't like it.

