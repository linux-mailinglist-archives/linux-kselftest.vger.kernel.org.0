Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A84453FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 14:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhKDNjP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 09:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhKDNjG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 09:39:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3B5661183;
        Thu,  4 Nov 2021 13:36:26 +0000 (UTC)
Date:   Thu, 4 Nov 2021 14:36:23 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     christian@brauner.io, shuah@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: clone3: clone3: add case CLONE3_ARGS_NO_TEST
Message-ID: <20211104133623.dfey3ryavuelwygz@wittgenstein>
References: <20211103201350.3866089-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211103201350.3866089-1-anders.roxell@linaro.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 03, 2021 at 09:13:50PM +0100, Anders Roxell wrote:
> Building selftests/clone3 with clang warns about enumeration not handled
> in switch case:
> 
> clone3.c:54:10: warning: enumeration value 'CLONE3_ARGS_NO_TEST' not handled in switch [-Wswitch]
>         switch (test_mode) {
>                 ^
> 
> Add the missing switch case with a comment.
> 
> Fixes: 17a810699c18 ("selftests: add tests for clone3()")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Fine by me. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
