Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD17D00A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjJSReZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 13:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjJSReZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 13:34:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9EF121
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 10:34:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso14218071a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697736861; x=1698341661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrMvigYB3sGbXrzmGtkW+duvRLkjqgFO+ebJCA8YXIo=;
        b=xvmEuloFUK5vMxtbHzs2mrZRiBWtrFHkq5R4Tdr4Rf029w4U+DZvh9ZLc3EWbftwM7
         FK407yfgM4XUX0AmqgPmcqvxgqcSTdhVg35i/vXFUVNMOYnaMiDTSt8EY9bLMVZTLAke
         Z87XX1G2gxSYeqYzZaZYqA7cMo/kh2srtKYU1YNI7t0g9NcDe2w5HZLEYo5xrHmIJdOn
         M79Sfm5QQvIuovE64NvE5tA6qO7ckxrhVXNWKTCXmqoj4jJzugnqiA8CxIadBM4qdH49
         87UHJVRwzQtYWty/nZev1c9pW6IHFcDRXEvFP2ZQxY1s8MzHjdK5FEbb0TT5ri5NtrM0
         g/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736861; x=1698341661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrMvigYB3sGbXrzmGtkW+duvRLkjqgFO+ebJCA8YXIo=;
        b=qmoQvweGwK1Z1KZTkSHH/WSPM7DxBolZ1SW+T9jLNbC7nBXLujVYr0L4yC7kJmgwm/
         A7oCKmlkcz2VKYZ8wnqbUpu4BDklCHy6JG9YJfA7SEUzmLE0e6j/m1yxbyXqOFPoJAA2
         Oxpyq0l52wKmWEAeqEzFr6nLLBkqA4mL4Z67+X7xTbUt0o2xC5UeJPz/rhA5C80Zmy5g
         J83LeYdCF1Xzx4bEqyWdbZ7109ODo70NCZtMeRVWTlrHJKW/2DJd58RTUXiFznPcNdO2
         KvVJs/rbjbm0RsIBtm2RKj+ORiJ33WAWyiFM5yipCh1opqhlZrC/sAkMku45bpsT2JZI
         jUzg==
X-Gm-Message-State: AOJu0Ywu3wuXlpQLNMmcAM/NgQv2ygclJ6mQfChJ0bYnCbyYKKzD3AZb
        mVSzJYWL6sk2euOEkpC9vveKIrISoSNXa1vw2gQUog==
X-Google-Smtp-Source: AGHT+IEXaAShkeRYMp2kuDHKws4X4gLvdPhiPGnuGhJBGTip6n1Ab0xYv3oA9sQrddtbSVhOwchiiQkFTqpYi+Oct/Y=
X-Received: by 2002:a17:907:2da9:b0:9c5:cfa3:d044 with SMTP id
 gt41-20020a1709072da900b009c5cfa3d044mr2405065ejc.19.1697736860992; Thu, 19
 Oct 2023 10:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231019101204.179a9a1d2c7a05b604dad182@linux-foundation.org>
In-Reply-To: <20231019101204.179a9a1d2c7a05b604dad182@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 19 Oct 2023 10:33:43 -0700
Message-ID: <CAJD7tkYZ826ysjnoSbYnTH3h7eWKOE=ObHNCADb78c4x7NBHzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] workload-specific and memory pressure-driven zswap writeback
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 10:12=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 17 Oct 2023 16:21:47 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > Subject: [PATCH v3 0/5] workload-specific and memory pressure-driven zs=
wap writeback
>
> We're at -rc6 and I'd prefer to drop this series from mm.git, have
> another go during the next cycle.
>
> However Hugh's v2 series "mempolicy: cleanups leading to NUMA mpol
> without vma" has syntactic dependencies on this series and will need
> rework, so I'd like to make that decision soon.
>
> Do we feel that this series can be made into a mergeable state within
> the next few days?

There are parts of the code that I would feel more comfortable if
someone took a look at (which I mentioned in individual patches). So
unless this happens in the next few days I wouldn't say so.

>
> Thanks.
