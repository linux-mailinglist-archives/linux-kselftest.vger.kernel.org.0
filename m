Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0267B8C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 18:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjAYRlg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 12:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjAYRlf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 12:41:35 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9B37541;
        Wed, 25 Jan 2023 09:41:35 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 8735881F42;
        Wed, 25 Jan 2023 17:41:28 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674668494;
        bh=Wo/QLZs7Iimn8JQQFtFENUgEjo1tvasMuPeWKFbAdjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fODmjBow1Eux9eNTdLT+3b9qfeLHBmDhD2CH5obiHrNgbZXp13ipDL+iBq5MjqpQN
         mf3bWU/5zbAsbJHnKZUhknLW0jTNAau9tdG5jVKy+A2XmPaa+tDPyhiYiBHONE8r0N
         dT4eaaG13GmTGubkZMI/3RALFqm+qOfmzQmGpN6v2Tmvjbfw5E053QaHBCkDcnfMx6
         aekxf2pEIK7wWQM+8aNy7kV6a6mJCyB9w5qGM3YEAfvl+iVQniOPsFPcOOcJdny+qD
         HgVFh/IO1xRixUh1yhZRI/Kn4MC7jG0+wkDI/AzNUWk1x4EL0NIAqHzWLveSWUuFBo
         2A4+A+UC9vSWA==
Date:   Thu, 26 Jan 2023 00:41:24 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Li, Xin3" <xin3.li@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 0/2] sysret_rip update for the Intel FRED
 architecture
Message-ID: <Y9FpxEz2+LJc7vJP@biznet-home.integral.gnuweeb.org>
References: <20230124022729.596997-3-ammarfaizi2@gnuweeb.org>
 <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com>
 <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org>
 <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com>
 <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org>
 <20230125034958.734527-1-ammarfaizi2@gnuweeb.org>
 <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org>
 <SA1PR11MB673480C4129F7A7EA9DFAF4AA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <A5C220D5-BCE6-42DC-8115-ED41CD011993@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5C220D5-BCE6-42DC-8115-ED41CD011993@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 25, 2023 at 09:24:40AM -0800, H. Peter Anvin wrote:
> On January 25, 2023 9:07:18 AM PST, "Li, Xin3" <xin3.li@intel.com> wrote:
> > Would it be better to get this patch set merged first?
> > 
> > Otherwise surely I will include it in the FRED patch set.
> 
> If the maintainers are ok with it, it would be better to merge it
> sooner: once we have agreed on the semantics, which I believe we
> have, we should be testing those semantics and nothing else.

OK, let's keep this patchset separated from the FRED support
patchset.

In the meantime, let me address the recent HPA's comments.

-- 
Ammar Faizi

