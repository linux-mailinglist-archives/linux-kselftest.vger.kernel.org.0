Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C81542B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBFLLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 06:11:11 -0500
Received: from foss.arm.com ([217.140.110.172]:57208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgBFLLL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 06:11:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04F16101E;
        Thu,  6 Feb 2020 03:11:11 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1B93F52E;
        Thu,  6 Feb 2020 03:11:10 -0800 (PST)
Subject: Re: [PATCH] selftests: allow detection of build failures
To:     Jiri Benc <jbenc@redhat.com>, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
References: <9929e231f4a0b14e8fd86a0debbee730320b531d.1580978204.git.jbenc@redhat.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <47710514-3e00-29d3-2304-a6f2aa5f7eaf@arm.com>
Date:   Thu, 6 Feb 2020 11:11:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9929e231f4a0b14e8fd86a0debbee730320b531d.1580978204.git.jbenc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jiri

On 06/02/2020 08:40, Jiri Benc wrote:
> Commit 5f70bde26a48 ("selftests: fix build behaviour on targets' failures")
> added a logic to track failure of builds of individual targets. However, it
> does exactly the opposite of what a distro kernel needs: we create a RPM
> package with a selected set of selftests and we need the build to fail if
> build of any of the targets fail.
> 
> Both use cases are valid. A distribution kernel is in control of what is
> included in the kernel and what is being built; any error needs to be
> flagged and acted upon. A CI system that tries to build as many tests as
> possible on the best effort basis is not really interested in a failure here
> and there.
> 
> Support both use cases by introducing a FORCE_TARGETS variable. It is
> switched off by default to make life for CI systems easier, distributions
> can easily switch it on while building their packages.
> 

Fine for me. My concerns as you said were only for CI systems and the fact that the build
was failing in a non-deterministic way depending on the outcome of the last built subsystem
only: I hadn't considered the opposite needs of a package build system. Sorry for that.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Regards

Cristian

> Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Signed-off-by: Jiri Benc <jbenc@redhat.com>
> ---
>  tools/testing/selftests/Makefile | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 5182d6078cbc..97fca70d2cd6 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -74,6 +74,12 @@ ifneq ($(SKIP_TARGETS),)
>  	override TARGETS := $(TMP)
>  endif
>  
> +# User can set FORCE_TARGETS to 1 to require all targets to be successfully
> +# built; make will fail if any of the targets cannot be built. If
> +# FORCE_TARGETS is not set (the default), make will succeed if at least one
> +# of the targets gets built.
> +FORCE_TARGETS ?=
> +
>  # Clear LDFLAGS and MAKEFLAGS if called from main
>  # Makefile to avoid test build failures when test
>  # Makefile doesn't have explicit build rules.
> @@ -148,7 +154,8 @@ all: khdr
>  	for TARGET in $(TARGETS); do				\
>  		BUILD_TARGET=$$BUILD/$$TARGET;			\
>  		mkdir $$BUILD_TARGET  -p;			\
> -		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;	\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
> +				$(if $(FORCE_TARGETS),|| exit);	\
>  		ret=$$((ret * $$?));				\
>  	done; exit $$ret;
>  
> @@ -202,7 +209,8 @@ ifdef INSTALL_PATH
>  	@ret=1;	\
>  	for TARGET in $(TARGETS); do \
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
> +				$(if $(FORCE_TARGETS),|| exit);	\
>  		ret=$$((ret * $$?));		\
>  	done; exit $$ret;
>  
> 

