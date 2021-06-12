Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7937E3A4CCD
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jun 2021 06:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFLE3Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Jun 2021 00:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhFLE3Z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Jun 2021 00:29:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2418E611CB;
        Sat, 12 Jun 2021 04:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623472046;
        bh=G0+2nGRRVIUoCr/WIFqTqLXmFCWX4fIZWw/3LoSObFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRPoAp3eO4ZeIHfw1rE+n4qJ3ACanh5dw7YUA1QKHE3KHAxQffyDzgMELbyLaosQ2
         iE8GFDGNqEUp5sc96Ev8PsJegnWMs0DJKKZWPP18yexpvuUNH/K0BbTM7wbNwicrpU
         WUrx0xazK9P7FXjp901zcihzNv02Lu1wITO241Ena7TW77b1GbaKUKh/DfpSMQ3zf0
         djiEn1xhJIiswASZMRmEbY7eUmx3joIXdrngiKXKcsrk02P4dyE9i738zdnXIK9qqo
         OixQ27dCENubTnLNUrVIHTKMnpNRPEdEnUA7kGuxeQWXYZZNpnZfySaIhrWX0H0a9r
         2ZLKpogOQIL4g==
Date:   Sat, 12 Jun 2021 07:27:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/5] selftests/sgx: Dump enclave memory map
Message-ID: <20210612042723.vp26eafhyzrv7t66@kernel.org>
References: <20210610083021.392269-1-jarkko@kernel.org>
 <20210610083021.392269-3-jarkko@kernel.org>
 <bb39b6af-5921-64e8-793b-5ef4b150153e@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb39b6af-5921-64e8-793b-5ef4b150153e@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 11, 2021 at 04:45:19PM -0600, Shuah Khan wrote:
> On 6/10/21 2:30 AM, Jarkko Sakkinen wrote:
> > Often, it's useful to check whether /proc/self/maps looks sane when
> > dealing with memory mapped objects, especially when they are JIT'ish
> > dynamically constructed objects. Therefore, dump "/dev/sgx_enclave"
> > matching lines from the memory map in FIXTURE_SETUP().
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >   tools/testing/selftests/sgx/main.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > index 6da19b6bf287..14030f8b85ff 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -117,6 +117,8 @@ FIXTURE_SETUP(enclave)
> >   	Elf64_Sym *sgx_enter_enclave_sym = NULL;
> >   	struct vdso_symtab symtab;
> >   	struct encl_segment *seg;
> > +	char maps_line[256];
> > +	FILE *maps_file;
> >   	unsigned int i;
> >   	void *addr;
> > @@ -167,6 +169,18 @@ FIXTURE_SETUP(enclave)
> >   	memset(&self->run, 0, sizeof(self->run));
> >   	self->run.tcs = self->encl.encl_base;
> > +	maps_file = fopen("/proc/self/maps", "r");
> 
> I almost applied these. Does this require root access, if so,
> please add logic to skip the test if non-root user runs it.
> 
> Same comments for all other paths that might require root access.

As Dave stated, it does not. A process can inspect its own state
through /proc/self path. E.g. Chrome web browser uses /proc/self/exe
to initialize multiple instances of itself for browser tabs...

As far as other things go, this patch set does not bind to any other
new OS resources.

> thanks,
> -- Shuah

/Jarkko
