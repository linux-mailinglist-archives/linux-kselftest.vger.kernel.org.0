Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A5674BDFC
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGHPBh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjGHPBa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F1170F
        for <linux-kselftest@vger.kernel.org>; Sat,  8 Jul 2023 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688828443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vo+xktwiVBdnYZNSkVaZ1jBQzqcsS/NnXCqSzqSIy/s=;
        b=BbqeYdLP1JwSGDVXcyeT8FjIPFD/H/5WWbz5nEhl5RF6/ApR0jqBp6Y4g5vjFugT+UfMSu
        kQUONUlivpD457kWkNEzv12zEJFKkA1qL1RJsKIfkusBV4bPv22hqmXG/mSmBUt2HWRBe5
        vQakVt/su68/+Is7wnltkOE3SrQ/5Eo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-VQfB27bhNLStK88nCTz1dg-1; Sat, 08 Jul 2023 11:00:42 -0400
X-MC-Unique: VQfB27bhNLStK88nCTz1dg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635e2618aaeso5973156d6.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Jul 2023 08:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688828441; x=1691420441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo+xktwiVBdnYZNSkVaZ1jBQzqcsS/NnXCqSzqSIy/s=;
        b=Rce83SI4sq4S/dPUMRe5TEqK18SpvXp8TwuOmPHsKbU/UMXLKCKWFaqSz/tPcukPPa
         nNFi0Rv1m6BSFZQCu4ouCH1VEWWjsaWTC8GGrJNe573Rilz/CoIQZdakK6Mi/KFf9+uR
         t4HGLAes1a7B00fA0JVpxQtLnIFOGykXg41IG84n8prEVwstChA7MqT6TGAWFZ4tSg/g
         TQuqAZpNAOV84lH5LKSLHiHQ13PoGUI/kzXLh+7ghgMZEns3W6gdc14/mHfNanGAIZdS
         ZhJmW6+7VQgTr5g99B1Rz2s7OKPPAVxtTW2ODKCjgFp6QlJT5TrtTK8Nr3zrfbaQQqwG
         7eyw==
X-Gm-Message-State: ABy/qLZSRbRgcH93j8cButL4szAmmUBmFHgMHoFVa/Hdcl5OGGebfi/0
        SjhVd531eszAuCUnwrYCSzuOMCHTSYdvwSEJu+rBQLL59sF3KzO7GATP6x1spzVDDowjnQisc5O
        khZJcmJfNY3YIJgSh/NaUD9jCYNEE
X-Received: by 2002:a05:6214:20cc:b0:635:da19:a67f with SMTP id 12-20020a05621420cc00b00635da19a67fmr8751527qve.1.1688828441400;
        Sat, 08 Jul 2023 08:00:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkX6m7GxhH9s94whBzq2AYzdzEBV2j5KQt1+Wi1Rfa+0O1g5J2LP1pKpldyxPAC+GVDL2kcA==
X-Received: by 2002:a05:6214:20cc:b0:635:da19:a67f with SMTP id 12-20020a05621420cc00b00635da19a67fmr8751500qve.1.1688828441141;
        Sat, 08 Jul 2023 08:00:41 -0700 (PDT)
Received: from xz-m1.local (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id e12-20020a0caa4c000000b0063627a022b0sm3467336qvb.49.2023.07.08.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 08:00:40 -0700 (PDT)
Date:   Sat, 8 Jul 2023 11:00:38 -0400
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
Subject: Re: [PATCH v4 1/8] mm: make PTE_MARKER_SWAPIN_ERROR more general
Message-ID: <ZKl6Fhxv6ruwGzpA@xz-m1.local>
References: <20230707215540.2324998-1-axelrasmussen@google.com>
 <20230707215540.2324998-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707215540.2324998-2-axelrasmussen@google.com>
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

On Fri, Jul 07, 2023 at 02:55:33PM -0700, Axel Rasmussen wrote:
> -static inline swp_entry_t make_swapin_error_entry(void)
> +static inline swp_entry_t make_poisoned_swp_entry(void)
>  {
> -	return make_pte_marker_entry(PTE_MARKER_SWAPIN_ERROR);
> +	return make_pte_marker_entry(PTE_MARKER_POISONED);
>  }
>  
> -static inline int is_swapin_error_entry(swp_entry_t entry)
> +static inline int is_poisoned_swp_entry(swp_entry_t entry)
>  {
>  	return is_pte_marker_entry(entry) &&
> -	    (pte_marker_get(entry) & PTE_MARKER_SWAPIN_ERROR);
> +	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
>  }

These two can be slightly confusing when put together with hwpoison
entries, so maybe it'll be good to somehow attach a "marker" inside the
names:

  make_poisoned_marker_entry()
  is_pointed_marker_entry()

(the old helpers didn't attach a "marker" keyword because we started with
 consuming a swp entry type, I think)

But we can still identify easily with "hw" prefix being there or not, so
it's still pretty clear at least to me.  I'd say not worth a repost, so
your call to keep or change, just in case a new version for other reasons.
All fine here now:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

