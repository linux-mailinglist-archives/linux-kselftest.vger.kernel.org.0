Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFB67DC14D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 21:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjJ3UgX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJ3UgX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 16:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85406F7
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698698132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQqQywcIq3pleqCdkmZJnvq+aD96AGHUCBNW1Pk+bxA=;
        b=jTv9qTE735qA/8NkivTkXNfj9jrlyyHF3nHgMfpY7CH1Z7iNfO2q2+Wtd/ynKrow2dk+2N
        aCcPWe8cPolgNfpo4HQLRoZnd+P+1t7Fst7bCEVXh7Q0jr6y0lhFgvCkgxY3qtCBRkUL+n
        AvkdwlfjYgn1zBp7uzYQHKo5tytyGFE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-cnmk7J5GPX2S0eH3F-0cWQ-1; Mon, 30 Oct 2023 16:35:31 -0400
X-MC-Unique: cnmk7J5GPX2S0eH3F-0cWQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-637948b24bdso15294356d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 13:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698698131; x=1699302931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQqQywcIq3pleqCdkmZJnvq+aD96AGHUCBNW1Pk+bxA=;
        b=T5s0CS4dTVgXEmjocSQegh05d57moFz9OCLnY6zOPq7BqJPm/AzxyfRqJi1eE4/FEj
         bX9d9yCdXfmLDPcENFYtjPwiB9aVWT3mJZSfCBqyH5Nsv8msee+KX0gQSWvVZHazaAhW
         qrShCkM0pVGiMgR4WaJsCo6GZKaLRDQoUZfnXREDPFpVKYtTVlljQ9yCMPB7TfIVo52C
         VSZEnDkoYhQINAeVN47jL7PuXcFiRJMsmWl1mG7r5o++6t9gVkbeIjU7unEdO01glrdS
         cAf+Ni4C0Zo5PIQiwxpccFvgjgm+pvgp5JKPjGXDS62rR1GiDcJs/uVaJ0I3px5tuw4j
         9Jdw==
X-Gm-Message-State: AOJu0YzaI+mEPsEFqZSy6bSim1aVlM7+6wrDy2cmDmcKipptD96ehewp
        N5S0PgJKcvFYyz/rmqNhQu3F8sIic9nBcxvLXyqVN414QVIsy/ry3hrcz1x6RKt9JCKOw9mDxUP
        MPvAo/tA6uusdFb7A/duirIVcDiy4
X-Received: by 2002:a0c:f78c:0:b0:66d:6111:5c5c with SMTP id s12-20020a0cf78c000000b0066d61115c5cmr11465040qvn.3.1698698130991;
        Mon, 30 Oct 2023 13:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoHYJYrlsiTilKNNDCIy4gwl3kNblk99zpaZUZAXSFQUfkN4dW93Dg1VUo6nUBxJv7RxuZhg==
X-Received: by 2002:a0c:f78c:0:b0:66d:6111:5c5c with SMTP id s12-20020a0cf78c000000b0066d61115c5cmr11465017qvn.3.1698698130723;
        Mon, 30 Oct 2023 13:35:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id cx15-20020a056214188f00b0066cfadfb796sm2362777qvb.107.2023.10.30.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:35:30 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:35:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <ZUATjxr2i7zVfL8I@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-6-surenb@google.com>
 <ZUAOpmVO3LMmge3S@x1n>
 <CAJuCfpEbrWVxfuqRxCrxB482-b=uUnZw2-gqmjxENBUqhCQb8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpEbrWVxfuqRxCrxB482-b=uUnZw2-gqmjxENBUqhCQb8A@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 30, 2023 at 01:22:02PM -0700, Suren Baghdasaryan wrote:
> > > +static int adjust_page_size(void)
> > > +{
> > > +     page_size = default_huge_page_size();
> >
> > This is hacky too, currently page_size is the real page_size backing the
> > memory.
> >
> > To make thp test simple, maybe just add one more test to MOVE a large chunk
> > to replace the thp test, which may contain a few thps?  It also doesn't
> > need to be fault based.
> 
> Sorry, I didn't get your suggestion. Could you please clarify? Which
> thp test are you referring to?

The new "move-pmd" test.

I meant maybe it makes sense to have one separate MOVE test for when one
ioctl(MOVE) covers a large range which can cover some thps.  Then that will
trigger thp paths.  Assuming the fault paths are already covered in the
generic "move" test.

Thanks,

-- 
Peter Xu

