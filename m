Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA16793BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjAXJNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 04:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjAXJNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 04:13:11 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B61F23108;
        Tue, 24 Jan 2023 01:13:09 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 4ACD981F43;
        Tue, 24 Jan 2023 09:13:03 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674551589;
        bh=JUdJx8WCD96WaEl9obiXS8b88Gy97jyGRUCeA1P4t5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAo1ikUbNTu84UGoQftUDsnXR0RcZDcZhc/lqDynKCVDGXFhJ99HxwfuFvPTEg0bm
         CaYi8ahLEV6UpV2RvOomq+qoQwj1TRXyFFZoaTW0OT1My3IB7aa+LtlUUeyIULAg0W
         Kn5iK54U3ntVGgIsnZkQji+GutOX+Hq2zq8uGlZKB+sCTegdIDTjqPJjbwFtk8zabP
         OTseAkPBQOqhtu1f2MYC4KL0R1mo8uLSvEe2xuAHL9mXq+qYo/qd+IosCIUwYV1Y7w
         zToZPWweKkiYfN/iV5tYfk5e3zCR77ilX4wtqoS4molbgZLIim7DQ89jlocxHm6Nqp
         4am54Xs+fqSvA==
Date:   Tue, 24 Jan 2023 16:12:59 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 Mailing List <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] selftests/x86: sysret_rip: Add more syscall
 tests with respect to `%rcx` and `%r11`
Message-ID: <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
References: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com>
 <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com>
 <20230124022729.596997-1-ammarfaizi2@gnuweeb.org>
 <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 01:07:38AM -0800, H. Peter Anvin wrote:
> Works for me, although I would call it REGS_UNDEFINED myself.

I'll call it REGS_UNDEFINED too, in v3.

-- 
Ammar Faizi

