Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE1271C48
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Sep 2020 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIUHue (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Sep 2020 03:50:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUHud (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Sep 2020 03:50:33 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kKGam-0001nP-0O; Mon, 21 Sep 2020 07:50:32 +0000
Date:   Mon, 21 Sep 2020 09:50:31 +0200
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
Subject: Re: [PATCH v2 2/4] selftests/seccomp: Allow syscall nr and ret value
 to be set separately
Message-ID: <20200921075031.j4gruygeugkp2zwd@wittgenstein>
References: <20200919080637.259478-1-keescook@chromium.org>
 <20200919080637.259478-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200919080637.259478-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 19, 2020 at 01:06:35AM -0700, Kees Cook wrote:
> In preparation for setting syscall nr and ret values separately, refactor
> the helpers to take a pointer to a value, so that a NULL can indicate
> "do not change this respective value". This is done to keep the regset
> read/write happening once and in one code path.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Looks good!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
