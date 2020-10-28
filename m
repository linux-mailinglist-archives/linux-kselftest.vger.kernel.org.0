Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58029D5B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 23:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgJ1WIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgJ1WIO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD87C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:08:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s21so1225323oij.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oi3DVB8F/e6EwkVxfJQHDyhN7VFOzS0P58Y6d1svvv8=;
        b=jXVmiXZu8yXdx16UWUKRRcQW3d958GquYkHbBD+UBM1BPN+6qvYgJfy3VeQGJ24Er9
         Zyy9kg0kOBFCkTfmlt7AEiymxOS24MvSVlxaGJlT6LDTdTo3HkObCm3o5CAvLdeKuEd1
         1MwK/jhtdR6eAYlD5msixjWuvxQ51caQvrx8vzMywcPUfkh8s7wGVU8/y0uZQxmO/dSK
         rmwJebMNGW26sQmiMxBvnwuNwp15brRu5elZDrXOKsuAB9tEMmk9UYuC0pciTb+7Cu89
         UkP+tgbtvoWYq7vgxJZkAf1eJgARDuCB6qEs7dSVONNSpoDituc/ejF+0MtQZoDaGf07
         PDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oi3DVB8F/e6EwkVxfJQHDyhN7VFOzS0P58Y6d1svvv8=;
        b=mwAgwePkCLVgEKq1muX744AeYCn1JpYbRSDGALpCHcHLp2iX+Dq3igNfeidSYxgCPK
         0Otn055P+dr1FzerYnI3Ai4+iaUsDqDbLbs0LHPfQikeBDCQj2GLxieYC4+GuOe/ahIL
         XiOVIjtAr8S2qI4Fx5osr2EdpeEBW/5dtOThFF00XLj2Pbi4WB7EYzvDU5v9JqqGXKPD
         ZK7v/ch7B15zkKqSTUK2k6OrX41RvBGsTEKvEmADbKAwyn54mhZxNgraRd8fFcwZvdZ7
         qtdNx2wf5Uj0IbbpUd4OalTKir0ZLJVHqP7B5e0BZOjsp0fqvQnWo1satTTay/hHUXda
         cjYA==
X-Gm-Message-State: AOAM531c3a6/2zCu+wMycp/0nZTqmcGJyIwofcsv5vecU6n+YR5PX/46
        xgYP3L8/77RcuemSCGc5gkOXLoP5UttDpa4s8NpPaUdXfYQ=
X-Google-Smtp-Source: ABdhPJxj/onBTr0+oaQG6L0+1VCfWvQlbvRrZgPHmV1pKzB6lkeZtNDMJpWQCfeN82ldP6Q5gdmTTr3To2SpR/zHFMs=
X-Received: by 2002:a54:4812:: with SMTP id j18mr4608973oij.70.1603873837192;
 Wed, 28 Oct 2020 01:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201027174726.85284-1-98.arpi@gmail.com> <202010280748.WUyq8OoJ-lkp@intel.com>
In-Reply-To: <202010280748.WUyq8OoJ-lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 28 Oct 2020 09:30:25 +0100
Message-ID: <CANpmjNON4e6Gh7-NQw4CT4e--vOrH_rFyGi9U9TiUNS_zn+_vw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     kernel test robot <lkp@intel.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        kbuild-all@lists.01.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 28 Oct 2020 at 00:50, kernel test robot <lkp@intel.com> wrote:
>
> Hi Arpitha,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on ext4/dev]
> [also build test WARNING on linus/master v5.10-rc1 next-20201027]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201028-015018
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: mips-randconfig-r016-20201027 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/2de1e52708cd83d1dc4c718876683f6809045a98
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201028-015018
>         git checkout 2de1e52708cd83d1dc4c718876683f6809045a98
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from fs/ext4/inode-test.c:7:
>    fs/ext4/inode-test.c: In function 'ext4_inode_gen_params':
> >> include/kunit/test.h:1735:58: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>     1735 |   return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;   \
>    fs/ext4/inode-test.c:214:1: note: in expansion of macro 'KUNIT_ARRAY_PARAM'
>      214 | KUNIT_ARRAY_PARAM(ext4_inode, test_data);
>          | ^~~~~~~~~~~~~~~~~

So this means we probably want to make the param_value, and the return
and prev types of the generator "const void*".

Thanks,
-- Marco
