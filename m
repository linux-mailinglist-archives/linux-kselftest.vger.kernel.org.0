Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25117DC109
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Oct 2023 21:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJ3UPg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Oct 2023 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJ3UPg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Oct 2023 16:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27954D3
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698696887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWGfMOu7F7kKUs5HJBbLfJGB4P8zWxfoMGodA/8nKgs=;
        b=fTVlVVAuNNv4kZD48yxnADgmhoXd7GmLrKACe5Wqj3LubLfJq+zKtX7BkQfmi3BnPVno4S
        jY5lUeV0WV81o6OggMMD/YDjc8DX/OX/N9PWIheb+xyEYI06vatK4063ZCxUxcjCHLvjv+
        DfVargXw5d8chs0dw49v8Fzcim4fLQM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-tXohxWOYPIKiCCRSYDq3jQ-1; Mon, 30 Oct 2023 16:14:46 -0400
X-MC-Unique: tXohxWOYPIKiCCRSYDq3jQ-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-79499607027so438004241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Oct 2023 13:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696885; x=1699301685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWGfMOu7F7kKUs5HJBbLfJGB4P8zWxfoMGodA/8nKgs=;
        b=LPFpPL0c+kAlOwwQN5GZHeaXN14fUzosn26jrKSaygM6EZvlsItLeszTi4rlO/O73X
         yFLXRV/sV3UWGyFXZ+sUFnsp/62r2sgqDI+swHXBnikrEI2mtuebu0d/Rp/6CFePwJSl
         3jg7y8ULGrczeLUk/1Zti6kYyQQ87Lfk7lISVxTYOlnkl1b0T8ozxWaOHxjDyFco352i
         ByyK16V9y4EqF758yTo2aLaY/HZEGviiSA69NXWu21MiB1FqsiZ+wB2iwCKaCCJW7JVx
         5mapUZdEv80qRV6KPTWI4PalpVv4W7DtxOlCLZMSTMKpVFZw/0f5VjNi9WttB7ejlYT+
         ve8w==
X-Gm-Message-State: AOJu0YyI39u4FFR8dRZh4cLALZbUxVn/hXRGOdRWb9gb15CP+QnYrzAe
        i9cj563M8yJadhxKjhXuCaF5CUttXkwXJiM6kwgEZh/Cv8/9KNJHJs5N6dBitrqk5PvVaEXhNEG
        cPVbsdnDFoMYeBpRDHEV5q2k/Plgu
X-Received: by 2002:a05:6102:914:b0:454:7a81:b30a with SMTP id x20-20020a056102091400b004547a81b30amr9263790vsh.0.1698696885454;
        Mon, 30 Oct 2023 13:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpG5KIh6bv0/spHSBWngU4H0SaI7+Bd7c85laDovrwWadeNA9ZKAwXd1Hhen8C8UCCLPNlZQ==
X-Received: by 2002:a05:6102:914:b0:454:7a81:b30a with SMTP id x20-20020a056102091400b004547a81b30amr9263776vsh.0.1698696885190;
        Mon, 30 Oct 2023 13:14:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z11-20020a0cfc0b000000b006564afc5908sm3707026qvo.111.2023.10.30.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:14:44 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:14:42 -0400
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
Subject: Re: [PATCH v4 3/5] selftests/mm: call uffd_test_ctx_clear at the end
 of the test
Message-ID: <ZUAOsn9Fj/qCo+xg@x1n>
References: <20231028003819.652322-1-surenb@google.com>
 <20231028003819.652322-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231028003819.652322-4-surenb@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 27, 2023 at 05:38:13PM -0700, Suren Baghdasaryan wrote:
> uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unmap
> areas used in the previous test run. This approach is problematic because
> while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
> which might differ from one test run to another.
> Fix this by calling uffd_test_ctx_clear() after each test is done.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

