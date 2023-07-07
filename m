Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F1E74B866
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGGVBy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjGGVBx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC5E212D
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688763666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dan6bESP0QByFGbOI4lpud/XpYRSbdBr9ACkzPME/Us=;
        b=cb/+TNLXO8+hFn7AlblGX3rttUE/QV7GmsI4hStTOEEjdWnTre9XMO1z4lTcZk9W1BCkEi
        krHxp31VQBTGZEKW2iSjFs5AxrySZI3fpU+DBnGNQO2034YxVd9fOGxV5GLquyixzqHTe7
        5EYLTPZhrgr1Al02W5oAGNdGU5MzO+Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Zlp59XTFMcO30tPnEWttWg-1; Fri, 07 Jul 2023 17:01:04 -0400
X-MC-Unique: Zlp59XTFMcO30tPnEWttWg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635eb5b04e1so5943326d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688763664; x=1689368464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dan6bESP0QByFGbOI4lpud/XpYRSbdBr9ACkzPME/Us=;
        b=gQ4VZHKFOvLr+J2IiekkSjVPRJPt91vvzSg/L3vKc1QVDAgf5c9C86Xfpt1JANBavY
         a4zJIsgzGH5hM+5RQGFwv8eZY/NSAD6S97HDYhBkgehyYQaRWPSi4ttz+gX5yhygojtm
         j8h+wVL3DgqRav3Z7OQc61P60UJfNP8HDkOj/vtcJOtOhWFapk/JztNKcwarkDmtDEhS
         /VY1FUboryGVul98axm9t3B22/XioBsfddplvPf99C6Dl/VxepMmHJKBMC0sXryOE9+S
         udl3bMps4oFa4YX4cOAhyTx1DkPXeduZua4k5p+RFrnyFtuwlj9Ewg7RnKHBaicLQP0V
         ltIA==
X-Gm-Message-State: ABy/qLYpdE2MLxfzdKu9R+XGqT7I9+OxCBxf3E+QkSqjW+6BP3M8X9zx
        HntMP/Rw2CMJbOtkRFONzcS986wTuTebkGdl4JUrib6Qf1p5S7JX9LWNjvcz+kdygXYGTNb96Ik
        3xgCz7NhXzBYLDfuxfLqdH//3RThZ
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr6797779qvb.6.1688763663952;
        Fri, 07 Jul 2023 14:01:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFi3ocgTXjlN1S3jnNJ0aY+HPfd5soOuCrai0nkztgKDiV5HmKoftoqMO6HM1sv+8OME69FPA==
X-Received: by 2002:a05:6214:411c:b0:62b:5410:322d with SMTP id kc28-20020a056214411c00b0062b5410322dmr6797738qvb.6.1688763663680;
        Fri, 07 Jul 2023 14:01:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a127600b0074d60b697a6sm2203149qkl.12.2023.07.07.14.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:01:03 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:00:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 7/8] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
Message-ID: <ZKh9AT96XiZ+6nCC@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-8-axelrasmussen@google.com>
 <ZKgWOYuIdqa25Qcs@x1n>
 <CAJHvVcj-3gUC3dx4LAVnNr-zgo8+cwjGNafQ480EhDifojrcRA@mail.gmail.com>
 <CAJHvVci6qCv+d7Hz0QkqeuEZze0OFJt0P9qnWgA_cgDeaLmptQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVci6qCv+d7Hz0QkqeuEZze0OFJt0P9qnWgA_cgDeaLmptQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 07, 2023 at 01:38:16PM -0700, Axel Rasmussen wrote:
> Ah, so I tried switching back to the {0} initializer, and was reminded
> why I didn't do that in v1. :) Ignoring the missing braces warning I
> talked about before, using {0} here is actually an error
> ("variable-sized object may not be initialized") because this is a
> variable sized array (nr_cpus isn't constant). So, that option is out.
> 
> I'm not a huge fan of adding the free() cleanup and dealing with all
> of the err() calls this function has.

Oh, that's definitely not needed - as long as we know we're going to quit,
we let kernel clean everything is fine.

I just worry in the future there can be a loop of userfaultfd_stress() so
it can OOM a host even if no err() hit but by looping.  I hope I explained
what I meant.. so it's still good we make sure things freed properly when
in success paths and when we're at it.

> 
> Originally I switched to calloc() because I'm not a big fan of VLAs
> anyway. But, as a compromise in v4 I'll leave it a VLA, and switch to
> memset() for initializing it.

That'll be good enough to me.  Thanks a lot,

-- 
Peter Xu

