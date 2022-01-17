Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920CF49000A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jan 2022 02:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiAQBpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jan 2022 20:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiAQBpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jan 2022 20:45:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA58C061574;
        Sun, 16 Jan 2022 17:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F94461035;
        Mon, 17 Jan 2022 01:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405A5C36AE3;
        Mon, 17 Jan 2022 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642383911;
        bh=DJAEq4o1jXgP9EWCpcvSu2ghyXyiKdYLzoB1nCwGiNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6iRZheW5ytv+6Z642c0d4i1vOORubSMquzUJ45cnPwMnEhia6oFVmANU/B3onUeZ
         HXEjSx+phfmMKyd51FQTXRWz2l4o+7N59s/lpofv/8Azdg8KZX62mbiwtcWIrOa1AW
         hP7nZbF27g2ihbOAkRCq+3/l4tfW5CXSFgKyp3ZLiNkvDy86ISmDgie4/EPLdxmU8Q
         CSwSV/uqJA6Xn6wQI3I1CRgYILSmmG4XhI3LpLIkfWX5PvMqQ1TmOQfOyq70dpWVgb
         /NCfWYuHk65IZ5jCLh1JZ8bLqgC6RqS+G+iqgpoMuk/2s06/RP0qlJWvdFgrJ00TMl
         caxUKCjIGIrlg==
Date:   Mon, 17 Jan 2022 03:44:59 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: tpm: add async space test with
 noneexisting handle
Message-ID: <YeTKG3qPxm2DJGCN@iki.fi>
References: <20220116012627.2031-1-tstruk@gmail.com>
 <20220116012627.2031-2-tstruk@gmail.com>
 <YeQs7Fy5NaK6m6Ar@iki.fi>
 <YeR6Z9a4Z3Xz79Tp@iki.fi>
 <070044a5-5468-1095-334f-67cf98eb30b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <070044a5-5468-1095-334f-67cf98eb30b3@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 16, 2022 at 02:43:32PM -0800, Tadeusz Struk wrote:
> On 1/16/22 12:04, Jarkko Sakkinen wrote:
> > $ b4 am20220116012627.2031-2-tstruk@gmail.com
> > Looking uphttps://lore.kernel.org/r/20220116012627.2031-2-tstruk%40gmail.com
> > Grabbing thread from lore.kernel.org/all/20220116012627.2031-2-tstruk%40gmail.com/t.mbox.gz
> > Analyzing 4 messages in the thread
> > Will use the latest revision: v4
> > You can pick other revisions using the -vN flag
> > Checking attestation on all messages, may take a moment...
> > ---
> >    ✓ [PATCH v4 1/2] tpm: Fix error handling in async work
> >      ✓ Signed: DKIM/gmail.com
> >      + Reviewed-by: Jarkko Sakkinen<jarkko@kernel.org>  (✓ DKIM/kernel.org)
> >    ERROR: missing [2/2]!
> > ---
> > Total patches: 1
> > ---
> > WARNING: Thread incomplete!
> >   Link:https://lore.kernel.org/r/20220116012627.2031-1-tstruk@gmail.com
> >   Base: applies clean to current tree
> >         git am ./v4_20220115_tstruk_tpm_fix_error_handling_in_async_work.mbx
> > 
> > The patch set is broken. It has patches from two different patch sets.
> > 
> > I saved the 2nd patch from my email client.
> 
> I'm not sure why it doesn't like it. They both are generated with the same
> git format-patch command. If you look at the source, the first one is:
> 
> Message-Id: <20220116012627.2031-1-tstruk@gmail.com>
> 
> and the second is:
> 
> Message-Id: <20220116012627.2031-2-tstruk@gmail.com>
> 
> and contains:
> 
> In-Reply-To: <20220116012627.2031-1-tstruk@gmail.com>
> References: <20220116012627.2031-1-tstruk@gmail.com>
> 
> Maybe it doesn't like the fact that the first in v4 and the second in v3?
> Do you need me to do anything else to get that applied?
> 
> --
> Thanks,
> Tadeusz

NP, Both are applied now.

BR, Jarkko
