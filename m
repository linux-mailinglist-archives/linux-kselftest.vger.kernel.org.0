Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201152044F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 02:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgFWAHo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 20:07:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730926AbgFWAHo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 20:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592870863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iRD1hPXhVUe8rwNuLvm5vZaW2Z1mXyC16yrqIfQ/+hY=;
        b=gDt8MOEKMQ+vPB51Ih0ObCGujIicHytOBC6S6bZi9Den4UE157U07htVEMm2vRImxNKS3A
        s1gHSEetOn94V3p6JoRkJvOYlg42LaPOAfiAKTNtbVuPvaJwxpQW6/Lj/k0uxMYhZnLttV
        0dtCn7Q1lnQCNtV1CX8ezgOrM8BfsFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-oiSLZ7BDMEGn-QWezPZEEg-1; Mon, 22 Jun 2020 20:07:39 -0400
X-MC-Unique: oiSLZ7BDMEGn-QWezPZEEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFBABFC1;
        Tue, 23 Jun 2020 00:07:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4683C19C71;
        Tue, 23 Jun 2020 00:07:38 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH] kselftest: ksft_test_num return type should be unsigned
Date:   Mon, 22 Jun 2020 20:07:37 -0400
Message-Id: <20200623000737.21710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes a compiler warning:

In file included from sync_test.c:37:
../kselftest.h: In function ‘ksft_print_cnts’:
../kselftest.h:78:16: warning: comparison of integer expressions of different signedness: ‘unsigned int’ and ‘int’ [-Wsign-compare]
  if (ksft_plan != ksft_test_num())
                ^~

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 0ac49d91a260..862eee734553 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -36,7 +36,7 @@ struct ksft_count {
 static struct ksft_count ksft_cnt;
 static unsigned int ksft_plan;
 
-static inline int ksft_test_num(void)
+static inline unsigned int ksft_test_num(void)
 {
 	return ksft_cnt.ksft_pass + ksft_cnt.ksft_fail +
 		ksft_cnt.ksft_xfail + ksft_cnt.ksft_xpass +
-- 
2.26.2

