Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC574B195
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGGNQm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGGNQj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 09:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC9B1FEA
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/scmW41nRLEVCcvmVFRaHD3MznC8NV7fH9vmMT3xxpU=;
        b=XKz+z5z+XaIBEKxFucvEi7DBUwmuvpqt4f3Bd/5X/j5dqZc23qSfkFJX9hDeC6wk67KOlQ
        EaELiesjnetegZnBmi7O7GOGJpMVkggoK46SBEWk9oXXpCOD5RtFOWal5DNRh1mn7v7PIi
        N5oJxzHfj4YA2JHNYOPvr5RoIkxrhCY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-dwJyDaMYNRizRLjpwobulw-1; Fri, 07 Jul 2023 09:15:49 -0400
X-MC-Unique: dwJyDaMYNRizRLjpwobulw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765ad67e600so39015485a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735749; x=1689340549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/scmW41nRLEVCcvmVFRaHD3MznC8NV7fH9vmMT3xxpU=;
        b=dMksYY7+gkwtlY5bGL+uvo21sGwROo4ln/BuGRbvl1YiiIKQdeeoCDY1GxHZCUnSd3
         FdOdoqAYgUxqa2X7zq6QpGdS3rCs9h+PV5sMoiGsZJIuVpG5IZdITN+rjqzas+90I3Jd
         XxKnh0NE7GH9IvbRke3JEhEtxr+b9sYkieKz2oZJohC+lEUKK71u4uaDqd604gkbMWDE
         MYwsmL138Tzd+uI3bqRo8U69qQJWipfAdB8EBJmGT00tPOIKUFp7sqe3miQiS0WXBbv9
         ixtUZ9vdpqpZu1POre6NF4Rp21Y9PySogRcd1u3p4Mw/JhIjCYO2mMzFNukCq2t98zIP
         dMjQ==
X-Gm-Message-State: ABy/qLbU2LT7HAEhBROg3XsxjHZv2I24vYwTFcU4b6HBv0GcHNP+y5T6
        sEy9yIP1LsZLuq/I5hoaedoAT5hZ8nhkUWt0B9TMwNPG6ANJR8H46V/6UrwC7qU0/71qTR4yJ8g
        V98tJhc01leKME4QYZsoVeYzc7esq
X-Received: by 2002:a05:620a:1908:b0:765:a957:f526 with SMTP id bj8-20020a05620a190800b00765a957f526mr5626643qkb.3.1688735748795;
        Fri, 07 Jul 2023 06:15:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGcT7o9U4nGwCRjHqy1oj78ajsK+fO3PKeth2RE5DnD0ZtdR5yHIs+kzadtUDYBH9DWM2VOg==
X-Received: by 2002:a05:620a:1908:b0:765:a957:f526 with SMTP id bj8-20020a05620a190800b00765a957f526mr5626622qkb.3.1688735748545;
        Fri, 07 Jul 2023 06:15:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c11-20020ae9e20b000000b0075cebaa1540sm1797911qkc.58.2023.07.07.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:15:48 -0700 (PDT)
Date:   Fri, 7 Jul 2023 09:15:44 -0400
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
Subject: Re: [PATCH v3 3/8] mm: userfaultfd: extract file size check out into
 a helper
Message-ID: <ZKgQAKIst4DH3lgw@x1n>
References: <20230706225037.1164380-1-axelrasmussen@google.com>
 <20230706225037.1164380-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706225037.1164380-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 06, 2023 at 03:50:31PM -0700, Axel Rasmussen wrote:
> This code is already duplicated twice, and UFFDIO_POISON will do the
> same check a third time. So, it's worth extracting into a helper to save
> repetitive lines of code.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

