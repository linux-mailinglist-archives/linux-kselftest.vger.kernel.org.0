Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9456B10F837
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 08:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfLCHAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 02:00:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44692 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfLCHAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 02:00:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so1218843pgl.11
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 23:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=INGajexy9It7CoUDmxX+ri4F9omlcw2mriGYC3fDDCI=;
        b=ItVhJQ5/E4Tjc6i/wsv9yGPBfHXXxKaCb4L7T+pTJEe+oB0q0MqPtcQNj3lmHkV3Cq
         dL5jxRC7w7herfMWSMCI/44CqKzzZkp7WGxLGvDWnxcp/9sFCv8pbSrB8lrzp0f6VIXG
         iv/iwztoNmBPqTpJKzBmnlDuF2XL7T8onNihgot0eJ96ZkmO8ZkQPcnVIx4wuR9eGRph
         BLJRIkR8vsfuBBnpdbIMYCCVOMjKpwCHS5EEmn/+f+yIPheJlNPkdmuHSAEf1mOVzy8s
         RMDPF4OYG+Yqw3SiBsNvCTMTNigzyeIwjps7jU9/izIs0clDzCqzHaNBOYM4KS+UIpcA
         EZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=INGajexy9It7CoUDmxX+ri4F9omlcw2mriGYC3fDDCI=;
        b=Yi8s5iN0mhtkiJhSJzw+Ov6ru2uUe5eUVKVYa3/BAH4GqaqGkL3x5cBh3PMsnYEIYw
         74OOsLzsImkBWee9GHYWsLLuDhrdquFTse6Tc0nec98qjXgVHS2cPUCj7XEG+WjWXJD0
         FZoRgKljGXM1kQd4BO4yHFrnxV4SBvkqfJiWAiuosUckJj2iQFdvLOOAQ0MNgMorNTKg
         bKAW+7V5U9lwLMWTd598sE3pFFoe1CT4Wgg32gxBUhA6nhucSpGXHpPEEFTkzygcLLBk
         bOsK1FlPe/lebY/bKsnZtRdETRYjJsNWnCbe02jonZ8vGvaXgTrV0kPOA4g1N+A3F9TL
         CAYA==
X-Gm-Message-State: APjAAAWGL3y65F4KY0WFEz4g4F4vPeRZo0vCjz1/wG1kLTcg+NBlQNU6
        ducx9prTnB0aMbe9ngpdnmMPQg==
X-Google-Smtp-Source: APXvYqy1Nw4ygDEMu+qXudGEcJNNMk2ym1VAsn4ckHP/DMNzJc0rIrbvfRLWNHSofdREJyMrAL6Big==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr3764856pgm.69.1575356430815;
        Mon, 02 Dec 2019 23:00:30 -0800 (PST)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id k4sm1887484pfa.25.2019.12.02.23.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:00:30 -0800 (PST)
Date:   Mon, 2 Dec 2019 23:00:25 -0800
From:   Brendan Higgins <brendanhiggins@google.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah@kernel.org, corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 0/6] Fix nits in the kunit
Message-ID: <20191203070025.GA4206@google.com>
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 02, 2019 at 08:25:18AM +0900, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This patchset contains trivial fixes for the kunit documentations and the
> wrapper python scripts.
> 
> SeongJae Park (6):
>   docs/kunit/start: Use in-tree 'kunit_defconfig'
>   docs/kunit/start: Skip wrapper run command
>   kunit: Remove duplicated defconfig creation
>   kunit: Create default config in 'build_dir'
>   kunit: Place 'test.log' under the 'build_dir'
>   kunit: Rename 'kunitconfig' to '.kunitconfig'
> 
>  Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
>  tools/testing/kunit/kunit.py            | 10 ++++++----
>  tools/testing/kunit/kunit_kernel.py     |  6 +++---
>  3 files changed, 14 insertions(+), 21 deletions(-)

I applied your patchset to torvalds/master, ran the command:

tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig --build_dir=.kunit

and got the error:

Traceback (most recent call last):
  File "tools/testing/kunit/kunit.py", line 140, in <module>
    main(sys.argv[1:])
  File "tools/testing/kunit/kunit.py", line 123, in main
    create_default_kunitconfig()
  File "tools/testing/kunit/kunit.py", line 36, in create_default_kunitconfig
    kunit_kernel.KUNITCONFIG_PATH)
  File "/usr/lib/python3.7/shutil.py", line 121, in copyfile
    with open(dst, 'wb') as fdst:
FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'

It seems that it expects the build_dir to already exist; however, I
don't think this is clear from the error message. Would you mind
addressing that here?

Cheers!
