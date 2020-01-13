Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3D139907
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 19:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMSi3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 13:38:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56686 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMSi2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 13:38:28 -0500
Received: from zn.tnic (p200300EC2F05D30049A87F91DFBF49F4.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:49a8:7f91:dfbf:49f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35DD81EC0CD0;
        Mon, 13 Jan 2020 19:38:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578940706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r7McRgwarV2b+r6sIInM74NlKhJpSvjV5hnKWVPuR0o=;
        b=D1HP2t+8usPgOrjRgVi7aoT8qkpV1xtoobPCrYuQK12FMrgCLBXMkoMgiADbDfcVcMT41Y
        XttefyjXefHfAolPygmC/mkZItU34+cAL6fprOfeIjotX6ZWHGhaGGh5tJD6oRrGC4QClp
        JvZkKj66nDsi9TCD5oO0BTxUww5YIJ4=
Date:   Mon, 13 Jan 2020 19:38:23 +0100
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v5 17/19] KVM: VMX: Use VMX_FEATURE_* flags to define
 VMCS control bits
Message-ID: <20200113183823.GP13310@zn.tnic>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
 <20191221044513.21680-18-sean.j.christopherson@intel.com>
 <20200113183228.GO13310@zn.tnic>
 <20200113183705.GL1175@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113183705.GL1175@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 10:37:05AM -0800, Sean Christopherson wrote:
> No, the CPU_BASED_* defines are used by existing KVM code, i.e. you'd
> also have to touch a bunch of KVM code.

Doesn't bother me, I could do it in a patch ontop. But your call.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
