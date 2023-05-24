Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6870FE5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjEXTQw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXTQv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 15:16:51 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3A12F;
        Wed, 24 May 2023 12:16:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E38276019E;
        Wed, 24 May 2023 21:16:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684955806; bh=yLzaJ3BZwmUfDHcCkUlzajM4xei2/G1Dqqs+yKtQYnw=;
        h=From:To:Cc:Subject:Date:From;
        b=FwExTAdritu5OMXZ1qimA82muaBvAAZZP9XBYSiUddU0pu0CSSAIeiku1fL1gF1y3
         8EK/gCCmyEga+zgVCB2NfEgYdD64pQDj59fti+yQBcsDDYQLU8nQEglkyaQnbSzcUB
         ALVYZpu9C7Vo6WTt+2w3JEtwox0IcKUhmk9HkARI4u7JB161oEorrGKgAw2kq+YNc5
         O3Z8JwiY8ZQ7TAcxQk1ciBtRiUqn1Vjj2mcXeeW6ddyQk08RwQJRL/4jE1VgeD/aQB
         6u9Cu0Np+gUO0Xt+ua81WcpoY3xdu0SqTmKbI3ekVyqYPYGZhPjaKPEi6UIOdHlEiz
         WFePpPOkjoy4Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GjDZ7k-lC9gp; Wed, 24 May 2023 21:16:44 +0200 (CEST)
Received: from defiant.. (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 4223F601A1;
        Wed, 24 May 2023 21:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1684955804; bh=yLzaJ3BZwmUfDHcCkUlzajM4xei2/G1Dqqs+yKtQYnw=;
        h=From:To:Cc:Subject:Date:From;
        b=u7TmgFJs2EolMF9HnPBHEVBeNWJMWTMs5t+225/p8LX5Dt/IADJxHsgO4k6VH5Tn/
         OS+4VGrPeIma2C3Mj+3T4iXihBQZBoH/HsXG4Y7pg0bx8NSzwxwGQorHiK3MrvyeyK
         x+r6AxPcZ6ZbZh/ZgTBJdTradXznD0Rbrdy0rYsb3c0FdJpw5sRF9Hr38zx1E6FEYb
         gryy52wn3nADaEkPq61+RoqBtc35H6bmGeGHejPcFnECNZOiMxLlcQx7F5C571z3zq
         7N/RPnI1YMbTo4GzTs2pr83GpzeflkEcYideSpWU4lzhWwSHu/uMOvSpayLDEoLnfu
         RXjxMeYZJMXzA==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v1 1/1] selftests: alsa: pcm-test: Fix compiler warnings about the format
Date:   Wed, 24 May 2023 21:15:29 +0200
Message-Id: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GCC 11.3.0 issues warnings in this module about wrong sizes of format
specifiers:

pcm-test.c: In function ‘test_pcm_time’:
pcm-test.c:384:68: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 5 \
				has type ‘unsigned int’ [-Wformat=]
  384 |                 snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
pcm-test.c:455:53: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has \
				type ‘long int’ [-Wformat=]
  455 |                                          "expected %d, wrote %li", rate, frames);
pcm-test.c:462:53: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has \
				type ‘long int’ [-Wformat=]
  462 |                                          "expected %d, wrote %li", rate, frames);
pcm-test.c:467:53: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has \
				type ‘long int’ [-Wformat=]
  467 |                                          "expected %d, wrote %li", rate, frames);

Simple fix according to compiler's suggestion removed the warnings.

Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/alsa/pcm-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 3e390fe67eb9..b7eef32addb4 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -381,7 +381,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate mismatch %ld != %d", rate, rrate);
 		goto __close;
 	}
 	rperiod_size = period_size;
@@ -447,24 +447,24 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 			frames = snd_pcm_writei(handle, samples, rate);
 			if (frames < 0) {
 				snprintf(msg, sizeof(msg),
-					 "Write failed: expected %d, wrote %li", rate, frames);
+					 "Write failed: expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 			if (frames < rate) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 		} else {
 			frames = snd_pcm_readi(handle, samples, rate);
 			if (frames < 0) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 			if (frames < rate) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 		}
-- 
2.34.1

