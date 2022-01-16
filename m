Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6448FEBB
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jan 2022 21:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiAPUFL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jan 2022 15:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiAPUFK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jan 2022 15:05:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638DC061574;
        Sun, 16 Jan 2022 12:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E5B660FD2;
        Sun, 16 Jan 2022 20:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F049C36AE3;
        Sun, 16 Jan 2022 20:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642363507;
        bh=A85c+Fu/0O4TFNO1oOCEADK5/7B4PXDkUy09FFdhXZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfmZEwJrnxyYBqUgmOymoQXv7kk33Fh9nYmQqwjWMlSxOFQfLCsyYbaoLfRl+2554
         R/MwmkUvJIwR9mIuwq04HCShLx6xV4jXAOkAm+lu4DizMyQ74FjvVyXhqsTblzbs/e
         IdPRsIMB/357Jq4jPMBlL8BgL46oFhbje9mLzO+eMEQUZs27qziVIaDN/KbKIzg+7h
         JzoJ4SRb2jZUOwOGa2RwWPWIVKak9W8y6hudZSzarIRLqK0dsnwf5qRKr/AECLzDwT
         hmxDYjYf8iaiRSF3Y8Fz8np6xcQ3kl5mhfKWofhU+ZZvw78lepdl6jRQ1PHY/Zr6D2
         lY+YCPzttqdqg==
Date:   Sun, 16 Jan 2022 22:04:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: tpm: add async space test with
 noneexisting handle
Message-ID: <YeR6Z9a4Z3Xz79Tp@iki.fi>
References: <20220116012627.2031-1-tstruk@gmail.com>
 <20220116012627.2031-2-tstruk@gmail.com>
 <YeQs7Fy5NaK6m6Ar@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeQs7Fy5NaK6m6Ar@iki.fi>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 16, 2022 at 04:34:20PM +0200, Jarkko Sakkinen wrote:
> On Sat, Jan 15, 2022 at 05:26:27PM -0800, Tadeusz Struk wrote:
> > Add a test for /dev/tpmrm0 in async mode that checks if
> > the code handles invalid handles correctly.
> > 
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: <linux-integrity@vger.kernel.org>
> > Cc: <linux-kselftest@vger.kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > 
> > Tested-by: Jarkko Sakkinen<jarkko@kernel.org>
> > Signed-off-by: Tadeusz Struk <tstruk@gmail.com>
> > ---
> > Changed in v2:
> > - Updated commit message
> > Changed in v3:
> > - Fixed typo in the function name
> > ---
> >  tools/testing/selftests/tpm2/tpm2_tests.py | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> > index 9d764306887b..340ffef97fb6 100644
> > --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> > +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> > @@ -302,3 +302,19 @@ class AsyncTest(unittest.TestCase):
> >          log.debug("Calling get_cap in a NON_BLOCKING mode")
> >          async_client.get_cap(tpm2.TPM2_CAP_HANDLES, tpm2.HR_LOADED_SESSION)
> >          async_client.close()
> > +
> > +    def test_flush_invalid_context(self):
> > +        log = logging.getLogger(__name__)
> > +        log.debug(sys._getframe().f_code.co_name)
> > +
> > +        async_client = tpm2.Client(tpm2.Client.FLAG_SPACE | tpm2.Client.FLAG_NONBLOCK)
> > +        log.debug("Calling flush_context passing in an invalid handle ")
> > +        handle = 0x80123456
> > +        rc = 0
> > +        try:
> > +            async_client.flush_context(handle)
> > +        except OSError as e:
> > +            rc = e.errno
> > +
> > +        self.assertEqual(rc, 22)
> > +        async_client.close()
> > -- 
> > 2.30.2
> > 
> 
> Thank you.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko



$ b4 am 20220116012627.2031-2-tstruk@gmail.com
Looking up https://lore.kernel.org/r/20220116012627.2031-2-tstruk%40gmail.com
Grabbing thread from lore.kernel.org/all/20220116012627.2031-2-tstruk%40gmail.com/t.mbox.gz
Analyzing 4 messages in the thread
Will use the latest revision: v4
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v4 1/2] tpm: Fix error handling in async work
    ✓ Signed: DKIM/gmail.com
    + Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org> (✓ DKIM/kernel.org)
  ERROR: missing [2/2]!
---
Total patches: 1
---
WARNING: Thread incomplete!
 Link: https://lore.kernel.org/r/20220116012627.2031-1-tstruk@gmail.com
 Base: applies clean to current tree
       git am ./v4_20220115_tstruk_tpm_fix_error_handling_in_async_work.mbx

The patch set is broken. It has patches from two different patch sets.

I saved the 2nd patch from my email client.

BR, Jarkko
