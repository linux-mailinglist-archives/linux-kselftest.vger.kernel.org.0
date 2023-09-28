Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153F27B2251
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjI1Q3s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjI1Q3p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 12:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293BC195
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695918537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ECSWxP1j3hBeSXdb6ywnnqSDGaz+yV4RHCz9Ky2uV1g=;
        b=O8XIyGMm9Jjfr7Vj7Y/tB6UNwG3Xg6XqfsfU9TAeXWQpM1bWUsmRbECPjRnS/fPyrRVd54
        hqURe8TWA+cZzCnOy8X5NVI1R+i+vvUAh+4iqBDoFjsFFSOKtlBzdgJLkoQtgku3or60Y2
        sZOQbtzfjzzyOhf5sVwrUpNMR1yhOFg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-OM2Prv7UMjm7iuRMCxUlUA-1; Thu, 28 Sep 2023 12:28:55 -0400
X-MC-Unique: OM2Prv7UMjm7iuRMCxUlUA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4197468d5caso1345481cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 09:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918535; x=1696523335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECSWxP1j3hBeSXdb6ywnnqSDGaz+yV4RHCz9Ky2uV1g=;
        b=umLnvBVsHUZmAQjzfxMaxAv80VB5i9X+en5M9m+OwIQd3cTvyzdHjuYMQk3D1/aGSi
         Fk/9qUcDV3UihJcK+1Xm6kOPuNbvwmVftrhK7SBQwEwBnUPgDycwhPrL96DBHxPZWuLu
         Hnss9qYL0oJFbWKec5vvctmyYuapndYVofxmgp0Aous5NoeaVBpxrnnUqStthLrQcQqS
         vXorqlTGVnJDEHy0J6Fg9E565g9LRvQb9z/hggB+83nsfbJHeUhDjOdN9HDd7nIvKfhd
         CgwWMC1CJDsxh0M/xBDcGKU+2Ph+kqRewbCjIZq5aN7PNBtiJ/MdT07/O5XP8pSIN34h
         dv8w==
X-Gm-Message-State: AOJu0YwQwVk58bdkjfu6wKur+Axfk/nXpBeOeHSa7pj+/5VAUJq0Gy75
        v5U25KcGtG6GQYrtz0onEuY+n0F2W4McXJw70s0S9hQtyLkDvgDWPp9Rj0vi3mpiBnApnmpyQwr
        n6YtmhVUiG8lbLc9MaQ5eISrxw/fR
X-Received: by 2002:a05:6214:d0e:b0:656:2e07:94cc with SMTP id 14-20020a0562140d0e00b006562e0794ccmr1636566qvh.6.1695918535400;
        Thu, 28 Sep 2023 09:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtkg8v2zJ+pSdlCquE/dXcGepO9QnmIZxHxXDH8RhAtWvwQG4zc9TlS+nwMnPka2OAQ6cV8Q==
X-Received: by 2002:a05:6214:d0e:b0:656:2e07:94cc with SMTP id 14-20020a0562140d0e00b006562e0794ccmr1636536qvh.6.1695918535071;
        Thu, 28 Sep 2023 09:28:55 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id n17-20020a0ce491000000b0065af657de01sm4900886qvl.115.2023.09.28.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 09:28:54 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:28:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRWpwx1N3ucnrrFE@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
 <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 27, 2023 at 11:25:22AM -0700, Suren Baghdasaryan wrote:
> For uffd_remap can_change_pte_writable() would fail it VM_WRITE is not
> set, but we want remapping to work for RO memory as well.

Is there an use case that we want remap to work on RO?

The thing is, either removing a page or installing a new one with valid
content imply VM_WRITE to me on either side..

Thanks,

-- 
Peter Xu

