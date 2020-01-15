Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10713CF86
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 22:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAOVzv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 16:55:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAOVzv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 16:55:51 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irqdc-0001p8-3H; Wed, 15 Jan 2020 22:55:44 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 76055101228; Wed, 15 Jan 2020 22:55:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        "Moger\, Babu" <Babu.Moger@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
In-Reply-To: <20200115211749.GA51626@romley-ivt3.sc.intel.com>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com> <7aacc3e8-4072-c6b9-5d0f-f687a40ad315@amd.com> <CY4PR12MB1574ACDEE30CDCD8113CECA795390@CY4PR12MB1574.namprd12.prod.outlook.com> <20200115211749.GA51626@romley-ivt3.sc.intel.com>
Date:   Wed, 15 Jan 2020 22:55:43 +0100
Message-ID: <87k15sxu3k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> writes:
>
> Hi, Boris, Thomas, Ingo, et al,
>
> Any comment on this patch set?

No objections from my side, but you forgot to CC the relevant
maintainer/mailinglist for tools/testing/selftests/. CC'ed now.

Thanks,

        tglx
