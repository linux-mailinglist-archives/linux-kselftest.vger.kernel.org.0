Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C744BB91C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiBRM1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 07:27:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiBRM1R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 07:27:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9773B1B7BF;
        Fri, 18 Feb 2022 04:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MVaFoxpSrw0lXOFRf60il59+xXDuimORkK161w41iNc=;
        t=1645187219; x=1646396819; b=EXibw6MQDxwd+G9ZAGVB7tlsFUP8j9mDkVRMKG/rZAkrK1b
        DvpIMQb2rEZIJlLjbXgYU641EJcGdpL2saikvB4+JDr/QblHL4nO8a78ww2/oCeSnyz1/UxPlEoQY
        QCSV+OTJvz+5IVTZ7kwUMvpKywlU7+mchSrEq11AL0anykxxgT48GuBBGgn4QN5ZbFT8Yxyn2wfah
        CBtdsJbFk92XfeOuVkRRGl0r9V/Z9Kgfo2+o919/aZKPrPWo+vhey5YBi/ddP7r5lkNDq41h41Ao7
        7CndmP3jomv4luE25VGXdLKA5X+P5TmnZs4p9RJCU6tZ7uU3FVa+8XwQksIkgr0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nL2LH-002du1-NQ;
        Fri, 18 Feb 2022 13:26:31 +0100
Message-ID: <ac4c5f8c890e5bdd7ad7ecc04a51e72fa3ac1703.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-um@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, felix.kuehling@amd.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Feb 2022 13:26:30 +0100
In-Reply-To: <20220218075727.2737623-5-davidgow@google.com>
References: <20220218075727.2737623-1-davidgow@google.com>
         <20220218075727.2737623-5-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-02-18 at 15:57 +0800, David Gow wrote:
> 
> Note that, while this does build again, it still segfaults on startup,
> so more work remains to be done.

That's probably just a lot more stuff getting included somehow?

> They are:
> - CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
> - CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache
> - CONFIG_BNXT: Failing under UML with -Werror
> ERROR:root:../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: In function ‘bnxt_ptp_enable’:
> ../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:400:43: error: array subscript 255 is above array bounds of ‘struct pps_pin[4]’ [-Werror=array-bounds]
>   400 |                         ptp->pps_info.pins[pin_id].event = BNXT_PPS_EVENT_EXTERNAL;
>       |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~
> - CONFIG_PATA_CS5535: Needs MSR access (__tracepoint_{read,write}_msr)
> - CONFIG_VDPA: Enables CONFIG_DMA_OPS, which is unimplemented. ('dma_ops' is not defined)
> 
> These are all issues which should be investigated properly and the
> corresponding options either fixed or disabled under UML. Having this
> list of broken options should act as a good to-do list here, and will
> allow these issues to be worked on independently, and other tests to
> work in the meantime.
> 

I'm not really sure it makes sense to even do anything other than
disabling these.

It looks like all of them are just exposed by now being able to build
PCI drivers on UML. Surely the people writing the driver didn't expect
their drivers to run over simulated PCI (which is what the UML PCI
support is all about).

Now from a PCI driver point of view you can't really tell the difference
(and anyway the driver won't be probed), but the issues (at least the
build time ones) come from having

    UML && PCI && X86_64

or

    UML && PCI && X86_32

because drivers typically depend on X86_64 or X86_32, rather than on
"X86 && X86_64" or "X86 && X86_32". In a sense thus, the issue is those
drivers don't know that "!X86 && (X86_32 || X86_64)" can happen (with
UML).


Now you could say that's the driver bug, or you could say that they
should just add "depends on !UML" (though that's basically equivalent to
adding "depends on X86" and the latter may be preferable in some cases).

Or actually in the three patches you have (1-3) it's in the code, but
same thing, you can either add && !UML (like you did) or add && X86.


Arguably, however, building PCI drivers by default is somewhat
questionable in the first place?

So maybe you should just add

    # CONFIG_UML_PCI_OVER_VIRTIO is not set

to the broken_on_uml.config since it exposes all these issues, and
really is not very useful since you're not going to actually run with
any simulated PCI devices anyway, so drivers will not be probed.

johannes
