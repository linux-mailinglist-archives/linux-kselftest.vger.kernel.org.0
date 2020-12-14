Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541D52DA35E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Dec 2020 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440204AbgLNW2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Dec 2020 17:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbgLNW1y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Dec 2020 17:27:54 -0500
Date:   Mon, 14 Dec 2020 14:27:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607984833;
        bh=xyP2b8Vm21p2QLiFLD3yX3hc/KptPq+Mkcjz6M02CkY=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=HrFJiy9iXJ8LuUJifJJKJKKaFaNc2qPhLDL88PM/hq25WNuNOZhGO9EwVIfyAeBgR
         6pQWafGegoQsRB/4RxQo/jkSVjjz7fsjF//IeLw0fgNpFMMPAYtQ3HvpJzbVoHsImA
         Pr/5gi4RDszx01ljnw/99FPdw9bbLfDNO/wXR9I0=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Harish <harish@linux.ibm.com>
Cc:     shuah@kernel.org, sandipan@linux.ibm.com, jhubbard@nvidia.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        bgeffon@google.com, almasrymina@google.com, suxingxing@loongson.cn,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/vm: Fix building protection keys test
Message-Id: <20201214142712.d69187b0a82504f67916696e@linux-foundation.org>
In-Reply-To: <20201214163951.141399-1-harish@linux.ibm.com>
References: <20201214163951.141399-1-harish@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 14 Dec 2020 22:09:51 +0530 Harish <harish@linux.ibm.com> wrote:

> The previous patch

d8cbe8bfa7d ("tools/testing/selftests/vm: fix build error"), yes?

> tries to include a arch check for powerpc using
> findstring, which prevents test from building on powerpc arch.

Why is that?  Please describe the error fully.  Presumably by pasting
the error messages?

> Fix
> this with filtering using machine type.

How does this fix whatever-the-problem-was?

Presumably the 5.10 build fails under some circumstances, yes?  In
which case a Fixes: line and a cc:stable@vger.kernel.org are needed.

> Signed-off-by: Harish <harish@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 691893afc15d..0dc632cdbc73 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -61,7 +61,7 @@ TEST_GEN_FILES += $(BINARIES_64)
>  endif
>  else
>  
> -ifneq (,$(findstring $(ARCH),powerpc))
> +ifneq (,$(filter $(MACHINE),ppc64 ppc64le))
>  TEST_GEN_FILES += protection_keys
>  endif
>  
> -- 
> 2.26.2
