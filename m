Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C278378240D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 08:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjHUGzK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHUGzJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 02:55:09 -0400
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F7A9;
        Sun, 20 Aug 2023 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692600604;
        bh=XqvE7N7p6l8xNYVxoU16FGFX8J28j5RVeM4hXQ3GxEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H0eIJn1cFi6QlqcUD1OOCXz3ZMUaMxK8JofWROoot7h16+Thrhs3Lb3nAlP0b26FP
         gIj2ZjxycynV8V/HYgxdSgzB13JlCvDdbJh8epir02aIy0a+b1Aphxrr7Og64nyV+P
         E98JGzPYTLbYTb6RQpTLtddHANemcxnvKRe2dTjE=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id C7AAC8AB; Mon, 21 Aug 2023 14:49:58 +0800
X-QQ-mid: xmsmtpt1692600598ticjome8j
Message-ID: <tencent_AA234615114B0D808474B2D42F9955A25F09@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjKld59uAmJVD2abDsyoO8Wvlna41a4o22n8scFUnfFo6Emc2NMa
         PAlHulPcmRQI4huXeYAHSg06bDoPpCxjGdyQcqURbO0V3Bb2EZweF/MgeaeAOZi5RBvN9rJX5JgF
         dtlaqSmbOX0FwG04//qTMooiTcBThxLyTFqQpStc/IxlCzLMQCwSesaF+3KUXJZfFd8KoKKG/s+J
         QEGiVQiaSVtYjQDOIsDklWx2sdqzJyUbxS1PC9XLR4SXPkF6ta4fGbdHrKLQoPSwJ7n4FWlAh1F7
         lnph7fXxziKEGIU2a9nyzEPOMf7OoXb9q3DbU/wNhQQXScAYC7A9rDl/IlE20S3FnRqWNRnzjR75
         SCGjnr9UtNly6QsEh/e+5j+S0Vs7LJcBLWFdstqPuDo/GVLLa+JeyfOY1O+DVpAPNKWQ0148vpA6
         BT66hqxAM40L5UvK2ArWyUqgbx126GMjiIi/0947iysTiVfO+AC8bGihLlPFnaySkpmq7bOZLPkl
         zqIxjE+kjBL3BgLt/Xi0TtCzDqhFHuCqRWLQXH7GJde5Nch2i3M6ExWcz3uxuqth+byjQay1QBbu
         5WejKzOOWLtTAP9u8QJmIiTHhunqHziOvZlGhJBET4/I2QSWwgb3Rxoal3gCa4aEO5eqKxWJj9jW
         VDmVwFc72p03A0m01nB0DdcDmxZNZyOafhfnux1jq9k3qSmgjoyLwLqtaGfB4dDNr1QaRxazQh4z
         9WmFzrM79KBK/n0BQvqcHs5GGVl3tOu7wGiBczO926uTRVCYR8U409b9XQKMBOqrD78edgGf6uKp
         BjG6d/A4xaUkGNH+9Uj6HVgf4x0OyUKvTGqC13g2wStruIAYh7wqrrrXnYpJNm4VtgUkocRCM+y3
         7mzD7X8xBcQThZkDJOA2bfUytOKSQvqmuM1YjczO8iMwEcNSyfiBeebhcn7MyhTV653sEyOdTeVn
         p85/d4P9YmBLnFaQcqhBPwkOgQYFBI1jNnIRBgvCiEDCWwvSd1ket9JKlG8z650iNgnPW2CyNY7q
         9qtx8JrIxL8zSdbw6PcQRgD8qWdP0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Rong Tao <rtoax@foxmail.com>
To:     yonghong.song@linux.dev
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, olsajiri@gmail.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org
Subject: Re: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Mon, 21 Aug 2023 14:49:58 +0800
X-OQ-MSGID: <20230821064958.156895-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <c2f564a3-f942-d275-3ecb-b679aa0810ec@linux.dev>
References: <c2f564a3-f942-d275-3ecb-b679aa0810ec@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tools/testing/selftests/bpf/ compile OK, however, samples/bpf/ compile failed.

>> 	tools/testing/selftests/bpf/trace_helpers.c:17:10:
>> 	fatal error: libbpf_internal.h: No such file or directory
>> 	   17 | #include "libbpf_internal.h"
>> 	      |          ^~~~~~~~~~~~~~~~~~~
>>
>> 	tools/testing/selftests/bpf/trace_helpers.c:17:10:
>> 	fatal error: bpf/libbpf_internal.h: No such file or directory
>> 	   17 | #include "bpf/libbpf_internal.h"
>> 	      |           ^~~~~~~~~~~~~~~~~~~~~~~

I just submit v6 [0], which apply libbpf_ensure_mem() and

	TPROGS_CFLAGS += -I$(srctree)/tools/lib

to samples/bpf/Makefile, make sure, samples/bpf/Makefile could found
libbpf_internal.h.

Please review, thanks.

Rong Tao

[0] https://lore.kernel.org/lkml/tencent_4A09A36F883A06EA428A593497642AF8AF08@qq.com/

