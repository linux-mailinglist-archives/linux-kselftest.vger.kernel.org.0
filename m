Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592A79E0A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 09:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjIMHR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbjIMHR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 03:17:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD4E1984;
        Wed, 13 Sep 2023 00:17:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fbb10dea4so2637445b3a.3;
        Wed, 13 Sep 2023 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694589444; x=1695194244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acu4nw1FXdQveACPv6+swZOIpF9eDwL9S1R/+hJY+40=;
        b=LdnBnjyXqPFfdorvMxFpe/7TnH2mowSHcBuo+m62lLVd3lKkDViTX0ZLV5dCj6GNz5
         +4eBaw/YtM6pr/tjJcU+LVLP2Mkm7tNMcfctSrftOPnPk7xXE1sHe+8XphArjCU4I/TN
         sCW+M/VdjQ3NsjUFex7zE23Wqbe0dfHu2kcASJY0UdWvhkDrlFWn0hYWoUnR+/LGm+EU
         F4m2hONIVNREvZnPzFzEUx3sm/BnMYDsY5mQR6R3JIywYziqFFvuZPaOZIBvOyWklhwm
         3sqeqDn81hKFoyPiu+OZTDi88rfLPF2RgNzFRlMGPVnxOlBCXivEw6peO4CZpaihfc3P
         0FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589444; x=1695194244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Acu4nw1FXdQveACPv6+swZOIpF9eDwL9S1R/+hJY+40=;
        b=ZlbyDJVq/S+wWYSkeLF0ackG1r8z2jsAD99lKU5Zvcx97nPes89/GbxkE2zpo0b11y
         GGSDMxSYhWw37mN3hoMq3QT4y60Vuh+KU3j1nOR06erxOASW6g1gRge01PZT7FGwygPL
         2g/jucePppcKzc/Vmo4KUDMZrFzPK2ivRnnw0QqiVQ6eO1uqqaslozTn2fpMaWKUqmIb
         ghR5sqYJPPownNNHc4ua5Pcj2SCSbN5zeVPECgRm8wHsSUondbRFX3hjZLvsynfjzUKL
         Gfc1hvZkq/PaX26kyWDHSK4aWzIoXaHhAH6S+0jiNOQ20dcT5XXOJ4k7eew3hLhxN2BQ
         lj2A==
X-Gm-Message-State: AOJu0YwyFYA+ZTuxyK07MPVlH62acaLB9WRMJTCLCGifhH634cGq4TrR
        CKINQiiI1ZzgarOm4DvP/K1o9RGhe487ur4BsHk=
X-Google-Smtp-Source: AGHT+IGCsNzD/UpJA9G+hgegxKBvYQkpYChDDeCF7oHQOnNF6IHt41a6oPe9d8KBv4u1GXGEvqZas0QcYddQ4NoqoQQ=
X-Received: by 2002:a05:6a00:18a0:b0:68f:b2f3:7737 with SMTP id
 x32-20020a056a0018a000b0068fb2f37737mr2305803pfh.15.1694589444020; Wed, 13
 Sep 2023 00:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230912083800.57435-1-cerasuolodomenico@gmail.com> <20230912101802.25b280ac306694ff02001706@linux-foundation.org>
In-Reply-To: <20230912101802.25b280ac306694ff02001706@linux-foundation.org>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Wed, 13 Sep 2023 09:17:12 +0200
Message-ID: <CA+CLi1gtgwa7JZC_NvynOKhM59j_hYpAnc+ivTjXobOqHkQb-A@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: fix test_zswap error path and
 meaningless check
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dan.carpenter@linaro.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 12, 2023 at 7:18=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 12 Sep 2023 10:38:00 +0200 Domenico Cerasuolo <cerasuolodomenico@=
gmail.com> wrote:
>
> > Replace destruction paths with simple returns before the test cgroup is
> > created, there is nothing to free or destroy at that point.
> >
> > Remove pointless check, stored_pages is a size_t and cannot be < 0.
> >
> > ...
> >
> > @@ -208,8 +208,6 @@ static int test_no_kmem_bypass(const char *root)
> >               free(trigger_allocation);
> >               if (get_zswap_stored_pages(&stored_pages))
> >                       break;
> > -             if (stored_pages < 0)
> > -                     break;
> >               /* If memory was pushed to zswap, verify it belongs to me=
mcg */
> >               if (stored_pages > stored_pages_threshold) {
> >                       int zswapped =3D cg_read_key_long(test_group, "me=
mory.stat", "zswapped ");
>
> stored_pages will be set to -1 on error.  It would be better to cast
> stored_pages to ssize_t in the check, rather than simply ignoring
> errors?

I'm not sure I understood, isn't it safe to just rely on the return value o=
f
get_zswap_stored_pages a few lines above? In that case we break the loop an=
d
the value of stored_pages is not used.
