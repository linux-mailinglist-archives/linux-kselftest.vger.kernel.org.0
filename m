Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D48140FAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAQRNB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 12:13:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56972 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQRNB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 12:13:01 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isVB3-0004oZ-AA; Fri, 17 Jan 2020 18:12:57 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CD600100C19; Fri, 17 Jan 2020 18:12:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel =?utf-8?Q?D=C3=ADaz?= <daniel.diaz@linaro.org>,
        shuah@kernel.org
Cc:     Daniel =?utf-8?Q?D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] selftests/x86: Build with LDFLAGS and LDLIBS
In-Reply-To: <20200117165330.17015-1-daniel.diaz@linaro.org>
References: <20200117165330.17015-1-daniel.diaz@linaro.org>
Date:   Fri, 17 Jan 2020 18:12:56 +0100
Message-ID: <87muam0zxj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Daniel Díaz <daniel.diaz@linaro.org> writes:

> During cross-compilation, it was discovered that LDFLAGS and
> LDLIBS were not being used while building binaries, leading
> to defaults which were not necessarily correct.
>
> OpenEmbedded reported this kind of problem:
>   ERROR: QA Issue: No GNU_HASH in the ELF binary [...], didn't pass LDFLAGS?
>
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
