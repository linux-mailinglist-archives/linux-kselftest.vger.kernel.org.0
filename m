Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182C9113592
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 20:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfLDTVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 14:21:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34022 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfLDTVs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 14:21:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so138530plr.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2019 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DifXKFST8fxhtH1miSgvC52bAOjBe8VIhNBj9qhxAyA=;
        b=sU1JSfe4ZXwst2VoEwnLY7Bn8vP4W/Z+FQ/f/lMhs5J4jsLxhjmlClb6sBB0czSyDj
         bZq/f8/vp5J5uWt9wnL3GQATulx21R/VuZfUMK/nt8R1EFPM/R/Q/CEnGFlFx8j5CW2u
         YrdP2KKw69KAac+CV30xGf37n57hRmr3+UlrW449e25/4j0Pitz0JSHx3FE0ODZxOeIc
         KtDNBkYvykdZG3KijAeCgOmQ+jlU2xgTpvvLP99gjn248XyWBpKzH0nAxZxVLjQs9xmO
         WXVrckTUpB3wjAtKjsg1LYfiJjxTM9er7doXZYwpch+f77lhXyFLkIssEhBNrUHScIol
         3q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DifXKFST8fxhtH1miSgvC52bAOjBe8VIhNBj9qhxAyA=;
        b=cEDyx7otyi8MwRUXbHp9G0lvRmsV98FT5syWyTh+Ux9+xJPNXHSCgFh9MYiyVQxWi3
         uu6RYMSkMK+26D1nyifPbUpMu7zAx9aVwuJKPYPzXwGtzC9qeaZs4v9w5NO3Ivex4M8e
         sxKBaaoyWRcQ31048CxI6JQip937Nn3TsZG+zlgWzvS7/s3m6hE2ZaD8gzON9LJK1EXZ
         NGtEFVf9lWlnIRTCgnUmqaFNV5HOEEYtNH6acZPwzuJ5xHWsuNB5uv2g0UOshZdaYibL
         WBA9Tt8F10JPOezaeuIEeQsZeQp7jiVjecktcOlKO4v4mBnQuFKxPtqcY2Hd3gLV9sa4
         oXqA==
X-Gm-Message-State: APjAAAXXwfhEC9FpH5gJYGdFFO4F9heSkEv30Q2uopYjrGOYP3gmw1+A
        eWkv3A3NK6U6FkiNBR/yqWeC/w==
X-Google-Smtp-Source: APXvYqwgj78CVQEsvHaciNRYpv8SFALXczwuGqtEa2Fgio39brOuBL8TfRgrEqAe81yEefApj17u5Q==
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr5072973pjb.62.1575487306918;
        Wed, 04 Dec 2019 11:21:46 -0800 (PST)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id d14sm9888831pfq.117.2019.12.04.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:21:46 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:21:41 -0800
From:   Brendan Higgins <brendanhiggins@google.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v3 0/5] Fix nits in the kunit
Message-ID: <20191204192141.GA247851@google.com>
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
 <CAFd5g46X9WK-xKJFF5AVYXXmM4a2dYD3fy=oi1CGJM1gc9RzuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFd5g46X9WK-xKJFF5AVYXXmM4a2dYD3fy=oi1CGJM1gc9RzuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 03, 2019 at 02:41:26PM -0800, Brendan Higgins wrote:
> On Tue, Dec 3, 2019 at 10:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > This patchset contains trivial fixes for the kunit documentations and the
> > wrapper python scripts.
> >
> > Changes from v2 (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com/T/#t):
> >  - Make 'build_dir' if not exists (missed from v3 by mistake)
> >
> > SeongJae Park (5):
> >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> >   kunit: Remove duplicated defconfig creation
> >   kunit: Create default config in '--build_dir'
> >   kunit: Place 'test.log' under the 'build_dir'
> >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> >
> >  Documentation/dev-tools/kunit/start.rst | 13 +++++--------
> >  tools/testing/kunit/kunit.py            | 16 ++++++++++------
> >  tools/testing/kunit/kunit_kernel.py     |  8 ++++----
> >  3 files changed, 19 insertions(+), 18 deletions(-)
> 
> Tested-by: Brendan Higgins <brendanhiggins@google.com>

I just realized that I forgot to test for something...

The following command fails:

./tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --defconfig

[11:17:13] Building KUnit Kernel ...
[11:17:16] Starting KUnit Kernel ...
Traceback (most recent call last):
  File "tools/testing/kunit/kunit.py", line 142, in <module>
    main(sys.argv[1:])
  File "tools/testing/kunit/kunit.py", line 135, in main
    result = run_tests(linux, request)
  File "tools/testing/kunit/kunit.py", line 67, in run_tests
    test_result = kunit_parser.parse_run_tests(kunit_output)
  File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 283, in parse_run_tests
    test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
  File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_parser.py", line 54, in isolate_kunit_output
    for line in kernel_output:
  File "/usr/local/google/home/brendanhiggins/gbmc-linux/tools/testing/kunit/kunit_kernel.py", line 146, in run_kernel
    with open(os.path.join(build_dir, 'test.log'), 'w') as f:
  File "/usr/lib/python3.7/posixpath.py", line 80, in join
    a = os.fspath(a)
TypeError: expected str, bytes or os.PathLike object, not NoneType

It seems as though you assume that build_dir is always populated by the flag.
