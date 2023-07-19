Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40131758E19
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGSGt3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 02:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGSGt2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 02:49:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652261BFD;
        Tue, 18 Jul 2023 23:49:25 -0700 (PDT)
X-QQ-mid: bizesmtp74t1689749354thyo62hs
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 14:49:13 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4nd9/ZbK/RUbfRAvSWblvBDYwoNO0gdsY4OJgmVvLnupcSf+Ho2G
        z+thUIxNFXCqBZtohM718SgDflaStVKFfp7lGFFF9T2s7BWePEy7j1wMTNRNgnZrSUMzmNx
        Sdqvka3W+oGOlfkW6cMVGIzFVZ+DGrWr5sznNggvSarxja0IDnKMed5E4fR/l+3Uo/rhzqL
        W5Hv9I8dt+TfYDVDtgLFqDsUWKF+QepPhqB3CDYsZCXI2+Vffsc9Q6bSHh/b5PI3/GAH/MZ
        NtP6Ozooezdiu/2vLkCcB9Xoizm1d303ytrQamkROgfHTF8whOZcPbUm0XunfmWJcoLpIgz
        M0NHrzdMvfVsRv1l/EbIlJxOptpWtDHTo6Xy9GvPjg0CU7iugDPZEsAwB17lw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9261781467462137373
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 3/8] selftests/nolibc: select_null: fix up for big endian powerpc64
Date:   Wed, 19 Jul 2023 14:49:12 +0800
Message-Id: <20230719064912.59792-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719043353.GC5331@1wt.eu>
References: <20230719043353.GC5331@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Wed, Jul 19, 2023 at 07:56:37AM +0800, Zhangjin Wu wrote:
> > It made me recalled I have at last disabled (not enabled for tinyconfig) the following options:
> > 
> >     CONFIG_ALTIVEC
> >     CONFIG_VSX --> This option enables kernel support for the Vector Scaler extensions
> > 
> > Or we can disable the vsx instructions explicitly:
> > 
> >     -mno-vsx
> > 
> > Both of them work well, but I prefer -mno-vsx for to get a faster build, what about you?
> > 
> >     +CFLAGS_powerpc64 = -m64 -mbig-endian -Wl,-EB,-melf64ppc -mno-vsx
> >     +CFLAGS_powerpc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
> > 
> > So, this patch itself is wrong, let's drop it from the next revision.
> 
> Better explicitly disable it in the CFLAGS (2nd option) if we want to
> make sure we don't want to rely on this, at least for portability
> purposes.

Ok, thanks, have updated CFLAGS in these two patches locally:

    [PATCH v1 7/8] selftests/nolibc: add test support for powerpc64le
    [PATCH v1 8/8] selftests/nolibc: add test support for powerpc64

what about the other ones? I'm ready to send v2 ;-)

Best regards,
Zhangjin

> 
> Willy
