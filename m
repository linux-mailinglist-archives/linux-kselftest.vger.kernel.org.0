Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA26657A8EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiGSVXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbiGSVXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2647861B32
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658265825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5XmcYFINzq7Zfp1ZH6JYE8dP3xg797dDa/g7sWMt+4=;
        b=curO7x0TQaPJsTinsezrxVzv8ZBPcAGzAGvXa4mxPkHQsJufkQ6vy9GLrKXk9S3THFwMzL
        oqrD0iI5Pr0LuFjmBQVq/Ashuol58w2lSr2SNNRdrJJ6IAFFeuRBKYDScKfadm7+R0Gxwb
        q9QvZ7ApRfPm6munrrB845UWnd4cVMY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-p9pl7NjwOOuTullYc3pKiA-1; Tue, 19 Jul 2022 17:23:44 -0400
X-MC-Unique: p9pl7NjwOOuTullYc3pKiA-1
Received: by mail-qv1-f72.google.com with SMTP id lb15-20020a056214318f00b00473726845c8so8076229qvb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 14:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5XmcYFINzq7Zfp1ZH6JYE8dP3xg797dDa/g7sWMt+4=;
        b=2dRP6+7wg5wmfF5mV0a8BIYBt4AW0m1ok9B60+DYmGJGXucDp76OLwny8AEzJyaKgj
         QxtXLrTVW/AfxOEV28SzodB8wzrAlDDaWxya1VO1GBYw5D2KMvUAm2emFX38vvnupfPo
         b+pBmzRg90gq/38tenNKYdXGRM5+JeL7jHhNXQjGz5fopAcXz8uTYvWREq286ZoxrR5V
         kVAFp8uj8p3h9c874v+lPjdF466edNUp9j4WI+ypZsrCAI/qqBONlvnGr0NkNlxm3oUN
         c/Co4ZnlwnDoMKbdSAThTB8F3H1okVZL+M1UV0tajVPDqXUuFBCyYqFO63RhmgtkBzv2
         xR1g==
X-Gm-Message-State: AJIora/zBPIR8umYIfZbycVE2LXK8rL6ss/SxovP8jKVqXedDmShhoLK
        63ktV4aKl40rfdi0Bn2NEtbSv1Lj334vKwnIFVM9yHpW2u4EoPCqTXDPurajp8X2OLzW4m7Un7t
        XtJfW2SHA1Kq4EB+kCIrgMQldOVN0
X-Received: by 2002:a05:6214:761:b0:472:f5f3:5139 with SMTP id f1-20020a056214076100b00472f5f35139mr26406592qvz.48.1658265824309;
        Tue, 19 Jul 2022 14:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uD5oB/LS6Ijqi8ckx7ZKbBD1V1rO23/Qvo6+97DahMzdhsOQVRGFH0eTyNrHtcanbtwn2H7A==
X-Received: by 2002:a05:6214:761:b0:472:f5f3:5139 with SMTP id f1-20020a056214076100b00472f5f35139mr26406569qvz.48.1658265824116;
        Tue, 19 Jul 2022 14:23:44 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a0bc500b006b555509398sm15545231qki.136.2022.07.19.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:23:43 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:23:41 -0400
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
Subject: Re: [PATCH v4 4/5] userfaultfd: update documentation to describe
 /dev/userfaultfd
Message-ID: <Ytcg3Q5lcJcajpPI@xz-m1.local>
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220719195628.3415852-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 12:56:27PM -0700, Axel Rasmussen wrote:
> Explain the different ways to create a new userfaultfd, and how access
> control works for each way.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

