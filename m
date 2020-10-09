Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5872288845
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbgJIMFk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 08:05:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57121 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbgJIMFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 08:05:40 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kQr9W-0008EA-Pg; Fri, 09 Oct 2020 12:05:38 +0000
Date:   Fri, 9 Oct 2020 14:05:38 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 09/13] selftests: android: fix multiple definition of
 sock_name
Message-ID: <20201009120538.45uspbezh5tqtin6@wittgenstein>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-10-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-10-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:29PM +0300, Tommi Rantala wrote:
> Fix multiple definition of sock_name compilation error:
> 
>   tools/testing/selftests/android/ion/ipcsocket.h:8: multiple definition of `sock_name'
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---

Ion will be removed from the kernel soon but this seems like an ok
bugfix.
Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
