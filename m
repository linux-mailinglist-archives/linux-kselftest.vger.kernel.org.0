Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83C7D4076
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjJWTvV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjJWTvU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 15:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620ACCC
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698090637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BZb3Bi9C2CsxxaJsgQZxAvcW9+sG5uBGA13Qc4GB1N8=;
        b=LbjR1RQKm06wxVwtUJDuK1UtnS6RiaP3vsyYQeiZJ7BVCxwhwAmM2Wu8DmBMOHut6m6iWD
        Gvsf80mgkhNKA8z9uMvz3gjxLBq4j7Ydd1kSY9DlVe0abHgTEcBvZATh31QO80BBLWj2dX
        iFnGA9FqNPDF5d6X9tOfDu32B+JaVHg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-HKOWsBQvMBOIY2fWCk_-eQ-1; Mon, 23 Oct 2023 15:50:35 -0400
X-MC-Unique: HKOWsBQvMBOIY2fWCk_-eQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-778a32da939so409897385a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090635; x=1698695435;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZb3Bi9C2CsxxaJsgQZxAvcW9+sG5uBGA13Qc4GB1N8=;
        b=JE29yA4Aed4szFAzs7SwENUjcaFb2jjXq8s0lHvFbebvLkKEz5CIY3a1VkgIlNp3Ao
         pxQcZvS6J8Ar2iCqwgA8why4Y9VdkTQ92aMedgSIeUPUMXmXNOyWhSgzkE/FIrsiqCD+
         hL/qUMmEQjdjj66CVTI41KiMUSLTB8NdJibq5WD1sJOaQ2iZeEHCO5wP7bRuVzw/7Poy
         HJD7CwcH8zNT/HPf9qHlLxnlfmMcq7c0Q9jPTF942TjiU8wftiwez09aaTx10L+Vf4di
         Db3M3xth0ccUOf12IujaMRhABodXYSWuAqvVB7i9bhWtzanIW3dRdtZbIYPI8QHdW/b1
         0XxA==
X-Gm-Message-State: AOJu0YzTdCGvcbQg6MxXa3ak0zOhRlheJ5zMbrreIlcQCPS1rtyRBZ9A
        X9RZ37RWTHtyFxgiP5yr0ju/WdSwNYBu65gObuh8AU1G+VYYntDF52CK7dmh8qEr9frA+B58Tfu
        xFiyGgBI1RSwIrznjgechyaM7IyVV
X-Received: by 2002:a05:620a:3189:b0:778:8fa5:41b7 with SMTP id bi9-20020a05620a318900b007788fa541b7mr10578541qkb.53.1698090635282;
        Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqdKoOkFy85HOQxGcepY4wCuviyrgecHE5HdSiaJC1NprkLTzZPHhjSkCaS/h73ih1dsisQg==
X-Received: by 2002:a05:620a:3189:b0:778:8fa5:41b7 with SMTP id bi9-20020a05620a318900b007788fa541b7mr10578524qkb.53.1698090635030;
        Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id s13-20020ae9f70d000000b007756c0853a5sm2921616qkg.58.2023.10.23.12.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:50:34 -0700 (PDT)
Date:   Mon, 23 Oct 2023 15:50:33 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: give more time to udpgro nat tests
Message-ID: <t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In some conditions, background processes in udpgro don't have enough
time to set up the sockets. When foreground processes start, this
results in the bad GRO lookup test freezing or reporting that it
received 0 gro segments.

To fix this, increase the time given to background processes to complete
the startup before foreground processes start.

This is the same issue and the same fix as posted by Adrien Therry.
Link: https://lore.kernel.org/all/20221101184809.50013-1-athierry@redhat.com/

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 tools/testing/selftests/net/udpgro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..4ccbcb2390ad 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -97,7 +97,8 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	# Hack: let bg programs complete the startup
+	sleep 0.2
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
-- 
2.41.0

