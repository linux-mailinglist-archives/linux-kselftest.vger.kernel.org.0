Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D672FF82E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jan 2021 23:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbhAUWrT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 17:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbhAUWrP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 17:47:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C867F23A61;
        Thu, 21 Jan 2021 22:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611269188;
        bh=96Z526pBbuqUE3z3L6f5CHO9G46NkdGHX9wOnkYrw4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FE+TJQtgLz9AxfV9MtnIhD3VwHTBtqYreaWHiScdgFDyz6n9wbVOgT2mEmSFbIygR
         4CbK9MItXsgMkSQTaTZcTt2MIJiGWdOHDxZwNUK4xv4aP9XCRpfbNikb7cwSqidx+O
         jO82+MkbvdL6lGQGjFROcRNzMsB/tuy24+FKhUV8=
Date:   Thu, 21 Jan 2021 14:46:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Message-Id: <20210121144627.64a60437fe97786596f389d0@linux-foundation.org>
In-Reply-To: <YAg+QHhczqtTZt4Z@kernel.org>
References: <20210118133310.98375-1-tianjia.zhang@linux.alibaba.com>
        <YAg+QHhczqtTZt4Z@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 20 Jan 2021 16:29:20 +0200 Jarkko Sakkinen <jarkko@kernel.org> wrote:

> 
> 
> On Mon, Jan 18, 2021 at 09:33:10PM +0800, Tianjia Zhang wrote:
> > Obviously, the error variable detection of the if statement is
> > for the mprotect callback function, so it is also put into the
> > scope of calling callbck.
> > 
> > Reported-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> No fixes tag, no description what this commit does. Nothing
> makes sense to me.

It's a little cleanup.  Makes the flow at this site consistent with the
other places where this function handles errors.  I added a bit to the
changelog mentioning this.


