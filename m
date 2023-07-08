Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772D674BE06
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGHPDY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGHPDX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A0F170C
        for <linux-kselftest@vger.kernel.org>; Sat,  8 Jul 2023 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688828558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T3GRnokqrPVaYV/THcdBGlJffY7BDH+AcPJHejmPSVM=;
        b=EW6f7q22MmwmnwnihEuHIiSXi55qBR6ytRxMtQBoPZ5/WvLQemW5UIzXI7vvsYfI4NgKSG
        jY0nAJvcWuIFnnGh+at/V0hohdjPBYPnjJYNRQRAy1D3yoQz8fANwJ3Kc6nDzMXSTPy21K
        0vO1Dd7rbUj0VTZm1vzDUvwL7779iz8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-dTth7qCGP1GcbgPOFooWmA-1; Sat, 08 Jul 2023 11:02:36 -0400
X-MC-Unique: dTth7qCGP1GcbgPOFooWmA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-401e1fc831fso6075211cf.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Jul 2023 08:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688828556; x=1691420556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3GRnokqrPVaYV/THcdBGlJffY7BDH+AcPJHejmPSVM=;
        b=lz4ihuUNpUnTE8zLCMpZ7QW2TYNOJ54QdmMQK9t8MD3qX5G0oBakSQ3o4gyYvOjfaA
         6/zzjbuX7HHz1mkfg8s7CcRmJj3P1sFRUsg2iOypme9YUhfN/9RhRoEqVV7a7HOmZt8H
         0CrSs68Ctrc09eTGfMI10ZuxY4eFbQfHQKnaSJvZZjWHv5jsobUBuC/ejMbChqtPQiDb
         se6sLgVxPXeIYdlVRk1jlww3g6rALSLHHCCIvtqKgwAukBNxMhc2Z6n3UTa+N4X5UOpW
         fOufSXJAPDnt27lxUnk8yYHoD9A6DifqRqhWC2P3eF8JKZRgJX+THsRrmMXnHFIwRtgV
         5Gcg==
X-Gm-Message-State: ABy/qLZDAA/pWOlf/viYAlEjxkEoo/bTDRcmRVsFliQ08o812ONo9P56
        vspiMsBlJNXbH9RHM9wNizhBGC+J5ydBK4suagURAoElNbb43f5ljaFx4nQKh9JmM+kEFHlGzhm
        tu1bN57teEIxaZX2vd79XhjjK/nrr
X-Received: by 2002:a05:6214:b65:b0:634:cdae:9941 with SMTP id ey5-20020a0562140b6500b00634cdae9941mr8767592qvb.0.1688828556019;
        Sat, 08 Jul 2023 08:02:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGj53IzcQAPmiI/v43Lyk7eh+euAZZXrSV8HTK/l4O/V2y1GtOUmoqfRyODcRL3zSDwxMPZhQ==
X-Received: by 2002:a05:6214:b65:b0:634:cdae:9941 with SMTP id ey5-20020a0562140b6500b00634cdae9941mr8767568qvb.0.1688828555801;
        Sat, 08 Jul 2023 08:02:35 -0700 (PDT)
Received: from xz-m1.local (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i4-20020a0cf484000000b0063013c621fasm3417890qvm.68.2023.07.08.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 08:02:35 -0700 (PDT)
Date:   Sat, 8 Jul 2023 11:02:33 -0400
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
Subject: Re: [PATCH v4 7/8] selftests/mm: refactor uffd_poll_thread to allow
 custom fault handlers
Message-ID: <ZKl6ie4s/94TPCgm@xz-m1.local>
References: <20230707215540.2324998-1-axelrasmussen@google.com>
 <20230707215540.2324998-8-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707215540.2324998-8-axelrasmussen@google.com>
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

On Fri, Jul 07, 2023 at 02:55:39PM -0700, Axel Rasmussen wrote:
> Previously, we had "one fault handler to rule them all", which used
> several branches to deal with all of the scenarios required by all of
> the various tests.
> 
> In upcoming patches, I plan to add a new test, which has its own
> slightly different fault handling logic. Instead of continuing to add
> cruft to the existing fault handler, let's allow tests to define custom
> ones, separate from other tests.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

PS: please remember to update manpage after it lands.  I still have a plan
to update but not yet happening; if you happen to update before mine please
feel free to update for whatever is missing.

Thanks!

-- 
Peter Xu

