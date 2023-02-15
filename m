Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447E697A1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 11:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjBOKoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 05:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjBOKox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 05:44:53 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED644A5;
        Wed, 15 Feb 2023 02:44:52 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.231])
        by gnuweeb.org (Postfix) with ESMTPSA id 66513830B9;
        Wed, 15 Feb 2023 10:44:46 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1676457892;
        bh=DRwv3piHmMXuW33yjmbYf/9oXn6DL3uQXB+v4j1d+Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnLLM3zr31CtA0QaReAYKDFpStlY6IHmiGPtDSpwq+D9FFjY0Iyc5HXVSZ0mliGzx
         Inof7OjEZxwkfJU3elgOZiTnH+bbRsRYNMSGu/mGJaqo761BZk9Srd/HUmwbYJL5+8
         XtGzYpkgpyQDis1y5Wb+h5d9jhwQbvVvORzKIhGzNXgK0dYHeVz3BURDKiVM2k8qf7
         wW7aCAhnV6ttjPQQyv0uPi+WYzr6SqaLENlmWbMOJkoxTfCTjKdXqLLlwVedORSaiW
         QCLAXzPUYkYdDOcnUix0MQzv1Hcf4JVbqTevHvnC6BoZ4JR4anNYmb7ZPNtMtENnqa
         Lg3F/tGprln3g==
Date:   Wed, 15 Feb 2023 17:44:41 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Xin Li <xin3.li@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y+y3mSKoVwem3xbT@biznet-home.integral.gnuweeb.org>
References: <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
 <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
 <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
 <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
 <Y9LdwVX9BaZA7zmA@biznet-home.integral.gnuweeb.org>
 <0b57d2ab-14e0-14a0-adf3-3186fd2f5282@citrix.com>
 <e4222762-fc60-a848-09af-f6de614d5f74@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4222762-fc60-a848-09af-f6de614d5f74@citrix.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 10:29:37AM +0000, Andrew Cooper wrote:
> I've opened https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108799

Added myself to the CC list. Thanks for opening.

-- 
Ammar Faizi

