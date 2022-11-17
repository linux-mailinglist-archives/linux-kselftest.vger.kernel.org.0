Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF762DDB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiKQOQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 09:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiKQOQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 09:16:07 -0500
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94811324;
        Thu, 17 Nov 2022 06:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668694558;
        bh=dG0QO9gWakQJU/P1I5Ahj/BVHfSZJ+0OC0RjDt31OLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tVoD92ZGc9tYqxKKDcoxuCSkK8bhR7E3oJqR78lZJSlI/13jloGKZffp3veUBDzsD
         9QoMyiFn2oSLYn1vlufVB2MkGPZI+9aJBE+NKznhHKipCcEfPzKfHZQ70mxied24iW
         jX2Rx9KYp4Whlchsg5jiCnLNy1uMe2EKxUcQLn6A=
Received: from localhost.localdomain ([111.199.191.46])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 3F529210; Thu, 17 Nov 2022 22:15:53 +0800
X-QQ-mid: xmsmtpt1668694553tgzfqsri8
Message-ID: <tencent_0316F265A5CADBEBFCA811E28E019A106806@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwscxIOyFD5IxKefeV3GpcDqPgG1RMRvStWcIKtetjnUspjSvW8E
         5H1Rxh+S+OjSsaiFLMqGLkFtkPA2iFXdGKq0Nl9z6KsC/6jSzgc6HW7cd305PTC7pbuyEK2xST8I
         AKx3gqR/VZAQ1zqZ6E+J8VH6P3lRftRmYy7dtH+Aalw+5obiG7xWyPmbTfasDBpd1A0xRBiEKe4/
         TkaoAWDzdL0uRycmxY0TY18lP+I6d7GKKeUz8cSD0O0UQY9lP+oJTnetqp1ZUkrqBe8VpTqkyFne
         o9YrM6GlLkCT/k10GgUdQPWP9DZvuHQhEzj3d72YErB3nLBvVSJH85IT3x5O6bs5D5ME7uWqO3Ni
         dN2pNhNyjlcbkkEM+db9OUKI+oNu4ePOyPPLg0XA10D69ZJCc98/tHbw5HwjojYTh3yYzIAXtoal
         AIV5ipGoq24f9bUsh/p9uxPm3QDIWoWCJVDORns4X09irkTQgbfs19NdqrMVvr+OIKcfALLPyXM4
         WL2/ewHQW4fA8szGbwmClyLjqE6yFTaDGVFhvTAkoR6DBU8zrZGMNMzegL6lyoF2Y6+2e7DChapK
         eMjKrWYfTxoAlaV6M8gOUqhA4SbPb9IiK/vxZA2uZXhsk6iLGZ8CL1HmeKMGONpUA6Lu2y9eDt6J
         YAdmOmKkhqDLUf8qe+ku8uqJRja6zd/svgZ7d8QQxGwctW2JcQQGMqdzQHuGYECqoIGhXwE/iq6u
         1v1nQ4/UNLNjXHZryuMVG/CsvjjRvszQxiDRpVGamaaHFA0CUc2yt83df0EWZX3WpIrzRn1MOFC5
         39nC3sM6k/tF78jZ2K3X9uvmpvBZsJUtJmiEuyaGTggxMykEhp3inA/zm7ObOiIhcptQVKfFPyk3
         qAmE5uADrFdLnho0S1GGzTxOqApSfLu+6p7sBLD2EZh7pfIq7sVvxOilVpaGLL0CFRYTpKz772sg
         ZBy0eD8PLL+iEcUQ3CtAHI89sP1+vyrciqdTsKHGosw4m9r/D21A7z1LMmza1Tr0rkMa6UaGTZfW
         EoAsBRvaEkjrft+20CtMP98X6EYHo=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, dxu@dxuuu.xyz, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lkp@intel.com, lorenzo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yhs@fb.com
Subject: Re: Re: [PATCH bpf-next] selftests/bpf: Fix error undeclared identifier 'NF_NAT_MANIP_SRC'
Date:   Thu, 17 Nov 2022 22:15:52 +0800
X-OQ-MSGID: <20221117141552.17353-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzY0dsog-_1v9Phskt2YzyavL_fNsSi2hUvGZboggDqM2w@mail.gmail.com>
References: <CAEf4BzY0dsog-_1v9Phskt2YzyavL_fNsSi2hUvGZboggDqM2w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

First of all, thank you all for your suggestions on this compilation
issue.

> It does break CI ([0]). We could use BPF CO-RE and ___suffix rule to
> avoid this. But we can also say that selftests/bpf/config{,<arch>} has
> to be used by bots that want to build BPF selftests.
>
>  [0] https://github.com/kernel-patches/bpf/actions/runs/3446651033/jobs/5752592868

I try to use bpf_core_enum_value_exists() and bpf_core_enum_value(), However, 
as far as my knowledge is concerned, I have to redefine a NF_NAT_MANIP_SRC 
enumeration, but this would conflict with the situation where there is no 
secondary compilation problem. How do I fix this with CO-RE, it seems that 
there is no similar CO-RE+ __suffix solution for enumerations in selftests. 
Can you give me some tips or help me?



