Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4777C3A1503
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jun 2021 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhFINC3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 09:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhFINC3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 09:02:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B15F2613AE;
        Wed,  9 Jun 2021 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623243633;
        bh=/vh+7RTWAaqD4dhw2jzi7Xiq/rA9MdpziXvQOyq82iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeGICY5IZLz5EmbXf8MJzGWye/xnTwtmAfSKOipJune5cZSx4JnDF1peiOPots1ch
         Yvsoje7d/ahZUCded1d1R5j/jYz28b3XRI6Jxk8ZEvVd0ukpFoRNVZtKF2GxIy7rZo
         bh+sOPSZMakYdsJew0NXlxag6QbyuMKCs+8FwAsrL04F0SvggBtockTpA3kwYPStN1
         nfWoNUFp4Bo/DrFtNKYgwVQSJaLPpUOmmI0XgoGqlJwP3WICxA32ASX4CoEQ2OqnOX
         1ubisZk2JMFhULVorFzP8npAhl/ELlCS26zM0WdI6yP+tB88LL1TeTAIPpBQLmHM5r
         OA+k5wMM/WNvQ==
Date:   Wed, 9 Jun 2021 16:00:30 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
Message-ID: <20210609130030.34jkpz5pq2iumzkj@kernel.org>
References: <20210526124740.16783-1-jarkko@kernel.org>
 <dddeda6a-0f76-8e5a-6ca8-2ad67f6411ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dddeda6a-0f76-8e5a-6ca8-2ad67f6411ea@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 07, 2021 at 09:28:56AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 5/26/2021 5:47 AM, Jarkko Sakkinen wrote:
> > diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
> > index 67211a708f04..68672fd86cf9 100644
> > --- a/tools/testing/selftests/sgx/main.h
> > +++ b/tools/testing/selftests/sgx/main.h
> > @@ -35,7 +35,7 @@ bool encl_load(const char *path, struct encl *encl);
> >   bool encl_measure(struct encl *encl);
> >   bool encl_build(struct encl *encl);
> > -int sgx_call_vdso(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
> > -		  struct sgx_enclave_run *run);
> > +int sgx_enter_enclave(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
> > +		      struct sgx_enclave_run *run);
> 
> Is there a reason why all registers except rdx are "void *"?

Evolution? It's test code.

There's neither reason to change this for no reason.

/Jarkko
