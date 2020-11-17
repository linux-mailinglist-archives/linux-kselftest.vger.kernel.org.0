Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2CC2B70A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKQVIR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:08:17 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:60259 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgKQVIQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:08:16 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kf8D0-002xz3-MW; Tue, 17 Nov 2020 22:08:14 +0100
Received: from p5b13ac4a.dip0.t-ipconnect.de ([91.19.172.74] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kf8D0-0031O9-E9; Tue, 17 Nov 2020 22:08:14 +0100
Subject: Re: [PATCH] selftests/seccomp: sh: Fix register names
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
References: <20201117205656.1000223-1-keescook@chromium.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <921a7e36-8b58-4a59-029a-066f5a05859e@physik.fu-berlin.de>
Date:   Tue, 17 Nov 2020 22:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117205656.1000223-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.172.74
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees!

On 11/17/20 9:56 PM, Kees Cook wrote:
> It looks like the seccomp selftests were never actually built for sh.
> This fixes it, though I don't have an environment to do a runtime test
> of it yet.

We were testing libsecomp itself but I think we might have forgotten the
self-test. Not sure how these are run.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

