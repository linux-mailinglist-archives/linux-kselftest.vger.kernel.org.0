Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1F53B71F
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 12:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiFBKaP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiFBK36 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 06:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28E4C68330
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Jun 2022 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654165795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snHHRq9gvgH3KmNDhpwAr/uJvvmdHvD2RhbsF2j6EaQ=;
        b=RpGoR2jvaXNx32GEGzCVQS0yXQaTOaw0wRSev5sk4mY44SVz3TiZGpAP5SvhltCNzRI4yF
        MHYyrF5MlDycUIeKP2YbbW6YH7lJwr3CLGK5HWN3zMDwZGdWO3j6oRVraZEfNfIlGAMJmH
        MvTFesTdu3eW/cUCJbyi2kx46sk9Ybs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-MCkBaid7Mo-vv7gK_qqcBg-1; Thu, 02 Jun 2022 06:29:52 -0400
X-MC-Unique: MCkBaid7Mo-vv7gK_qqcBg-1
Received: by mail-qt1-f199.google.com with SMTP id w8-20020ac87e88000000b002fc7b026e66so3319827qtj.20
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jun 2022 03:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=snHHRq9gvgH3KmNDhpwAr/uJvvmdHvD2RhbsF2j6EaQ=;
        b=ifHpytYSpwaqwd/X/Qxal/cZaheJ+s8sRpt4KzYGCe+m4+qaOHN4/BwWPxzyca6lqf
         UhM9qvUohe7OJuUcdMpQbqA/dmr+JjfhNjtaA/qt/kGuKIOajXZM+FHVMjfhLKT5h5OJ
         5Gl2BdPv+9Mmiug1s5DU3Iz6ar86Tb+2qOMRSZVMSI9kNaU4s+7DWva+qy0ZriQApvQe
         Dz6Y356Iqv1MmNaj9h6kU1XRzBoTeqei7pAASYgejATktjAVElC++y+CIKSNAumVT/LF
         09Hsybzm8mTx2bxHWsaTDD75976IyxIFR8noyqojtXraDKQw2kfffzINi8/Hbp7iEEIE
         c2AQ==
X-Gm-Message-State: AOAM532/kEswFYSMTjpWOXIICTApI2zWxa/ng2yMNVtExo7RMr1qEPLB
        IVxaHfD3kEEfJVhBRxEP/k/DdrC88E1kVRjLeBZGUC9ra7sToepWFcKbsWoytYgE4hgqaNEm0St
        2EuHsdVm//r80kI2tUUM1VU0cUquj
X-Received: by 2002:a37:6290:0:b0:6a6:7d23:5eb7 with SMTP id w138-20020a376290000000b006a67d235eb7mr840494qkb.642.1654165791784;
        Thu, 02 Jun 2022 03:29:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdvLDzsn8T7wXWgdLuW/UBeiKgUTaKg8kIckdX0qrk68ukg3/B5uglLQxeT5wvy6xQscvXRA==
X-Received: by 2002:a37:6290:0:b0:6a6:7d23:5eb7 with SMTP id w138-20020a376290000000b006a67d235eb7mr840481qkb.642.1654165791538;
        Thu, 02 Jun 2022 03:29:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id u3-20020a372e03000000b006a323e60e29sm2950621qkh.135.2022.06.02.03.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:29:51 -0700 (PDT)
Message-ID: <83d04ebf876fc2be804a6351318806cd38fba20b.camel@redhat.com>
Subject: Re: [PATCH v2] selftests net: fix bpf build error
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lina Wang <lina.wang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej enczykowski <maze@google.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, rong.a.chen@intel.com,
        kernel test robot <oliver.sang@intel.com>
Date:   Thu, 02 Jun 2022 12:29:46 +0200
In-Reply-To: <20220601084840.11024-1-lina.wang@mediatek.com>
References: <20220601084840.11024-1-lina.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-06-01 at 16:48 +0800, Lina Wang wrote:
> bpf_helpers.h has been moved to tools/lib/bpf since 5.10, so add more
> including path.
> 
> Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-tests")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Lina Wang <lina.wang@mediatek.com>
> ---
>  tools/testing/selftests/net/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/bpf/Makefile b/tools/testing/selftests/net/bpf/Makefile
> index f91bf14bbee7..070251986dbe 100644
> --- a/tools/testing/selftests/net/bpf/Makefile
> +++ b/tools/testing/selftests/net/bpf/Makefile
> @@ -2,6 +2,7 @@
>  
>  CLANG ?= clang
>  CCINCLUDE += -I../../bpf
> +CCINCLUDE += -I../../../../lib
>  CCINCLUDE += -I../../../../../usr/include/
>  
>  TEST_CUSTOM_PROGS = $(OUTPUT)/bpf/nat6to4.o

With this patch applied, I still get an error while building the self-
tests:

---
cd tools/testing/selftests/
make 
#...
make[1]: Entering directory '/home/pabeni/net/tools/testing/selftests/net'
bpf/Makefile:15: warning: overriding recipe for target 'clean'
../lib.mk:136: warning: ignoring old recipe for target 'clean'
clang -O2 -target bpf -c bpf/nat6to4.c -I../../bpf -I../../../../lib -I../../../../../usr/include/ -o /home/pabeni/net/tools/testing/selftests/net/bpf/nat6to4.o
bpf/nat6to4.c:43:10: fatal error: 'bpf/bpf_helpers.h' file not found
#include <bpf/bpf_helpers.h>
         ^~~~~~~~~~~~~~~~~~~
1 error generated.
make[1]: *** [bpf/Makefile:12: /home/pabeni/net/tools/testing/selftests/net/bpf/nat6to4.o] Error 1
---

the following fix the issue here:

---
diff --git a/tools/testing/selftests/net/bpf/Makefile b/tools/testing/selftests/net/bpf/Makefile
index 070251986dbe..cff99d571408 100644
--- a/tools/testing/selftests/net/bpf/Makefile
+++ b/tools/testing/selftests/net/bpf/Makefile
@@ -2,7 +2,7 @@
 
 CLANG ?= clang
 CCINCLUDE += -I../../bpf
-CCINCLUDE += -I../../../../lib
+CCINCLUDE += -I../../../lib
 CCINCLUDE += -I../../../../../usr/include/
---

(But I still hit the "overriding recipe for target 'clean'" warnings)

Cheers,

Paolo


