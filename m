Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB56ED1E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Apr 2023 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjDXQCk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjDXQCj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 12:02:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7E86A63;
        Mon, 24 Apr 2023 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682352157; x=1713888157;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NViz8YEHgJpMLlZYKRxkuNx1Ws9e+PU14KamgS4jHwQ=;
  b=a7OFKzyS73CrJ6hDgr2uDqoso+dPKfvgXO3BfOk4kM/dQmhFszEiuGMx
   jjpUqhIjhKMwkSA9NtnYVMqJ1ZC0TI4I33vQlG+oWFGxTmVmWMK0QVhgz
   II07409WQqDX6SxeooaSnITpxEfspXcRptFkVJ712mStmtpdfcsGCG3ms
   yOmOkQ05kHMiqQ8wX64WdfHIZb+SYjZoGHv2kVuwyNa4VpM9lEFw4Nx8g
   aR9dot9ztRzTduXuQ4QoT0grQzKE9JhkeLN4/6YbkP8u+kpUFi7WFDgyw
   ORY76GIahaVVQR4gZsRrt9hwTTijy2FyNNkS1W2risIgInsq3l79Z6zKl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345246207"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="345246207"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 09:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="837031993"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="837031993"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 09:01:46 -0700
Date:   Mon, 24 Apr 2023 19:01:44 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v2 10/24] selftests/resctrl: Split run_fill_buf() to
 alloc, work, and dealloc helpers
In-Reply-To: <8d6f94e6-4d51-5b96-2a74-2417ffcc0b51@intel.com>
Message-ID: <a38cba17-77c3-3f81-d4c9-fca839a46444@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-11-ilpo.jarvinen@linux.intel.com> <8d6f94e6-4d51-5b96-2a74-2417ffcc0b51@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1840410181-1682352107=:2038"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1840410181-1682352107=:2038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Apr 2023, Reinette Chatre wrote:
> On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> > 
> > diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> > index 5cdb421a2f6c..6f0438aa71a6 100644
> > --- a/tools/testing/selftests/resctrl/fill_buf.c
> > +++ b/tools/testing/selftests/resctrl/fill_buf.c
> > @@ -24,6 +24,11 @@
> >  
> >  static unsigned char *startptr;
> >  
> > +void free_buffer(void)
> > +{
> > +	free(startptr);
> > +}
> > +
> 
> >From what I understand startptr is a global variable because there used
> to be a signal handler that attempted to free the buffer as part of
> its cleanup. This was not necessary and this behavior no longer exists,
> yet the global buffer pointer remains.
> See commit 73c55fa5ab55 ("selftests/resctrl: Commonize the signal handler
> register/unregister for all tests")
> 
> I do not see why a global buffer pointer with all these indirections
> are needed. Why not just use a local pointer and pass it to functions
> as needed? In the above case, just call free(pointer) directly from the
> test.

OK, I'll try to convert all this into using non-global pointers then. It 
requires a bit refactoring but, IIRC, it is doable.

> >  static void sb(void)
> >  {
> >  #if defined(__i386) || defined(__x86_64)
> > @@ -138,36 +143,53 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
> >  	return 0;
> >  }
> >  
> > -static int
> > -fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
> > +int alloc_buffer(unsigned long long buf_size, int memflush)
> >  {
> 
> This can be an allocation function that returns a pointer to
> allocated buffer, NULL if error.
>
> > -	unsigned char *start_ptr, *end_ptr;
> > -	int ret;
> > +	unsigned char *start_ptr;
> >  
> >  	start_ptr = malloc_and_init_memory(buf_size);
> >  	if (!start_ptr)
> >  		return -1;
> >  
> >  	startptr = start_ptr;
> > -	end_ptr = start_ptr + buf_size;
> >  
> >  	/* Flush the memory before using to avoid "cache hot pages" effect */
> >  	if (memflush)
> >  		mem_flush(start_ptr, buf_size);
> >  
> > +	return 0;
> > +}
> > +
> > +int use_buffer(unsigned long long buf_size, int op, char *resctrl_val)
> > +{
> > +	unsigned char *end_ptr;
> > +	int ret;
> > +
> > +	end_ptr = startptr + buf_size;
> >  	if (op == 0)
> > -		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
> > +		ret = fill_cache_read(startptr, end_ptr, resctrl_val);
> >  	else
> > -		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
> > +		ret = fill_cache_write(startptr, end_ptr, resctrl_val);
> >  
> > -	if (ret) {
> > +	if (ret)
> >  		printf("\n Error in fill cache read/write...\n");
> > -		return -1;
> > -	}
> >  
> > -	free(startptr);
> > +	return ret;
> > +}
> >  
> 
> This seems like an unnecessary level of abstraction to me. Could
> callers not just call fill_cache_read()/fill_cache_write() directly?
> I think doing so will make tests easier to understand. Looking ahead
> at how cat_val() turns out in the final patch I do think a call
> to fill_cache_read() is easier to follow than this abstraction.

Passing a custom benchmark command with -b would lose some functionality 
if this abstraction is removed. CAT test could make a direct call though 
as it doesn't care about the benchmark command.

How useful that -b functionality is for selftesting is somewhat 
questionable though.


-- 
 i.

--8323329-1840410181-1682352107=:2038--
