Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E965FC3A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJLKSp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 06:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJLKSg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 06:18:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ACDD83;
        Wed, 12 Oct 2022 03:18:32 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7164D1EC0716;
        Wed, 12 Oct 2022 12:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665569907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9vYszipudkgN+JyCf6YKNcAINQz5USDy31mfIDJFVGs=;
        b=bUR2WL5WGtmu9OPZHEVmibMsQjRPSN5SwXgYgrqCOe0jXKGU2KDQpreiK48V4qekgiZppe
        s0JN83R33y7M7crVylIXvWaNvDc8w04mCNheyrlQGDPLUj29DN28b3l9Ca7K+lUhRcE39H
        vSjhbxAp+9WhMxnaXvNv1wgW/X1Krjs=
Date:   Wed, 12 Oct 2022 12:18:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 1/3] x86/tdx: Make __tdx_module_call() usable in
 driver module
Message-ID: <Y0aUb3n7ouaeAt2a@zn.tnic>
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 28, 2022 at 02:55:33PM -0700, Kuppuswamy Sathyanarayanan wrote:
> To support TDX attestation, the TDX guest user interface driver must
> use the __tdx module_call() function in the driver to allow the user to
> obtain the TDREPORT.
> 
> So export the __tdx_module_call() and move the TDX Module IDs to
> asm/tdx.h.

The functions with the __ prefix are usually lower-level interfaces
which should be internal. Usually.

Why aren't you exporting the tdx_module_call() one instead?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
