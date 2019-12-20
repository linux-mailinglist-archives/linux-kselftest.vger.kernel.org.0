Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DEB1274DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLTFBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:01:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36678 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfLTFBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:01:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so7873740wma.1;
        Thu, 19 Dec 2019 21:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=upxU0sSVmZx48s5pcLgl2PhLJm36OOz7fOd0OEBAsWk=;
        b=d1Sqr6jjZ2LAID5NMaS24UN540fd7UB2d9MQlu3Qv5RJrtwdaBYzg62QzxceoXAwcI
         gH2JkmQo1Fp16RLHJM5UUMYrbQTtBElrOpezk3w0gzKrjyZtq1a7uhIoxk8opKChvNz/
         3k18bwYaft9fplY9QUN/WX7jnFhAZ2ixU4mIfwA3U2TruskdX76KZR1MBTrCrep8WWrY
         11BbFHo4xJAi3oXJLFbjNOvQBCUDYos8koMhh3aXfeRUNP78UUaCNun853NHORBn3pF9
         p5b32/nv/nbkWhFqmTWUOGjUbBbwevSgSFF/RP/j9l4ylfd9kidxfGYMfL+qU6zq8eqR
         oiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=upxU0sSVmZx48s5pcLgl2PhLJm36OOz7fOd0OEBAsWk=;
        b=uFy7MHN+VeaBOAg6MkuEZS0wfpabPJTVzijI/XGUjNc3x6NTfPs17LyyEZOG/6v6ZK
         W1kauHXfG+lDqRIITSL+FGBoP1o/esrpXKzMaM/RwZnlNaIAiDuzoIhc4vo1yfuDa8eq
         eTCY+M6K2nBMrdxOWg1MjBcffMNDlheuE2GnCeU0n8faYzzZzLGNekjb7quOgnwcirK7
         ElK2yADnYp0nRXACJTFm8fBTnWo2dbTtRgaVUwHu+LtVvec6PUrEOaqhvEQ+2hiKinUd
         NiA/6cIEuqKBetrIq030DzqGg9Knkh54CLODSN3lCQ0b/37LPL63YAeRonkCHldaIEg7
         0f/A==
X-Gm-Message-State: APjAAAVBrD9rKgThVl+mD3u0Be38RdkskVc4BhlrYwEc/WVtkJ7jrdfl
        N61rD1+kj2E3of+1KYemVQs=
X-Google-Smtp-Source: APXvYqwPT8rvktm9nnQ5N9hZi4dAyJOk8j9TNmEnO33NGcxDqrJtkiRXzDWDiYZaBfvAZe/SFodf+g==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr13404376wme.27.1576818104014;
        Thu, 19 Dec 2019 21:01:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id x26sm7976691wmc.30.2019.12.19.21.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 21:01:43 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     SeongJae Park <sj38.park@gmail.com>, brendanhiggins@google.com,
        sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sjpark@amazon.de
Subject: Re: Re: [PATCH v6 0/6] Fix nits in the kunit
Date:   Fri, 20 Dec 2019 06:01:21 +0100
Message-Id: <20191220050121.24334-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <13f1203e-030d-699e-d12d-d9fea335ca36@kernel.org> (raw)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 Dec 2019 16:37:28 -0700 shuah <shuah@kernel.org> wrote:

> On 12/11/19 7:27 PM, SeongJae Park wrote:
> > This patchset contains trivial fixes for the kunit documentations and
> > the wrapper python scripts.
> > 
> > 
> > Baseline
> > --------
> > 
> > This patchset is based on 'kselftest/fixes' branch of
> > linux-kselftest[1].  A complete tree is available at my repo:
> > https://github.com/sjp38/linux/tree/kunit_fix/20191205_v6
> > 
> > 
> > Version History
> > ---------------
> > 
> > Changes from v5
> > (https://lore.kernel.org/linux-kselftest/20191205093440.21824-1-sjpark@amazon.com):
> >   - Rebased on kselftest/fixes
> >   - Add 'Reviewed-by' and 'Tested-by' from Brendan Higgins
> > 
> > Changes from v4
> > (https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
> >   - Rebased on Heidi Fahim's patch[2]
> >   - Fix failing kunit_tool_test test
> >   - Add 'build_dir' option test in 'kunit_tool_test.py'
> > 
> > Changes from v3
> > (https://lore.kernel.org/linux-kselftest/20191204192141.GA247851@google.com):
> >   - Fix the 4th patch, "kunit: Place 'test.log' under the 'build_dir'" to
> >     set default value of 'build_dir' as '' instead of NULL so that kunit
> >     can run even though '--build_dir' option is not given.
> > 
> > Changes from v2
> > (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com):
> >   - Make 'build_dir' if not exists (missed from v3 by mistake)
> > 
> > Changes from v1
> > (https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com):
> >   - Remove "docs/kunit/start: Skip wrapper run command" (A similar
> >     approach is ongoing)
> >   - Make 'build_dir' if not exists
> > 
> > SeongJae Park (6):
> >    docs/kunit/start: Use in-tree 'kunit_defconfig'
> >    kunit: Remove duplicated defconfig creation
> >    kunit: Create default config in '--build_dir'
> >    kunit: Place 'test.log' under the 'build_dir'
> >    kunit: Rename 'kunitconfig' to '.kunitconfig'
> >    kunit/kunit_tool_test: Test '--build_dir' option run
> > 
> >   Documentation/dev-tools/kunit/start.rst | 13 +++++--------
> >   tools/testing/kunit/kunit.py            | 18 +++++++++++-------
> >   tools/testing/kunit/kunit_kernel.py     | 10 +++++-----
> >   tools/testing/kunit/kunit_tool_test.py  | 10 +++++++++-
> >   4 files changed, 30 insertions(+), 21 deletions(-)
> > 
> 
> Hi SeongJae Park,
> 
> Please make sure your From and Signed-off-by addresses match. I tried
> applying these patches and I am seeing warnings.
> 
> WARNING: Missing Signed-off-by: line by nominal patch author 'SeongJae 
> Park <sj38.park@gmail.com>'

I tried to reproduce the warning on my side using 'git am' and 'checkpatch.pl',
but those doesn't show me such warnings.  Could you please let me know what
command you use?  Or, you could simply ignore the warning and use 'SeongJae
Park <sjpark@amazon.de>'.


Thanks,
SeongJae Park

> 
> thanks,
> -- Shuah
