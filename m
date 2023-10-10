Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC807BF269
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 07:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442152AbjJJFqo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 01:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442162AbjJJFql (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 01:46:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C6511A;
        Mon,  9 Oct 2023 22:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696916797; x=1728452797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ueFvf7JJaks5mJOm09moID6hWZ9bgKShkkmMs8XC9kA=;
  b=VROw0XHmop17NRiaefiA8M6kbbI7dvEEB08QWgNZJPNLvvAoOj1TmFJE
   U+7dAY3HQYSAhENS6EipftzB0XiQAe0fBLuZNxqB1nM57t02N62H91NTD
   b1/Z/a8HQa61Na7RTNYEns7IfUpWS8F1cdsAWUvZ1CLXSbpcsMyQyEGWx
   B4lhESJHkQHnwZF11M9Q5ZJSYc7h6DUdvOBr1An6BI0rV1fMESGqQkwfn
   VZGxpLkB6QVBa7pCWwxzLl0O3ozk469eRQJ8xHdU91x3WX3ausavh19qJ
   rNTcJyYtBgW70Lzh6tnsywNccn223oeQpOm86Rtl/x3q81aVVy3OwiQgf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="381574063"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="381574063"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 22:46:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="843990705"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="843990705"
Received: from geigerri-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.41.165])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 22:46:34 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A273310A196; Tue, 10 Oct 2023 08:46:31 +0300 (+03)
Date:   Tue, 10 Oct 2023 08:46:31 +0300
From:   kirill.shutemov@linux.intel.com
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, weihong.zhang@intel.com
Subject: Re: [PATCH] selftests/x86/lam: Zero out buffer for readlink()
Message-ID: <20231010054631.kud3zvv57je2buad@box.shutemov.name>
References: <20230923233346.12726-1-binbin.wu@linux.intel.com>
 <20230927110219.b5n3fbbwrxtcwtzp@box.shutemov.name>
 <1793b780-cd15-b6a3-f951-c19a14a1310c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1793b780-cd15-b6a3-f951-c19a14a1310c@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 10, 2023 at 11:51:32AM +0800, Binbin Wu wrote:
> 
> 
> On 9/27/2023 7:02 PM, kirill.shutemov@linux.intel.com wrote:
> > On Sun, Sep 24, 2023 at 07:33:46AM +0800, Binbin Wu wrote:
> > > Zero out the buffer for readlink() since readlink() does not append a
> > > terminating null byte to the buffer.
> > > 
> > > Fixes: 833c12ce0f430 ("selftests/x86/lam: Add inherit test cases for linear-address masking")
> > > 
> > > Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> > > ---
> > >   tools/testing/selftests/x86/lam.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> > > index eb0e46905bf9..9f06942a8e25 100644
> > > --- a/tools/testing/selftests/x86/lam.c
> > > +++ b/tools/testing/selftests/x86/lam.c
> > > @@ -680,7 +680,7 @@ static int handle_execve(struct testcases *test)
> > >   		perror("Fork failed.");
> > >   		ret = 1;
> > >   	} else if (pid == 0) {
> > > -		char path[PATH_MAX];
> > > +		char path[PATH_MAX] = {0};
> > Shouldn't it be PATH_MAX+1 to handle the case when readlink(2) stores
> > exactly PATH_MAX bytes into the buffer?
> According to the definition of PATH_MAX in include/uapi/linux/limits.h
> #define PATH_MAX        4096    /* # chars in a path name including nul */
> 
> IIUC, Linux limits the path length to 4095 and PATH_MAX includes the
> terminating nul.

Consider the case when kernel bump PATH_MAX to 8192. The binary that
compiled from lam.c against the older kernel headers will get compromised.

Increase the size of the buffer by one or pass PATH_MAX - 1 as buffer size
to readlink(2).

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
