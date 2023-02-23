Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98816A0F8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjBWSfS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 13:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBWSfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 13:35:15 -0500
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 10:35:14 PST
Received: from welho-filter3.welho.com (welho-filter3b.welho.com [83.102.41.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589B5AB72
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 10:35:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by welho-filter3.welho.com (Postfix) with ESMTP id 176A414C59;
        Thu, 23 Feb 2023 20:28:44 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from welho-smtp3.welho.com ([IPv6:::ffff:83.102.41.86])
        by localhost (welho-filter3.welho.com [::ffff:83.102.41.25]) (amavisd-new, port 10024)
        with ESMTP id zMygM_G5Jxhj; Thu, 23 Feb 2023 20:28:43 +0200 (EET)
Received: from [192.168.0.20] (89-27-41-239.bb.dnainternet.fi [89.27.41.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by welho-smtp3.welho.com (Postfix) with ESMTPSA id B4B992316;
        Thu, 23 Feb 2023 20:28:40 +0200 (EET)
Message-ID: <3c68d40f-ee1c-4a35-9cb9-fde2dc62e8ed@helsinkinet.fi>
Date:   Thu, 23 Feb 2023 20:28:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
References: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
 <b3e0b5e6-1d0-cdb2-186c-6b4f50e0a3aa@linux-m68k.org>
 <D5221DC2-2A9C-43DC-AC21-FA96E7F76E5B@oracle.com>
 <CAMuHMdVtsZ-jU5foR7V_4XeXT_0f3Nx5vfoJo5pH2jMga0SpWA@mail.gmail.com>
 <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
Content-Language: en-US
From:   Eero Tamminen <oak@helsinkinet.fi>
In-Reply-To: <58CCF033-58C3-4AF0-B958-BE1AAF1695F3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 23.2.2023 18.18, Chuck Lever III wrote:
> Since I cannot reproduce this crash and do not have an m68k
> platform available to me, I will need you to continue to
> pursue the issue. I'll help as much as I can.

There are multiple m68k emulators that can run m68k Linux.  At least 
Qemu, WinUAE, Aranym and Hatari.

Of those, Qemu, Aranym & Hatari are available directly from Debian:
* https://packages.debian.org/bookworm/qemu-system-misc
* https://packages.debian.org/bookworm/aranym
* https://packages.debian.org/bookworm/hatari

Crypto in general is very (too) slow on ancient HW which does not have 
any crypto instructions or acceleration, so I would avoid emulators that 
aim for cycle accuracy with old HW (WinUAE & Hatari).

Qemu can be used to test also other platforms than m68k, and its usage 
may be easier to automate for your CI than Aranym, so you could try that 
(not necessarily starting with m68k).


	- Eero
