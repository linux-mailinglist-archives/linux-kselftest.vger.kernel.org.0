Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC5E4DC5F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 13:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiCQMq3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 08:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiCQMq3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 08:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 053821042A5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647521111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Qqa/Ov513ThnEsEWFPNgQG8r30QerKlezRS4gXg/kpo=;
        b=a9Rys1RoTMR4F7CzWIbA/vk60wq4ez97PWiF4m9nKiKHN30ubXLYdjch+4Ikxx+HyOjQuw
        USFg03h1tmdBDdrGPeVZgFld6Y++mE3qed56CnJidewfAej+lPk6kegNWGo9boZfwgDMBa
        enpzi1kXQ98cVn/LDVDEGVH10kmZ46I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-CbIK_B7LN-WHzmZnCctgOQ-1; Thu, 17 Mar 2022 08:45:09 -0400
X-MC-Unique: CbIK_B7LN-WHzmZnCctgOQ-1
Received: by mail-wr1-f72.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so1516353wri.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Mar 2022 05:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Qqa/Ov513ThnEsEWFPNgQG8r30QerKlezRS4gXg/kpo=;
        b=aj+EpSME2dvSaQzjX6YxJZCqHlEMcP7j8kX+LTyUeWUa60r/Lg40CiKJefR6bRyHVD
         a95TNCKY6ZcCJU39irIWDyup1YKSm5sRXfzrqjAlxnFJO0ukvun7N6d8XqU66gt79MH3
         xIxcdA6KVuyH2Zap8a9wqJyZoL129mKN8dZMWTTbs368Ukq6/eDt9u3zUyfbaDZkbFmP
         cIDs2kTMSXk08Mxq0hOG3z3jQP9V95FTD/lpRw92q8qc+ovNZ6/QQt1AT7+6OXO5uDDe
         MC64gF32SvKvklI+DsWYIGJ5tMHVYrC/S4T72utMHU2igGkFpGQXYa8f8cvxu8k806Ra
         8RrQ==
X-Gm-Message-State: AOAM532H/U4N8FY5jn42vEi8iHxI8o+aP8p4+Mv1AcxyUPGAbqQMtPwO
        qpcCY6TI9ayTAGfQokd/Yjoa90lNSo4j1Mu+iL9cqy0VAC5Vk4baRsjagt0k9bZ5wv2m2f8TKjs
        iNSLxrjRPtrt50bg3MkMuHs/3TxCf
X-Received: by 2002:a5d:66c5:0:b0:1f1:d7e3:7068 with SMTP id k5-20020a5d66c5000000b001f1d7e37068mr3831194wrw.410.1647521107887;
        Thu, 17 Mar 2022 05:45:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQUEz9vTD/tN2vTIWpyB+hSq9ZgG3GpogtOJn/Hz4HV5q/2amMBXTc2kBHynEiyLTPZY+MFA==
X-Received: by 2002:a5d:66c5:0:b0:1f1:d7e3:7068 with SMTP id k5-20020a5d66c5000000b001f1d7e37068mr3831183wrw.410.1647521107691;
        Thu, 17 Mar 2022 05:45:07 -0700 (PDT)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm6947761wmv.31.2022.03.17.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:45:07 -0700 (PDT)
Date:   Thu, 17 Mar 2022 13:45:05 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/2] ipv4: Handle TOS and scope properly for ICMP
 redirects and PMTU updates
Message-ID: <cover.1647519748.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ICMPv4 PMTU and redirect handlers didn't properly initialise the
struct flowi4 they used for route lookups:

  * ECN bits sometimes weren't cleared from ->flowi4_tos.
  * The RTO_ONLINK flag wasn't taken into account for ->flowi4_scope.

In some special cases, this resulted in ICMP redirects and PMTU updates
not being taken into account because fib_lookup() couldn't retrieve the
correct route.

Changes since v1:
  * Fix 'Fixes' tag in patch 1 (David Ahern).
  * Add kernel seltest (David Ahern).

Guillaume Nault (2):
  ipv4: Fix route lookups when handling ICMP redirects and PMTU updates
  selftest: net: Test IPv4 PMTU exceptions with DSCP and ECN

 net/ipv4/route.c                    |  18 +++-
 tools/testing/selftests/net/pmtu.sh | 141 +++++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 8 deletions(-)

-- 
2.21.3

