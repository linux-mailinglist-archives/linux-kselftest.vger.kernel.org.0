Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4C172629
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 19:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgB0SJy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 13:09:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:29054 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729563AbgB0SJy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 13:09:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 10:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="437125047"
Received: from unknown (HELO [134.134.177.87]) ([134.134.177.87])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2020 10:09:52 -0800
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     TonyWWang-oc@zhaoxin.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, bp@alien8.de, bp@suse.de,
        hpa@zytor.com, jacob.jun.pan@linux.intel.com,
        jarkko.sakkinen@linux.intel.com, jmattson@google.com,
        jolsa@redhat.com, joro@8bytes.org, kvm@vger.kernel.org,
        lenb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
        namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
        rkrcmar@redhat.com, shuah@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <20191221044513.21680-14-sean.j.christopherson@intel.com>
 <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
 <20200227021221.GA14478@linux.intel.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <38e05b7a-aea2-1da1-56b5-1505615c55fb@intel.com>
Date:   Thu, 27 Feb 2020 10:09:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227021221.GA14478@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/26/2020 6:12 PM, Sean Christopherson wrote:
> On Tue, Feb 25, 2020 at 01:49:13PM -0800, Jacob Keller wrote:
> 
> One other thing that's been bothering me; you mention in a later email that
> this bug resulting in a crash during boot.  The low timestamps also suggest
> the system is fairly early in its bringup.
> 
> But KVM only does VMXON when it actually creates a VM[*].  During boot I
> would expect the bug to result in KVM being incorrectly loaded/enabled, but
> that alone wouldn't trigger a crash.

It crashes during hardware enable, specifically in the kvm_cpu_vmxon
during the hardware_enable() function.

It doesn't crash until near the end of bootup, and it didn't crash when
I kept the system in single-user boot mode.

> 
> I assume/hope your system is automatically running some form of virt
> process at boot?  Not that there's anything wrong with that, it's just
> suprising and I want to make sure there's not something really funky going
> on.
> 

The system has libvirtd enabled. My guess is that libvirtd starts up and
enables hardware. I don't see any actual virtual machines enabled, but I
think you're right that this is why it crashes.

Thanks,
Jake
