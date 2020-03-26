Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25A193513
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 01:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCZApl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 20:45:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:19082 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbgCZApl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 20:45:41 -0400
IronPort-SDR: eyZ+Lm8IS52aH2yif8+hSSC4ijUdrrhPYC4Y6mqcPYeIwdnDuTXQd/mCJa3VoO//yJqi89zR2R
 iQyofA1J25ZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 17:45:41 -0700
IronPort-SDR: 9zOY6UgWxTyOVTL3IsoRMu7dl4YEEHlXDJsyVUbZRSeKnqNXMlasBB4Zzh87J/LndN9M9XIFVc
 mxTxgJEHXspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="393803360"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.169.99]) ([10.249.169.99])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 17:45:38 -0700
Subject: Re: [PATCH v2 0/6] Fix errors when try to build kvm selftests on
 specified output
To:     shuah <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
 <8e5a7de6-25f3-7979-c6b9-49e1ea717f8e@kernel.org>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <00b92d64-5991-f102-4bec-7aca8f1ece9a@intel.com>
Date:   Thu, 26 Mar 2020 08:45:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8e5a7de6-25f3-7979-c6b9-49e1ea717f8e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/26/2020 12:12 AM, shuah wrote:
> On 3/25/20 8:01 AM, Xiaoyao Li wrote:
>> I attempted to build KVM selftests on a specified dir, unfortunately
>> neither    "make O=/path/to/mydir TARGETS=kvm" in 
>> tools/testing/selftests, nor
>> "make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.
>>
> 
> Please elaborate on the problems you are seeing. I would like you
> to describe in detail the problems you are seeing and how you are
> fixing them in this patch series.
> 
> The problem you are fixing here is subdir structure not being
> supported for relocatable builds and the Makefile not being
> able to locate headers files. These are issues, however, these
> need to be fixed in the kvm Makefile
Maybe I should have sent it as RFC.

OK, then I'll just resend patch 1 in v1 to fix the subdir not created 
issue for relocatable build, in kvm Makefile. Obviously lib.mk doesn't 
create it, and you don't allow me to touch lib.mk

About headers issue, since I'm not familiar with Makefile, I don't want 
to waste any more time on it and I decide to drop them.

I can add a "make mrproper" in my script to do the cleanup as a workaround.

And never make kvm selftests in parent dir with
	make O=/somewhere TARGETS=kvm
to workaround the header not found issue.

> Please look at arm64, android, futex tests as examples. lib.mk
> and main selftests Makefile allow for overrides for make targets.
> When a test has sub-dir structure and libraries, it is easier to
> handle these in the individual Makefile.
> 
> Please fix the problems you are seeing in kvm Makefile.
> 
>  >I only test the sub TARGET of kvm.
>  >In theory, it won't break other TARGET of selftests.
> 
> When you change lib.mk which is a common infrastructure, theory
> doesn't help. Statements like this make me very reluctant to
> accept patches. :)
> 
> This is one reason why I asked Paolo to drop these patches.
> 
> thanks,
> -- Shuah

