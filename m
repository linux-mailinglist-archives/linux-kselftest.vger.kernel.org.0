Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E854BAD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiFNTno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 15:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346818AbiFNTnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 15:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A682A421
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655235819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0kBJ9jVSmrZsPatTagpukwacW+JAMXi3G+ttyb9CVmA=;
        b=Sk7LCxwaEEpe1GKCm2Y7ECHAmlVI2iQMS7TvJuKo27xcvBgoz7MCBueOA8j4dt7ps5Q/Ua
        /4lyx+TdveASNpeV8Q9cC4WeXJxZRtyjwXEYY1lmIvLVcqsf6HZZFogZdGasYya1oCUL/y
        UrbLdcj9mZEA6NJWSDe688dMIqUFgdg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-rB1VENXeMbaJ1t5JdIaRGw-1; Tue, 14 Jun 2022 15:43:38 -0400
X-MC-Unique: rB1VENXeMbaJ1t5JdIaRGw-1
Received: by mail-il1-f200.google.com with SMTP id k15-20020a056e021a8f00b002d79963e53fso6082944ilv.14
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 12:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0kBJ9jVSmrZsPatTagpukwacW+JAMXi3G+ttyb9CVmA=;
        b=uoaTjdxXEJRfDeIv1OakxCIVWXUM0/72n11UKwiWP3YY4P6wZMC7ZD6wiy04TaLSl4
         cWNdOPeVtOzHGm+S1GtTNLDmzXwJuxdHY9H9ZWtp9vs6SvjI+Z0vqtj3wOQQJZMnExa5
         u4oJ66fbSosHaTnzsyJJ8aZz7KWrrt10iP+XKvSenNc6ghibnzosl0gvVf9k1XOA0pnT
         76B54GfJ7wjh+YCMyxCv2ggzNgUpdjVa6v7W8RlVBQDwZ8+AL6nSzsBUWRFGEakd77VF
         6G3ti5GYtc+RcFWU+ZAEVrceMbE6MJ87nOR1nPOgwe8Tpykpep0T8Fc10F0eDoDV29KH
         LMRQ==
X-Gm-Message-State: AOAM533o0UOMQL8RU3VQlkl9vNqAlIt6ZukRuKID2R0X9W6EJoo4PUuS
        bOvK6Akf+Ix6BdJB2I+lsYYJ+LIbAQwBoVVtFOt9IxZggoACuuDJNZPXaXRMpRxGiJ4nwl1hEE1
        42mzp7t+fqlQU3tsJoB1Onws9aKVL
X-Received: by 2002:a05:6638:2711:b0:332:1030:d6c2 with SMTP id m17-20020a056638271100b003321030d6c2mr3742567jav.263.1655235818123;
        Tue, 14 Jun 2022 12:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyka9HjOgMy6b8pnRt/A/embx73zjB9YhZLRYD1IRFIZfVzSN4bJjcwuFQgiPhot6lgYqIMuA==
X-Received: by 2002:a05:6638:2711:b0:332:1030:d6c2 with SMTP id m17-20020a056638271100b003321030d6c2mr3742560jav.263.1655235817943;
        Tue, 14 Jun 2022 12:43:37 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y11-20020a02904b000000b0032e6f0d3796sm5225276jaf.145.2022.06.14.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:43:37 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:43:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 6/6] selftests: vm: add /dev/userfaultfd test cases to
 run_vmtests.sh
Message-ID: <Yqjk5qEvNk9l72P3@xz-m1.local>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601210951.3916598-7-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 01, 2022 at 02:09:51PM -0700, Axel Rasmussen wrote:
> This new mode was recently added to the userfaultfd selftest. We want to
> exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
> test cases to the script.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

