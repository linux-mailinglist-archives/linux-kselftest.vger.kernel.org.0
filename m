Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9711FFC95
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 22:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgFRUg5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbgFRUgz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 16:36:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FFC06174E
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 13:36:53 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dp10so3416409qvb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZYzhuBZS9rkuOZVHOQsEAGRBl1qfIjePfyvKHgBh4OM=;
        b=yR3Onkl6GAedASEnIYKoSQdDDq55u7rSUAdcrerC2I36aFDVFgdQNmz+YntLg/KJqk
         guHQb1gluVExpam6Acdgf6Zzo7DPus6FRSprCfROwH6+xLA+pSrEYCmdv1dHMVHst9nm
         PI0y26KMs8Ab1SbheWZRB02JwyM6R8RIE7QdZw/rsNEd8PqSKCBl9Qe90ETW0a580PJE
         /DSgLzBToRolw9uCRUEEhrLWhcHxQQNNsS4mbJuLERBZ6bmlRxeJyXllNzXe2383JmbC
         Kl8C53X0TypFOppXtnFMHzl5uMN4/Wd9Ojoqmpkg6T8UaEy++Eph5rDTwIBANMfJxOcA
         Ti7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZYzhuBZS9rkuOZVHOQsEAGRBl1qfIjePfyvKHgBh4OM=;
        b=ZlhXYXgxMzAXqWi2NF0OptWjl2aqhvHO/NBaYC1bAtXQyMUUGdggkkAbIX6Qf6Dmu+
         FmqO8wUB2QPpLKUo6JXJb90BU9IsGPcL7jwvKEUadH0+PP1kkoyuc3OJWDF3+Ru5KJhi
         OuMhqpL6B15FomIY5+MwJW5vXxW0zbTLFF4+Ip6PJo9h00IjZ9KzT3VFzb0wk0LBdKnS
         apcN8/8IJphpIFP1rG+mbUDqgmdFYAPFvGGNIJc9H6Kn/oHb+xoU9u9Od3cHI3+oZrKg
         rDd4Mki/E7gDOR1i810BBD52oJP/iWd/yMqjKK97B75DgMfRw0z2+VDKdNCFzSTMIGlf
         BZ9g==
X-Gm-Message-State: AOAM532qbnuAGKIZl4GJA/Ani2uLhjl9xbviDrNozqUgTciKWfzOp+Jl
        GeAWdDuOI1fNYT2pr7+qIoAJmQ==
X-Google-Smtp-Source: ABdhPJxuN5Wtev05q/gcl9cRRq8T1PFeCRU+R/qg0zNZaGaNLs6k5uX3I52sJpgcqJKmEN5eaWp+bw==
X-Received: by 2002:a05:6214:1925:: with SMTP id es5mr5692284qvb.165.1592512613158;
        Thu, 18 Jun 2020 13:36:53 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id k26sm4684548qtk.55.2020.06.18.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:36:52 -0700 (PDT)
Message-ID: <5d00735a16728de5547c87e2cf4c29c23a1f0720.camel@massaru.org>
Subject: Re: [PATCH] kunit: fix KconfigParseError by ignoring CC_VERSION_TEXT
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 18 Jun 2020 17:36:50 -0300
In-Reply-To: <CAFd5g45AB8K-p78GRmauRPbkXLU572D2tuMTc0pumL+EgDA52Q@mail.gmail.com>
References: <20200618035736.245566-1-vitor@massaru.org>
         <CAFd5g45AB8K-p78GRmauRPbkXLU572D2tuMTc0pumL+EgDA52Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2020-06-18 at 13:29 -0700, Brendan Higgins wrote:
> On Wed, Jun 17, 2020 at 8:57 PM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> > Commit 8b59cd81dc5 ("kbuild: ensure full rebuild when the compiler
> > is updated") added the environment variable CC_VERSION_TEXT,
> > parse_from_string() doesn't expect a string and this causes the
> > failure below:
> > 
> > [iha@bbking linux]$ tools/testing/kunit/kunit.py run --timeout=60
> > [00:20:12] Configuring KUnit Kernel ...
> > Generating .config ...
> > Traceback (most recent call last):
> >   File "tools/testing/kunit/kunit.py", line 347, in <module>
> >     main(sys.argv[1:])
> >   File "tools/testing/kunit/kunit.py", line 257, in main
> >     result = run_tests(linux, request)
> >   File "tools/testing/kunit/kunit.py", line 134, in run_tests
> >     config_result = config_tests(linux, config_request)
> >   File "tools/testing/kunit/kunit.py", line 64, in config_tests
> >     success = linux.build_reconfig(request.build_dir,
> > request.make_options)
> >   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py",
> > line 161, in build_reconfig
> >     return self.build_config(build_dir, make_options)
> >   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py",
> > line 145, in build_config
> >     return self.validate_config(build_dir)
> >   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py",
> > line 124, in validate_config
> >     validated_kconfig.read_from_file(kconfig_path)
> >   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py",
> > line 89, in read_from_file
> >     self.parse_from_string(f.read())
> >   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py",
> > line 85, in parse_from_string
> >     raise KconfigParseError('Failed to parse: ' + line)
> > kunit_config.KconfigParseError: Failed to parse:
> > CONFIG_CC_VERSION_TEXT="gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-
> > 1)"
> 
> I am pretty there is already a fix out for this issue:
> 
> https://patchwork.kernel.org/patch/11592313/
> 
> Can you confirm?

Sure, thanks!

