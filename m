Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500AE5F5AFB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJEU3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiJEU3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8806F80BFE
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665001752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WhHrCKV1cwvD4EM7naK+YDuH8wkC6i7kWGC/pb6hko=;
        b=Ob8AeOD3O04JKuMfa6+gvtII2znbsV01e9fC3yVcq6RFtnNYBOiEkY6u/2tCZwGEuKntX9
        D9z96IXGsx3IchLbsYkrshA/cK4CHnJOMYw90CyYJkY15Fx0STAIl61LjL4VfUPSQgJV9N
        QBjjq61RGreqDTf7beHgo/q1yBnZ9Ow=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-Cv_bG8N-MtCXvlU0-u70KA-1; Wed, 05 Oct 2022 16:29:11 -0400
X-MC-Unique: Cv_bG8N-MtCXvlU0-u70KA-1
Received: by mail-qk1-f200.google.com with SMTP id d18-20020a05620a241200b006ce80a4d74aso14996095qkn.6
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9WhHrCKV1cwvD4EM7naK+YDuH8wkC6i7kWGC/pb6hko=;
        b=hEm+wcZV5xxa3Q5jZ8/zvTh6+/WtReoFy1h4zX7/hrSLw6sjZsBb8ZzTkS8wFr6iD9
         4WLhCSuL896VAhHmOAkmKVx33S8wz8TdZOqXLooMaz7n1KuClEJ//15mdbm9yhtpBNCs
         OqcYa4T88lH7a2XxZciK/CNfyg4PPO2+O1OzR8SArsxkFKSc0D2zJYLLb97huARYxjb2
         FalpJcLbxMr608H8qevKL6Vl+GjAl6UZ09q6nyN1a/APP8dOo+gNMqYTy1NFINZ3zYCJ
         jlrVD8OcrpInaXbg14O4eNbA9Qas5p4hOiMTHbYkkjGZStwmJtdfwlVgrnfHPWnGcB45
         mYfw==
X-Gm-Message-State: ACrzQf0dwcNX1hvHdbK5A2kL2ZL4wtfyFbTrUUSYlpXVQGIAQwINwY40
        MvKr17pzTJkHobf7xDRrqgzg435ZzmySDrv9aVY5A5IaQrT4vd+kXvObB+Y1exqY3/NHJDHHgjG
        QYAM2o1jj4aaVKjgbA6773DU9/RZq
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id n15-20020a05622a11cf00b0035ba3690cc3mr1040736qtk.11.1665001750998;
        Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4X1NNPNTAB6aR9AIvBCYejjhroiFWgmpijdD0gX07m80Y4kME6G/bmuMyCb5pJutilihvZhQ==
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id n15-20020a05622a11cf00b0035ba3690cc3mr1040727qtk.11.1665001750820;
        Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u5-20020a05622a17c500b0035d0655b079sm14386325qtk.30.2022.10.05.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:29:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 2/7] mm/ksm: simplify break_ksm() to not rely on
 VM_FAULT_WRITE
Message-ID: <Yz3pFPuJrWEIHCWz@x1n>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220930141931.174362-3-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 30, 2022 at 04:19:26PM +0200, David Hildenbrand wrote:
> I don't think that we particularly care about that performance drop when
> unmerging. If it ever turns out to be an actual performance issue, we can
> think about a better alternative for FAULT_FLAG_UNSHARE -- let's just keep
> it simple for now.

It'll be nice to hear from real ksm users for sure.  But to me this makes
sense, and the patch itself looks good to me, I think that also means:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

