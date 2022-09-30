Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB8E5F0BA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 14:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiI3MWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiI3MWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 08:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD872112659;
        Fri, 30 Sep 2022 05:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C76862303;
        Fri, 30 Sep 2022 12:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4F1C433D6;
        Fri, 30 Sep 2022 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664540566;
        bh=CHzO+vNuepBFU9kUufWG3FjCziAEyCBNZhdDpOTDwcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEaYmnjyImRc3xSCs/ev9HdSjc/3w6DenXCVwQhLuYJq5/z9iAZsKSrYohc5x3p8S
         LT7IyWlt/51GzynNiChJgwTGAx+rLylsUB6KUEcRJqWbg2TJFq+SL6etpyDtMSlGU4
         FiOR4whdMNKJnl1QdJhF5u8mpAogTM6sSVnt6Pfk=
Date:   Fri, 30 Sep 2022 14:22:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 2/3] virt: Add TDX guest driver
Message-ID: <YzbflIZzANjAgN9d@kroah.com>
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YzXduIn83E1oood8@fedora>
 <665a4db2-a342-43ba-38a0-715c34709729@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665a4db2-a342-43ba-38a0-715c34709729@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 29, 2022 at 11:11:47AM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 9/29/22 11:02 AM, Wander Lairson Costa wrote:
> >> +#define TDX_GUEST_DEVICE                "tdx-guest"
> > nit: I think now we can use KBUILD_MODNAME, can't we?
> > 
> 
> Yes. We can use it. But I thought user can use this macro
> and avoid hard coding the device name.

What user?  Please use KBUILD_MODNAME now instead.

thanks,

greg k-h
