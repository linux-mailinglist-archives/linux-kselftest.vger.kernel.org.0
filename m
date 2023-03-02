Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9756A7F09
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 10:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjCBJ4A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCBJza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 04:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E80B1ACEF
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Mar 2023 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677750888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jl4deYgtYQ06Ijfay6FIS+BGHtz4sq6QUOH6s3fzXLM=;
        b=dRzBmyCVfCWFKJwGIAfbVXk52s5aFDzqkIJw0kdr6S/5LWpsu0qENizIybVInV6RJgki2d
        TOhljfpc7w6zChD9UcflF3W19wqGYdF4EWKimFKXrYVe3NfGoGWvM5viObjO/qGad/AF6K
        H0UYT983mnCZim3yhKWEVTdroVjX2ic=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-65ssUX-xOnqIBejHTH6ogw-1; Thu, 02 Mar 2023 04:54:47 -0500
X-MC-Unique: 65ssUX-xOnqIBejHTH6ogw-1
Received: by mail-qt1-f197.google.com with SMTP id x4-20020ac85384000000b003bfbb485e2dso8147680qtp.22
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Mar 2023 01:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl4deYgtYQ06Ijfay6FIS+BGHtz4sq6QUOH6s3fzXLM=;
        b=I6d5MBJgAs9cWaaxMZWo2driQsJmz+dD8dj57A1Y0/3LgR02OQuM953xZg2AWJIER3
         PFuwxUpBnDxHeBvfgLgpDQtzN0aV1FhhCUfNaZ+i6zKAkBS0yvFZbaOJj6nqOI6zwh/N
         6OimwbGHOmJwzWGic+YH3cg/uiFsdizCEmlmtSVh36B4863TolxNrUvW8fCcOBucEHGm
         xcAQqIQK0XjNC31G653PPnMybYcmoRv8vEwG9FLWlkGEbYLxZKk5NNOxqjxLkMughIrf
         K3xd2scl3wnFNrWg51FGzugKWdwNh1OK0Lmg902UV06A1lVhFtbiXxja4pG2LHSwHPqF
         1j5g==
X-Gm-Message-State: AO0yUKW4KHDEXF/ttt58TRQTduay8F9F+RASDDJS5Jb11VexLzv9zdhf
        3bB3EMUPzP1FOCz4d3mQAQv+3UwXMEnb3NuapWoaDUo1yQbWAsHN9g239GYYfkkFum9oMxkqGcw
        F0HqWOJY/Rc4LqdiIP3dTBYLX+8BB
X-Received: by 2002:a05:6214:1c4f:b0:56e:ad32:2d66 with SMTP id if15-20020a0562141c4f00b0056ead322d66mr20116652qvb.10.1677750886519;
        Thu, 02 Mar 2023 01:54:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/zHXtLONQKHsTMxBoLmedRcRQY43vgPItc+r7atw2mN0yr6/437PDMUCFGDoA9aWymkxnO/g==
X-Received: by 2002:a05:6214:1c4f:b0:56e:ad32:2d66 with SMTP id if15-20020a0562141c4f00b0056ead322d66mr20116604qvb.10.1677750885976;
        Thu, 02 Mar 2023 01:54:45 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
        by smtp.gmail.com with ESMTPSA id q11-20020a37430b000000b00742a252ba06sm8395133qka.135.2023.03.02.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:54:45 -0800 (PST)
Date:   Thu, 2 Mar 2023 10:54:34 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net-next v3 3/3] selftests/bpf: add a test case for vsock
 sockmap
Message-ID: <20230302095434.opufchwk7efiw4dv@sgarzare-redhat>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
 <20230227-vsock-sockmap-upstream-v3-3-7e7f4ce623ee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230227-vsock-sockmap-upstream-v3-3-7e7f4ce623ee@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 28, 2023 at 07:04:36PM +0000, Bobby Eshleman wrote:
>Add a test case testing the redirection from connectible AF_VSOCK
>sockets to connectible AF_UNIX sockets.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> .../selftests/bpf/prog_tests/sockmap_listen.c      | 163 +++++++++++++++++++++
> 1 file changed, 163 insertions(+)

Ditto.

For the vsock part:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

