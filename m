Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844346C49EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCVMIy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 08:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCVMIx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 08:08:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0CE1B565;
        Wed, 22 Mar 2023 05:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA89B81C6C;
        Wed, 22 Mar 2023 12:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A569DC433D2;
        Wed, 22 Mar 2023 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679486930;
        bh=sJgqKtzzq3ORWa9DfGXW323DtqlfE2Drg0E8BukAMlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLjSCToO82eR1amnA3qQHvVMdhrGc2jiFxdfFo85O9HqsaVg5qqg24nywG8tW1PfS
         iEENAPBQ+K2SzSX6DQRAnhJzUB1m7n5y6N5JFz1mO/2kLffrVgOD5nXpaTkDK1ZbTD
         zos8rNaRYxgUf8Hlts4Ik9t//juUasJLBG9s3xEY=
Date:   Wed, 22 Mar 2023 13:08:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Message-ID: <ZBrvzypQoNu7SD27@kroah.com>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
> The creation of a dummy device in order to test managed interfaces is a
> generally useful test feature. The drm test helpers
> drm_kunit_helper_alloc_device() and drm_kunit_helper_free_device()
> are doing exactly this. It makes no sense that each and every component
> which intends to be testing managed interfaces will create similar
> helpers so stole these for more generic use.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Changes:
> v4 => v5:
> - Add accidentally dropped header and email recipients
> - do not rename + move helpers from DRM but add temporary dublicates to
>   simplify merging. (This patch does not touch DRM and can be merged
>   separately. DRM patch and IIO test patch still depend on this one).
> 
> Please note that there's something similar ongoing in the CCF:
> https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/
> 
> I do like the simplicity of these DRM-originated helpers so I think
> they're worth. I do equally like the Stephen's idea of having the
> "dummy platform device" related helpers under drivers/base and the
> header being in include/kunit/platform_device.h which is similar to real
> platform device under include/linux/platform_device.h
> ---
>  drivers/base/test/Kconfig             |  5 ++
>  drivers/base/test/Makefile            |  2 +
>  drivers/base/test/test_kunit_device.c | 83 +++++++++++++++++++++++++++

By putting files in this directory, you are asking me to maintain this
code, and right now, I can't agree with that, sorry.  See my review
comments on it for why.

thanks,

greg k-h
