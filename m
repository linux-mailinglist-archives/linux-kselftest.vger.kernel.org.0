Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D36084E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Oct 2022 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJVGEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Oct 2022 02:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVGEc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Oct 2022 02:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD352BD1;
        Fri, 21 Oct 2022 23:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12A92601C6;
        Sat, 22 Oct 2022 06:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FA1C433D6;
        Sat, 22 Oct 2022 06:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666418668;
        bh=Juz5LjJbSCNynnLDYD7GXdYfa161RW8vLJD4JA2tHS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLBwCPBC927P7PqXScUSO95lyXe13Iior2iKmUfeh/0S8b28HUBRC9vsN9D7r4NbF
         aR/fuvZamZwjZA+ZGfdwdhtNWe8HImdVYsJvYkrhqqhCcepXvLYee0jlYfM03UbpCz
         QqR5aSH7MyEeDGcr1FgTQAoJnzKX+K8Y6sbA0etQ=
Date:   Sat, 22 Oct 2022 08:05:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v15 2/3] virt: Add TDX guest driver
Message-ID: <Y1OIHjFp2r58fDPI@kroah.com>
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221020045828.2354731-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1De4IyAB6n2qs4V@kroah.com>
 <34ef18d6-69f8-853a-d1ba-7023822e17ff@linux.intel.com>
 <Y1Iimg0WItgIGq6/@kroah.com>
 <13adfc8d-8118-2fd7-3a66-98dfbf8037a9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13adfc8d-8118-2fd7-3a66-98dfbf8037a9@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 04:51:34PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi Greg,
> 
> On 10/20/22 9:39 PM, Greg Kroah-Hartman wrote:
> >>>> +#ifdef MODULE
> >>>> +static const struct x86_cpu_id tdx_guest_ids[] = {
> >>>> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
> >>>> +	{}
> >>>> +};
> >>>> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> >>>> +#endif
> >>> Why the #ifdef?  Should not be needed, right?
> >> I have added it to fix the following warning reported by 0-day.
> >>
> >> https://lore.kernel.org/lkml/202209211607.tCtTWKbV-lkp@intel.com/
> >>
> >> It is related to nullifying the MODULE_DEVICE_TABLE in #ifndef MODULE
> >> case in linux/module.h.
> > Then fix it properly, by correctly using that structure no matter what.
> > You don't do that here...
> 
> I think we can use __maybe_unused attribute to fix this warning like
> mentioned below. Are you fine with it?
> 
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -118,13 +118,11 @@ static void __exit tdx_guest_exit(void)
>  }
>  module_exit(tdx_guest_exit);
>  
> -#ifdef MODULE
> -static const struct x86_cpu_id tdx_guest_ids[] = {
> +static const struct x86_cpu_id __maybe_unused tdx_guest_ids[] = {
>         X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> -#endif
> 
> Solution 2:
> -----------
> 
> We can also modify the code to use this structure in all cases like
> below. But it requires me to use slower x86_match_cpu() in place of 
> cpu_feature_enabled() which I think is unnecessary.
> 
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -103,9 +103,15 @@ static struct miscdevice tdx_misc_dev = {
>         .fops = &tdx_guest_fops,
>  };
>  
> +static const struct x86_cpu_id tdx_guest_ids[] = {
> +       X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
> +       {}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> +
>  static int __init tdx_guest_init(void)
>  {
> -       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +       if (!x86_match_cpu(tdx_guest_ids))

Please use this as it's what all other users of the x86cpu module device
table code uses, right?

And what is the "speed" difference here?  Is is measurable and where
does it matter?

thanks,

greg k-h
