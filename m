Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF47C105107
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 12:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKULFl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 06:05:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44722 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKULFl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 06:05:41 -0500
Received: from zn.tnic (p200300EC2F0F07006553A4184595DC73.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:6553:a418:4595:dc73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59F9C1EC0CF0;
        Thu, 21 Nov 2019 12:05:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574334335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uDA1XNH/BDEQTxr9BABuMzUgYDIn2hXZ3aP/cBDMLVo=;
        b=ZY01aSvHF7c4EoU+iM0ZCScSFeQNFtWU/+MDFyPJCPtEWLx3Hb2EnvMfQhbh9cMRZRoo0y
        SGvuVpJPyqDfS1zGs3B0B2hcie36w0DSAENy2TehmN7lEu8QfdPc0q/F7tyt6N/Zmppmn/
        nevOTxhrAvrKr81GvYA9mfgh8butiHM=
Date:   Thu, 21 Nov 2019 12:05:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 04/19] x86/intel: Initialize IA32_FEATURE_CONTROL MSR
 at boot
Message-ID: <20191121110533.GD6540@zn.tnic>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-5-sean.j.christopherson@intel.com>
 <20191121103925.GB20907@linux.intel.com>
 <20191121104145.GC20907@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191121104145.GC20907@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 12:41:45PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 21, 2019 at 12:39:25PM +0200, Jarkko Sakkinen wrote:
> > > +void init_feature_control_msr(struct cpuinfo_x86 *c)
> 
> I'd also use here shorter init_feat_ctl_msr(). It has one call site
> but shorter name is more convenient when playing with tracing tools.

Yeah, and since we're shortening all to feat_ctl, let's do:

mv arch/x86/kernel/cpu/feature_control.c arch/x86/kernel/cpu/feat_ctl.c

too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
