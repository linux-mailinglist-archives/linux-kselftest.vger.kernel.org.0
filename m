Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5DE3AC1F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFREZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 00:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhFREZE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:04 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F461C061768;
        Thu, 17 Jun 2021 21:22:55 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4F2rwbz9sfG; Fri, 18 Jun 2021 14:22:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0ad62673d3e063f848e7c99d719bb966efd433e8.1622809833.git.christophe.leroy@csgroup.eu>
References: <0ad62673d3e063f848e7c99d719bb966efd433e8.1622809833.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/selftests: Use gettid() instead of getppid() for null_syscall
Message-Id: <162398829644.1363949.13696130535208062444.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 4 Jun 2021 12:31:09 +0000 (UTC), Christophe Leroy wrote:
> gettid() is 10% lighter than getppid(), use it for null_syscall selftest.

Applied to powerpc/next.

[1/1] powerpc/selftests: Use gettid() instead of getppid() for null_syscall
      https://git.kernel.org/powerpc/c/a1ea0ca8a6f17d7b79bbc4d05dd4e6ca162d8f15

cheers
