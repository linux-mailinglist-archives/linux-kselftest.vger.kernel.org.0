Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F9C537DD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 May 2022 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiE3Nmn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 May 2022 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbiE3NlU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 May 2022 09:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB599698;
        Mon, 30 May 2022 06:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04A8E60EEE;
        Mon, 30 May 2022 13:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C45C341C0;
        Mon, 30 May 2022 13:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653917512;
        bh=eoTntXkJva1hHSA1bjTzO8FjSkV4RFJ+pjuoRT5FL7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AA6QtqDYCnVvd35jydVbjB3NQizpTEfRj7iVthh+jJVkHr56Kad4pgac71jw3aKWB
         QUPMVmmqOhchgRSqjrZzfAwhK2Aq2YPMhKFiKVozfceiRwWOwix+63UzBVl1jWd+4L
         R8BQFsqMQQ+rB4VvHorkVsObcy8H/okn47WcsDc/2FktGENFupz7R8FJBvEgnOL36V
         OB2ZWp66uViL9fRGuGqInIrgB/KQFrBRukso18pMrYIEkNYKTa46Nbk71YqEfoB+nU
         Mc+bqTkWpLzXY/QSxHbFtl+lRkxk85CPF6zZuhihQSSkJwidf2T3bc85V/mbZJQND2
         qt9HNM6ejuszw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 006/135] selftests/bpf: Fix parsing of prog types in UAPI hdr for bpftool sync
Date:   Mon, 30 May 2022 09:29:24 -0400
Message-Id: <20220530133133.1931716-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133133.1931716-1-sashal@kernel.org>
References: <20220530133133.1931716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Quentin Monnet <quentin@isovalent.com>

[ Upstream commit 4eeebce6ac4ad80ee8243bb847c98e0e55848d47 ]

The script for checking that various lists of types in bpftool remain in
sync with the UAPI BPF header uses a regex to parse enum bpf_prog_type.
If this enum contains a set of values different from the list of program
types in bpftool, it complains.

This script should have reported the addition, some time ago, of the new
BPF_PROG_TYPE_SYSCALL, which was not reported to bpftool's program types
list. It failed to do so, because it failed to parse that new type from
the enum. This is because the new value, in the BPF header, has an
explicative comment on the same line, and the regex does not support
that.

Let's update the script to support parsing enum values when they have
comments on the same line.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20220404140944.64744-1-quentin@isovalent.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_bpftool_synctypes.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index 6bf21e47882a..c0e7acd698ed 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -180,7 +180,7 @@ class FileExtractor(object):
         @enum_name: name of the enum to parse
         """
         start_marker = re.compile(f'enum {enum_name} {{\n')
-        pattern = re.compile('^\s*(BPF_\w+),?$')
+        pattern = re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
         end_marker = re.compile('^};')
         parser = BlockParser(self.reader)
         parser.search_block(start_marker)
-- 
2.35.1

