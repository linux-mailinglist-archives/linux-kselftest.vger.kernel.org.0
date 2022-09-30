Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875E95F1331
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiI3UHL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 16:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiI3UG6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 16:06:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290A169E54;
        Fri, 30 Sep 2022 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aTzelscJVlRGdPlgSnMe0y8WwyBDEIz1e4O/F9IzojM=; b=dOJenA3EpNxGQ455qmYgRD21Qd
        MzFXy2TTNoRYQuGLiZA/E9yz5PGrotRPYN3Qn3DJwY/LyXnhtS/6gfnF0pLKOcggJlivRrjaElsNs
        5Uvo/RoEuZde0/uwaJ9mI1Jb+nBWqicd0KvM3NmpgWQoPJ1zfUcHq09GWMUugNhWTK5p4oY7If1mO
        c2DEvwFORia0vcuPsIwp91DWFjFDjw/ZDSECAV7xGTPvwF/SdtpADdAkPXYOOSnOeIritDXHn+zCD
        rSPfDBlDcf+l4sNFIfNAae3dA+HQ6/Fq+Bl94waycGzSdtZq5BNHgQbbTIU+hRWv84v+Kp1NGKeTx
        LbPHIXTA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oeMHa-00BJdR-Gw; Fri, 30 Sep 2022 20:06:50 +0000
Date:   Fri, 30 Sep 2022 13:06:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     joe@perches.com, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] SPDX: add copyleft-next-0.3.1
Message-ID: <YzdMWr84Z8mgbfWS@bombadil.infradead.org>
References: <20220914060147.1934064-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914060147.1934064-1-mcgrof@kernel.org>
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

On Tue, Sep 13, 2022 at 11:01:45PM -0700, Luis Chamberlain wrote:
> As suggested by Thomas Gleixner, I'm following up to move on with
> the SPDX tag needed for copyleft-next-0.3.1. I've split this out
> from the test_sysfs selftest so to separate review from that.
> 
> Changes on this v10:
> 
>   o embraced paragraph from Thomas Gleixner which helps explain why             
>     the OR operator in the SPDX license name
>   o dropped the GPL-2.0 and GPL-2.0+ tags as suggested by Thomas Gleixner
>     as these are outdated (still valid) in the SPDX spec
>   o trimmed the Cc list to remove the test_sysfs / block layer / fs folks as
>     the test_sysfs stuff is now dropped from consideration in this series
> 
> The last series was at v9 but it also had the test_sysfs and its
> changes, its history can be found here:
> 
> https://lore.kernel.org/all/20211029184500.2821444-1-mcgrof@kernel.org/
> 
> Luis Chamberlain (2):
>   LICENSES: Add the copyleft-next-0.3.1 license
>   testing: use the copyleft-next-0.3.1 SPDX tag

*poke*

  Luis
