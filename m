Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4096466FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 03:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLHCcq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 21:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHCcp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 21:32:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34ED6381;
        Wed,  7 Dec 2022 18:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TGRmTjUuLBYU254G3ZYWN6qyws6uV3BnshQv6AMXkyY=; b=G50N7eTG1xMVdwdI3/ou/lxXzj
        CykWS7Y4jOn4mfQrZ05YpHAcu23UyAEsko67J2+jUwno8AvWB9+6Q5fE8iw1iu4H5v4TkFjhGm36N
        prvhNU3qVMGRZLIG9QmEJOEwW8AUevP2dUn4220BlHGuNieDtou2cJpMlsBx+4x8fltjZ98WTXzch
        77IWh6E+yBF7nTXziprc9sK1c8YNd4cd5E+qGnoyFM2t7a8nRuPkT+Muw4iCNNaVbLUZZcld3bdau
        Mbk6LhELh7qDWX2/smbQKGJ3yB9598xTgaF991W3O9F/Se9qx9b1dLZQYkT57K6VJrWvNE46SRFCR
        n+NidXEA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p36iC-000Kdv-Ct; Thu, 08 Dec 2022 02:32:39 +0000
Date:   Wed, 7 Dec 2022 18:32:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "Zhou, Jie2X" <jie2x.zhou@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: fw_fallback.sh test failed in Debian 11
Message-ID: <Y5FMxAJ1SGEezLgl@bombadil.infradead.org>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
 <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
 <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
 <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <217b7959-facc-1028-19be-1040898a705c@intel.com>
 <CY4PR11MB13206A6918FFDEB5B3D3794BC5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <57b8f45b-da8c-e9ae-6b3f-ba82f936c9b2@intel.com>
 <CY4PR11MB132068A19AF9704D1B14814FC5179@CY4PR11MB1320.namprd11.prod.outlook.com>
 <4e5bbaf8-58ea-5ebe-a585-496ee7b51bce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5bbaf8-58ea-5ebe-a585-496ee7b51bce@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 02, 2022 at 08:29:15AM -0800, Russ Weight wrote:
> 
> On 12/1/22 22:02, Zhou, Jie2X wrote:
> >> The above message looks like the problem. Firmware sysfs fallback has been turned off
> >> on this system using sysctl. Can you try turning it on and rerunning the test?
> > Sorry, I don't know how to turn on firmware sysfs fallback.
> > Could you tell me?
> 
> Take a look at the kernel documentation (https://www.kernel.org/doc/html/v5.0/driver-api/firmware/fallback-mechanisms.html) which says, "This syfs fallback mechanism may be disabled completely on a system by setting the proc sysctl value ignore_sysfs_fallback to true."
> 
> Also refer to the sysctl man page: https://manpages.debian.org/testing/procps/sysctl.8.en.html.

I often see folks mis-running selftests, even thougggh in theory it
should be easy. And so I've added initial kernel selftests support to kdevops:

https://github.com/linux-kdevops/kdevops

So try to enable the selftests dedicated workflow, enable the firmware
test, enable building a linux-next kernel and go to town:

make menuconfig
make
make linux              # installs linux-next
make selftests          # builds selftests
make selftests-firwmare # runs the selftests for firmware

I think we have to up our timeout now for the firmware loader as its
currently failing as the tests now take a bit too long. Anyone oppose we
bump the firmware selftests to 200s ?

  Luis
