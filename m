Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3C52CE1B6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Dec 2020 23:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbgLCWdI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Dec 2020 17:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbgLCWdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Dec 2020 17:33:06 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AACAC061A54
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Dec 2020 14:32:26 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id z12so1920039pjn.1
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Dec 2020 14:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=SPmFoB1my9jXoLv2dn26VSZIQKA7cIMRdqpuLUFB/zE=;
        b=uibFYOvnC4zY0yQjSghNFXGoITN/klJGjUJawm7CLMgnwHLEgoSF8aYrp3JujngJOL
         Q1/1efT1Sk1ZvEgzkg0itaC6uT+mpiCbV+wr2qFTg/EhXoM8USYjKCA49GdnVTWWZ0tP
         rahJLwwp8GwB0lIDDNsa/yfR1+ZYu8Jzevvs/J5ONrYw8jKGlEw9eov6jWgP39zOBXFG
         iIH8Qv+lpLNP2Zhd2G7dAvg8kGv/PxOxkG6KmZP9h1L9cCQQNa1jrvom/D1PErxBspZJ
         iVqODTL1y2FkymUDIFPNBB6S6aotiP8SU7ZbbYz16SRlFub6isCp3ufmz/yH1ijPlqxp
         oF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=SPmFoB1my9jXoLv2dn26VSZIQKA7cIMRdqpuLUFB/zE=;
        b=rIU+CJMzM4UoibBiK1S9G5pD/AJiHfb41M4DzBoEV0C4xTnLfn4vKLKaN2MjQ1KQMh
         J9PexuDHdgYywUpix1ecTFFHV0kGD3KGKhQZyL6gDrxE9FZMIPJfc2ai7GXsP2BTUxM6
         PEGppl7tY7MgdFfJbdBf+e60XkSvcPh0psgoJC8CLDuEZimNq7aQi66jF4OFXZ8mTpbc
         /u3qAGdAXx43GOSf8ORw4E+nEigPE8VjQCVgsb1PcwbaooRnTGf67OOM2VOWcUqvSiuO
         XCzxLHjxzNCEq1SrND/G15qh/Zu9KBpM0RhqWg4VX8s0m8oVEy10AvvmrGcQLwE/JhM1
         J6kg==
X-Gm-Message-State: AOAM532YoH7jT5EhHPidQrLuFSOf6ZdeVLW3y27vp1AYnJaCQ38Q/mcC
        skFG+9cnmtqbnjq8v4c4zyfK5A==
X-Google-Smtp-Source: ABdhPJxhPr+P5fujnqKI96o2pvSvJ5MAQGdtq4scxTMGJtMVGb63v//A39PGQQlbMjp5MmCtDbhQGg==
X-Received: by 2002:a17:902:469:b029:da:17d0:e755 with SMTP id 96-20020a1709020469b02900da17d0e755mr954487ple.53.1607034745298;
        Thu, 03 Dec 2020 14:32:25 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x23sm2646437pfo.209.2020.12.03.14.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 14:32:24 -0800 (PST)
Subject: [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to userspace
Date:   Thu,  3 Dec 2020 13:58:54 -0800
Message-Id: <20201203215859.2719888-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, song@kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch set contains dm-user, a device mapper target that proxies incoming
BIOs to userspace via a misc device.  Essentially it's FUSE, but for block
devices.  There's more information in the documentation patch and as a handful
of commends, so I'm just going to avoid duplicating that here.  I don't really
think there's any fundamental functionality that dm-user enables, as one could
use something along the lines of nbd/iscsi, but dm-user does result in
extremely simple userspace daemons -- so simple that when I tried to write a
helper userspace library for dm-user I just ended up with nothing.

I talked about this a bit at Plumbers and was hoping to send patches a bit
earlier on in the process, but got tied up with a few things.  As a result this
is actually quite far along: it's at the point where we're starting to run this
on real devices as part of an updated Android OTA update flow, where we're
using this to provide an Android-specific compressed backing store for
dm-snap-persistent.  The bulk of that project is scattered throughout the
various Android trees, so there are kselftests and a (somewhat bare for now)
Documentation entry with the intent of making this a self-contained
contribution.  There's a lot to the Android userspace daemon, but it doesn't
interact with dm-user in a very complex manner.

This is still in a somewhat early stage, but it's at the point where things
largely function.  I'm certainly not ready to commit to the user ABI
implemented here and there are a bunch of FIXMEs scattered throughout the code,
but I do think that it's far along enough to begin a more concrete discussion
of where folks would like to go with something like this.  While I'd intending
on sorting that stuff out, I'd like to at least get a feel for whether this is
a path worth pursuing before spending a bunch more time on it.

I haven't done much in the way of performance analysis for dm-user.  Earlier on
I did some simple throughput tests and found that dm-user/ext4 was faster than
half the speed of tmpfs, which is way out of the realm of being an issue for
our use case (decompressing blocks out of a phone's storage).  The design of
dm-user does preclude an extremely high performance implementation, where I
assume one would want an explicit ring buffer and zero copy, but I feel like
users who want that degree of performance are probably better served writing a
proper kernel driver.  I wouldn't be opposed to pushing on performance (ideally
without a major design change), but for now I feel like time is better spent
fortifying the user ABI and fixing the various issues with the implementation.

The patches follow as usual, but in case it's easier I've published a tree as
well:

    git://git.kernel.org/pub/scm/linux/kernel/git/palmer/dm-user.git -b dm-user-v1


