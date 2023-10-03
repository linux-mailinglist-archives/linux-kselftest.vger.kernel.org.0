Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33807B7271
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbjJCUWo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJCUWo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 16:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB5C9E
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Oct 2023 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696364518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lGz/zPDmfUe9p/qsYHyjDH/ju5fxgNmRfXXQH4ZGRfQ=;
        b=EkqQjfpldRC2BCBcTJ68LVuX0Bw8ZlVOyjDEjK89zT+YSpYKau35htluhoqcWWrXy5nhXp
        ymLmB6hjXkuBIYggXk71vGdpoLqaLFWX6i6LJ53Znq/CzSL3rhu2+iZdpf8lMGmaHw4g/T
        t9Tnr/WOX324Hp30r9GCUork8OmdiOw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ZFOCi-g7PmmxP6Mtb4QxAg-1; Tue, 03 Oct 2023 16:21:46 -0400
X-MC-Unique: ZFOCi-g7PmmxP6Mtb4QxAg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7756d0fb11dso36721485a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Oct 2023 13:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696364505; x=1696969305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGz/zPDmfUe9p/qsYHyjDH/ju5fxgNmRfXXQH4ZGRfQ=;
        b=nwD3SB8ubH5JwjAbmbg7jqNm01dSbM/ZfUprt5U4AJII9C3TgyyEoMIrv3jvGSsTiH
         FRvD2jjITk18cXgUGw+u1Mcr3v2QKIiv9aZ64wQ+UKrgl/9zz25zLV8XjwnLB+J3EgUw
         6xCw2w385k3Th9s2qq41/cUQqEWc/LKJzVgnQWJTdlJU9r7sJfZO1benQPhHn7t+EX3C
         nf65CkiUpx6Gu7gQXRZHNyCT7gu4UUQnDQ0PJNWy48/XbWPQYbWhAtewfiUF0wwb735u
         Cg00dxWi4mrI0opKeG3he7xA31H7m8FLvhEdBz8XjQI04iqVRutVrS7VlnzuP1qBmX5Z
         2LIw==
X-Gm-Message-State: AOJu0YwAR4fvx/hFms+/6HVo93Vys9vKUmzclYSumlDnOmjO5HqARVJA
        KnBK8Le+Fdtzq80tDRwkJ8HHD4jFGR/RJMTH+MF70dOr8Zhe6OKPSvrznCCzDNxESpug785mi6x
        vgNV+EsaJ+ACOn3HyJ9bcZMwEwmb9
X-Received: by 2002:a05:620a:1914:b0:773:b634:b05a with SMTP id bj20-20020a05620a191400b00773b634b05amr664290qkb.2.1696364505549;
        Tue, 03 Oct 2023 13:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1us9YsAy4zroBwMwR+GwfiHfM87maalEVWo8Ggo0EdogasY6gSCuj6gjLUHCv5mmQk23vSg==
X-Received: by 2002:a05:620a:1914:b0:773:b634:b05a with SMTP id bj20-20020a05620a191400b00773b634b05amr664260qkb.2.1696364505180;
        Tue, 03 Oct 2023 13:21:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id w13-20020ae9e50d000000b0077407e3d68asm729062qkf.111.2023.10.03.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 13:21:44 -0700 (PDT)
Date:   Tue, 3 Oct 2023 16:21:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZRx31TKFDGRatoC8@x1n>
References: <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com>
 <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
 <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
 <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
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

On Tue, Oct 03, 2023 at 01:04:44PM -0700, Suren Baghdasaryan wrote:
> Ok, I think it makes sense to implement the strict remap logic but in
> a way that we can easily add copy fallback if that's needed in the
> future. So, I'll change UFFDIO_REMAP to UFFDIO_MOVE and will return
> some unique error, like EBUSY when the page is not PAE. If we need to
> add a copy fallback in the future, we will add a
> UFFDIO_MOVE_MODE_ALLOW_COPY flag and will implement the copy
> mechanism. Does that sound good?

For the clear failing approach, sounds all good here.

For the name, no strong opinion, but is there any strong one over MOVE?
MOVE is a fine name, however considering UFFDIO_REMAP's long history.. I
tend to prefer keeping it called as REMAP - it still sounds sane, and
anyone who knows REMAP will know this is exactly that.

Thanks,

-- 
Peter Xu

