Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8996708ABE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 23:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjERVvu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjERVvt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 17:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87257E6E
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684446661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PTxJzjUCnDeLKGxq08Q4RltGGG7TNyuXuOM81PDsCQ=;
        b=ehJ6/tQpER+6utwgWlzS7qx0XKYsMLHum2jfb6OCoi2KcVdz08yS0GXVhN1uFElpFf27gY
        FXDuJovjQrSjK+oo41jcyuwcFEu9isSFOiJ+qEnV8KHEqbkw9eYtb9WY4UoIVKq/H+MI93
        NpnsoDkFT893j4dWAvbYeUYV6LczMDA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-eGga8p9mNqy8HMHYzhWPeQ-1; Thu, 18 May 2023 17:51:00 -0400
X-MC-Unique: eGga8p9mNqy8HMHYzhWPeQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-757e1673827so19798885a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 14:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684446660; x=1687038660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PTxJzjUCnDeLKGxq08Q4RltGGG7TNyuXuOM81PDsCQ=;
        b=C4jwMIYqa38psrNTSDaeA+fA8WCX50kswksnV77eGl85HIlgWnJNjli1cpeyCWIfaA
         8QIHyR6WD1D83TbxrHnLnXMLbeVc3n3G3BqnUVu+RZABgOGn6jRMSbl/8V8Zah1vu8qU
         b5NKltItt0exnahOI9dYyFgTWs6Wv/ayRCG+r7dfkZ4csuyQN98hBl5kg7G+MSEdyv6C
         y6r/m3AhdtR2Db+whjhf9zBrnixrU5nurCV+cS7gYappGNGD7sLkg+X69f8JMQEFLTSD
         jasrVUfNkUJfmxVCe2+w+eV1vcN5Jlgv09n5pFMX0vkA40svrNFqy+zeEBEJDhi0G8RX
         I2cQ==
X-Gm-Message-State: AC+VfDyq/rUXXbFsfZhi23Dl8kKk467CJBiiYPKQkf+jVt0Bxm/HPxrp
        IJfdoH+wXKGq80sMfw0gvbMGAmz7E/U25Ka8laZB8TSAfezJ7C6aMRkHE1SPfGeiBbgZKJrwHJf
        +vBemXwiBWkSS7ANNdamjYONNcFpA
X-Received: by 2002:a05:6214:519a:b0:621:7d4:e05b with SMTP id kl26-20020a056214519a00b0062107d4e05bmr1024266qvb.0.1684446659898;
        Thu, 18 May 2023 14:50:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hwLLJfjckQ3qXnTQ5Jvs59iaTcg3CL+DRiXVyjoA2RxvwVhuDUKynLqHROugZ/mgJauTrRA==
X-Received: by 2002:a05:6214:519a:b0:621:7d4:e05b with SMTP id kl26-20020a056214519a00b0062107d4e05bmr1024242qvb.0.1684446659694;
        Thu, 18 May 2023 14:50:59 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id c30-20020a0ca9de000000b0061f7cf8207asm818958qvb.133.2023.05.18.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:50:58 -0700 (PDT)
Date:   Thu, 18 May 2023 17:50:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <ZGadwEDlsvIxnsvq@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n>
 <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n>
 <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
 <ZGaaxjS4jWUio+f6@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGaaxjS4jWUio+f6@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 18, 2023 at 05:38:14PM -0400, Peter Xu wrote:
> If with uffd, perhaps avoid calling it sigbus? As we have FEATURE_SIGBUS
> and I'm afraid it'll cause confusion.  UFFDIO_HWPOISON may sound more
> suitable?

Or UFFDIO_POISON (to identify it from real hw poisons)..

-- 
Peter Xu

