Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E628FA41
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 22:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgJOUkt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 16:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732543AbgJOUks (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 16:40:48 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA9E2074A;
        Thu, 15 Oct 2020 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602794448;
        bh=Qm9cC9KFu3xj9C59JMqjeE0ma0wxuVFp57tRrXta47c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TamyK5L6fQP69CxylBIxgKfLSRQt6xSti4Z7Olh056rWLBYYm8IVFBGLpt+WSMRls
         fRGgoutQepv0FOH232SWDfRWM79EQE1jBRvAd4jx9BwOq7bvPr6HeRuFt0O95mgzbN
         BA9HxzQlKTYMLFcOE6Ca07sXvBVEkKL4umVYOnEo=
From:   Will Deacon <will@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mina Almasry <almasrymina@google.com>, lokeshgidra@google.com,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "H. Peter Anvin" <hpa@zytor.com>, surenb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        joelaf@google.com, Masahiro Yamada <masahiroy@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Price <steven.price@arm.com>, x86@kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, minchan@google.com,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Gavin Shan <gshan@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jia He <justin.he@arm.com>, Mike Rapoport <rppt@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        SeongJae Park <sjpark@amazon.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 0/5] Speed up mremap on large regions
Date:   Thu, 15 Oct 2020 21:40:30 +0100
Message-Id: <160275767389.2776006.15931668564498606994.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014005320.2233162-1-kaleshsingh@google.com>
References: <20201014005320.2233162-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 14 Oct 2020 00:53:05 +0000, Kalesh Singh wrote:
> This is a repost of the mremap speed up patches, adding Kirill's
> Acked-by's (from a separate discussion). The previous versions are
> posted at:
> v1 - https://lore.kernel.org/r/20200930222130.4175584-1-kaleshsingh@google.com
> v2 - https://lore.kernel.org/r/20201002162101.665549-1-kaleshsingh@google.com
> v3 - http://lore.kernel.org/r/20201005154017.474722-1-kaleshsingh@google.com
> 
> [...]

Applied just the arm64 PMD patch to arm64 (for-next/core), thanks!

[1/1] arm64: mremap speedup - Enable HAVE_MOVE_PMD
      https://git.kernel.org/arm64/c/45544eee9606

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
