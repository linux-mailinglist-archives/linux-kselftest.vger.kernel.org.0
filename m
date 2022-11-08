Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B427621D3D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 20:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKHTwr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 14:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKHTwq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 14:52:46 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28AFE65E6C;
        Tue,  8 Nov 2022 11:52:46 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-25-210.rev.numericable.fr [85.170.25.210])
        by linux.microsoft.com (Postfix) with ESMTPSA id C085920B9F80;
        Tue,  8 Nov 2022 11:52:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C085920B9F80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667937165;
        bh=t36xpm43qmLMEEXsLNHAnvSSN1fHn9/wxZfzoHQm4H4=;
        h=From:To:Cc:Subject:Date:From;
        b=jLCsIjthGu7d4DRVQ1TB1mUyc8RViDwSi21b47OLSSvYIUrMF88SfAwGaztkyEF3C
         xlvS4iAXH5LWDmr/3H9Zbx7JkO/Pk1Yeyq1fUOTIm7LLa854J4p4OteAabn/akYUnt
         ut53qaPtrmCoJUQjxqsEupHjc9whVtslOLdkiBus=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alban Crequy <albancrequy@microsoft.com>, linux-mm@kvack.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 0/2] Fix offset when fault occurs in strncpy_from_kernel_nofault()
Date:   Tue,  8 Nov 2022 20:52:05 +0100
Message-Id: <20221108195211.214025-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi.


First of all, I hope you are fine and the same for your relatives.

This contribution fixes a bug where the byte before the destination address can
be reset when a page fault occurs in strncpy_from_kernel_nofault() while copying
the first byte from the source address.

This bug leaded to kernel panic if a pointer containing the modified address is
dereferenced as the pointer does not contain a correct addresss.

To fix this bug, we simply reset the current destination byte in a case of a
page fault.
The proposed fix was tested and validated inside a VM:
root@vm-amd64:~# ./share/linux/tools/testing/selftests/bpf/test_progs --name varlen
...
#222     varlen:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
Without the patch, the test will fail:
root@vm-amd64:~# ./share/linux/tools/testing/selftests/bpf/test_progs --name varlen
...
#222     varlen:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

If you see any way to improve this contribution, feel free to share.

Alban Crequy (2):
  maccess: fix writing offset in case of fault in
    strncpy_from_kernel_nofault()
  selftests: bpf: add a test when bpf_probe_read_kernel_str() returns
    EFAULT

 mm/maccess.c                                    | 2 +-
 tools/testing/selftests/bpf/prog_tests/varlen.c | 7 +++++++
 tools/testing/selftests/bpf/progs/test_varlen.c | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)


Best regards and thank you in advance.
--
2.25.1

