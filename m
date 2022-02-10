Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912504B1777
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 22:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbiBJVPV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 16:15:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbiBJVPU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 16:15:20 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7661120
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 13:15:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c3so2962079pls.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 13:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=82DdbPKP7kjeLQlK5oCbxLVQbpRl6tS9veakwafAfwM=;
        b=ZEgxS2NOiSTPvF4gN2vTfXSBM/PmC9lw6FPvap3HY16dNy4VNKxbvttaJBVkXJ8rUK
         6tdvCy7z0n07CEwKw/4F1g2AnT2vriBgeofTEt84Pl71phnqqkLb0SOPvlvQWMCTFWl8
         fciN7Uw2+iODzzOhcAo0UKbmoVqipKz/K/i68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82DdbPKP7kjeLQlK5oCbxLVQbpRl6tS9veakwafAfwM=;
        b=iO7fWCKoYrlU4oa9Nnjs7r40+aCBqAf6YMRxnN6Wi7BRDS9DsPJmxkWIpyNb/+5Bzy
         p8PiFrimGIplKpifFEvBngZEW0OoTdEZy0qACEUeRYEA1j334nFmz+pFtrZKcQimRj4f
         ulZ7Y8FRyQ47y4o9Le23Ns/XZGl2zXNqb6ipy7uWh5UKyLaJuvEpngJZRqr0M8io3ZBk
         6AbC6sjGDmpZiknivaK2A/jxEt72peiGxbPF8m2cXVtUme8e5RYlcXmxi5LFX+VfKomO
         xNSEB2boMLadQdgzoIhCOMuT1mFJAHNY8bOYsoPsRfa9189effC817gVFVQveDohILFg
         MqGg==
X-Gm-Message-State: AOAM533qtChjSQiIVUxxkZeidIj0/2giFjNM4UKgB8+jbdOZFFWNzzAC
        /G9uwrN6FjLLKGDLJFH8gM6wag==
X-Google-Smtp-Source: ABdhPJyI/iJYt6Y+8VDXdnZEL290wYjAu5cUAZCCuNrgPtqzAfbVr/nbwnhidTNEy2XeQfmPSKHERw==
X-Received: by 2002:a17:902:7d97:: with SMTP id a23mr9176121plm.92.1644527720463;
        Thu, 10 Feb 2022 13:15:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u13sm25914929pfg.151.2022.02.10.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:15:20 -0800 (PST)
Date:   Thu, 10 Feb 2022 13:15:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        kernelci@groups.io, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Rename file binfmt_script to
 binfmt_script.py
Message-ID: <202202101312.23076F5@keescook>
References: <20220210192845.1533204-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210192845.1533204-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 12:28:45AM +0500, Muhammad Usama Anjum wrote:
> Rename file for readability purpose. Update its usage and references.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> This path was suggested while review of the following patch. Please
> apply it after applying that one first:
> 	selftests/exec: Add non-regular to TEST_GEN_PROGS
> ---
>  tools/testing/selftests/exec/Makefile          |  2 +-
>  .../exec/{binfmt_script => binfmt_script.py}   | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>  rename tools/testing/selftests/exec/{binfmt_script => binfmt_script.py} (90%)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index a89ba6de79870..a0b8688b08369 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -3,7 +3,7 @@ CFLAGS = -Wall
>  CFLAGS += -Wno-nonnull
>  CFLAGS += -D_GNU_SOURCE
>  
> -TEST_PROGS := binfmt_script
> +TEST_PROGS := binfmt_script.py
>  TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
>  TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
>  # Makefile is a run-time dependency, since it's accessed by the execveat test
> diff --git a/tools/testing/selftests/exec/binfmt_script b/tools/testing/selftests/exec/binfmt_script.py
> similarity index 90%
> rename from tools/testing/selftests/exec/binfmt_script
> rename to tools/testing/selftests/exec/binfmt_script.py

Everything from here up, yes. Thank you! :)

All the rest aren't right: it's talking about the binfmt_script subsystem
of the kernel, rather than the binfmt_script.py test script file itself.

> index 05f94a741c7aa..6f717fedc97bd 100755
> --- a/tools/testing/selftests/exec/binfmt_script
> +++ b/tools/testing/selftests/exec/binfmt_script.py
> @@ -28,11 +28,11 @@ foreach my $a (@ARGV) {
>  '''
>  
>  ##
> -# test - produce a binfmt_script hashbang line for testing
> +# test - produce a binfmt_script.py hashbang line for testing
>  #
>  # @size:     bytes for bprm->buf line, including hashbang but not newline
>  # @good:     whether this script is expected to execute correctly
> -# @hashbang: the special 2 bytes for running binfmt_script
> +# @hashbang: the special 2 bytes for running binfmt_script.py
>  # @leading:  any leading whitespace before the executable path
>  # @root:     start of executable pathname
>  # @target:   end of executable pathname
> @@ -45,7 +45,7 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
>      global test_num, tests, NAME_MAX
>      test_num += 1
>      if test_num > tests:
> -        raise ValueError("more binfmt_script tests than expected! (want %d, expected %d)"
> +        raise ValueError("more binfmt_script.py tests than expected! (want %d, expected %d)"
>                           % (test_num, tests))
>  
>      middle = ""
> @@ -68,7 +68,7 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
>      if len(newline) > 0:
>          buf += 'echo this is not really perl\n'
>  
> -    script = "binfmt_script-%s" % (name)
> +    script = "binfmt_script.py-%s" % (name)
>      open(script, "w").write(buf)
>      os.chmod(script, 0o755)
>  
> @@ -78,17 +78,17 @@ def test(name, size, good=True, leading="", root="./", target="/perl",
>  
>      if proc.returncode == 0 and b'Executed interpreter' in stdout:
>          if good:
> -            print("ok %d - binfmt_script %s (successful good exec)"
> +            print("ok %d - binfmt_script.py %s (successful good exec)"
>                    % (test_num, name))
>          else:
> -            print("not ok %d - binfmt_script %s succeeded when it should have failed"
> +            print("not ok %d - binfmt_script.py %s succeeded when it should have failed"
>                    % (test_num, name))
>      else:
>          if good:
> -            print("not ok %d - binfmt_script %s failed when it should have succeeded (rc:%d)"
> +            print("not ok %d - binfmt_script.py %s failed when it should have succeeded (rc:%d)"
>                    % (test_num, name, proc.returncode))
>          else:
> -            print("ok %d - binfmt_script %s (correctly failed bad exec)"
> +            print("ok %d - binfmt_script.py %s (correctly failed bad exec)"
>                    % (test_num, name))
>  
>      # Clean up crazy binaries
> @@ -167,5 +167,5 @@ test(name="two-under-leading",   size=int(SIZE/2), leading=" ")
>  test(name="two-under-lead-trunc-arg", size=int(SIZE/2), leading=" ", arg=" ")
>  
>  if test_num != tests:
> -    raise ValueError("fewer binfmt_script tests than expected! (ran %d, expected %d"
> +    raise ValueError("fewer binfmt_script.py tests than expected! (ran %d, expected %d"
>                       % (test_num, tests))
> -- 
> 2.30.2
> 

-- 
Kees Cook
