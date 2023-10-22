Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0E7D23BE
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 17:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjJVPrm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjJVPrl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 11:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F51735
        for <linux-kselftest@vger.kernel.org>; Sun, 22 Oct 2023 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697989597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGgrk7U7ziyea5cunTO+IloGn3qNk/rZsIkV0TfaQNg=;
        b=EcuK1kh/ZQPPzsx/eAaDZy6ZkM8gIso0iZA3sjvz9KpW+ajDtnV8yr6JiJ4j/l3HU9uLrM
        MFsvVIj70zP4dmmToGijT1GvKCD+usk7nLEaLtUvW7eLwbipoiDv2GEFA06Yxzde2dBtKh
        3vLETs72EuYoxK1t4lbpiOjfpRhshGg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-EtGHpv3oMzy0N6kOoka_kA-1; Sun, 22 Oct 2023 11:46:35 -0400
X-MC-Unique: EtGHpv3oMzy0N6kOoka_kA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d2fdf80beso8870796d6.0
        for <linux-kselftest@vger.kernel.org>; Sun, 22 Oct 2023 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989595; x=1698594395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGgrk7U7ziyea5cunTO+IloGn3qNk/rZsIkV0TfaQNg=;
        b=ShHTmKCCC2nfLRJS5YrcGjgr4KyzuET08reznoYoooNp71Wc/pGIK1sEyMF4pvM8fc
         ZH6IUB36WlvgmQHe48ZfIPYUb83MAv8CyAtZUAQyfmaSAZ6hJZqQvTjFyd0ZMN4zG8QS
         15N1Tou2dAT6NQKjtfGfe6XsnzwcJUaFk8qJERQe+GFttgYP/ZkA0qAFZ0R6D6yO+EUM
         oz+085YoAgLqtv4jp/QNTVKCMrLnBrEVYjWUhVjXdaU8d/dK984GfsEoUL8KzocPdsnH
         H17UT5P/5PnufDoBiRTpIxP4pM/LNm/MOZ9ZCarc0pIiqekmRpzU5XTJoCnqV3u0Ij7o
         xc2Q==
X-Gm-Message-State: AOJu0YwwUz0CKrZPJKm3qmKs+j5afSMkeHr3YhRCAbsLGZknfpwIjUxn
        EXUGlTAts9X75CntrPzJT4wVjNdtBrUOkQdHjv0sgyaWAwJyhxAK32+qrV7zTofDKmyGt//2E94
        sPZ+EcJx3sVK8W5drPV5+xIKxIuvj
X-Received: by 2002:a05:620a:2b4d:b0:773:b634:b05a with SMTP id dp13-20020a05620a2b4d00b00773b634b05amr6696807qkb.2.1697989595290;
        Sun, 22 Oct 2023 08:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWN6AC503edm3tNF4Vnyfigq1+yBTgZzdwoQzZvT6nDeUnhRhK8Btp6MrUdseV2H9geWSwow==
X-Received: by 2002:a05:620a:2b4d:b0:773:b634:b05a with SMTP id dp13-20020a05620a2b4d00b00773b634b05amr6696793qkb.2.1697989594852;
        Sun, 22 Oct 2023 08:46:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a228800b0076cdc3b5beasm2100836qkh.86.2023.10.22.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 08:46:33 -0700 (PDT)
Date:   Sun, 22 Oct 2023 11:46:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
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
Message-ID: <ZTVD18RgBfITsQC4@x1n>
References: <ZSlragGjFEw9QS1Y@x1n>
 <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n>
 <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n>
 <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n>
 <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
 <CAJuCfpHZWfjW530CvQCFx-PYNSaeQwkh-+Z6KgdfFyZHRGSEDQ@mail.gmail.com>
 <d34dfe82-3e31-4f85-8405-c582a0650688@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d34dfe82-3e31-4f85-8405-c582a0650688@redhat.com>
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

On Fri, Oct 20, 2023 at 07:16:19PM +0200, David Hildenbrand wrote:
> These are rather the vibes I'm getting from Peter. "Why rename it, could
> confuse people because the original patches are old", "Why exclude it if it
> has been included in the original patches". Not the kind of reasoning I can
> relate to when it comes to upstreaming some patches.

You can't blame anyone if you misunderstood and biased the question.

The first question is definitely valid, even until now.  You guys still
prefer to rename it, which I'm totally fine with.

The 2nd question is wrong from your interpretation.  That's not my point,
at least not starting from a few replies already.  What I was asking for is
why such page movement between mm is dangerous.  I don't think I get solid
answers even until now.

Noticing "memcg is missing" is not an argument for "cross-mm is dangerous",
it's a review comment.  Suren can address that.

You'll propose a new feature that may tag an mm is not an argument either,
if it's not merged yet.  We can also address that depending on what it is,
also on which lands earlier.

It'll be good to discuss these details even in a single-mm support.  Anyone
would like to add that can already refer to discussion in this thread.

I hope I'm clear.

-- 
Peter Xu

