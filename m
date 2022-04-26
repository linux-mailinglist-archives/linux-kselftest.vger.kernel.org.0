Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D3510A8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355058AbiDZUg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355017AbiDZUgS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 16:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F07E71A863E
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651005183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJupZ9EKBhCX8US4p7GIAW6BSuQyT3fJWSWGs492ld4=;
        b=XRghbmOtv73zpJl3Ez76GQSI3MdzswbE96Ikcw+PZLeJFEW+OTQLjfX+KHoI2rI0Fng60W
        6LX0D1rVpirqE8mj920zZkkO15/n9kaze6u8pc//D8bKwF1YdyYy8rgyaFbWQWGBhIuy06
        gKWRYpQ2C1IaZ8YuZfGP1BksunWk314=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-kngpGn7QMfeNfErIagHrWg-1; Tue, 26 Apr 2022 16:33:01 -0400
X-MC-Unique: kngpGn7QMfeNfErIagHrWg-1
Received: by mail-io1-f72.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so7572iov.9
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 13:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJupZ9EKBhCX8US4p7GIAW6BSuQyT3fJWSWGs492ld4=;
        b=H0rjDpG9abu6PzXoaG+wK1p7Q62uJZnURZwSHvf8v0jxl7kT6C9VCaj+PYUL+sJ1d0
         Xgyd6W5rCPX4Ba0hUl+jtPIXvuAawggJsWdO/L9WskIuXYbaD7eurs+4+o69d4DOF7Ij
         E29wgFZ7u8jOsmAM7OBMRGnN4ce0z5yugSNsK4GmMDIRdi5zSn6EnhnxXVM27NPuLxVD
         PU1pTPsyvZoSGb0UtuEDtjGbO08Ke17aStI5X4yTKDNOTxuzgZl+BN5RKDe12twh4t3b
         92XOye4t/EB8LcuknogAA4ZkHDqLD0DGbnW0CvfSZ++15qV27QlEecnwER/cK1JYeOay
         GYWw==
X-Gm-Message-State: AOAM532WsawQT9ctBWcsYgcKpQfdhRRvJNmNiODNwVl0CXubyT670ab0
        m7R6sYo/+3dSmVN6WpqUYLo1cD+tTWDCHg4LJbi6WrIWVdhLRsqHKqoLV4m6VsGy4XtCK5t4wHh
        Q/KaGsU+XFbgtq9t7Rxhy9Oso5MvH
X-Received: by 2002:a05:6638:1487:b0:328:6e36:39e4 with SMTP id j7-20020a056638148700b003286e3639e4mr10263042jak.202.1651005181067;
        Tue, 26 Apr 2022 13:33:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv3DOWZkK6AhpbIXCeFJ2/lY2z7CXm1JNRmILCaRK5MqEyMqTOfcKl6cB6RwB1JoqOHBf6sQ==
X-Received: by 2002:a05:6638:1487:b0:328:6e36:39e4 with SMTP id j7-20020a056638148700b003286e3639e4mr10263012jak.202.1651005180758;
        Tue, 26 Apr 2022 13:33:00 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id x186-20020a6bc7c3000000b00648deae6630sm10449855iof.54.2022.04.26.13.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:33:00 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:32:58 -0400
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
Subject: Re: [PATCH v2 2/6] userfaultfd: add /dev/userfaultfd for fine
 grained access control
Message-ID: <YmhW+mOuQUWsByj4@xz-m1.local>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422212945.2227722-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Axel,

On Fri, Apr 22, 2022 at 02:29:41PM -0700, Axel Rasmussen wrote:
> @@ -65,6 +66,8 @@ struct userfaultfd_ctx {
>  	unsigned int flags;
>  	/* features requested from the userspace */
>  	unsigned int features;
> +	/* whether or not to handle kernel faults */
> +	bool handle_kernel_faults;

Could you help explain why we need this bool?  I failed to figure out
myself on the difference against "!(ctx->flags & UFFD_USER_MODE_ONLY)".

Thanks,

-- 
Peter Xu

