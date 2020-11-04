Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDF42A6461
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 13:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgKDMbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 07:31:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45645 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKDMbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 07:31:37 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kaHwo-0005ud-1H; Wed, 04 Nov 2020 12:31:30 +0000
Date:   Wed, 4 Nov 2020 13:31:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        christian@brauner.io
Subject: Re: [PATCH] selftests/cgroup: Fix build on older distros
Message-ID: <20201104123129.qczj363jrqiljpvi@wittgenstein>
References: <20201104100545.657898-1-mpe@ellerman.id.au>
 <EC8A9B1A-B080-499D-B81C-31055E1C8BD8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EC8A9B1A-B080-499D-B81C-31055E1C8BD8@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 04, 2020 at 05:50:40PM +0530, Sachin Sant wrote:
> 
> 
> > On 04-Nov-2020, at 3:35 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > 
> > On older distros struct clone_args does not have a cgroup member,
> > leading to build errors:
> > 
> >  cgroup_util.c: In function 'clone_into_cgroup':
> >  cgroup_util.c:343:4: error: 'struct clone_args' has no member named 'cgroup'
> > 
> > But the selftests already have a locally defined version of the
> > structure which is up to date, called __clone_args.
> > 
> > So use __clone_args which fixes the error.
> > 
> 
> Argument passed to sys_clone3() will also require a similar change.
> 
> -	pid = sys_clone3(&args, sizeof(struct clone_args));
> +	pid = sys_clone3(&args, sizeof(struct __clone_args));
> 
> Without this compilation still fails(at least for me) due to following error
> 
> cgroup_util.c: In function 'clone_into_cgroup':
> cgroup_util.c:346:33: error: invalid application of 'sizeof' to incomplete type 'struct clone_args'
>   pid = sys_clone3(&args, sizeof(struct clone_args));
> 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---

Thanks Michael for taking care fo this. Much appreciated. I think with
the fix that Sachin pointed out this should work out fine!

Once that's fixed up:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
Christian
