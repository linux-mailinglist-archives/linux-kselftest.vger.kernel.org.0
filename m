Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D837E76B8FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjHAPsx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjHAPsv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 11:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A751193
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690904889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fzL/Ybnx3HfszMfs/mHvvF2PskJxWsEeOJHTJUi83hM=;
        b=HbhuYcgc3sE7riyuZxG7c91FsLndVUXBw5RyxWevwof1UhxC0jfphbtRw+OTkCTms2HpgT
        Z2zoaMukJ3HBnB3UKW+T/pRecHJPhj3n2IlZbUnAn3ujDHRWqCHAzH/4p649HKJd+zDc8A
        fj13qU4bAzh6P9ajVU4fGM6h0p+TOq4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ELTlGCsIOoawBJNJZzzHUA-1; Tue, 01 Aug 2023 11:48:08 -0400
X-MC-Unique: ELTlGCsIOoawBJNJZzzHUA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d05a56b4dso14952576d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Aug 2023 08:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690904888; x=1691509688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzL/Ybnx3HfszMfs/mHvvF2PskJxWsEeOJHTJUi83hM=;
        b=DURYjGHOM4mnblVDZTbFo2x1W4yLQysG975Od1L/gqiD3l2L23FvrMSR/wu1SsnEcA
         U28GnNVVe8vk7Q1IGbS5Lti1+hhoNohT9XRUMbl4miciAbJQIvMOzy7ksjBtW9Ytj9HO
         YGCDj5IHX+po2ClJNdrtiIj4RfAqKOKeOOkHdr0CXKb8lcGjqHUOEiikdBJON5ygf3s/
         a3o2uXG+1/9hjMGOuEv70Emrg0wkIOqO4yWSkB49/cS+XP1GXM5m4hYbquE7eHyexVaU
         63qdRtc2mw+Tlb0E0cUmF1H3wkFlUsamx84lGVWTO03mr685n3m5cO/muUDmQWMBL6bl
         3lmQ==
X-Gm-Message-State: ABy/qLYMMkiUFKJZc0FvHlxPOEuWKv20+0Tj/oVU1xJBZ806/mkF+7UH
        UCNA6QlWAaInZ38U+IPHusquT7UCyu+QHKXvpX0vob+/55DX7A4kIcAKO3GjhoPgkV0nC1pzcyZ
        bU0wUUCjmhJTDMUUZLTcZTR2SQnlH
X-Received: by 2002:a05:6214:f6d:b0:63d:2a0b:3f83 with SMTP id iy13-20020a0562140f6d00b0063d2a0b3f83mr13483330qvb.6.1690904887773;
        Tue, 01 Aug 2023 08:48:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkIpicp2puvI5rez9Bp+zxcAl/7L3rx/USJUT9iEBbnLJ3LmasmjZqlKMQch/r6bJKu79nfw==
X-Received: by 2002:a05:6214:f6d:b0:63d:2a0b:3f83 with SMTP id iy13-20020a0562140f6d00b0063d2a0b3f83mr13483311qvb.6.1690904887526;
        Tue, 01 Aug 2023 08:48:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h16-20020a0cf410000000b0063d119034a3sm4695385qvl.94.2023.08.01.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 08:48:07 -0700 (PDT)
Date:   Tue, 1 Aug 2023 11:48:03 -0400
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
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/8] mm/gup: reintroduce FOLL_NUMA as
 FOLL_HONOR_NUMA_FAULT
Message-ID: <ZMkpM95vdc9wgs9T@x1n>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-2-david@redhat.com>
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

On Tue, Aug 01, 2023 at 02:48:37PM +0200, David Hildenbrand wrote:
> @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>  		gup_flags |= FOLL_UNLOCKABLE;
>  	}
>  
> +	/*
> +	 * For now, always trigger NUMA hinting faults. Some GUP users like
> +	 * KVM really require it to benefit from autonuma.
> +	 */
> +	gup_flags |= FOLL_HONOR_NUMA_FAULT;

Since at it, do we want to not set it for FOLL_REMOTE, which still sounds
like a good thing to have?

Other than that, looks good here.

Side note: when I was looking at the flags again just to check the
interactions over numa balancing, I found FOLL_NOFAULT and I highly suspect
that's not needed, instead it just wants to use follow_page[_mask]() with
some proper gup flags passed over.. but that's off topic.

Thanks,

-- 
Peter Xu

