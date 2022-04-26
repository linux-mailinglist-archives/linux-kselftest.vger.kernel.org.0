Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81BA510A90
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355022AbiDZUgz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 16:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355006AbiDZUg2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 16:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B07041AB8E5
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651005194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Av2XJWYSmxJiVQjp5kZR1hfhT+pdVskMA4VQgdFQOaM=;
        b=VDjbHVNq0DBR4YUbjdkw3QJstcZDy4ZrK1SN9wei0Ms8iMg0UJQkGN6mDMSky5U3akhRA4
        dfZhPxSqFGyBW72NSbPUH7MvmLAB9SOPO+lfzJW3KHH+GGs6eeY1mZFc5APkruaAwH8i3B
        sf7ayuKh/KCosyG5GzviSVphugFzhos=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-ukUKwlcGNeWRiQUYKzmj8Q-1; Tue, 26 Apr 2022 16:33:12 -0400
X-MC-Unique: ukUKwlcGNeWRiQUYKzmj8Q-1
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso15301395ioo.13
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 13:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Av2XJWYSmxJiVQjp5kZR1hfhT+pdVskMA4VQgdFQOaM=;
        b=Cc9tjagwXmvYvccLKHOk/zKG6Ki/0Bnv+7Y5ZPKS4el9oAsE38in6OXUEgVxrjWJ6w
         DwH3I2XWJZ/2wHqvqFWaVq9XcpIDqhmTJtkhD73z2GZYss7ohBhMIrGGnvdQSULWoteg
         /XBC7ZcV0efcC4kBQq8MKj5mkyH+MXXXgsxYV/HnQjZeOEehsUhcUNvjFNS5npI8HDUa
         tKYN54te5xo6IYDbU7/u/mqAuMtp7poGQOvVjgvKvuOAltz5ZSdg2aPSAywAjRDXJeyE
         gGNTOSaHnUHjxXnP9gTH1U94gO56SWJzcQbldVi//bD8PF5MK30QqT+QywNrJ+T6iDcM
         H6aw==
X-Gm-Message-State: AOAM532AhFGP0yBAilbW6QUgUKLY+09mUP6hTbkkV2ATf7PtTK/QjT0P
        vV/HWLYIMCM7p9SUtziStzUa7LlzlagH9I8swzbonnA32K5e3BMBZ4TPRPt6/dqwENCNONs0NSm
        4xJJ4m2aIB6Wp8ycEVaF/5G27GpAR
X-Received: by 2002:a05:6638:272c:b0:32a:f95b:fc77 with SMTP id m44-20020a056638272c00b0032af95bfc77mr4011888jav.179.1651005191546;
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd4CFNten6nl0jATzOU1yCBTY6Y58j8Espgob7sbvIFYcRfIXeg+IqFoDNsZPO7cKZaJ3nww==
X-Received: by 2002:a05:6638:272c:b0:32a:f95b:fc77 with SMTP id m44-20020a056638272c00b0032af95bfc77mr4011865jav.179.1651005191365;
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id e18-20020a92d752000000b002cd6dae980fsm8497051ilq.13.2022.04.26.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:33:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:33:08 -0400
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/6] selftests: vm: add hugetlb_shared userfaultfd
 test to run_vmtests.sh
Message-ID: <YmhXBHFrXKT/Jqkd@xz-m1.local>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422212945.2227722-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 22, 2022 at 02:29:40PM -0700, Axel Rasmussen wrote:
> This not being included was just a simple oversight. There are certain
> features (like minor fault support) which are only enabled on shared
> mappings, so without including hugetlb_shared we actually lose a
> significant amount of test coverage.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

