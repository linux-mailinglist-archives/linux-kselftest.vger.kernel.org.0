Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687243D88BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 09:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhG1HTY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 03:19:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:59815 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233209AbhG1HTX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 03:19:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="276384402"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="276384402"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 00:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="663199615"
Received: from fedora29.sh.intel.com ([10.239.182.87])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2021 00:19:13 -0700
Date:   Wed, 28 Jul 2021 15:18:35 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>,
        Yu Yu-cheng <yu-cheng.yu@intel.com>,
        Yu Fenghua <fenghua.yu@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>
Subject: Re: [RFC PATCH v1 0/2] Introduce XSAVE/XRSTOR self-test
Message-ID: <20210728071835.GA12735@fedora29.sh.intel.com>
References: <cover.1627355565.git.pengfei.xu@intel.com>
 <af8e6de6-c428-d3f9-9abf-f8bd5cc95838@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8e6de6-c428-d3f9-9abf-f8bd5cc95838@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,
  Thanks for comments!

On 2021-07-27 at 10:46:45 -0700, Dave Hansen wrote:
> On 7/26/21 8:34 PM, Pengfei Xu wrote:
> > The XSAVE feature set supports the saving and restoring of state components
> > such as FPU, which is used for process context switching.
> 
> This sentence is really awkward.  It reads at first as saying that the
> FPU is used for context switching.  Can you rephrase.
> 
  Thanks for advice, I will update it as below if it's appropriate:
"
The XSAVE feature set supports the saving and restoring of state components,
which is used for process context switching. The state components include
x87 state for FPU execution environment, SSE state, AVX state and so on.
"

> > In order to ensure that XSAVE works correctly, add XSAVE basic test for
> > XSAVE architecture functionality.
> 
> This sentence needs to be start on the same line as the previous one,
> *or* be in a new paragraph.  Please rewrap it.
> 
  Will rewrap it.

> > This patch set tests XSAVE/XRSTOR instructions on x86 platforms and verify if
> > the XSAVE/XRSTOR works correctly during signal handling.
> 
> This reads to me like you are going to test the XSAVE/XRSTOR
> instructions *in* a signal handler, instead of testing the XSAVE/XRSTOR
> instructions that the kernel uses at signal entry/exit.
> 
> Also, the kernel does *NOT* *USE* XSAVE/XRSTOR in many cases to
> save/restore signal state.  The changelog could be read as implying that
> it does.
> 
  Yes, how about updating it as below:
"
This patch set tests and verifies the basic functions of XSAVE/XRSTOR in
user space; during and after signal processing on the x86 platform, the
XSAVE contents of the process should not be changed.
"

> > Cases such as signal handling, process creation, other xstate(except FPU)
> > tests for XSAVE check, etc. will be added to the Linux kernel self-test.
> > If appropriate, it is even planned to add the [1] mentioned XSAVE issues
> > reproduce and some XSAVE anomaly tests to the kernel self-test.
> 
> This is not clear whether it is talking about *this* series int he
> future tense (will be added) or whether it is talking about future *work*.
> 
> Maybe something like this:
> 
> 	This series introduces only the most basic XSAVE tests.  In the
> 	future, the intention is to continue expanding the scope of
> 	these selftests to include more kernel XSAVE-related
> 	functionality and XSAVE-managed features like AMX and shadow
> 	stacks.
Thanks for advice, will update it.

-Pengfei
BR.
