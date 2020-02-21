Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7A4166EBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 06:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgBUFMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Feb 2020 00:12:33 -0500
Received: from ozlabs.org ([203.11.71.1]:53129 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgBUFMd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Feb 2020 00:12:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48P02R2Bh2z9sPk;
        Fri, 21 Feb 2020 16:12:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582261951;
        bh=VN01LPmrMRRE7xnQaiPGlfuivp3p3nCGU9JeUtjz/7s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R+XtdpLEozvcl4JlLLYpijxvQ3ZHQ0ZijmxlvQlNWwRx5fdDNKl9AtanwNuf6YSnh
         9t1peF/9ZWC5WMOdzPPuJNIGWAMxXbNxqjnpYJVEqCqxG7VLMQekya3eZw6PHNITGr
         /Uudf/Qlewr4yRXBn7cmfEcwW/EwwUf12ltS5B1QVQTNqK8uHTpCIdmA4FptDytkTV
         nUv0Esfr9v0ndMoSJGXvqvdF6aaVYqERN55P/NGlpvQxCuBhdTA+sjiSNPePE3G/QZ
         5Fzir81AZ0ix9bnCLr18CH7u44SrcOaXxL5pJmAsnF2eVb06236eBMPt8e37z21I0x
         6IY7O9q0I5gqg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
In-Reply-To: <fccfcd8b-628b-9b3d-13b1-6dcda49b4df9@linuxfoundation.org>
References: <20200220044241.2878-1-mpe@ellerman.id.au> <202002201450.A4BB99421@keescook> <fccfcd8b-628b-9b3d-13b1-6dcda49b4df9@linuxfoundation.org>
Date:   Fri, 21 Feb 2020 16:12:27 +1100
Message-ID: <87o8tsed6s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:
> On 2/20/20 3:51 PM, Kees Cook wrote:
>> On Thu, Feb 20, 2020 at 03:42:41PM +1100, Michael Ellerman wrote:
>>> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>>> timeout per test") added a 45 second timeout for tests, and also added
>>> a way for tests to customise the timeout via a settings file.
>>>
>>> For example the ftrace tests take multiple minutes to run, so they
>>> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
>>> timeout setting").
>>>
>>> This works when the tests are run from the source tree. However if the
>>> tests are installed with "make -C tools/testing/selftests install",
>>> the settings files are not copied into the install directory. When the
>>> tests are then run from the install directory the longer timeouts are
>>> not applied and the tests timeout incorrectly.
>> 
>> Eek, yes, nice catch.
>> 
>>> So add the settings files to TEST_FILES of the appropriate Makefiles
>>> to cause the settings files to be installed using the existing install
>>> logic.
>> 
>> Instead, shouldn't lib.mk "notice" the settings file and automatically
>> include it in TEST_FILES instead of having to do this in each separate
>> Makefile?
>> 
>
> Let's keep it custom per test for now.

Yeah that seems less magical.

FWIW the patch below does work, so it's a small patch, but I'm not sure
it's worth the added complexity vs just listing the file in the few
tests that need it.

cheers


diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..82086c6ad5e7 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,6 +20,10 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+ifeq ($(wildcard settings),settings)
+       TEST_FILES += settings
+endif
+
 ifdef KSFT_KHDR_INSTALL
 top_srcdir ?= ../../../..
 include $(top_srcdir)/scripts/subarch.include
