Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6613E76F33E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHCTHb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjHCTH2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 15:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A101C2698
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691089603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qFYzrSS5XNvQWAYfcj9a9H/bevzOTd1j3Mu4MDu2J6A=;
        b=TZmQL06vtPD7L7HrRTn9A3cdmMAouiLTBC/Dy/guVHqR4+v79TJEVNbrtyp6GCdoTaIgsK
        QnIocQptnoVOGwmLefIRWyCj+0B6QjADJjwFJy0HZdTgHiEm5sGia/sZJrQdxJGN4V5XvK
        a3/ubRWG7s7NvyQgf0XUlAS7Y/QhWZA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-cCsS9notOHe6YSBUxaxiXQ-1; Thu, 03 Aug 2023 15:06:42 -0400
X-MC-Unique: cCsS9notOHe6YSBUxaxiXQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4059b5c3dd0so3062751cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 12:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691089602; x=1691694402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFYzrSS5XNvQWAYfcj9a9H/bevzOTd1j3Mu4MDu2J6A=;
        b=i+1Pu3MCgcAV22AQmzjYCeWDVwfQ9Uv7OKbhLj/NzO0qOyjY3ELabqk3BzdWyGm2KY
         pMq8slVqdXdZJoDAzRvV963PCnFdw/QPUl3O+HN//cXo6pXCPevqEJvx5mocHmeTxSKJ
         hpXEtWAGCVzA038/RQT/7EXW0dO00Ir5XUW7wMx0PDz/xdtI95y3crQMDXc7PJRMCme0
         GXZfvlkq4IJBpCcMb8eNVHuMqpcbG809YGTuccahIcWBzd4g3E90Bey35ID3qw02ucWZ
         YeiFWcMIJxW3DMlXnVFLwxC+42A1/uenjbPp0D5M8IwIMCvVTaWTHp6F3amM4PqoOwvQ
         2vmA==
X-Gm-Message-State: ABy/qLafMBlv0Nt+8YqVT967sN1ewt29NYlfwqHVFp/09S8JETVdRRqM
        zZfJ/e3JD4NBIeM/DQU8V/mtP4i0/TNEtuMEzJOXaG4fZb+/BKPU5nPvPllaq6gFyqBXioEz9cE
        AWOISC+itxxJxe+Q45uEd4f810Wz0
X-Received: by 2002:a05:622a:1828:b0:3f6:a8e2:127b with SMTP id t40-20020a05622a182800b003f6a8e2127bmr20616711qtc.5.1691089602287;
        Thu, 03 Aug 2023 12:06:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFizsiZjzbYNwIPp/+9OLfOtrHLxCg3OVOqwnveu9rIN6TWoLqQWZIyH+9ZlPvwA+YrlWrJVw==
X-Received: by 2002:a05:622a:1828:b0:3f6:a8e2:127b with SMTP id t40-20020a05622a182800b003f6a8e2127bmr20616681qtc.5.1691089601995;
        Thu, 03 Aug 2023 12:06:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id oo13-20020a05620a530d00b007339c5114a9sm111503qkn.103.2023.08.03.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:06:41 -0700 (PDT)
Date:   Thu, 3 Aug 2023 15:06:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 7/7] selftest/mm: ksm_functional_tests: Add PROT_NONE
 test
Message-ID: <ZMv6wG7PqehMp6vT@x1n>
References: <20230803143208.383663-1-david@redhat.com>
 <20230803143208.383663-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230803143208.383663-8-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 04:32:08PM +0200, David Hildenbrand wrote:
> Let's test whether merging and unmerging in PROT_NONE areas works as
> expected.
> 
> Pass a page protection to mmap_and_merge_range(), which will trigger
> an mprotect() after writing to the pages, but before enabling merging.
> 
> Make sure that unsharing works as expected, by performing a ptrace write
> (using /proc/self/mem) and by setting MADV_UNMERGEABLE.
> 
> Note that this implicitly tests that ptrace writes in an inaccessible
> (PROT_NONE) mapping work as expected.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

[...]

> +static void test_prot_none(void)
> +{
> +	const unsigned int size = 2 * MiB;
> +	char *map;
> +	int i;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	map = mmap_and_merge_range(0x11, size, PROT_NONE, false);
> +	if (map == MAP_FAILED)
> +		goto unmap;
> +
> +	/* Store a unique value in each page on one half using ptrace */
> +	for (i = 0; i < size / 2; i += pagesize) {
> +		lseek(mem_fd, (uintptr_t) map + i, SEEK_SET);
> +		if (write(mem_fd, &i, sizeof(size)) != sizeof(size)) {

sizeof(i)?  May not matter a huge lot, though..

> +			ksft_test_result_fail("ptrace write failed\n");
> +			goto unmap;
> +		}
> +	}

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

