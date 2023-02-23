Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594676A0EFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBWSEZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 13:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBWSEY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 13:04:24 -0500
X-Greylist: delayed 380 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 10:04:21 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16555078;
        Thu, 23 Feb 2023 10:04:21 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4PN12v2tLjz1r15j;
        Thu, 23 Feb 2023 18:57:59 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4PN12v1P5vz1qqlR;
        Thu, 23 Feb 2023 18:57:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id swIsH1ONtk6g; Thu, 23 Feb 2023 18:57:58 +0100 (CET)
X-Auth-Info: 1HGqSa/xXAv0pLUXFyDppgnfnh819edct4rbXVxL1P4Kkf6OeDFZTxemhhugNskc
Received: from igel.home (aftr-82-135-86-224.dynamic.mnet-online.de [82.135.86.224])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 23 Feb 2023 18:57:58 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id EC43C2C154C; Thu, 23 Feb 2023 18:57:57 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "simo@redhat.com" <simo@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
        <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
        <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
        <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
        <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
X-Yow:  BEEP-BEEP!!  I'm a '49 STUDEBAKER!!
Date:   Thu, 23 Feb 2023 18:57:57 +0100
In-Reply-To: <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com> (Chuck Lever,
        III's message of "Thu, 23 Feb 2023 16:18:44 +0000")
Message-ID: <87mt54e02i.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Feb 23 2023, Chuck Lever III wrote:

> Assuming that "PC:" on m68k is the same as "RIP:" on x86...
> this does not make sense. rfc6803_suite is not a function.

That can mean that something has overwritten the return PC.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
