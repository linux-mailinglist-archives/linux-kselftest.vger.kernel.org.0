Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7359CAAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 23:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbiHVVTD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiHVVSz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 17:18:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D91C917;
        Mon, 22 Aug 2022 14:18:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ce26so8020603ejb.11;
        Mon, 22 Aug 2022 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=hDBKv/8ETnnMAaccShR4P83NaWgmzGbvbXWVBFeEpZs=;
        b=Agb6dLlefvQ0ywqpkO9npD7PMFEuELAonA9/uR/3ED/19kgFs48eCTwzWibSYdoYB3
         DrDFaWXL/dEe6q9xW3acXvvfsXr/bTouRaWYsCZvNAH68cRm22CJn1JYJuXOugYALhpp
         dG/Ff+2OpW/POnCZfTawOTpMN2t3hqtKfEIisml3Q35HWId9NYf9Fb9KZFxnoidiOwGk
         m97IbqdVCKN3GuvqZZikN/droGeIoodQcg4Ak0WbZ8HU6Gm+anG0rfm4NCNNvUDf4t9h
         AjxIfDOEFJ9LtFYH0k28wzowKEg4hxuQH7kOmpU6d67MZ0HFTy2i6+8pZF4oXnUM2AFD
         Nnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=hDBKv/8ETnnMAaccShR4P83NaWgmzGbvbXWVBFeEpZs=;
        b=CA5V8/d30CUGsji1Uu+TEhydXUbKcPGJAucc8Vyr4MqQT4ljLHJ7jsnreeLsxXb/1i
         sylSNvaorMN+bbVPp8lz7Qmum/k7lrpUrSjpstfc9iop7gKtLbm9LukrUQ4J6DaLqBKf
         fAK36Iv17eacq9tiFNyL1wWlcOSEOO8jdBfiUc35RhAEYt//u0r+AbQlqxmZnMjLKVRu
         iAmHoPaQNZbt7ITldetrs4F2DT/dtlev95KcqdyEzu1/z3UgipamWcfPuIk6WYgZllbW
         nwCOPPVbGvebphJZZ6xCOIseydBpWdwA3aPKXCOgyjyiIGnMruBZA2n1ueNRMkI0Xtmp
         9nhQ==
X-Gm-Message-State: ACgBeo0XXugRZjymqjsi9Av6/Sf7n8RwqyWzaeHtMG1C22KE/RJOxaT5
        Mw8mmAkIgMAnAJIB58kyxtY=
X-Google-Smtp-Source: AA6agR4flPRskv4WzfFSo3rseB/ZFjSM0puxTqggg6Nj7vbqYDmEL65VVvD88GkBoLsO+Q0TEmHT8Q==
X-Received: by 2002:a17:907:1b0e:b0:72f:9b43:b98c with SMTP id mp14-20020a1709071b0e00b0072f9b43b98cmr14059971ejc.710.1661203132032;
        Mon, 22 Aug 2022 14:18:52 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id m26-20020a056402051a00b004464c3de6dasm280381edv.65.2022.08.22.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:18:51 -0700 (PDT)
Date:   Mon, 22 Aug 2022 23:18:49 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, mic@digikod.net,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH -next 0/5] landlock: add chmod and chown support
Message-ID: <YwPyuX7oao6EqTvJ@nuc>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <YwPWN/d15S24PuLS@nuc>
 <39df1a34-51dc-da55-ff1c-59cab896c8a0@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39df1a34-51dc-da55-ff1c-59cab896c8a0@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 22, 2022 at 12:35:18PM -0700, Casey Schaufler wrote:
> On 8/22/2022 12:17 PM, Günther Noack wrote:
> > Hi!
> >
> > Very exciting to see! Thank you for sending this! :)
> >
> > I'm just throwing in some comments based on the very similar truncate
> > patch set, in the hope that it helps. (But obviously, Mickaël Salaün
> > has the last word on this code.)
> >
> > Slightly higher level question: Should we start to group the
> > functionality of multiple LSM hooks under one Landlock flag? (Will it
> > be harder to change the LSM hook interface in the future if we
> > continue to add one flag per hook? Or is this structure already
> > exposed to userspace by other LSMs?)
>
> I'm not a landlock expert. The question is nonsensical, yet somewhat
> frightening nonetheless. Could you put just a touch more context into
> what you're asking for?

By "Landlock flags", I meant the integer that Landlock uses to
represent the set of possible operations on a file hierarchy:

Landlock's file system access rights (access_mode_t on the kernel
side) are defined with an integer with flags (LANDLOCK_ACCESS_FS_*)
for different operations that one might do with files. They get used
from userspace to control what is permitted on which parts of the file
system. (Docs: https://docs.kernel.org/userspace-api/landlock.html)

Currently most of the available Landlock flags map pretty closely to
one of the file- and path-related LSM hooks. (See various hook
implementations in security/landlock/fs.c)

The file system operations that Landlock doesn't cover yet (as of
kernel 5.19) are listed below, and there are potentially a few more
that might be missing. I suspect/hope that there will be more patches
in the style of the truncate/chmod/chown patches, which will add that
coverage.

The question is basically:
When these patches get added, how should the userspace-exposed
Landlock file system access rights map to the LSM hooks for these
upcoming Landlock features? Should each of the newly covered
operations have its own flag, or is it better to group them?

(It's well possible that the right answer is "one flag per feature",
but I feel it still makes sense to ask this before all these patches
get written?)

—Günther

> > For example, some of the "missing" operations listed on the Landlock
> > documentation could also be grouped roughly as:
> >
> > Modifying files:
> >  - truncate
> >
> > Modifying file metadata:
> >  - chmod
> >  - chown
> >  - setxattr
> >  - utime
> >
> > Observing files (check presence and file metadata):
> >  - access
> >  - stat
> >  - readlink, following links (can observe symlink presence)
> >  - chdir (can observe dir presence and 'x' attribute)
> >
> > Ungrouped:
> >  - flock
> >  - ioctl
> >  - fcntl
> >
> > Do you have opinions on this?
> >
> > —Günther
> >
> > On Mon, Aug 22, 2022 at 07:46:56PM +0800, Xiu Jianfeng wrote:
> >> hi,
> >>   this patchset adds chmod and chown support for landlock
> >>
> >> Xiu Jianfeng (5):
> >>   landlock: expand access_mask_t to u32 type
> >>   landlock: add chmod and chown support
> >>   landlock/selftests: add selftests for chmod and chown
> >>   landlock/samples: add chmod and chown support
> >>   landlock: update chmod and chown support in document
> >>
> >>  Documentation/userspace-api/landlock.rst     |   8 +-
> >>  include/uapi/linux/landlock.h                |   8 +-
> >>  samples/landlock/sandboxer.c                 |  12 +-
> >>  security/landlock/fs.c                       |  16 +-
> >>  security/landlock/limits.h                   |   2 +-
> >>  security/landlock/ruleset.h                  |   2 +-
> >>  security/landlock/syscalls.c                 |   2 +-
> >>  tools/testing/selftests/landlock/base_test.c |   2 +-
> >>  tools/testing/selftests/landlock/fs_test.c   | 234 ++++++++++++++++++-
> >>  9 files changed, 274 insertions(+), 12 deletions(-)
> >>
> >> --
> >> 2.17.1
> >>
> > --

--
