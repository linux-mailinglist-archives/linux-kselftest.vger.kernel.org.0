Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CAA7D02D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 21:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbjJSTxz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 15:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346552AbjJSTxy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 15:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D311B
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697745186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsesIdim+wPTdU/RUNRWHqvYIZjYuIVW1UPJdK5PEjw=;
        b=ApaHmtJyWDw1D5347fQGBa9gzklaq/xGwATU82Chm6SL8qs3pWzPcJlBcN2fxkK1qfzSw+
        M6g6QvuwSwInbLXcvT+2UbRlZtcWn4eTYzl60HH1LLdo/TGZLL0uxNs6lZCpatE9L2H2YT
        zdKsdlR0aEcf/Vhr4UavNKe+4rJFKHw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-AWOuth6yMCiIN5k5OT0InQ-1; Thu, 19 Oct 2023 15:53:04 -0400
X-MC-Unique: AWOuth6yMCiIN5k5OT0InQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-775842dc945so913885a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 12:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745183; x=1698349983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsesIdim+wPTdU/RUNRWHqvYIZjYuIVW1UPJdK5PEjw=;
        b=G6Nq4g4XXBTx0HDpzk+rAj1pRFTxKDTKu8bQr9Xy3zRjHogq2a2u8nvWMAAwWy0zLW
         qAd56w3Dv2MGd1Bv/QdPHSECw8aOw5csdYpU3C4dT9+Mk/apWjpaxmDnEtPRnzJxw/bf
         uznWEc1LoGh7asfZxqRHAKzNBy2O9G7gTNR6npP1/kZHYe+OqDKot5LCNuDFMU7Y0Aiy
         e2lnrgXJyLgs/9eOlGmf+lVPkGW1yz9upfxfsUsymTHkkNY4mPIrsBAkbnSOVVlNUGlC
         oYR3smugaUjETfpxN7mcM+1qFuxdNONnWU7JwZV3KKvoMZqDq0SJZi09WY+RIq7RpMJG
         4KkA==
X-Gm-Message-State: AOJu0YxD7QkDuKNBXBIru9g0+AGVtLXElWJz3sGdG625BUnuuR+MHJyW
        26VTp7UwhyiL8pnxUcK17uj+Po4Q1+YzL6e6ny/xPgB3Xsn34JZEHOrLJFRwdkbCd1VKH7ELEtY
        geR8c30FwCgOso7+w3moQJ9jTKcOL
X-Received: by 2002:a05:620a:1a87:b0:778:96e8:90af with SMTP id bl7-20020a05620a1a8700b0077896e890afmr3341446qkb.5.1697745183633;
        Thu, 19 Oct 2023 12:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6lM3hjpOvbZ85Uma0UlRsQCBxfq3qPNAwSumdJHciqDnKFJqXdgnennQ8IWt6btGoUMNwrQ==
X-Received: by 2002:a05:620a:1a87:b0:778:96e8:90af with SMTP id bl7-20020a05620a1a8700b0077896e890afmr3341429qkb.5.1697745183351;
        Thu, 19 Oct 2023 12:53:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a070200b0077413b342e9sm53812qkc.128.2023.10.19.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:53:03 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:53:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZTGJHesvkV84c+l6@x1n>
References: <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n>
 <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n>
 <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 05:41:01PM +0200, David Hildenbrand wrote:
> That's not my main point. It can easily become a maintenance burden without
> any real use cases yet that we are willing to support.

That's why I requested a few times that we can discuss the complexity of
cross-mm support already here, and I'm all ears if I missed something on
the "maintenance burden" part..

I started by listing what I think might be different, and we can easily
speedup single-mm with things like "if (ctx->mm != mm)" checks with
e.g. memcg, just like what this patch already did with pgtable depositions.

We keep saying "maintenance burden" but we refuse to discuss what is that..

I'll leave that to Suren and Lokesh to decide.  For me the worst case is
one more flag which might be confusing, which is not the end of the world..
Suren, you may need to work more thoroughly to remove cross-mm implications
if so, just like when renaming REMAP to MOVE.

Thanks,

-- 
Peter Xu

