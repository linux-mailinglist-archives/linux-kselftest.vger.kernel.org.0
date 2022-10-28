Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2678F6106C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 02:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiJ1A0O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 20:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ1A0N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 20:26:13 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053898CAE
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1666916768;
        bh=suBHY5qlkVC2FazI0mEXno4TRJYxkCCmk1jWJMwKEnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CfvDxVBRRzuxsMIilKXp8zPGasD46y1UBDikt880+AACxPu9VcH6GE1vdTXzNJU2W
         4YV8vPCGpFUcAz327qgTlriI3pZZ75koc5Cp14ZLRwahIAhSdb3sDBWuHSHyJ1uf83
         UmWcRu1BBNrPnezvg+wdMWYJePp4Z9E5K/tue0Is=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 683932A9; Fri, 28 Oct 2022 08:26:03 +0800
X-QQ-mid: xmsmtpt1666916763tf0jfoxmb
Message-ID: <tencent_CD22930180507496CE65B30ACBABC4681506@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtSl1818EcLCSNRBDbUY51bDHj+Me+Ax7xqLMJLM8ZcEXnXlBD3E
         MKb/Tcv+w8xlbRGaBgdLZcrIm/+CnzBD+3LtMUbw5l7anlZoZmDARjqMBWdJccZVa9trNESDQEhM
         QBi0Q1xjkUSKbflCyU3hD7hdCrVlr1cOvIXsRb0CNB8C1TKS79CZf1jTbiUgWVOCy26rErIviPKy
         XevaDkKXbXh5QrTI+nfXO0iIm4avyIqrShBFkcb7spmuWOlFWOMRcXY06d/gHpZIcodCQcQ9VjS3
         SzxG9gqCHpMJ/VOD3MtmBCpJbKRmqo2YRSOfAK4O8QmQfzX3d2YltPhFpwU/8a+PZnWX1k+s0uoE
         VIUPRDLuID1VUPvx9eoAHiaNBQUyjLQlERssJkDLPT+nVVF8upYUPboyAVfs9CTuZUCHitoT8mMb
         0hMgT5a7o6Bpf4r2MgOyk1/MGGIBrvGSnpDpguyrt/OE8x9kt4QRQ0edbggArYwZT47Qjp1W3lg5
         eF5mo0rbwB35Y/YT8nRNCZQ+C19SluFtt6ZTJRo1TFPvAb2tGBGIxC8lpGnPUQUYh7N54n/VW7dk
         JRMvgD02whXbLZSjB9iFG09oP38+VTOeFOxpy8f0K2fkWtIw6s02rU+XpLAFQ0iQBxJHFsE7w6dT
         Z/KZPBFatyo9EbedYihVOhxF9jLGY6tMmIQE6y4pur+D2jcQZoBeVPbTEJGiPpOuvFx3M1LQ1Y3F
         8YCFwdqg6hyJoXjHXdfn1wGI4vixu29Pw8QErftHlOg0s7Zo/BTx5tkMwy8Zbj+j8mGyzeAewnXV
         qKPkprYJ5mD5bLxhzoFHMQcj3V/hbTQQ0O71aVf8lzfHglOwU2M976FrKMm21eE9VFafMByVSnLh
         GsbdoJmkGNrEAwm/0CyD4ygEZktmoQhBC8W5AGHVJfKasnR1vJ266qBub1L7p5Nea/HRi2XSHE9Y
         vshE/icZgvj1mfZuvIQ7THcJwRBrEW19hKZ9TZd8KOZlwwMVUnKg==
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: Re: Re: [PATCH] selftests/bpf: Fix strncpy() fortify warning
Date:   Fri, 28 Oct 2022 08:26:03 +0800
X-OQ-MSGID: <20221028002603.97776-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4Bzbq0PSsc6xCGSF=Af-pcysjt8Lv76-4N65AJMpXOOpOcg@mail.gmail.com>
References: <CAEf4Bzbq0PSsc6xCGSF=Af-pcysjt8Lv76-4N65AJMpXOOpOcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Thanks for your reply, `enable[0] = '\0';` at the beginning and then
strncat() still has the same compile warning

--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -77,7 +77,8 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
                enable[len] = 0;
                close(fd);
        } else {
-               strncpy(enable, controllers, sizeof(enable));
+               enable[0] = '\0';
+               strncat(enable, controllers, sizeof(enable));
        }

In function ‘__enable_controllers’:
tools/testing/selftests/bpf/cgroup_helpers.c:81:17: warning: ‘strncat’ specified bound 4097 equals destination size [-Wstringop-truncation]
   81 |                 strncat(enable, controllers, sizeof(enable));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/testing/selftests/bpf/cgroup_helpers.c:81:17: warning: ‘strncat’ specified bound 4097 equals destination size [-Wstringop-overflow=]

So, i think just add '-1' for strncpy() is a good way.
