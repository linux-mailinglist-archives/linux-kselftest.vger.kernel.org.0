Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F92A700F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 23:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgKDWAw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 17:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbgKDWAH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 17:00:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699CC0613D3;
        Wed,  4 Nov 2020 14:00:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604527204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcDsYZoZ0HQ8m/eP7LfmBFx38dKfFr6Bky2Op7UAmTc=;
        b=uWGK10QusV8XBgAEcXVFwB1s7DNqNR5bL2JxVVUikjP6JCw35Az+lH5kDWr/WVmnsV5f1a
        v9VKhuFzImQ6xYFX7YxIzcIJ8YdpvepoHsQWKeEDjnDCubBPSFXYO8t/8LEmfdY1e0a1LQ
        zW4GmgphvtE89rP0MbRj0SVvzfkZIg3CNxaDvYoK0I/s21xPkV1Yp9dLyQ5pB8PaIUff08
        VcFY0hmUO0WpT6iFhQYDoHl8KvFDJbuIcKAgCcldgqvZIvkM8szgbdWQ3TGu/eRovgBYXP
        cx196hdriOCOBkZ0zIsChUhB5+Elt6carE/r29w1GPSqqLChVCIne7K15cElzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604527204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcDsYZoZ0HQ8m/eP7LfmBFx38dKfFr6Bky2Op7UAmTc=;
        b=4RHQiyW6VNGm/O/DAJIaIeOw+XnqzvzEWcSqFGUfKYoL99s98K8xSO9iHJpE1NVxJhZwIu
        pTGKWcex2mU6TyAg==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS) support
In-Reply-To: <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com> <871rhb8h73.fsf@nanos.tec.linutronix.de> <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
Date:   Wed, 04 Nov 2020 23:00:04 +0100
Message-ID: <87k0v0lr4r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 04 2020 at 09:46, Ira Weiny wrote:
> On Tue, Nov 03, 2020 at 12:36:16AM +0100, Thomas Gleixner wrote:
>> This is the wrong ordering, really.
>> 
>>      x86/entry: Move nmi entry/exit into common code
>> 
>> is a general cleanup and has absolutely nothing to do with PKRS.So this
>> wants to go first.
>
> Sorry, yes this should be a pre-patch.

I picked it out of the series and applied it to tip core/entry as I have
other stuff coming up in that area. 

Thanks,

        tglx
