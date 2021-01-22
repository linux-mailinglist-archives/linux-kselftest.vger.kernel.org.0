Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDDA300A38
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 18:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbhAVRmu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jan 2021 12:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbhAVRjE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jan 2021 12:39:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACA7023A68;
        Fri, 22 Jan 2021 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337104;
        bh=ge6tFCsU5h0tS9yUo8/3zw0PVb/UhI5wMta1OpY7wJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdHV/9mKBWfKxkyGt65UDS6nh7Gm9zzC1uQDDgz/6Pz7OaUPM9Q4WCyNK2PK/C8PQ
         3NwtLe6z1bbfmkR+ujUgNpLDHoedMnaDDKFwvp0On8N7ftz4fs9cdC8U3K1ANnH9iF
         ZPdj5xV4FgGXlRK5CRpnAOKHVG00PHS7o2PpR+Kx3sokVMJ7rNobRgs7g6Oy/VSlnt
         4s+pke/pNHhdVr6HmuxgVtM8hR53oySrrNI9UvWOP6vGCft+97Ke6q18/MYG3t8+tZ
         yMAhXRcFoKATyn68lVD3MU6NXocopg8y4uhy1MzbXPHRinVlZiSnT4vTBkakYYnvQf
         ICjAiRvM+ylIA==
Date:   Fri, 22 Jan 2021 19:38:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        haitao.huang@intel.com, Kai Huang <kai.huang@intel.com>,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] mm: Optimizing error condition detection in
 do_mprotect_pkey()
Message-ID: <YAsNja81xnhvRGsL@kernel.org>
References: <20210118133310.98375-1-tianjia.zhang@linux.alibaba.com>
 <YAg+QHhczqtTZt4Z@kernel.org>
 <20210121144627.64a60437fe97786596f389d0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121144627.64a60437fe97786596f389d0@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 21, 2021 at 02:46:27PM -0800, Andrew Morton wrote:
> On Wed, 20 Jan 2021 16:29:20 +0200 Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > 
> > 
> > On Mon, Jan 18, 2021 at 09:33:10PM +0800, Tianjia Zhang wrote:
> > > Obviously, the error variable detection of the if statement is
> > > for the mprotect callback function, so it is also put into the
> > > scope of calling callbck.
> > > 
> > > Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > 
> > No fixes tag, no description what this commit does. Nothing
> > makes sense to me.
> 
> It's a little cleanup.  Makes the flow at this site consistent with the
> other places where this function handles errors.  I added a bit to the
> changelog mentioning this.

Alright, I see. I'm just used to getting feedback to my own patches
that "imperative form" of expression should be rigidly used. That's the
main reason I gave the feedback.

/Jarkko
