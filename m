Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB226B118
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgIOWYj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 18:24:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49602 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbgIOQXq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 12:23:46 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kIDOE-00061Q-NV; Tue, 15 Sep 2020 16:01:06 +0000
Date:   Tue, 15 Sep 2020 18:01:05 +0200
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
Subject: Re: [PATCH 07/15] selftests/seccomp: Remove syscall setting #ifdefs
Message-ID: <20200915160105.sqo7x2qyt6uwzphx@wittgenstein>
References: <20200912110820.597135-1-keescook@chromium.org>
 <20200912110820.597135-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200912110820.597135-8-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 12, 2020 at 04:08:12AM -0700, Kees Cook wrote:
> With all architectures now using the common SYSCALL_NUM_SET() macro, the
> arch-specific #ifdef can be removed from change_syscall() itself.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
