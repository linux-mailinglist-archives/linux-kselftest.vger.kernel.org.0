Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563CA26B24E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 00:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgIOWpE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 18:45:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47791 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgIOPxy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 11:53:54 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kIDFF-0005NH-1g; Tue, 15 Sep 2020 15:51:49 +0000
Date:   Tue, 15 Sep 2020 17:51:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/15] selftests/seccomp: Refactor arch register macros
 to avoid xtensa special case
Message-ID: <20200915155148.ujvgr5o6apls7rob@wittgenstein>
References: <20200912110820.597135-1-keescook@chromium.org>
 <20200912110820.597135-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200912110820.597135-2-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 12, 2020 at 04:08:06AM -0700, Kees Cook wrote:
> To avoid an xtensa special-case, refactor all arch register macros to
> take the register variable instead of depending on the macro expanding
> as a struct member name.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
