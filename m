Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F392817C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgJBQWY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 12:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQWP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 12:22:15 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3826CC0613E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 09:22:13 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a20so1136535qvk.17
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=s/Xw/RBCO0n2Bno5i+4SkYcgbDI4qmMOMsdLQNIN2w0=;
        b=k9sKPkWtGuu4ZGWnqHoEmBSTPfyCRaLKxN4sh1GlVpxOGK13giY9J2fDvWDPjX3Clh
         TYH8Hre3GaZ8/nIA8+ifpHAGT+ghFEFLUdJ98i1yCBxhNJ9QrKzKR9vsuJdhGLMhk1zM
         jRbNpFUL/RIhh0uLkk4dGTeWDWn3Xsf8T9Mjf5+vyOSSIvFswNWS2pjJfJeYWvb1nllw
         YjhjQUal9ax2B4XfW6quUw5G3P9nvwUHIzfEgXNEhGVLdcNy8vs04A1WDWphoHtUThaq
         VAL43/lPVuz798l5kpoX7JUlKCQG4nshkFweKYl7tfdWKJASLiJBr6LEcZQmfobxorms
         K6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=s/Xw/RBCO0n2Bno5i+4SkYcgbDI4qmMOMsdLQNIN2w0=;
        b=CWHoupsQvCcxUyl9OUHUOK4mZcGB8Wkr7uQ8rvJXKK4ftBRK1xuMdjiTOT/a1nL8u0
         6w+bVlzvXpWKrcWDt6dVhweD/b0xdjoNuzjX7Wxf8M4LepGQNnBOhPJzLdxsUKRYaQVP
         kCTjmYB/exz2onAcFixCYpfsNdJEyLbBVtlihgJQrvh5WMunavJfqWLSMO2Ax3DSD1LC
         ZQXU73+VbJcRuTLqKi/7dKDiFqNvLX9dZGl2cdINiIH+2aOaLxhzBNVYuUhWHQ1zaG8n
         DiOCqyNkbxmmu0aM7GmODFxWtdlIfMfcrDNt7lsMvNJ8LXHWjsImqAYtfdMyS0DJonG4
         7CoQ==
X-Gm-Message-State: AOAM533zRiW+iiCccS+7CIEa+MI/H/dO0JrAM+vshQqYc+EQsMjwyKnc
        tK6gPwHqYgFCnkpvXphOYxSfSL5J/X8gMtbOmg==
X-Google-Smtp-Source: ABdhPJy1XYUcKvGqDmhG+SgmlzqCf1a7mFONorMqdUyr843tXA3FgfFHdqOZFCcNSS+Fax1oPNOyO7OdvdzrlXWIkQ==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:e904:: with SMTP id
 a4mr2730548qvo.26.1601655732278; Fri, 02 Oct 2020 09:22:12 -0700 (PDT)
Date:   Fri,  2 Oct 2020 16:20:49 +0000
In-Reply-To: <20201002162101.665549-1-kaleshsingh@google.com>
Message-Id: <20201002162101.665549-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201002162101.665549-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 4/6] arm64: Add set_pud_at() function
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

set_pud_at() is used in move_normal_pud() for remapping
pages at the PUD level.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d5d3fbe73953..8848125e3024 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -415,6 +415,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
+#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
 
 #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
 #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
-- 
2.28.0.806.g8561365e88-goog

