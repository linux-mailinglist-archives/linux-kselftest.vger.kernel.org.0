Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763616A7EED
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 10:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCBJy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 04:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCBJyk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 04:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE001ACF3
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Mar 2023 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677750838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAanRdQ6lew74x0O2AW3iUiZVFolX1emAfL8FQaMI/4=;
        b=gzdALdWRMqb33PVvMB16FhKgqS4hEYbt8grKWAckL6CvyLN6dpP6UYdSCIaxhIJ+nlzrF1
        xOY65khD392eWjv2syXp32y83CKeH2NgJuLN1LquoXNXmYvcvKMCenM172bo6dtywgvacF
        uCYCO6rWYNHFckmr0E1jVmOtjTGx9XY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-WdkA6ZquMGWx1ii1y6kUIw-1; Thu, 02 Mar 2023 04:53:57 -0500
X-MC-Unique: WdkA6ZquMGWx1ii1y6kUIw-1
Received: by mail-qv1-f69.google.com with SMTP id x18-20020ad44592000000b00571bb7cdc42so8558143qvu.23
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Mar 2023 01:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAanRdQ6lew74x0O2AW3iUiZVFolX1emAfL8FQaMI/4=;
        b=0xBaf0oM1ZEeUQGA566XR3srUdBTVorpChqQp9Xm9zrGRS1TZNks2haVOGy4nZfpGs
         dn3rhVqK6k6+yy+yqdLe+VXa3tetUKpodThhbF44xmIOqjMOlUHbG0mVnVaMe1TucGaM
         nsjmMIUxusShr+8tafnnEAT33R1UsD2nJIq6hXXXQ/3nuXxmt9OFycYkOU1SjY3LJYc6
         FUdzNxNnxvmu2SMZeXH3WEHmIf/eO7QjyNONm3sCW6Ys3Uxm08Ypok8KDcXbZRcBqJhM
         SpBpcpu88XsVumR7SR8VY+zYalUGrvmdqHMgO6/++0RXAm8ISIxus8WofTu6onoOPr6n
         lEFQ==
X-Gm-Message-State: AO0yUKX7jvxzy0AoFtZfjxh2zYeh4lfVHv0TB3hzk+AnNqxem/Ci/AKM
        sdcE8utGleXo3Ql9A9cKQM4kWxL8Ksy0rqqFPocuPwRJl2p9eaZtDc7Qpw9DKBMt+q2WgYrtA89
        BYSRRERllhOnt0AEu1JLzDOtG0UOk
X-Received: by 2002:ac8:7c4e:0:b0:3bf:c431:ea6e with SMTP id o14-20020ac87c4e000000b003bfc431ea6emr16382387qtv.3.1677750837180;
        Thu, 02 Mar 2023 01:53:57 -0800 (PST)
X-Google-Smtp-Source: AK7set+D27uSWXYnYHncolI/Nj6QVQLpZyQycFGgRCQpd47EnoDoYamAUXMK1mc3+TkNw/RjY6KEew==
X-Received: by 2002:ac8:7c4e:0:b0:3bf:c431:ea6e with SMTP id o14-20020ac87c4e000000b003bfc431ea6emr16382365qtv.3.1677750836940;
        Thu, 02 Mar 2023 01:53:56 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
        by smtp.gmail.com with ESMTPSA id x7-20020ac87007000000b003c00573aaffsm676414qtm.3.2023.03.02.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:53:56 -0800 (PST)
Date:   Thu, 2 Mar 2023 10:53:46 +0100
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
Subject: Re: [PATCH net-next v3 2/3] selftests/bpf: add vsock to vmtest.sh
Message-ID: <20230302095346.rbu6s3os4kz2bnbr@sgarzare-redhat>
References: <20230227-vsock-sockmap-upstream-v3-0-7e7f4ce623ee@bytedance.com>
 <20230227-vsock-sockmap-upstream-v3-2-7e7f4ce623ee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230227-vsock-sockmap-upstream-v3-2-7e7f4ce623ee@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 28, 2023 at 07:04:35PM +0000, Bobby Eshleman wrote:
>Add vsock loopback to the test kernel.
>
>This allows sockmap for vsock to be tested.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> tools/testing/selftests/bpf/config.aarch64 | 2 ++
> tools/testing/selftests/bpf/config.s390x   | 3 +++
> tools/testing/selftests/bpf/config.x86_64  | 3 +++
> 3 files changed, 8 insertions(+)

I already acked this in the v2, please bring them between versions if 
there are no changes.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

