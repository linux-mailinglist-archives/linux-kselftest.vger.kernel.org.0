Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73377D17F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjHOSHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbjHOSHQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:07:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A81987;
        Tue, 15 Aug 2023 11:07:15 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79095499a17so246727239f.3;
        Tue, 15 Aug 2023 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692122834; x=1692727634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VPx8QGORtNg5bUCZpRkMX7Gr4rCncHGCoyJkqRF/4g=;
        b=a7Nk99b2Wjv/TDe7+U4g7ZdqAqL/N/lNcJx3oQHGk/kHE6JMVQkP2s9XUIjY+m4A9R
         9zSnWzI7dTfp3fs+jM7AUueRIWd+6iOXz+6pW/Nm9gRvRi04osKK+eWstmb+REheziJj
         /R7vHX5WefZ236SmK2qXUQnbWK7OD6RKAaOMuTrKkKxPmA4OsufHyGbtuv5bKc0MDVIh
         lGr3L7ZYpb6THtqM0j14RLBl2iz0koU3t248teffMzNO1CLUrubDoQ8pFsja7vEF8Ah+
         NvzwYffRRN6jUeNNfQS0eVfxSA8tKq2dwQaioddpM0BXvQ/k2Y8mU6FMhfuyksBwwzoJ
         nfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122834; x=1692727634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VPx8QGORtNg5bUCZpRkMX7Gr4rCncHGCoyJkqRF/4g=;
        b=Je9G9GeDbac50aL0s3KpDdWEVmmW4NIXKffiZ1vuLsj39CwGR+aUxc0RmaNR6jmW6a
         lM/+1Gh560S9NOwlReswdwSjqS+Vs6oddCxPsPyJDRmZVL1opB6Xq3ZU8kzYr170DRQh
         88mrB04/G4mGAiVB4vDrD4Pm1cJtoqspxoo1tV6fsBuvHQRTo67TKvAi/+iZvYDdLEmQ
         5yd4Cy6u8On/z/NRkDhL2kLpdOE4NlJeGj4k2Q1d33Y6YTHN4bp9mgZDy1cCkO8JkoDU
         X1yPtao3E5rPvv+AoJrio+rPn/b4n8ecyb8B/WdxYmX0g13Sq1xs3HK+YxMwJqm5S34a
         t2+A==
X-Gm-Message-State: AOJu0YykG4M5mvynu1DqgU8hPiyJORNocXmaGBTxANMW2vgj22ug3Qgn
        k2seulg8Qoh+pdTM16DmsICK5r4by4PPImHu39pWxZyLV59fhw==
X-Google-Smtp-Source: AGHT+IHeLOuQP7iwwLLTQZPtYaapj6AB8sXE5zlz/r9WRsB//3BgeG3DTERDW+dm3uKTF1DhwZEmqfwIODxDuy6+48w=
X-Received: by 2002:a05:6e02:2197:b0:346:d51:9922 with SMTP id
 j23-20020a056e02219700b003460d519922mr22291641ila.13.1692122834538; Tue, 15
 Aug 2023 11:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230815155612.2535947-1-andre.przywara@arm.com>
In-Reply-To: <20230815155612.2535947-1-andre.przywara@arm.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 15 Aug 2023 11:07:03 -0700
Message-ID: <CAKEwX=OFsmTNyF-f=j53f34u8aiOhWf4N6tUW11TdppNW5YbnQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] selftests: cachestat: fix build and run on older kernels
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 8:56=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> I ran all kernel selftests on some test machine, and stumbled upon
> cachestat failing (among others).
> Those patches fix the cachestat test compilation and run on older
> kernels.
>
> Also I found that the but-last test (on a normal file) fails when run on
> a tmpfs mounted directory, as it happens on an initramfs-only system, or
> when the current directory happens to be /dev/shm or /tmp:
> # Create/open tmpfilecachestat
> # Cachestat call returned 0
> # Using cachestat: Cached: 4, Dirty: 4, Writeback: 0, Evicted: 0, Recentl=
y Evicted: 0
> # Cachestat call (after fsync) returned 0
> # Using cachestat: Cached: 4, Dirty: 4, Writeback: 0, Evicted: 0, Recentl=
y Evicted: 0
> # Number of dirty should be zero after fsync.
> not ok 6 cachestat fails with normal file
>
> That same test binary succeeds on the same machine right afterwards if
> the current directory is changed to an ext4 filesystem.

Ah, if I recall correctly, these kinds of fs have no-op fsync, correct?
Something along the line of:
https://github.com/torvalds/linux/blob/91aa6c4/mm/shmem.c#L4111
The fsync logic would fail indeed. Thanks for pointing that out!

>
> I don't really know if this is expected, and whether we should try to
> figure out if the test file lives on a tmpfs filesystem, or whether the

This would be nice. I think there's a userspace method to check
this, right? There's a TMPFS_MAGIC here - not sure if relevant:

https://man7.org/linux/man-pages/man2/statfs.2.html

> test itself is not strict enough, and requires more "flushing"
> (drop_caches?) to cover tmpfs directories as well.
>
> Any ideas how to fix this would be appreciated.
>
> Cheers,
> Andre
>
> Andre Przywara (3):
>   selftests: cachestat: properly link in librt
>   selftests: cachestat: use proper syscall number macro
>   selftests: cachestat: test for cachestat availability
>
>  tools/testing/selftests/cachestat/Makefile    |  2 +-
>  .../selftests/cachestat/test_cachestat.c      | 29 +++++++++++++++----
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> --
> 2.25.1
>
