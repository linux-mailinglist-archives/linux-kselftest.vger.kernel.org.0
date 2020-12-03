Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60162CDA57
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 16:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgLCPsC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 10:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLCPsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 10:48:01 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC3C061A51
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 07:47:21 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so3038514ljj.6
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ayfcs9PdWYm7lbPtI7skq4RBm0f2Hr2bSO79nAHtFc=;
        b=qeNyZ8YsBRIcSSEnxPslZwdaQzbHNHWQrVBr58zRszE0F8P9QlO9s+F6Eup0AC7FxW
         QCI9RwkC5r87S1DcMFuQ0LGorDW6hc5tvP0HfgHeOOAQ4yRiIDrmcnabMErr46z25doA
         KuS+R05984StHPoMfsXc6p3fX8UtHh/OTtoHz+R5rvw8+PEVFCbi/ODbvauIcTOeBy/l
         LjY8bfJMs0j0jbctFehRcbnTYB5vfU33O6FRUX3G3dJeEzqE4yjZP8cwtzrXBtIu4V9x
         qG8OhxlOwT0sXfEVrrlcH+U1SXqjVUNsoLXauBwPRBppDacfBHal0+6hTivZDoWfPiUF
         I5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ayfcs9PdWYm7lbPtI7skq4RBm0f2Hr2bSO79nAHtFc=;
        b=FwfM2IHG0Sravs42N7Cxj+pxrlc55+CD5Gs5wnYZizkXSa5jnElchqtqL3gKTjc9It
         PDtF6s1FITS5YK5JGeuOqJlTPPqzYTn4/urnZMMkrxLT4TVC2DQWbaO3NZ6VR1ZkafL6
         Ek9XZ2ssHaguQttf6WLwj0hQjuUc/bw2Pv1k0SYKhBQp1Kfb3tR84+aJD9a9kda1BHT5
         ASKjYmaMZ0JmvWfhglo5mge5NVmoB7vZaVTk0MILsLS7SIGOByrK1IPiFh5iL0LRjV5p
         M0VBKKPNzoLcXznOSNwVZXAk2Nq6DWVdilE2vYhoXRX7D4/MocIgiOfPAhVsxZzAO2mH
         wFPQ==
X-Gm-Message-State: AOAM530Cib3X7EftITDmdZhlmyuckqWmSI332bwQgHxRQw+D5rSbQRmM
        QU3hsOdRf5u3xyz5bMa3xhFfmGceVDckhY8gMLlojw==
X-Google-Smtp-Source: ABdhPJwIWQzmwxHBiRB8EE+s5XaHTO5aY/OfRodwgESsla0us6E0o0PYvgEf52SU6B5EtE5PNDOv6vNy/ZwtEjOqjbg=
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr1526064lja.192.1607010439133;
 Thu, 03 Dec 2020 07:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20201203062949.5484-1-rppt@kernel.org> <20201203062949.5484-8-rppt@kernel.org>
In-Reply-To: <20201203062949.5484-8-rppt@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Dec 2020 07:47:07 -0800
Message-ID: <CALvZod5-r+TmuAYS7ErpSPdF0RKN_F_CbNMoXQdqONbhPxunTg@mail.gmail.com>
Subject: Re: [PATCH v14 07/10] secretmem: add memcg accounting
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 2, 2020 at 10:31 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
