Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B371B222312
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGPM4m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgGPM4T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:19 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C686C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jul 2020 05:56:18 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vQ53Sk2z9sVY; Thu, 16 Jul 2020 22:56:13 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Sandipan Das <sandipan@linux.ibm.com>, mpe@ellerman.id.au
Cc:     linuxram@us.ibm.com, ruscur@russell.cc,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        fweimer@redhat.com, bauerman@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.ibm.com
In-Reply-To: <20200604125610.649668-1-sandipan@linux.ibm.com>
References: <20200604125610.649668-1-sandipan@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] selftests: powerpc: Fixes and execute-disable test for pkeys
Message-Id: <159490400411.3805857.17323999819214487510.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:56:13 +1000 (AEST)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 4 Jun 2020 18:26:07 +0530, Sandipan Das wrote:
> This fixes the way the Authority Mask Register (AMR) is updated
> by the existing pkey tests and adds a new test to verify the
> functionality of execute-disabled pkeys.
> 
> Previous versions can be found at:
> v2: https://lore.kernel.org/linuxppc-dev/20200527030342.13712-1-sandipan@linux.ibm.com/
> v1: https://lore.kernel.org/linuxppc-dev/20200508162332.65316-1-sandipan@linux.ibm.com/
> 
> [...]

Applied to powerpc/next.

[1/3] selftests/powerpc: Fix pkey access right updates
      https://git.kernel.org/powerpc/c/828ca4320d130bbe1d12866152600c49ff6a9f79
[2/3] selftests/powerpc: Move Hash MMU check to utilities
      https://git.kernel.org/powerpc/c/c405b738daf9d8e8a5aedfeb6be851681e65e54b
[3/3] selftests/powerpc: Add test for execute-disabled pkeys
      https://git.kernel.org/powerpc/c/1addb6444791f9e87fce0eb9882ec96a4a76e615

cheers
