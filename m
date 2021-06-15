Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9873A7EAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jun 2021 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFONJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Jun 2021 09:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhFONJr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Jun 2021 09:09:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DEB6146D;
        Tue, 15 Jun 2021 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623762462;
        bh=sYX3ZPx6IeNrw8KHZ2uYVId5UWZzrYfAFih38ALGU/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ec7KJe9PlXKis266j1A0M4xixXj7bJmv5Ji9Gae4zI2c+jzcvM32UWG9DkBY3WzTz
         Kba+gr0dp9WkfkysxK42o8xNWxCDzyVHcz65MIG3Cu+xHSuux2vGSWpAX/EiMTn+Ob
         H5WxsmdVR9oNgNeTEFi7jpP7CNz02/1zCKa3o/bB3tFJUJFbfW0pxd/eBBcQ+1BuEU
         u9moZR0qbmMBDmRm8UHo4uHM/gF8EYsiGOHd1wcKxCLnKn+i3qIDcj09S61AC+N0fP
         G8Y9vBuV2wGmcQITeE05HrEMDuOqJ4A4cuhr4kVOFQ8aut/M+pSZkQrwUC/ipv1uty
         KE1a7z4Xh1flg==
Date:   Tue, 15 Jun 2021 16:07:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/5] selftests/sgx: Dump enclave memory map
Message-ID: <20210615130740.3axsxi2m2ozqfofm@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <20210610083021.392269-3-jarkko@kernel.org>
 <bb39b6af-5921-64e8-793b-5ef4b150153e@linuxfoundation.org>
 <20210612042723.vp26eafhyzrv7t66@kernel.org>
 <c18409da-dd2b-c813-d7dd-bad81db102bd@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18409da-dd2b-c813-d7dd-bad81db102bd@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 14, 2021 at 10:45:43AM -0600, Shuah Khan wrote:
> On 6/11/21 10:27 PM, Jarkko Sakkinen wrote:
> > On Fri, Jun 11, 2021 at 04:45:19PM -0600, Shuah Khan wrote:
> > > On 6/10/21 2:30 AM, Jarkko Sakkinen wrote:
> > > > Often, it's useful to check whether /proc/self/maps looks sane when
> > > > dealing with memory mapped objects, especially when they are JIT'ish
> > > > dynamically constructed objects. Therefore, dump "/dev/sgx_enclave"
> > > > matching lines from the memory map in FIXTURE_SETUP().
> > > > 
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > >    tools/testing/selftests/sgx/main.c | 14 ++++++++++++++
> > > >    1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > > > index 6da19b6bf287..14030f8b85ff 100644
> > > > --- a/tools/testing/selftests/sgx/main.c
> > > > +++ b/tools/testing/selftests/sgx/main.c
> > > > @@ -117,6 +117,8 @@ FIXTURE_SETUP(enclave)
> > > >    	Elf64_Sym *sgx_enter_enclave_sym = NULL;
> > > >    	struct vdso_symtab symtab;
> > > >    	struct encl_segment *seg;
> > > > +	char maps_line[256];
> > > > +	FILE *maps_file;
> > > >    	unsigned int i;
> > > >    	void *addr;
> > > > @@ -167,6 +169,18 @@ FIXTURE_SETUP(enclave)
> > > >    	memset(&self->run, 0, sizeof(self->run));
> > > >    	self->run.tcs = self->encl.encl_base;
> > > > +	maps_file = fopen("/proc/self/maps", "r");
> > > 
> > > I almost applied these. Does this require root access, if so,
> > > please add logic to skip the test if non-root user runs it.
> > > 
> > > Same comments for all other paths that might require root access.
> > 
> > As Dave stated, it does not. A process can inspect its own state
> > through /proc/self path. E.g. Chrome web browser uses /proc/self/exe
> > to initialize multiple instances of itself for browser tabs...
> > 
> 
> Ah yes. I missed the self part. Thanks for clarifying.
> 
> > As far as other things go, this patch set does not bind to any other
> > new OS resources.
> > 
> 
> Thank you. I will apply these for 5.14-rc1.

Thank you!

> thanks,
> -- Shuah

/Jarkko
