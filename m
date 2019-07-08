Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD4618C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2019 03:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfGHBTs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Jul 2019 21:19:48 -0400
Received: from ozlabs.org ([203.11.71.1]:44261 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbfGHBTo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:44 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hng20xqlz9sNs; Mon,  8 Jul 2019 11:19:42 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7b570361f6f66c91443541b19121038c076e7d64
In-Reply-To: <20190617145204.6810-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: Add missing newline at end of file
Message-Id: <45hng20xqlz9sNs@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:42 +1000 (AEST)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2019-06-17 at 14:52:04 UTC, Geert Uytterhoeven wrote:
> "git diff" says:
> 
>     \ No newline at end of file
> 
> after modifying the file.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7b570361f6f66c91443541b19121038c076e7d64

cheers
