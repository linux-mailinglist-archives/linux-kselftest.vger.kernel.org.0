Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B95104268
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 18:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfKTRsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Nov 2019 12:48:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35402 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfKTRsT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Nov 2019 12:48:19 -0500
Received: from zn.tnic (p200300EC2F0D8C00F553B94F3FB99B80.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:f553:b94f:3fb9:9b80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B7D41EC0C0A;
        Wed, 20 Nov 2019 18:48:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574272097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sRGk1TFOicxI4LhR8Ex8diUi+6oCm1GfPkLIX+2fv3k=;
        b=ddWR/VPtrKLvTOJFzaHVDWgpMgbnK9t9PGNQfhYFWQXJDrF/b/wgn4TGqzrtqDphOUfvY9
        S9/TKirB/KIQWRegfs5f8xqqEspKeinJ7gj3veo+LbHfNO/22QCW/xAe4av/1pQJKREgFD
        tSdQHBcSqiKfr3ZQdsucmfmj3+xUGag=
Date:   Wed, 20 Nov 2019 18:48:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v3 01/19] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191120174810.GI2634@zn.tnic>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-2-sean.j.christopherson@intel.com>
 <20191119111445.GB27787@zn.tnic>
 <20191119231822.GA6855@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191119231822.GA6855@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 19, 2019 at 03:18:22PM -0800, Sean Christopherson wrote:
> Ugh.  Match the SDM unless it's obviously "wrong"?  :-)  It might literally
> be the only instance of the SDM using "on" instead of "enable(d)" for an
> MSR or CR bit.  The SDM even refers to it as an enable bit, e.g. "platform
> software has not enabled LMCE by setting IA32_FEATURE_CONTROL.LMCE_ON (bit 20)".
> 
> Whining aside, I'm ok going with LMCE_ON, I have a feeling "on" was
> deliberately chosen differentiate it from IA32_MCG_EXT_CTL.LMCE_EN.

Nah, ok, let's leave this as a one-off case where the SDM is simply
wrong but otherwise the bit names are correct and we keep them the same
as in the SDM to avoid obvious confusion.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
