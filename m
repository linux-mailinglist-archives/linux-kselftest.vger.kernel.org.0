Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977B336EBDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbhD2ODu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 10:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbhD2ODt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:49 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AF9C06138B;
        Thu, 29 Apr 2021 07:03:03 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJf5GZHz9t15; Fri, 30 Apr 2021 00:02:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Yang Li <yang.lee@linux.alibaba.com>, shuah@kernel.org
Cc:     paulus@samba.org, linux-kselftest@vger.kernel.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <1612780870-95890-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612780870-95890-1-git-send-email-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH] selftests/powerpc: remove unneeded semicolon
Message-Id: <161970488494.4033873.16008307098207126624.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 8 Feb 2021 18:41:10 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./tools/testing/selftests/powerpc/nx-gzip/gzfht_test.c:327:4-5: Unneeded
> semicolon

Applied to powerpc/next.

[1/1] selftests/powerpc: remove unneeded semicolon
      https://git.kernel.org/powerpc/c/0db11461677aa5105b9ebbd939aee0ceb77a988b

cheers
