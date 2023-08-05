Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDED7712F7
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 01:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjHEXOU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 19:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEXOU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 19:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7851BD4;
        Sat,  5 Aug 2023 16:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA2560F5D;
        Sat,  5 Aug 2023 23:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D2DC433C7;
        Sat,  5 Aug 2023 23:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691277257;
        bh=SZoeTvqPDR+vF5ZhiCtzVJefMWAWzNemtsBf6oZ55KE=;
        h=From:Date:Subject:To:Cc:From;
        b=emYiu/DWEy4ADUS7nok1VtJ7U9KQO/u+30fWplQDUTEqupWAfksoKEPIoWF6wDflE
         cbF5MRrK6naDO5cLSaQboghSIIZjdkM2WMr42K/bRkzw4/3lQHdsJK5h50ClkEj/D2
         67M9HJlfQTXOY/MPT28nL2W9LWMCjcCfac/IPrDD3R2nLycgfvZDqi53YcmrX/7d+J
         t/2bKkU+fjIv4up7DJQ6JTUMjZy/qJTO4RG4GuZWSxIRDaod0EPXFBFxyhvPs1uVVf
         9k/rvOLTCJnabjfo0pxiAdLeID8A7qI1DCPrW7EYQ5X43z/0tUS3BJPiUMavWNW0Li
         QajkVStE0684Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 06 Aug 2023 00:14:07 +0100
Subject: [PATCH] selftests: Hook more tests into the build infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-kselftest-perf-events-build-v1-1-0120e7a9cd72@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL7XzmQC/x3MQQqDMBAF0KvIrDswSRGkVykuNP7ooETJpFIQ7
 97Q5du8iwxZYfRqLso41XRPFe7RUFiGNIN1qiYv/imdtLwatlhghQ/kyDiRivH40W3iIJDoXOf
 HAVSHIyPq97+/+/v+AVI0C0ttAAAA
To:     Shuah Khan <shuah@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SZoeTvqPDR+vF5ZhiCtzVJefMWAWzNemtsBf6oZ55KE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkztfGiwnJOHJxtvWUO88geBNS9exbfDWBm8AO3
 tnIh5OaFQ6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZM7XxgAKCRAk1otyXVSH
 0G4LB/9KLFWJA9HBLL7c0D8f81z5Hevsci0B27cyEjxnlyeE81cZMb32fcUrZ4tD7c9W8HN/QqN
 UOHENUxjrDYU67lvrx8smA3Sa8twHU7A8K6P+ZO+K/IRb9s00FF7+7ex6GLigNjFr1JWAfZnb0I
 WYgW2M9tfzVTvwKA/uuXwVDfwYcqU7uO3LqpVDQ6HmgJ+sPO15s5xCqKbb9A6zmnjCVoixvKZ/o
 Na81CLTIae+3zVk7yy8LDcVuLD76OkmNvVCRj6Uu7kq/9cOd9vWdJe6yjFsmOi1dJtkis8xTXbr
 XoSGuBvwwhnxxVnbD0Ks20gdZRfMYlxoOMRMWqYYc+w/hZw5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have some dmabuf-heaps and perf_events tests but they are not hooked
up to the kselftest build infrastructure which is a bit of an obstacle
to running them in systems with generic infrastructure for selftests.
Add them to the top level kselftest Makefile so they get built as
standard.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 666b56f22a41..bdee501596ef 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -12,6 +12,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net/bonding
@@ -56,6 +57,7 @@ TARGETS += net/mptcp
 TARGETS += net/openvswitch
 TARGETS += netfilter
 TARGETS += nsfs
+TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
 TARGETS += powerpc
@@ -88,6 +90,7 @@ endif
 TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += tty
+TARGETS += uevents
 TARGETS += user
 TARGETS += vDSO
 TARGETS += mm

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230805-kselftest-perf-events-build-c0e0f1182bae

Best regards,
-- 
Mark Brown <broonie@kernel.org>

