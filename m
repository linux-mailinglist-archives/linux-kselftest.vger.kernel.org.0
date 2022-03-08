Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB44D2411
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbiCHWQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 17:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350570AbiCHWQA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79E9854BE3
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 14:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646777702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jsagWIcYjBlb0odjn78vqSEkzAg0cbRigaFdUE2Hpig=;
        b=Oyp3E45L2FkP222D3fo1+vqmMLXNoUJ1K2QUIGo4VU5SO3aeh9TVildDqU9yyocMaAoP1s
        Nye9DodaQaEDPYis+sggno2nHxH+24V2zmIhx7/Zz7ULcWyWhxUmFtztMV47bAV4bEVdvc
        yLhbtf5D9lOo5rArOP4f1gbP2KVXLcY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-K2tWc35QMUW68o_OrqaABA-1; Tue, 08 Mar 2022 17:15:00 -0500
X-MC-Unique: K2tWc35QMUW68o_OrqaABA-1
Received: by mail-wr1-f71.google.com with SMTP id e6-20020a5d4e86000000b001f045d4a962so20966wru.21
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 14:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jsagWIcYjBlb0odjn78vqSEkzAg0cbRigaFdUE2Hpig=;
        b=M2IyGGhqIws/GX9WmlMWrv9NesHOUl1lBMl38/gJ6QDeLyynI8yCc2XblSqhJjiv8Y
         AHRa1cQv2OD3Dgkbb7cePzAFq1TikD6MPKyefLyvs7bnSLw9b+P6L1IiORDaPv6P3KB0
         /j0/qByejpC1nqG02sPd0lmwaC0JqCuMYcEsiKcPMvusX0EVOu1dXeKSm/oEFzIwxP7a
         h9CRwBYTdeF7Mo2S9OJp0CfKKBOX1OsgQH40L8y++HWdRXLy05PrcG/797rnBPp/+7IZ
         GCKTvKQ39+Jg9OnQGDA5Eq0jSRBk+hye90178vDYmQv+EeX4VaM8URCI0qNuDlLjcCyy
         3F1A==
X-Gm-Message-State: AOAM530G05I5OC4Jw9JeOXGiaUUK7e6diwQCr3TDrIOuo6Cl/Vrioqmo
        QSI6EnuhdCQdW3jZmxkenjVZ0oKdPDMtYy9IYPvtuE5WNuRKABqZI6Kid+6L/tpnbI3qOLwgBXH
        oX/k+C30Aa/kxKc5WStwtZjakWO8X
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id w3-20020a05600018c300b001e582d3e4e2mr13645281wrq.575.1646777699809;
        Tue, 08 Mar 2022 14:14:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDow23AB2HL6l37bLT+PO/3s00Fj0O0u0HhfOmL8nM5trxzYGuVjDazcaoLLM0rqwFvkfvOQ==
X-Received: by 2002:a05:6000:18c3:b0:1e5:82d3:e4e2 with SMTP id w3-20020a05600018c300b001e582d3e4e2mr13645270wrq.575.1646777699575;
        Tue, 08 Mar 2022 14:14:59 -0800 (PST)
Received: from debian.home (2a01cb058d3818005c1e4a7b0f47339f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d38:1800:5c1e:4a7b:f47:339f])
        by smtp.gmail.com with ESMTPSA id k10-20020adfe3ca000000b001f0329ba94csm139504wrm.18.2022.03.08.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:14:59 -0800 (PST)
Date:   Tue, 8 Mar 2022 23:14:57 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Vadim Fedorenko <vfedorenko@novek.ru>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/2] selftests: pmtu.sh: Fix cleanup of processes
 launched in subshell.
Message-ID: <cover.1646776561.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Depending on the options used, pmtu.sh may launch tcpdump and nettest
processes in the background. However it fails to clean them up after
the tests complete.

Patch 1 allows the cleanup() function to read the list of PIDs launched
by the tests.
Patch 2 fixes the way the nettest PIDs are retrieved.

v2:
  * Use tcpdump's immediate mode to capture packets even in short lived
    tests.
  * Add patch 2 to fix the nettest_pids list.

Guillaume Nault (2):
  selftests: pmtu.sh: Kill tcpdump processes launched by subshell.
  selftests: pmtu.sh: Kill nettest processes launched in subshell.

 tools/testing/selftests/net/pmtu.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
2.21.3

