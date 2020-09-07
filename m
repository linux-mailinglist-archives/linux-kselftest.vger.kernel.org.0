Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0F25F77C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgIGKPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 06:15:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59700 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgIGKPh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 06:15:37 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFEBT-0005SH-0R; Mon, 07 Sep 2020 10:15:35 +0000
Date:   Mon, 7 Sep 2020 12:15:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 4/9] signal: Expose SYS_USER_DISPATCH si_code type
Message-ID: <20200907101534.gjqbuivvjuyncbzb@wittgenstein>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-5-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:42PM -0400, Gabriel Krisman Bertazi wrote:
> SYS_USER_DISPATCH will be triggered when a syscall is sent to userspace
> by the Syscall User Dispatch mechanism.  This adjusts eventual
> BUILD_BUG_ON around the tree.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
