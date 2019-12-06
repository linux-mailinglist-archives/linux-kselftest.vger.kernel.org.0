Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221F2115849
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLFUrt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 15:47:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:60664 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFUrt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 15:47:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 12:47:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="209535429"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2019 12:47:47 -0800
Date:   Fri, 6 Dec 2019 12:47:47 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] Reanme the definitions of INTERRUPT_PENDING,
 NMI_PENDING and TSC_OFFSETING
Message-ID: <20191206204747.GD5433@linux.intel.com>
References: <20191206084526.131861-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206084526.131861-1-xiaoyao.li@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 06, 2019 at 04:45:23PM +0800, Xiaoyao Li wrote:
> When reading the codes, I find the definitions of interrupt-window exiting
> and nmi-window exiting don't match the names in latest intel SDM.

I prefer KVM's names even though they diverge from the SDM.  The "window
exiting" terminology is very literal, which is desirable for the SDM
because it doesn't leave any wiggle room.  But for software, IMO the
"event pending" terminology is preferable as it's more descriptive of the
intended use of the control, e.g. KVM sets VIRTUAL_{INTR,NMI}_PENDING when
it has a virtual event to inject and clears it after injecting said event.
