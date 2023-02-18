Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CE69B807
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Feb 2023 05:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBRE1y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 23:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRE1w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 23:27:52 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62092D5E;
        Fri, 17 Feb 2023 20:27:50 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.176])
        by gnuweeb.org (Postfix) with ESMTPSA id 81EF1830E1;
        Sat, 18 Feb 2023 04:27:44 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1676694470;
        bh=q8e47NtPRtINzIK4xZX9p80Y94ve8y9ggkpeKfq7PS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNYjC7v2iV1fUNBOE66W+PIXGinCod4mebI3ct3A2ZXHBtcxPq/n5OGSnKdwOyA+J
         CALV5mUSOYuwho354rEiEQxeTyeQ/9itK9mvjVITlpDLwo2m3By5LQ9JP+06ihqnyD
         7vDhbgswiJ+Mn3aHqw68htTh93S+eqXkzINIMIRDX2X1oEUlwgkySRKeE4d394OoON
         CIbWibqp+LoWX8tPWFWEV43K+VT7IjksKPHJcRf/MD9F7uAi+GpOH2lQ7QnMVzsDKf
         aZcL5Oz6BCUqMdLiDH1iCUjT0mLadUfgTYzFrSqeJSw+ikc9NxyZ3/76Kgc6FzPa5t
         WXRjHK2p1FJJA==
Date:   Sat, 18 Feb 2023 11:27:40 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Message-ID: <Y/BTvGJT1QEz15w7@biznet-home.integral.gnuweeb.org>
References: <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org>
 <SA1PR11MB673480C4129F7A7EA9DFAF4AA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <A5C220D5-BCE6-42DC-8115-ED41CD011993@zytor.com>
 <Y9FpxEz2+LJc7vJP@biznet-home.integral.gnuweeb.org>
 <SA1PR11MB673454F82DEBD8A1C7009C79A8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <SA1PR11MB67342D0472C023619BDEFB26A8A39@SA1PR11MB6734.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB67342D0472C023619BDEFB26A8A39@SA1PR11MB6734.namprd11.prod.outlook.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 07:42:47AM +0000, Li, Xin3 wrote:
> Hi Faizi,
> 
> Any update on this patch set?

No comment from HPA. But after the recent discussion with Andrew, I
think at least it's now clear that we are not going to use "+r"(rsp) to
avoid the red zone problem.

I am on leave today. Will send revision v8 on Monday.

Thanks,

-- 
Ammar Faizi

