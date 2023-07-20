Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E875A60D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 08:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGTGLt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 02:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGTGLs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 02:11:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04971985;
        Wed, 19 Jul 2023 23:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689833495; bh=O7SOTrjSXooLoE40Zt5wmlSeIeoQuEl79RrevjNNK74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUL8bCaEJhVPh2qxmdPsXjm0AHMhgbY7zBo7aKoHF69g4oLA/vx+8ySBS+t/iFRoG
         ha5iWAQUkEyQ25a/8QnRy9774zR4ZB/OjFp9llcsQQhWu3+z41DmZgCIpjV+gujSGS
         o/BQuI5NNeFClNRTx/dcMWBzr+XYRHR7WEz4lrB0=
Date:   Thu, 20 Jul 2023 08:11:32 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/8] selftests/nolibc: select_null: fix up for big
 endian powerpc64
Message-ID: <c332c69e-d12a-4a7b-8f95-50515a43304e@t-8ch.de>
References: <20230719043353.GC5331@1wt.eu>
 <20230719064912.59792-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719064912.59792-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On 2023-07-19 14:49:12+0800, Zhangjin Wu wrote:
> > On Wed, Jul 19, 2023 at 07:56:37AM +0800, Zhangjin Wu wrote:
> > > It made me recalled I have at last disabled (not enabled for tinyconfig) the following options:
> > > 
> > >     CONFIG_ALTIVEC
> > >     CONFIG_VSX --> This option enables kernel support for the Vector Scaler extensions
> > > 
> > > Or we can disable the vsx instructions explicitly:
> > > 
> > >     -mno-vsx
> > > 
> > > Both of them work well, but I prefer -mno-vsx for to get a faster build, what about you?
> > > 
> > >     +CFLAGS_powerpc64 = -m64 -mbig-endian -Wl,-EB,-melf64ppc -mno-vsx
> > >     +CFLAGS_powerpc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
> > > 
> > > So, this patch itself is wrong, let's drop it from the next revision.
> > 
> > Better explicitly disable it in the CFLAGS (2nd option) if we want to
> > make sure we don't want to rely on this, at least for portability
> > purposes.
> 
> Ok, thanks, have updated CFLAGS in these two patches locally:
> 
>     [PATCH v1 7/8] selftests/nolibc: add test support for powerpc64le
>     [PATCH v1 8/8] selftests/nolibc: add test support for powerpc64
> 
> what about the other ones? I'm ready to send v2 ;-)

Unfortunately I won't have the time for a proper review this week.

Thomas
