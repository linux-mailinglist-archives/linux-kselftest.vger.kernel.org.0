Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D944828883F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgJIMEm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 08:04:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732585AbgJIMEm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 08:04:42 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kQr8a-00088p-QI; Fri, 09 Oct 2020 12:04:40 +0000
Date:   Fri, 9 Oct 2020 14:04:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 07/13] selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y
 to config
Message-ID: <20201009120440.46yaiov5f5koryue@wittgenstein>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-8-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-8-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:27PM +0300, Tommi Rantala wrote:
> kcmp syscall is used in pidfd_getfd_test.c, so add
> CONFIG_CHECKPOINT_RESTORE=y to config to ensure kcmp is available.
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---

Good catch, thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
