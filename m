Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12533294C5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 14:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442271AbgJUMRd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 08:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411517AbgJUMRc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 08:17:32 -0400
Received: from mail.kernel.org (ip5f5ad5a8.dynamic.kabel-deutschland.de [95.90.213.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6A422453;
        Wed, 21 Oct 2020 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603282651;
        bh=ZThY5uPrN8m7PVeYj6yV3k4YTH50nRqHVbTBxoDTc5M=;
        h=From:To:Cc:Subject:Date:From;
        b=eLjiVAUbctSCqXFNEqOjYCcD0lD36EsozUQwQLXQib17OkD1maRKTKIGr2Sfggau3
         MkRA3zzFiQNh47QZlV8cJjzX/nrnNCZAV/sHmguIAyCCH4oLr9VIY1qSgtkUKuBp7s
         7Q/wiluVMS9Ay8unKODOQ7hNqNbe2LcMEjwM37mg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kVD3Y-001U2X-88; Wed, 21 Oct 2020 14:17:28 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colton Lewis <colton.w.lewis@protonmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        David Sterba <dsterba@suse.com>, Dennis Li <Dennis.Li@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Evan Quan <evan.quan@amd.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Kees Cook <keescook@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH v3 0/6] Documentation build fixes against upstream
Date:   Wed, 21 Oct 2020 14:17:21 +0200
Message-Id: <cover.1603282193.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As we're close to the end of the merge window for Kernel 5.10,
this series contain the patches from the past two documentation
fix series I sent during the merge window and that required more
work.

It is based on the top of upstream. The full series with the patches
that either didn't generate any reply or have been acked is on
this branch:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=docs_for_v5.10

There are a couple of warnings that aren't addressed here, because
they don't show at linux-next. I'm keeping a second patch series 
against next-20201021 fixing additional warnings caused by patches
pending merges.

I'll be posting those in separate.

Regards,
Mauro

Mauro Carvalho Chehab (6):
  drm: amdgpu: kernel-doc: update some adev parameters
  docs: lockdep-design: fix some warning issues
  locking/refcount: move kernel-doc markups to the proper place
  IB/srpt: docs: add a description for cq_size  member
  kunit: test: fix remaining kernel-doc warnings
  docs: fs: api-summary.rst: get rid of kernel-doc include

 Documentation/filesystems/api-summary.rst    |   3 -
 Documentation/locking/lockdep-design.rst     |  51 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  28 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |   7 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h        |   1 +
 include/kunit/test.h                         |  16 +-
 include/linux/refcount.h                     | 158 +++++++++----------
 8 files changed, 139 insertions(+), 131 deletions(-)

-- 
2.26.2


