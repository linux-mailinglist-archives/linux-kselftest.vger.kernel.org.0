Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463512DD592
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgLQQ7M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 11:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQQ7K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 11:59:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F3AC061794;
        Thu, 17 Dec 2020 08:58:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608224308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BfeG9stxOsSpjRYXj7Js+sXxnOSrg6f7PFi1tBPvTk4=;
        b=gBt8MjRwIBoZoOeRr2iv95diwya5Pn0IUF0cU39dmJIhU7C9g+sbPkGpiPSqGHzNVwKtDS
        Xebun5owJ8k+ANh+8c0GWB+05QGhsw5KAcBBaS6D+JrDVzMI/TKSy6DG+w/+ZCUJmtTY5D
        +i8C5pHMQYcdLgBTjcVfO3mGh8TlhZc8gB9nhauvVIBqeUXg5M+/0ysikjITOcokAeDkJd
        L+YVwS6Fdxdeuz2l35ol/TuD+YD5rlv/Pv0DupbkIoORNb84qEnTPe1nB+J9E3JjQtUabc
        usFUtM5tTrGUzWYXB2IJZs/PvBxPNuAIYQ0XIdXEbKQ/LoKy3j0BoiipJxmPQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608224308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BfeG9stxOsSpjRYXj7Js+sXxnOSrg6f7PFi1tBPvTk4=;
        b=dn3W9hQ1peESFmJ2swDmnwnBERH9a1KMBLetWpglvwv9bYVzv/pp+RbTDpNLyrNb0+nCvp
        vsP9GutiQJM3cYDg==
To:     ira.weiny@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
In-Reply-To: <20201124060956.1405768-1-ira.weiny@intel.com>
References: <20201106232908.364581-6-ira.weiny@intel.com> <20201124060956.1405768-1-ira.weiny@intel.com>
Date:   Thu, 17 Dec 2020 17:58:28 +0100
Message-ID: <87v9d0qsi3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 23 2020 at 22:09, ira weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>
> Currently struct irqentry_state_t only contains a single bool value
> which makes passing it by value is reasonable.  However, future patches
> add information to this struct.  This includes the PKRS thread state,
> included in this series, as well as information to store kmap reference
> tracking and PKS global state outside this series. In total, we
> anticipate 2 new 32 bit fields and an integer field to be added to the
> struct beyond the existing bool value.

Well yes, but why can't you provide at least in the comment section
below the '---' a pointer to the latest version of this reference muck
and PKS global state if you can't explain at least the concept of the
two things here?

It's one thing that you anticipate something but a different thing
whether it's the right thing to do.

Thanks,

        tglx
