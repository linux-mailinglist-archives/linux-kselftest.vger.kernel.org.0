Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5851857A8E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiGSVXn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbiGSVXm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6A2160685
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658265817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1TU2R5pboSet6ITgX36x+voVt+WLRvd3J0ToQzPKr4=;
        b=eRRok27c3pXneX/YlQ26svLqnMYeSStIXMBJxrhaNUtiZ4G9t6kF4juYiGGt0O9z68AdQ5
        z4kibTclVW69MzkVWpN9NVFjjIC+RZyn5mKVsbwkPdJ1SdxTSPhdJPMcyGPkriui2kjncR
        LbC/ffJbERF7/PfbzTmBaqnj8G8MNeM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-2Z2t761XMNKmjgJmRkGQDQ-1; Tue, 19 Jul 2022 17:23:36 -0400
X-MC-Unique: 2Z2t761XMNKmjgJmRkGQDQ-1
Received: by mail-qv1-f70.google.com with SMTP id d18-20020a0cfe92000000b0047342562073so8093361qvs.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 14:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1TU2R5pboSet6ITgX36x+voVt+WLRvd3J0ToQzPKr4=;
        b=mi88uw+YHPHgPzt2OHXvuXYbTXZtBX5qKQbrHXeHtMt2daDkKFUSzzuQkjVVrvOsUy
         sotEVhaD9r3ZGAVngVf4NxqSWkYrgf8036YrOStKM8i+SEinjB5/rCudywMQR4X4wXJa
         T0oAVTHYEBu5WeLeRXMXq8RT65rTj1wFjPMrdcc+hwlvYwzGTbj5EkH49ZM3iieF8lFJ
         KrHBy4m5toNYbK4wCSJy0rX/aRHYHzMBfd73PvNPS+Dk0DdtqPA6P8DMzAQBfGHiFl1i
         lm/90nGSmfW/RL5u9UyKWnTaF/mbhTDbBh/8tR0ftGQyi9AKe74L8rZruCasUVCON+YR
         9GCg==
X-Gm-Message-State: AJIora90EppoqhiJYhqvwznjkV+mj2FB2qlbsAa4I8nggbIt5vIqT3xP
        GHE/O+En1ZkdiJlF6lBFSFyiF86Q0GhuswZQTMniu9opzSBukx0Vnnr0ITTDx7dNGNBZSZorODI
        wf7FNxTcoa/yNX4cs0Xlxo18VJ1T8
X-Received: by 2002:a05:620a:24d1:b0:6b5:920b:d322 with SMTP id m17-20020a05620a24d100b006b5920bd322mr11460285qkn.102.1658265816301;
        Tue, 19 Jul 2022 14:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQyLEwJ5TVS2RJifrC96oJqY/QforayKxBACf0fpS9TyhAhQ8kUEPoFLC/H7rZJmZjldw6Pg==
X-Received: by 2002:a05:620a:24d1:b0:6b5:920b:d322 with SMTP id m17-20020a05620a24d100b006b5920bd322mr11460267qkn.102.1658265816086;
        Tue, 19 Jul 2022 14:23:36 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id t18-20020a05620a451200b006a6b374d8bbsm1797249qkp.69.2022.07.19.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:23:35 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:23:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/5] userfaultfd: selftests: modify selftest to use
 /dev/userfaultfd
Message-ID: <Ytcg1aPwU/AdzifS@xz-m1.local>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220719195628.3415852-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 12:56:26PM -0700, Axel Rasmussen wrote:
> We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
> working into the future, so just run the test twice, using each
> interface.
> 
> Instead of always testing both userfaultfd(2) and /dev/userfaultfd,
> let the user choose which to test.
> 
> As with other test features, change the behavior based on a new
> command line flag. Introduce the idea of "test mods", which are
> generic (not specific to a test type) modifications to the behavior of
> the test. This is sort of borrowed from this RFC patch series [1], but
> simplified a bit.
> 
> The benefit is, in "typical" configurations this test is somewhat slow
> (say, 30sec or something). Testing both clearly doubles it, so it may
> not always be desirable, as users are likely to use one or the other,
> but never both, in the "real world".
> 
> [1]: https://patchwork.kernel.org/project/linux-mm/patch/20201129004548.1619714-14-namit@vmware.com/
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

