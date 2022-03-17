Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC474DC9CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiCQPYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCQPYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 11:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 077E81FE563
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647530577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K36YRnlSJZ5rMbZiePbXroyvMxX7L2yn2TNzdvxrJ7I=;
        b=gkVT2gEPDRC7B2SudCNMKuUmNNpwvp8uUQG7E7SAXxXvnfzVMhIkUfkw56bGfbaZarkF46
        I/TYlfray0eLXpN/oXHvcq6dAsPyJoAKmKWjVu/jH4PLPe68QbeK641EBIMBh81ZuSQDcf
        gYfLPjVobZvzvj3lh8wYnv5Sq0QYYvY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-hEG0BKbqOde_3LrclGQm7w-1; Thu, 17 Mar 2022 11:22:56 -0400
X-MC-Unique: hEG0BKbqOde_3LrclGQm7w-1
Received: by mail-qk1-f199.google.com with SMTP id bs8-20020a05620a470800b0067e383077adso1261147qkb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 08:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K36YRnlSJZ5rMbZiePbXroyvMxX7L2yn2TNzdvxrJ7I=;
        b=WlMw0JhTyAS93MqB3ZYShqKQQnd+3uxphskOPBnVfYNh6aPrG0wdQ83KIML10tTsjZ
         V1NPyRqsqcFUBnIVcKp7pWm9dgakdJ+/4i4hC8pDYL5VPAcLFFZnW4AhCCC4TcO2rBdN
         /ookKQhfFFLwOoV3ggVYcB85VWdNGQV6USwrEJ+MqeFxqqzlRCmOAdMJ9pORo+QNjOZT
         cYrzvdj3otN3IWpzgDC2NlSF8nMovUu+oFCL64No1b+MshTuTFvuq1VTublukefb6XCx
         1cW9pnjYJLyveGu9ra7YtSOQoWFCjvNpHQQp/e0gWvRizGPmA645J2purBG+g0EBZuBU
         ncKA==
X-Gm-Message-State: AOAM530/bQrppxPpEbDl2iGP5HjddHDT/RdBETN1aH0Ce82l4Efcpdo/
        KLPeF9GM4mLlrfuPgB7Hfl/hZG3/pLj2C511Q1g6Q1HdTImi1Ut6zKpqSBGWgifD/w4uav0di1A
        k+1ztASxZ2NI7QJzgpU9aZYijEkfl
X-Received: by 2002:a05:620a:2183:b0:67d:3a8a:feb3 with SMTP id g3-20020a05620a218300b0067d3a8afeb3mr3220723qka.338.1647530575443;
        Thu, 17 Mar 2022 08:22:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySgB7580L9bJischTixsEjZHREdy/Z4zNRtDq/mWkSSiZeJ3tDYbe1QLBGcnswbTlkso/faw==
X-Received: by 2002:a05:620a:2183:b0:67d:3a8a:feb3 with SMTP id g3-20020a05620a218300b0067d3a8afeb3mr3220702qka.338.1647530575165;
        Thu, 17 Mar 2022 08:22:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002e1e038a8fdsm3718173qta.13.2022.03.17.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:22:54 -0700 (PDT)
Message-ID: <86189872c47b8b94fd7da12c3443ad2af3240b56.camel@redhat.com>
Subject: Re: [PATCH] selftests: net: fix array_size.cocci warning
From:   Paolo Abeni <pabeni@redhat.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
Date:   Thu, 17 Mar 2022 16:22:50 +0100
In-Reply-To: <20220316092858.9398-1-guozhengkui@vivo.com>
References: <20220316092858.9398-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-03-16 at 17:28 +0800, Guo Zhengkui wrote:
> Fix array_size.cocci warning in tools/testing/selftests/net.
> 
> Use `ARRAY_SIZE(arr)` instead of forms like `sizeof(arr)/sizeof(arr[0])`.
> 
> It has been tested with gcc (Debian 8.3.0-6) 8.3.0.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

This landed to net-next. Next time please specify a target tree in the
patch subj, thanks!

Paolo

