Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6698B271C5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Sep 2020 09:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIUHye (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Sep 2020 03:54:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49555 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIUHye (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Sep 2020 03:54:34 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kKGee-0001xR-V7; Mon, 21 Sep 2020 07:54:33 +0000
Date:   Mon, 21 Sep 2020 09:54:32 +0200
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
Subject: Re: [PATCH v2 4/4] selftests/clone3: Avoid OS-defined clone_args
Message-ID: <20200921075432.u4gis3s2o5qrsb5g@wittgenstein>
References: <20200919080637.259478-1-keescook@chromium.org>
 <20200919080637.259478-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200919080637.259478-5-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 19, 2020 at 01:06:37AM -0700, Kees Cook wrote:
> As the UAPI headers start to appear in distros, we need to avoid outdated
> versions of struct clone_args to be able to test modern features;
> rename to "struct __clone_args". Additionally update the struct size
> macro names to match UAPI names.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Looks good, thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
