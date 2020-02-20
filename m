Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECE166A52
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 23:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgBTWZo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 17:25:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729207AbgBTWZo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 17:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582237544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTx11zK1gASAMOs9t/a1QY4KkKM46Fq6dItwGiorPxk=;
        b=THVXRbErt69Io72tR6uaKRG+Qur2/w22Cvt9LizI+uzG6XGFFYLIV2wborLjEVOrFByjuc
        etB/9VONkHXbWeNXDdI91bEZVU4K+JK2zLfKv4JpUamcHOGTbj2XFiMIDZZpcniN3MFVj6
        U9xggkDIXDbtR/TrY377BtNWn4NfEsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-_U0vgCISN8W7Dw1GtkeWQg-1; Thu, 20 Feb 2020 17:25:32 -0500
X-MC-Unique: _U0vgCISN8W7Dw1GtkeWQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD38800D5C;
        Thu, 20 Feb 2020 22:25:31 +0000 (UTC)
Received: from [10.18.17.119] (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF7158B568;
        Thu, 20 Feb 2020 22:25:30 +0000 (UTC)
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
References: <20200220044241.2878-1-mpe@ellerman.id.au>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <85385291-b039-c72d-508a-0b988c1302b5@redhat.com>
Date:   Thu, 20 Feb 2020 17:25:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220044241.2878-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/19/20 11:42 PM, Michael Ellerman wrote:
> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test") added a 45 second timeout for tests, and also added
> a way for tests to customise the timeout via a settings file.
> 
> For example the ftrace tests take multiple minutes to run, so they
> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
> timeout setting").
> 
> This works when the tests are run from the source tree. However if the
> tests are installed with "make -C tools/testing/selftests install",
> the settings files are not copied into the install directory. When the
> tests are then run from the install directory the longer timeouts are
> not applied and the tests timeout incorrectly.
> 
> So add the settings files to TEST_FILES of the appropriate Makefiles
> to cause the settings files to be installed using the existing install
> logic.
> 
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/ftrace/Makefile    | 2 +-
>   tools/testing/selftests/livepatch/Makefile | 2 ++
>   tools/testing/selftests/net/mptcp/Makefile | 2 ++
>   tools/testing/selftests/rseq/Makefile      | 2 ++
>   tools/testing/selftests/rtc/Makefile       | 2 ++
>   5 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> index cd1f5b3a7774..d6e106fbce11 100644
> --- a/tools/testing/selftests/ftrace/Makefile
> +++ b/tools/testing/selftests/ftrace/Makefile
> @@ -2,7 +2,7 @@
>   all:
>   
>   TEST_PROGS := ftracetest
> -TEST_FILES := test.d
> +TEST_FILES := test.d settings
>   EXTRA_CLEAN := $(OUTPUT)/logs/*
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index 3876d8d62494..1acc9e1fa3fb 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -8,4 +8,6 @@ TEST_PROGS := \
>   	test-state.sh \
>   	test-ftrace.sh
>   
> +TEST_FILES := settings
> +
>   include ../lib.mk
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 93de52016dde..ba450e62dc5b 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -8,6 +8,8 @@ TEST_PROGS := mptcp_connect.sh
>   
>   TEST_GEN_FILES = mptcp_connect
>   
> +TEST_FILES := settings
> +
>   EXTRA_CLEAN := *.pcap
>   
>   include ../../lib.mk
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index d6469535630a..f1053630bb6f 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -19,6 +19,8 @@ TEST_GEN_PROGS_EXTENDED = librseq.so
>   
>   TEST_PROGS = run_param_test.sh
>   
> +TEST_FILES := settings
> +
>   include ../lib.mk
>   
>   $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> index de9c8566672a..90fa1a346908 100644
> --- a/tools/testing/selftests/rtc/Makefile
> +++ b/tools/testing/selftests/rtc/Makefile
> @@ -6,4 +6,6 @@ TEST_GEN_PROGS = rtctest
>   
>   TEST_GEN_PROGS_EXTENDED = setdate
>   
> +TEST_FILES := settings
> +
>   include ../lib.mk
> 

Looks good to me,

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe

