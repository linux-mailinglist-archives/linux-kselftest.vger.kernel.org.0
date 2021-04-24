Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE91336A2BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Apr 2021 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhDXTFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Apr 2021 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhDXTFY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Apr 2021 15:05:24 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C47C061574;
        Sat, 24 Apr 2021 12:04:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v23so842069qkj.13;
        Sat, 24 Apr 2021 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EmREJ2/iRw8n3hCpoagIR/SHHYbiB6HFNVxF3BqpXcE=;
        b=Bvx1MzorBEcYwYZLnkgNU1eqcJP9O3U4ynU4Qmb0bJlAUD/ElebctJvi8oIeZOtsRM
         Lwu97kgeDyCD7tQSkQETgR1NaVopc/zeCeUVLSYBnR+T1XMW/s2pTGrl+Y3Jz7TYYW5t
         ZidcznrxCOXRYUe/0qvY2WzacKypTZ0J61mfNBeHyZrLlqpyXEnqBplTfsElZkX6pHzs
         PLxdhPAEUL7r7CbBDNo/BYkncGVeIvt4t9tm4SbF5a6yeRnBvgg+vr0CfCLLnuxyH+zB
         63eXxsnAIPDO19K3mULJucY2bP/GMsA29M8hBYY7lLRynZIdmBrOxZSs02zjkfnWR/ls
         BfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EmREJ2/iRw8n3hCpoagIR/SHHYbiB6HFNVxF3BqpXcE=;
        b=FW6B47sljrcwfdYzImecwrvaSELR6dqhpHcpFf9C3PBfBT6nuBHz6SOI0hSGRDfjTg
         DilOW2MzX+qtwAuOxx+Tthikk/LSVlI37CvqYNwgKckCQMBuY0/1g0XcZxM91OsKw1yM
         s4n8gvUVGRFzpyAW80gdn+14fZs3VWUSVCr4VG2SPIWhZtQB9b7oq+484EoT9xBbLVXN
         g44XhgAbJQlQLBzape56s6Yg6YJFDcP7o0NTDOvrBzOay24BJcXUlOSoPW65RIQlPAyw
         J1VPiXyB+Q0zPGvRcsb8uK5HSSzT6CT0++8Cwj1HT1KO3K5rAG5L6ISsqBDp8IKIWd0U
         IntA==
X-Gm-Message-State: AOAM531lLH5NV70dLsnNd+FRE61arEMOx+d+5kfhF7eNXASw665r5zg3
        HU0FzxsvFlVMC0KgkQg+uJMvnzUvz+lZlA==
X-Google-Smtp-Source: ABdhPJwO6DpoeBBrWiO7IviNss6A856Tm0ryAhdIaD6aAsimCq1O/C8d6ELBmk+NX5+GT6pwYkGXJg==
X-Received: by 2002:a37:58c5:: with SMTP id m188mr9823498qkb.327.1619291084626;
        Sat, 24 Apr 2021 12:04:44 -0700 (PDT)
Received: from smtp.gmail.com ([2804:30c:909:ed00:eb66:a9ae:aa9c:152f])
        by smtp.gmail.com with ESMTPSA id u4sm1005367qkp.22.2021.04.24.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 12:04:44 -0700 (PDT)
Date:   Sat, 24 Apr 2021 16:04:41 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andersonreisrosa@gmail.com
Subject: Running kunit_tool on unclean trees
Message-ID: <YIRryUf6noodWiqe@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, a friend and I were chasing bug 205219 [1] listed in Bugzilla.
We step into something a little bit different when trying to reproduce
the buggy behavior. In our try, compilation failed with a message form
make asking us to clean the source tree. We couldn't run kunit_tool
after compiling the kernel for x86, as described by Ted in the
discussion pointed out by the bug report.

Steps to reproduce:

0) Run kunit_tool
$ ./tools/testing/kunit/kunit.py run
Works fine with a clean tree.

1) Compile the kernel for some architecture (we did it for x86_64).

2) Run kunit_tool again
$ ./tools/testing/kunit/kunit.py run
Fails with a message form make asking us to clean the source tree.

Removing the clean source tree check from the top-level Makefile gives
us a similar error to what was described in the bug report. We see that
after running `git clean -fdx` kunit_tool runs nicely again. However,
this is not a real solution since some kernel binaries are erased by git.

We also had a look into the commit messages of Masahiro Yamada but
couldn't quite grasp why the check for the tree to be clean was added.
We could invest more time in this issue but actually don't know how to
proceed. We'd be glad to receive any comment about it. We could also try
something else if it's a too hard issue for beginners.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=205219


Best Regards,

Marcelo
