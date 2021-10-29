Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B343F536
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 05:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhJ2DKn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 23:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhJ2DKm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 23:10:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7509460E73;
        Fri, 29 Oct 2021 03:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635476895;
        bh=rcFijOokhBYoREUdIW7nvJYgzDFRwYCbkztI1xQYVmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOYa3tUi9tfZpCDRBF3sXsgoQk8bPaS4G2dOw+K66TAtwlvY77khAAFO7dvlDdkWK
         +lAjFLXy1WqQIaANb1J+wGc/BGGgd+LnYJtc+TgD+OigquQbbCQwhRp7x8nBmheqT5
         BJ7FR/gHqNN5WXbkwXeTfsYDGKj08G28UXiAV2AXubLG8AelIr3H2UarYT6KqsJ19j
         C5TiNCa1JiH/U9fxx92jGfwqsgRbxmKg9ktJBtz5UPhJN+DyV3Nc96woCCVfy/IZlr
         3+tk4qHB5HuFA3ja3ncHK3GQ6DGQfXukV+P0Wf+2xrH/4AIEX5cjvh7IEYaqBWetai
         qIpbe8RbASjog==
Date:   Fri, 29 Oct 2021 06:08:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com, seanjc@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 13/15] selftests/sgx: Add page permission and
 exception test
Message-ID: <YXtlnORs1545GXvq@iki.fi>
References: <cover.1635447301.git.reinette.chatre@intel.com>
 <85dd8852e85cd1fcdf70f5b6be9389b6df096b0d.1635447301.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85dd8852e85cd1fcdf70f5b6be9389b6df096b0d.1635447301.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 28, 2021 at 01:37:38PM -0700, Reinette Chatre wrote:
> The Enclave Page Cache Map (EPCM) is a secure structure used by the
> processor to track the contents of the enclave page cache. The EPCM
> contains permissions with which enclave pages can be accessed. SGX
> support allows EPCM and PTE page permissions to differ - as long as
> the PTE permissions do not exceed the EPCM permissions.
> 
> Add a test that:
> (1) Creates an SGX enclave page with writable EPCM permission.
> (2) Changes the PTE permission on the page to read-only. This should
>     be permitted because the permission does not exceed the EPCM
>     permission.
> (3) Attempts a write to the page. This should generate a page fault
>     (#PF) because of the read-only PTE even though the EPCM
>     permissions allow the page to be written to.
> 
> This introduces the first test of SGX exception handling. In this test
> the issue that caused the exception (PTE page permissions) can be fixed
> from outside the enclave and after doing so it is possible to re-enter
> enclave at original entrypoint with ERESUME.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
