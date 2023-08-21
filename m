Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8D078214B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 04:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjHUCDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Aug 2023 22:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUCDs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Aug 2023 22:03:48 -0400
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E589C;
        Sun, 20 Aug 2023 19:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692583424;
        bh=tev9vFwzr3CByXx+8306FXg78Anw1TmvVUAj6prq2Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WkT54Y2p9MnNLhSIx6DcYvg9g0G1Sn0DZXRFYTRBcqG7GcniodBoQz4zHH+nhtGl3
         kcDrkCPQ5q+NguvdszpPp5TuBkJaSqT6bsc7Urzveb8P8dVPDsgXzw/YdJ5elmamQf
         nyykN6cWtOv8Z/ozaDOZbyOnBdR/usxgXNfUFcOs=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id E692A2B; Mon, 21 Aug 2023 10:03:38 +0800
X-QQ-mid: xmsmtpt1692583418tyfo4egzn
Message-ID: <tencent_ADC403037821ABAC8ECB6F15C6D7A3510507@qq.com>
X-QQ-XMAILINFO: OaoBA5NOFC/jOVj7yUQgbw3QstZL4g20mKVHyjXoPuKpolkCmC5AfK22VR8nC8
         alfmaQIRUsQC3wyEFWgCxncjTVdteAXHrgkkHARUsfxEYTXOrkmkXxKas5ocAh7QOSe/TD1IRqLb
         etN2iFQ5cWcKXMwoFS5zhUBXZSXHqDMGPGZ6r+xV6SP8Bz0HlneWhZp8p1RsRmjf1XA7LCt8wpre
         9DQjcWldehO7Edn4s87tIr89ZduY+6MKlC+MQOPwPWifLYaig0u3O+cu4ovNw5f91nmHy3qxMnXO
         RwrsHTB4p7uQK7eN2sdrJ3WKIsQYEVr7VxbVDjriiqSABXzX02qMNERo/46jGatEKwSwZvSq1i9f
         xKkws1ljzTZGXw0LwJw945og7SLn0i6OR9+VRXnxB4klMsKexMMEljDSP807+217HKGIUgSKcLjS
         3CFGC/jBoO7naSnjglCiOoKQshU1JtIKHnlE83tlHdFJVJfXMdG3t7QKz8xWq4xcZBg4ee7BCE5X
         D//ogdjjuQWagITmQYnZrNJjVhRWILcJBTm+f/vCtzkuP+iQ2OZ6nxuMUaMV4S+Q7Za+pqUcwKhV
         Hp5glHpwA1koUumSD4YD9okcwJdYxJwPOsaLzFkl1jgotTlzZAjf8GfZb1uah7UN0afu6NY4Q8We
         cL9Depgl7FtPlutwN1+g88xblLiaRHdQEYyDdNu9PFkopPCZqcuuBL5gHmvE8z5wdrlXcD0O8Be/
         bHLS0oEr2+MGmO5cIFREE8RstWicLJlgxiQ+brwV3M9S8hwPRN56fgjMEIHONHkrqvMAkEeVIW6l
         HSL91KCwgFH9lV7D4sv0gUCPx8NR+6i8C6wfj32k7kLw5KvTnsyOOk32n2crzUmvHrjBjnIB0iLG
         oPJZKiDeFlhJYRQh3bU5BCiAkl/v9M0NTsts4CW9a6qMz4XuWddLvEocpmnDpxp0JeMvJz/mH63N
         SfpKG+ffNtF6Qx1palfZeirWx/K9KuDoTFdceo2Jqzw8sDn4ErOQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Date:   Mon, 21 Aug 2023 10:03:38 +0800
X-OQ-MSGID: <20230821020338.94266-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <817af9ec-0ba3-fab0-6d8a-4529ede337b5@linux.dev>
References: <817af9ec-0ba3-fab0-6d8a-4529ede337b5@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry Song, I did not state clear.

libbpf_ensure_mem() is declared in libbpf_internal.h, we want to use 
libbpf_ensure_mem() in trace_helpers.c, Unforturnately, we could only include
the headers 'install_headers:' defined in tools/lib/bpf/Makefile, the
'install_headers:' target does not include libbpf_internal.h, like:

	tools/testing/selftests/bpf/trace_helpers.c:17:10:
	fatal error: libbpf_internal.h: No such file or directory
	   17 | #include "libbpf_internal.h"
	      |          ^~~~~~~~~~~~~~~~~~~

	tools/testing/selftests/bpf/trace_helpers.c:17:10:
	fatal error: bpf/libbpf_internal.h: No such file or directory
	   17 | #include "bpf/libbpf_internal.h"
	      |          ^~~~~~~~~~~~~~~~~~~~~~~

How about

1. dup-declare libbpf_ensure_mem() in trace_helpers.c
2. move libbpf_ensure_mem() declare into libbpf_common.h

Which one do you like best.

Best wishes,
Rong Tao

